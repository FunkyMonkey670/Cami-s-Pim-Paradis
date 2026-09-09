extension MoneyData
{
    FileName = "CamiMoneyData";
    PropName_Money = "PropMoneyData";
    SavingsKey = "Money";
    WalletKey = "Wallet";
    StartingWallet = 100;
    _allPlayersData = Dict();
    _dirty = false;
    _saveTimer = 10;

    function NewPlayerData()
    {
        data = Dict();
        data.Set(self.SavingsKey, 0);
        data.Set(self.WalletKey, self.StartingWallet);
        return data;
    }

    function NormalizePlayerData(data)
    {
        if (data == null) {data = self.NewPlayerData(); self._dirty = true;}
        if (!data.Contains(self.SavingsKey)) {data.Set(self.SavingsKey, 0); self._dirty = true;}
        if (!data.Contains(self.WalletKey)) {data.Set(self.WalletKey, self.StartingWallet); self._dirty = true;}
        savings = Math.Max(0, Convert.ToInt(data.Get(self.SavingsKey, 0)));
        wallet = Math.Max(0, Convert.ToInt(data.Get(self.WalletKey, self.StartingWallet)));
        data.Set(self.SavingsKey, savings);
        data.Set(self.WalletKey, wallet);
        return data;
    }

    function LoadPlayerData(serverID)
    {
        if (serverID == null || serverID == "") {return null;}
        if (!self._allPlayersData.Contains(serverID))
        {
            self._allPlayersData.Set(serverID, self.NewPlayerData());
            self._dirty = true;
        }
        data = self.NormalizePlayerData(self._allPlayersData.Get(serverID));
        self._allPlayersData.Set(serverID, data);
        return data;
    }

    function LoadAllPlayersData()
    {
        if (!Network.IsMasterClient) {return;}
        data = PData.LoadDataFromFile(self.FileName, self.PropName_Money, false, true);
        if (data != null) {self._allPlayersData = data;}
    }

    function GetWallet(serverID)
    {
        data = self.LoadPlayerData(serverID);
        if (data == null) {return 0;}
        return Math.Max(0, Convert.ToInt(data.Get(self.WalletKey, self.StartingWallet)));
    }

    function GetSavings(serverID)
    {
        data = self.LoadPlayerData(serverID);
        if (data == null) {return 0;}
        return Math.Max(0, Convert.ToInt(data.Get(self.SavingsKey, 0)));
    }

    function LoadHostPlayerData(hostServerID)
    {
        if (!Network.IsMasterClient) {return;}
        self.SyncPlayer(Network.MyPlayer, hostServerID);
    }

    function LoadClientPlayerData(serverID, player)
    {
        if (!Network.IsMasterClient) {return;}
        self.SyncPlayer(player, serverID);
    }

    function SyncPlayer(player, serverID)
    {
        if (!Network.IsMasterClient || player == null || serverID == null) {return;}
        wallet = self.GetWallet(serverID);
        savings = self.GetSavings(serverID);
        if (player == Network.MyPlayer)
        {
            Main.Coins = wallet;
            Main._savings = savings;
        }
        else
        {
            Network.SendMessage(player, "Economy.Sync|" + wallet + "|" + savings);
        }
    }

    function SetBalances(player, serverID, wallet, savings)
    {
        if (!Network.IsMasterClient || player == null || serverID == null) {return false;}
        data = self.LoadPlayerData(serverID);
        if (data == null) {return false;}
        data.Set(self.WalletKey, Math.Max(0, Convert.ToInt(wallet)));
        data.Set(self.SavingsKey, Math.Max(0, Convert.ToInt(savings)));
        self._allPlayersData.Set(serverID, data);
        self._dirty = true;
        self.SyncPlayer(player, serverID);
        return true;
    }

    function SetWallet(player, serverID, amount)
    {
        return self.SetBalances(player, serverID, amount, self.GetSavings(serverID));
    }

    function GetBalance(serverID) {return self.GetWallet(serverID);}
    function SetBalance(player, serverID, amount) {return self.SetWallet(player, serverID, amount);}

    function CreditWallet(player, serverID, amount)
    {
        amount = Convert.ToInt(amount);
        if (amount <= 0) {return false;}
        return self.SetWallet(player, serverID, self.GetWallet(serverID) + amount);
    }

    function TrySpendWallet(player, serverID, amount)
    {
        amount = Convert.ToInt(amount);
        if (!Network.IsMasterClient || player == null || serverID == null || amount <= 0) {return false;}
        wallet = self.GetWallet(serverID);
        if (wallet < amount)
        {
            Network.SendMessage(player, "Economy.Notice|Not enough coins.");
            return false;
        }
        return self.SetWallet(player, serverID, wallet - amount);
    }

    function TrySpend(player, serverID, amount) {return self.TrySpendWallet(player, serverID, amount);}
    function Credit(player, serverID, amount) {return self.CreditWallet(player, serverID, amount);}

    function TransferWallet(sender, senderServerID, target, targetServerID, amount)
    {
        amount = Convert.ToInt(amount);
        if (!Network.IsMasterClient || sender == null || target == null || sender == target || amount <= 0) {return false;}
        if (!self.TrySpendWallet(sender, senderServerID, amount)) {return false;}
        if (!self.CreditWallet(target, targetServerID, amount))
        {
            self.CreditWallet(sender, senderServerID, amount);
            return false;
        }
        Network.SendMessage(sender, "Economy.Notice|Sent " + amount + " coins to " + target.Name + ".");
        Network.SendMessage(target, "Economy.Notice|Received " + amount + " coins from " + sender.Name + ".");
        return true;
    }

    function Transfer(sender, senderServerID, target, targetServerID, amount)
    {
        return self.TransferWallet(sender, senderServerID, target, targetServerID, amount);
    }

    function Deposit(player, serverID, amount)
    {
        if (!Network.IsMasterClient || player == null || serverID == null) {return false;}
        wallet = self.GetWallet(serverID);
        if (amount == "all") {amount = wallet;}
        else {amount = Convert.ToInt(amount);}
        if (amount <= 0 || wallet < amount) {return false;}
        return self.SetBalances(player, serverID, wallet - amount, self.GetSavings(serverID) + amount);
    }

    function Withdraw(player, serverID, amount)
    {
        if (!Network.IsMasterClient || player == null || serverID == null) {return false;}
        savings = self.GetSavings(serverID);
        if (amount == "all") {amount = savings;}
        else {amount = Convert.ToInt(amount);}
        if (amount <= 0 || savings < amount) {return false;}
        return self.SetBalances(player, serverID, self.GetWallet(serverID) + amount, savings - amount);
    }

    function SaveMoney(money, serverID)
    {
        if (!Network.IsMasterClient || serverID == null) {return;}
        player = self.FindPlayerByServerID(serverID);
        if (player == null) {return;}
        self.SetBalances(player, serverID, self.GetWallet(serverID), money);
    }

    function FindPlayerByServerID(serverID)
    {
        for (player in Network.Players)
        {
            if (ServerID._playerServerIDs.Get(player.ID) == serverID) {return player;}
        }
        return null;
    }

    function MigrateIdentity(oldID, newID)
    {
        if (!Network.IsMasterClient || oldID == null || newID == null || oldID == newID) {return;}
        if (!self._allPlayersData.Contains(oldID) || self._allPlayersData.Contains(newID)) {return;}
        self._allPlayersData.Set(newID, self.NormalizePlayerData(self._allPlayersData.Get(oldID)));
        self._allPlayersData.Remove(oldID);
        self._dirty = true;
    }

    function OnSecond()
    {
        if (!Network.IsMasterClient || !self._dirty) {return;}
        self._saveTimer -= 1;
        if (self._saveTimer <= 0) {self.Flush();}
    }

    function Flush()
    {
        if (!Network.IsMasterClient || !self._dirty) {return;}
        PData.SaveToFile(self.FileName, self.PropName_Money, self._allPlayersData, false, true);
        self._dirty = false;
        self._saveTimer = 10;
    }
}
