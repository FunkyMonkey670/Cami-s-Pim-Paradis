component FastTravel
{
    Description = "Makes this object a fast-travel waypoint. Matching channels and global waypoints are connected.";
    Name = "";
    NameTooltip = "Name shown in the fast-travel menu.";
    GlobalWaypoint = false;
    GlobalWaypointTooltip = "Connect this waypoint regardless of channel.";
    Channel = "";
    ChannelTooltip = "Primary connection channel.";
    SubChannel = "";
    SubChannelTooltip = "Optional secondary connection channel.";
    HitboxSize = Vector3(4, 4, 4);

    _destinations = Dict();
    _character = null;
    _nearUntil = 0.0;
    _popupName = "";
    _popupCreated = false;

    function Init()
    {
        self._popupName = "FastTravel_" + self.MapObject.ID;
        scale = self.MapObject.Scale;
        colliderSize = Vector3(
            self.HitboxSize.X / Math.Max(0.001, Math.Abs(scale.X)),
            self.HitboxSize.Y / Math.Max(0.001, Math.Abs(scale.Y)),
            self.HitboxSize.Z / Math.Max(0.001, Math.Abs(scale.Z))
        );
        self.MapObject.AddBoxCollider("Region", "Characters", Vector3.Zero, colliderSize);
        self.RefreshDestinations();
    }

    function HasValue(value)
    {
        return value != null && value != "";
    }

    function SharesChannel(other)
    {
        if (other == null) {return false;}
        if (self.GlobalWaypoint || other.GlobalWaypoint) {return true;}
        if (self.HasValue(self.Channel) && (self.Channel == other.Channel || self.Channel == other.SubChannel)) {return true;}
        if (self.HasValue(self.SubChannel) && (self.SubChannel == other.Channel || self.SubChannel == other.SubChannel)) {return true;}
        return false;
    }

    function RefreshDestinations()
    {
        self._destinations.Clear();
        for (waypoint in Map.FindMapObjectsByComponent("FastTravel"))
        {
            if (waypoint == null || waypoint == self.MapObject) {continue;}
            comp = waypoint.GetComponent("FastTravel");
            if (!self.SharesChannel(comp)) {continue;}
            displayName = comp.Name;
            if (!self.HasValue(displayName)) {displayName = "Waypoint " + waypoint.ID;}
            if (self._destinations.Contains(displayName)) {displayName += " (" + waypoint.ID + ")";}
            self._destinations.Set(displayName, waypoint);
        }

        if (!self._popupCreated)
        {
            UI.CreatePopup(self._popupName, "Fast Travel", 400, 400);
            self._popupCreated = true;
        }
        else {UI.ClearPopup(self._popupName);}
        UI.AddPopupButtons(self._popupName, self._destinations.Keys, self._destinations.Keys);
    }

    function OnButtonClick(buttonName)
    {
        if (!self._destinations.Contains(buttonName)) {return;}
        destination = self._destinations.Get(buttonName);
        UI.HidePopup(self._popupName);
        if (destination != null && self._character != null)
        {
            self._character.Position = destination.Position;
        }
    }

    function OnFrame()
    {
        if (Time.GameTime <= self._nearUntil && Input.GetKeyDown(InputInteractionEnum.Interact))
        {
            self.RefreshDestinations();
            UI.ShowPopup(self._popupName);
        }
    }

    function OnTick()
    {
        if (Network.MyPlayer.Character == null || Time.GameTime > self._nearUntil) {self._character = null;}
    }

    function OnCollisionStay(other)
    {
        if (other == null || !other.IsCharacter || !other.IsMine || other.Type != "Human") {return;}
        self._character = other;
        self._nearUntil = Time.GameTime + 0.25;
        prompt = "<color=orange>(" + Input.GetKeyName(InputInteractionEnum.Interact) + ")</color> Fast Travel Menu";
        UI.SetLabelForTime(UILabelEnum.MiddleCenter, prompt, 0.1);
    }

    function OnCollisionExit(other)
    {
        if (other != null && other.IsCharacter && other.IsMine) {self._nearUntil = 0.0; self._character = null; UI.HidePopup(self._popupName);}
    }
}
