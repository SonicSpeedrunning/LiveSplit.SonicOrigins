// Sonic Origins
// Autosplitter and IGT timer
// Coding: Jujstme
// contacts: just.tribe@gmail.com
// Version: 1.2.1 (Jul 5th, 2022)

state("SonicOrigins") {}

init
{
    vars.DebugPrint("Autosplitter Init:");

    // Define main watcher variable
    vars.DebugPrint("   => Setting up MemoryWatchers...");
    vars.watchers = new MemoryWatcherList();
    var ptr = IntPtr.Zero;
    var scanner = new SignatureScanner(game, modules.First().BaseAddress, modules.First().ModuleMemorySize);
    Action checkptr = () => { if (ptr == IntPtr.Zero) throw new Exception(); };

    // Functions needed for sigscanning
    Func<int, int, int, bool, IntPtr> pointerPath = (offset1, offset2, offset3, absolute) =>
    {
        var tempOffset = game.ReadValue<int>(ptr + offset1);
        var tempOffset2 = modules.First().BaseAddress + tempOffset + offset2;
        if (absolute)
            return modules.First().BaseAddress + game.ReadValue<int>(tempOffset2) + offset3;
        else
            return tempOffset2 + 0x4 + game.ReadValue<int>(tempOffset2) + offset3;
    };

    // Sonic CD RSDK flags (RSDKv3) - Will be used for most of the addresses shared between Sonic 1, 2 and CD
    // jumptable 000000014008CB7F
    ptr = scanner.Scan(new SigScanTarget(-4, "49 03 CD FF E1 8B 05") { OnFound = (p, s, addr) => modules.First().BaseAddress + p.ReadValue<int>(addr) }); checkptr();
    vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 *  19, 10, 0x942,  false)) { Name = "SonicCDStartTrigger" });
    vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 * 120, 26, 0,      false)) { Name = "Act" });
    vars.watchers.Add(new MemoryWatcher<bool>(pointerPath(0x4 * 121,  3, 0,      false)) { Name = "TimerIsRunning" });
    vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 * 122,  3, 0,      false)) { Name = "Centisecs" });
    vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 * 123,  3, 0,      false)) { Name = "Secs" });
    vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 * 124,  3, 0,      false)) { Name = "Mins" });
    vars.watchers.Add(new MemoryWatcher<int>( pointerPath(0x4 *  37, 10, 0x814,  false)) { Name = "SCDTimeBonus" });
    vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 *  11, 7,  0x2C,  true)) { Name = "SCDLives" });
    vars.watchers.Add(new MemoryWatcher<bool>(pointerPath(0x4 *  11, 7, 0x1AC,  true)) { Name = "SCDDemoMode" });
    vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 *  11, 7, 0x22C,  true)) { Name = "SCDMissionCondition" });
    vars.watchers.Add(new MemoryWatcher<bool>(pointerPath(0x4 *  11, 7, 0x248,  true)) { Name = "SCDMissionClear" });
    vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 *  11, 7, 0xD8,  true)) { Name = "SCDSpecialStageReturn" });
    vars.watchers.Add(new MemoryWatcher<bool>(pointerPath(0x4 *  19, 10, 0x832,  false)) { Name = "SCDSScomplete" });

    // Dunno why these addresses, used in Sonic 3, are found in this jmp table, but it's convenient nonetheless
    vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 * 120,  3, 2,      false)) { Name = "S3TimerIsRunning" });
    vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 * 120,  3, 4,      false)) { Name = "S3Centisecs" });
    vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 * 120,  3, 5,      false)) { Name = "S3Secs" });
    vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 * 120,  3, 6,      false)) { Name = "S3Mins" });

    // Sonic 1 and 2 RSDK flags (RSDKv4)
    // jumptable 00000001400A2461
    ptr = scanner.Scan(new SigScanTarget(-4, "49 03 CC FF E1 8B 05") { OnFound = (p, s, addr) => modules.First().BaseAddress + p.ReadValue<int>(addr) }); checkptr();
    vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 * 17,  7, 0x1A4,      true)) { Name = "S1PlayMode" }); // Becomes 5 in story mode
    vars.watchers.Add(new MemoryWatcher<bool>(pointerPath(0x4 * 17,  7,  0x14,      true)) { Name = "S1DemoMode" }); // Also works in Sonic 2
    vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 * 17,  7,  0x5C,      true)) { Name = "S1Lives" });
    var S1MissionCondition = pointerPath(0x4 * 17,  7, 0x1F8,      true);
    vars.watchers.Add(new MemoryWatcher<byte>(S1MissionCondition) { Name = "S1MissionCondition" }); // 1 if mission clear, 2 if mission failed, 0 if mission not completed
    vars.watchers.Add(new MemoryWatcher<bool>(pointerPath(0x4 * 17,  7, 0x20C,      true)) { Name = "S1MissionClear" });
    vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 * 17,  7,  0x64,      true)) { Name = "S2Lives" });
    vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 * 17,  7,  0xB0,      true)) { Name = "S1SpecialStageReturn" }); // Also works for Sonic 2
    vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 * 17,  7, 0x290,      true)) { Name = "S2MissionCondition" }); // 1 if mission clear, 2 if mission failed, 0 if mission not completed
    vars.watchers.Add(new MemoryWatcher<bool>(pointerPath(0x4 * 17,  7, 0x2A4,      true)) { Name = "S2MissionClear" });
    vars.watchers.Add(new MemoryWatcher<int> (pointerPath(0x4 * 71, 45, 0x20F8,    false)) { Name = "S1TimeBonus" });
    vars.watchers.Add(new MemoryWatcher<int> (pointerPath(0x4 * 71, 45, 0x2100,    false)) { Name = "S2TimeBonus" });
    vars.watchers.Add(new MemoryWatcher<bool>(pointerPath(0x4 * 71, 45, 0x16B4,    false)) { Name = "S2SScomplete" });


    // Single sigscan to a function its only job is, apparently, timer management inside the game
    // This variable is relative to Sonic 1, 2 and CD but its only purpose inside the autosplitter is to deal with the timer bug in Sonic CD
    ptr = scanner.Scan(new SigScanTarget(3, "8B 8C 96 ???????? 48 03 CE") { OnFound = (p, s, addr) => modules.First().BaseAddress + p.ReadValue<int>(addr) }); checkptr();
    var Ticks = pointerPath(0x4 * 1, 51, 0,      false); // Valid only for Sonic 1, 2 and CD. Not valid for S3K

