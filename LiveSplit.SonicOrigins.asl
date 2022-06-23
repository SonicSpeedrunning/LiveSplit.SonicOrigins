// Sonic Origins autosplitter
// Coding: Jujstme
// contacts: just.tribe@gmail.com
// Version: 1.0.0 (Jun 23rd, 2022)

state("SonicOrigins") {}

init
{
    // Define main watcher variable
    vars.watchers = new MemoryWatcherList();
    var scanner = new SignatureScanner(game, modules.First().BaseAddress, modules.First().ModuleMemorySize);
    Action<IntPtr> checkptr = (IntPtr addr) => { if (addr == IntPtr.Zero) throw new Exception(); };

    vars.watchers.Add(new MemoryWatcher<byte>(modules.First().BaseAddress + 0x3F420D8) { Name = "Game" });
    vars.watchers.Add(new MemoryWatcher<byte>(modules.First().BaseAddress + 0x3D34FF4) { Name = "Act" });

    vars.watchers.Add(new MemoryWatcher<byte>(modules.First().BaseAddress + 0x30D78FC) { Name = "Sonic12StartTrigger" });
    vars.watchers.Add(new MemoryWatcher<byte>(modules.First().BaseAddress + 0x2F49092) { Name = "SonicCDStartTrigger" });
    vars.watchers.Add(new MemoryWatcher<byte>(modules.First().BaseAddress + 0x3701F2C) { Name = "Sonic3SaveSlot" });
}

