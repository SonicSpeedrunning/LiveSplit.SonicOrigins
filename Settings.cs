using System.Windows.Forms;
using System.Xml;

namespace LiveSplit.SonicOrigins
{
    public partial class Settings : UserControl
    {
        // Story mode
        public bool Story_Start { get; set; }
        public bool Story_GreenHill1 { get; set; }
        public bool Story_GreenHill2 { get; set; }
        public bool Story_GreenHill3 { get; set; }
        public bool Story_Marble1 { get; set; }
        public bool Story_Marble2 { get; set; }
        public bool Story_Marble3 { get; set; }
        public bool Story_SpringYard1 { get; set; }
        public bool Story_SpringYard2 { get; set; }
        public bool Story_SpringYard3 { get; set; }
        public bool Story_Labyrinth1 { get; set; }
        public bool Story_Labyrinth2 { get; set; }
        public bool Story_Labyrinth3 { get; set; }
        public bool Story_StarLight1 { get; set; }
        public bool Story_StarLight2 { get; set; }
        public bool Story_StarLight3 { get; set; }
        public bool Story_ScrapBrain1 { get; set; }
        public bool Story_ScrapBrain2 { get; set; }
        public bool Story_ScrapBrain3 { get; set; }
        public bool Story_FinalZone { get; set; }
        public bool Story_PalmtreePanic1 { get; set; }
        public bool Story_PalmtreePanic2 { get; set; }
        public bool Story_PalmtreePanic3 { get; set; }
        public bool Story_CollisionChaos1 { get; set; }
        public bool Story_CollisionChaos2 { get; set; }
        public bool Story_CollisionChaos3 { get; set; }
        public bool Story_TidalTempest1 { get; set; }
        public bool Story_TidalTempest2 { get; set; }
        public bool Story_TidalTempest3 { get; set; }
        public bool Story_QuartzQuadrant1 { get; set; }
        public bool Story_QuartzQuadrant2 { get; set; }
        public bool Story_QuartzQuadrant3 { get; set; }
        public bool Story_WackyWorkbench1 { get; set; }
        public bool Story_WackyWorkbench2 { get; set; }
        public bool Story_WackyWorkbench3 { get; set; }
        public bool Story_StardustSpeedway1 { get; set; }
        public bool Story_StardustSpeedway2 { get; set; }
        public bool Story_StardustSpeedway3 { get; set; }
        public bool Story_MetallicMadness1 { get; set; }
        public bool Story_MetallicMadness2 { get; set; }
        public bool Story_MetallicMadness3 { get; set; }
        public bool Story_EmeraldHill1 { get; set; }
        public bool Story_EmeraldHill2 { get; set; }
        public bool Story_ChemicalPlant1 { get; set; }
        public bool Story_ChemicalPlant2 { get; set; }
        public bool Story_AquaticRuin1 { get; set; }
        public bool Story_AquaticRuin2 { get; set; }
        public bool Story_CasinoNight1 { get; set; }
        public bool Story_CasinoNight2 { get; set; }
        public bool Story_HillTop1 { get; set; }
        public bool Story_HillTop2 { get; set; }
        public bool Story_MysticCave1 { get; set; }
        public bool Story_MysticCave2 { get; set; }
        public bool Story_OilOcean1 { get; set; }
        public bool Story_OilOcean2 { get; set; }
        public bool Story_Metropolis1 { get; set; }
        public bool Story_Metropolis2 { get; set; }
        public bool Story_Metropolis3 { get; set; }
        public bool Story_SkyChase { get; set; }
        public bool Story_WingFortress { get; set; }
        public bool Story_DeathEgg { get; set; }
        public bool Story_AngelIsland1 { get; set; }
        public bool Story_AngelIsland2 { get; set; }
        public bool Story_Hydrocity1 { get; set; }
        public bool Story_Hydrocity2 { get; set; }
        public bool Story_MarbleGarden1 { get; set; }
        public bool Story_MarbleGarden2 { get; set; }
        public bool Story_CarnivalNight1 { get; set; }
        public bool Story_CarnivalNight2 { get; set; }
        public bool Story_IceCap1 { get; set; }
        public bool Story_IceCap2 { get; set; }
        public bool Story_LaunchBase1 { get; set; }
        public bool Story_LaunchBase2 { get; set; }
        public bool Story_MushroomHill1 { get; set; }
        public bool Story_MushroomHill2 { get; set; }
        public bool Story_FlyingBattery1 { get; set; }
        public bool Story_FlyingBattery2 { get; set; }
        public bool Story_Sandopolis1 { get; set; }
        public bool Story_Sandopolis2 { get; set; }
        public bool Story_LavaReef1 { get; set; }
        public bool Story_LavaReef2 { get; set; }
        public bool Story_HiddenPalace { get; set; }
        public bool Story_SkySanctuary { get; set; }
        public bool Story_DeathEgg1 { get; set; }
        public bool Story_DeathEgg2 { get; set; }
        public bool Story_Doomsday { get; set; }

        // Sonic 1
        public bool Sonic1_Start { get; set; }
        public bool Sonic1_GreenHill1 { get; set; }
        public bool Sonic1_GreenHill2 { get; set; }
        public bool Sonic1_GreenHill3 { get; set; }
        public bool Sonic1_Marble1 { get; set; }
        public bool Sonic1_Marble2 { get; set; }
        public bool Sonic1_Marble3 { get; set; }
        public bool Sonic1_SpringYard1 { get; set; }
        public bool Sonic1_SpringYard2 { get; set; }
        public bool Sonic1_SpringYard3 { get; set; }
        public bool Sonic1_Labyrinth1 { get; set; }
        public bool Sonic1_Labyrinth2 { get; set; }
        public bool Sonic1_Labyrinth3 { get; set; }
        public bool Sonic1_StarLight1 { get; set; }
        public bool Sonic1_StarLight2 { get; set; }
        public bool Sonic1_StarLight3 { get; set; }
        public bool Sonic1_ScrapBrain1 { get; set; }
        public bool Sonic1_ScrapBrain2 { get; set; }
        public bool Sonic1_ScrapBrain3 { get; set; }
        public bool Sonic1_FinalZone { get; set; }

        // Sonic CD
        public bool SonicCD_Start { get; set; }
        public bool SonicCD_PalmtreePanic1 { get; set; }
        public bool SonicCD_PalmtreePanic2 { get; set; }
        public bool SonicCD_PalmtreePanic3 { get; set; }
        public bool SonicCD_CollisionChaos1 { get; set; }
        public bool SonicCD_CollisionChaos2 { get; set; }
        public bool SonicCD_CollisionChaos3 { get; set; }
        public bool SonicCD_TidalTempest1 { get; set; }
        public bool SonicCD_TidalTempest2 { get; set; }
        public bool SonicCD_TidalTempest3 { get; set; }
        public bool SonicCD_QuartzQuadrant1 { get; set; }
        public bool SonicCD_QuartzQuadrant2 { get; set; }
        public bool SonicCD_QuartzQuadrant3 { get; set; }
        public bool SonicCD_WackyWorkbench1 { get; set; }
        public bool SonicCD_WackyWorkbench2 { get; set; }
        public bool SonicCD_WackyWorkbench3 { get; set; }
        public bool SonicCD_StardustSpeedway1 { get; set; }
        public bool SonicCD_StardustSpeedway2 { get; set; }
        public bool SonicCD_StardustSpeedway3 { get; set; }
        public bool SonicCD_MetallicMadness1 { get; set; }
        public bool SonicCD_MetallicMadness2 { get; set; }
        public bool SonicCD_MetallicMadness3 { get; set; }

        // Sonic 2
        public bool Sonic2_Start { get; set; }
        public bool Sonic2_EmeraldHill1 { get; set; }
        public bool Sonic2_EmeraldHill2 { get; set; }
        public bool Sonic2_ChemicalPlant1 { get; set; }
        public bool Sonic2_ChemicalPlant2 { get; set; }
        public bool Sonic2_AquaticRuin1 { get; set; }
        public bool Sonic2_AquaticRuin2 { get; set; }
        public bool Sonic2_CasinoNight1 { get; set; }
        public bool Sonic2_CasinoNight2 { get; set; }
        public bool Sonic2_HillTop1 { get; set; }
        public bool Sonic2_HillTop2 { get; set; }
        public bool Sonic2_MysticCave1 { get; set; }
        public bool Sonic2_MysticCave2 { get; set; }
        public bool Sonic2_OilOcean1 { get; set; }
        public bool Sonic2_OilOcean2 { get; set; }
        public bool Sonic2_Metropolis1 { get; set; }
        public bool Sonic2_Metropolis2 { get; set; }
        public bool Sonic2_Metropolis3 { get; set; }
        public bool Sonic2_SkyChase { get; set; }
        public bool Sonic2_WingFortress { get; set; }
        public bool Sonic2_DeathEgg { get; set; }

