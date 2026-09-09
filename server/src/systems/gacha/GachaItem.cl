class GachaItem
{
    Name = "";
    Rarity = 0;
    Description = "";
    Edition = 0;
    Element = null;
    Row = null;

    function Init(name, rarity, description, edition)
    {
        self.Name = name;
        self.Rarity = rarity;
        self.Description = description;
        self.Edition = edition;
    }

    function GetName() {return self.Name;}
    function GetRarity() {return self.Rarity;}
    function GetDescription() {return self.Description;}
    function GetEdition() {return self.Edition;}

    function SetElement(element, row)
    {
        self.Element = element;
        self.Row = row;
        if (element == null) {return;}
        element.RegisterMouseEnterEventCallback(self.SetInterfaceTooltipText);
        element.RegisterMouseEnterEventCallback(Interface.TooltipOnMouseHover);
        element.RegisterMouseLeaveEventCallback(Interface.TooltipOnMouseExit);
    }

    function SetInterfaceTooltipText() {Interface.SetTooltip(self.Description);}

    function OnButtonClick()
    {
        sprite = "";
        if (Interface.Gacha != null) {sprite = Interface.Gacha.GetSprite(self.Name);}
        Interface.ShowGachaCard(self.Name, sprite, self.Description);
    }

    function Clone() {return GachaItem(self.Name, self.Rarity, self.Description, self.Edition);}

    function RemoveSelf()
    {
        if (self.Row != null && self.Element != null) {self.Row.Remove(self.Element);}
        self.Element = null;
        self.Row = null;
        Interface.TooltipOnMouseExit();
    }
}
