component Bank
{
    InteractionDistance = 15.0;
    RequestCooldown = 0.15;
    _nearUntil = 0.0;
    _waiting = false;
    _buttons = List("Withdraw", "Deposit");
    _amountButtons = List("All", "50", "100", "500", "1000", "5000");
    _lastRequests = Dict();

    function OnGameStart()
    {
        UI.CreatePopup("Bank", "Bank", 600, 800);
        UI.CreatePopup("Depositing", "Deposits", 600, 800);
        UI.CreatePopup("Withdrawing", "Withdrawals", 600, 800);
    }

    function OnCollisionStay(obj)
    {
        if (obj != null && obj.IsCharacter && obj.Type == "Human" && obj.IsMine) {self._nearUntil = Time.GameTime + 0.25;}
    }

    function OnCollisionExit(obj)
    {
        if (obj != null && obj.IsCharacter && obj.Type == "Human" && obj.IsMine)
        {
            self._nearUntil = 0.0;
            self.Hide();
        }
    }

    function OnTick() {}

    function OnCharacterDie(victim, killer, killerName) {if (victim != null && victim.IsMine) {self.Hide();}}

    function OnPlayerLeave(player)
    {
        if (Network.IsMasterClient && player != null) {self._lastRequests.Remove(player.ID);}
    }

    function OnFrame()
    {
        if (Time.GameTime > self._nearUntil) {return;}
        UI.SetLabelForTime("MiddleCenter", "Press " + Input.GetKeyName(InputInteractionEnum.Function1) + " to open the bank", 0.1);
        if (Input.GetKeyDown(InputInteractionEnum.Function1)) {self.Show();}
    }

    function OnButtonClick(buttonName)
    {
        if (self._waiting) {return;}
        if (buttonName == "Withdraw") {self.ShowAmounts(false); return;}
        if (buttonName == "Deposit") {self.ShowAmounts(true); return;}

        if (UI.IsPopupActive("Depositing")) {self.SendTransaction("Deposit", buttonName);}
        elif (UI.IsPopupActive("Withdrawing")) {self.SendTransaction("Withdraw", buttonName);}
    }

    function Show()
    {
        self.RequestSync();
        self.RenderBank();
        UI.ShowPopup("Bank");
    }

    function Hide()
    {
        UI.HidePopup("Bank");
        UI.HidePopup("Depositing");
        UI.HidePopup("Withdrawing");
    }

    function ShowAmounts(deposit)
    {
        popup = "Withdrawing";
        if (deposit) {popup = "Depositing";}
        UI.ClearPopup(popup);
        UI.AddPopupButtons(popup, self._amountButtons, self._amountButtons);
        UI.HidePopup("Bank");
        UI.ShowPopup(popup);
    }

    function RenderBank()
    {
        UI.ClearPopup("Bank");
        text = "In Savings: " + Main._savings + String.Newline + "In Wallet: " + Main.Coins;
        UI.AddPopupLabel("Bank", text);
        UI.AddPopupButtons("Bank", self._buttons, self._buttons);
    }

    function RequestSync()
    {
        self._waiting = true;
        self.NetworkView.SendMessage(Network.MasterClient, "Bank.SyncRequest");
    }

    function SendTransaction(action, amount)
    {
        if (amount != "All" && Convert.ToInt(amount) <= 0) {return;}
        self._waiting = true;
        self.NetworkView.SendMessage(Network.MasterClient, "Bank." + action + "|" + amount);
    }

    function OnNetworkMessage(sender, message)
    {
        args = String.Split(message, "|", false);
        if (args.Count == 0) {return;}
        rpc = args.Get(0);

        if (sender == Network.MasterClient && rpc == "Bank.Result")
        {
            if (args.Count < 5) {return;}
            self._waiting = false;
            Main.Coins = Math.Max(0, Convert.ToInt(args.Get(2)));
            Main._savings = Math.Max(0, Convert.ToInt(args.Get(3)));
            messageText = args.Get(4);
            if (messageText != "") {Game.Print(messageText);}
            if (UI.IsPopupActive("Bank")) {self.RenderBank();}
            return;
        }

        if (!Network.IsMasterClient) {return;}
        if (!self.AllowRequest(sender)) {self.SendResult(sender, false, "Move closer to the bank and wait before trying again."); return;}
        serverID = ServerID._playerServerIDs.Get(sender.ID);
        if (serverID == null) {self.SendResult(sender, false, "Bank data is not ready."); return;}

        if (rpc == "Bank.SyncRequest") {self.SendResult(sender, true, ""); return;}
        if (args.Count < 2) {self.SendResult(sender, false, "Invalid bank request."); return;}
        amount = args.Get(1);
        if (amount == "All") {amount = "all";}

        success = false;
        if (rpc == "Bank.Deposit") {success = MoneyData.Deposit(sender, serverID, amount);}
        elif (rpc == "Bank.Withdraw") {success = MoneyData.Withdraw(sender, serverID, amount);}
        else {return;}

        result = "Transaction completed.";
        if (!success) {result = "Transaction rejected: check the requested amount and available balance.";}
        self.SendResult(sender, success, result);
        if (success) {MoneyData.Flush();}
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

    function SendResult(player, success, message)
    {
        if (player == null) {return;}
        serverID = ServerID._playerServerIDs.Get(player.ID);
        wallet = 0;
        savings = 0;
        if (serverID != null)
        {
            wallet = MoneyData.GetWallet(serverID);
            savings = MoneyData.GetSavings(serverID);
        }
        self.NetworkView.SendMessage(player, "Bank.Result|" + success + "|" + wallet + "|" + savings + "|" + message);
    }
}
