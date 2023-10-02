using System;
using System.Diagnostics;
using LiveSplit.ComponentUtil;

namespace LiveSplit.SonicOrigins
{
    internal class Sonic2Manager
    {
        private readonly Process game;

        private readonly IntPtr LevelID;
        // private readonly IntPtr Timer;
        private readonly IntPtr TimeBonus;
        private readonly IntPtr StartTrigger;
        private readonly IntPtr DemoMode;
        private readonly IntPtr GameMode;
        private readonly IntPtr ScoreTally;
        private readonly IntPtr ContinueBonus;

        // Buffer values
        private readonly FakeMemoryWatcher<LevelID> LevelWatcher;
        private readonly FakeMemoryWatcher<int> TimeBonusValue;
        private int timeBonusStartValue;
        private readonly FakeMemoryWatcher<byte> StartTriggerValue;

        internal Sonic2Manager(SignatureScanner scanner)
        {
            var ptr = scanner.ScanOrThrow(new SigScanTarget(15, "3D F9 00 00 00 0F 87 ?? ?? ?? ?? 41 8B 8C 84 ?? ?? ?? ?? 49 03 CC FF ?? 41 8B 84") { OnFound = (p, s, addr) => p.MainModuleWow64Safe().BaseAddress + p.ReadValue<int>(addr) });
            var lea = scanner.ScanOrThrow(new SigScanTarget(1, "EB ?? 8B CF E8 ???????? 8B 3D") { OnFound = (p, s, addr) =>
            {
                var tempAddr = addr + 4 + p.ReadValue<byte>(addr);
                return tempAddr + 0x4 + p.ReadValue<int>(tempAddr);
            } });

            game = scanner.Process;
            var mainModule = game.MainModuleWow64Safe();

            IntPtr pointerPath(int offset1, int offset2, int offset3, bool absolute)
            {
                if (offset1 == 0)
                    return lea + offset3;

                int tempOffset = game.ReadValue<int>(ptr + offset1);
                IntPtr tempOffset2 = mainModule.BaseAddress + tempOffset + offset2;

                if (absolute)
                    return mainModule.BaseAddress + game.ReadValue<int>(tempOffset2) + offset3;
                else
                    return tempOffset2 + 0x4 + game.ReadValue<int>(tempOffset2) + offset3;
            }

            LevelID = pointerPath(0x4 * 122, 39, 0, false);
            // Timer = pointerPath(0x4 * 126, 11, -1, false);
            TimeBonus = pointerPath(0x4 * 0, 0, 0x20D0 + 0x30, false);
            StartTrigger = pointerPath(0x4 * 0, 0, 0x2418 + 0xD4, false);
            DemoMode = pointerPath(0x4 * 17, 15, 0x5 * 4, true);
            GameMode = pointerPath(0x4 * 17, 15, 0x8F * 4, true);
            ScoreTally = pointerPath(0x4 * 0, 0, 0x20D0 + 0xD4, false);
            ContinueBonus = pointerPath(0x4 * 0, 0, 0x20D0 + 0x44, false);

            // Setting up fake watchers
            LevelWatcher = new FakeMemoryWatcher<LevelID>(() =>
            {
                var curLevel = game.ReadValue<byte>(LevelID) switch
                {
                    0 => SonicOrigins.LevelID.Sonic2_TitleScreen,
                    1 or 2 => SonicOrigins.LevelID.Sonic2_Ending,
                    6 => SonicOrigins.LevelID.Sonic2_EmeraldHillAct1,
                    7 => SonicOrigins.LevelID.Sonic2_EmeraldHillAct2,
                    8 => SonicOrigins.LevelID.Sonic2_ChemicalPlantAct1,
                    9 => SonicOrigins.LevelID.Sonic2_ChemicalPlantAct2,
                    10 => SonicOrigins.LevelID.Sonic2_AquaticRuinAct1,
                    11 => SonicOrigins.LevelID.Sonic2_AquaticRuinAct2,
                    12 => SonicOrigins.LevelID.Sonic2_CasinoNightAct1,
                    13 => SonicOrigins.LevelID.Sonic2_CasinoNightAct2,
                    14 => SonicOrigins.LevelID.Sonic2_HillTopAct1,
                    15 => SonicOrigins.LevelID.Sonic2_HillTopAct2,
                    16 => SonicOrigins.LevelID.Sonic2_MysticCaveAct1,
                    17 => SonicOrigins.LevelID.Sonic2_MysticCaveAct2,
                    18 => SonicOrigins.LevelID.Sonic2_OilOceanAct1,
                    19 => SonicOrigins.LevelID.Sonic2_OilOceanAct2,
                    20 => SonicOrigins.LevelID.Sonic2_MetropolisAct1,
                    21 => SonicOrigins.LevelID.Sonic2_MetropolisAct2,
                    22 => SonicOrigins.LevelID.Sonic2_MetropolisAct3,
                    23 => SonicOrigins.LevelID.Sonic2_SkyChase,
                    24 => SonicOrigins.LevelID.Sonic2_WingFortress,
                    25 => SonicOrigins.LevelID.Sonic2_DeathEgg,
                    _ => SonicOrigins.LevelID.Unknown,
                };

                if (curLevel != SonicOrigins.LevelID.Unknown)
                {
                    return curLevel;
                }
                else
                {
                    return LevelWatcher.Current;
                }
            });
            LevelWatcher.Update(SonicOrigins.LevelID.Sonic2_TitleScreen);
            TimeBonusValue = new FakeMemoryWatcher<int>(() => game.ReadValue<int>(TimeBonus));
            StartTriggerValue = new FakeMemoryWatcher<byte>(() => game.ReadValue<byte>(StartTrigger));
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
            TimeBonusValue.Update();

            if (TimeBonusValue.Old == 0 && TimeBonusValue.Changed)
            {
                timeBonusStartValue = TimeBonusValue.Current;
            }
            else if (TimeBonusValue.Current == 0)
            {
                timeBonusStartValue = 0;
            }

            return (timeBonusStartValue != 0 && TimeBonusValue.Current != timeBonusStartValue)
                // Include the continue bonus
                || (game.ReadValue<byte>(ScoreTally) == 4 && game.ReadValue<byte>(ContinueBonus) != 0);
        }

        internal bool GetStartTrigger()
        {
            StartTriggerValue.Update();
            return StartTriggerValue.Old == 8 && StartTriggerValue.Current == 9;
        }

        internal bool IsDemoMode()
        {
            return game.ReadValue<byte>(DemoMode) != 0;
        }

        internal GameMode GetGameMode()
        {
            return game.ReadValue<GameMode>(GameMode);
        }
    }
}
