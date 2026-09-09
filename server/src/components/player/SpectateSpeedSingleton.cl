extension SpectateSpeedSingleton
{
    ManagerComponentName = "zzz_SpectateSpeed_Manager";
    ActiveComponentName = "zzz_SpectateSpeed_Active";
    ManagerComponent = null;
    ActiveComponent = null;
    MapObject = null;

    function Init()
    {
        if (self.MapObject != null) {return;}
        self.MapObject = Map.CreateMapObjectRaw("Scene,None,0,0,1,0,0,0,SpectateSpeedSingletonMapObject,0,0,0,0,0,0,1,1,1,None,Entities,Default,DefaultNoTint|255/255/255/255," + self.ManagerComponentName + "|," + self.ActiveComponentName + "|");
        if (self.MapObject == null) {return;}
        self.ManagerComponent = self.MapObject.GetComponent(self.ManagerComponentName);
        self.ActiveComponent = self.MapObject.GetComponent(self.ActiveComponentName);
        self.MapObject.SetComponentEnabled(self.ActiveComponentName, false);
    }
}
