component ProofZone
{
    function IsLocalHuman(obj) {return obj != null && obj.IsCharacter && obj.IsMine && obj.Type == "Human";}
    function OnCollisionEnter(obj) {if (self.IsLocalHuman(obj)) {HandleBakery.SetNearby("ProofZone", true);}}
    function OnCollisionStay(obj)
    {
        if (!self.IsLocalHuman(obj)) {return;}
        HandleBakery.SetNearby("ProofZone", true);
        UI.SetLabelForTime(UILabelEnum.MiddleCenter, "Press " + Input.GetKeyName(InputInteractionEnum.Function1) + " to proof dough.", 0.2);
    }
    function OnCollisionExit(obj) {if (self.IsLocalHuman(obj)) {HandleBakery.SetNearby("ProofZone", false);}}
    function OnTick() {}
}
