component MixingZone
{
    function IsLocalHuman(obj) {return obj != null && obj.IsCharacter && obj.IsMine && obj.Type == "Human";}
    function OnCollisionEnter(obj) {if (self.IsLocalHuman(obj)) {HandleBakery.SetNearby("MixingZone", true);}}
    function OnCollisionStay(obj)
    {
        if (!self.IsLocalHuman(obj)) {return;}
        HandleBakery.SetNearby("MixingZone", true);
        UI.SetLabelForTime(UILabelEnum.MiddleCenter, "Press " + Input.GetKeyName(InputInteractionEnum.Function1) + " to mix dough.", 0.2);
    }
    function OnCollisionExit(obj) {if (self.IsLocalHuman(obj)) {HandleBakery.SetNearby("MixingZone", false);}}
    function OnTick() {}
}