// General variables
    ptr = scanner.Scan(new SigScanTarget(5, "8B 47 10 89 05") { OnFound = (p, s, addr) => addr + 0x4 + p.ReadValue<int>(addr) }); checkptr();
    vars.watchers.Add(new MemoryWatcher<byte>(ptr) { Name = "Game" });

    ptr = scanner.Scan(new SigScanTarget(2, "8B 35 ???????? 89 1D") { OnFound = (p, s, addr) => addr + 0x4 + p.ReadValue<int>(addr) + 0x23D0 }); checkptr();
    vars.watchers.Add(new MemoryWatcher<byte>(ptr) { Name = "Sonic12StartTrigger" });

// Messy Sonic 3 variables
    ptr = scanner.Scan(new SigScanTarget(5, "83 FB 01 89 05") { OnFound = (p, s, addr) => addr + 0x4 + p.ReadValue<int>(addr) }); checkptr();
    vars.watchers.Add(new MemoryWatcher<byte>(ptr) { Name = "S3Act" });

    ptr = scanner.Scan(new SigScanTarget(5, "83 F9 01 8B 05") { OnFound = (p, s, addr) => addr + 0x4 + p.ReadValue<int>(addr) }); checkptr();
    vars.watchers.Add(new MemoryWatcher<byte>(ptr) { Name = "S3AIZflag" });

    ptr = scanner.Scan(new SigScanTarget(7, "0F B7 04 5F") { OnFound = (p, s, addr) => modules.First().BaseAddress + p.ReadValue<int>(addr) }); checkptr();
    vars.watchers.Add(new MemoryWatcher<byte>(ptr + 0xD4) { Name = "S3Lives" });
    vars.watchers.Add(new MemoryWatcher<byte>(ptr + 0xCC) { Name = "Sonic3SaveSlot" });
    vars.watchers.Add(new MemoryWatcher<int>(ptr + 0x86F8) { Name = "S3TimeBonus" });

    ptr = scanner.Scan(new SigScanTarget(3, "4C 39 35 ???????? 74 05") { OnFound = (p, s, addr) => addr + 0x4 + p.ReadValue<int>(addr) }); checkptr();
    vars.watchers.Add(new MemoryWatcher<long>(ptr) { Name = "S3HPZFlag_0" });
    vars.watchers.Add(new MemoryWatcher<byte>(new DeepPointer(ptr, 0x4)) { Name = "S3HPZFlag_1", FailAction = MemoryWatcher.ReadFailAction.SetZeroOrNull });

    ptr = scanner.Scan(new SigScanTarget(11, "74 ?? 41 B9 ???????? 4C 8D 1D") { OnFound = (p, s, addr) => addr + 0x4 + p.ReadValue<int>(addr) }); checkptr();
    vars.watchers.Add(new MemoryWatcher<bool>(ptr + 0x4C) { Name = "S3SScomplete" });

    ptr = scanner.Scan(new SigScanTarget(1, "E8 ???????? 83 FE 05") { OnFound = (p, s, addr) => { var tempAddr = addr + 0x7 + p.ReadValue<int>(addr); return tempAddr + 0x4 + p.ReadValue<int>(tempAddr); } });
    vars.watchers.Add(new MemoryWatcher<int>(new DeepPointer(ptr, 0x18, 0xD8, 0xA8)) { Name = "BossRushTime" });


    // Defining another pointerpath for Sonic 3's shenanigans
    Func<int, DeepPointer> pointerPath2 = (offset1) =>
    {
        var tempOffset = game.ReadValue<int>(ptr + offset1);
        var tempOffset2 = modules.First().BaseAddress + tempOffset + 3;
        //var tempOffset3 = tempOffset2 + 6;
        return new DeepPointer(tempOffset2 + game.ReadValue<int>(tempOffset2) + 0x4, game.ReadValue<int>(tempOffset2 + 6));
    };
    // jumptable 00000001400D706C
    ptr = scanner.Scan(new SigScanTarget(3, "8B 84 81 ???????? 48 03 C1 FF E0") { OnFound = (p, s, addr) => modules.First().BaseAddress + p.ReadValue<int>(addr) }); checkptr();
    var S3MissionCondition = pointerPath2(0x4 * 4);
    var S3MissionClear = pointerPath2(0x4 * 9);
    vars.watchers.Add(new MemoryWatcher<byte>(S3MissionCondition) { Name = "S3MissionCondition" }); // 1 if mission clear, 2 if mission failed, 0 if mission not completed
    vars.watchers.Add(new MemoryWatcher<bool>(S3MissionClear) { Name = "S3MissionClear" });

    ptr = scanner.Scan(new SigScanTarget(4, "4A 8B 84 32 ???????? 48 8B 08") { OnFound = (p, s, addr) => modules.First().BaseAddress + p.ReadValue<int>(addr) }); checkptr();
    vars.watchers.Add(new MemoryWatcher<byte>(new DeepPointer(ptr + 0x5390, 0x0, 0x28, 0xD8)) { Name = "S3SpecialStageReturn" });


    // Finished setting up the MemoryWatchers
    vars.DebugPrint("     => Done");

    // Custom functions
    Func<DeepPointer, IntPtr> Deref = (a) => { 
        IntPtr _out = IntPtr.Zero;
        a.DerefOffsets(memory, out _out);
        return _out;
    };

    // Default variables
    vars.DebugPrint("   => Setting up default state variables...");

    // Variables used throughout the script
    current.Game = 0;
    current.IGT = TimeSpan.Zero;
    current.StartTrigger = 0;
    current.ActID = 0;
    current.Act = 0;
    current.TimerIsRunning = true;
    current.Lives = 0;
    current.MissionCondition = 0;
    current.MissionClear = false;
    current.BonusHPZ = false;
    current.BossRushTime = TimeSpan.Zero;
    current.GameMode = 0;
    current.TimeBonus = 0;
    current.DemoMode = false;
    //vars.HasTimerBug = false;
    current.SpecialIGT = TimeSpan.Zero;

    vars.DebugPrint("     => Done");

    // Functions used for fixing bugs in the game, because fans do what SEGAren't
    vars.DebugPrint("   => Setting up custom functions...");
    vars.Func.ResetS1MissionCondition = (Action)(() => game.WriteValue<byte>(S1MissionCondition, 0));
    vars.Func.ResetS3MissionCondition = (Action)(() => game.WriteValue<byte>(Deref(S3MissionCondition), 0));
    vars.Func.ResetS3MissionClear = (Action)(() => game.WriteValue<byte>(Deref(S3MissionClear), 0));
    vars.Func.FixSonicCDTimer = (Action)(() => game.WriteValue<byte>(Ticks, (byte)Math.Round((vars.watchers["Centisecs"].Current / 100f) * 60)));
    vars.DebugPrint("     => Done");

    vars.DebugPrint("   => Init script completed");
}

