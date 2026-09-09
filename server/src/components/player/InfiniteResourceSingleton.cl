extension InfiniteResourceSingleton
{
    SettingsComponentName = "InfiniteResourceSettings";
    ActiveComponentName = "__InfiniteResource_Active";
    InactiveComponentName = "__InfiniteResource_Inactive";
    SettingsComponent = null;
    ActiveComponent = null;
    InactiveComponent = null;
    ActiveHuman = null;
    MapObject = null;

    function Init()
    {
        if (self.MapObject != null) {return;}
        self.MapObject = Map.CreateMapObjectRaw("Scene,None,0,0,1,0,0,0,__InfiniteResourceSingleton_MapObject,0,0,0,0,0,0,1,1,1,None,Entities,Default,DefaultNoTint|255/255/255/255," + self.ActiveComponentName + "|," + self.InactiveComponentName + "|");
        if (self.MapObject == null) {return;}
        self.ActiveComponent = self.MapObject.GetComponent(self.ActiveComponentName);
        self.InactiveComponent = self.MapObject.GetComponent(self.InactiveComponentName);
        settingsObjects = Map.FindMapObjectsByComponent(self.SettingsComponentName);
        if (settingsObjects.Count > 0) {self.SettingsComponent = settingsObjects.Get(0).GetComponent(self.SettingsComponentName);}
        else {self.SettingsComponent = self.MapObject.AddComponent(self.SettingsComponentName);}
        self.MapObject.SetComponentEnabled(self.ActiveComponentName, false);
    }

    function Activate(human)
    {
        if (self.MapObject == null || human == null || human.Type != "Human") {return;}
        self.ActiveHuman = human;
        self.MapObject.SetComponentEnabled(self.ActiveComponentName, true);
        self.MapObject.SetComponentEnabled(self.InactiveComponentName, false);
    }

    function Deactivate()
    {
        self.ActiveHuman = null;
        if (self.MapObject == null) {return;}
        self.MapObject.SetComponentEnabled(self.ActiveComponentName, false);
        self.MapObject.SetComponentEnabled(self.InactiveComponentName, true);
    }

    function Enable()
    {
        player = Network.MyPlayer;
        if (player != null && player.Status == PlayerStatusEnum.Alive && player.Character != null && player.Character.Type == "Human") {self.Activate(player.Character);}
        else {self.Deactivate();}
    }

    function Disable()
    {
        self.Deactivate();
        if (self.MapObject != null) {self.MapObject.SetComponentEnabled(self.InactiveComponentName, false);}
    }
}
