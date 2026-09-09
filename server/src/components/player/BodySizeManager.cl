extension BodySizeManager
{
    message_prefix = "ChangeChacterSize";
    request_prefix = "BodySizeRequest";
    character_sizes = Dict();
    MinScale = 0.25;
    MaxScale = 4.0;

    function OnChatInput(message)
    {
        args = String.Split(message, " ", true);
        if (args.Count == 0 || args.Get(0) != "/csize") {return true;}
        if (args.Count != 4 && args.Count != 5)
        {
            Game.Print("Usage: /csize [x] [y] [z], or /csize [playerID] [x] [y] [z] for operators.");
            return false;
        }
        playerID = Network.MyPlayer.ID;
        offset = 1;
        if (args.Count == 5) {playerID = Convert.ToInt(args.Get(1)); offset = 2;}
        x = Math.Clamp(Convert.ToFloat(args.Get(offset)), self.MinScale, self.MaxScale);
        y = Math.Clamp(Convert.ToFloat(args.Get(offset + 1)), self.MinScale, self.MaxScale);
        z = Math.Clamp(Convert.ToFloat(args.Get(offset + 2)), self.MinScale, self.MaxScale);
        Network.SendMessage(Network.MasterClient, self.request_prefix + " " + playerID + " " + x + " " + y + " " + z);
        return false;
    }

    function OnNetworkMessage(sender, message)
    {
        args = String.Split(message, " ", true);
        if (args.Count < 1) {return;}
        rpc = args.Get(0);
        if (Network.IsMasterClient && rpc == self.request_prefix)
        {
            if (args.Count < 5) {return;}
            playerID = Convert.ToInt(args.Get(1));
            if (playerID != sender.ID && sender != Network.MasterClient && !ServerID._authorizedUsers.Contains(sender)) {return;}
            scale = Vector3(
                Math.Clamp(Convert.ToFloat(args.Get(2)), self.MinScale, self.MaxScale),
                Math.Clamp(Convert.ToFloat(args.Get(3)), self.MinScale, self.MaxScale),
                Math.Clamp(Convert.ToFloat(args.Get(4)), self.MinScale, self.MaxScale)
            );
            Network.SendMessageAll(self.GetMessage(playerID, scale));
            return;
        }
        if (sender != Network.MasterClient || rpc != self.message_prefix || args.Count < 5) {return;}
        self.ChangeSize(
            Convert.ToInt(args.Get(1)),
            Vector3(Convert.ToFloat(args.Get(2)), Convert.ToFloat(args.Get(3)), Convert.ToFloat(args.Get(4)))
        );
    }

    function ChangeSize(playerID, scale)
    {
        player = Network.FindPlayer(playerID);
        if (player == null || player.Character == null) {return;}
        player.Character.Transform.Scale = scale;
        self.character_sizes.Set(player.Character.ViewID, scale);
    }

    function GetMessage(playerID, scale)
    {
        return String.FormatFromList(self.message_prefix + " {0} {1} {2} {3}", List(playerID, scale.X, scale.Y, scale.Z));
    }

    function OnPlayerJoin(player)
    {
        if (!Network.IsMasterClient) {return;}
        stale = List();
        for (viewID in self.character_sizes.Keys)
        {
            character = Game.FindCharacterByViewID(viewID);
            if (character == null) {stale.Add(viewID);}
            else {Network.SendMessage(player, self.GetMessage(character.Player.ID, self.character_sizes.Get(viewID)));}
        }
        for (viewID in stale) {self.character_sizes.Remove(viewID);}
    }
}
