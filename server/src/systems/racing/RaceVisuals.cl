extension RaceVisuals
{
    _palette = List(
        "#ff4d6d", "#4dabf7", "#ffd43b", "#69db7c", "#da77f2", "#ff922b",
        "#38d9a9", "#748ffc", "#f783ac", "#a9e34b", "#66d9e8", "#e599f7",
        "#ff8787", "#74c0fc", "#b197fc", "#ffc078", "#63e6be", "#91a7ff",
        "#faa2c1", "#c0eb75", "#3bc9db", "#d0bfff", "#f06595", "#20c997"
    );

    function FindAvailableSlot(assignments)
    {
        used = Set();
        for (slot in assignments.Values) {used.Add(Convert.ToInt(slot));}
        for (i in Range(self._palette.Count))
        {
            if (!used.Contains(i)) {return i;}
        }
        return self._palette.Count;
    }

    function GetColorHex(slot)
    {
        index = Convert.ToInt(slot);
        if (index >= 0 && index < self._palette.Count) {return self._palette.Get(index);}
        return "#ffffff";
    }

    function GetColor(slot) {return Color(self.GetColorHex(slot));}
}
