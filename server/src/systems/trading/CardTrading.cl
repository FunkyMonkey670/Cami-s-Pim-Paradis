extension CardTrading
{
    RequestCooldown = 1.0;
    _initialized = false;
    _lastRequests = Dict();

    function Init()
    {
        if (self._initialized) {return;}
        self._initialized = true;
        Commands.RegisterCommand("trade", self.TradeCmd, "/trade [playerID] [card name]");
    }

    function OnNetworkMessage(sender, message, args)
    {
        if (args.Count == 0) {return;}
        rpc = args.Get(0);
        if (sender == Network.MasterClient)
        {
            if (rpc == "Trade.Receive" && args.Count >= 3)
            {
                cardName = args.Get(1);
                Game.Print("<color=#78e7ff>" + args.Get(2) + "</color> gave you <color=#ffd166>" + cardName + "</color>.");
                if (Interface.Gacha != null && Interface.MainInventory != null)
                {
                    item = Interface.Gacha._items.Get(cardName);
                    if (item != null) {Interface.MainInventory.AddItem(item);}
                }
            }
            elif (rpc == "Trade.Sent" && args.Count >= 3)
            {
                cardName = args.Get(1);
                if (Interface.Gacha != null && Interface.MainInventory != null)
                {
                    item = Interface.Gacha._items.Get(cardName);
                    if (item != null) {Interface.MainInventory.RemoveItem(item);}
                }
                Game.Print("Gave <color=#78e7ff>" + args.Get(2) + "</color> <color=#ffd166>" + cardName + "</color>.");
            }
            elif (rpc == "Trade.Failed" && args.Count >= 2) {Game.Print(args.Get(1));}
            return;
        }

        if (!Network.IsMasterClient || sender == null || rpc != "Trade.Request" || args.Count < 3) {return;}
        last = Convert.ToFloat(self._lastRequests.Get(sender.ID, -100.0));
        if (Time.GameTime - last < self.RequestCooldown) {return;}
        self._lastRequests.Set(sender.ID, Time.GameTime);
        targetID = Convert.ToInt(args.Get(1));
        itemName = args.Get(2);
        target = Network.FindPlayer(targetID);
        senderServerID = ServerID._playerServerIDs.Get(sender.ID);
        targetServerID = ServerID._playerServerIDs.Get(targetID);
        if (target == null || target == sender || senderServerID == null || targetServerID == null)
        {
            Network.SendMessage(sender, "Trade.Failed|Invalid trade target.");
            return;
        }
        if (Interface.Gacha == null || !Interface.Gacha._items.Contains(itemName) || !GachaData.TransferItem(senderServerID, targetServerID, itemName))
        {
            Network.SendMessage(sender, "Trade.Failed|Trade failed: verify card ownership and recipient inventory.");
            return;
        }
        senderName = String.Replace(sender.Name, "|", "/");
        targetName = String.Replace(target.Name, "|", "/");
        Network.SendMessage(sender, "Trade.Sent|" + itemName + "|" + targetName);
        Network.SendMessage(target, "Trade.Receive|" + itemName + "|" + senderName);
    }

    function TradeCmd(cmd, args)
    {
        if (args.Count < 2) {Game.Print("Usage: /trade [playerID] [card name]"); return;}
        targetID = Convert.ToInt(args.Get(0));
        cardName = "";
        for (i in Range(1, args.Count, 1))
        {
            if (cardName != "") {cardName += " ";}
            cardName += Convert.ToString(args.Get(i));
        }
        if (Interface.MainInventory == null || !Interface.MainInventory._items.Contains(cardName))
        {
            Game.Print("You do not own that card.");
            return;
        }
        target = Network.FindPlayer(targetID);
        if (target == null || target == Network.MyPlayer) {Game.Print("Choose another connected player."); return;}
        Network.SendMessage(Network.MasterClient, "Trade.Request|" + targetID + "|" + cardName);
    }
}
