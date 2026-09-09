extension TextUtil
{
    _color = "ffffff";

    function GetPlainText(richText)
    {
        if (richText == null || richText == "") {return "";}
        parts = String.Split(richText, "<", false);
        if (parts.Count <= 1) {return richText;}
        output = parts.Get(0);
        for (i in Range(1, parts.Count, 1))
        {
            part = parts.Get(i);
            close = String.IndexOf(part, ">");
            if (close < 0) {output += "<" + part;}
            else {output += String.Substring(part, close + 1);}
        }
        return output;
    }

    function NormalizeColor(color)
    {
        if (color == null || color == "") {return "ffffff";}
        if (String.StartsWith(color, "#")) {return String.Substring(color, 1);}
        return color;
    }

    function SetColor(color) {self._color = self.NormalizeColor(color);}
    function ColorStr(text, color) {return "<color=#" + self.NormalizeColor(color) + ">" + text + "</color>";}
    function LazyColorStr(text) {return self.ColorStr(text, self._color);}
    function SizeStr(text, size) {return "<size=" + size + ">" + text + "</size>";}
    function BoldStr(text) {return "<b>" + text + "</b>";}
}