startup
{
    // Settings
    // --> ID, Setting name, parent, enabled
    dynamic[,] Settings =
    {
        { "start", "Auto start settings", null, true },
            { "storystart",  "Story mode",                     "start", true },
            { "s1start",     "Sonic 1",                        "start", true },
            { "scdstart",    "Sonic CD",                       "start", true },
            { "s2start",     "Sonic 2",                        "start", true },
            { "s3start",     "Sonic 3",                        "start", true },
            { "s1bossrush",  "Boss Rush (Sonic 1)",            "start", true },
            { "scdbossrush", "Boss Rush (Sonic CD)",           "start", true },
            { "s2bossrush",  "Boss Rush (Sonic 2)",            "start", true },
            { "s3bossrush",  "Boss Rush (Sonic 3 & Knuckles)", "start", true },
        
        { "timing", "Timing method options", null, true },
            // { "autosensing", "Auto-detect", "timing", true  },
            { "rta-tb",      "Use RTA-TB instead of IGT",                     "timing", true  },
            { "brrewind",    "Don't roll back time after dying in boss rush", "timing", false },
            // { "igt",         "Use IGT",     "timing", false },
        
        { "autosplitting", "Autosplitting - Act list", null, true },
            { "s1",  "Sonic 1",            "autosplitting", true },
            { "scd", "Sonic CD",           "autosplitting", true },
            { "s2",  "Sonic 2",            "autosplitting", true },
            { "s3",  "Sonic 3 & Knuckles", "autosplitting", true },
        
        { "bossrush", "Boss Rush", null, true },
            { "brs1",  "Sonic 1",            "bossrush", true },
            { "brscd", "Sonic CD",           "bossrush", true },
            { "brs2",  "Sonic 2",            "bossrush", true },
            { "brs3",  "Sonic 3 & Knuckles", "bossrush", true },
    };
    // Autobuild the settings based on the info provided above
    for (int s = 0; s < Settings.GetLength(0); s++) settings.Add(Settings[s, 0], Settings[s, 3], Settings[s, 1], Settings[s, 2]);
    settings.SetToolTip("rta-tb", "If this setting is enabled, the game timer will be RTA-TB (RTA minus Time Bonus).\nIf this setting is disabled, the game timer will be IGT (in-game timer).\n\nPlease refer to the category rules on speedun.com for the correct setting to use in your run.");
    settings.SetToolTip("brrewind", "This setting is applied only when IGT is used as the timing method.\nIf enabled, the in-game timer will not roll back after dying in boss rush,.\nIf this setting is disabled, the timer LiveSplit's timer will reflect the behaviour of the game internal Boss Rush timer.\n\nDefault: disabled.");

    // Array containing the name of every act
    // This is used both in the settings and for debug purposes
    var actsName = new string[][] {
        new string[] { "Green Hill Zone - Act 1", "Green Hill Zone - Act 2", "Green Hill Zone - Act 3", "Marble Zone - Act 1", "Marble Zone - Act 2", "Marble Zone - Act 3", "Spring Yard Zone - Act 1", "Spring Yard Zone - Act 2", "Spring Yard Zone - Act 3", "Labyrinth Zone - Act 1", "Labyrinth Zone - Act 2", "Labyrinth Zone - Act 3", "Star Light Zone - Act 1", "Star Light Zone - Act 2", "Star Light Zone - Act 3", "Scrap Brain Zone - Act 1", "Scrap Brain Zone - Act 2", "Scrap Brain Zone - Act 3", "Final Zone" },
        new string[] { "Palmtree Panic Act 1", "Palmtree Panic Act 2", "Palmtree Panic Act 3", "Collision Chaos Act 1", "Collision Chaos Act 2", "Collision Chaos Act 3", "Tidal Tempest Act 1", "Tidal Tempest Act 2", "Tidal Tempest Act 3", "Quartz Quadrant Act 1", "Quartz Quadrant Act 2", "Quartz Quadrant Act 3", "Wacky Workbench Act 1", "Wacky Workbench Act 2", "Wacky Workbench Act 3", "Stardust Speedway Act 1", "Stardust Speedway Act 2", "Stardust Speedway Act 3", "Metallic Madness Act 1", "Metallic Madness Act 2", "Metallic Madness Act 3" },
        new string[] { "Emerald Hill Zone - Act 1", "Emerald Hill Zone - Act 2", "Chemical Plant Zone - Act 1", "Chemical Plant Zone - Act 2", "Aquatic Ruin Zone - Act 1", "Aquatic Ruin Zone - Act 2", "Casino Night Zone - Act 1", "Casino Night Zone - Act 2", "Hill Top Zone - Act 1", "Hill Top Zone - Act 2", "Mystic Cave Zone - Act 1", "Mystic Cave Zone - Act 2", "Oil Ocean Zone - Act 1", "Oil Ocean Zone - Act 2", "Metropolis Zone - Act 1", "Metropolis Zone - Act 2", "Metropolis Zone - Act 3", "Sky Chase Zone", "Wing Fortress Zone", "Death Egg Zone"},
        new string[] { "Angel Island Zone - Act 1", "Angel Island Zone - Act 2", "Hydrocity Zone - Act 1", "Hydrocity Zone - Act 2", "Marble Garden Zone - Act 1", "Marble Garden Zone - Act 2", "Carnival Night Zone - Act 1", "Carnival Night Zone - Act 2", "Ice Cap Zone - Act 1", "Ice Cap Zone - Act 2", "Launch Base Zone - Act 1", "Launch Base Zone - Act 2", "Mushroom Hill Zone - Act 1", "Mushroom Hill Zone - Act 2", "Flying Battery Zone - Act 1", "Flying Battery Zone - Act 2", "Sandopolis Zone - Act 1", "Sandopolis Zone - Act 2", "Lava Reef Zone - Act 1", "Lava Reef Zone - Act 2", "Hidden Palace Zone", "Sky Sanctuary Zone", "Death Egg Zone - Act 1", "Death Egg Zone - Act 2", "Doomsday Zone" },
        new string[] { "Egg Wrecker", "Egg Scorcher", "Egg Stinger", "Egg Mobile", "Egg Spiker", "Egg Crusher" },
        new string[] { "EGG-HVC-001", "Egg Tilter", "Egg Bubble", "Egg Conveyer", "Egg Razer", "Metal Sonic", "Egg Spinner" },
        new string[] { "Egg Drillster", "Egg Poison", "Egg Hammer", "Egg Claw", "Egg Scorcher Mk.II", "Egg Driller", "Eggmarine", "Egg Bouncer", "Laser Prison", "Mecha Sonic - Death Egg Robo" },
        new string[] { "Egg Scorcher Mk.III", "Egg Vortex", "Egg Drillster Mk.II", "Egg Gravitron (Sonic/Tails only)", "Egg Froster", "Egg Cannon, Egg Rocket, Big Arms", "Egg Scrambler", "Egg Hanger", "Egg Golem", "Egg Inferno (Sonic/Tails only)", "Giant Eggman Robo (Sonic/Tails only)", "Mecha Sonic Mk.II (Knuckles only)" },
    };

    // Adding the acts to the autosplitting settings
    int i = 0;
    Func<int, string> entry = (int J) => {
        switch (J)
        {
            case 0: return "s1";
            case 1: return "scd";
            case 2: return "s2";
            case 3: return "s3";
            case 4: return "brs1";
            case 5: return "brscd";
            case 6: return "brs2";
            case 7: return "brs3";
            default: return "";
        }
    };
    vars.ActsName = new List<string>();
    for (int j = 0; j < actsName.Length; j++)
    {
        for (int z = 0; z < actsName[j].Length; z++)
        {
            settings.Add(i++.ToString(), true, actsName[j][z], entry(j));
            vars.ActsName.Add(actsName[j][z]);
        }
    }

    // Dictionaries
    vars.Game = new ExpandoObject();
    vars.Game.Sonic1 = 0;
    vars.Game.Sonic2 = 1;
    vars.Game.Sonic3 = 2;
    vars.Game.SonicCD = 3;

    // Dictionary used to associate the game's internal ID of each act
    // with the index we are going to use in the autosplitter.
    vars.Acts = new Dictionary<int, int>{
        {  6,  0 }, {  7,  1 }, {  8,  2 }, // Green Hill Act 1, 2, 3
        {  9,  3 }, { 10,  4 }, { 11,  5 }, // Marble Zone Act 1, 2, 3
        { 12,  6 }, { 13,  7 }, { 14,  8 }, // Spring Yard 1, 2, 3
        { 15,  9 }, { 16, 10 }, { 17, 11 }, // Labyrinth 1, 2, 3
        { 18, 12 }, { 19, 13 }, { 20, 14 }, // Starlight Zone 1, 2, 3
        { 21, 15 }, { 22, 16 }, { 23, 17 }, // Scrap Brain 1, 2, 3
        { 24, 18 },                         // Final Zone
        {  1, 19 }, { 2, 19 },              // S1 ending
        { 3013, 19 }, { 3014, 19 }, { 3015, 19 }, { 3016, 19 }, // Palmtree Panic Act 1
        { 3017, 20 }, { 3018, 20 }, { 3019, 20 }, { 3020, 20 }, // Palmtree Panic Act 2
        { 3021, 21 }, { 3022, 21 },                             // Palmtree Panic Act 3
        { 3023, 22 }, { 3024, 22 }, { 3025, 22 }, { 3026, 22 }, // Collision Chaos Act 1
        { 3027, 23 }, { 3028, 23 }, { 3029, 23 }, { 3030, 23 }, // Collision Chaos Act 2
        { 3031, 24 }, { 3032, 24 },                             // Collision Chaos Act 3
        { 3033, 25 }, { 3034, 25 }, { 3035, 25 }, { 3036, 25 }, // Tidal Tempest Act 1
        { 3037, 26 }, { 3038, 26 }, { 3039, 26 }, { 3040, 26 }, // Tidal Tempest Act 2
        { 3041, 27 }, { 3042, 27 },                             // Tidal Tempest Act 3
        { 3043, 28 }, { 3044, 28 }, { 3045, 28 }, { 3046, 28 }, // Quartz Quadrant Act 1
        { 3047, 29 }, { 3048, 29 }, { 3049, 29 }, { 3050, 29 }, // Quartz Quadrant Act 2
        { 3051, 30 }, { 3052, 30 },                             // Quartz Quadrant Act 3
        { 3053, 31 }, { 3054, 31 }, { 3055, 31 }, { 3056, 31 }, // Wacky Workbench Act 1
        { 3057, 32 }, { 3058, 32 }, { 3059, 32 }, { 3060, 32 }, // Wacky Workbench Act 2
        { 3061, 33 }, { 3062, 33 },                             // Wacky Workbench Act 3
        { 3063, 34 }, { 3064, 34 }, { 3065, 34 }, { 3066, 34 }, // Stardust Speedway Act 1
        { 3067, 35 }, { 3068, 35 }, { 3069, 35 }, { 3070, 35 }, // Stardust Speedway Act 2
        { 3071, 36 }, { 3072, 36 },                             // Stardust Speedway Act 3
        { 3073, 37 }, { 3074, 37 }, { 3075, 37 }, { 3076, 37 }, // Metallic Madness Act 1
        { 3077, 38 }, { 3078, 38 }, { 3079, 38 }, { 3080, 38 }, // Metallic Madness Act 2
        { 3081, 39 }, { 3082, 39 },                             // Metallic Madness Act 3
        { 3008, 40 },                                           // SCD Ending
        { 1006, 40 }, { 1007, 41 }, // Emerald Hill Act 1, 2
        { 1008, 42 }, { 1009, 43 }, // Chemical Plant Act 1, 2
        { 1010, 44 }, { 1011, 45 }, // Aquatic Ruin Act 1, 2
        { 1012, 46 }, { 1013, 47 }, // Casino Night Act 1, 2
        { 1014, 48 }, { 1015, 49 }, // Hill Top Act 1, 2
        { 1016, 50 }, { 1017, 51 }, // Mystic Cave Act 1, 2
        { 1018, 52 }, { 1019, 53 }, // Oil Ocean Act 1, 2
        { 1020, 54 }, { 1021, 55 }, { 1022, 56 }, // Metropolis Zone Act 1, 2, 3
        { 1023, 57 },               // Sky Chase
        { 1024, 58 },               // Wing Fortress
        { 1025, 59 },               // Death Egg
        { 1001, 60 }, { 1002, 60 }, // S2 Ending
        { 2015, 61 /* 60 */ }, { 2016, 61 }, // Angel Island Act 1, 2
        { 2017, 62 }, { 2018, 63 }, // Hydrocity Act 1, 2
        { 2019, 64 }, { 2020, 65 }, // Marble Garden Act 1, 2
        { 2021, 66 }, { 2022, 67 }, // Carnival Night Act 1, 2
        { 2023, 68 }, { 2024, 69 }, // Ice Cap Act 1, 2
        { 2025, 70 }, { 2026, 71 }, { 2004, 71 }, // Launch Base Act 1, 2
        { 2027, 72 }, { 2028, 73 }, // Mushroom Hill Act 1, 2
        { 2029, 74 }, { 2030, 75 }, // Flying Battery Act 1, 2
        { 2031, 76 }, { 2032, 77 }, // Sandopolis Act 1, 2
        { 2033, 78 },               // Lava Reef Act 1
        { 2034, 79 }, { 2035, 79 }, // Lava Reef Act 2 and Boss
        { 2036, 80 },               // Hidden Palace
        { 2037, 81 }, { 2038, 81 }, // Sky Sanctuary (+ Knuckles' version)
        { 2039, 82 },               // Death Egg Act 1
        { 2040, 83 }, { 2041, 83 }, // Death Egg Act 2 and Boss
        { 2042, 84 },               // Doomsday Zone
        { 2005, 85 },               // S3 Ending
        { 36, 85 },     // VS Egg Wrecker
        { 37, 86 },     // VS Egg Scorcher
        { 38, 87 },     // VS Egg Stinger
        { 39, 88 },     // VS Egg Mobile
        { 40, 89 },     // VS Egg Spiker
        { 41, 90 },     // VS Egg Crusher
        { 3111, 91 },   // VS EGG-HVC-001
        { 3112, 92 },   // VS Egg Tilter
        { 3113, 93 },   // VS Egg Bubble
        { 3114, 94 },   // VS Egg Conveyer
        { 3115, 95 },   // VS Egg Razer
        { 3116, 96 },   // VS Metal Sonic
        { 3117, 97 },   // VS Egg Spinner
        { 1063, 98 },   // VS Egg Drillster
        { 1064, 99 },   // VS Egg Poison
        { 1065, 100 },  // VS Egg Hammer
        { 1066, 101 },  // VS Egg Claw
        { 1067, 102 },  // VS Egg Scorcher Mk.II
        { 1068, 103 },  // VS Egg Driller
        { 1069, 104 },  // VS Eggmarine
        { 1070, 105 },  // VS Egg Bouncer
        { 1071, 106 },  // VS Laser Prison
        { 1072, 107 },  // VS Mecha Sonic - Death Egg Robo
        { 2070, 108 },  // VS Egg Scorcher Mk III
        { 2071, 109 },  // VS Egg Vortex
        { 2072, 110 },  // VS Egg Drillster Mk.II
        { 2073, 111 },  // VS Egg Gravitron
        { 2074, 112 },  // VS Egg Froster
        { 2075, 113 },  // VS Egg Cannon, Egg Rocket, Big Arms
        { 2076, 114 },  // VS Egg Scrambler
        { 2077, 115 },  // VS Egg Hanger
        { 2078, 116 },  // VS Egg Golem
        { 2079, 117 },  // VS Egg Inferno
        { 2080, 118 },  // VS Giant Eggman Robo
        { 2084, 119 },  // VS Mecha Sonic Mk.II (Knuckles)
    };

    vars.SpecialStagesIDs = new List<int>{
        26, 27, 28, 29, 30, 31, 32,     // Sonic 1
        3083, 3084, 3085, 3086, 3087, 3088, 3089,     // Sonic CD
        1028, 1029, 1030, 1031, 1032, 1033, 1034, 1035, // Sonic 2
        2085, 2086, 2087, 2088, 2089, 2090, 2091, 2092, 2093, 2094, 2095, 2096, 2097, 2098, 2099, 2100, // Sonic 3
        2052, 2053, 2054,   // Sonic 3 Bonus rounds
    };

    // Custom functions
    vars.Func = new ExpandoObject();
    vars.Func.ResetIGTBuffers = (Action)(() => { vars.AccumulatedIGT = TimeSpan.Zero; vars.BufferIGT = TimeSpan.Zero; });

    // Default variables
    vars.UpdateIGT = true;
    vars.BufferIGT = TimeSpan.Zero;
    vars.AccumulatedIGT = TimeSpan.Zero;
    vars.TimeBonusStartValue = 0;
    vars.RTATB = new Stopwatch();

    // Debug functions
    var debug = true; // Easy flag to quickly enable and disable debug outputs. When they're not needed anymore all it takes is to set this to false.
    vars.DebugPrint = (Action<string>)((obj) => { if (debug) print("[Sonic Origins] " + obj); });
    vars.Start = (Func<string, bool>)((obj) => { vars.DebugPrint("   => Run started: " + obj); return true; });
    vars.Split = (Func<string, bool>)((obj) => { vars.DebugPrint("   => Run split - previously on: " + obj); return true; });
}

