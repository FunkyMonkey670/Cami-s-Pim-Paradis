component UITooltip
{
    Active = false;
    Element = null;

    function Init() {self.CreateTooltip();}
    function OnGameStart() {self.CreateTooltip();}

    function CreateTooltip()
    {
        if (self.Element != null) {return;}
        self.Element = UI.Label("")
            .Absolute(true).Width(280, false).Height(260, false)
            .Padding(15, false).BorderRadius(7).BorderWidth(2)
            .BorderColor(Color("#646464")).BackgroundColor(Color("#ffffff"))
            .Color(Color("#111111")).FontSize(15).TextWrap(true)
            .OverflowX(OverflowEnum.Hidden).OverflowY(OverflowEnum.Hidden).Active(false);
        self.Element.EnableRichText = true;
        UI.GetRootVisualElement().Add(self.Element);
    }

    function SetActive(active)
    {
        self.CreateTooltip();
        self.Active = active;
        if (self.Element == null) {return;}
        if (active)
        {
            self.Element.RemoveFromHierarchy();
            UI.GetRootVisualElement().Add(self.Element);
        }
        self.Element.Active(active);
    }

    function OnFrame()
    {
        if (!self.Active || self.Element == null) {return;}
        mouse = Input.GetMousePosition();
        dimensions = Input.GetScreenDimensions();
        x = Math.Min(mouse.X + 15.0, dimensions.X - 295.0);
        y = Math.Min(dimensions.Y - mouse.Y + 5.0, dimensions.Y - 275.0);
        self.Element.Left(Math.Max(0.0, x), false).Top(Math.Max(0.0, y), false);
    }
}
