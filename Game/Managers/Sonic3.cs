using System;
using System.Diagnostics;
using LiveSplit.ComponentUtil;

namespace LiveSplit.SonicOrigins
{
    internal class Sonic3Manager
    {
        private readonly Process game;

        private readonly IntPtr Status;
        private readonly IntPtr LevelID;
        private readonly IntPtr LevelIDApparent;
        private readonly DeepPointer GameMode;
        private readonly DeepPointer HPZFlag;

        // Buffer values
        private readonly FakeMemoryWatcher<LevelID> LevelWatcher;

        internal Sonic3Manager(SignatureScanner scanner)
        {
            Status = scanner.ScanOrThrow(new SigScanTarget(4, "0A C1 88 05") { OnFound = (p, s, addr) => addr + 0x4 + p.ReadValue<int>(addr) });
            LevelID = scanner.ScanOrThrow(new SigScanTarget(3, "66 89 05 ?? ?? ?? ?? 3B DF") { OnFound = (p, s, addr) => addr + 0x4 + p.ReadValue<int>(addr) });
            LevelIDApparent = scanner.ScanOrThrow(new SigScanTarget(2, "89 15 ???????? 48 8B 87") { OnFound = (p, s, addr) => addr + 0x4 + p.ReadValue<int>(addr) });
            HPZFlag = new DeepPointer(scanner.ScanOrThrow(new SigScanTarget(3, "4C 39 35 ???????? 74 05") { OnFound = (p, s, addr) => addr + 0x4 + p.ReadValue<int>(addr) }), 0x4);

            var ptr = scanner.ScanOrThrow(new SigScanTarget(32, "41 83 F8 05 0F 85 ?? ?? ?? ?? 83 F9 16 0F 87 ?? ?? ?? ?? 48 63 C1 48 8D 0D") { OnFound = (p, s, addr) => p.MainModuleWow64Safe().BaseAddress + p.ReadValue<int>(addr) });
            game = scanner.Process;
            var mainModule = game.MainModuleWow64Safe();
            IntPtr pointerCase(int offset1, int offset2)
            {
                int tempOffset = game.ReadValue<int>(ptr + offset1);
                IntPtr tempOffset2 = mainModule.BaseAddress + tempOffset + offset2;
                return tempOffset2;
            }
            var _base = pointerCase(0x4 * 0, 3);
            GameMode = new DeepPointer(_base + 0x4 + game.ReadValue<int>(_base), game.ReadValue<int>(_base + 0x6));


            // Setting up fake watchers
            LevelWatcher = new FakeMemoryWatcher<LevelID>(() =>
            {
                var Act = game.ReadValue<byte>(LevelID);

                if (Act == 0)
                    return SonicOrigins.LevelID.Sonic3_TitleScreen;
                else if (Act == 2)
                    return SonicOrigins.LevelID.Sonic3_SaveSelect;
                else if (Act == 5)
                    return SonicOrigins.LevelID.Sonic3_Ending;
                else if (Act == 15)
                    return SonicOrigins.LevelID.Sonic3_AngelIslandAct1;

                var ApparentAct = game.ReadValue<byte>(LevelIDApparent);

                return ApparentAct switch
                {
                    0 => SonicOrigins.LevelID.Sonic3_AngelIslandAct1,
                    1 => SonicOrigins.LevelID.Sonic3_AngelIslandAct2,
                    2 => Act == 17 ? SonicOrigins.LevelID.Sonic3_HydrocityAct1 : LevelWatcher.Current,
                    3 => SonicOrigins.LevelID.Sonic3_HydrocityAct2,
                    4 => SonicOrigins.LevelID.Sonic3_MarbleGardenAct1,
                    5 => SonicOrigins.LevelID.Sonic3_MarbleGardenAct2,
                    6 => SonicOrigins.LevelID.Sonic3_CarnivalNightAct1,
                    7 => SonicOrigins.LevelID.Sonic3_CarnivalNightAct2,
                    8 => SonicOrigins.LevelID.Sonic3_IceCapAct1,
                    9 => SonicOrigins.LevelID.Sonic3_IceCapAct2,
                    10 => SonicOrigins.LevelID.Sonic3_LaunchBaseAct1,
                    11 => SonicOrigins.LevelID.Sonic3_LaunchBaseAct2,
                    12 => SonicOrigins.LevelID.Sonic3_MushroomHillAct1,
                    13 => SonicOrigins.LevelID.Sonic3_MushroomHillAct2,
                    14 => SonicOrigins.LevelID.Sonic3_FlyingBatteryAct1,
                    15 => SonicOrigins.LevelID.Sonic3_FlyingBatteryAct2,
                    16 => SonicOrigins.LevelID.Sonic3_SandopolisAct1,
                    17 => SonicOrigins.LevelID.Sonic3_SandopolisAct2,
                    18 => SonicOrigins.LevelID.Sonic3_LavaReefAct1,
                    19 or 20 => SonicOrigins.LevelID.Sonic3_LavaReefAct2,
                    21 => game.ReadValue<byte>(Status) != 2 ? LevelWatcher.Current : HPZFlag.Deref(game, out byte val) ? (val == 0 ? SonicOrigins.LevelID.Sonic3_HiddenPalace : LevelWatcher.Current) : LevelWatcher.Current,
                    22 or 23 => SonicOrigins.LevelID.Sonic3_SkySanctuary,
                    24 => SonicOrigins.LevelID.Sonic3_DeathEggAct1,
                    25 or 26 => SonicOrigins.LevelID.Sonic3_DeathEggAct2,
                    27 => SonicOrigins.LevelID.Sonic3_Doomsday,
                    _ => LevelWatcher.Current,
                };
            });
            LevelWatcher.Update(SonicOrigins.LevelID.Sonic3_TitleScreen);
        }

        internal LevelID GetCurrentLevel()
        {
            LevelWatcher.Update();
            return LevelWatcher.Current;
        }

        /*
        internal TimeSpan GetIGT()
        {
            var time = game.ReadBytes(Timer, 3);
            return TimeSpan.FromMilliseconds(time[0] * 10 + time[1] * 1000 + time[2] * 60000);
        }
        */

        internal bool IsInTimeBonus()
        {
            return false;
        }

        internal bool GetStartTrigger()
        {
            return LevelWatcher.Old == SonicOrigins.LevelID.Sonic3_SaveSelect && LevelWatcher.Current == SonicOrigins.LevelID.Sonic3_AngelIslandAct1;
        }

        internal bool IsDemoMode()
        {
            return false;
        }

        internal GameMode GetGameMode()
        {
            return GameMode.Deref<GameMode>(game);
        }
    }
}
