// Sonic Origins autosplitter
// Coding: Jujstme
// contacts: just.tribe@gmail.com
// Version: 1.0.1 (Jun 24th, 2022)

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


    ptr = scanner.Scan(new SigScanTarget(-4, "49 03 CD FF E1 8B 05")
        { OnFound = (p, s, addr) => modules.First().BaseAddress + p.ReadValue<int>(addr) }
    );
    checkptr();
    // jumptable 000000014008CB7F
    vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 * 120, 26, 0,      false)) { Name = "Act" });
    vars.watchers.Add(new MemoryWatcher<bool>(pointerPath(0x4 * 121,  3, 0,      false)) { Name = "TimerIsRunning" });
    vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 * 122,  3, 0,      false)) { Name = "Centisecs" });
    vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 * 123,  3, 0,      false)) { Name = "Secs" });
    vars.watchers.Add(new MemoryWatcher<byte>(pointerPath(0x4 * 124,  3, 0,      false)) { Name = "Mins" });

    ptr = scanner.Scan(new SigScanTarget(5, "8B 47 10 89 05") { OnFound = (p, s, addr) => addr + 0x4 + p.ReadValue<int>(addr) });
    checkptr();
    vars.watchers.Add(new MemoryWatcher<byte>(ptr) { Name = "Game" });

    vars.watchers.Add(new MemoryWatcher<byte>(modules.First().BaseAddress + 0x30D78FC) { Name = "Sonic12StartTrigger" });
    vars.watchers.Add(new MemoryWatcher<byte>(modules.First().BaseAddress + 0x2F49092) { Name = "SonicCDStartTrigger" });



    ptr = scanner.Scan(new SigScanTarget(5, "83 FB 01 89 05") { OnFound = (p, s, addr) => addr + 0x4 + p.ReadValue<int>(addr) }); checkptr();
    vars.watchers.Add(new MemoryWatcher<byte>(ptr) { Name = "S3Act" });

    vars.watchers.Add(new MemoryWatcher<short>(modules.First().BaseAddress + 0x3701E6A) { Name = "S3XPOS" });

    vars.watchers.Add(new MemoryWatcher<byte>(modules.First().BaseAddress + 0x3701F2C) { Name = "Sonic3SaveSlot" });
    vars.watchers.Add(new MemoryWatcher<bool>(modules.First().BaseAddress + 0x370A520) { Name = "S3ActClearFlag" });
    vars.watchers.Add(new MemoryWatcher<byte>(modules.First().BaseAddress + 0x2871B71) { Name = "Ticks" });

    vars.Ticks = modules.First().BaseAddress + 0x2871B71;

    // Default Act
    current.Act = 0;
    current.IGT = 0f;
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
        // new string[] { "Egg Wrecker", "Egg Scorcher", "Egg Stinger", "Egg Mobile", "Egg Spiker", "Egg Crusher" },
    };

    // Settings
    settings.Add("start", true, "Autostart options");
    settings.Add("s1start", true, "Start from Sonic 1", "start");
    settings.Add("scdstart", true, "Start from Sonic CD", "start");
    settings.Add("s2start", true, "Start from Sonic 2", "start");
    settings.Add("s3start", true, "Start from Sonic 3 & Knuckles", "start");
    settings.Add("fixes", true, "Game Fixes");
    settings.Add("timerbug", false, "Fix Sonic CD timer bug", "fixes");
    settings.Add("autosplitting", true, "Autosplitting - Act list");
    settings.Add("s1", true, "Sonic 1", "autosplitting");
    settings.Add("scd", true, "Sonic CD", "autosplitting");
    settings.Add("s2", true, "Sonic 2", "autosplitting");
    settings.Add("s3", true, "Sonic 3 & Knuckles", "autosplitting");
    //settings.Add("bossrush", true, "Boss Rush");
    //settings.Add("brs1", true, "Sonic 1", "bossrush");
    //settings.Add("brscd", true, "Sonic CD", "bossrush");
    //settings.Add("brs2", true, "Sonic 2", "bossrush");
    //settings.Add("brs3", true, "Sonic 3 & Knuckles", "bossrush");


    // Adding the acts to the autosplitting settings
    int i = 0;
    for (int j = 0; j < vars.actsName.Length; j++)
    {
        for (int z = 0; z < vars.actsName[j].Length; z++)
            settings.Add(i++.ToString(), true, vars.actsName[j][z], j == 0 ? "s1" : j == 1 ? "scd" : j == 2 ? "s2" : "s3");
    }

    // Dictionaries
    vars.Game = new Dictionary<string, byte>{
        { "Sonic1",  0 },
        { "SonicCD", 3 },
        { "Sonic2",  1 },
        { "Sonic3",  2 }
    };

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
        {  1, 19 },                         // S1 ending
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
        { 1001, 60 },               // S2 Ending
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
        /* { 36, 85 },     // VS Egg Wrecker
        { 37, 86 },     // VS Egg Scorcher
        { 38, 87 },     // VS Egg Stinger
        { 39, 88 },     // VS Egg Mobile
        { 40, 89 },     // VS Egg Spiker
        { 41, 90 },     // VS Egg Crusher
        */
    };
}

