// Sonic Origins autosplitter
// Coding: Jujstme
// contacts: just.tribe@gmail.com
// Version: 1.0.5 (Jun 28th, 2022)

state("SonicOrigins") {}

init
{
    // Define main watcher variable
    vars.watchers = new MemoryWatcherList();
    var ptr = IntPtr.Zero;
    var scanner = new SignatureScanner(game, modules.First().BaseAddress, modules.First().ModuleMemorySize);
    Action checkptr = () => { if (ptr == IntPtr.Zero) throw new Exception(); };

    // Preliminary support for sigscanning
    Func<int, int, int, bool, IntPtr> pointerPath = (int offset1, int offset2, int offset3, bool absolute) =>
    {
        int tempOffset = game.ReadValue<int>(ptr + offset1);
        IntPtr tempOffset2 = modules.First().BaseAddress + tempOffset + offset2;
        if (absolute)
            return modules.First().BaseAddress + game.ReadValue<int>(tempOffset2) + offset3;
        else
            return tempOffset2 + 0x4 + game.ReadValue<int>(tempOffset2) + offset3;
    };

    // Sonic CD jumptable 000000014008CB7F
    ptr = scanner.Scan(new SigScanTarget(-4, "49 03 CD FF E1 8B 05") { OnFound = (p, s, addr) => modules.First().BaseAddress + p.ReadValue<int>(addr) }); checkptr();
    vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 *  19, 10, 0x942,  false)) { Name = "SonicCDStartTrigger" });
    vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 * 120, 26, 0,      false)) { Name = "Act" });
    vars.watchers.Add(new MemoryWatcher<bool>(pointerPath(0x4 * 121,  3, 0,      false)) { Name = "TimerIsRunning" });
    vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 * 122,  3, 0,      false)) { Name = "Centisecs" });
    vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 * 123,  3, 0,      false)) { Name = "Secs" });
    vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 * 124,  3, 0,      false)) { Name = "Mins" });
    // Sonic CD RSDK flags
    // print(pointerPath(0x4 * 11, 7, 0,      true).ToString("X"));
    vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 *  11, 7,  0x2C,  true)) { Name = "SCDLives" });
    vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 *  11, 7, 0x22C,  true)) { Name = "SCDMissionCondition" });
    vars.watchers.Add(new MemoryWatcher<bool>(pointerPath(0x4 *  11, 7, 0x248,  true)) { Name = "SCDMissionClear" });

    // Sonic 1-2 RSDK flags
    ptr = scanner.Scan(new SigScanTarget(-4, "49 03 CC FF E1 8B 05") { OnFound = (p, s, addr) => modules.First().BaseAddress + p.ReadValue<int>(addr) }); checkptr();
    // jumptable 00000001400A2461 // print(pointerPath(0x4 * 17,  7, 0,      true).ToString("X"));
    vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 * 17,  7, 0x1A4,      true)) { Name = "S1PlayMode" }); // Becomes 5 in story mode
    vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 * 17,  7,  0x5C,      true)) { Name = "S1Lives" });
    vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 * 17,  7, 0x1F8,      true)) { Name = "S1MissionCondition" }); // 1 if mission clear, 2 if mission failed, 0 if mission not completed
    vars.watchers.Add(new MemoryWatcher<bool>(pointerPath(0x4 * 17,  7, 0x20C,      true)) { Name = "S1MissionClear" });
    vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 * 17,  7,  0x64,      true)) { Name = "S2Lives" });
    vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 * 17,  7, 0x290,      true)) { Name = "S2MissionCondition" }); // 1 if mission clear, 2 if mission failed, 0 if mission not completed
    vars.watchers.Add(new MemoryWatcher<bool>(pointerPath(0x4 * 17,  7, 0x2A4,      true)) { Name = "S2MissionClear" });


    ptr = scanner.Scan(new SigScanTarget(3, "8B 8C 96 ???????? 48 03 CE") { OnFound = (p, s, addr) => modules.First().BaseAddress + p.ReadValue<int>(addr) }); checkptr();
    vars.Ticks = pointerPath(0x4 * 1, 51, 0,      false);
    vars.watchers.Add(new MemoryWatcher<byte>((IntPtr)vars.Ticks) { Name = "Ticks" });
    //vars.watchers.Add(new MemoryWatcher<byte>(modules.First().BaseAddress + 0x2871B71) { Name = "Ticks" });

