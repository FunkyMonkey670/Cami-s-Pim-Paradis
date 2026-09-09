component GuillotineButton
{
    GuillotineId = 0;
    GuillotineIdTooltip = "Map object ID containing the Guillotine component.";
    ButtonText = "Drop guillotine";

    _nearUntil = 0.0;
    _guillotine = null;

    function Init()
    {
        object = Map.FindMapObjectByID(Convert.ToInt(self.GuillotineId));
        if (object != null) {self._guillotine = object.GetComponent("Guillotine");}
    }

    function OnCollisionStay(obj)
    {
        if (obj != null && obj.IsCharacter && obj.IsMine) {self._nearUntil = Time.GameTime + 0.25;}
    }

    function OnTick()
    {
        if (self._guillotine != null && Time.GameTime <= self._nearUntil)
        {
            UI.SetLabelForTime(UILabelEnum.MiddleCenter, "<color=#ffad42>[" + Input.GetKeyName(InputInteractionEnum.Interact) + "]</color> " + self.ButtonText, 0.2);
        }
    }

    function OnFrame()
    {
        if (self._guillotine != null && Time.GameTime <= self._nearUntil && Input.GetKeyDown(InputInteractionEnum.Interact))
        {
            self._guillotine.Activate();
            self._nearUntil = 0.0;
        }
    }
}