update
{
    // Update the main watchers variable
    vars.watchers.UpdateAll(game);

    // Define current Act
    int cAct = vars.watchers[(vars.watchers["Game"].Current == vars.Game["Sonic3"] ? "S3" : "") + "Act"].Current + vars.watchers["Game"].Current * 1000;
    if (vars.Acts.ContainsKey(cAct))
        current.Act = vars.Acts[cAct];
    
    // Fixing timer bug in Sonic CD
    if (settings["timerbug"] && vars.watchers["Game"].Current == vars.Game["SonicCD"])
    {
        if (vars.watchers["TimerIsRunning"].Current || vars.watchers["Mins"].Current * 60 + vars.watchers["Secs"].Current + vars.watchers["Centisecs"].Current / 100f != 0f)
            current.IGT = vars.watchers["Mins"].Current * 60 + vars.watchers["Secs"].Current + vars.watchers["Centisecs"].Current / 100f;
        if (old.IGT > current.IGT)
        {
            game.WriteValue<byte>((IntPtr)vars.Ticks, (byte)Math.Round((vars.watchers["Centisecs"].Current / 100f) * 60));
        }
    }
}

start
{
    if (vars.watchers["Game"].Current == vars.Game["Sonic1"])
    {
        return settings["s1start"] && vars.watchers["Sonic12StartTrigger"].Old == 6 && vars.watchers["Sonic12StartTrigger"].Current == 1;
    } else if (vars.watchers["Game"].Current == vars.Game["SonicCD"]) {
        return settings["scdstart"] && vars.watchers["SonicCDStartTrigger"].Old == 11 && vars.watchers["SonicCDStartTrigger"].Current == 2;
    } else if (vars.watchers["Game"].Current == vars.Game["Sonic2"]) {
        return settings["s2start"] && vars.watchers["Sonic12StartTrigger"].Old == 8 && vars.watchers["Sonic12StartTrigger"].Current == 9;
    } else {
        return settings["s3start"] && vars.watchers["Act"].Old == 2 && vars.watchers["Act"].Current == 15 && vars.watchers["Sonic3SaveSlot"].Current >= 65 && vars.watchers["Sonic3SaveSlot"].Current <= 73;
    }
}

split
{
    // If current act is 0 (invalid stage or start of the run), there's no need to continue
    if (current.Act == 0)
        return false;
    
    // 1 = stages; 2 = boss rush
    // int Mode = current.Act <= 85 ? 1 : 2;

    // If you disabled spitting for the stage you completed, there's no need to continue as well
    // if (!settings[old.Act.ToString()])
    //     return false;

    // Check what game you're running
    if (vars.watchers["Game"].Current != vars.Game["Sonic3"])
    {
        // In all games except Sonic 3, progression is simple: just split whenever you go to the next stage
        if (settings[old.Act.ToString()] && current.Act == old.Act + 1)
            return true;
    } else {
        // Act 61 (Angel Island Zone) needs special care
        if (current.Act == 61)
        {
            if (settings["60"] && vars.watchers["S3ActClearFlag"].Old && !vars.watchers["S3ActClearFlag"].Current && vars.watchers["S3XPOS"].Current < 4700)
                return true;
        }
        // Act 72 (Mushroom Hill Act 1) needs to be reached after the falling Death Egg cutscene
        else if (current.Act == 72)
        {
            if (settings[old.Act.ToString()] && vars.watchers["Act"].Old == 4 && vars.watchers["Act"].Current != 4)
                return true;
        }
        // Act 85 (credits) can be reached from Sky Sanctuary (Knuckles' ending), DEZ2 or Doomsday Zone
        else if (current.Act == 85)
        {
            if (settings[old.Act.ToString()] && (old.Act == 81 || old.Act == 83 || old.Act == 84))
                return true;
        } else {
            // Otherwise, use the standard progression
            if (settings[old.Act.ToString()] && current.Act == old.Act + 1)
                return true;
        }
    }
}
