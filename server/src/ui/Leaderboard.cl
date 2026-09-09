extension Leaderboard
{
    PopupName = "Leaderboard";
    MaxEntries = 100;
    _walletSnapshot = Dict();
    _popupCreated = false;

    function OnGameStart()
    {
        self.ResetPopup();
    }

    function ResetPopup()
    {
        if (!self._popupCreated)
        {
            UI.CreatePopup(self.PopupName, "❤ Coin Leaderboard ❤", 600, 800);
            self._popupCreated = true;
        }
        else {UI.ClearPopup(self.PopupName);}
    }

    function OnNetworkMessage(sender, message, args)
    {
        if (args.Count == 0) {return;}
        rpc = args.Get(0);
        if (sender == Network.MasterClient && (rpc == "Leaderboard.Data" || rpc == "Synced") && args.Count >= 2)
        {
            rows = Json.LoadFromString(args.Get(1));
            if (rows == null) {return;}
            self.ResetPopup();
            for (row in rows) {UI.AddPopupButton(self.PopupName, "Leaderboard.Noop", row);}
            UI.ShowPopup(self.PopupName);
            return;
        }

        if (!Network.IsMasterClient || (rpc != "Leaderboard.Request" && rpc != "SyncBoard")) {return;}
        Network.SendMessage(sender, "Leaderboard.Data|" + Json.SaveToString(self.BuildRows()));
    }

    function BuildRows()
    {
        self._walletSnapshot.Clear();
        keys = List();
        for (serverID in MoneyData._allPlayersData.Keys)
        {
            keys.Add(serverID);
            self._walletSnapshot.Set(serverID, MoneyData.GetWallet(serverID));
        }
        keys.SortCustom(self.CompareDescending);

        rows = List();
        count = Math.Min(self.MaxEntries, keys.Count);
        for (i in Range(count))
        {
            serverID = keys.Get(i);
            name = ServerID._serverIDNames.Get(serverID, "Unknown player");
            wallet = self._walletSnapshot.Get(serverID, 0);
            rows.Add("<color=#9aa0a6>#" + (i + 1) + "</color> " + name + "  <color=#66e38f>" + wallet + " CC</color>");
        }
        if (rows.Count == 0) {rows.Add("No saved players yet.");}
        return rows;
    }

    function CompareDescending(a, b)
    {
        left = self._walletSnapshot.Get(a, 0);
        right = self._walletSnapshot.Get(b, 0);
        if (left < right) {return 1;}
        if (left > right) {return -1;}
        return 0;
    }

    function Load() {}
    function Save(serverID) {}
    function SortKeys() {return self._walletSnapshot.Keys;}
    function ParseScore(rawScore) {return Convert.ToFloat(rawScore);}
}