update
{
    // Update the main watchers variable
    vars.watchers.UpdateAll(game);

    // Define current game, as almost every other variable that needs to be picked depends on this
    current.Game = vars.watchers["Game"].Current;

    // Default ActID. Its memory address stays the same across all the 4 games
    current.ActID = vars.watchers["S3Act"].Current + current.Game * 1000;

    // Calculate time at the end of each battle in Boss Rush. This helps with the timing
    current.BossRushTime = TimeSpan.FromMilliseconds(vars.watchers["BossRushTime"].Current * 10);

    // Pick the correct values from the respective game
    switch ((byte)current.Game)
    {
        case 0: // Sonic 1
            current.StartTrigger = vars.watchers["Sonic12StartTrigger"].Current;
            current.TimerIsRunning = vars.watchers["TimerIsRunning"].Current;
            current.IGT = TimeSpan.FromSeconds(vars.watchers["Mins"].Current * 60 + vars.watchers["Secs"].Current + vars.watchers["Centisecs"].Current / 100d);
            current.Lives = vars.watchers["S1Lives"].Current;
            current.TimeBonus = vars.watchers["S1TimeBonus"].Current;
            current.MissionCondition = vars.watchers["S1MissionCondition"].Current;
            current.MissionClear = vars.watchers["S1MissionClear"].Current;
            current.DemoMode = vars.watchers["S1DemoMode"].Current;
            current.SpecialStageReturn = vars.watchers["S1SpecialStageReturn"].Current + 5;
            current.BonusHPZ = false;
            break;
        case 1: // Sonic 2
            current.StartTrigger = vars.watchers["Sonic12StartTrigger"].Current;
            current.TimerIsRunning = vars.watchers["TimerIsRunning"].Current;
            current.IGT = TimeSpan.FromSeconds(vars.watchers["Mins"].Current * 60 + vars.watchers["Secs"].Current + vars.watchers["Centisecs"].Current / 100d);
            current.Lives = vars.watchers["S2Lives"].Current;
            current.TimeBonus = vars.watchers["S2TimeBonus"].Current;
            current.MissionCondition = vars.watchers["S2MissionCondition"].Current;
            current.MissionClear = vars.watchers["S2MissionClear"].Current;
            current.DemoMode = vars.watchers["S1DemoMode"].Current;
            current.SpecialStageReturn = vars.watchers["S1SpecialStageReturn"].Current + 7 + current.Game * 1000;
            current.BonusHPZ = false;
            break;
        case 2: // Sonic 3 & Knuckles
            current.StartTrigger = vars.watchers["Act"].Current;
            current.TimerIsRunning = vars.watchers["S3TimerIsRunning"].Current == 1;
            current.IGT = TimeSpan.FromSeconds(vars.watchers["S3Mins"].Current * 60 + vars.watchers["S3Secs"].Current + vars.watchers["S3Centisecs"].Current / 100d);
            current.Lives = vars.watchers["S3Lives"].Current;
            current.TimeBonus = vars.watchers["S3TimeBonus"].Current;
            current.MissionCondition = vars.watchers["S3MissionCondition"].Current;
            current.MissionClear = vars.watchers["S3MissionClear"].Current;
            current.DemoMode = false;
            current.SpecialStageReturn = vars.watchers["S3SpecialStageReturn"].Current + current.Game * 1000;
            current.BonusHPZ = vars.watchers["S3HPZFlag_0"].Current == 0 || vars.watchers["S3HPZFlag_1"].Current != 0;
            break;
        case 3: // Sonic CD
            current.StartTrigger = vars.watchers["SonicCDStartTrigger"].Current;
            current.TimerIsRunning = vars.watchers["TimerIsRunning"].Current;
            current.IGT = TimeSpan.FromSeconds(vars.watchers["Mins"].Current * 60 + vars.watchers["Secs"].Current + vars.watchers["Centisecs"].Current / 100d);
            // fix for sonic cd buggy timer
            if (current.IGT < old.IGT) vars.Func.FixSonicCDTimer();
            //if (current.IGT < old.IGT) game.WriteValue<byte>((IntPtr)vars.Ticks, (byte)Math.Round((vars.watchers["Centisecs"].Current / 100f) * 60));
            current.Lives = vars.watchers["SCDLives"].Current;
            current.TimeBonus = vars.watchers["SCDTimeBonus"].Current;
            current.MissionCondition = vars.watchers["SCDMissionCondition"].Current;
            current.MissionClear = vars.watchers["SCDMissionClear"].Current;
            current.DemoMode = vars.watchers["SCDDemoMode"].Current;
            current.SpecialStageReturn = vars.watchers["SCDSpecialStageReturn"].Current + 9 + current.Game * 1000;
            current.BonusHPZ = false;
            break;
    }

    //
    // IGT logic
    //
    // If updating the IGT has been disabled (eg. in boss rush mode) return to the previous value
    if (!vars.UpdateIGT)
        current.IGT = old.IGT;

    // In a variety of conditions related to the TimerIsRunning variable, don't update the IGT (and thus return to the previous value)
    // It's a very ugly hack made to cope with the timer losing its values in memory when entering a special stage
    switch ((byte)current.Game)
    {
        case 0: case 1: if (!old.TimerIsRunning || !current.TimerIsRunning) current.IGT = old.IGT; break;
        case 3: if (!old.TimerIsRunning && !current.TimerIsRunning) current.IGT = old.IGT; break;
        case 2: if (!current.TimerIsRunning) current.IGT = old.IGT; break;
    }

    // If in demo mode, IGT must be 0 regardless of the game
    if (current.DemoMode || old.DemoMode)
        current.IGT = TimeSpan.Zero;

    // If in the main menu for each of the 4 games, IGT must be 0
    if (current.ActID == 0 || current.ActID == 1000 || current.ActID == 2000 || current.ActID == 2002 || current.ActID == 3000)
        current.IGT = TimeSpan.Zero;

    // Check if we are in a special stage
    current.IsInSpecialStage = vars.SpecialStagesIDs.Contains(current.ActID) || (current.ActID == 2036 && current.BonusHPZ);
        
    // Define current Act
    if (current.IsInSpecialStage)
        current.Act = vars.Acts[current.SpecialStageReturn];
    else if (vars.Acts.ContainsKey(current.ActID))
        current.Act = vars.Acts[current.ActID];
/*
    // Check if we are in a special stage
    if (current.Game == vars.Game.Sonic3)
        current.IsInSpecialStage = vars.SpecialStagesIDs.Contains(current.ActID) || (current.ActID == 2036 && vars.watchers["S3HPZFlag_1"].Current == 2);
    else
        current.IsInSpecialStage = vars.SpecialStagesIDs.Contains(current.ActID);
        
    // Define current Act
    if (current.IsInSpecialStage || (current.ActID == 2036 && current.BonusHPZ))
    {
        current.Act = vars.Acts[current.SpecialStageReturn];
    } else if (vars.Acts.ContainsKey(current.ActID)) {
        current.Act = vars.Acts[current.ActID];
    }
*/

    // Special condition for because AIZ1 and AIZ2 share the same map
    if (current.Act == 61)
    {
        if (vars.watchers["S3AIZflag"].Current == 0)
            current.Act -= 1;
        else if (vars.watchers["S3AIZflag"].Current > 1)
            current.Act = old.Act;
    }

    // Define game mode
    // 0 = normal; 1 = boss rush
    if ( (current.Act > 85 && current.Act <= 119) || (current.Act == 85 && current.Game != vars.Game.Sonic3) )
        current.GameMode = 1;
    else
        current.GameMode = 0;

    // In special stages we don't want to run the normal timer
    if (current.IsInSpecialStage)
    {
        current.IGT = old.IGT;

        switch((byte)current.Game)
        {
            case 0:
                current.SpecialIGT = TimeSpan.FromSeconds(vars.watchers["Mins"].Current * 60 + vars.watchers["Secs"].Current + vars.watchers["Centisecs"].Current / 100d);
                break;
            case 1:
                current.SpecialIGT = TimeSpan.FromSeconds(vars.watchers["Mins"].Current * 60 + vars.watchers["Secs"].Current + vars.watchers["Centisecs"].Current / 100d);
                if (vars.watchers["S2SScomplete"].Current) current.SpecialIGT = old.SpecialIGT;
                break;
            case 2:
                current.SpecialIGT = TimeSpan.FromSeconds(vars.watchers["S3Mins"].Current * 60 + vars.watchers["S3Secs"].Current + vars.watchers["S3Centisecs"].Current / 100d);
                if (current.ActID != 2052 && current.ActID != 2053 && current.ActID != 2054 && vars.watchers["S3SScomplete"].Current) current.SpecialIGT = old.SpecialIGT;
                if (!current.TimerIsRunning) current.SpecialIGT = old.SpecialIGT;
                break;
            case 3:
                current.SpecialIGT = TimeSpan.FromSeconds(vars.watchers["Mins"].Current * 60 + vars.watchers["Secs"].Current + vars.watchers["Centisecs"].Current / 100d);
                if (vars.watchers["SCDSScomplete"].Current) current.SpecialIGT = old.SpecialIGT;
                break;
        }
    } else {
        current.SpecialIGT = TimeSpan.Zero;
    }

    // Reset the buffer IGT variables when the timer is stopped
    if (timer.CurrentPhase == TimerPhase.NotRunning)
    {
        vars.Func.ResetIGTBuffers();
        current.IGT = TimeSpan.Zero;
        current.SpecialIGT = TimeSpan.Zero;
    }
    if (current.IGT < old.IGT && current.GameMode != 1)
    {
        vars.AccumulatedIGT += old.IGT - vars.BufferIGT;
        vars.BufferIGT = current.IGT;
    }

    // Boss rush mode timer
    // If executed, the timer will not revert after dying in a boss rush act
    if (settings["brrewind"] && current.IGT < old.IGT && current.GameMode == 1 && current.MissionCondition == 0)
    {
        vars.AccumulatedIGT += old.IGT - vars.BufferIGT;
        vars.BufferIGT = current.IGT;
    }
    if (current.SpecialIGT < old.SpecialIGT)
        vars.AccumulatedIGT += old.SpecialIGT;

    // Time Bonus start value
    if (old.TimeBonus == 0 && old.TimeBonus != current.TimeBonus)
        vars.TimeBonusStartValue = current.TimeBonus;
    else if (current.TimeBonus == 0)
        vars.TimeBonusStartValue = 0;

    // Managing RTA-TB timer on a dedicated stopwatch
    switch (timer.CurrentPhase)
    {
        case TimerPhase.NotRunning:
            vars.RTATB.Reset();
            break;
        case TimerPhase.Running:
            if (vars.RTATB.IsRunning && vars.TimeBonusStartValue != 0 && current.TimeBonus != vars.TimeBonusStartValue) vars.RTATB.Stop();
            if (!vars.RTATB.IsRunning && !(vars.TimeBonusStartValue != 0 && current.TimeBonus != vars.TimeBonusStartValue)) vars.RTATB.Start();
            break;
        case TimerPhase.Paused:
        case TimerPhase.Ended:
            if (vars.RTATB.IsRunning) vars.RTATB.Stop();
            break;
    }

    // Whenever you beat a boss in boss rush mode, the IGT picked up by LiveSplit needs to be frozen
    //if (current.GameMode == 1 && old.BossRushTime != current.BossRushTime && current.IGT > TimeSpan.FromSeconds(1)) { vars.UpdateIGT = false; current.IGT = current.BossRushTime; }
    if (current.GameMode == 1 && current.MissionCondition > 0 && old.MissionCondition == 0)
    {
        vars.UpdateIGT = false;
        vars.AccumulatedIGT += current.BossRushTime;
        current.IGT = TimeSpan.Zero;
    }
    if (!vars.UpdateIGT && ((current.ActID != old.ActID) || current.GameMode != 1))
        vars.UpdateIGT = true;

    // Fix for Sonic 3 mission flag shenanigans
    if (current.Game == vars.Game.Sonic3 && current.GameMode != 0)
    {
        if (current.MissionCondition > 0) vars.Func.ResetS3MissionCondition();
        if (current.MissionClear) vars.Func.ResetS3MissionClear();
    }

    // Fix for Sonic 1 mission flag shenanigans
    if (current.Game == vars.Game.Sonic1 && current.GameMode != 0 && current.MissionCondition > 0)
        vars.Func.ResetS1MissionCondition();
}

