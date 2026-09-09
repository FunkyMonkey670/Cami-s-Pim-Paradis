extension ServerID
{
    PreventAltClients = false;

    _playerServerIDs = Dict();
    _activeServerIDs = Set();
    _authorizedUsers = Set();
    _isAuthorized = false;

    _serverIDNames = Dict();
    _authorizedUserServerIDs = List();
    _bannedServerIDs = List();
    _bannedServerNames = List();

    _myServerIDFileName = "ServerID_Cami";
    _myServerIDPropName = "SID_Cami";

    _serverIDNamesFileName = "";
    _serverIDNamesPropName = "";
    _serverAdminServerIDsFileName = "";
    _serverAdminServerIdsPropName = "";
    _bannedServerIDFileName = "";
    _bannedServerIDPropName = "";
    _bannedServerNamesFileName = "";
    _bannedServerNamesPropName = "";
    _fileNameStorageFile = "FileNames_Cami";
    _sidDelayTimer = -1;

    function LoadPrivateStorageFileNames()
    {
        if (!Network.IsMasterClient) {return;}
        PrivateFileManager.SetupStorage(self._fileNameStorageFile);
    }

    function LoadFileNames()
    {
        if (!Network.IsMasterClient) {return;}
        self._serverIDNamesFileName = PrivateFileManager.LoadFileName("FileServerIDNames", false, false);
        self._serverIDNamesPropName = PrivateFileManager.LoadFileName("Prop_ServerIDNames", false, false);
        self._serverAdminServerIDsFileName = PrivateFileManager.LoadFileName("File_ServerAdminIDs", false, false);
        self._serverAdminServerIdsPropName = PrivateFileManager.LoadFileName("Prop_ServerAdminIDs", false, false);
        self._bannedServerIDFileName = PrivateFileManager.LoadFileName("File_BannedServerIDs", false, false);
        self._bannedServerIDPropName = PrivateFileManager.LoadFileName("Prop_BannedServerIDs", false, false);
        self._bannedServerNamesFileName = PrivateFileManager.LoadFileName("File_BannedServerNames", false, false);
        self._bannedServerNamesPropName = PrivateFileManager.LoadFileName("Prop_BannedServerNames", false, false);
    }

    function LoadDataFiles()
    {
        if (!Network.IsMasterClient) {return;}
        names = PData.LoadDataFromFile(self._serverIDNamesFileName, self._serverIDNamesPropName, false, true);
        admins = PData.LoadDataFromFile(self._serverAdminServerIDsFileName, self._serverAdminServerIdsPropName, false, true);
        bannedIDs = PData.LoadDataFromFile(self._bannedServerIDFileName, self._bannedServerIDPropName, false, true);
        bannedNames = PData.LoadDataFromFile(self._bannedServerNamesFileName, self._bannedServerNamesPropName, false, true);
        if (names != null) {self._serverIDNames = names;}
        if (admins != null) {self._authorizedUserServerIDs = admins;}
        if (bannedIDs != null) {self._bannedServerIDs = bannedIDs;}
        if (bannedNames != null) {self._bannedServerNames = bannedNames;}
    }

    function GeneratePlayerServerID()
    {
        return Convert.ToString(Random.RandomInt(0, 2147483647)) + "-" +
            Convert.ToString(Random.RandomInt(0, 2147483647)) + "-" +
            Convert.ToString(Random.RandomInt(0, 2147483647)) + "-" +
            Convert.ToString(Random.RandomInt(0, 2147483647));
    }

    function GetLocalLegacyID()
    {
        value = PData.LoadDataFromFile(self._myServerIDFileName, self._myServerIDPropName, true, false);
        if (value == null || value == "")
        {
            value = self.GeneratePlayerServerID();
            PData.SaveToFile(self._myServerIDFileName, self._myServerIDPropName, value, true, false);
        }
        return value;
    }

    function GetCanonicalIdentity(player, legacyID)
    {
        if (player == null) {return null;}
        if (!player.IsAnonymous && player.UserID != null && player.UserID != "") {return "user:" + player.UserID;}
        if (legacyID != null && legacyID != "" && String.Length(legacyID) >= 16)
        {
            if (String.StartsWith(legacyID, "guest:")) {return legacyID;}
            return "guest:" + legacyID;
        }
        return "session:" + player.ID;
    }

    function GetHostServerID()
    {
        if (!Network.IsMasterClient) {return;}
        self.PreventAltClients = Main.PreventAlts;
        legacyID = self.GetLocalLegacyID();
        canonicalID = self.GetCanonicalIdentity(Network.MyPlayer, legacyID);
        self.MigrateIdentity(legacyID, canonicalID);
        if (!self._authorizedUserServerIDs.Contains(canonicalID))
        {
            self._authorizedUserServerIDs.Add(canonicalID);
            self.SaveAdmins();
        }
        self.AcceptIdentity(Network.MyPlayer, canonicalID);
        self._authorizedUsers.Add(Network.MyPlayer);
        self._isAuthorized = true;
    }

    function OnPlayerJoin(player)
    {
        if (Network.IsMasterClient && player != null && player != Network.MyPlayer)
        {
            Network.SendMessage(player, "Identity.Request");
        }
    }

    function CheckIfImBanned()
    {
        if (!Network.IsMasterClient) {self._sidDelayTimer = 1;}
    }

    function DelaySIDSendOnSec()
    {
        if (Network.IsMasterClient || self._sidDelayTimer < 0) {return;}
        if (self._sidDelayTimer > 0) {self._sidDelayTimer -= 1; return;}
        self.SendSIDToHost();
        self._sidDelayTimer = -1;
    }

    function SendSIDToHost()
    {
        if (Network.IsMasterClient) {return;}
        Network.SendMessage(Network.MasterClient, "Identity.Hello|" + self.GetLocalLegacyID());
    }

    function HandleServerIDRpcs(sender, args)
    {
        if (args.Count == 0) {return;}
        rpc = args.Get(0);

        if (Network.IsMasterClient)
        {
            if ((rpc == "Identity.Hello" || rpc == "SID") && args.Count >= 2)
            {
                canonicalID = self.GetCanonicalIdentity(sender, args.Get(1));
                self.MigrateIdentity(args.Get(1), canonicalID);
                self.AcceptIdentity(sender, canonicalID);
                return;
            }
            if ((rpc == "Admin.Ban" || rpc == "PermaBanPlayer") && args.Count >= 2)
            {
                if (self.IsAuthorized(sender)) {self.BanPlayer(Network.FindPlayer(Convert.ToInt(args.Get(1))));}
                return;
            }
            if ((rpc == "Admin.Kick" || rpc == "KickPlayer") && args.Count >= 2)
            {
                if (self.IsAuthorized(sender)) {self.KickPlayer(Network.FindPlayer(Convert.ToInt(args.Get(1))));}
                return;
            }
        }

        if (sender != Network.MasterClient) {return;}
        if (rpc == "Identity.Request") {self.SendSIDToHost();}
        elif (rpc == "Admin.Authorized" || rpc == "Auth")
        {
            self._isAuthorized = true;
            Main.SetCommands();
            Game.Print("<color=#79d279>Server operator permissions granted.</color>");
        }
    }

    function AcceptIdentity(player, serverID)
    {
        if (!Network.IsMasterClient || player == null || serverID == null || serverID == "") {return false;}
        if (player.Name == null || TextUtil.GetPlainText(player.Name) == "")
        {
            Network.KickPlayer(player, "Empty name");
            return false;
        }
        if (self.CheckIfBanned(serverID, player))
        {
            Network.KickPlayer(player, "Permanently banned");
            return false;
        }
        if (self.PreventAltClients && self.IdentityInUseByOther(serverID, player))
        {
            Network.KickPlayer(player, "Alternate clients are not allowed");
            return false;
        }

        self._playerServerIDs.Set(player.ID, serverID);
        self._activeServerIDs.Add(serverID);
        self.SaveServerName(player.Name, serverID);
        if (self._authorizedUserServerIDs.Contains(serverID))
        {
            self._authorizedUsers.Add(player);
            if (player != Network.MyPlayer) {Network.SendMessage(player, "Admin.Authorized");}
        }
        MoneyData.LoadClientPlayerData(serverID, player);
        KDData.SyncPlayer(serverID, player);
        GachaData.LoadMyData(player.ID);
        return true;
    }

    function IdentityInUseByOther(serverID, player)
    {
        for (playerID in self._playerServerIDs.Keys)
        {
            if (playerID != player.ID && self._playerServerIDs.Get(playerID) == serverID) {return true;}
        }
        return false;
    }

    function IsAuthorized(player)
    {
        if (player == null) {return false;}
        if (player == Network.MasterClient) {return true;}
        serverID = self._playerServerIDs.Get(player.ID);
        return self._authorizedUsers.Contains(player) && serverID != null && self._authorizedUserServerIDs.Contains(serverID);
    }

    function HandleServerIDCommands(args)
    {
        if (args.Count == 0 || !self._isAuthorized) {return;}
        command = args.Get(0);
        if (command == "/pban")
        {
            if (args.Count < 2) {Game.Print("Usage: /pban [playerID]"); return;}
            playerID = Convert.ToInt(args.Get(1));
            if (Network.IsMasterClient) {self.BanPlayer(Network.FindPlayer(playerID));}
            else {Network.SendMessage(Network.MasterClient, "Admin.Ban|" + playerID);}
        }
        elif (command == "/tkick")
        {
            if (args.Count < 2) {Game.Print("Usage: /tkick [playerID]"); return;}
            playerID = Convert.ToInt(args.Get(1));
            if (Network.IsMasterClient) {self.KickPlayer(Network.FindPlayer(playerID));}
            else {Network.SendMessage(Network.MasterClient, "Admin.Kick|" + playerID);}
        }
        elif (command == "/auth" && Network.IsMasterClient)
        {
            if (args.Count < 2) {Game.Print("Usage: /auth [playerID]"); return;}
            self.AuthorizePlayer(Network.FindPlayer(Convert.ToInt(args.Get(1))));
        }
    }

    function AuthorizePlayer(player)
    {
        if (!Network.IsMasterClient || player == null) {return false;}
        serverID = self._playerServerIDs.Get(player.ID);
        if (serverID == null) {Game.Print("Player identity has not loaded yet."); return false;}
        if (!self._authorizedUserServerIDs.Contains(serverID)) {self._authorizedUserServerIDs.Add(serverID); self.SaveAdmins();}
        self._authorizedUsers.Add(player);
        Network.SendMessage(player, "Admin.Authorized");
        Game.Print("Granted server operator permissions to " + player.Name + ".");
        return true;
    }

    function BanPlayer(player)
    {
        if (!Network.IsMasterClient || player == null || player == Network.MasterClient) {return false;}
        serverID = self._playerServerIDs.Get(player.ID);
        self.SaveBannedName(player.Name);
        if (serverID != null && !String.StartsWith(serverID, "session:")) {self.SaveBannedServerID(serverID);}
        Network.KickPlayer(player, "Permanently banned");
        return true;
    }

    function KickPlayer(player)
    {
        if (!Network.IsMasterClient || player == null || player == Network.MasterClient) {return false;}
        Network.KickPlayer(player, "Removed by a server operator");
        return true;
    }

    function CheckIfBanned(serverID, player)
    {
        if (self._bannedServerIDs.Contains(serverID)) {return true;}
        if (player == null) {return false;}
        name = TextUtil.GetPlainText(player.Name);
        return self._bannedServerNames.Contains(name);
    }

    function SaveServerName(playerName, playerServerID)
    {
        if (!Network.IsMasterClient || playerServerID == null) {return;}
        if (!self._serverIDNames.Contains(playerServerID) || self._serverIDNames.Get(playerServerID) != playerName)
        {
            self._serverIDNames.Set(playerServerID, playerName);
            PData.SaveToFile(self._serverIDNamesFileName, self._serverIDNamesPropName, self._serverIDNames, false, true);
        }
    }

    function SaveValidServerID(serverID, playerName, playerID)
    {
        player = Network.FindPlayer(playerID);
        if (player != null) {self.AcceptIdentity(player, serverID);}
    }

    function SaveBannedPlayer(bannedID, bannedName)
    {
        self.SaveBannedName(bannedName);
        self.SaveBannedServerID(bannedID);
    }

    function SaveBannedName(bannedName)
    {
        if (!Network.IsMasterClient || bannedName == null) {return;}
        name = TextUtil.GetPlainText(bannedName);
        if (name == "" || self._bannedServerNames.Contains(name)) {return;}
        self._bannedServerNames.Add(name);
        PData.SaveToFile(self._bannedServerNamesFileName, self._bannedServerNamesPropName, self._bannedServerNames, false, true);
    }

    function SaveBannedServerID(bannedServerID)
    {
        if (!Network.IsMasterClient || bannedServerID == null || self._bannedServerIDs.Contains(bannedServerID)) {return;}
        self._bannedServerIDs.Add(bannedServerID);
        PData.SaveToFile(self._bannedServerIDFileName, self._bannedServerIDPropName, self._bannedServerIDs, false, true);
    }

    function SaveAdmins()
    {
        PData.SaveToFile(self._serverAdminServerIDsFileName, self._serverAdminServerIdsPropName, self._authorizedUserServerIDs, false, true);
    }

    function MigrateIdentity(legacyID, canonicalID)
    {
        if (!Network.IsMasterClient || legacyID == null || legacyID == "" || canonicalID == null || legacyID == canonicalID) {return;}
        MoneyData.MigrateIdentity(legacyID, canonicalID);
        KDData.MigrateIdentity(legacyID, canonicalID);
        GachaData.MigrateIdentity(legacyID, canonicalID);
        if (self._serverIDNames.Contains(legacyID) && !self._serverIDNames.Contains(canonicalID))
        {
            self._serverIDNames.Set(canonicalID, self._serverIDNames.Get(legacyID));
            self._serverIDNames.Remove(legacyID);
            PData.SaveToFile(self._serverIDNamesFileName, self._serverIDNamesPropName, self._serverIDNames, false, true);
        }
        if (self._authorizedUserServerIDs.Contains(legacyID))
        {
            if (!self._authorizedUserServerIDs.Contains(canonicalID)) {self._authorizedUserServerIDs.Add(canonicalID);}
            self._authorizedUserServerIDs.Remove(legacyID);
            self.SaveAdmins();
        }
        if (self._bannedServerIDs.Contains(legacyID) && !self._bannedServerIDs.Contains(canonicalID))
        {
            self._bannedServerIDs.Add(canonicalID);
            PData.SaveToFile(self._bannedServerIDFileName, self._bannedServerIDPropName, self._bannedServerIDs, false, true);
        }
    }

    function RemovePlayerFromStorage(player)
    {
        if (!Network.IsMasterClient || player == null) {return;}
        serverID = self._playerServerIDs.Get(player.ID);
        if (self._playerServerIDs.Contains(player.ID)) {self._playerServerIDs.Remove(player.ID);}
        if (self._authorizedUsers.Contains(player)) {self._authorizedUsers.Remove(player);}
        if (serverID == null) {return;}
        stillActive = false;
        for (otherID in self._playerServerIDs.Keys)
        {
            if (self._playerServerIDs.Get(otherID) == serverID) {stillActive = true;}
        }
        if (!stillActive && self._activeServerIDs.Contains(serverID)) {self._activeServerIDs.Remove(serverID);}
    }

    function SaveBan() {}
    function SaveMyServerID(serverID) {PData.SaveToFile(self._myServerIDFileName, self._myServerIDPropName, serverID, true, false);}
    coroutine DelayKick(delay, player, reason) {wait delay; if (player != null) {Network.KickPlayer(player, reason);}}
}
