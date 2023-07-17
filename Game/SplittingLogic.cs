using LiveSplit.UI.Components;
using System;

namespace LiveSplit.SonicOrigins
{
    partial class SonicOriginsComponent : LogicComponent
    {
        private bool Start()
        {
            if (watchers.StoryStartFlag && watchers.ActID.Current == LevelID.Sonic1_GreenHillAct1 && watchers.GameMode.Current == GameMode.Story)
            {
                watchers.StoryStartFlag = false;
                if (Settings.Story_Start)
                    return true;
            }
            else if (watchers.Game.Current == Game.Sonic1 && (watchers.GameMode.Current == GameMode.Classic || watchers.GameMode.Current == GameMode.Anniversary || watchers.GameMode.Current == GameMode.Mirror) && Settings.Sonic1_Start && watchers.StartTrigger.Current && !watchers.StartTrigger.Old)
                return true;
            else if (watchers.Game.Current == Game.SonicCD && (watchers.GameMode.Current == GameMode.Classic || watchers.GameMode.Current == GameMode.Anniversary || watchers.GameMode.Current == GameMode.Mirror) && Settings.SonicCD_Start && watchers.StartTrigger.Current && !watchers.StartTrigger.Old)
                return true;
            else if (watchers.Game.Current == Game.Sonic2 && (watchers.GameMode.Current == GameMode.Classic || watchers.GameMode.Current == GameMode.Anniversary || watchers.GameMode.Current == GameMode.Mirror) && Settings.Sonic2_Start && watchers.StartTrigger.Current && !watchers.StartTrigger.Old)
                return true;
            else if (watchers.Game.Current == Game.Sonic3 && (watchers.GameMode.Current == GameMode.Classic || watchers.GameMode.Current == GameMode.Anniversary || watchers.GameMode.Current == GameMode.Mirror) && Settings.Sonic3_Start && watchers.StartTrigger.Current && !watchers.StartTrigger.Old)
                return true;

            return false;
        }