start
{
    // Story mode
    if (settings["storystart"] && vars.watchers["S1PlayMode"].Current == 5 && old.ActID == 0 && current.ActID == 6)
        return vars.Start("Story Mode");

    // Sonic 1 boss rush
    if (settings["s1bossrush"] && current.ActID == 36 && (old.ActID != 36 || (old.Lives != 3 && current.Lives == 3) ) )
        return vars.Start("Sonic 1 - Boss Rush");

    // Sonic CD boss rush
    if (settings["scdbossrush"] && current.ActID == 3111 && (old.ActID != 3111 || (old.Lives != 3 && current.Lives == 3) ) )
        return vars.Start("Sonic CD - Boss Rush");

    // Sonic 2 boss rush
    if (settings["s2bossrush"] && current.ActID == 1063 && (old.ActID != 1063 || (old.Lives != 3 && current.Lives == 3) ) )
        return vars.Start("Sonic 2 - Boss Rush");

    // Sonic 3 boss rush
    if (settings["s3bossrush"] && current.ActID == 2070 && (old.ActID != 2070 || (old.Lives != 3 && current.Lives == 3) ) )
        return vars.Start("Sonic 3 & Knuckles - Boss Rush");

    // Sonic 1 single game
    if (settings["s1start"] && old.StartTrigger == 6 && current.StartTrigger == 1)
        return vars.Start("Sonic 1");

    // Sonic CD single game
    if (settings["scdstart"] && old.StartTrigger == 11 && current.StartTrigger == 2)
        return vars.Start("Sonic CD");
    
    // Sonic 2 single game
    if (settings["s2start"] && old.StartTrigger == 8 && current.StartTrigger == 9)
        return vars.Start("Sonic 2");
    
    // Sonic 3 single game
    if (settings["s3start"] && old.StartTrigger == 2 && current.StartTrigger == 15)
        return vars.Start("Sonic 3");
}

