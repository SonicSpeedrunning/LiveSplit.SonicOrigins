using System;
using System.Collections.Generic;
using LiveSplit.ComponentUtil;
using LiveSplit.Model;

namespace LiveSplit.SonicOrigins
{
    partial class Watchers
    {
        // Pointers and offsets
        private readonly Dictionary<string, Dictionary<string, IntPtr>> addresses = new Dictionary<string, Dictionary<string, IntPtr>>();

        // RTTI vtables
        private RTTI RTTI;
        private Sonic1Manager Sonic1;
        private SonicCDManager SonicCD;
        private Sonic2Manager Sonic2;
        private Sonic3Manager Sonic3;

        // Watchers
        internal FakeMemoryWatcher<GameStatus> GameStatus { get; private set; }
        internal FakeMemoryWatcher<Game> Game { get; private set; }
        internal FakeMemoryWatcher<GameMode> GameMode { get; private set; }
        internal FakeMemoryWatcher<bool> StartTrigger { get; private set; }
        internal FakeMemoryWatcher<LevelID> ActID { get; private set; }
        internal FakeMemoryWatcher<bool> IsInTimeBonus { get; private set; }
        internal FakeMemoryWatcher<bool> DemoMode { get; private set; }

        // Other buffer variables
        internal bool StoryStartFlag { get; set; } = false;

        internal Watchers(LiveSplitState LSstate)
        {
            // Define LiveSplit's current state. We need this because we want to reset AccumulatedIGT and AlreadyTriggeredBools when a run is reset
            state = LSstate;

            // Define our address dictionaries
            addresses["HedgehogEngine"] = new Dictionary<string, IntPtr>();

            GameStatus = new FakeMemoryWatcher<GameStatus>(() =>
            {
                var success = new DeepPointer(addresses["HedgehogEngine"]["baseAddress"], 0x88, 0x0, 0x70, 0x0).Deref<long>(game, out var val);

                if (!success)
                    return GameStatus.Current;

                var value = (IntPtr)val;

                if (value == RTTI["GameModeMainMenu::game::app"])
                    return SonicOrigins.GameStatus.MainMenu;
                else if (value == RTTI["GameModeRetroEngine::game::app"])
                    return SonicOrigins.GameStatus.RetroEngine;
                else if (value == RTTI["GameModeGameGear::game::app"])
                    return SonicOrigins.GameStatus.GameGear;
                else
                    return GameStatus.Current;
            });

            Game = new FakeMemoryWatcher<Game>(() =>
            {
                if (GameStatus.Current == SonicOrigins.GameStatus.RetroEngine)
                {
                    return game.ReadValue<byte>(addresses["HedgehogEngine"]["CurrentRSDKGame"]) switch
                    {
                        0 => SonicOrigins.Game.Sonic1,
                        1 => SonicOrigins.Game.Sonic2,
                        2 => SonicOrigins.Game.Sonic3,
                        3 => SonicOrigins.Game.SonicCD,
                        _ => Game.Current,
                    };
                }
                else if (GameStatus.Current == SonicOrigins.GameStatus.MainMenu || GameStatus.Current == SonicOrigins.GameStatus.GameGear)
                {
                    return SonicOrigins.Game.None;
                }
                else
                {
                    return Game.Current;
                }
            });

            GameMode = new FakeMemoryWatcher<GameMode>(() =>
            {
                return Game.Current switch
                {
                    SonicOrigins.Game.Sonic1 => Sonic1.GetGameMode(),
                    SonicOrigins.Game.Sonic2 => Sonic2.GetGameMode(),
                    SonicOrigins.Game.SonicCD => SonicCD.GetGameMode(),
                    SonicOrigins.Game.Sonic3 => Sonic3.GetGameMode(),
                    _ => SonicOrigins.GameMode.Classic, // GameMode.Current,
                };
            });

            StartTrigger = new FakeMemoryWatcher<bool>(() =>
            {
                return Game.Current switch
                {
                    SonicOrigins.Game.Sonic1 => Sonic1.GetStartTrigger(),
                    SonicOrigins.Game.Sonic2 => Sonic2.GetStartTrigger(),
                    SonicOrigins.Game.SonicCD => SonicCD.GetStartTrigger(),
                    SonicOrigins.Game.Sonic3 => Sonic3.GetStartTrigger(),
                    _ => false,
                };
            });

            ActID = new FakeMemoryWatcher<LevelID>(() =>
            {
                return Game.Current switch
                {
                    SonicOrigins.Game.None => SonicOrigins.LevelID.MainMenu,
                    SonicOrigins.Game.Sonic1 => Sonic1.GetCurrentLevel(),
                    SonicOrigins.Game.Sonic2 => Sonic2.GetCurrentLevel(),
                    SonicOrigins.Game.SonicCD => SonicCD.GetCurrentLevel(),
                    SonicOrigins.Game.Sonic3 => Sonic3.GetCurrentLevel(),
                    _ => ActID.Current,
                };
            });

            IsInTimeBonus = new FakeMemoryWatcher<bool>(() =>
            {
                return Game.Current switch
                {
                    SonicOrigins.Game.Sonic1 => Sonic1.IsInTimeBonus(),
                    SonicOrigins.Game.Sonic2 => Sonic2.IsInTimeBonus(),
                    SonicOrigins.Game.SonicCD => SonicCD.IsInTimeBonus(),
                    SonicOrigins.Game.Sonic3 => false,
                    _ => false,
                };
            });

            DemoMode = new FakeMemoryWatcher<bool>(() =>
            {
                return Game.Current switch
                {
                    SonicOrigins.Game.Sonic1 => Sonic1.IsDemoMode(),
                    SonicOrigins.Game.Sonic2 => Sonic2.IsDemoMode(),
                    SonicOrigins.Game.SonicCD => SonicCD.IsDemoMode(),
                    SonicOrigins.Game.Sonic3 => false,
                    _ => false,
                };
            });

            GameProcess = new ProcessHook("SonicOrigins");
        }

