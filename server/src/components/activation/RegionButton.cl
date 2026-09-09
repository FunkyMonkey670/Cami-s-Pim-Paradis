component RegionButton
{
    DeactivateDelay = 0.0;
    DeactivateDelayTooltip = "Time after leaving the region before deactivation.";
    Reverse = false;
    ReverseTooltip = "Reverse active and inactive behavior.";

    _activatable = null;
    _timer = null;

    function Initialize()
    {
        self._timer = Timer(0.0);
        self._activatable = self.MapObject.GetComponent("Activatable");
    }

    function OnGameStart() {self.Initialize();}

    function IsLocalCharacter(obj)
    {
        return obj != null && obj.IsCharacter && obj.IsMine && (obj.Type == "Human" || obj.Type == "Titan" || obj.Type == "Shifter");
    }

    function OnCollisionStay(obj)
    {
        if (self.IsLocalCharacter(obj) && self._timer != null)
        {
            self._timer.Reset(Math.Max(0.0, self.DeactivateDelay) + 0.25);
        }
    }

    function OnCollisionExit(obj)
    {
        if (self.IsLocalCharacter(obj) && self._timer != null)
        {
            self._timer.Reset(Math.Max(0.0, self.DeactivateDelay));
        }
    }

    function OnTick()
    {
        if (self._activatable == null || self._timer == null) {return;}
        self._timer.UpdateOnTick();
        shouldActivate = (!self._timer.IsDone()) != self.Reverse;
        if (shouldActivate) {self._activatable.Activate();}
        else {self._activatable.Deactivate();}
    }

    function IsActive()
    {
        return self._activatable != null && self._activatable.IsActive();
    }
}