        private bool Split()
        {
            if (watchers.DemoMode.Current)
                return false;

            if (watchers.GameMode.Current == GameMode.Classic || watchers.GameMode.Current == GameMode.Mirror || watchers.GameMode.Current == GameMode.Anniversary || watchers.GameMode.Current == GameMode.Story)
            {
                return watchers.ActID.Old switch
                {
                    LevelID.Sonic1_GreenHillAct1 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_GreenHill1 : Settings.Sonic1_GreenHill1) && watchers.ActID.Current == LevelID.Sonic1_GreenHillAct2,
                    LevelID.Sonic1_GreenHillAct2 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_GreenHill2 : Settings.Sonic1_GreenHill2) && watchers.ActID.Current == LevelID.Sonic1_GreenHillAct3,
                    LevelID.Sonic1_GreenHillAct3 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_GreenHill3 : Settings.Sonic1_GreenHill3) && watchers.ActID.Current == LevelID.Sonic1_MarbleAct1,
                    LevelID.Sonic1_MarbleAct1 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_Marble1 : Settings.Sonic1_Marble1) && watchers.ActID.Current == LevelID.Sonic1_MarbleAct2,
                    LevelID.Sonic1_MarbleAct2 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_Marble2 : Settings.Sonic1_Marble2) && watchers.ActID.Current == LevelID.Sonic1_MarbleAct3,
                    LevelID.Sonic1_MarbleAct3 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_Marble3 : Settings.Sonic1_Marble3) && watchers.ActID.Current == LevelID.Sonic1_SpringYardAct1,
                    LevelID.Sonic1_SpringYardAct1 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_SpringYard1 : Settings.Sonic1_SpringYard1) && watchers.ActID.Current == LevelID.Sonic1_SpringYardAct2,
                    LevelID.Sonic1_SpringYardAct2 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_SpringYard2 : Settings.Sonic1_SpringYard2) && watchers.ActID.Current == LevelID.Sonic1_SpringYardAct3,
                    LevelID.Sonic1_SpringYardAct3 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_SpringYard3 : Settings.Sonic1_SpringYard3) && watchers.ActID.Current == LevelID.Sonic1_LabyrinthAct1,
                    LevelID.Sonic1_LabyrinthAct1 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_Labyrinth1 : Settings.Sonic1_Labyrinth1) && watchers.ActID.Current == LevelID.Sonic1_LabyrinthAct2,
                    LevelID.Sonic1_LabyrinthAct2 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_Labyrinth2 : Settings.Sonic1_Labyrinth2) && watchers.ActID.Current == LevelID.Sonic1_LabyrinthAct3,
                    LevelID.Sonic1_LabyrinthAct3 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_Labyrinth3 : Settings.Sonic1_Labyrinth3) && watchers.ActID.Current == LevelID.Sonic1_StarLightAct1,
                    LevelID.Sonic1_StarLightAct1 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_StarLight1 : Settings.Sonic1_StarLight1) && watchers.ActID.Current == LevelID.Sonic1_StarLightAct2,
                    LevelID.Sonic1_StarLightAct2 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_StarLight2 : Settings.Sonic1_StarLight2) && watchers.ActID.Current == LevelID.Sonic1_StarLightAct3,
                    LevelID.Sonic1_StarLightAct3 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_StarLight3 : Settings.Sonic1_StarLight3) && watchers.ActID.Current == LevelID.Sonic1_ScrapBrainAct1,
                    LevelID.Sonic1_ScrapBrainAct1 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_ScrapBrain1 : Settings.Sonic1_ScrapBrain1) && watchers.ActID.Current == LevelID.Sonic1_ScrapBrainAct2,
                    LevelID.Sonic1_ScrapBrainAct2 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_ScrapBrain2 : Settings.Sonic1_ScrapBrain2) && watchers.ActID.Current == LevelID.Sonic1_ScrapBrainAct3,
                    LevelID.Sonic1_ScrapBrainAct3 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_ScrapBrain3 : Settings.Sonic1_ScrapBrain3) && watchers.ActID.Current == LevelID.Sonic1_FinalZone,
                    LevelID.Sonic1_FinalZone => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_FinalZone : Settings.Sonic1_FinalZone) && watchers.ActID.Current == LevelID.Sonic1_Ending,
                    LevelID.Sonic2_EmeraldHillAct1 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_EmeraldHill1 : Settings.Sonic2_EmeraldHill1) && watchers.ActID.Current == LevelID.Sonic2_EmeraldHillAct2,
                    LevelID.Sonic2_EmeraldHillAct2 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_EmeraldHill2 : Settings.Sonic2_EmeraldHill2) && watchers.ActID.Current == LevelID.Sonic2_ChemicalPlantAct1,
                    LevelID.Sonic2_ChemicalPlantAct1 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_ChemicalPlant1 : Settings.Sonic2_ChemicalPlant1) && watchers.ActID.Current == LevelID.Sonic2_ChemicalPlantAct2,
                    LevelID.Sonic2_ChemicalPlantAct2 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_ChemicalPlant2 : Settings.Sonic2_ChemicalPlant2) && watchers.ActID.Current == LevelID.Sonic2_AquaticRuinAct1,
                    LevelID.Sonic2_AquaticRuinAct1 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_AquaticRuin1 : Settings.Sonic2_AquaticRuin1) && watchers.ActID.Current == LevelID.Sonic2_AquaticRuinAct2,
                    LevelID.Sonic2_AquaticRuinAct2 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_AquaticRuin2 : Settings.Sonic2_AquaticRuin2) && watchers.ActID.Current == LevelID.Sonic2_CasinoNightAct1,
                    LevelID.Sonic2_CasinoNightAct1 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_CasinoNight1 : Settings.Sonic2_CasinoNight1) && watchers.ActID.Current == LevelID.Sonic2_CasinoNightAct2,
                    LevelID.Sonic2_CasinoNightAct2 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_CasinoNight2 : Settings.Sonic2_CasinoNight2) && watchers.ActID.Current == LevelID.Sonic2_HillTopAct1,
                    LevelID.Sonic2_HillTopAct1 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_HillTop1 : Settings.Sonic2_HillTop1) && watchers.ActID.Current == LevelID.Sonic2_HillTopAct2,
                    LevelID.Sonic2_HillTopAct2 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_HillTop2 : Settings.Sonic2_HillTop2) && watchers.ActID.Current == LevelID.Sonic2_MysticCaveAct1,
                    LevelID.Sonic2_MysticCaveAct1 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_MysticCave1 : Settings.Sonic2_MysticCave1) && watchers.ActID.Current == LevelID.Sonic2_MysticCaveAct2,
                    LevelID.Sonic2_MysticCaveAct2 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_MysticCave2 : Settings.Sonic2_MysticCave2) && watchers.ActID.Current == LevelID.Sonic2_OilOceanAct1,
                    LevelID.Sonic2_OilOceanAct1 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_OilOcean1 : Settings.Sonic2_OilOcean1) && watchers.ActID.Current == LevelID.Sonic2_OilOceanAct2,
                    LevelID.Sonic2_OilOceanAct2 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_OilOcean2 : Settings.Sonic2_OilOcean2) && watchers.ActID.Current == LevelID.Sonic2_MetropolisAct1,
                    LevelID.Sonic2_MetropolisAct1 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_Metropolis1 : Settings.Sonic2_Metropolis1) && watchers.ActID.Current == LevelID.Sonic2_MetropolisAct2,
                    LevelID.Sonic2_MetropolisAct2 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_Metropolis2 : Settings.Sonic2_Metropolis2) && watchers.ActID.Current == LevelID.Sonic2_MetropolisAct3,
                    LevelID.Sonic2_MetropolisAct3 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_Metropolis3 : Settings.Sonic2_Metropolis3) && watchers.ActID.Current == LevelID.Sonic2_SkyChase,
                    LevelID.Sonic2_SkyChase => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_SkyChase : Settings.Sonic2_SkyChase) && watchers.ActID.Current == LevelID.Sonic2_WingFortress,
                    LevelID.Sonic2_WingFortress => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_WingFortress : Settings.Sonic2_WingFortress) && watchers.ActID.Current == LevelID.Sonic2_DeathEgg,
                    LevelID.Sonic2_DeathEgg => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_DeathEgg : Settings.Sonic2_DeathEgg) && watchers.ActID.Current == LevelID.Sonic2_Ending,
                    LevelID.Sonic3_AngelIslandAct1 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_AngelIsland1 : Settings.Sonic3_AngelIsland1) && watchers.ActID.Current == LevelID.Sonic3_AngelIslandAct2,
                    LevelID.Sonic3_AngelIslandAct2 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_AngelIsland2 : Settings.Sonic3_AngelIsland2) && watchers.ActID.Current == LevelID.Sonic3_HydrocityAct1,
                    LevelID.Sonic3_HydrocityAct1 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_Hydrocity1 : Settings.Sonic3_Hydrocity1) && watchers.ActID.Current == LevelID.Sonic3_HydrocityAct2,
                    LevelID.Sonic3_HydrocityAct2 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_Hydrocity2 : Settings.Sonic3_Hydrocity2) && watchers.ActID.Current == LevelID.Sonic3_MarbleGardenAct1,
                    LevelID.Sonic3_MarbleGardenAct1 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_MarbleGarden1 : Settings.Sonic3_MarbleGarden1) && watchers.ActID.Current == LevelID.Sonic3_MarbleGardenAct2,
                    LevelID.Sonic3_MarbleGardenAct2 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_MarbleGarden2 : Settings.Sonic3_MarbleGarden2) && watchers.ActID.Current == LevelID.Sonic3_CarnivalNightAct1,
                    LevelID.Sonic3_CarnivalNightAct1 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_CarnivalNight1 : Settings.Sonic3_CarnivalNight1) && watchers.ActID.Current == LevelID.Sonic3_CarnivalNightAct2,
                    LevelID.Sonic3_CarnivalNightAct2 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_CarnivalNight2 : Settings.Sonic3_CarnivalNight2) && watchers.ActID.Current == LevelID.Sonic3_IceCapAct1,
                    LevelID.Sonic3_IceCapAct1 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_IceCap1 : Settings.Sonic3_IceCap1) && watchers.ActID.Current == LevelID.Sonic3_IceCapAct2,
                    LevelID.Sonic3_IceCapAct2 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_IceCap2 : Settings.Sonic3_IceCap2) && watchers.ActID.Current == LevelID.Sonic3_LaunchBaseAct1,
                    LevelID.Sonic3_LaunchBaseAct1 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_LaunchBase1 : Settings.Sonic3_LaunchBase1) && watchers.ActID.Current == LevelID.Sonic3_LaunchBaseAct2,
                    LevelID.Sonic3_LaunchBaseAct2 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_LaunchBase2 : Settings.Sonic3_LaunchBase2) && watchers.ActID.Current == LevelID.Sonic3_MushroomHillAct1,
                    LevelID.Sonic3_MushroomHillAct1 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_MushroomHill1 : Settings.Sonic3_MushroomHill1) && (watchers.ActID.Current == LevelID.Sonic3_MushroomHillAct2 || watchers.ActID.Current == LevelID.Sonic3_HiddenPalace),
                    LevelID.Sonic3_MushroomHillAct2 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_MushroomHill2 : Settings.Sonic3_MushroomHill2) && (watchers.ActID.Current == LevelID.Sonic3_FlyingBatteryAct1 || watchers.ActID.Current == LevelID.Sonic3_HiddenPalace),
                    LevelID.Sonic3_FlyingBatteryAct1 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_FlyingBattery1 : Settings.Sonic3_FlyingBattery1) && (watchers.ActID.Current == LevelID.Sonic3_FlyingBatteryAct2 || watchers.ActID.Current == LevelID.Sonic3_HiddenPalace),
                    LevelID.Sonic3_FlyingBatteryAct2 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_FlyingBattery2 : Settings.Sonic3_FlyingBattery2) && (watchers.ActID.Current == LevelID.Sonic3_SandopolisAct1 || watchers.ActID.Current == LevelID.Sonic3_HiddenPalace),
                    LevelID.Sonic3_SandopolisAct1 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_Sandopolis1 : Settings.Sonic3_Sandopolis1) && (watchers.ActID.Current == LevelID.Sonic3_SandopolisAct2 || watchers.ActID.Current == LevelID.Sonic3_HiddenPalace),
                    LevelID.Sonic3_SandopolisAct2 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_Sandopolis2 : Settings.Sonic3_Sandopolis2) && (watchers.ActID.Current == LevelID.Sonic3_LavaReefAct1 || watchers.ActID.Current == LevelID.Sonic3_HiddenPalace),
                    LevelID.Sonic3_LavaReefAct1 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_LavaReef1 : Settings.Sonic3_LavaReef1) && (watchers.ActID.Current == LevelID.Sonic3_LavaReefAct2 || watchers.ActID.Current == LevelID.Sonic3_HiddenPalace),
                    LevelID.Sonic3_LavaReefAct2 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_LavaReef2 : Settings.Sonic3_LavaReef2) && watchers.ActID.Current == LevelID.Sonic3_HiddenPalace,
                    LevelID.Sonic3_HiddenPalace => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_HiddenPalace : Settings.Sonic3_HiddenPalace) && watchers.ActID.Current == LevelID.Sonic3_SkySanctuary,
                    LevelID.Sonic3_SkySanctuary => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_SkySanctuary : Settings.Sonic3_SkySanctuary) && (watchers.ActID.Current == LevelID.Sonic3_DeathEggAct1 || watchers.ActID.Current == LevelID.Sonic3_Ending),
                    LevelID.Sonic3_DeathEggAct1 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_DeathEgg1 : Settings.Sonic3_DeathEgg1) && watchers.ActID.Current == LevelID.Sonic3_DeathEggAct2,
                    LevelID.Sonic3_DeathEggAct2 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_DeathEgg2 : Settings.Sonic3_DeathEgg2) && (watchers.ActID.Current == LevelID.Sonic3_Doomsday || watchers.ActID.Current == LevelID.Sonic3_Ending),
                    LevelID.Sonic3_Doomsday => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_DeathEgg2 : Settings.Sonic3_DeathEgg2) && watchers.ActID.Current == LevelID.Sonic3_Ending,
                    LevelID.SonicCD_PalmtreePanicAct1 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_PalmtreePanic1 : Settings.SonicCD_PalmtreePanic1) && watchers.ActID.Current == LevelID.SonicCD_PalmtreePanicAct2,
                    LevelID.SonicCD_PalmtreePanicAct2 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_PalmtreePanic2 : Settings.SonicCD_PalmtreePanic2) && watchers.ActID.Current == LevelID.SonicCD_PalmtreePanicAct3,
                    LevelID.SonicCD_PalmtreePanicAct3 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_PalmtreePanic3 : Settings.SonicCD_PalmtreePanic3) && watchers.ActID.Current == LevelID.SonicCD_CollisionChaosAct1,
                    LevelID.SonicCD_CollisionChaosAct1 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_CollisionChaos1 : Settings.SonicCD_CollisionChaos1) && watchers.ActID.Current == LevelID.SonicCD_CollisionChaosAct2,
                    LevelID.SonicCD_CollisionChaosAct2 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_CollisionChaos2 : Settings.SonicCD_CollisionChaos2) && watchers.ActID.Current == LevelID.SonicCD_CollisionChaosAct3,
                    LevelID.SonicCD_CollisionChaosAct3 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_CollisionChaos3 : Settings.SonicCD_CollisionChaos3) && watchers.ActID.Current == LevelID.SonicCD_TidalTempestAct1,
                    LevelID.SonicCD_TidalTempestAct1 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_TidalTempest1 : Settings.SonicCD_TidalTempest1) && watchers.ActID.Current == LevelID.SonicCD_TidalTempestAct2,
                    LevelID.SonicCD_TidalTempestAct2 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_TidalTempest2 : Settings.SonicCD_TidalTempest2) && watchers.ActID.Current == LevelID.SonicCD_TidalTempestAct3,
                    LevelID.SonicCD_TidalTempestAct3 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_TidalTempest3 : Settings.SonicCD_TidalTempest3) && watchers.ActID.Current == LevelID.SonicCD_QuartzQuadrantAct1,
                    LevelID.SonicCD_QuartzQuadrantAct1 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_QuartzQuadrant1 : Settings.SonicCD_QuartzQuadrant1) && watchers.ActID.Current == LevelID.SonicCD_QuartzQuadrantAct2,
                    LevelID.SonicCD_QuartzQuadrantAct2 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_QuartzQuadrant2 : Settings.SonicCD_QuartzQuadrant2) && watchers.ActID.Current == LevelID.SonicCD_QuartzQuadrantAct3,
                    LevelID.SonicCD_QuartzQuadrantAct3 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_QuartzQuadrant3 : Settings.SonicCD_QuartzQuadrant3) && watchers.ActID.Current == LevelID.SonicCD_WackyWorkbenchAct1,
                    LevelID.SonicCD_WackyWorkbenchAct1 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_WackyWorkbench1 : Settings.SonicCD_WackyWorkbench1) && watchers.ActID.Current == LevelID.SonicCD_WackyWorkbenchAct2,
                    LevelID.SonicCD_WackyWorkbenchAct2 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_WackyWorkbench2 : Settings.SonicCD_WackyWorkbench2) && watchers.ActID.Current == LevelID.SonicCD_WackyWorkbenchAct3,
                    LevelID.SonicCD_WackyWorkbenchAct3 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_WackyWorkbench3 : Settings.SonicCD_WackyWorkbench3) && watchers.ActID.Current == LevelID.SonicCD_StardustSpeedwayAct1,
                    LevelID.SonicCD_StardustSpeedwayAct1 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_StardustSpeedway1 : Settings.SonicCD_StardustSpeedway1) && watchers.ActID.Current == LevelID.SonicCD_StardustSpeedwayAct2,
                    LevelID.SonicCD_StardustSpeedwayAct2 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_StardustSpeedway2 : Settings.SonicCD_StardustSpeedway2) && watchers.ActID.Current == LevelID.SonicCD_StardustSpeedwayAct3,
                    LevelID.SonicCD_StardustSpeedwayAct3 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_StardustSpeedway3 : Settings.SonicCD_StardustSpeedway3) && watchers.ActID.Current == LevelID.SonicCD_MetallicMadnessAct1,
                    LevelID.SonicCD_MetallicMadnessAct1 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_MetallicMadness1 : Settings.SonicCD_MetallicMadness1) && watchers.ActID.Current == LevelID.SonicCD_MetallicMadnessAct2,
                    LevelID.SonicCD_MetallicMadnessAct2 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_MetallicMadness2 : Settings.SonicCD_MetallicMadness2) && watchers.ActID.Current == LevelID.SonicCD_MetallicMadnessAct3,
                    LevelID.SonicCD_MetallicMadnessAct3 => (watchers.GameMode.Current == GameMode.Story ? Settings.Story_MetallicMadness3 : Settings.SonicCD_MetallicMadness3) && watchers.ActID.Current == LevelID.SonicCD_Ending,
                    _ => false,
                };
            }

            return false;
        }

        private bool Reset()
        {
            return false;
        }

        private bool IsLoading()
        {
            return watchers.IsInTimeBonus.Current;
        }

        private TimeSpan? GameTime()
        {
            return null;
        }
    }
}