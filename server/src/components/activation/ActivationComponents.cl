component DistanceButton
{
    ActivatableID = 0;
    ActivatableIDTooltip = "Leave 0 to use the Activatable component from the same object.";
    DeactivateDelay = 0.0;
    DeactivateDelayTooltip = "Time after leaving range before deactivation.";
    Distance = 100.0;
    DistanceTooltip = "Maximum activation distance from the local player.";
    Reverse = false;
    ReverseTooltip = "Reverse active and inactive behavior.";

    _activatable = null;
    _timer = null;

    function Initialize()
    {
        self._timer = Timer(0.0);
        target = self.MapObject;
        if (self.ActivatableID > 0) {target = Map.FindMapObjectByID(self.ActivatableID);}
        if (target != null) {self._activatable = target.GetComponent("Activatable");}
    }

    function OnGameStart() {self.Initialize();}

    function OnTick()
    {
        if (self._activatable == null || self._timer == null) {return;}
        character = Network.MyPlayer.Character;
        if (character != null && Vector3.Distance(character.Position, self.MapObject.Position) <= Math.Max(0.0, self.Distance))
        {
            self._timer.Reset(Math.Max(0.0, self.DeactivateDelay) + 0.25);
        }
        self._timer.UpdateOnTick();
        self.ApplyState(!self._timer.IsDone());
    }

    function ApplyState(inRange)
    {
        shouldActivate = inRange != self.Reverse;
        if (shouldActivate) {self._activatable.Activate();}
        else {self._activatable.Deactivate();}
    }

    function IsActive()
    {
        return self._activatable != null && self._activatable.IsActive();
    }
}