        internal void Update()
        {
            // These 2 need to be updated first, as the rest of the update commands rely on those values
            GameStatus.Update();
            Game.Update();

            GameMode.Update();
            ActID.Update();
            StartTrigger.Update();
            // Lives.Update();
            IsInTimeBonus.Update();
            DemoMode.Update();

            if (ActID.Current == LevelID.MainMenu)
                StoryStartFlag = true;
        }

        /// <summary>
        /// This function is essentially equivalent of the init descriptor in script-based autosplitters.
        /// Everything you want to be executed when the game gets hooked needs to be put here.
        /// The main purpose of this function is to perform sigscanning and get memory addresses and offsets
        /// needed by the autosplitter.
        /// </summary>
        private void GetAddresses()
        {
            SignatureScanner scanner = new SignatureScanner(game, game.MainModuleWow64Safe().BaseAddress, game.MainModuleWow64Safe().ModuleMemorySize);

            // Base Address for the Hedgehog Engine 2
            addresses["HedgehogEngine"]["baseAddress"] = scanner.ScanOrThrow(new SigScanTarget(1, "E8 ???????? 44 39 75 48") { OnFound = (p, s, addr) => { IntPtr tempAddr = addr + p.ReadValue<int>(addr) + 0x4 + 0x3; return tempAddr + p.ReadValue<int>(tempAddr) + 0x4; } });

            // Defining a new instance of the RTTI class in order to get the vTable addresses of a couple of classes.
            // This makes it incredibly easy to calculate some dynamic offsets later,
            var RTTILIST = new string[]
            {
                "GameModeMainMenu::game::app",
                "GameModeRetroEngine::game::app",
                "GameModeGameGear::game::app"
            };
            RTTI = new RTTI(scanner, RTTILIST);

            addresses["HedgehogEngine"]["CurrentRSDKGame"] = scanner.ScanOrThrow(new SigScanTarget(2, "89 0D ?? ?? ?? ?? 89 15 ?? ?? ?? ?? C7 05") { OnFound = (p, s, addr) => addr + 0x4 + p.ReadValue<int>(addr) });

            Sonic1 = new Sonic1Manager(scanner);
            Sonic2 = new Sonic2Manager(scanner);
            SonicCD = new SonicCDManager(scanner);
            Sonic3 = new Sonic3Manager(scanner);

            // Settings default values for enums
            GameStatus.Update(SonicOrigins.GameStatus.MainMenu);
            Game.Update(SonicOrigins.Game.Sonic1);
            ActID.Update(SonicOrigins.LevelID.MainMenu);
            GameMode.Update(SonicOrigins.GameMode.Story);
        }
    }
}