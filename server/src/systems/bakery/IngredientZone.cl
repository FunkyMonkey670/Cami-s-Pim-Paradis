component IngredientZone
{
    function IsLocalHuman(obj) {return obj != null && obj.IsCharacter && obj.IsMine && obj.Type == "Human";}
    function OnCollisionEnter(obj) {if (self.IsLocalHuman(obj)) {HandleBakery.SetNearby("IngredientZone", true);}}
    function OnCollisionStay(obj)
    {
        if (!self.IsLocalHuman(obj)) {return;}
        HandleBakery.SetNearby("IngredientZone", true);
        UI.SetLabelForTime(UILabelEnum.MiddleCenter, "Press " + Input.GetKeyName(InputInteractionEnum.Function1) + " to gather ingredients.", 0.2);
    }
    function OnCollisionExit(obj) {if (self.IsLocalHuman(obj)) {HandleBakery.SetNearby("IngredientZone", false);}}
    function OnFrame() {}
    function OnTick() {}
}
