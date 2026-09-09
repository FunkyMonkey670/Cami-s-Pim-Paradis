extension HandleBakery
{
    SellReward = 50;
    InteractionDistance = 15.0;
    RequestCooldown = 0.25;

    _items = Dict();
    _nearZones = Set();
    _requestPending = false;
    _busy = false;
    _animationToken = 0;
    _popupCreated = false;

    _serverInventories = Dict();
    _serverBusyUntil = Dict();
    _serverActionSerial = Dict();
    _lastRequests = Dict();

    function Init()
    {
        self._items = self.NewInventory();
        self.ResetPopup();
        Network.SendMessage(Network.MasterClient, "Bakery.Sync");
    }

    function NewInventory()
    {
        inventory = Dict();
        inventory.Set("Water", 0);
        inventory.Set("Ingredients", 0);
        inventory.Set("Raw Dough", 0);
        inventory.Set("Kneaded Dough", 0);
        inventory.Set("Proofed Dough", 0);
        inventory.Set("Cookies", 0);
        return inventory;
    }

    function ResetPopup()
    {
        if (!self._popupCreated)
        {
            UI.CreatePopup("BakeryMenu", "Bakery Menu", 700, 800);
            self._popupCreated = true;
        }
        else {UI.ClearPopup("BakeryMenu");}
        self.SetMenuContent();
    }

    function SetMenuContent()
    {
        nl = String.Newline;
        text = UI.WrapStyleTag(Sprites.NPC2, "size", "4") + nl + nl;
        text += "<color=#fd8d8d>Ingredients</color>: " + self.GetCount("Ingredients") + nl + nl;
        text += "<color=#4dafff>Water</color>: " + self.GetCount("Water") + nl + nl;
        text += "<color=#fff78b>Raw Dough</color>: " + self.GetCount("Raw Dough") + nl + nl;
        text += "<color=#b0ff8b>Kneaded Dough</color>: " + self.GetCount("Kneaded Dough") + nl + nl;
        text += "<color=#51ff01>Proofed Dough</color>: " + self.GetCount("Proofed Dough") + nl + nl;
        text += "<color=#a17922>Cookies</color>: " + self.GetCount("Cookies") + nl;
        UI.AddPopupLabel("BakeryMenu", text);
    }

    function RefreshMenu()
    {
        self.ResetPopup();
        UI.ShowPopup("BakeryMenu");
    }

    function GetCount(name)
    {
        return Math.Max(0, Convert.ToInt(self._items.Get(name, 0)));
    }

    function SetNearby(zone, nearby)
    {
        if (nearby) {self._nearZones.Add(zone);}
        elif (self._nearZones.Contains(zone)) {self._nearZones.Remove(zone);}
    }

    function OnFrame()
    {
        if (Input.GetKeyDown(InputInteractionEnum.QuickSelect8))
        {
            Network.SendMessage(Network.MasterClient, "Bakery.Sync");
            self.RefreshMenu();
        }
        if (!Input.GetKeyDown(InputInteractionEnum.Function1) || self._requestPending || self._busy) {return;}
        action = self.GetNearbyAction();
        if (action == "") {return;}
        self._requestPending = true;
        Network.SendMessage(Network.MasterClient, "Bakery.Action|" + action);
    }

    function GetNearbyAction()
    {
        if (self._nearZones.Contains("Register")) {return "sell";}
        if (self._nearZones.Contains("Oven")) {return "bake";}
        if (self._nearZones.Contains("ProofZone")) {return "proof";}
        if (self._nearZones.Contains("KneadingZone")) {return "knead";}
        if (self._nearZones.Contains("MixingZone")) {return "mix";}
        if (self._nearZones.Contains("IngredientZone")) {return "ingredients";}
        if (self._nearZones.Contains("WaterZone")) {return "water";}
        return "";
    }

    function OnTick() {}

    function OnNetworkMessage(sender, message, args)
    {
        if (args.Count == 0) {return;}
        rpc = args.Get(0);
        if (sender == Network.MasterClient)
        {
            if (rpc == "Bakery.State" && args.Count >= 2)
            {
                inventory = Json.LoadFromString(args.Get(1));
                if (inventory != null) {self._items = inventory;}
                self._requestPending = false;
            }
            elif (rpc == "Bakery.Notice" && args.Count >= 2)
            {
                self._requestPending = false;
                Game.Print(args.Get(1));
            }
            elif (rpc == "Bakery.Start" && args.Count >= 3)
            {
                self._requestPending = false;
                self._busy = true;
                self._animationToken += 1;
                Game.Print("<color=#09db2c>" + args.Get(1) + "</color>");
                self.PlayActionAnimation(Convert.ToFloat(args.Get(2)), self._animationToken);
            }
            elif (rpc == "Bakery.Done" && args.Count >= 2)
            {
                self._requestPending = false;
                self._busy = false;
                self._animationToken += 1;
                Game.Print("<color=#90fa66>" + args.Get(1) + "</color>");
            }
        }

        if (!Network.IsMasterClient) {return;}
        if (rpc == "Bakery.Sync") {self.SendState(sender);}
        elif (rpc == "Bakery.Action" && args.Count >= 2) {self.HandleAction(sender, args.Get(1));}
    }

    function HandleAction(player, action)
    {
        if (player == null) {return;}
        last = Convert.ToFloat(self._lastRequests.Get(player.ID, -100.0));
        if (Time.GameTime - last < self.RequestCooldown)
        {
            self.SendNotice(player, "Please wait before using another bakery station.");
            return;
        }
        self._lastRequests.Set(player.ID, Time.GameTime);

        zone = self.GetActionZone(action);
        if (zone == "" || !self.IsNearZone(player, zone))
        {
            self.SendNotice(player, "Move closer to the bakery station.");
            return;
        }
        if (Convert.ToFloat(self._serverBusyUntil.Get(player.ID, 0.0)) > Time.GameTime)
        {
            self.SendNotice(player, "Finish the current bakery task first.");
            return;
        }

        inventory = self.GetServerInventory(player);
        if (action == "water")
        {
            self.ChangeCount(inventory, "Water", 1);
            self.SendState(player);
            self.SendNotice(player, "Collected <color=#62c6ff>+1 Water</color>.");
            return;
        }
        if (action == "ingredients")
        {
            self.ChangeCount(inventory, "Ingredients", 1);
            self.SendState(player);
            self.SendNotice(player, "Collected <color=#ffad72>+1 Ingredient</color>.");
            return;
        }
        if (action == "sell")
        {
            if (!self.TryConsume(inventory, "Cookies", 1)) {self.SendNotice(player, "You have no cookies to sell."); return;}
            serverID = ServerID._playerServerIDs.Get(player.ID);
            if (serverID == null || !MoneyData.CreditWallet(player, serverID, self.SellReward))
            {
                self.ChangeCount(inventory, "Cookies", 1);
                self.SendNotice(player, "Your economy data is not ready yet.");
                return;
            }
            MoneyData.Flush();
            self.SendState(player);
            self.SendNotice(player, "Sold one cookie for <color=#66e38f>+" + self.SellReward + " CC</color>.");
            return;
        }

        if (action == "mix")
        {
            if (!self.TryConsume(inventory, "Water", 1)) {self.SendNotice(player, "You have no water."); return;}
            if (!self.TryConsume(inventory, "Ingredients", 1))
            {
                self.ChangeCount(inventory, "Water", 1);
                self.SendNotice(player, "You have no ingredients.");
                return;
            }
            self.StartRecipe(player, action, "Raw Dough", 5.0, "Mixing", "Mixing complete");
        }
        elif (action == "knead")
        {
            if (!self.TryConsume(inventory, "Raw Dough", 1)) {self.SendNotice(player, "You have no raw dough."); return;}
            self.StartRecipe(player, action, "Kneaded Dough", 5.0, "Kneading", "Kneading complete");
        }
        elif (action == "proof")
        {
            if (!self.TryConsume(inventory, "Kneaded Dough", 1)) {self.SendNotice(player, "You have no kneaded dough."); return;}
            self.StartRecipe(player, action, "Proofed Dough", 20.0, "Proofing", "Proofing complete");
        }
        elif (action == "bake")
        {
            if (!self.TryConsume(inventory, "Proofed Dough", 1)) {self.SendNotice(player, "You have no proofed dough."); return;}
            self.StartRecipe(player, action, "Cookies", 20.0, "Baking", "Baking complete");
        }
    }

    function GetActionZone(action)
    {
        if (action == "water") {return "WaterZone";}
        if (action == "ingredients") {return "IngredientZone";}
        if (action == "mix") {return "MixingZone";}
        if (action == "knead") {return "KneadingZone";}
        if (action == "proof") {return "ProofZone";}
        if (action == "bake") {return "Oven";}
        if (action == "sell") {return "Register";}
        return "";
    }

    function IsNearZone(player, componentName)
    {
        if (player == null || player.Character == null || player.Character.Type != "Human") {return false;}
        for (obj in Map.FindMapObjectsByComponent(componentName))
        {
            if (obj != null && Vector3.Distance(player.Character.Position, obj.Position) <= self.InteractionDistance) {return true;}
        }
        return false;
    }

    function GetServerInventory(player)
    {
        key = Convert.ToString(player.ID);
        if (!self._serverInventories.Contains(key)) {self._serverInventories.Set(key, self.NewInventory());}
        return self._serverInventories.Get(key);
    }

    function ChangeCount(inventory, name, delta)
    {
        inventory.Set(name, Math.Max(0, Convert.ToInt(inventory.Get(name, 0)) + delta));
    }

    function TryConsume(inventory, name, amount)
    {
        count = Convert.ToInt(inventory.Get(name, 0));
        if (count < amount) {return false;}
        inventory.Set(name, count - amount);
        return true;
    }

    function StartRecipe(player, action, output, duration, startText, doneText)
    {
        serial = Convert.ToInt(self._serverActionSerial.Get(player.ID, 0)) + 1;
        self._serverActionSerial.Set(player.ID, serial);
        self._serverBusyUntil.Set(player.ID, Time.GameTime + duration);
        self.SendState(player);
        Network.SendMessage(player, "Bakery.Start|" + startText + "|" + duration);
        self.CompleteRecipe(player.ID, serial, output, duration, doneText);
    }

    coroutine CompleteRecipe(playerID, serial, output, duration, doneText)
    {
        wait duration;
        if (self._serverActionSerial.Get(playerID, -1) != serial) {return;}
        player = Network.FindPlayer(playerID);
        if (player == null) {return;}
        inventory = self.GetServerInventory(player);
        self.ChangeCount(inventory, output, 1);
        self._serverBusyUntil.Set(playerID, 0.0);
        self.SendState(player);
        Network.SendMessage(player, "Bakery.Done|" + doneText);
    }

    coroutine PlayActionAnimation(duration, token)
    {
        elapsed = 0.0;
        while (elapsed < duration && token == self._animationToken)
        {
            character = Network.MyPlayer.Character;
            if (character == null || character.Type != "Human") {break;}
            length = Math.Max(0.1, character.GetAnimationLength(HumanAnimationEnum.TSShootL));
            character.ForceAnimation(HumanAnimationEnum.TSShootL);
            wait length;
            elapsed += length;
        }
    }

    function SendState(player)
    {
        if (!Network.IsMasterClient || player == null) {return;}
        Network.SendMessage(player, "Bakery.State|" + Json.SaveToString(self.GetServerInventory(player)));
    }

    function SendNotice(player, text)
    {
        if (player != null) {Network.SendMessage(player, "Bakery.Notice|" + text);}
    }

    function OnPlayerLeave(player)
    {
        if (!Network.IsMasterClient || player == null) {return;}
        key = Convert.ToString(player.ID);
        if (self._serverInventories.Contains(key)) {self._serverInventories.Remove(key);}
        if (self._serverBusyUntil.Contains(player.ID)) {self._serverBusyUntil.Remove(player.ID);}
        if (self._lastRequests.Contains(player.ID)) {self._lastRequests.Remove(player.ID);}
        self._serverActionSerial.Set(player.ID, Convert.ToInt(self._serverActionSerial.Get(player.ID, 0)) + 1);
    }

    # Compatibility helpers for legacy map calls.
    function AddItem(item) {if (item != null) {self._items.Set(item.Name, self.GetCount(item.Name) + Math.Max(0, item.Count));}}
    function RemoveItem(item) {if (item != null) {self._items.Set(item.Name, Math.Max(0, self.GetCount(item.Name) - 1));}}
    function Sell() {self._requestPending = true; Network.SendMessage(Network.MasterClient, "Bakery.Action|sell");}
    function Mix() {self._requestPending = true; Network.SendMessage(Network.MasterClient, "Bakery.Action|mix");}
    function Knead() {self._requestPending = true; Network.SendMessage(Network.MasterClient, "Bakery.Action|knead");}
    function Proof() {self._requestPending = true; Network.SendMessage(Network.MasterClient, "Bakery.Action|proof");}
    function Cook() {self._requestPending = true; Network.SendMessage(Network.MasterClient, "Bakery.Action|bake");}
    function AnimLoop() {}
}
