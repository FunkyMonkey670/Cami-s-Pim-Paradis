extension GachaData
{
    FileName = "CamiGacha";
    PropertyName = "PropCamiGacha";
    LegacyItemKey = "Item";
    ItemsKey = "Items";
    SaveInterval = 10;

    _allPlayersData = Dict();
    _dirty = false;
    _saveTimer = 10;

    function NewPlayerData()
    {
        data = Dict();
        data.Set(self.LegacyItemKey, "");
        data.Set(self.ItemsKey, List());
        return data;
    }

    function NormalizePlayerData(data)
    {
        if (data == null) {data = self.NewPlayerData(); self._dirty = true;}
        if (!data.Contains(self.LegacyItemKey)) {data.Set(self.LegacyItemKey, ""); self._dirty = true;}
        raw = data.Get(self.LegacyItemKey, "");
        if (raw == null || raw == "_") {data.Set(self.LegacyItemKey, ""); self._dirty = true;}
        if (!data.Contains(self.ItemsKey))
        {
            items = List();
            raw = data.Get(self.LegacyItemKey, "");
            if (raw != null && raw != "" && raw != "_") {items = String.Split(raw, "_", true);}
            data.Set(self.ItemsKey, items);
            self._dirty = true;
        }
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
        data = PData.LoadDataFromFile(self.FileName, self.PropertyName, false, true);
        if (data != null) {self._allPlayersData = data;}
    }

    function LoadHostPlayerData(hostServerID) {self.LoadPlayerData(hostServerID);}

    function GetItems(serverID)
    {
        data = self.LoadPlayerData(serverID);
        if (data == null) {return List();}
        items = data.Get(self.ItemsKey, List());
        if (items == null) {return List();}
        return items;
    }

    function SetItems(serverID, items)
    {
        data = self.LoadPlayerData(serverID);
        if (data == null) {return false;}
        data.Set(self.ItemsKey, items);
        data.Set(self.LegacyItemKey, String.Join(items, "_"));
        self._allPlayersData.Set(serverID, data);
        self._dirty = true;
        return true;
    }

    function HasItem(serverID, itemName)
    {
        return serverID != null && itemName != null && itemName != "" && self.GetItems(serverID).Contains(itemName);
    }

    function SaveItem(itemName, serverID)
    {
        if (!Network.IsMasterClient || serverID == null || itemName == null || itemName == "") {return false;}
        items = self.GetItems(serverID);
        if (items.Contains(itemName)) {return false;}
        items.Add(itemName);
        return self.SetItems(serverID, items);
    }

    function RemoveItemS(itemName, serverID)
    {
        if (!Network.IsMasterClient || !self.HasItem(serverID, itemName)) {return false;}
        items = self.GetItems(serverID);
        items.Remove(itemName);
        return self.SetItems(serverID, items);
    }

    function TransferItem(fromServerID, toServerID, itemName)
    {
        if (!Network.IsMasterClient || fromServerID == null || toServerID == null || fromServerID == toServerID) {return false;}
        if (!self.HasItem(fromServerID, itemName) || self.HasItem(toServerID, itemName)) {return false;}
        fromItems = self.GetItems(fromServerID);
        toItems = self.GetItems(toServerID);
        fromItems.Remove(itemName);
        toItems.Add(itemName);
        self.SetItems(fromServerID, fromItems);
        self.SetItems(toServerID, toItems);
        self.Flush();
        return true;
    }

    function LoadClientPlayerData(serverID, player)
    {
        if (!Network.IsMasterClient || player == null || serverID == null) {return;}
        serializedItems = String.Join(self.GetItems(serverID), "_");
        if (player == Network.MyPlayer) {self.LoadItemToInv(serializedItems);}
        else {Network.SendMessage(player, "YourGachaData|" + Json.SaveToString(serializedItems));}
    }

    function LoadMyData(playerID)
    {
        if (!Network.IsMasterClient)
        {
            Network.SendMessage(Network.MasterClient, "LoadMyGacha");
            return;
        }
        player = Network.FindPlayer(playerID);
        serverID = ServerID._playerServerIDs.Get(playerID);
        if (player == null || serverID == null) {return;}
        self.LoadClientPlayerData(serverID, player);
    }

    coroutine LoadItemToInv(data)
    {
        if (data == null || Interface.MainInventory == null) {return;}
        attempts = 0;
        while ((Interface.Gacha == null || Interface.Gacha._items.Count == 0) && attempts < 20)
        {
            attempts += 1;
            wait 0.1;
        }
        if (Interface.Gacha == null) {return;}
        for (itemName in String.Split(data, "_", true))
        {
            if (itemName == null || itemName == "") {continue;}
            item = Interface.Gacha._items.Get(itemName);
            if (item != null) {Interface.MainInventory.AddItem(item);}
            wait 0.02;
        }
    }

    function MigrateIdentity(oldID, newID)
    {
        if (!Network.IsMasterClient || oldID == null || newID == null || oldID == newID || !self._allPlayersData.Contains(oldID)) {return;}
        oldItems = self.GetItems(oldID);
        newItems = self.GetItems(newID);
        for (item in oldItems) {if (!newItems.Contains(item)) {newItems.Add(item);}}
        self.SetItems(newID, newItems);
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
        PData.SaveToFile(self.FileName, self.PropertyName, self._allPlayersData, false, true);
        self._dirty = false;
        self._saveTimer = self.SaveInterval;
    }
}
