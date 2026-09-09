component StatChanger
{
    MinStat = 50;
    MaxStat = 100;
    Step = 5;

    _acl = 0;
    _speed = 0;
    _gas = 0;
    _components = List();
    _nearUntil = 0.0;
    _initialized = false;
    _selectedStat = "ACL";

    function Init()
    {
        self._components.Clear();
        for (obj in Map.FindMapObjectsByComponent("StatChanger"))
        {
            if (obj == null) {continue;}
            comp = obj.GetComponent("StatChanger");
            if (comp != null) {self._components.Add(comp);}
        }
    }

    function InitializeFromCharacter(character)
    {
        if (character == null || character.Type != "Human") {return;}
        acl = Math.Clamp(Math.Round(character.Acceleration), self.MinStat, self.MaxStat);
        speed = Math.Clamp(Math.Round(character.Speed), self.MinStat, self.MaxStat);
        gas = Math.Clamp(Math.Round((character.MaxGas + 35.0) / 2.0), self.MinStat, self.MaxStat);
        for (comp in self._components)
        {
            if (comp == null) {continue;}
            comp._acl = acl;
            comp._speed = speed;
            comp._gas = gas;
            comp._initialized = true;
        }
    }

    function OnCharacterReloaded(character)
    {
        if (character == null || !character.IsMainCharacter || character.Type != "Human") {return;}
        if (!self._initialized) {self.InitializeFromCharacter(character);}
        self.ApplyToCharacter(character);
    }

    function OnCollisionStay(character)
    {
        if (character == null || character != Network.MyPlayer.Character || character.Type != "Human") {return;}
        if (!self._initialized) {self.InitializeFromCharacter(character);}
        self._nearUntil = Time.GameTime + 0.25;
    }

    function OnFrame()
    {
        if (Time.GameTime > self._nearUntil) {return;}
        if (Input.GetKeyDown(InputInteractionEnum.Interact)) {self.UpdateStat(self._selectedStat, self.GetStat() + self.Step);}
        if (Input.GetKeyDown(InputInteractionEnum.Interact2)) {self.UpdateStat(self._selectedStat, self.GetStat() - self.Step);}
        if (Input.GetKeyDown(InputInteractionEnum.Interact3))
        {
            if (self._selectedStat == "ACL") {self._selectedStat = "SPEED";}
            elif (self._selectedStat == "SPEED") {self._selectedStat = "GAS";}
            else {self._selectedStat = "ACL";}
        }
    }

    function GetStat()
    {
        if (self._selectedStat == "ACL") {return self._acl;}
        if (self._selectedStat == "SPEED") {return self._speed;}
        return self._gas;
    }

    function UpdateStat(stat, amount)
    {
        amount = Math.Clamp(amount, self.MinStat, self.MaxStat);
        for (comp in self._components)
        {
            if (comp == null) {continue;}
            if (stat == "ACL") {comp._acl = amount;}
            elif (stat == "SPEED") {comp._speed = amount;}
            elif (stat == "GAS") {comp._gas = amount;}
        }
        self.ApplyToCharacter(Network.MyPlayer.Character);
    }

    function ApplyToCharacter(character)
    {
        if (character == null || character.Type != "Human") {return;}
        character.Acceleration = self._acl;
        character.Speed = self._speed;
        character.MaxGas = Convert.ToFloat((self._gas * 2.0) - 35.0);
        character.CurrentGas = character.MaxGas;
    }

    function OnTick()
    {
        if (Time.GameTime <= self._nearUntil)
        {
            prompt = self._selectedStat + ": " + self.GetStat() + String.Newline;
            prompt += "<color=orange>(" + Input.GetKeyName(InputInteractionEnum.Interact) + ")</color> +" + self.Step + String.Newline;
            prompt += "<color=orange>(" + Input.GetKeyName(InputInteractionEnum.Interact2) + ")</color> -" + self.Step + String.Newline;
            prompt += "<color=orange>(" + Input.GetKeyName(InputInteractionEnum.Interact3) + ")</color> change stat";
            UI.SetLabelForTime(UILabelEnum.MiddleCenter, prompt, 0.1);
        }
    }

    function OnCollisionExit(character)
    {
        if (character != null && character == Network.MyPlayer.Character) {self._nearUntil = 0.0;}
    }
}