// General variables
    ptr = scanner.Scan(new SigScanTarget(5, "8B 47 10 89 05") { OnFound = (p, s, addr) => addr + 0x4 + p.ReadValue<int>(addr) }); checkptr();
    vars.watchers.Add(new MemoryWatcher<byte>(ptr) { Name = "Game" });

    ptr = scanner.Scan(new SigScanTarget(2, "8B 35 ???????? 89 1D") { OnFound = (p, s, addr) => addr + 0x4 + p.ReadValue<int>(addr) + 0x23D0 }); checkptr();
    vars.watchers.Add(new MemoryWatcher<byte>(ptr) { Name = "Sonic12StartTrigger" });
    //vars.watchers.Add(new MemoryWatcher<byte>(modules.First().BaseAddress + 0x30D78FC) { Name = "Sonic12StartTrigger" });

// Messy Sonic 3 variables
    ptr = scanner.Scan(new SigScanTarget(5, "83 FB 01 89 05") { OnFound = (p, s, addr) => addr + 0x4 + p.ReadValue<int>(addr) }); checkptr();
    vars.watchers.Add(new MemoryWatcher<byte>(ptr) { Name = "S3Act" });

    ptr = scanner.Scan(new SigScanTarget(7, "0F B7 04 5F") { OnFound = (p, s, addr) => modules.First().BaseAddress + p.ReadValue<int>(addr) }); checkptr();
    vars.watchers.Add(new MemoryWatcher<short>(ptr + 0xA) { Name = "S3XPOS" });
    vars.watchers.Add(new MemoryWatcher<byte>(ptr + 0xD4) { Name = "S3Lives" });
    vars.watchers.Add(new MemoryWatcher<byte>(ptr + 0xCC) { Name = "Sonic3SaveSlot" });
    vars.watchers.Add(new MemoryWatcher<bool>(ptr + 0x86C0) { Name = "S3ActClearFlag" }); 
    //vars.watchers.Add(new MemoryWatcher<short>(modules.First().BaseAddress + 0x3701E6A) { Name = "S3XPOS" });
    //vars.watchers.Add(new MemoryWatcher<byte>(modules.First().BaseAddress + 0x3701F2C) { Name = "Sonic3SaveSlot" });
    //vars.watchers.Add(new MemoryWatcher<bool>(modules.First().BaseAddress + 0x370A520) { Name = "S3ActClearFlag" });


    // Defining another pointerpath for Sonic 3's shenanigans
    Func<int, DeepPointer> pointerPath2 = (int offset1) =>
    {
        int tempOffset = game.ReadValue<int>(ptr + offset1);
        IntPtr tempOffset2 = modules.First().BaseAddress + tempOffset + 3;
        IntPtr tempOffset3 = modules.First().BaseAddress + tempOffset + 9;
        return new DeepPointer(tempOffset2 + game.ReadValue<int>(tempOffset2) + 0x4, game.ReadValue<int>(tempOffset3));
    };
    // jumptable 00000001400D706C
    ptr = scanner.Scan(new SigScanTarget(3, "8B 84 81 ???????? 48 03 C1 FF E0") { OnFound = (p, s, addr) => modules.First().BaseAddress + p.ReadValue<int>(addr) }); checkptr();
    vars.S3MissionCondition = pointerPath2(0x4 * 4);
    vars.S3MissionClear = pointerPath2(0x4 * 9);
    vars.watchers.Add(new MemoryWatcher<byte>(vars.S3MissionCondition) { Name = "S3MissionCondition" }); // 1 if mission clear, 2 if mission failed, 0 if mission not completed
    vars.watchers.Add(new MemoryWatcher<bool>(vars.S3MissionClear) { Name = "S3MissionClear" });

    // Custom functions
    vars.Deref = (Func<DeepPointer, IntPtr>)((a) => { 
        IntPtr _out = IntPtr.Zero;
        a.DerefOffsets(memory, out _out);
        return _out;
    });

    // Default variables
    current.Act = 0;
    current.IGT = 0f;
    current.GameMode = 0;
    current.S3MissionCondition = 0;
    current.S3MissionClear = false;

}