startup
{
    // Acts name: used primarily for populating the settings
    string[] Sonic1actsName = {
        "Green Hill Zone - Act 1", "Green Hill Zone - Act 2", "Green Hill Zone - Act 3",
        "Marble Zone - Act 1", "Marble Zone - Act 2", "Marble Zone - Act 3",
        "Spring Yard Zone - Act 1", "Spring Yard Zone - Act 2", "Spring Yard Zone - Act 3",
        "Labyrinth Zone - Act 1", "Labyrinth Zone - Act 2", "Labyrinth Zone - Act 3",
        "Star Light Zone - Act 1", "Star Light Zone - Act 2", "Star Light Zone - Act 3",
        "Scrap Brain Zone - Act 1", "Scrap Brain Zone - Act 2", "Scrap Brain Zone - Act 3",
        "Final Zone"
    };

    string[][] SonicCDactsName = {
        new string[] { "Palmtree Panic Act 1", "Palmtree Panic Act 1 - Past", "Palmtree Panic Act 1 - Good Future", "Palmtree Panic Act 1 - Bad Future" },
        new string[] { "Palmtree Panic Act 2", "Palmtree Panic Act 2 - Past", "Palmtree Panic Act 2 - Good Future", "Palmtree Panic Act 2 - Bad Future" },
        new string[] { "Palmtree Panic Act 3", "Palmtree Panic act 3 - Bad Future" },
        new string[] { "Collision Chaos Act 1", "Collision Chaos Act 1 - Past", "Collision Chaos Act 1 - Good Future", "Collision Chaos Act 1 - Bad Future" },
        new string[] { "Collision Chaos Act 2", "Collision Chaos Act 2 - Past", "Collision Chaos Act 2 - Good Future", "Collision Chaos Act 2 - Bad Future" },
        new string[] { "Collision Chaos Act 3", "Collision Chaos Act 3 - Bad Future"},
        new string[] { "Tidal Tempest Act 1", "Tidal Tempest Act 1 - Past", "Tidal Tempest Act 1 - Good Future", "Tidal Tempest Act 1 - Bad Future" },
        new string[] { "Tidal Tempest Act 2", "Tidal Tempest Act 2 - Past", "Tidal Tempest Act 2 - Good Future", "Tidal Tempest Act 2 - Bad Future" },
        new string[] { "Tidal Tempest Act 3", "Tidal Tempest Act 3 - Bad Future"},
        new string[] { "Quartz Quadrant Act 1", "Quartz Quadrant Act 1 - Past", "Quartz Quadrant Act 1 - Good Future", "Quartz Quadrant Act 1 - Bad Future" },
        new string[] { "Quartz Quadrant Act 2", "Quartz Quadrant Act 2 - Past", "Quartz Quadrant Act 2 - Good Future", "Quartz Quadrant Act 2 - Bad Future" },
        new string[] { "Quartz Quadrant Act 3", "Quartz Quadrant Act 3 - Bad Future" },
        new string[] { "Wacky Workbench Act 1", "Wacky Workbench Act 1 - Past", "Wacky Workbench Act 1 - Good Future", "Wacky Workbench Act 1 - Bad Future" },
        new string[] { "Wacky Workbench Act 2", "Wacky Workbench Act 2 - Past", "Wacky Workbench Act 2 - Good Future", "Wacky Workbench Act 2 - Bad Future" },
        new string[] { "Wacky Workbench Act 3", "Wacky Workbench Act 3 - Bad Future" },
        new string[] { "Stardust Speedway Act 1", "Stardust Speedway Act 1 - Past", "Stardust Speedway Act 1 - Good Future", "Stardust Speedway Act 1 - Bad Future" },
        new string[] { "Stardust Speedway Act 2", "Stardust Speedway Act 2 - Past", "Stardust Speedway Act 2 - Good Future", "Stardust Speedway Act 2 - Bad Future" },
        new string[] { "Stardust Speedway Act 3", "Stardust Speedway Act 3 - Bad Future" },
        new string[] { "Metallic Madness Act 1", "Metallic Madness Act 1 - Past", "Metallic Madness Act 1 - Good Future", "Metallic Madness Act 1 - Bad Future" },
        new string[] { "Metallic Madness Act 2", "Metallic Madness Act 2 - Past", "Metallic Madness Act 2 - Good Future", "Metallic Madness Act 2 - Bad Future" },
        new string[] { "Metallic Madness Act 3", "Metallic Madness Act 3 - Bad Future" }
    };

    string[] Sonic2actsName = {
        "Emerald Hill Zone - Act 1", "Emerald Hill Zone - Act 2",
        "Chemical Plant Zone - Act 1", "Chemical Plant Zone - Act 2",
        "Aquatic Ruin Zone - Act 1", "Aquatic Ruin Zone - Act 2",
        "Casino Night Zone - Act 1", "Casino Night Zone - Act 2",
        "Hill Top Zone - Act 1", "Hill Top Zone - Act 2",
        "Mystic Cave Zone - Act 1", "Mystic Cave Zone - Act 2",
        "Oil Ocean Zone - Act 1", "Oil Ocean Zone - Act 2",
        "Metropolis Zone - Act 1", "Metropolis Zone - Act 2", "Metropolis Zone - Act 3",
        "Sky Chase Zone",
        "Wing Fortress Zone",
        "Death Egg Zone"
    };

    string[] Sonic3actsName = {
        "Angel Island Zone - Act 1", "Angel Island Zone - Act 2",
        "Hydrocity Zone - Act 1", "Hydrocity Zone - Act 2",
        "Marble Garden Zone - Act 1", "Marble Garden Zone - Act 2",
        "Carnival Night Zone - Act 1", "Carnival Night Zone - Act 2",
        "Ice Cap Zone - Act 1", "Ice Cap Zone - Act 2",
        "Launch Base Zone - Act 1", "Launch Base Zone - Act 2",
        "Mushroom Hill Zone - Act 1", "Mushroom Hill Zone - Act 2",
        "Flying Battery Zone - Act 1", "Flying Battery Zone - Act 2",
        "Sandopolis Zone - Act 1", "Sandopolis Zone - Act 2",
        "Lava Reef Zone - Act 1", "Lava Reef Zone - Act 2",
        "Hidden Palace Zone", "Sky Sanctuary Zone",
        "Death Egg Zone - Act 1", "Death Egg Zone - Act 2",
        "Doomsday Zone"
    };

    // Settings
    settings.Add("start", true, "Autostart options");
    settings.Add("s1start", true, "Start from Sonic 1", "start");
    settings.Add("scdstart", true, "Start from Sonic CD", "start");
    settings.Add("s2start", true, "Start from Sonic 2", "start");
    settings.Add("s3start", true, "Start from Sonic 3 & Knuckles", "start");
    //settings.Add("fixes", true, "Game Fixes");
    //settings.Add("timerbug", true, "Fix Sonic CD timer bug", "fixes");
    settings.Add("autosplitting", true, "Autosplitting");
    settings.Add("s1", true, "Sonic 1", "autosplitting");
    settings.Add("scd", true, "Sonic CD", "autosplitting");
    settings.Add("s2", true, "Sonic 2", "autosplitting");
    settings.Add("s3", true, "Sonic 3 & Knuckles", "autosplitting");

    // Adding the acts to the autosplitting settings
    int i = 0;
    for (int j = 0; j < Sonic1actsName.Length; j++) settings.Add(i++.ToString(), true, Sonic1actsName[j], "s1");
    for (int j = 0; j < SonicCDactsName.Length; j++) settings.Add(i++.ToString(), true, SonicCDactsName[j][0], "scd");
    for (int j = 0; j < Sonic2actsName.Length; j++) settings.Add(i++.ToString(), true, Sonic2actsName[j], "s2");
    for (int j = 0; j < Sonic3actsName.Length; j++) settings.Add(i++.ToString(), true, Sonic3actsName[j], "s3");

    // Dictionaries
    vars.Game = new Dictionary<string, byte>{
        { "Sonic1", 0 },
        { "SonicCD", 3 },
        { "Sonic2", 1 },
        { "Sonic3", 2 }
    };

    vars.Acts = new ExpandoObject();

    vars.Acts.Sonic1 = new Dictionary<string, byte>{
        { "GreenHill1", 6 },
        { "GreenHill2", 7 },
        { "GreenHill3", 8 },
        { "Marble1", 9 },
        { "Marble2", 10 },
        { "Marble3", 11 },
        { "SpringYard1", 12 },
        { "SpringYard2", 13 },
        { "SpringYard3", 14 },
        { "Labyrinth1", 15 },
        { "Labyrinth2", 16 },
        { "Labyrinth3", 17 },
        { "Starlight1", 18 },
        { "Starlight2", 19 },
        { "Starlight3", 20 },
        { "ScrapBrain1", 21 },
        { "ScrapBrain2", 22 },
        { "ScrapBrain3", 23 },
        { "FinalZone", 24 },
        { "Ending", 1 }
    };

    vars.Acts.SonicCD = new Dictionary<string, byte>{
        { "PalmtreePanic1", 13 },
        { "PalmtreePanic1Past", 14 },
        { "PalmtreePanic1GoodFuture", 15 },
        { "PalmtreePanic1BadFuture", 16 },
        { "PalmtreePanic2", 17 },
        { "PalmtreePanic2Past", 18 },
        { "PalmtreePanic2GoodFuture", 19 },
        { "PalmtreePanic2BadFuture", 20 },
        { "PalmtreePanic3GoodFuture", 21 },
        { "PalmtreePanic3BadFuture", 22 },
        { "CollisionChaos1", 23 },
        { "CollisionChaos1Past", 24 },
        { "CollisionChaos1GoodFuture", 25 },
        { "CollisionChaos1BadFuture", 26 },
        { "CollisionChaos2", 27 },
        { "CollisionChaos2Past", 28 },
        { "CollisionChaos2GoodFuture", 29 },
        { "CollisionChaos2BadFuture", 30 },
        { "CollisionChaos3GoodFuture", 31 },
        { "CollisionChaos3BadFuture", 32 },
        { "TidalTempest1", 33 },
        { "TidalTempest1Past", 34 },
        { "TidalTempest1GoodFuture", 35 },
        { "TidalTempest1BadFuture", 36 },
        { "TidalTempest2", 37 },
        { "TidalTempest2Past", 38 },
        { "TidalTempest2GoodFuture", 39 },
        { "TidalTempest2BadFuture", 40 },
        { "TidalTempest3GoodFuture", 41 },
        { "TidalTempest3BadFuture", 42 },
        { "QuartzQuadrant1", 43 },
        { "QuartzQuadrant1Past", 44 },
        { "QuartzQuadrant1GoodFuture", 45 },
        { "QuartzQuadrant1BadFuture", 46 },
        { "QuartzQuadrant2", 47 },
        { "QuartzQuadrant2Past", 48 },
        { "QuartzQuadrant2GoodFuture", 49 },
        { "QuartzQuadrant2BadFuture", 50 },
        { "QuartzQuadrant3GoodFuture", 51 },
        { "QuartzQuadrant3BadFuture", 52 },
        { "WackyWorkbench1", 53 },
        { "WackyWorkbench1Past", 54 },
        { "WackyWorkbench1GoodFuture", 55 },
        { "WackyWorkbench1BadFuture", 56 },
        { "WackyWorkbench2", 57 },
        { "WackyWorkbench2Past", 58 },
        { "WackyWorkbench2GoodFuture", 59 },
        { "WackyWorkbench2BadFuture", 60 },
        { "WackyWorkbench3GoodFuture", 61 },
        { "WackyWorkbench3BadFuture", 62 },
        { "StardustSpeedway1", 63 },
        { "StardustSpeedway1Past", 64 },
        { "StardustSpeedway1GoodFuture", 65 },
        { "StardustSpeedway1BadFuture", 66 },
        { "StardustSpeedway2", 67 },
        { "StardustSpeedway2Past", 68 },
        { "StardustSpeedway2GoodFuture", 69 },
        { "StardustSpeedway2BadFuture", 70 },
        { "StardustSpeedway3GoodFuture", 71 },
        { "StardustSpeedway3BadFuture", 72 },
        { "MetallicMadness1", 73 },
        { "MetallicMadness1Past", 74 },
        { "MetallicMadness1GoodFuture", 75 },
        { "MetallicMadness1BadFuture", 76 },
        { "MetallicMadness2", 77 },
        { "MetallicMadness2Past", 78 },
        { "MetallicMadness2GoodFuture", 79 },
        { "MetallicMadness2BadFuture", 80 },
        { "MetallicMadness3GoodFuture", 81 },
        { "MetallicMadness3BadFuture", 82 },
        { "Ending", 8 }
    };

    vars.Acts.Sonic2 = new Dictionary<string, byte>{
        { "EmeraldHill1", 6 },
        { "EmeraldHill2", 7 },
        { "ChemicalPlant1", 8 },
        { "ChemicalPlant2", 9 },
        { "AquaticRuin1", 10 },
        { "AquaticRuin2", 11 },
        { "CasinoNight1", 12 },
        { "CasinoNight2", 13 },
        { "HillTop1", 14 },
        { "HillTop2", 15 },
        { "MysticCave1", 16 },
        { "MysticCave2", 17 },
        { "OilOcean1", 18 },
        { "OilOcean2", 19 },
        { "Metropolis1", 20 },
        { "Metropolis2", 21 },
        { "Metropolis3", 22 },
        { "SkyChase", 23 },
        { "WingFortress", 24 },
        { "DeathEgg", 25 },
        { "Ending", 1 }
    };

    vars.Acts.Sonic3 = new Dictionary<string, byte>{
        { "AngelIsland1", 15 },
        { "AngelIsland2", 16 },
        { "Hydrocity1", 17 },
        { "Hydrocity2", 18 },
        { "MarbleGarden1", 19 },
        { "MarbleGarden2", 20 },
        { "CarnivalNight1", 21 },
        { "CarnivalNight2", 22 },
        { "IceCap1", 23 },
        { "IceCap2", 24 },
        { "LaunchBase1", 25 },
        { "LaunchBase2", 26 },
        { "MushroomHill1", 27 },
        { "MushroomHill2", 28 },
        { "FlyingBattery1", 29 },
        { "FlyingBattery2", 30 },
        { "Sandopolis1", 31 },
        { "Sandopolis2", 32 },
        { "LavaReef1", 33 },
        { "LavaReef2", 34 },
        { "LavaReefBoss", 35 },
        { "HiddenPalace", 36 },
        { "SkySanctuary", 37 },
        { "SkySanctuaryKnuckles", 38 },
        { "DeathEgg1", 39 },
        { "DeathEgg2", 40 },
        { "DeathEggBoss", 41 },
        { "DoomsDay", 42 },
        { "Ending", 5 },
    };

    // Default Act
    vars.Act = new ExpandoObject();
    vars.Act.Current = 0;
    vars.Act.Old = 0;

    // Conditional splitting
    i = 0;
    vars.SplitBools = new Dictionary<string, Func<bool>>{
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic1"] && vars.Act.Old == vars.Acts.Sonic1["GreenHill1"] && vars.Act.Current == vars.Acts.Sonic1["GreenHill2"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic1"] && vars.Act.Old == vars.Acts.Sonic1["GreenHill2"] && vars.Act.Current == vars.Acts.Sonic1["GreenHill3"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic1"] && vars.Act.Old == vars.Acts.Sonic1["GreenHill3"] && vars.Act.Current == vars.Acts.Sonic1["Marble1"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic1"] && vars.Act.Old == vars.Acts.Sonic1["Marble1"] && vars.Act.Current == vars.Acts.Sonic1["Marble2"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic1"] && vars.Act.Old == vars.Acts.Sonic1["Marble2"] && vars.Act.Current == vars.Acts.Sonic1["Marble3"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic1"] && vars.Act.Old == vars.Acts.Sonic1["Marble3"] && vars.Act.Current == vars.Acts.Sonic1["SpringYard1"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic1"] && vars.Act.Old == vars.Acts.Sonic1["SpringYard1"] && vars.Act.Current == vars.Acts.Sonic1["SpringYard2"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic1"] && vars.Act.Old == vars.Acts.Sonic1["SpringYard2"] && vars.Act.Current == vars.Acts.Sonic1["SpringYard3"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic1"] && vars.Act.Old == vars.Acts.Sonic1["SpringYard3"] && vars.Act.Current == vars.Acts.Sonic1["Labyrinth1"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic1"] && vars.Act.Old == vars.Acts.Sonic1["Labyrinth1"] && vars.Act.Current == vars.Acts.Sonic1["Labyrinth2"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic1"] && vars.Act.Old == vars.Acts.Sonic1["Labyrinth2"] && vars.Act.Current == vars.Acts.Sonic1["Labyrinth3"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic1"] && vars.Act.Old == vars.Acts.Sonic1["Labyrinth3"] && vars.Act.Current == vars.Acts.Sonic1["Starlight1"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic1"] && vars.Act.Old == vars.Acts.Sonic1["Starlight1"] && vars.Act.Current == vars.Acts.Sonic1["Starlight2"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic1"] && vars.Act.Old == vars.Acts.Sonic1["Starlight2"] && vars.Act.Current == vars.Acts.Sonic1["Starlight3"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic1"] && vars.Act.Old == vars.Acts.Sonic1["Starlight3"] && vars.Act.Current == vars.Acts.Sonic1["ScrapBrain1"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic1"] && vars.Act.Old == vars.Acts.Sonic1["ScrapBrain1"] && vars.Act.Current == vars.Acts.Sonic1["ScrapBrain2"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic1"] && vars.Act.Old == vars.Acts.Sonic1["ScrapBrain2"] && vars.Act.Current == vars.Acts.Sonic1["ScrapBrain3"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic1"] && vars.Act.Old == vars.Acts.Sonic1["ScrapBrain3"] && vars.Act.Current == vars.Acts.Sonic1["FinalZone"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic1"] && vars.Act.Current == vars.Acts.Sonic1["Ending"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["SonicCD"] && (vars.Act.Old == vars.Acts.SonicCD["PalmtreePanic1"] || vars.Act.Old == vars.Acts.SonicCD["PalmtreePanic1Past"] || vars.Act.Old == vars.Acts.SonicCD["PalmtreePanic1GoodFuture"] || vars.Act.Old == vars.Acts.SonicCD["PalmtreePanic1BadFuture"]) && (vars.Act.Current == vars.Acts.SonicCD["PalmtreePanic2"] || vars.Act.Current == vars.Acts.SonicCD["PalmtreePanic2Past"] || vars.Act.Current == vars.Acts.SonicCD["PalmtreePanic2GoodFuture"] || vars.Act.Current == vars.Acts.SonicCD["PalmtreePanic2BadFuture"]) },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["SonicCD"] && (vars.Act.Old == vars.Acts.SonicCD["PalmtreePanic2"] || vars.Act.Old == vars.Acts.SonicCD["PalmtreePanic2Past"] || vars.Act.Old == vars.Acts.SonicCD["PalmtreePanic2GoodFuture"] || vars.Act.Old == vars.Acts.SonicCD["PalmtreePanic2BadFuture"]) && (vars.Act.Current == vars.Acts.SonicCD["PalmtreePanic3GoodFuture"] || vars.Act.Current == vars.Acts.SonicCD["PalmtreePanic3BadFuture"]) },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["SonicCD"] && (vars.Act.Old == vars.Acts.SonicCD["PalmtreePanic3GoodFuture"] || vars.Act.Old == vars.Acts.SonicCD["PalmtreePanic3BadFuture"]) && (vars.Act.Current == vars.Acts.SonicCD["CollisionChaos1"] || vars.Act.Current == vars.Acts.SonicCD["CollisionChaos1Past"] || vars.Act.Current == vars.Acts.SonicCD["CollisionChaos1GoodFuture"] || vars.Act.Current == vars.Acts.SonicCD["CollisionChaos1BadFuture"]) },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["SonicCD"] && (vars.Act.Old == vars.Acts.SonicCD["CollisionChaos1"] || vars.Act.Old == vars.Acts.SonicCD["CollisionChaos1Past"] || vars.Act.Old == vars.Acts.SonicCD["CollisionChaos1GoodFuture"] || vars.Act.Old == vars.Acts.SonicCD["CollisionChaos1BadFuture"]) && (vars.Act.Current == vars.Acts.SonicCD["CollisionChaos2"] || vars.Act.Current == vars.Acts.SonicCD["CollisionChaos2Past"] || vars.Act.Current == vars.Acts.SonicCD["CollisionChaos2GoodFuture"] || vars.Act.Current == vars.Acts.SonicCD["CollisionChaos2BadFuture"]) },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["SonicCD"] && (vars.Act.Old == vars.Acts.SonicCD["CollisionChaos2"] || vars.Act.Old == vars.Acts.SonicCD["CollisionChaos2Past"] || vars.Act.Old == vars.Acts.SonicCD["CollisionChaos2GoodFuture"] || vars.Act.Old == vars.Acts.SonicCD["CollisionChaos2BadFuture"]) && (vars.Act.Current == vars.Acts.SonicCD["CollisionChaos3GoodFuture"] || vars.Act.Current == vars.Acts.SonicCD["CollisionChaos3BadFuture"]) },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["SonicCD"] && (vars.Act.Old == vars.Acts.SonicCD["CollisionChaos3GoodFuture"] || vars.Act.Old == vars.Acts.SonicCD["CollisionChaos3BadFuture"]) && (vars.Act.Current == vars.Acts.SonicCD["TidalTempest1"] || vars.Act.Current == vars.Acts.SonicCD["TidalTempest1Past"] || vars.Act.Current == vars.Acts.SonicCD["TidalTempest1GoodFuture"] || vars.Act.Current == vars.Acts.SonicCD["TidalTempest1BadFuture"]) },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["SonicCD"] && (vars.Act.Old == vars.Acts.SonicCD["TidalTempest1"] || vars.Act.Old == vars.Acts.SonicCD["TidalTempest1Past"] || vars.Act.Old == vars.Acts.SonicCD["TidalTempest1GoodFuture"] || vars.Act.Old == vars.Acts.SonicCD["TidalTempest1BadFuture"]) && (vars.Act.Current == vars.Acts.SonicCD["TidalTempest2"] || vars.Act.Current == vars.Acts.SonicCD["TidalTempest2Past"] || vars.Act.Current == vars.Acts.SonicCD["TidalTempest2GoodFuture"] || vars.Act.Current == vars.Acts.SonicCD["TidalTempest2BadFuture"]) },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["SonicCD"] && (vars.Act.Old == vars.Acts.SonicCD["TidalTempest2"] || vars.Act.Old == vars.Acts.SonicCD["TidalTempest2Past"] || vars.Act.Old == vars.Acts.SonicCD["TidalTempest2GoodFuture"] || vars.Act.Old == vars.Acts.SonicCD["TidalTempest2BadFuture"]) && (vars.Act.Current == vars.Acts.SonicCD["TidalTempest3GoodFuture"] || vars.Act.Current == vars.Acts.SonicCD["TidalTempest3BadFuture"]) },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["SonicCD"] && (vars.Act.Old == vars.Acts.SonicCD["TidalTempest3GoodFuture"] || vars.Act.Old == vars.Acts.SonicCD["TidalTempest3BadFuture"]) && (vars.Act.Current == vars.Acts.SonicCD["QuartzQuadrant1"] || vars.Act.Current == vars.Acts.SonicCD["QuartzQuadrant1Past"] || vars.Act.Current == vars.Acts.SonicCD["QuartzQuadrant1GoodFuture"] || vars.Act.Current == vars.Acts.SonicCD["QuartzQuadrant1BadFuture"]) },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["SonicCD"] && (vars.Act.Old == vars.Acts.SonicCD["QuartzQuadrant1"] || vars.Act.Old == vars.Acts.SonicCD["QuartzQuadrant1Past"] || vars.Act.Old == vars.Acts.SonicCD["QuartzQuadrant1GoodFuture"] || vars.Act.Old == vars.Acts.SonicCD["QuartzQuadrant1BadFuture"]) && (vars.Act.Current == vars.Acts.SonicCD["QuartzQuadrant2"] || vars.Act.Current == vars.Acts.SonicCD["QuartzQuadrant2Past"] || vars.Act.Current == vars.Acts.SonicCD["QuartzQuadrant2GoodFuture"] || vars.Act.Current == vars.Acts.SonicCD["QuartzQuadrant2BadFuture"]) },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["SonicCD"] && (vars.Act.Old == vars.Acts.SonicCD["QuartzQuadrant2"] || vars.Act.Old == vars.Acts.SonicCD["QuartzQuadrant2Past"] || vars.Act.Old == vars.Acts.SonicCD["QuartzQuadrant2GoodFuture"] || vars.Act.Old == vars.Acts.SonicCD["QuartzQuadrant2BadFuture"]) && (vars.Act.Current == vars.Acts.SonicCD["QuartzQuadrant3GoodFuture"] || vars.Act.Current == vars.Acts.SonicCD["QuartzQuadrant3BadFuture"]) },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["SonicCD"] && (vars.Act.Old == vars.Acts.SonicCD["QuartzQuadrant3GoodFuture"] || vars.Act.Old == vars.Acts.SonicCD["QuartzQuadrant3BadFuture"]) && (vars.Act.Current == vars.Acts.SonicCD["WackyWorkbench1"] || vars.Act.Current == vars.Acts.SonicCD["WackyWorkbench1Past"] || vars.Act.Current == vars.Acts.SonicCD["WackyWorkbench1GoodFuture"] || vars.Act.Current == vars.Acts.SonicCD["WackyWorkbench1BadFuture"]) },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["SonicCD"] && (vars.Act.Old == vars.Acts.SonicCD["WackyWorkbench1"] || vars.Act.Old == vars.Acts.SonicCD["WackyWorkbench1Past"] || vars.Act.Old == vars.Acts.SonicCD["WackyWorkbench1GoodFuture"] || vars.Act.Old == vars.Acts.SonicCD["WackyWorkbench1BadFuture"]) && (vars.Act.Current == vars.Acts.SonicCD["WackyWorkbench2"] || vars.Act.Current == vars.Acts.SonicCD["WackyWorkbench2Past"] || vars.Act.Current == vars.Acts.SonicCD["WackyWorkbench2GoodFuture"] || vars.Act.Current == vars.Acts.SonicCD["WackyWorkbench2BadFuture"]) },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["SonicCD"] && (vars.Act.Old == vars.Acts.SonicCD["WackyWorkbench2"] || vars.Act.Old == vars.Acts.SonicCD["WackyWorkbench2Past"] || vars.Act.Old == vars.Acts.SonicCD["WackyWorkbench2GoodFuture"] || vars.Act.Old == vars.Acts.SonicCD["WackyWorkbench2BadFuture"]) && (vars.Act.Current == vars.Acts.SonicCD["WackyWorkbench3GoodFuture"] || vars.Act.Current == vars.Acts.SonicCD["WackyWorkbench3BadFuture"]) },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["SonicCD"] && (vars.Act.Old == vars.Acts.SonicCD["WackyWorkbench3GoodFuture"] || vars.Act.Old == vars.Acts.SonicCD["WackyWorkbench3BadFuture"]) && (vars.Act.Current == vars.Acts.SonicCD["StardustSpeedway1"] || vars.Act.Current == vars.Acts.SonicCD["StardustSpeedway1Past"] || vars.Act.Current == vars.Acts.SonicCD["StardustSpeedway1GoodFuture"] || vars.Act.Current == vars.Acts.SonicCD["StardustSpeedway1BadFuture"]) },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["SonicCD"] && (vars.Act.Old == vars.Acts.SonicCD["StardustSpeedway1"] || vars.Act.Old == vars.Acts.SonicCD["StardustSpeedway1Past"] || vars.Act.Old == vars.Acts.SonicCD["StardustSpeedway1GoodFuture"] || vars.Act.Old == vars.Acts.SonicCD["StardustSpeedway1BadFuture"]) && (vars.Act.Current == vars.Acts.SonicCD["StardustSpeedway2"] || vars.Act.Current == vars.Acts.SonicCD["StardustSpeedway2Past"] || vars.Act.Current == vars.Acts.SonicCD["StardustSpeedway2GoodFuture"] || vars.Act.Current == vars.Acts.SonicCD["StardustSpeedway2BadFuture"]) },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["SonicCD"] && (vars.Act.Old == vars.Acts.SonicCD["StardustSpeedway2"] || vars.Act.Old == vars.Acts.SonicCD["StardustSpeedway2Past"] || vars.Act.Old == vars.Acts.SonicCD["StardustSpeedway2GoodFuture"] || vars.Act.Old == vars.Acts.SonicCD["StardustSpeedway2BadFuture"]) && (vars.Act.Current == vars.Acts.SonicCD["StardustSpeedway3GoodFuture"] || vars.Act.Current == vars.Acts.SonicCD["StardustSpeedway3BadFuture"]) },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["SonicCD"] && (vars.Act.Old == vars.Acts.SonicCD["StardustSpeedway3GoodFuture"] || vars.Act.Old == vars.Acts.SonicCD["StardustSpeedway3BadFuture"]) && (vars.Act.Current == vars.Acts.SonicCD["MetallicMadness1"] || vars.Act.Current == vars.Acts.SonicCD["MetallicMadness1Past"] || vars.Act.Current == vars.Acts.SonicCD["MetallicMadness1GoodFuture"] || vars.Act.Current == vars.Acts.SonicCD["MetallicMadness1BadFuture"]) },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["SonicCD"] && (vars.Act.Old == vars.Acts.SonicCD["MetallicMadness1"] || vars.Act.Old == vars.Acts.SonicCD["MetallicMadness1Past"] || vars.Act.Old == vars.Acts.SonicCD["MetallicMadness1GoodFuture"] || vars.Act.Old == vars.Acts.SonicCD["MetallicMadness1BadFuture"]) && (vars.Act.Current == vars.Acts.SonicCD["MetallicMadness2"] || vars.Act.Current == vars.Acts.SonicCD["MetallicMadness2Past"] || vars.Act.Current == vars.Acts.SonicCD["MetallicMadness2GoodFuture"] || vars.Act.Current == vars.Acts.SonicCD["MetallicMadness2BadFuture"]) },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["SonicCD"] && (vars.Act.Old == vars.Acts.SonicCD["MetallicMadness2"] || vars.Act.Old == vars.Acts.SonicCD["MetallicMadness2Past"] || vars.Act.Old == vars.Acts.SonicCD["MetallicMadness2GoodFuture"] || vars.Act.Old == vars.Acts.SonicCD["MetallicMadness2BadFuture"]) && (vars.Act.Current == vars.Acts.SonicCD["MetallicMadness3GoodFuture"] || vars.Act.Current == vars.Acts.SonicCD["MetallicMadness3BadFuture"]) },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["SonicCD"] && vars.Act.Current == vars.Acts.SonicCD["Ending"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic2"] && vars.Act.Old == vars.Acts.Sonic2["EmeraldHill1"] && vars.Act.Current == vars.Acts.Sonic2["EmeraldHill2"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic2"] && vars.Act.Old == vars.Acts.Sonic2["EmeraldHill2"] && vars.Act.Current == vars.Acts.Sonic2["ChemicalPlant1"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic2"] && vars.Act.Old == vars.Acts.Sonic2["ChemicalPlant1"] && vars.Act.Current == vars.Acts.Sonic2["ChemicalPlant2"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic2"] && vars.Act.Old == vars.Acts.Sonic2["ChemicalPlant2"] && vars.Act.Current == vars.Acts.Sonic2["AquaticRuin1"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic2"] && vars.Act.Old == vars.Acts.Sonic2["AquaticRuin1"] && vars.Act.Current == vars.Acts.Sonic2["AquaticRuin2"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic2"] && vars.Act.Old == vars.Acts.Sonic2["AquaticRuin2"] && vars.Act.Current == vars.Acts.Sonic2["CasinoNight1"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic2"] && vars.Act.Old == vars.Acts.Sonic2["CasinoNight1"] && vars.Act.Current == vars.Acts.Sonic2["CasinoNight2"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic2"] && vars.Act.Old == vars.Acts.Sonic2["CasinoNight2"] && vars.Act.Current == vars.Acts.Sonic2["HillTop1"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic2"] && vars.Act.Old == vars.Acts.Sonic2["HillTop1"] && vars.Act.Current == vars.Acts.Sonic2["HillTop2"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic2"] && vars.Act.Old == vars.Acts.Sonic2["HillTop2"] && vars.Act.Current == vars.Acts.Sonic2["MysticCave1"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic2"] && vars.Act.Old == vars.Acts.Sonic2["MysticCave1"] && vars.Act.Current == vars.Acts.Sonic2["MysticCave2"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic2"] && vars.Act.Old == vars.Acts.Sonic2["MysticCave2"] && vars.Act.Current == vars.Acts.Sonic2["OilOcean1"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic2"] && vars.Act.Old == vars.Acts.Sonic2["OilOcean1"] && vars.Act.Current == vars.Acts.Sonic2["OilOcean2"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic2"] && vars.Act.Old == vars.Acts.Sonic2["OilOcean2"] && vars.Act.Current == vars.Acts.Sonic2["Metropolis1"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic2"] && vars.Act.Old == vars.Acts.Sonic2["Metropolis1"] && vars.Act.Current == vars.Acts.Sonic2["Metropolis2"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic2"] && vars.Act.Old == vars.Acts.Sonic2["Metropolis2"] && vars.Act.Current == vars.Acts.Sonic2["Metropolis3"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic2"] && vars.Act.Old == vars.Acts.Sonic2["Metropolis3"] && vars.Act.Current == vars.Acts.Sonic2["SkyChase"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic2"] && vars.Act.Old == vars.Acts.Sonic2["SkyChase"] && vars.Act.Current == vars.Acts.Sonic2["WingFortress"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic2"] && vars.Act.Old == vars.Acts.Sonic2["WingFortress"] && vars.Act.Current == vars.Acts.Sonic2["DeathEgg"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic2"] && vars.Act.Current == vars.Acts.Sonic2["Ending"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic3"] && vars.Act.Old == vars.Acts.Sonic3["AngelIsland1"] && vars.Act.Current == vars.Acts.Sonic3["AngelIsland2"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic3"] && vars.Act.Old == vars.Acts.Sonic3["AngelIsland2"] && vars.Act.Current == vars.Acts.Sonic3["Hydrocity1"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic3"] && vars.Act.Old == vars.Acts.Sonic3["Hydrocity1"] && vars.Act.Current == vars.Acts.Sonic3["Hydrocity2"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic3"] && vars.Act.Old == vars.Acts.Sonic3["Hydrocity2"] && vars.Act.Current == vars.Acts.Sonic3["MarbleGarden1"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic3"] && vars.Act.Old == vars.Acts.Sonic3["MarbleGarden1"] && vars.Act.Current == vars.Acts.Sonic3["MarbleGarden2"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic3"] && vars.Act.Old == vars.Acts.Sonic3["MarbleGarden2"] && vars.Act.Current == vars.Acts.Sonic3["CarnivalNight1"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic3"] && vars.Act.Old == vars.Acts.Sonic3["CarnivalNight1"] && vars.Act.Current == vars.Acts.Sonic3["CarnivalNight2"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic3"] && vars.Act.Old == vars.Acts.Sonic3["CarnivalNight2"] && vars.Act.Current == vars.Acts.Sonic3["IceCap1"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic3"] && vars.Act.Old == vars.Acts.Sonic3["IceCap1"] && vars.Act.Current == vars.Acts.Sonic3["IceCap2"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic3"] && vars.Act.Old == vars.Acts.Sonic3["IceCap2"] && vars.Act.Current == vars.Acts.Sonic3["LaunchBase1"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic3"] && vars.Act.Old == vars.Acts.Sonic3["LaunchBase1"] && vars.Act.Current == vars.Acts.Sonic3["LaunchBase2"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic3"] && vars.Act.Old == vars.Acts.Sonic3["LaunchBase1"] && vars.Act.Current == vars.Acts.Sonic3["MushroomHill1"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic3"] && vars.Act.Old == vars.Acts.Sonic3["MushroomHill1"] && vars.Act.Current == vars.Acts.Sonic3["MushroomHill2"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic3"] && vars.Act.Old == vars.Acts.Sonic3["MushroomHill2"] && vars.Act.Current == vars.Acts.Sonic3["FlyingBattery1"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic3"] && vars.Act.Old == vars.Acts.Sonic3["FlyingBattery1"] && vars.Act.Current == vars.Acts.Sonic3["FlyingBattery2"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic3"] && vars.Act.Old == vars.Acts.Sonic3["FlyingBattery2"] && vars.Act.Current == vars.Acts.Sonic3["Sandopolis1"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic3"] && vars.Act.Old == vars.Acts.Sonic3["Sandopolis1"] && vars.Act.Current == vars.Acts.Sonic3["Sandopolis2"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic3"] && vars.Act.Old == vars.Acts.Sonic3["Sandopolis2"] && vars.Act.Current == vars.Acts.Sonic3["LavaReef1"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic3"] && vars.Act.Old == vars.Acts.Sonic3["LavaReef1"] && vars.Act.Current == vars.Acts.Sonic3["LavaReef2"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic3"] && (vars.Act.Old == vars.Acts.Sonic3["LavaReef2"] || vars.Act.Old == vars.Acts.Sonic3["LavaReefBoss"]) && vars.Act.Current == vars.Acts.Sonic3["HiddenPalace"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic3"] && vars.Act.Old == vars.Acts.Sonic3["HiddenPalace"] && (vars.Act.Current == vars.Acts.Sonic3["SkySanctuary"] || vars.Act.Current == vars.Acts.Sonic3["SkySanctuaryKnuckles"]) },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic3"] && ((vars.Act.Old == vars.Acts.Sonic3["SkySanctuary"] && vars.Act.Current == vars.Acts.Sonic3["DeathEgg1"]) || (vars.Act.Old == vars.Acts.Sonic3["SkySanctuaryKnuckles"] && vars.Act.Current == vars.Acts.Sonic3["Ending"])) },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic3"] && vars.Act.Old == vars.Acts.Sonic3["DeathEgg1"] && vars.Act.Current == vars.Acts.Sonic3["DeathEgg2"] },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic3"] && vars.Act.Old == vars.Acts.Sonic3["DeathEggBoss"] && (vars.Act.Current == vars.Acts.Sonic3["DoomsDay"] || vars.Act.Current == vars.Acts.Sonic3["Ending"]) },
        { i++.ToString(), () => vars.watchers["Game"].Current == vars.Game["Sonic3"] && vars.Act.Old == vars.Acts.Sonic3["DoomsDay"] && vars.Act.Current == vars.Acts.Sonic3["Ending"] }
    };
}

