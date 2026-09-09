component TVZone
{
    function IsLocalHuman(obj)
    {
        return obj != null && obj.IsCharacter && obj.IsMine && obj.Type == "Human";
    }

    function OnCollisionEnter(obj) {if (self.IsLocalHuman(obj)) {TVController.SetNearby(true);}}
    function OnCollisionStay(obj)
    {
        if (!self.IsLocalHuman(obj)) {return;}
        TVController.SetNearby(true);
        UI.SetLabelForTime(UILabelEnum.MiddleCenter, "Use /play1, /play2, or /nextep.", 0.2);
    }
    function OnCollisionExit(obj) {if (self.IsLocalHuman(obj)) {TVController.SetNearby(false);}}
}
