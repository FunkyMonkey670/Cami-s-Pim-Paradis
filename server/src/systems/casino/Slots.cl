component Slots
{
    SlotSize = 120;
    SlotSpacing = 15;
    SpinDuration = 3.0;
    SpinCost = 5;
    InteractionDistance = 15.0;
    RequestCooldown = 3.25;

    _root = null;
    _mainContainer = null;
    _slots = List();
    _slotLabels = List();
    _symbols = List("#", "$", "7", "⚠", "meow", "❤︎", "-`♡´-", "★");
    _isSpinning = false;
    _requestPending = false;
    _isActive = false;
    _uiBuilt = false;
    _nearUntil = 0.0;
    _sound = null;
    _lastRequests = Dict();

    function OnGameStart()
    {
        self._sound = Map.FindMapObjectByName("slotssound");
    }

    function OnCollisionStay(obj)
    {
        if (obj != null && obj.IsCharacter && obj.Type == "Human" && obj.IsMine)
        {
            self._nearUntil = Time.GameTime + 0.25;
            if (!self._isActive) {UI.SetLabelForTime("MiddleCenter", "Press F1 to open slots", 0.1);}
        }
    }

    function OnCollisionExit(obj)
    {
        if (obj != null && obj.IsCharacter && obj.Type == "Human" && obj.IsMine)
        {
            self._nearUntil = 0.0;
            if (!self._isSpinning) {self.HideUI();}
        }
    }

    function OnTick() {}

    function OnCharacterDie(victim, killer, killerName)
    {
        if (victim != null && victim.IsMine && !self._isSpinning) {self.HideUI();}
    }

    function OnPlayerLeave(player)
    {
        if (Network.IsMasterClient && player != null) {self._lastRequests.Remove(player.ID);}
    }

    function OnFrame()
    {
        if (Time.GameTime > self._nearUntil || !Input.GetKeyDown(InputInteractionEnum.Function1)) {return;}
        if (self._isActive) {if (!self._isSpinning) {self.HideUI();}}
        else {self.ShowUI();}
    }

    function BuildUI()
    {
        self._root = UI.GetRootVisualElement();
        self._mainContainer = UI.VisualElement()
            .Absolute(true).Top(0, false).Left(0, false).Width(100, true).Height(100, true)
            .BackgroundColor(Color(0, 0, 0, 180)).JustifyContent(JustifyEnum.Center).AlignItems(AlignEnum.Center);
        self._root.Add(self._mainContainer);

        centerBox = UI.VisualElement()
            .Width(500).Height(400).BackgroundColor(Color(40, 40, 40, 255))
            .BorderRadius(15).BorderWidth(4).BorderColor(Color("#ffd700"))
            .FlexDirection(FlexDirectionEnum.Column).JustifyContent(JustifyEnum.Center).AlignItems(AlignEnum.Center);
        self._mainContainer.Add(centerBox);

        centerBox.Add(UI.Label("SLOT MACHINE").FontSize(28).Color(Color("#ffd700")).MarginTop(20).MarginBottom(30));
        slotsRow = UI.VisualElement()
            .FlexDirection(FlexDirectionEnum.Row).JustifyContent(JustifyEnum.Center)
            .AlignItems(AlignEnum.Center).MarginTop(10).MarginBottom(30);
        centerBox.Add(slotsRow);

        self._slots.Clear();
        self._slotLabels.Clear();
        for (i in Range(3))
        {
            slot = UI.VisualElement()
                .Width(self.SlotSize).Height(self.SlotSize).BackgroundColor(Color(30, 30, 30, 255))
                .BorderRadius(10).BorderWidth(3).BorderColor(Color("#ffd700"))
                .JustifyContent(JustifyEnum.Center).AlignItems(AlignEnum.Center)
                .OverflowX(OverflowEnum.Hidden).OverflowY(OverflowEnum.Hidden);
            if (i > 0) {slot.MarginLeft(self.SlotSpacing);}
            label = UI.Label("?").FontSize(36).Color(Color(255, 255, 255, 255)).TextAlign(TextAlignEnum.MiddleCenter);
            slot.Add(label);
            slotsRow.Add(slot);
            self._slots.Add(slot);
            self._slotLabels.Add(label);
        }

        centerBox.Add(UI.Button("SPIN (" + self.SpinCost + ")", self.OnSpinButtonClicked)
            .Height(55).Width(200).FontSize(22).BackgroundColor(Color(218, 165, 32, 255))
            .Color(Color(0, 0, 0, 255)).BorderRadius(8).MarginBottom(30));
        self._uiBuilt = true;
    }

    function OnSpinButtonClicked()
    {
        if (self._isSpinning || self._requestPending) {return;}
        if (Main.Coins < self.SpinCost) {Game.Print("Not enough coins."); return;}
        self._requestPending = true;
        self.NetworkView.SendMessage(Network.MasterClient, "Slots.Spin");
    }

    function OnNetworkMessage(sender, message)
    {
        args = String.Split(message, "|", false);
        if (args.Count == 0) {return;}
        rpc = args.Get(0);

        if (sender == Network.MasterClient)
        {
            if (rpc == "Slots.Rejected")
            {
                self._requestPending = false;
                if (args.Count > 1) {Game.Print(args.Get(1));}
                return;
            }
            if (rpc == "Slots.Result" && args.Count >= 5)
            {
                self._requestPending = false;
                results = List(args.Get(1), args.Get(2), args.Get(3));
                self.AnimateSpin(results, args.Get(4));
                return;
            }
        }

        if (!Network.IsMasterClient || rpc != "Slots.Spin") {return;}
        if (!self.AllowRequest(sender))
        {
            self.NetworkView.SendMessage(sender, "Slots.Rejected|Move closer to the slot machine and wait before spinning again.");
            return;
        }
        serverID = ServerID._playerServerIDs.Get(sender.ID);
        if (serverID == null || !MoneyData.TrySpendWallet(sender, serverID, self.SpinCost))
        {
            self.NetworkView.SendMessage(sender, "Slots.Rejected|Unable to start the spin.");
            return;
        }

        results = List();
        for (i in Range(3)) {results.Add(self._symbols.Get(Random.RandomInt(0, self._symbols.Count)));}
        resultText = self.ResolveResult(sender, serverID, results);
        MoneyData.Flush();
        self.NetworkView.SendMessage(sender, "Slots.Result|" + results.Get(0) + "|" + results.Get(1) + "|" + results.Get(2) + "|" + resultText);
    }

    function AllowRequest(player)
    {
        if (player == null || player.Character == null || player.Character.Type != "Human") {return false;}
        if (Vector3.Distance(player.Character.Position, self.MapObject.Position) > self.InteractionDistance) {return false;}
        last = Convert.ToFloat(self._lastRequests.Get(player.ID, -100.0));
        if (Time.GameTime - last < self.RequestCooldown) {return false;}
        self._lastRequests.Set(player.ID, Time.GameTime);
        return true;
    }

    function ResolveResult(player, serverID, results)
    {
        unique = results.ToSet().Count;
        if (unique == 1 && results.Get(0) == "⚠")
        {
            penalty = Math.Min(195, MoneyData.GetWallet(serverID));
            if (penalty > 0) {MoneyData.SetWallet(player, serverID, MoneyData.GetWallet(serverID) - penalty);}
            return "Disaster: lost " + (self.SpinCost + penalty) + " coins.";
        }
        if (unique == 1)
        {
            prize = Random.RandomInt(10, 50);
            MoneyData.CreditWallet(player, serverID, self.SpinCost + prize);
            return "Jackpot: won " + prize + " coins!";
        }
        if (unique == 2)
        {
            MoneyData.CreditWallet(player, serverID, self.SpinCost + 5);
            return "Match: won 5 coins!";
        }
        return "No match: lost " + self.SpinCost + " coins.";
    }

    coroutine AnimateSpin(results, resultText)
    {
        if (self._isSpinning || self._slotLabels.Count != 3) {return;}
        self._isSpinning = true;
        if (self._sound != null) {self._sound.Active = true;}

        elapsed = 0.0;
        interval = 0.05;
        while (elapsed < self.SpinDuration)
        {
            for (i in Range(self._slotLabels.Count))
            {
                self._slotLabels.Get(i).Text = self._symbols.Get(Random.RandomInt(0, self._symbols.Count));
            }
            wait interval;
            elapsed += interval;
            interval = Math.Min(0.25, interval * 1.15);
        }

        for (i in Range(self._slotLabels.Count))
        {
            label = self._slotLabels.Get(i);
            symbol = results.Get(i);
            label.Text = symbol;
            if (symbol == "7") {label.Color(Color(255, 70, 70, 255));}
            elif (symbol == "#") {label.Color(Color(255, 215, 0, 255));}
            else {label.Color(Color(255, 255, 255, 255));}
        }
        if (self._sound != null) {self._sound.Active = false;}
        self._isSpinning = false;
        Game.Print(resultText + " Wallet: " + Main.Coins);
    }

    function ShowUI()
    {
        if (!self._uiBuilt) {self.BuildUI();}
        self._mainContainer.Active(true);
        self._isActive = true;
        UI.ForceHideNames = true;
        UI.SetLabelActive("MiddleCenter", false);
        Input.SetHumanKeysEnabled(false);
        Camera.SetCursorVisible(true);
    }

    function HideUI()
    {
        if (!self._isActive) {return;}
        if (self._mainContainer != null) {self._mainContainer.Active(false);}
        self._isActive = false;
        UI.ForceHideNames = false;
        Camera.SetCursorVisible(false);
        Input.SetHumanKeysEnabled(true);
        UI.SetLabelActive("MiddleCenter", true);
    }
}
