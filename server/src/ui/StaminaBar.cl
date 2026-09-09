extension StaminaBar
{
    MaxStamina = 100.0;
    AttackCost = 25.0;
    RegenerationRate = 10.0;
    RegenerationDelay = 5.0;

    _stamina = 100.0;
    _regenDelay = 0.0;
    _owner = null;
    _label = null;

    function OnPlayerSpawn(player, character)
    {
        if (player != Network.MyPlayer || character == null || character.Type != "Human") {return;}
        self._owner = character;
        self._stamina = self.MaxStamina;
        self._regenDelay = 0.0;
        self.EnsureUI();
        self.UpdateUI();
    }

    function EnsureUI()
    {
        if (self._label != null) {return;}
        self._label = UI.Label("Stamina: 100")
            .Absolute(true).Width(190, false).Height(30, false)
            .Bottom(55, false).Left(50, true)
            .FontSize(17).FontStyle(FontStyleEnum.Bold)
            .TextAlign(TextAlignEnum.MiddleCenter)
            .BackgroundColor(Color("#101820cc"))
            .BorderColor(Color("#23d7f7")).BorderWidth(2).BorderRadius(7);
        UI.GetRootVisualElement().Add(self._label);
    }

    function OnFrame()
    {
        character = Network.MyPlayer.Character;
        if (character == null || character != self._owner || character.Type != "Human") {return;}
        if (Input.GetKeyDown(InputHumanEnum.AttackDefault) || Input.GetKeyDown(InputHumanEnum.AttackSpecial))
        {
            self.ReduceStamina(self.AttackCost);
        }
    }

    function OnTick()
    {
        character = Network.MyPlayer.Character;
        active = character != null && character == self._owner && character.Type == "Human";
        if (self._label != null) {self._label.Active(active);}
        if (!active) {return;}
        if (self._regenDelay > 0.0) {self._regenDelay = Math.Max(0.0, self._regenDelay - Time.TickTime);}
        elif (self._stamina < self.MaxStamina)
        {
            self._stamina = Math.Min(self.MaxStamina, self._stamina + self.RegenerationRate * Time.TickTime);
        }
        self.UpdateUI();
    }

    function CanSpend(amount) {return amount > 0.0 && self._stamina >= amount;}

    function ReduceStamina(amount)
    {
        if (!self.CanSpend(amount)) {return false;}
        self._stamina = Math.Max(0.0, self._stamina - amount);
        self._regenDelay = self.RegenerationDelay;
        self.UpdateUI();
        return true;
    }

    function UpdateUI()
    {
        self.EnsureUI();
        self._label.Text = "Stamina: " + Convert.ToInt(self._stamina);
    }
}