        // Sonic 3
        public bool Sonic3_Start { get; set; }
        public bool Sonic3_AngelIsland1 { get; set; }
        public bool Sonic3_AngelIsland2 { get; set; }
        public bool Sonic3_Hydrocity1 { get; set; }
        public bool Sonic3_Hydrocity2 { get; set; }
        public bool Sonic3_MarbleGarden1 { get; set; }
        public bool Sonic3_MarbleGarden2 { get; set; }
        public bool Sonic3_CarnivalNight1 { get; set; }
        public bool Sonic3_CarnivalNight2 { get; set; }
        public bool Sonic3_IceCap1 { get; set; }
        public bool Sonic3_IceCap2 { get; set; }
        public bool Sonic3_LaunchBase1 { get; set; }
        public bool Sonic3_LaunchBase2 { get; set; }
        public bool Sonic3_MushroomHill1 { get; set; }
        public bool Sonic3_MushroomHill2 { get; set; }
        public bool Sonic3_FlyingBattery1 { get; set; }
        public bool Sonic3_FlyingBattery2 { get; set; }
        public bool Sonic3_Sandopolis1 { get; set; }
        public bool Sonic3_Sandopolis2 { get; set; }
        public bool Sonic3_LavaReef1 { get; set; }
        public bool Sonic3_LavaReef2 { get; set; }
        public bool Sonic3_HiddenPalace { get; set; }
        public bool Sonic3_SkySanctuary { get; set; }
        public bool Sonic3_DeathEgg1 { get; set; }
        public bool Sonic3_DeathEgg2 { get; set; }
        public bool Sonic3_Doomsday { get; set; }

