class BakeryItem
{
    Name = "";
    Count = 0;

    function Init(name, count)
    {
        self.Name = name;
        self.Count = Math.Max(0, Convert.ToInt(count));
    }
}
