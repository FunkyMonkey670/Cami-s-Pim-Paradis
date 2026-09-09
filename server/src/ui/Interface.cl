extension Interface
{
    CurrentWindow = null;
    Tooltip = null;
    MainInventory = null;
    Gacha = null;
    _initialized = false;
    _cardPopupCreated = false;

    function Init()
    {
        if (self._initialized) {return;}
        self._initialized = true;
        inventoryObject = Map.CreateMapObjectRaw("Scene,None,13,0,1,0,0,0,PimInventory,0,0,0,0,0,0,1,1,1,None,Entities,Default,DefaultNoTint|255/255/255/255");
        tooltipObject = Map.CreateMapObjectRaw("Scene,None,13,0,1,0,0,0,PimTooltip,0,0,0,0,0,0,1,1,1,None,Entities,Default,DefaultNoTint|255/255/255/255");
        if (inventoryObject != null) {self.MainInventory = inventoryObject.AddComponent("Inventory");}
        if (tooltipObject != null) {self.Tooltip = tooltipObject.AddComponent("UITooltip");}
        if (self.MainInventory != null) {self.MainInventory.CreateInventoryUI(); self.MainInventory.Hide();}
        if (self.Tooltip != null) {self.Tooltip.CreateTooltip();}
        gachaObject = Map.FindMapObjectByComponent("Gacha");
        if (gachaObject != null) {self.Gacha = gachaObject.GetComponent("Gacha");}
    }

    function OpenWindow(window)
    {
        if (window == null) {return;}
        if (self.CurrentWindow != null && self.CurrentWindow != window) {self.CurrentWindow.SetEnabled(false);}
        self.CurrentWindow = window;
        self.CurrentWindow.SetEnabled(true);
    }

    function CloseWindow()
    {
        if (self.CurrentWindow != null) {self.CurrentWindow.SetEnabled(false);}
        self.CurrentWindow = null;
        self.TooltipOnMouseExit();
    }

    function IsCurrentWindow(window) {return self.CurrentWindow == window;}

    function SetTooltip(text)
    {
        if (self.Tooltip != null && self.Tooltip.Element != null) {self.Tooltip.Element.Text = text;}
    }

    function TooltipOnMouseHover()
    {
        if (self.Tooltip == null || self.Tooltip.Element == null) {return;}
        self.Tooltip.SetActive(true);
    }

    function TooltipOnMouseExit()
    {
        if (self.Tooltip == null || self.Tooltip.Element == null) {return;}
        self.Tooltip.SetActive(false);
    }

    function ShowGachaCard(name, sprite, description)
    {
        popup = "Pim.GachaCard";
        if (!self._cardPopupCreated)
        {
            UI.CreatePopup(popup, name, 700, 800);
            self._cardPopupCreated = true;
        }
        else {UI.ClearPopup(popup);}
        content = sprite + String.Newline + UI.WrapStyleTag(description, "size", "20");
        UI.AddPopupLabel(popup, UI.WrapStyleTag(content, "size", "4"));
        UI.ShowPopup(popup);
    }
}