        public Settings()
        {
            InitializeComponent();
            autosplitterVersion.Text = "Autosplitter version: v" + System.Diagnostics.FileVersionInfo.GetVersionInfo(System.Reflection.Assembly.GetExecutingAssembly().Location).FileVersion;

            // Story mode
            chkStory_Start.DataBindings.Add("Checked", this, "Story_Start", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_GreenHill1.DataBindings.Add("Checked", this, "Story_GreenHill1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_GreenHill2.DataBindings.Add("Checked", this, "Story_GreenHill2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_GreenHill3.DataBindings.Add("Checked", this, "Story_GreenHill3", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_Marble1.DataBindings.Add("Checked", this, "Story_Marble1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_Marble2.DataBindings.Add("Checked", this, "Story_Marble2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_Marble3.DataBindings.Add("Checked", this, "Story_Marble3", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_SpringYard1.DataBindings.Add("Checked", this, "Story_SpringYard1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_SpringYard2.DataBindings.Add("Checked", this, "Story_SpringYard2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_SpringYard3.DataBindings.Add("Checked", this, "Story_SpringYard3", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_Labyrinth1.DataBindings.Add("Checked", this, "Story_Labyrinth1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_Labyrinth2.DataBindings.Add("Checked", this, "Story_Labyrinth2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_Labyrinth3.DataBindings.Add("Checked", this, "Story_Labyrinth3", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_StarLight1.DataBindings.Add("Checked", this, "Story_StarLight1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_StarLight2.DataBindings.Add("Checked", this, "Story_StarLight2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_StarLight3.DataBindings.Add("Checked", this, "Story_StarLight3", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_ScrapBrain1.DataBindings.Add("Checked", this, "Story_ScrapBrain1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_ScrapBrain2.DataBindings.Add("Checked", this, "Story_ScrapBrain2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_ScrapBrain3.DataBindings.Add("Checked", this, "Story_ScrapBrain3", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_FinalZone.DataBindings.Add("Checked", this, "Story_FinalZone", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_PalmtreePanic1.DataBindings.Add("Checked", this, "Story_PalmtreePanic1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_PalmtreePanic2.DataBindings.Add("Checked", this, "Story_PalmtreePanic2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_PalmtreePanic3.DataBindings.Add("Checked", this, "Story_PalmtreePanic3", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_CollisionChaos1.DataBindings.Add("Checked", this, "Story_CollisionChaos1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_CollisionChaos2.DataBindings.Add("Checked", this, "Story_CollisionChaos2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_CollisionChaos3.DataBindings.Add("Checked", this, "Story_CollisionChaos3", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_TidalTempest1.DataBindings.Add("Checked", this, "Story_TidalTempest1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_TidalTempest2.DataBindings.Add("Checked", this, "Story_TidalTempest2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_TidalTempest3.DataBindings.Add("Checked", this, "Story_TidalTempest3", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_QuartzQuadrant1.DataBindings.Add("Checked", this, "Story_QuartzQuadrant1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_QuartzQuadrant2.DataBindings.Add("Checked", this, "Story_QuartzQuadrant2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_QuartzQuadrant3.DataBindings.Add("Checked", this, "Story_QuartzQuadrant3", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_WackyWorkbench1.DataBindings.Add("Checked", this, "Story_WackyWorkbench1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_WackyWorkbench2.DataBindings.Add("Checked", this, "Story_WackyWorkbench2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_WackyWorkbench3.DataBindings.Add("Checked", this, "Story_WackyWorkbench3", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_StardustSpeedway1.DataBindings.Add("Checked", this, "Story_StardustSpeedway1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_StardustSpeedway2.DataBindings.Add("Checked", this, "Story_StardustSpeedway2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_StardustSpeedway3.DataBindings.Add("Checked", this, "Story_StardustSpeedway3", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_MetallicMadness1.DataBindings.Add("Checked", this, "Story_MetallicMadness1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_MetallicMadness2.DataBindings.Add("Checked", this, "Story_MetallicMadness2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_MetallicMadness3.DataBindings.Add("Checked", this, "Story_MetallicMadness3", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_EmeraldHill1.DataBindings.Add("Checked", this, "Story_EmeraldHill1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_EmeraldHill2.DataBindings.Add("Checked", this, "Story_EmeraldHill2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_ChemicalPlant1.DataBindings.Add("Checked", this, "Story_ChemicalPlant1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_ChemicalPlant2.DataBindings.Add("Checked", this, "Story_ChemicalPlant2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_AquaticRuin1.DataBindings.Add("Checked", this, "Story_AquaticRuin1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_AquaticRuin2.DataBindings.Add("Checked", this, "Story_AquaticRuin2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_CasinoNight1.DataBindings.Add("Checked", this, "Story_CasinoNight1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_CasinoNight2.DataBindings.Add("Checked", this, "Story_CasinoNight2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_HillTop1.DataBindings.Add("Checked", this, "Story_HillTop1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_HillTop2.DataBindings.Add("Checked", this, "Story_HillTop2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_MysticCave1.DataBindings.Add("Checked", this, "Story_MysticCave1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_MysticCave2.DataBindings.Add("Checked", this, "Story_MysticCave2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_OilOcean1.DataBindings.Add("Checked", this, "Story_OilOcean1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_OilOcean2.DataBindings.Add("Checked", this, "Story_OilOcean2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_Metropolis1.DataBindings.Add("Checked", this, "Story_Metropolis1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_Metropolis2.DataBindings.Add("Checked", this, "Story_Metropolis2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_Metropolis3.DataBindings.Add("Checked", this, "Story_Metropolis3", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_SkyChase.DataBindings.Add("Checked", this, "Story_SkyChase", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_WingFortress.DataBindings.Add("Checked", this, "Story_WingFortress", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_DeathEgg.DataBindings.Add("Checked", this, "Story_DeathEgg", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_AngelIsland1.DataBindings.Add("Checked", this, "Story_AngelIsland1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_AngelIsland2.DataBindings.Add("Checked", this, "Story_AngelIsland2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_Hydrocity1.DataBindings.Add("Checked", this, "Story_Hydrocity1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_Hydrocity2.DataBindings.Add("Checked", this, "Story_Hydrocity2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_MarbleGarden1.DataBindings.Add("Checked", this, "Story_MarbleGarden1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_MarbleGarden2.DataBindings.Add("Checked", this, "Story_MarbleGarden2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_CarnivalNight1.DataBindings.Add("Checked", this, "Story_CarnivalNight1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_CarnivalNight2.DataBindings.Add("Checked", this, "Story_CarnivalNight2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_IceCap1.DataBindings.Add("Checked", this, "Story_IceCap1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_IceCap2.DataBindings.Add("Checked", this, "Story_IceCap2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_LaunchBase1.DataBindings.Add("Checked", this, "Story_LaunchBase1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_LaunchBase2.DataBindings.Add("Checked", this, "Story_LaunchBase2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_MushroomHill1.DataBindings.Add("Checked", this, "Story_MushroomHill1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_MushroomHill2.DataBindings.Add("Checked", this, "Story_MushroomHill2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_FlyingBattery1.DataBindings.Add("Checked", this, "Story_FlyingBattery1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_FlyingBattery2.DataBindings.Add("Checked", this, "Story_FlyingBattery2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_Sandopolis1.DataBindings.Add("Checked", this, "Story_Sandopolis1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_Sandopolis2.DataBindings.Add("Checked", this, "Story_Sandopolis2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_LavaReef1.DataBindings.Add("Checked", this, "Story_LavaReef1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_LavaReef2.DataBindings.Add("Checked", this, "Story_LavaReef2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_HiddenPalace.DataBindings.Add("Checked", this, "Story_HiddenPalace", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_SkySanctuary.DataBindings.Add("Checked", this, "Story_SkySanctuary", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_DeathEgg1.DataBindings.Add("Checked", this, "Story_DeathEgg1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_DeathEgg2.DataBindings.Add("Checked", this, "Story_DeathEgg2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkStory_Doomsday.DataBindings.Add("Checked", this, "Story_Doomsday", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic1_Start.DataBindings.Add("Checked", this, "Sonic1_Start", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic1_GreenHill1.DataBindings.Add("Checked", this, "Sonic1_GreenHill1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic1_GreenHill2.DataBindings.Add("Checked", this, "Sonic1_GreenHill2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic1_GreenHill3.DataBindings.Add("Checked", this, "Sonic1_GreenHill3", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic1_Marble1.DataBindings.Add("Checked", this, "Sonic1_Marble1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic1_Marble2.DataBindings.Add("Checked", this, "Sonic1_Marble2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic1_Marble3.DataBindings.Add("Checked", this, "Sonic1_Marble3", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic1_SpringYard1.DataBindings.Add("Checked", this, "Sonic1_SpringYard1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic1_SpringYard2.DataBindings.Add("Checked", this, "Sonic1_SpringYard2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic1_SpringYard3.DataBindings.Add("Checked", this, "Sonic1_SpringYard3", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic1_Labyrinth1.DataBindings.Add("Checked", this, "Sonic1_Labyrinth1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic1_Labyrinth2.DataBindings.Add("Checked", this, "Sonic1_Labyrinth2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic1_Labyrinth3.DataBindings.Add("Checked", this, "Sonic1_Labyrinth3", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic1_StarLight1.DataBindings.Add("Checked", this, "Sonic1_StarLight1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic1_StarLight2.DataBindings.Add("Checked", this, "Sonic1_StarLight2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic1_StarLight3.DataBindings.Add("Checked", this, "Sonic1_StarLight3", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic1_ScrapBrain1.DataBindings.Add("Checked", this, "Sonic1_ScrapBrain1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic1_ScrapBrain2.DataBindings.Add("Checked", this, "Sonic1_ScrapBrain2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic1_ScrapBrain3.DataBindings.Add("Checked", this, "Sonic1_ScrapBrain3", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic1_FinalZone.DataBindings.Add("Checked", this, "Sonic1_FinalZone", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonicCD_Start.DataBindings.Add("Checked", this, "SonicCD_Start", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonicCD_PalmtreePanic1.DataBindings.Add("Checked", this, "SonicCD_PalmtreePanic1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonicCD_PalmtreePanic2.DataBindings.Add("Checked", this, "SonicCD_PalmtreePanic2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonicCD_PalmtreePanic3.DataBindings.Add("Checked", this, "SonicCD_PalmtreePanic3", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonicCD_CollisionChaos1.DataBindings.Add("Checked", this, "SonicCD_CollisionChaos1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonicCD_CollisionChaos2.DataBindings.Add("Checked", this, "SonicCD_CollisionChaos2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonicCD_CollisionChaos3.DataBindings.Add("Checked", this, "SonicCD_CollisionChaos3", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonicCD_TidalTempest1.DataBindings.Add("Checked", this, "SonicCD_TidalTempest1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonicCD_TidalTempest2.DataBindings.Add("Checked", this, "SonicCD_TidalTempest2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonicCD_TidalTempest3.DataBindings.Add("Checked", this, "SonicCD_TidalTempest3", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonicCD_QuartzQuadrant1.DataBindings.Add("Checked", this, "SonicCD_QuartzQuadrant1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonicCD_QuartzQuadrant2.DataBindings.Add("Checked", this, "SonicCD_QuartzQuadrant2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonicCD_QuartzQuadrant3.DataBindings.Add("Checked", this, "SonicCD_QuartzQuadrant3", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonicCD_WackyWorkbench1.DataBindings.Add("Checked", this, "SonicCD_WackyWorkbench1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonicCD_WackyWorkbench2.DataBindings.Add("Checked", this, "SonicCD_WackyWorkbench2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonicCD_WackyWorkbench3.DataBindings.Add("Checked", this, "SonicCD_WackyWorkbench3", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonicCD_StardustSpeedway1.DataBindings.Add("Checked", this, "SonicCD_StardustSpeedway1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonicCD_StardustSpeedway2.DataBindings.Add("Checked", this, "SonicCD_StardustSpeedway2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonicCD_StardustSpeedway3.DataBindings.Add("Checked", this, "SonicCD_StardustSpeedway3", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonicCD_MetallicMadness1.DataBindings.Add("Checked", this, "SonicCD_MetallicMadness1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonicCD_MetallicMadness2.DataBindings.Add("Checked", this, "SonicCD_MetallicMadness2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonicCD_MetallicMadness3.DataBindings.Add("Checked", this, "SonicCD_MetallicMadness3", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic2_Start.DataBindings.Add("Checked", this, "Sonic2_Start", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic2_EmeraldHill1.DataBindings.Add("Checked", this, "Sonic2_EmeraldHill1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic2_EmeraldHill2.DataBindings.Add("Checked", this, "Sonic2_EmeraldHill2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic2_ChemicalPlant1.DataBindings.Add("Checked", this, "Sonic2_ChemicalPlant1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic2_ChemicalPlant2.DataBindings.Add("Checked", this, "Sonic2_ChemicalPlant2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic2_AquaticRuin1.DataBindings.Add("Checked", this, "Sonic2_AquaticRuin1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic2_AquaticRuin2.DataBindings.Add("Checked", this, "Sonic2_AquaticRuin2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic2_CasinoNight1.DataBindings.Add("Checked", this, "Sonic2_CasinoNight1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic2_CasinoNight2.DataBindings.Add("Checked", this, "Sonic2_CasinoNight2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic2_HillTop1.DataBindings.Add("Checked", this, "Sonic2_HillTop1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic2_HillTop2.DataBindings.Add("Checked", this, "Sonic2_HillTop2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic2_MysticCave1.DataBindings.Add("Checked", this, "Sonic2_MysticCave1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic2_MysticCave2.DataBindings.Add("Checked", this, "Sonic2_MysticCave2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic2_OilOcean1.DataBindings.Add("Checked", this, "Sonic2_OilOcean1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic2_OilOcean2.DataBindings.Add("Checked", this, "Sonic2_OilOcean2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic2_Metropolis1.DataBindings.Add("Checked", this, "Sonic2_Metropolis1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic2_Metropolis2.DataBindings.Add("Checked", this, "Sonic2_Metropolis2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic2_Metropolis3.DataBindings.Add("Checked", this, "Sonic2_Metropolis3", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic2_SkyChase.DataBindings.Add("Checked", this, "Sonic2_SkyChase", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic2_WingFortress.DataBindings.Add("Checked", this, "Sonic2_WingFortress", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic2_DeathEgg.DataBindings.Add("Checked", this, "Sonic2_DeathEgg", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic3_Start.DataBindings.Add("Checked", this, "Sonic3_Start", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic3_AngelIsland1.DataBindings.Add("Checked", this, "Sonic3_AngelIsland1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic3_AngelIsland2.DataBindings.Add("Checked", this, "Sonic3_AngelIsland2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic3_Hydrocity1.DataBindings.Add("Checked", this, "Sonic3_Hydrocity1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic3_Hydrocity2.DataBindings.Add("Checked", this, "Sonic3_Hydrocity2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic3_MarbleGarden1.DataBindings.Add("Checked", this, "Sonic3_MarbleGarden1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic3_MarbleGarden2.DataBindings.Add("Checked", this, "Sonic3_MarbleGarden2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic3_CarnivalNight1.DataBindings.Add("Checked", this, "Sonic3_CarnivalNight1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic3_CarnivalNight2.DataBindings.Add("Checked", this, "Sonic3_CarnivalNight2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic3_IceCap1.DataBindings.Add("Checked", this, "Sonic3_IceCap1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic3_IceCap2.DataBindings.Add("Checked", this, "Sonic3_IceCap2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic3_LaunchBase1.DataBindings.Add("Checked", this, "Sonic3_LaunchBase1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic3_LaunchBase2.DataBindings.Add("Checked", this, "Sonic3_LaunchBase2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic3_MushroomHill1.DataBindings.Add("Checked", this, "Sonic3_MushroomHill1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic3_MushroomHill2.DataBindings.Add("Checked", this, "Sonic3_MushroomHill2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic3_FlyingBattery1.DataBindings.Add("Checked", this, "Sonic3_FlyingBattery1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic3_FlyingBattery2.DataBindings.Add("Checked", this, "Sonic3_FlyingBattery2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic3_Sandopolis1.DataBindings.Add("Checked", this, "Sonic3_Sandopolis1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic3_Sandopolis2.DataBindings.Add("Checked", this, "Sonic3_Sandopolis2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic3_LavaReef1.DataBindings.Add("Checked", this, "Sonic3_LavaReef1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic3_LavaReef2.DataBindings.Add("Checked", this, "Sonic3_LavaReef2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic3_HiddenPalace.DataBindings.Add("Checked", this, "Sonic3_HiddenPalace", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic3_SkySanctuary.DataBindings.Add("Checked", this, "Sonic3_SkySanctuary", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic3_DeathEgg1.DataBindings.Add("Checked", this, "Sonic3_DeathEgg1", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic3_DeathEgg2.DataBindings.Add("Checked", this, "Sonic3_DeathEgg2", false, DataSourceUpdateMode.OnPropertyChanged);
            chkSonic3_Doomsday.DataBindings.Add("Checked", this, "Sonic3_Doomsday", false, DataSourceUpdateMode.OnPropertyChanged);



            // Default Values
            Story_Start = true;
            Story_GreenHill1 = Story_GreenHill2 = Story_GreenHill3 = true;
            Story_Marble1 = Story_Marble2 = Story_Marble3 = true;
            Story_SpringYard1 = Story_SpringYard2 = Story_SpringYard3 = true;
            Story_Labyrinth1 = Story_Labyrinth2 = Story_Labyrinth3 = true;
            Story_StarLight1 = Story_StarLight2 = Story_StarLight3 = true;
            Story_ScrapBrain1 = Story_ScrapBrain2 = Story_ScrapBrain3 = true;
            Story_FinalZone = true;
            Story_PalmtreePanic1 = Story_PalmtreePanic2 = Story_PalmtreePanic3 = true;
            Story_CollisionChaos1 = Story_CollisionChaos2 = Story_CollisionChaos3 = true;
            Story_TidalTempest1 = Story_TidalTempest2 = Story_TidalTempest3 = true;
            Story_QuartzQuadrant1 = Story_QuartzQuadrant2 = Story_QuartzQuadrant3 = true;
            Story_WackyWorkbench1 = Story_WackyWorkbench2 = Story_WackyWorkbench3 = true;
            Story_StardustSpeedway1 = Story_StardustSpeedway2 = Story_StardustSpeedway3 = true;
            Story_MetallicMadness1 = Story_MetallicMadness2 = Story_MetallicMadness3 = true;
            Story_EmeraldHill1 = Story_EmeraldHill2 = true;
            Story_ChemicalPlant1 = Story_ChemicalPlant2 = true;
            Story_AquaticRuin1 = Story_AquaticRuin2 = true;
            Story_CasinoNight1 = Story_CasinoNight2 = true;
            Story_HillTop1 = Story_HillTop2 = true;
            Story_MysticCave1 = Story_MysticCave2 = true;
            Story_OilOcean1 = Story_OilOcean2 = true;
            Story_Metropolis1 = Story_Metropolis2 = Story_Metropolis3 = true;
            Story_SkyChase = Story_WingFortress = Story_DeathEgg = true;
            Story_AngelIsland1 = Story_AngelIsland2 = true;
            Story_Hydrocity1 = Story_Hydrocity2 = true;
            Story_MarbleGarden1 = Story_MarbleGarden2 = true;
            Story_CarnivalNight1 = Story_CarnivalNight2 = true;
            Story_IceCap1 = Story_IceCap2 = true;
            Story_LaunchBase1 = Story_LaunchBase2 = true;
            Story_MushroomHill1 = Story_MushroomHill2 = true;
            Story_FlyingBattery1 = Story_FlyingBattery2 = true;
            Story_Sandopolis1 = Story_Sandopolis2 = true;
            Story_LavaReef1 = Story_LavaReef2 = true;
            Story_HiddenPalace = Story_SkySanctuary = true; 
            Story_DeathEgg1 = Story_DeathEgg2 = true;
            Story_Doomsday = true;

            // Sonic 1
            Sonic1_Start = true;
            Sonic1_GreenHill1 = Sonic1_GreenHill2 = Sonic1_GreenHill3 = true;
            Sonic1_Marble1 = Sonic1_Marble2 = Sonic1_Marble3 = true;
            Sonic1_SpringYard1 = Sonic1_SpringYard2 = Sonic1_SpringYard3 = true;
            Sonic1_Labyrinth1 = Sonic1_Labyrinth2 = Sonic1_Labyrinth3 = true;
            Sonic1_StarLight1 = Sonic1_StarLight2 = Sonic1_StarLight3 = true;
            Sonic1_ScrapBrain1 = Sonic1_ScrapBrain2 = Sonic1_ScrapBrain3 = true;
            Sonic1_FinalZone = true;

            // Sonic CD
            SonicCD_Start = true;
            SonicCD_PalmtreePanic1 = SonicCD_PalmtreePanic2 = SonicCD_PalmtreePanic3 = true;
            SonicCD_CollisionChaos1 = SonicCD_CollisionChaos2 = SonicCD_CollisionChaos3 = true;
            SonicCD_TidalTempest1 = SonicCD_TidalTempest2 = SonicCD_TidalTempest3 = true;
            SonicCD_QuartzQuadrant1 = SonicCD_QuartzQuadrant2 = SonicCD_QuartzQuadrant3 = true;
            SonicCD_WackyWorkbench1 = SonicCD_WackyWorkbench2 = SonicCD_WackyWorkbench3 = true;
            SonicCD_StardustSpeedway1 = SonicCD_StardustSpeedway2 = SonicCD_StardustSpeedway3 = true;
            SonicCD_MetallicMadness1 = SonicCD_MetallicMadness2 = SonicCD_MetallicMadness3 = true;

            // Sonic 2
            Sonic2_Start = true;
            Sonic2_EmeraldHill1 = Sonic2_EmeraldHill2 = true;
            Sonic2_ChemicalPlant1 = Sonic2_ChemicalPlant2 = true;
            Sonic2_AquaticRuin1 = Sonic2_AquaticRuin2 = true;
            Sonic2_CasinoNight1 = Sonic2_CasinoNight2 = true;
            Sonic2_HillTop1 = Sonic2_HillTop2 = true;
            Sonic2_MysticCave1 = Sonic2_MysticCave2 = true;
            Sonic2_OilOcean1 = Sonic2_OilOcean2 = true;
            Sonic2_Metropolis1 = Sonic2_Metropolis2 = Sonic2_Metropolis3 = true;
            Sonic2_SkyChase = Sonic2_WingFortress = Sonic2_DeathEgg = true;

            // Sonic 3
            Sonic3_Start = true;
            Sonic3_AngelIsland1 = Sonic3_AngelIsland2 = true;
            Sonic3_Hydrocity1 = Sonic3_Hydrocity2 = true;
            Sonic3_MarbleGarden1 = Sonic3_MarbleGarden2 = true;
            Sonic3_CarnivalNight1 = Sonic3_CarnivalNight2 = true;
            Sonic3_IceCap1 = Sonic3_IceCap2 = true;
            Sonic3_LaunchBase1 = Sonic3_LaunchBase2 = true;
            Sonic3_MushroomHill1 = Sonic3_MushroomHill2 = true; 
            Sonic3_FlyingBattery1 = Sonic3_FlyingBattery2 = true;
            Sonic3_Sandopolis1 = Sonic3_Sandopolis2 = true;
            Sonic3_LavaReef1 = Sonic3_LavaReef2 = true;
            Sonic3_HiddenPalace = Sonic3_SkySanctuary = true;
            Sonic3_DeathEgg1 = Sonic3_DeathEgg2 = true;
            Sonic3_Doomsday = true;
        }

        public XmlNode GetSettings(XmlDocument doc)
        {
            XmlElement settingsNode = doc.CreateElement("Settings");

            // Story mode
            settingsNode.AppendChild(ToElement(doc, "Story_Start", Story_Start));
            settingsNode.AppendChild(ToElement(doc, "Story_GreenHill1", Story_GreenHill1));
            settingsNode.AppendChild(ToElement(doc, "Story_GreenHill2", Story_GreenHill2));
            settingsNode.AppendChild(ToElement(doc, "Story_GreenHill3", Story_GreenHill3));
            settingsNode.AppendChild(ToElement(doc, "Story_Marble1", Story_Marble1));
            settingsNode.AppendChild(ToElement(doc, "Story_Marble2", Story_Marble2));
            settingsNode.AppendChild(ToElement(doc, "Story_Marble3", Story_Marble3));
            settingsNode.AppendChild(ToElement(doc, "Story_SpringYard1", Story_SpringYard1));
            settingsNode.AppendChild(ToElement(doc, "Story_SpringYard2", Story_SpringYard2));
            settingsNode.AppendChild(ToElement(doc, "Story_SpringYard3", Story_SpringYard3));
            settingsNode.AppendChild(ToElement(doc, "Story_Labyrinth1", Story_Labyrinth1));
            settingsNode.AppendChild(ToElement(doc, "Story_Labyrinth2", Story_Labyrinth2));
            settingsNode.AppendChild(ToElement(doc, "Story_Labyrinth3", Story_Labyrinth3));
            settingsNode.AppendChild(ToElement(doc, "Story_StarLight1", Story_StarLight1));
            settingsNode.AppendChild(ToElement(doc, "Story_StarLight2", Story_StarLight2));
            settingsNode.AppendChild(ToElement(doc, "Story_StarLight3", Story_StarLight3));
            settingsNode.AppendChild(ToElement(doc, "Story_ScrapBrain1", Story_ScrapBrain1));
            settingsNode.AppendChild(ToElement(doc, "Story_ScrapBrain2", Story_ScrapBrain2));
            settingsNode.AppendChild(ToElement(doc, "Story_ScrapBrain3", Story_ScrapBrain3));
            settingsNode.AppendChild(ToElement(doc, "Story_FinalZone", Story_FinalZone));
            settingsNode.AppendChild(ToElement(doc, "Story_PalmtreePanic1", Story_PalmtreePanic1));
            settingsNode.AppendChild(ToElement(doc, "Story_PalmtreePanic2", Story_PalmtreePanic2));
            settingsNode.AppendChild(ToElement(doc, "Story_PalmtreePanic3", Story_PalmtreePanic3));
            settingsNode.AppendChild(ToElement(doc, "Story_CollisionChaos1", Story_CollisionChaos1));
            settingsNode.AppendChild(ToElement(doc, "Story_CollisionChaos2", Story_CollisionChaos2));
            settingsNode.AppendChild(ToElement(doc, "Story_CollisionChaos3", Story_CollisionChaos3));
            settingsNode.AppendChild(ToElement(doc, "Story_TidalTempest1", Story_TidalTempest1));
            settingsNode.AppendChild(ToElement(doc, "Story_TidalTempest2", Story_TidalTempest2));
            settingsNode.AppendChild(ToElement(doc, "Story_TidalTempest3", Story_TidalTempest3));
            settingsNode.AppendChild(ToElement(doc, "Story_QuartzQuadrant1", Story_QuartzQuadrant1));
            settingsNode.AppendChild(ToElement(doc, "Story_QuartzQuadrant2", Story_QuartzQuadrant2));
            settingsNode.AppendChild(ToElement(doc, "Story_QuartzQuadrant3", Story_QuartzQuadrant3));
            settingsNode.AppendChild(ToElement(doc, "Story_WackyWorkbench1", Story_WackyWorkbench1));
            settingsNode.AppendChild(ToElement(doc, "Story_WackyWorkbench2", Story_WackyWorkbench2));
            settingsNode.AppendChild(ToElement(doc, "Story_WackyWorkbench3", Story_WackyWorkbench3));
            settingsNode.AppendChild(ToElement(doc, "Story_StardustSpeedway1", Story_StardustSpeedway1));
            settingsNode.AppendChild(ToElement(doc, "Story_StardustSpeedway2", Story_StardustSpeedway2));
            settingsNode.AppendChild(ToElement(doc, "Story_StardustSpeedway3", Story_StardustSpeedway3));
            settingsNode.AppendChild(ToElement(doc, "Story_MetallicMadness1", Story_MetallicMadness1));
            settingsNode.AppendChild(ToElement(doc, "Story_MetallicMadness2", Story_MetallicMadness2));
            settingsNode.AppendChild(ToElement(doc, "Story_MetallicMadness3", Story_MetallicMadness3));
            settingsNode.AppendChild(ToElement(doc, "Story_EmeraldHill1", Story_EmeraldHill1));
            settingsNode.AppendChild(ToElement(doc, "Story_EmeraldHill2", Story_EmeraldHill2));
            settingsNode.AppendChild(ToElement(doc, "Story_ChemicalPlant1", Story_ChemicalPlant1));
            settingsNode.AppendChild(ToElement(doc, "Story_ChemicalPlant2", Story_ChemicalPlant2));
            settingsNode.AppendChild(ToElement(doc, "Story_AquaticRuin1", Story_AquaticRuin1));
            settingsNode.AppendChild(ToElement(doc, "Story_AquaticRuin2", Story_AquaticRuin2));
            settingsNode.AppendChild(ToElement(doc, "Story_CasinoNight1", Story_CasinoNight1));
            settingsNode.AppendChild(ToElement(doc, "Story_CasinoNight2", Story_CasinoNight2));
            settingsNode.AppendChild(ToElement(doc, "Story_HillTop1", Story_HillTop1));
            settingsNode.AppendChild(ToElement(doc, "Story_HillTop2", Story_HillTop2));
            settingsNode.AppendChild(ToElement(doc, "Story_MysticCave1", Story_MysticCave1));
            settingsNode.AppendChild(ToElement(doc, "Story_MysticCave2", Story_MysticCave2));
            settingsNode.AppendChild(ToElement(doc, "Story_OilOcean1", Story_OilOcean1));
            settingsNode.AppendChild(ToElement(doc, "Story_OilOcean2", Story_OilOcean2));
            settingsNode.AppendChild(ToElement(doc, "Story_Metropolis1", Story_Metropolis1));
            settingsNode.AppendChild(ToElement(doc, "Story_Metropolis2", Story_Metropolis2));
            settingsNode.AppendChild(ToElement(doc, "Story_Metropolis3", Story_Metropolis3));
            settingsNode.AppendChild(ToElement(doc, "Story_SkyChase", Story_SkyChase));
            settingsNode.AppendChild(ToElement(doc, "Story_WingFortress", Story_WingFortress));
            settingsNode.AppendChild(ToElement(doc, "Story_DeathEgg", Story_DeathEgg));
            settingsNode.AppendChild(ToElement(doc, "Story_AngelIsland1", Story_AngelIsland1));
            settingsNode.AppendChild(ToElement(doc, "Story_AngelIsland2", Story_AngelIsland2));
            settingsNode.AppendChild(ToElement(doc, "Story_Hydrocity1", Story_Hydrocity1));
            settingsNode.AppendChild(ToElement(doc, "Story_Hydrocity2", Story_Hydrocity2));
            settingsNode.AppendChild(ToElement(doc, "Story_MarbleGarden1", Story_MarbleGarden1));
            settingsNode.AppendChild(ToElement(doc, "Story_MarbleGarden2", Story_MarbleGarden2));
            settingsNode.AppendChild(ToElement(doc, "Story_CarnivalNight1", Story_CarnivalNight1));
            settingsNode.AppendChild(ToElement(doc, "Story_CarnivalNight2", Story_CarnivalNight2));
            settingsNode.AppendChild(ToElement(doc, "Story_IceCap1", Story_IceCap1));
            settingsNode.AppendChild(ToElement(doc, "Story_IceCap2", Story_IceCap2));
            settingsNode.AppendChild(ToElement(doc, "Story_LaunchBase1", Story_LaunchBase1));
            settingsNode.AppendChild(ToElement(doc, "Story_LaunchBase2", Story_LaunchBase2));
            settingsNode.AppendChild(ToElement(doc, "Story_MushroomHill1", Story_MushroomHill1));
            settingsNode.AppendChild(ToElement(doc, "Story_MushroomHill2", Story_MushroomHill2));
            settingsNode.AppendChild(ToElement(doc, "Story_FlyingBattery1", Story_FlyingBattery1));
            settingsNode.AppendChild(ToElement(doc, "Story_FlyingBattery2", Story_FlyingBattery2));
            settingsNode.AppendChild(ToElement(doc, "Story_Sandopolis1", Story_Sandopolis1));
            settingsNode.AppendChild(ToElement(doc, "Story_Sandopolis2", Story_Sandopolis2));
            settingsNode.AppendChild(ToElement(doc, "Story_LavaReef1", Story_LavaReef1));
            settingsNode.AppendChild(ToElement(doc, "Story_LavaReef2", Story_LavaReef2));
            settingsNode.AppendChild(ToElement(doc, "Story_HiddenPalace", Story_HiddenPalace));
            settingsNode.AppendChild(ToElement(doc, "Story_SkySanctuary", Story_SkySanctuary));
            settingsNode.AppendChild(ToElement(doc, "Story_DeathEgg1", Story_DeathEgg1));
            settingsNode.AppendChild(ToElement(doc, "Story_DeathEgg2", Story_DeathEgg2));
            settingsNode.AppendChild(ToElement(doc, "Story_Doomsday", Story_Doomsday));

            // Sonic 1
            settingsNode.AppendChild(ToElement(doc, "Sonic1_Start", Sonic1_Start));
            settingsNode.AppendChild(ToElement(doc, "Sonic1_GreenHill1", Sonic1_GreenHill1));
            settingsNode.AppendChild(ToElement(doc, "Sonic1_GreenHill2", Sonic1_GreenHill2));
            settingsNode.AppendChild(ToElement(doc, "Sonic1_GreenHill3", Sonic1_GreenHill3));
            settingsNode.AppendChild(ToElement(doc, "Sonic1_Marble1", Sonic1_Marble1));
            settingsNode.AppendChild(ToElement(doc, "Sonic1_Marble2", Sonic1_Marble2));
            settingsNode.AppendChild(ToElement(doc, "Sonic1_Marble3", Sonic1_Marble3));
            settingsNode.AppendChild(ToElement(doc, "Sonic1_SpringYard1", Sonic1_SpringYard1));
            settingsNode.AppendChild(ToElement(doc, "Sonic1_SpringYard2", Sonic1_SpringYard2));
            settingsNode.AppendChild(ToElement(doc, "Sonic1_SpringYard3", Sonic1_SpringYard3));
            settingsNode.AppendChild(ToElement(doc, "Sonic1_Labyrinth1", Sonic1_Labyrinth1));
            settingsNode.AppendChild(ToElement(doc, "Sonic1_Labyrinth2", Sonic1_Labyrinth2));
            settingsNode.AppendChild(ToElement(doc, "Sonic1_Labyrinth3", Sonic1_Labyrinth3));
            settingsNode.AppendChild(ToElement(doc, "Sonic1_StarLight1", Sonic1_StarLight1));
            settingsNode.AppendChild(ToElement(doc, "Sonic1_StarLight2", Sonic1_StarLight2));
            settingsNode.AppendChild(ToElement(doc, "Sonic1_StarLight3", Sonic1_StarLight3));
            settingsNode.AppendChild(ToElement(doc, "Sonic1_ScrapBrain1", Sonic1_ScrapBrain1));
            settingsNode.AppendChild(ToElement(doc, "Sonic1_ScrapBrain2", Sonic1_ScrapBrain2));
            settingsNode.AppendChild(ToElement(doc, "Sonic1_ScrapBrain3", Sonic1_ScrapBrain3));
            settingsNode.AppendChild(ToElement(doc, "Sonic1_FinalZone", Sonic1_FinalZone));

            // Sonic CD
            settingsNode.AppendChild(ToElement(doc, "SonicCD_Start", SonicCD_Start));
            settingsNode.AppendChild(ToElement(doc, "SonicCD_PalmtreePanic1", SonicCD_PalmtreePanic1));
            settingsNode.AppendChild(ToElement(doc, "SonicCD_PalmtreePanic2", SonicCD_PalmtreePanic2));
            settingsNode.AppendChild(ToElement(doc, "SonicCD_PalmtreePanic3", SonicCD_PalmtreePanic3));
            settingsNode.AppendChild(ToElement(doc, "SonicCD_CollisionChaos1", SonicCD_CollisionChaos1));
            settingsNode.AppendChild(ToElement(doc, "SonicCD_CollisionChaos2", SonicCD_CollisionChaos2));
            settingsNode.AppendChild(ToElement(doc, "SonicCD_CollisionChaos3", SonicCD_CollisionChaos3));
            settingsNode.AppendChild(ToElement(doc, "SonicCD_TidalTempest1", SonicCD_TidalTempest1));
            settingsNode.AppendChild(ToElement(doc, "SonicCD_TidalTempest2", SonicCD_TidalTempest2));
            settingsNode.AppendChild(ToElement(doc, "SonicCD_TidalTempest3", SonicCD_TidalTempest3));
            settingsNode.AppendChild(ToElement(doc, "SonicCD_QuartzQuadrant1", SonicCD_QuartzQuadrant1));
            settingsNode.AppendChild(ToElement(doc, "SonicCD_QuartzQuadrant2", SonicCD_QuartzQuadrant2));
            settingsNode.AppendChild(ToElement(doc, "SonicCD_QuartzQuadrant3", SonicCD_QuartzQuadrant3));
            settingsNode.AppendChild(ToElement(doc, "SonicCD_WackyWorkbench1", SonicCD_WackyWorkbench1));
            settingsNode.AppendChild(ToElement(doc, "SonicCD_WackyWorkbench2", SonicCD_WackyWorkbench2));
            settingsNode.AppendChild(ToElement(doc, "SonicCD_WackyWorkbench3", SonicCD_WackyWorkbench3));
            settingsNode.AppendChild(ToElement(doc, "SonicCD_StardustSpeedway1", SonicCD_StardustSpeedway1));
            settingsNode.AppendChild(ToElement(doc, "SonicCD_StardustSpeedway2", SonicCD_StardustSpeedway2));
            settingsNode.AppendChild(ToElement(doc, "SonicCD_StardustSpeedway3", SonicCD_StardustSpeedway3));
            settingsNode.AppendChild(ToElement(doc, "SonicCD_MetallicMadness1", SonicCD_MetallicMadness1));
            settingsNode.AppendChild(ToElement(doc, "SonicCD_MetallicMadness2", SonicCD_MetallicMadness2));
            settingsNode.AppendChild(ToElement(doc, "SonicCD_MetallicMadness3", SonicCD_MetallicMadness3));

            // Sonic 2
            settingsNode.AppendChild(ToElement(doc, "Sonic2_Start", Sonic2_Start));
            settingsNode.AppendChild(ToElement(doc, "Sonic2_EmeraldHill1", Sonic2_EmeraldHill1));
            settingsNode.AppendChild(ToElement(doc, "Sonic2_EmeraldHill2", Sonic2_EmeraldHill2));
            settingsNode.AppendChild(ToElement(doc, "Sonic2_ChemicalPlant1", Sonic2_ChemicalPlant1));
            settingsNode.AppendChild(ToElement(doc, "Sonic2_ChemicalPlant2", Sonic2_ChemicalPlant2));
            settingsNode.AppendChild(ToElement(doc, "Sonic2_AquaticRuin1", Sonic2_AquaticRuin1));
            settingsNode.AppendChild(ToElement(doc, "Sonic2_AquaticRuin2", Sonic2_AquaticRuin2));
            settingsNode.AppendChild(ToElement(doc, "Sonic2_CasinoNight1", Sonic2_CasinoNight1));
            settingsNode.AppendChild(ToElement(doc, "Sonic2_CasinoNight2", Sonic2_CasinoNight2));
            settingsNode.AppendChild(ToElement(doc, "Sonic2_HillTop1", Sonic2_HillTop1));
            settingsNode.AppendChild(ToElement(doc, "Sonic2_HillTop2", Sonic2_HillTop2));
            settingsNode.AppendChild(ToElement(doc, "Sonic2_MysticCave1", Sonic2_MysticCave1));
            settingsNode.AppendChild(ToElement(doc, "Sonic2_MysticCave2", Sonic2_MysticCave2));
            settingsNode.AppendChild(ToElement(doc, "Sonic2_OilOcean1", Sonic2_OilOcean1));
            settingsNode.AppendChild(ToElement(doc, "Sonic2_OilOcean2", Sonic2_OilOcean2));
            settingsNode.AppendChild(ToElement(doc, "Sonic2_Metropolis1", Sonic2_Metropolis1));
            settingsNode.AppendChild(ToElement(doc, "Sonic2_Metropolis2", Sonic2_Metropolis2));
            settingsNode.AppendChild(ToElement(doc, "Sonic2_Metropolis3", Sonic2_Metropolis3));
            settingsNode.AppendChild(ToElement(doc, "Sonic2_SkyChase", Sonic2_SkyChase));
            settingsNode.AppendChild(ToElement(doc, "Sonic2_WingFortress", Sonic2_WingFortress));
            settingsNode.AppendChild(ToElement(doc, "Sonic2_DeathEgg", Sonic2_DeathEgg));

            // Sonic 3
            settingsNode.AppendChild(ToElement(doc, "Sonic3_Start", Sonic3_Start));
            settingsNode.AppendChild(ToElement(doc, "Sonic3_AngelIsland1", Sonic3_AngelIsland1));
            settingsNode.AppendChild(ToElement(doc, "Sonic3_AngelIsland2", Sonic3_AngelIsland2));
            settingsNode.AppendChild(ToElement(doc, "Sonic3_Hydrocity1", Sonic3_Hydrocity1));
            settingsNode.AppendChild(ToElement(doc, "Sonic3_Hydrocity2", Sonic3_Hydrocity2));
            settingsNode.AppendChild(ToElement(doc, "Sonic3_MarbleGarden1", Sonic3_MarbleGarden1));
            settingsNode.AppendChild(ToElement(doc, "Sonic3_MarbleGarden2", Sonic3_MarbleGarden2));
            settingsNode.AppendChild(ToElement(doc, "Sonic3_CarnivalNight1", Sonic3_CarnivalNight1));
            settingsNode.AppendChild(ToElement(doc, "Sonic3_CarnivalNight2", Sonic3_CarnivalNight2));
            settingsNode.AppendChild(ToElement(doc, "Sonic3_IceCap1", Sonic3_IceCap1));
            settingsNode.AppendChild(ToElement(doc, "Sonic3_IceCap2", Sonic3_IceCap2));
            settingsNode.AppendChild(ToElement(doc, "Sonic3_LaunchBase1", Sonic3_LaunchBase1));
            settingsNode.AppendChild(ToElement(doc, "Sonic3_LaunchBase2", Sonic3_LaunchBase2));
            settingsNode.AppendChild(ToElement(doc, "Sonic3_MushroomHill1", Sonic3_MushroomHill1));
            settingsNode.AppendChild(ToElement(doc, "Sonic3_MushroomHill2", Sonic3_MushroomHill2));
            settingsNode.AppendChild(ToElement(doc, "Sonic3_FlyingBattery1", Sonic3_FlyingBattery1));
            settingsNode.AppendChild(ToElement(doc, "Sonic3_FlyingBattery2", Sonic3_FlyingBattery2));
            settingsNode.AppendChild(ToElement(doc, "Sonic3_Sandopolis1", Sonic3_Sandopolis1));
            settingsNode.AppendChild(ToElement(doc, "Sonic3_Sandopolis2", Sonic3_Sandopolis2));
            settingsNode.AppendChild(ToElement(doc, "Sonic3_LavaReef1", Sonic3_LavaReef1));
            settingsNode.AppendChild(ToElement(doc, "Sonic3_LavaReef2", Sonic3_LavaReef2));
            settingsNode.AppendChild(ToElement(doc, "Sonic3_HiddenPalace", Sonic3_HiddenPalace));
            settingsNode.AppendChild(ToElement(doc, "Sonic3_SkySanctuary", Sonic3_SkySanctuary));
            settingsNode.AppendChild(ToElement(doc, "Sonic3_DeathEgg1", Sonic3_DeathEgg1));
            settingsNode.AppendChild(ToElement(doc, "Sonic3_DeathEgg2", Sonic3_DeathEgg2));
            settingsNode.AppendChild(ToElement(doc, "Sonic3_Doomsday", Sonic3_Doomsday));

            return settingsNode;
        }

        public void SetSettings(XmlNode settings)
        {
            // Story mode
            Story_Start = ParseBool(settings, "Story_Start", true);
            Story_GreenHill1 = ParseBool(settings, "Story_GreenHill1", true);
            Story_GreenHill2 = ParseBool(settings, "Story_GreenHill2", true);
            Story_GreenHill3 = ParseBool(settings, "Story_GreenHill3", true);
            Story_Marble1 = ParseBool(settings, "Story_Marble1", true);
            Story_Marble2 = ParseBool(settings, "Story_Marble2", true);
            Story_Marble3 = ParseBool(settings, "Story_Marble3", true);
            Story_SpringYard1 = ParseBool(settings, "Story_SpringYard1", true);
            Story_SpringYard2 = ParseBool(settings, "Story_SpringYard2", true);
            Story_SpringYard3 = ParseBool(settings, "Story_SpringYard3", true);
            Story_Labyrinth1 = ParseBool(settings, "Story_Labyrinth1", true);
            Story_Labyrinth2 = ParseBool(settings, "Story_Labyrinth2", true);
            Story_Labyrinth3 = ParseBool(settings, "Story_Labyrinth3", true);
            Story_StarLight1 = ParseBool(settings, "Story_StarLight1", true);
            Story_StarLight2 = ParseBool(settings, "Story_StarLight2", true);
            Story_StarLight3 = ParseBool(settings, "Story_StarLight3", true);
            Story_ScrapBrain1 = ParseBool(settings, "Story_ScrapBrain1", true);
            Story_ScrapBrain2 = ParseBool(settings, "Story_ScrapBrain2", true);
            Story_ScrapBrain3 = ParseBool(settings, "Story_ScrapBrain3", true);
            Story_FinalZone = ParseBool(settings, "Story_FinalZone", true);
            Story_PalmtreePanic1 = ParseBool(settings, "Story_PalmtreePanic1", true);
            Story_PalmtreePanic2 = ParseBool(settings, "Story_PalmtreePanic2", true);
            Story_PalmtreePanic3 = ParseBool(settings, "Story_PalmtreePanic3", true);
            Story_CollisionChaos1 = ParseBool(settings, "Story_CollisionChaos1", true);
            Story_CollisionChaos2 = ParseBool(settings, "Story_CollisionChaos2", true);
            Story_CollisionChaos3 = ParseBool(settings, "Story_CollisionChaos3", true);
            Story_TidalTempest1 = ParseBool(settings, "Story_TidalTempest1", true);
            Story_TidalTempest2 = ParseBool(settings, "Story_TidalTempest2", true);
            Story_TidalTempest3 = ParseBool(settings, "Story_TidalTempest3", true);
            Story_QuartzQuadrant1 = ParseBool(settings, "Story_QuartzQuadrant1", true);
            Story_QuartzQuadrant2 = ParseBool(settings, "Story_QuartzQuadrant2", true);
            Story_QuartzQuadrant3 = ParseBool(settings, "Story_QuartzQuadrant3", true);
            Story_WackyWorkbench1 = ParseBool(settings, "Story_WackyWorkbench1", true);
            Story_WackyWorkbench2 = ParseBool(settings, "Story_WackyWorkbench2", true);
            Story_WackyWorkbench3 = ParseBool(settings, "Story_WackyWorkbench3", true);
            Story_StardustSpeedway1 = ParseBool(settings, "Story_StardustSpeedway1", true);
            Story_StardustSpeedway2 = ParseBool(settings, "Story_StardustSpeedway2", true);
            Story_StardustSpeedway3 = ParseBool(settings, "Story_StardustSpeedway3", true);
            Story_MetallicMadness1 = ParseBool(settings, "Story_MetallicMadness1", true);
            Story_MetallicMadness2 = ParseBool(settings, "Story_MetallicMadness2", true);
            Story_MetallicMadness3 = ParseBool(settings, "Story_MetallicMadness3", true);
            Story_EmeraldHill1 = ParseBool(settings, "Story_EmeraldHill1", true);
            Story_EmeraldHill2 = ParseBool(settings, "Story_EmeraldHill2", true);
            Story_ChemicalPlant1 = ParseBool(settings, "Story_ChemicalPlant1", true);
            Story_ChemicalPlant2 = ParseBool(settings, "Story_ChemicalPlant2", true);
            Story_AquaticRuin1 = ParseBool(settings, "Story_AquaticRuin1", true);
            Story_AquaticRuin2 = ParseBool(settings, "Story_AquaticRuin2", true);
            Story_CasinoNight1 = ParseBool(settings, "Story_CasinoNight1", true);
            Story_CasinoNight2 = ParseBool(settings, "Story_CasinoNight2", true);
            Story_HillTop1 = ParseBool(settings, "Story_HillTop1", true);
            Story_HillTop2 = ParseBool(settings, "Story_HillTop2", true);
            Story_MysticCave1 = ParseBool(settings, "Story_MysticCave1", true);
            Story_MysticCave2 = ParseBool(settings, "Story_MysticCave2", true);
            Story_OilOcean1 = ParseBool(settings, "Story_OilOcean1", true);
            Story_OilOcean2 = ParseBool(settings, "Story_OilOcean2", true);
            Story_Metropolis1 = ParseBool(settings, "Story_Metropolis1", true);
            Story_Metropolis2 = ParseBool(settings, "Story_Metropolis2", true);
            Story_Metropolis3 = ParseBool(settings, "Story_Metropolis3", true);
            Story_SkyChase = ParseBool(settings, "Story_SkyChase", true);
            Story_WingFortress = ParseBool(settings, "Story_WingFortress", true);
            Story_DeathEgg = ParseBool(settings, "Story_DeathEgg", true);
            Story_AngelIsland1 = ParseBool(settings, "Story_AngelIsland1", true);
            Story_AngelIsland2 = ParseBool(settings, "Story_AngelIsland2", true);
            Story_Hydrocity1 = ParseBool(settings, "Story_Hydrocity1", true);
            Story_Hydrocity2 = ParseBool(settings, "Story_Hydrocity2", true);
            Story_MarbleGarden1 = ParseBool(settings, "Story_MarbleGarden1", true);
            Story_MarbleGarden2 = ParseBool(settings, "Story_MarbleGarden2", true);
            Story_CarnivalNight1 = ParseBool(settings, "Story_CarnivalNight1", true);
            Story_CarnivalNight2 = ParseBool(settings, "Story_CarnivalNight2", true);
            Story_IceCap1 = ParseBool(settings, "Story_IceCap1", true);
            Story_IceCap2 = ParseBool(settings, "Story_IceCap2", true);
            Story_LaunchBase1 = ParseBool(settings, "Story_LaunchBase1", true);
            Story_LaunchBase2 = ParseBool(settings, "Story_LaunchBase2", true);
            Story_MushroomHill1 = ParseBool(settings, "Story_MushroomHill1", true);
            Story_MushroomHill2 = ParseBool(settings, "Story_MushroomHill2", true);
            Story_FlyingBattery1 = ParseBool(settings, "Story_FlyingBattery1", true);
            Story_FlyingBattery2 = ParseBool(settings, "Story_FlyingBattery2", true);
            Story_Sandopolis1 = ParseBool(settings, "Story_Sandopolis1", true);
            Story_Sandopolis2 = ParseBool(settings, "Story_Sandopolis2", true);
            Story_LavaReef1 = ParseBool(settings, "Story_LavaReef1", true);
            Story_LavaReef2 = ParseBool(settings, "Story_LavaReef2", true);
            Story_HiddenPalace = ParseBool(settings, "Story_HiddenPalace", true);
            Story_SkySanctuary = ParseBool(settings, "Story_SkySanctuary", true);
            Story_DeathEgg1 = ParseBool(settings, "Story_DeathEgg1", true);
            Story_DeathEgg2 = ParseBool(settings, "Story_DeathEgg2", true);
            Story_Doomsday = ParseBool(settings, "Story_Doomsday", true);

            // Sonic 1
            Sonic1_Start = ParseBool(settings, "Sonic1_Start", true);
            Sonic1_GreenHill1 = ParseBool(settings, "Sonic1_GreenHill1", true);
            Sonic1_GreenHill2 = ParseBool(settings, "Sonic1_GreenHill2", true);
            Sonic1_GreenHill3 = ParseBool(settings, "Sonic1_GreenHill3", true);
            Sonic1_Marble1 = ParseBool(settings, "Sonic1_Marble1", true);
            Sonic1_Marble2 = ParseBool(settings, "Sonic1_Marble2", true);
            Sonic1_Marble3 = ParseBool(settings, "Sonic1_Marble3", true);
            Sonic1_SpringYard1 = ParseBool(settings, "Sonic1_SpringYard1", true);
            Sonic1_SpringYard2 = ParseBool(settings, "Sonic1_SpringYard2", true);
            Sonic1_SpringYard3 = ParseBool(settings, "Sonic1_SpringYard3", true);
            Sonic1_Labyrinth1 = ParseBool(settings, "Sonic1_Labyrinth1", true);
            Sonic1_Labyrinth2 = ParseBool(settings, "Sonic1_Labyrinth2", true);
            Sonic1_Labyrinth3 = ParseBool(settings, "Sonic1_Labyrinth3", true);
            Sonic1_StarLight1 = ParseBool(settings, "Sonic1_StarLight1", true);
            Sonic1_StarLight2 = ParseBool(settings, "Sonic1_StarLight2", true);
            Sonic1_StarLight3 = ParseBool(settings, "Sonic1_StarLight3", true);
            Sonic1_ScrapBrain1 = ParseBool(settings, "Sonic1_ScrapBrain1", true);
            Sonic1_ScrapBrain2 = ParseBool(settings, "Sonic1_ScrapBrain2", true);
            Sonic1_ScrapBrain3 = ParseBool(settings, "Sonic1_ScrapBrain3", true);
            Sonic1_FinalZone = ParseBool(settings, "Sonic1_FinalZone", true);

            // Sonic CD
            SonicCD_Start = ParseBool(settings, "SonicCD_Start", true);
            SonicCD_PalmtreePanic1 = ParseBool(settings, "SonicCD_PalmtreePanic1", true);
            SonicCD_PalmtreePanic2 = ParseBool(settings, "SonicCD_PalmtreePanic2", true);
            SonicCD_PalmtreePanic3 = ParseBool(settings, "SonicCD_PalmtreePanic3", true);
            SonicCD_CollisionChaos1 = ParseBool(settings, "SonicCD_CollisionChaos1", true);
            SonicCD_CollisionChaos2 = ParseBool(settings, "SonicCD_CollisionChaos2", true);
            SonicCD_CollisionChaos3 = ParseBool(settings, "SonicCD_CollisionChaos3", true);
            SonicCD_TidalTempest1 = ParseBool(settings, "SonicCD_TidalTempest1", true);
            SonicCD_TidalTempest2 = ParseBool(settings, "SonicCD_TidalTempest2", true);
            SonicCD_TidalTempest3 = ParseBool(settings, "SonicCD_TidalTempest3", true);
            SonicCD_QuartzQuadrant1 = ParseBool(settings, "SonicCD_QuartzQuadrant1", true);
            SonicCD_QuartzQuadrant2 = ParseBool(settings, "SonicCD_QuartzQuadrant2", true);
            SonicCD_QuartzQuadrant3 = ParseBool(settings, "SonicCD_QuartzQuadrant3", true);
            SonicCD_WackyWorkbench1 = ParseBool(settings, "SonicCD_WackyWorkbench1", true);
            SonicCD_WackyWorkbench2 = ParseBool(settings, "SonicCD_WackyWorkbench2", true);
            SonicCD_WackyWorkbench3 = ParseBool(settings, "SonicCD_WackyWorkbench3", true);
            SonicCD_StardustSpeedway1 = ParseBool(settings, "SonicCD_StardustSpeedway1", true);
            SonicCD_StardustSpeedway2 = ParseBool(settings, "SonicCD_StardustSpeedway2", true);
            SonicCD_StardustSpeedway3 = ParseBool(settings, "SonicCD_StardustSpeedway3", true);
            SonicCD_MetallicMadness1 = ParseBool(settings, "SonicCD_MetallicMadness1", true);
            SonicCD_MetallicMadness2 = ParseBool(settings, "SonicCD_MetallicMadness2", true);
            SonicCD_MetallicMadness3 = ParseBool(settings, "SonicCD_MetallicMadness3", true);

            // Sonic 2
            Sonic2_Start = ParseBool(settings, "Sonic2_Start", true);
            Sonic2_EmeraldHill1 = ParseBool(settings, "Sonic2_EmeraldHill1", true);
            Sonic2_EmeraldHill2 = ParseBool(settings, "Sonic2_EmeraldHill2", true);
            Sonic2_ChemicalPlant1 = ParseBool(settings, "Sonic2_ChemicalPlant1", true);
            Sonic2_ChemicalPlant2 = ParseBool(settings, "Sonic2_ChemicalPlant2", true);
            Sonic2_AquaticRuin1 = ParseBool(settings, "Sonic2_AquaticRuin1", true);
            Sonic2_AquaticRuin2 = ParseBool(settings, "Sonic2_AquaticRuin2", true);
            Sonic2_CasinoNight1 = ParseBool(settings, "Sonic2_CasinoNight1", true);
            Sonic2_CasinoNight2 = ParseBool(settings, "Sonic2_CasinoNight2", true);
            Sonic2_HillTop1 = ParseBool(settings, "Sonic2_HillTop1", true);
            Sonic2_HillTop2 = ParseBool(settings, "Sonic2_HillTop2", true);
            Sonic2_MysticCave1 = ParseBool(settings, "Sonic2_MysticCave1", true);
            Sonic2_MysticCave2 = ParseBool(settings, "Sonic2_MysticCave2", true);
            Sonic2_OilOcean1 = ParseBool(settings, "Sonic2_OilOcean1", true);
            Sonic2_OilOcean2 = ParseBool(settings, "Sonic2_OilOcean2", true);
            Sonic2_Metropolis1 = ParseBool(settings, "Sonic2_Metropolis1", true);
            Sonic2_Metropolis2 = ParseBool(settings, "Sonic2_Metropolis2", true);
            Sonic2_Metropolis3 = ParseBool(settings, "Sonic2_Metropolis3", true);
            Sonic2_SkyChase = ParseBool(settings, "Sonic2_SkyChase", true);
            Sonic2_WingFortress = ParseBool(settings, "Sonic2_WingFortress", true);
            Sonic2_DeathEgg = ParseBool(settings, "Sonic2_DeathEgg", true);

            // Sonic 3
            Sonic3_Start = ParseBool(settings, "Sonic3_Start", true);
            Sonic3_AngelIsland1 = ParseBool(settings, "Sonic3_AngelIsland1", true);
            Sonic3_AngelIsland2 = ParseBool(settings, "Sonic3_AngelIsland2", true);
            Sonic3_Hydrocity1 = ParseBool(settings, "Sonic3_Hydrocity1", true);
            Sonic3_Hydrocity2 = ParseBool(settings, "Sonic3_Hydrocity2", true);
            Sonic3_MarbleGarden1 = ParseBool(settings, "Sonic3_MarbleGarden1", true);
            Sonic3_MarbleGarden2 = ParseBool(settings, "Sonic3_MarbleGarden2", true);
            Sonic3_CarnivalNight1 = ParseBool(settings, "Sonic3_CarnivalNight1", true);
            Sonic3_CarnivalNight2 = ParseBool(settings, "Sonic3_CarnivalNight2", true);
            Sonic3_IceCap1 = ParseBool(settings, "Sonic3_IceCap1", true);
            Sonic3_IceCap2 = ParseBool(settings, "Sonic3_IceCap2", true);
            Sonic3_LaunchBase1 = ParseBool(settings, "Sonic3_LaunchBase1", true);
            Sonic3_LaunchBase2 = ParseBool(settings, "Sonic3_LaunchBase2", true);
            Sonic3_MushroomHill1 = ParseBool(settings, "Sonic3_MushroomHill1", true);
            Sonic3_MushroomHill2 = ParseBool(settings, "Sonic3_MushroomHill2", true);
            Sonic3_FlyingBattery1 = ParseBool(settings, "Sonic3_FlyingBattery1", true);
            Sonic3_FlyingBattery2 = ParseBool(settings, "Sonic3_FlyingBattery2", true);
            Sonic3_Sandopolis1 = ParseBool(settings, "Sonic3_Sandopolis1", true);
            Sonic3_Sandopolis2 = ParseBool(settings, "Sonic3_Sandopolis2", true);
            Sonic3_LavaReef1 = ParseBool(settings, "Sonic3_LavaReef1", true);
            Sonic3_LavaReef2 = ParseBool(settings, "Sonic3_LavaReef2", true);
            Sonic3_HiddenPalace = ParseBool(settings, "Sonic3_HiddenPalace", true);
            Sonic3_SkySanctuary = ParseBool(settings, "Sonic3_SkySanctuary", true);
            Sonic3_DeathEgg1 = ParseBool(settings, "Sonic3_DeathEgg1", true);
            Sonic3_DeathEgg2 = ParseBool(settings, "Sonic3_DeathEgg2", true);
            Sonic3_Doomsday = ParseBool(settings, "Sonic3_Doomsday", true);
        }

        static bool ParseBool(XmlNode settings, string setting, bool default_ = false)
        {
            return settings[setting] != null ? (bool.TryParse(settings[setting].InnerText, out bool val) ? val : default_) : default_;
        }

        static XmlElement ToElement<T>(XmlDocument document, string name, T value)
        {
            XmlElement str = document.CreateElement(name);
            str.InnerText = value.ToString();
            return str;
        }

        private void DiscordLink_LinkClicked(object sender, LinkLabelLinkClickedEventArgs e)
        {
            System.Diagnostics.Process.Start("https://discord.gg/ZgRQuEWw9W");
        }
    }
}