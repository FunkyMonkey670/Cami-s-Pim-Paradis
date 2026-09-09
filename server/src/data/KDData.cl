extension KDData
{
    FileName = "CamiKDData";
    PropName_KD = "PropCamiKD";
    _allPlayersData = Dict();
    _dirty = false;
    _saveTimer = 15;

    function NewPlayerData()
    {
        data = Dict();
        data.Set("Kills", 0);
        data.Set("Deaths", 0);
        data.Set("HighestDmg", 0);
        data.Set("TotalDmg", 0);
        return data;
    }

    function LoadPlayerData(serverID)
    {
        if (serverID == null) {return null;}
        if (!self._allPlayersData.Contains(serverID))
        {
            self._allPlayersData.Set(serverID, self.NewPlayerData());
            self._dirty = true;
        }
        return self._allPlayersData.Get(serverID);
    }

    function LoadALLPlayersData()
    {
        if (!Network.IsMasterClient) {return;}
        data = PData.LoadDataFromFile(self.FileName, self.PropName_KD, false, true);
        if (data != null) {self._allPlayersData = data;}
    }

    function SyncPlayer(serverID, player)
    {
        if (!Network.IsMasterClient || player == null) {return;}
        data = self.LoadPlayerData(serverID);
        if (data == null) {return;}
        player.Kills = Convert.ToInt(data.Get("Kills", 0));
        player.Deaths = Convert.ToInt(data.Get("Deaths", 0));
        player.HighestDamage = Convert.ToInt(data.Get("HighestDmg", 0));
        player.TotalDamage = Convert.ToInt(data.Get("TotalDmg", 0));
    }

    function RecordKill(player)
    {
        if (!Network.IsMasterClient || player == null) {return;}
        serverID = ServerID._playerServerIDs.Get(player.ID);
        data = self.LoadPlayerData(serverID);
        if (data == null) {return;}
        value = Convert.ToInt(data.Get("Kills", 0)) + 1;
        data.Set("Kills", value);
        player.Kills = value;
        self._dirty = true;
    }

    function RecordDeath(player)
    {
        if (!Network.IsMasterClient || player == null) {return;}
        serverID = ServerID._playerServerIDs.Get(player.ID);
        data = self.LoadPlayerData(serverID);
        if (data == null) {return;}
        value = Convert.ToInt(data.Get("Deaths", 0)) + 1;
        data.Set("Deaths", value);
        player.Deaths = value;
        self._dirty = true;
    }

    function RecordDamage(player, damage)
    {
        if (!Network.IsMasterClient || player == null || damage <= 0) {return;}
        serverID = ServerID._playerServerIDs.Get(player.ID);
        data = self.LoadPlayerData(serverID);
        if (data == null) {return;}
        value = Convert.ToInt(damage);
        total = Convert.ToInt(data.Get("TotalDmg", 0)) + value;
        highest = Convert.ToInt(data.Get("HighestDmg", 0));
        if (value > highest) {highest = value; data.Set("HighestDmg", highest);}
        data.Set("TotalDmg", total);
        player.HighestDamage = highest;
        player.TotalDamage = total;
        self._dirty = true;
    }

    function SetScore(player, kills, deaths)
    {
        if (!Network.IsMasterClient || player == null) {return false;}
        serverID = ServerID._playerServerIDs.Get(player.ID);
        data = self.LoadPlayerData(serverID);
        if (data == null) {return false;}
        kills = Math.Max(0, Convert.ToInt(kills));
        deaths = Math.Max(0, Convert.ToInt(deaths));
        data.Set("Kills", kills);
        data.Set("Deaths", deaths);
        player.Kills = kills;
        player.Deaths = deaths;
        self._dirty = true;
        return true;
    }

    function MigrateIdentity(oldID, newID)
    {
        if (!Network.IsMasterClient || oldID == null || oldID == "" || newID == null || newID == "" || oldID == newID) {return;}
        if (!self._allPlayersData.Contains(oldID) || self._allPlayersData.Contains(newID)) {return;}
        self._allPlayersData.Set(newID, self._allPlayersData.Get(oldID));
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
        PData.SaveToFile(self.FileName, self.PropName_KD, self._allPlayersData, false, true);
        self._dirty = false;
        self._saveTimer = 15;
    }
}
