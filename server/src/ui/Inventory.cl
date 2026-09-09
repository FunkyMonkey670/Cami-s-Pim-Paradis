component Inventory
{
    DefaultWidth = 900;
    ItemsPerRow = 7;
    _enabled = false;
    _items = Dict();
    _rootContainer = null;
    _itemContainer = null;
    _lastRow = null;
    _lastRowCount = 0;

    function OnGameStart()
    {
        self.CreateInventoryUI();
        self.Hide();
    }

    function OnFrame()
    {
        if (Input.GetKeyDown(InputInteractionEnum.Interact2)) {self.ToggleEnabled();}
        elif (self._enabled && Input.GetKeyDown(InputGeneralEnum.Pause)) {Interface.CloseWindow();}
    }

    function ToggleEnabled()
    {
        if (self._enabled) {Interface.CloseWindow();}
        else {Interface.OpenWindow(self);}
    }

    function SetEnabled(enabled)
    {
        if (enabled) {self.Show();}
        else {self.Hide();}
    }

    function Show()
    {
        self.CreateInventoryUI();
        self._enabled = true;
        self._rootContainer.Active(true).Width(self.DefaultWidth, false);
        Input.SetKeyDefaultEnabled(InputHumanEnum.AttackDefault, false);
        Camera.SetCursorVisible(true);
        Camera.SetCameraLocked(true);
    }

    function Hide()
    {
        self._enabled = false;
        if (self._rootContainer != null) {self._rootContainer.Active(false);}
        Input.SetKeyDefaultEnabled(InputHumanEnum.AttackDefault, true);
        Camera.SetCursorVisible(false);
        Camera.SetCameraLocked(false);
    }

    function CreateInventoryUI()
    {
        if (self._rootContainer != null) {return;}
        self._rootContainer = UI.VisualElement()
            .Absolute(true).Width(self.DefaultWidth, false).Height(650, false)
            .AlignSelf(AlignEnum.Center).Padding(18, false)
            .BorderColor(Color("#8a8a8a")).BorderWidth(3).BorderRadius(12)
            .BackgroundColor(Color("#11151de8")).OverflowX(OverflowEnum.Hidden);
        UI.GetRootVisualElement().Add(self._rootContainer);
        vertical = UI.VisualElement().Width(100, true).Height(100, true).FlexDirection(FlexDirectionEnum.Column);
        self._rootContainer.Add(vertical);
        vertical.Add(UI.Label("CARD INVENTORY").Height(48, false).FontSize(28).FontStyle(FontStyleEnum.Bold).TextAlign(TextAlignEnum.MiddleCenter));
        scroll = UI.ScrollView().FlexGrow(1).Width(100, true).AlignSelf(AlignEnum.Center);
        vertical.Add(scroll);
        self._itemContainer = UI.VisualElement().Width(100, true).FlexDirection(FlexDirectionEnum.Column).AlignItems(AlignEnum.FlexStart);
        scroll.Add(self._itemContainer);
    }

    function AddItem(item)
    {
        if (item == null || self._items.Contains(item.GetName())) {return;}
        self.CreateInventoryUI();
        row = self.GetRow();
        button = UI.Button("", item.OnButtonClick).Margin(5, false).Width(112, false).Height(145, false);
        row.Add(button);
        vertical = UI.VisualElement().Width(100, true).Height(100, true).FlexDirection(FlexDirectionEnum.Column);
        button.Add(vertical);
        gacha = Interface.Gacha;
        rarity = "Unknown";
        color = "#ffffff";
        edition = "";
        if (gacha != null)
        {
            rarity = gacha.GetStringRarity(item.GetRarity());
            color = gacha.GetItemColor(item.GetRarity());
            edition = gacha.GetStringEdition(item.GetEdition());
        }
        label = UI.Label(item.GetName() + String.Newline + "<color=" + color + ">" + rarity + "</color>" + String.Newline + "<color=#ffdf57>" + edition + "</color>")
            .Width(100, true).Height(100, true).FontSize(12).TextWrap(true)
            .FontStyle(FontStyleEnum.Bold).TextAlign(TextAlignEnum.MiddleCenter);
        label.EnableRichText = true;
        vertical.Add(label);
        item.SetElement(button, row);
        self._items.Set(item.GetName(), item);
    }

    function RemoveItem(item)
    {
        if (item == null || !self._items.Contains(item.GetName())) {return;}
        stored = self._items.Get(item.GetName());
        if (stored != null) {stored.RemoveSelf();}
        self._items.Remove(item.GetName());
    }

    function GetRow()
    {
        if (self._lastRow == null || self._lastRowCount >= self.ItemsPerRow)
        {
            self._lastRow = UI.VisualElement().Width(100, true).FlexDirection(FlexDirectionEnum.Row).JustifyContent(JustifyEnum.FlexStart);
            self._itemContainer.Add(self._lastRow);
            self._lastRowCount = 0;
        }
        self._lastRowCount += 1;
        return self._lastRow;
    }
}
