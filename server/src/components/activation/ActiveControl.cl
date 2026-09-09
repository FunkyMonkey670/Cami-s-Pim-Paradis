component ActiveControl
{
    ActivatableID = 0;
    ActivatableIDTooltip = "Leave 0 to use the Activatable component from the same object.";
    Reverse = false;
    ReverseTooltip = "Reverse active and inactive behavior.";

    _activatable = null;
    _activated = true;
    _deactivatableList = List();

    function Initialize()
    {
        target = self.MapObject;
        if (self.ActivatableID > 0) {target = Map.FindMapObjectByID(self.ActivatableID);}
        if (target != null) {self._activatable = target.GetComponent("Activatable");}
        self._RegisterDeactivatableComponents();
        self._activated = self.GetDesiredState();
        if (self._activated) {self._Activate();}
        else {self._Deactivate();}
    }

    function _RegisterDeactivatableComponents()
    {
        # N/A
    }

    function OnGameStart() {self.Initialize();}

    function GetDesiredState()
    {
        if (self._activatable == null) {return true;}
        return self._activatable.IsActive() != self.Reverse;
    }

    function OnTick()
    {
        desired = self.GetDesiredState();
        if (self._activated == desired) {return;}
        self._activated = desired;
        if (desired) {self._Activate();}
        else {self._Deactivate();}
    }

    function KeepControlEnabled(name)
    {
        if (self.MapObject.GetComponent(name) != null) {self.MapObject.SetComponentEnabled(name, true);}
    }

    function _Activate()
    {
        self.MapObject.SetComponentsEnabled(true);
    }

    function _Deactivate()
    {
        self.MapObject.SetComponentsEnabled(false);
        self.KeepControlEnabled("ActiveControl");
        self.KeepControlEnabled("Activatable");
        self.KeepControlEnabled("DistanceButton");
        self.KeepControlEnabled("RegionButton");
        for (name in self._deactivatableList)
        {
            comp = self.MapObject.GetComponent(name);
            if (comp != null) {comp.OnDeactivate();}
        }
    }
}