startup
{
    // Array containing the name of every act
    // This is used both in the settings and for debug purposes
    vars.actsName = new string[][] {
        new string[] { "Green Hill Zone - Act 1", "Green Hill Zone - Act 2", "Green Hill Zone - Act 3", "Marble Zone - Act 1", "Marble Zone - Act 2", "Marble Zone - Act 3", "Spring Yard Zone - Act 1", "Spring Yard Zone - Act 2", "Spring Yard Zone - Act 3", "Labyrinth Zone - Act 1", "Labyrinth Zone - Act 2", "Labyrinth Zone - Act 3", "Star Light Zone - Act 1", "Star Light Zone - Act 2", "Star Light Zone - Act 3", "Scrap Brain Zone - Act 1", "Scrap Brain Zone - Act 2", "Scrap Brain Zone - Act 3", "Final Zone" },
        new string[] { "Palmtree Panic Act 1", "Palmtree Panic Act 2", "Palmtree Panic Act 3", "Collision Chaos Act 1", "Collision Chaos Act 2", "Collision Chaos Act 3", "Tidal Tempest Act 1", "Tidal Tempest Act 2", "Tidal Tempest Act 3", "Quartz Quadrant Act 1", "Quartz Quadrant Act 2", "Quartz Quadrant Act 3", "Wacky Workbench Act 1", "Wacky Workbench Act 2", "Wacky Workbench Act 3", "Stardust Speedway Act 1", "Stardust Speedway Act 2", "Stardust Speedway Act 3", "Metallic Madness Act 1", "Metallic Madness Act 2", "Metallic Madness Act 3" },
        new string[] { "Emerald Hill Zone - Act 1", "Emerald Hill Zone - Act 2", "Chemical Plant Zone - Act 1", "Chemical Plant Zone - Act 2", "Aquatic Ruin Zone - Act 1", "Aquatic Ruin Zone - Act 2", "Casino Night Zone - Act 1", "Casino Night Zone - Act 2", "Hill Top Zone - Act 1", "Hill Top Zone - Act 2", "Mystic Cave Zone - Act 1", "Mystic Cave Zone - Act 2", "Oil Ocean Zone - Act 1", "Oil Ocean Zone - Act 2", "Metropolis Zone - Act 1", "Metropolis Zone - Act 2", "Metropolis Zone - Act 3", "Sky Chase Zone", "Wing Fortress Zone", "Death Egg Zone"},
        new string[] { "Angel Island Zone - Act 1", "Angel Island Zone - Act 2", "Hydrocity Zone - Act 1", "Hydrocity Zone - Act 2", "Marble Garden Zone - Act 1", "Marble Garden Zone - Act 2", "Carnival Night Zone - Act 1", "Carnival Night Zone - Act 2", "Ice Cap Zone - Act 1", "Ice Cap Zone - Act 2", "Launch Base Zone - Act 1", "Launch Base Zone - Act 2", "Mushroom Hill Zone - Act 1", "Mushroom Hill Zone - Act 2", "Flying Battery Zone - Act 1", "Flying Battery Zone - Act 2", "Sandopolis Zone - Act 1", "Sandopolis Zone - Act 2", "Lava Reef Zone - Act 1", "Lava Reef Zone - Act 2", "Hidden Palace Zone", "Sky Sanctuary Zone", "Death Egg Zone - Act 1", "Death Egg Zone - Act 2", "Doomsday Zone" },
        new string[] { "Egg Wrecker", "Egg Scorcher", "Egg Stinger", "Egg Mobile", "Egg Spiker", "Egg Crusher" },
        new string[] { "EGG-HVC-001", "Egg Tilter", "Egg Bubble", "Egg Conveyer", "Egg Razer", "Metal Sonic", "Egg Spinner" },
        new string[] { "Egg Drillster", "Egg Poison", "Egg Hammer", "Egg Claw", "Egg Scorcher Mk.II", "Egg Driller", "Eggmarine", "Egg Bouncer", "Laser Prison", "Mecha Sonic - Death Egg Robo" },
        new string[] { "Egg Scorcher Mk.III", "Egg Vortex", "Egg Drillster Mk.II", "Egg Gravitron (Sonic/Tails only)", "Egg Froster", "Egg Cannon, Egg Rocket, Big Arms", "Egg Scrambler", "Egg Hanger", "Egg Golem", "Egg Inferno (Sonic/Tails only)", "Giant Eggman Robo (Sonic/Tails only)", "Mecha Sonic Mk.II (Knuckles only)" },
    };

    // Settings
    settings.Add("start", true, "Autostart options");
    settings.Add("storystart", true, "Start from Story Mode", "start");
    settings.Add("s1start", true, "Start from Sonic 1", "start");
    settings.Add("scdstart", true, "Start from Sonic CD", "start");
    settings.Add("s2start", true, "Start from Sonic 2", "start");
    settings.Add("s3start", true, "Start from Sonic 3 & Knuckles", "start");
    settings.Add("s1bossrush", true, "Start at Boss Rush (Sonic 1)", "start");
    settings.Add("scdbossrush", true, "Start at Boss Rush (Sonic CD)", "start");
    settings.Add("s2bossrush", true, "Start at Boss Rush (Sonic 2)", "start");
    settings.Add("s3bossrush", true, "Start at Boss Rush (Sonic 3 & Knuckles)", "start");
    settings.Add("fixes", true, "Game Fixes");
    settings.Add("timerbug", false, "Fix Sonic CD timer bug", "fixes");
    settings.Add("autosplitting", true, "Autosplitting - Act list");
    settings.Add("s1", true, "Sonic 1", "autosplitting");
    settings.Add("scd", true, "Sonic CD", "autosplitting");
    settings.Add("s2", true, "Sonic 2", "autosplitting");
    settings.Add("s3", true, "Sonic 3 & Knuckles", "autosplitting");
    settings.Add("bossrush", true, "Boss Rush");
    settings.Add("brs1", true, "Sonic 1", "bossrush");
    settings.Add("brscd", true, "Sonic CD", "bossrush");
    settings.Add("brs2", true, "Sonic 2", "bossrush");
    settings.Add("brs3", true, "Sonic 3 & Knuckles", "bossrush");

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
    for (int j = 0; j < vars.actsName.Length; j++)
    {
        for (int z = 0; z < vars.actsName[j].Length; z++)
            settings.Add(i++.ToString(), true, vars.actsName[j][z], entry(j));
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
        { 2025, 70 }, { 2026, 71 }, // Launch Base Act 1, 2
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
}

update
{
    // Update the main watchers variable
    vars.watchers.UpdateAll(game);

    // Define current Act
    int cAct;
    switch ((byte)vars.watchers["Game"].Current)
    {
        default:
            cAct = vars.watchers["Act"].Current + vars.watchers["Game"].Current * 1000;
            break;
        case 2: // Sonic 3
            cAct = vars.watchers["S3Act"].Current + vars.watchers["Game"].Current * 1000;
            break;
    }
    if (vars.Acts.ContainsKey(cAct))
        current.Act = vars.Acts[cAct];

    // Define game mode
    // 0 = normal; 1 = boss rush
    if (current.Act < 85 || (current.Act == 85 && vars.watchers["Game"].Current == vars.Game.Sonic1))
        current.GameMode = 0;
    else
        current.GameMode = 1;

    // Fixing timer bug in Sonic CD
    if (settings["timerbug"] && vars.watchers["Game"].Current == vars.Game.SonicCD)
    {
        if (vars.watchers["TimerIsRunning"].Current || vars.watchers["Mins"].Current * 60 + vars.watchers["Secs"].Current + vars.watchers["Centisecs"].Current / 100f != 0f)
            current.IGT = vars.watchers["Mins"].Current * 60 + vars.watchers["Secs"].Current + vars.watchers["Centisecs"].Current / 100f;
        if (old.IGT > current.IGT)
        {
            game.WriteValue<byte>((IntPtr)vars.Ticks, (byte)Math.Round((vars.watchers["Centisecs"].Current / 100f) * 60));
        }
    }

    // Fix for Sonic 3 mission flag shenanigans
    if (vars.watchers["Game"].Current == vars.Game.Sonic3)
    {
        current.S3MissionCondition = vars.watchers["S3MissionCondition"].Current;
        current.S3MissionClear = vars.watchers["S3MissionClear"].Current;
        if (current.S3MissionCondition > 0) game.WriteValue<byte>((IntPtr)vars.Deref(vars.S3MissionCondition), 0);
        if (current.S3MissionClear) game.WriteValue<byte>((IntPtr)vars.Deref(vars.S3MissionClear), 0);
    }
}

start
{
    // Story mode
    if (settings["storystart"] && vars.watchers["S1PlayMode"].Current == 5 && vars.watchers["Act"].Old == 0 && vars.watchers["Act"].Current == 6) return true;

    // Sonic 1 boss rush
    if (settings["s1bossrush"] && vars.watchers["Game"].Current == vars.Game.Sonic1 && (vars.watchers["Act"].Old != 36 && vars.watchers["Act"].Current == 36) || (vars.watchers["Act"].Current == 36 && vars.watchers["S1Lives"].Old != 3 && vars.watchers["S1Lives"].Current == 3)) return true;

    // Sonic CD boss rush
    if (settings["scdbossrush"] && vars.watchers["Game"].Current == vars.Game.SonicCD && (vars.watchers["Act"].Old != 111 && vars.watchers["Act"].Current == 111) || (vars.watchers["Act"].Current == 111 && vars.watchers["SCDLives"].Old != 3 && vars.watchers["SCDLives"].Current == 3)) return true;

    // Sonic 2 boss rush
    if (settings["s2bossrush"] && vars.watchers["Game"].Current == vars.Game.Sonic2 && (vars.watchers["Act"].Old != 63 && vars.watchers["Act"].Current == 63) || (vars.watchers["Act"].Current == 63 && vars.watchers["S2Lives"].Old != 3 && vars.watchers["S2Lives"].Current == 3)) return true;

    // Sonic 3 boss rush
    if (settings["s3bossrush"] && vars.watchers["Game"].Current == vars.Game.Sonic3 && (vars.watchers["Act"].Old != 70 && vars.watchers["Act"].Current == 70) || (vars.watchers["Act"].Current == 70 && vars.watchers["S3Lives"].Old != 3 && vars.watchers["S3Lives"].Current == 3)) return true;

    // Single games
    switch ((byte)vars.watchers["Game"].Current)
    {
        case 0: // Sonic1
            return settings["s1start"] && vars.watchers["Sonic12StartTrigger"].Old == 6 && vars.watchers["Sonic12StartTrigger"].Current == 1;
        case 3: // Sonic CD
            return settings["scdstart"] && vars.watchers["SonicCDStartTrigger"].Old == 11 && vars.watchers["SonicCDStartTrigger"].Current == 2;
        case 1: // Sonic 2
            return settings["s2start"] && vars.watchers["Sonic12StartTrigger"].Old == 8 && vars.watchers["Sonic12StartTrigger"].Current == 9;
        case 2: // Sonic 3
            return settings["s3start"] && vars.watchers["Act"].Old == 2 && vars.watchers["Act"].Current == 15 && vars.watchers["Sonic3SaveSlot"].Current >= 65 && vars.watchers["Sonic3SaveSlot"].Current <= 73;
    }
}

split
{
    // If current act is 0 (invalid stage or start of the run), there's no need to continue
    if (current.Act == 0)
        return false;
    
    // 0 = stages; 1 = boss rush

    // Splitting in Boss rush
    if (current.GameMode == 1)
    {
        switch ((byte)vars.watchers["Game"].Current)
        {
            case 0: // Sonic 1
                if (settings["90"] && old.Act == 90 && vars.watchers["S1MissionCondition"].Old == 0 && vars.watchers["S1MissionCondition"].Current == 1) return true;
                if (settings[old.Act.ToString()] && current.Act == old.Act + 1) return true;
                break;
            case 1: // Sonic 2
                if (settings["107"] && old.Act == 107 && vars.watchers["S2MissionCondition"].Old == 0 && vars.watchers["S2MissionCondition"].Current == 1) return true;
                if (settings[old.Act.ToString()] && current.Act == old.Act + 1) return true;
                break;
            case 2: // Sonic 3
                switch ((byte)current.Act)
                {
                    // Act 112 (Egg Froster) can be accessed even from Act 110 (Egg Drillster Mk.II), especially with Knuckles as he skips Egg Gravitron
                    case 112:
                        if (settings[old.Act.ToString()] && (old.Act == 110 || old.Act == 111)) return true;
                        break;
                    // Act 119 (Mecha Sonic Mk.II) is a Knuckles-exclusive boss, and will be accessed directly from Act 116 (Egg Golem)
                    // It's also the final boss for Knuckles, so we need to put the las tboss condition here
                    case 119:
                        if (settings["116"] && old.Act == 116) return true;
                        if (settings["119"] && old.Act == 119 && current.S3MissionCondition == 1) return true;
                        break;
                    default:
                        if (settings["118"] && old.Act == 118 && current.S3MissionCondition == 1) return true;
                        if (settings[old.Act.ToString()] && current.Act == old.Act + 1) return true;
                        break;
                }
                break;
            case 3: // Sonic CD
                if (settings["97"] && old.Act == 97 && vars.watchers["SCDMissionCondition"].Old == 0 && vars.watchers["SCDMissionCondition"].Current == 1) return true;
                if (settings[old.Act.ToString()] && current.Act == old.Act + 1) return true;
                break;
        }
    }

    // Splitting in normal acts
    if (current.GameMode == 0)
    {
        switch ((byte)vars.watchers["Game"].Current)
        {
            default:
                if (settings[old.Act.ToString()] && current.Act == old.Act + 1) return true;
                break;
            // Split management in Sonic 3 needs special cases
            case 2:
                switch ((byte)current.Act)
                {
                    // Act 61 Angel Island needs special care
                    case 61:
                        if (settings["60"] && vars.watchers["S3ActClearFlag"].Old && !vars.watchers["S3ActClearFlag"].Current && vars.watchers["S3XPOS"].Current < 4700) return true;
                        break;
                    // Act 72 (Mushroom Hill Act 1) needs to be reached after the falling Death Egg cutscene
                    case 72:
                        if (settings[old.Act.ToString()] && vars.watchers["Act"].Old == 4 && vars.watchers["Act"].Current != 4) return true;
                        break;
                    // Act 85 (credits) can be reached from Sky Sanctuary (Knuckles' ending), DEZ2 or Doomsday Zone
                    case 85:
                        if (settings[old.Act.ToString()] && (old.Act == 81 || old.Act == 83 || old.Act == 84)) return true;
                        break;
                    default:
                        if (settings[old.Act.ToString()] && current.Act == old.Act + 1) return true;
                        break;
                }
            break;
        }
    }
}
