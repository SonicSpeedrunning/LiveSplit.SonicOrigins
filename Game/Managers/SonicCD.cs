using System;
using System.Diagnostics;
using LiveSplit.ComponentUtil;

namespace LiveSplit.SonicOrigins
{
    internal class SonicCDManager
    {
        private readonly Process game;

        private readonly IntPtr LevelID;
        // private readonly IntPtr Timer;
        private readonly IntPtr TimeBonus;
        private readonly IntPtr StartTrigger;
        private readonly IntPtr DemoMode;
        private readonly IntPtr GameMode;
        private readonly IntPtr TimeTravel;

        // Buffer values
        private readonly FakeMemoryWatcher<LevelID> LevelWatcher;
        private readonly FakeMemoryWatcher<int> TimeBonusValue;
        private int timeBonusStartValue;
        private readonly FakeMemoryWatcher<byte> StartTriggerValue;

        internal SonicCDManager(SignatureScanner scanner)
        {
            var ptr = scanner.ScanOrThrow(new SigScanTarget(15, "3D E4 00 00 00 0F 87 ?? ?? ?? ?? 41 8B 8C 84 ?? ?? ?? ?? 49 03 CC FF ?? 41 8B 84") { OnFound = (p, s, addr) => p.MainModuleWow64Safe().BaseAddress + p.ReadValue<int>(addr) });
            var lea = scanner.ScanOrThrow(new SigScanTarget(1, "EB ?? 45 33 FF 45 85 D2") { OnFound = (p, s, addr) => { var tempAddr = addr + 4 + p.ReadValue<byte>(addr); return tempAddr + 0x4 + p.ReadValue<int>(tempAddr); } });

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

            LevelID = pointerPath(0x4 * 120, 46, 0, false);
            // Timer = pointerPath(0x4 * 123, 11, -1, false);
            TimeBonus = pointerPath(0x4 * 0, 0, 0x814, false);
            StartTrigger = pointerPath(0x4 * 0, 0, 0x942, false);
            DemoMode = pointerPath(0x4 * 11, 15, 0x6B * 4, true);
            GameMode = pointerPath(0x4 * 11, 15, 0x77 * 4, true);
            TimeTravel = pointerPath(0x4 * 11, 15, 0x1E * 4, true);

            // Setting up fake watchers
            LevelWatcher = new FakeMemoryWatcher<LevelID>(() =>
                game.ReadValue<byte>(LevelID) switch
                {
                    0 => SonicOrigins.LevelID.SonicCD_TitleScreen,
                    8 => SonicOrigins.LevelID.SonicCD_Ending,
                    13 or 14 or 15 or 16 => SonicOrigins.LevelID.SonicCD_PalmtreePanicAct1,
                    17 or 18 or 19 or 20 => SonicOrigins.LevelID.SonicCD_PalmtreePanicAct2,
                    21 or 22 => SonicOrigins.LevelID.SonicCD_PalmtreePanicAct3,
                    23 or 24 or 25 or 26 => SonicOrigins.LevelID.SonicCD_CollisionChaosAct1,
                    27 or 28 or 29 or 30 => SonicOrigins.LevelID.SonicCD_CollisionChaosAct2,
                    31 or 32 => SonicOrigins.LevelID.SonicCD_CollisionChaosAct3,
                    33 or 34 or 35 or 36 => SonicOrigins.LevelID.SonicCD_TidalTempestAct1,
                    37 or 38 or 39 or 40 => SonicOrigins.LevelID.SonicCD_TidalTempestAct2,
                    41 or 42 => SonicOrigins.LevelID.SonicCD_TidalTempestAct3,
                    43 or 44 or 45 or 46 => SonicOrigins.LevelID.SonicCD_QuartzQuadrantAct1,
                    47 or 48 or 49 or 50 => SonicOrigins.LevelID.SonicCD_QuartzQuadrantAct2,
                    51 or 52 => SonicOrigins.LevelID.SonicCD_QuartzQuadrantAct3,
                    53 or 54 or 55 or 56 => SonicOrigins.LevelID.SonicCD_WackyWorkbenchAct1,
                    57 or 59 or 59 or 60 => SonicOrigins.LevelID.SonicCD_WackyWorkbenchAct2,
                    61 or 62 => SonicOrigins.LevelID.SonicCD_WackyWorkbenchAct3,
                    63 or 64 or 65 or 66 => SonicOrigins.LevelID.SonicCD_StardustSpeedwayAct1,
                    67 or 68 or 69 or 70 => SonicOrigins.LevelID.SonicCD_StardustSpeedwayAct2,
                    71 or 72 => SonicOrigins.LevelID.SonicCD_StardustSpeedwayAct3,
                    73 or 74 or 75 or 76 => SonicOrigins.LevelID.SonicCD_MetallicMadnessAct1,
                    77 or 78 or 79 or 80 => SonicOrigins.LevelID.SonicCD_MetallicMadnessAct2,
                    81 or 82 => SonicOrigins.LevelID.SonicCD_MetallicMadnessAct3,
                    _ => LevelWatcher.Current,
                }
            );
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
                timeBonusStartValue = TimeBonusValue.Current;
            else if (TimeBonusValue.Current == 0)
                timeBonusStartValue = 0;

            return (timeBonusStartValue != 0 && TimeBonusValue.Current != timeBonusStartValue) || game.ReadValue<int>(TimeTravel) != 0;
        }

        internal bool GetStartTrigger()
        {
            StartTriggerValue.Update();
            return StartTriggerValue.Old == 11 && StartTriggerValue.Current == 2;
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
