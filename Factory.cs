using System;
using System.Reflection;
using LiveSplit.Model;
using LiveSplit.UI.Components;
using LiveSplit.SonicOrigins;

[assembly: ComponentFactory(typeof(SonicOriginsFactory))]

namespace LiveSplit.SonicOrigins
{
    public class SonicOriginsFactory : IComponentFactory
    {
        public string ComponentName => "Sonic Origins - Autosplitter";
        public string Description => "Automatic splitting and Game Time calculation";
        public ComponentCategory Category => ComponentCategory.Control;
        public string UpdateName => this.ComponentName;
        public string UpdateURL => "https://raw.githubusercontent.com/SonicSpeedrunning/LiveSplit.SonicOrigins/main/";
        public Version Version => Assembly.GetExecutingAssembly().GetName().Version;
        public string XMLURL => this.UpdateURL + "Components/update.LiveSplit.SonicOrigins.xml";
        public IComponent Create(LiveSplitState state) { return new SonicOriginsComponent(state); }
    }
}