split
{
    // If current act is 0 (invalid stage or start of the run), there's no need to continue
    if (current.Act == 0)
        return false;
    
    // 0 = stages; 1 = boss rush

    // Splitting in Boss rush
    if (current.GameMode == 1 && settings[old.Act.ToString()] && old.MissionCondition == 0 && current.MissionCondition > 0)
        return vars.Split(vars.ActsName[old.Act]);

    // Splitting in normal acts
    if (current.GameMode == 0)
    {
        switch ((byte)current.Act)
        {
            // Act 80 (Hidden Palace) can be accessed from any previous level, thanks to the wrong warp
            case 80:
                if (settings[old.Act.ToString()] && old.Act < current.Act)
                    return vars.Split(vars.ActsName[old.Act]);
                break;
            // Act 81 (Sky Sanctuary) can technically be reached only from HPZ, but, because of a workaround used earlier in the script
            // we need to allow splitting from any previous level
            case 81:
                if (settings[(current.Act - 1).ToString()] && old.Act < current.Act)
                    return vars.Split(vars.ActsName[current.Act - 1]);
                break;
            // Act 85 (Sonic 3 credits) can be reached from either Sky Sanctuary (Knuckles' version), Death Egg 2 or Doomsday Zone
            case 85:
                if (settings[old.Act.ToString()] && (old.Act == 81 || old.Act == 83 || old.Act == 84))
                    return vars.Split(vars.ActsName[old.Act]);
                break;
            // The default behaviour is to split whenver you progress from a stage to the next one
            // In that case, the stage counte rincreased by 1
            default:
                if (settings[old.Act.ToString()] && current.Act == old.Act + 1)
                    return vars.Split(vars.ActsName[old.Act]);
                break;
        }
    }
}

isLoading
{
    return true;
}

gameTime
{
    if (settings["rta-tb"])
        return vars.RTATB.Elapsed;
    else
        return current.IGT + vars.AccumulatedIGT - vars.BufferIGT + current.SpecialIGT;
}

onStart
{
    if (!vars.RTATB.IsRunning) vars.RTATB.Start();
}