update
{
    // Update the main watchers variable
    vars.watchers.UpdateAll(game);

    vars.Act.Old = vars.Act.Current;
    // Filter out invalid Acts
    if ((vars.watchers["Game"].Current == vars.Game["Sonic1"] && vars.Acts.Sonic1.ContainsValue(vars.watchers["Act"].Current)) ||
        (vars.watchers["Game"].Current == vars.Game["SonicCD"] && vars.Acts.SonicCD.ContainsValue(vars.watchers["Act"].Current)) ||
        (vars.watchers["Game"].Current == vars.Game["Sonic2"] && vars.Acts.Sonic2.ContainsValue(vars.watchers["Act"].Current)) ||
        (vars.watchers["Game"].Current == vars.Game["Sonic3"] && vars.Acts.Sonic3.ContainsValue(vars.watchers["Act"].Current)))
            vars.Act.Current = vars.watchers["Act"].Current;
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
        return settings["s3start"] && vars.watchers["Act"].Old == 2 && vars.watchers["Act"].Current == 15 && vars.watchers["Sonic3SaveSlot"].Current >= 65 && vars.watchers["Sonic3SaveSlot"].Current >= 73;
    }
}

split
{
    if (vars.Act.Old != vars.Act.Current)
    {
        foreach (var entry in vars.SplitBools)
        {
            if (entry.Value())
            {
                if (settings[entry.Key])
                {
                    return true;
                }
            }
        }
    }
}