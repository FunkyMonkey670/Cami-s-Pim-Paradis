component WaterZone
{
    function IsLocalHuman(obj) {return obj != null && obj.IsCharacter && obj.IsMine && obj.Type == "Human";}
    function OnCollisionEnter(obj) {if (self.IsLocalHuman(obj)) {HandleBakery.SetNearby("WaterZone", true);}}
    function OnCollisionStay(obj)
    {
        if (!self.IsLocalHuman(obj)) {return;}
        HandleBakery.SetNearby("WaterZone", true);
        UI.SetLabelForTime(UILabelEnum.MiddleCenter, "Press " + Input.GetKeyName(InputInteractionEnum.Function1) + " to gather water.", 0.2);
    }
    function OnCollisionExit(obj) {if (self.IsLocalHuman(obj)) {HandleBakery.SetNearby("WaterZone", false);}}
    function OnFrame() {}
    function OnTick() {}
}
