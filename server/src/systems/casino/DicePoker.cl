component DicePoker
{
    MinBet = 5;
    InteractionDistance = 15.0;

    _root = null;
    _container = null;
    _walletLabel = null;
    _betLabel = null;
    _dealerLabel = null;
    _playerLabel = null;
    _resultLabel = null;
    _rollBTN = null;
    _collidingHuman = null;
    _nearUntil = 0.0;
    _isActive = false;
    _currentBet = 0;
    _lastBet = 0;
    _requestPending = false;
    _lastRequests = Dict();

    function Init() {}

    function OnGameStart()
    {
        self.BuildUI();
        self.Hide();
    }

    function OnCollisionStay(obj)
    {
        if (obj == null || !obj.IsCharacter || !obj.IsMine || obj.Type != "Human") {return;}
        self._collidingHuman = obj;
        self._nearUntil = Time.GameTime + 0.25;
        if (!self._isActive) {UI.SetLabelForTime(UILabelEnum.MiddleCenter, "Press " + Input.GetKeyName(InputInteractionEnum.Function1) + " to open dice poker.", 0.2);}
    }

    function OnCollisionExit(obj)
    {
        if (obj != null && obj.IsCharacter && obj.IsMine) {self._collidingHuman = null; self._nearUntil = 0.0; self.Hide();}
    }

    function OnCharacterDie(victim, killer, killerName)
    {
        if (victim != null && victim.Type == "Human" && victim.IsMainCharacter) {self.Hide();}
    }

    function OnPlayerLeave(player)
    {
        if (Network.IsMasterClient && player != null) {self._lastRequests.Remove(player.ID);}
    }

    function OnFrame()
    {
        if (self._collidingHuman != null && Time.GameTime <= self._nearUntil && Input.GetKeyDown(InputInteractionEnum.Function1))
        {
            if (self._isActive) {self.Hide();}
            else {self.Show();}
        }
        if (self._isActive && Input.GetKeyDown(InputGeneralEnum.Pause)) {self.Hide();}
    }

    function OnTick() {if (Time.GameTime > self._nearUntil) {self._collidingHuman = null;}}

    function BuildUI()
    {
        self._root = UI.GetRootVisualElement();
        self._container = UI.VisualElement()
            .Absolute(true).Width(650, false).Height(540, false).AlignSelf(AlignEnum.Center)
            .Padding(20, false).BackgroundColor(Color("#123b20f2"))
            .BorderColor(Color("#d088f1")).BorderWidth(3).BorderRadius(14)
            .FlexDirection(FlexDirectionEnum.Column);
        self._root.Add(self._container);
        self._container.Add(UI.Label("DICE POKER").Height(45, false).FontSize(30).FontStyle(FontStyleEnum.Bold).TextAlign(TextAlignEnum.MiddleCenter));

        summary = UI.VisualElement().Height(40, false).FlexDirection(FlexDirectionEnum.Row).JustifyContent(JustifyEnum.SpaceBetween);
        self._container.Add(summary);
        self._walletLabel = UI.Label("Wallet: 0 CC").FontSize(18);
        self._betLabel = UI.Label("Bet: 0 CC").FontSize(18);
        summary.Add(self._walletLabel);
        summary.Add(self._betLabel);

        self._dealerLabel = UI.Label("Dealer" + String.Newline + "—").Height(115, false).FontSize(22).TextAlign(TextAlignEnum.MiddleCenter).BackgroundColor(Color("#1a6d09"));
        self._playerLabel = UI.Label("Player" + String.Newline + "—").Height(115, false).FontSize(22).TextAlign(TextAlignEnum.MiddleCenter).BackgroundColor(Color("#1a6d09"));
        self._container.Add(self._dealerLabel);
        self._container.Add(self._playerLabel);
        self._resultLabel = UI.Label("Choose a wager and roll.").Height(55, false).FontSize(18).TextAlign(TextAlignEnum.MiddleCenter).TextWrap(true);
        self._container.Add(self._resultLabel);

        betRow = UI.VisualElement().Height(50, false).FlexDirection(FlexDirectionEnum.Row).JustifyContent(JustifyEnum.Center);
        self._container.Add(betRow);
        betRow.Add(UI.Button("-100", self.OnMinus100Clicked).Width(90, false));
        betRow.Add(UI.Button("-5", self.OnMinus5Clicked).Width(70, false));
        betRow.Add(UI.Button("+5", self.OnBet5Clicked).Width(70, false));
        betRow.Add(UI.Button("+100", self.OnBet100Clicked).Width(90, false));
        betRow.Add(UI.Button("Last", self.OnLastClicked).Width(90, false));

        self._rollBTN = UI.Button("Roll", self.OnRollClicked).Height(52, false).Width(180, false).AlignSelf(AlignEnum.Center).BackgroundColor(Color("#d088f1"));
        self._container.Add(self._rollBTN);
        self.UpdateDisplay();
    }

    function Show()
    {
        if (self._container == null) {self.BuildUI();}
        self._isActive = true;
        self._container.Active(true);
        self.DisableInputs();
        self.UpdateDisplay();
    }

    function Hide()
    {
        self._isActive = false;
        if (self._container != null) {self._container.Active(false);}
        self.EnableInputs();
    }

    function SetBet(value)
    {
        if (self._requestPending) {return;}
        self._currentBet = Math.Clamp(Convert.ToInt(value), 0, Math.Max(0, Main.Coins));
        self.UpdateDisplay();
    }

    function OnBet5Clicked() {self.SetBet(self._currentBet + 5);}
    function OnMinus5Clicked() {self.SetBet(self._currentBet - 5);}
    function OnBet100Clicked() {self.SetBet(self._currentBet + 100);}
    function OnMinus100Clicked() {self.SetBet(self._currentBet - 100);}
    function OnLastClicked() {self.SetBet(self._lastBet);}

    function OnRollClicked()
    {
        if (self._requestPending) {return;}
        if (self._currentBet < self.MinBet) {Game.Print("Minimum dice-poker bet: " + self.MinBet + " CC."); return;}
        self._requestPending = true;
        self._resultLabel.Text = "Rolling...";
        self.UpdateDisplay();
        self.NetworkView.SendMessage(Network.MasterClient, "DP.Roll|" + self._currentBet);
    }

    function OnNetworkMessage(sender, message)
    {
        args = String.Split(message, "|", false);
        if (args.Count == 0) {return;}
        rpc = args.Get(0);
        if (sender == Network.MasterClient)
        {
            if (rpc == "DP.Result" && args.Count >= 2)
            {
                result = Json.LoadFromString(args.Get(1));
                if (result != null) {self.ApplyResult(result);}
                return;
            }
            if (rpc == "DP.Error" && args.Count >= 2)
            {
                self._requestPending = false;
                self._resultLabel.Text = args.Get(1);
                self.UpdateDisplay();
                return;
            }
        }

        if (!Network.IsMasterClient || rpc != "DP.Roll" || args.Count < 2) {return;}
        self.RollForPlayer(sender, Convert.ToInt(args.Get(1)));
    }

    function RollForPlayer(player, bet)
    {
        if (!self.AllowRequest(player)) {self.SendError(player, "Move closer to the dice-poker table."); return;}
        serverID = ServerID._playerServerIDs.Get(player.ID);
        bet = Math.Max(0, Convert.ToInt(bet));
        if (serverID == null) {self.SendError(player, "Your economy data is not ready yet."); return;}
        if (bet < self.MinBet) {self.SendError(player, "Minimum dice-poker bet: " + self.MinBet + " CC."); return;}
        if (!MoneyData.TrySpendWallet(player, serverID, bet)) {self.SendError(player, "Not enough coins."); return;}

        playerDice = self.RollHand();
        dealerDice = self.RollHand();
        playerStrength = self.EvaluateStrength(playerDice);
        dealerStrength = self.EvaluateStrength(dealerDice);
        payout = 0;
        message = "Dealer wins.";
        if (playerStrength > dealerStrength) {payout = bet * 2; message = "You win <color=#66e38f>+" + bet + " CC</color>.";}
        elif (playerStrength == dealerStrength) {payout = bet; message = "Exact tie — your bet was returned.";}
        if (payout > 0) {MoneyData.CreditWallet(player, serverID, payout);}
        MoneyData.Flush();

        result = Dict();
        result.Set("PlayerDice", playerDice);
        result.Set("DealerDice", dealerDice);
        result.Set("PlayerRank", self.GetRankName(playerStrength));
        result.Set("DealerRank", self.GetRankName(dealerStrength));
        result.Set("Message", message);
        result.Set("Wallet", MoneyData.GetWallet(serverID));
        result.Set("Bet", bet);
        self.NetworkView.SendMessage(player, "DP.Result|" + Json.SaveToString(result));
    }

    function AllowRequest(player)
    {
        if (player == null || player.Character == null || player.Character.Type != "Human") {return false;}
        if (Vector3.Distance(player.Character.Position, self.MapObject.Position) > self.InteractionDistance) {return false;}
        last = Convert.ToFloat(self._lastRequests.Get(player.ID, -100.0));
        if (Time.GameTime - last < 0.25) {return false;}
        self._lastRequests.Set(player.ID, Time.GameTime);
        return true;
    }

    function RollHand()
    {
        hand = List();
        for (i in Range(5)) {hand.Add(Random.RandomInt(1, 7));}
        hand.SortCustom(self.SortDescending);
        return hand;
    }

    function SortDescending(a, b)
    {
        if (a < b) {return 1;}
        if (a > b) {return -1;}
        return 0;
    }

    function CountFace(hand, face)
    {
        count = 0;
        for (value in hand) {if (value == face) {count += 1;}}
        return count;
    }

    function EvaluateStrength(hand)
    {
        five = 0;
        four = 0;
        triple = 0;
        highPair = 0;
        lowPair = 0;
        singles = List();
        distinct = 0;
        for (face in Range(1, 7, 1))
        {
            count = self.CountFace(hand, face);
            if (count > 0) {distinct += 1;}
            if (count == 5) {five = face;}
            elif (count == 4) {four = face;}
            elif (count == 3) {triple = face;}
            elif (count == 2)
            {
                if (face > highPair) {lowPair = highPair; highPair = face;}
                else {lowPair = face;}
            }
            elif (count == 1) {singles.Add(face);}
        }
        singles.SortCustom(self.SortDescending);
        if (five > 0) {return 8000000 + five * 10000;}
        if (four > 0) {return 7000000 + four * 10000 + singles.Get(0) * 1000;}
        if (triple > 0 && highPair > 0) {return 6000000 + triple * 10000 + highPair * 1000;}
        if (distinct == 5 && hand.Get(0) - hand.Get(4) == 4) {return 5000000 + hand.Get(0) * 10000;}
        if (triple > 0) {return 4000000 + triple * 10000 + singles.Get(0) * 1000 + singles.Get(1) * 100;}
        if (highPair > 0 && lowPair > 0) {return 3000000 + highPair * 10000 + lowPair * 1000 + singles.Get(0) * 100;}
        if (highPair > 0)
        {
            return 2000000 + highPair * 10000 + singles.Get(0) * 1000 + singles.Get(1) * 100 + singles.Get(2) * 10;
        }
        return 1000000 + hand.Get(0) * 10000 + hand.Get(1) * 1000 + hand.Get(2) * 100 + hand.Get(3) * 10 + hand.Get(4);
    }

    function GetRankName(strength)
    {
        rank = Math.Floor(strength / 1000000);
        if (rank == 8) {return "Five of a Kind";}
        if (rank == 7) {return "Four of a Kind";}
        if (rank == 6) {return "Full House";}
        if (rank == 5) {return "Straight";}
        if (rank == 4) {return "Three of a Kind";}
        if (rank == 3) {return "Two Pair";}
        if (rank == 2) {return "Pair";}
        return "High Card";
    }

    function FormatDice(hand)
    {
        text = "";
        for (value in hand)
        {
            if (text != "") {text += "   ";}
            text += "[ " + value + " ]";
        }
        return text;
    }

    function ApplyResult(result)
    {
        self._requestPending = false;
        self._lastBet = Convert.ToInt(result.Get("Bet", self._currentBet));
        self._currentBet = 0;
        Main.Coins = Convert.ToInt(result.Get("Wallet", Main.Coins));
        self._playerLabel.Text = "Player — " + result.Get("PlayerRank") + String.Newline + self.FormatDice(result.Get("PlayerDice"));
        self._dealerLabel.Text = "Dealer — " + result.Get("DealerRank") + String.Newline + self.FormatDice(result.Get("DealerDice"));
        self._resultLabel.Text = result.Get("Message", "");
        self.UpdateDisplay();
    }

    function SendError(player, text)
    {
        if (player != null) {self.NetworkView.SendMessage(player, "DP.Error|" + text);}
    }

    function UpdateDisplay()
    {
        if (self._walletLabel == null) {return;}
        self._walletLabel.Text = "Wallet: " + Main.Coins + " CC";
        self._betLabel.Text = "Bet: " + self._currentBet + " CC";
        self._rollBTN.Active(!self._requestPending);
    }

    function DisableInputs()
    {
        Camera.SetCameraLocked(true);
        Camera.SetCursorVisible(true);
        UI.SetBottomHUDActive(false);
        Input.SetHumanKeysEnabled(false);
    }

    function EnableInputs()
    {
        Camera.SetCameraLocked(false);
        Camera.SetCursorVisible(false);
        UI.SetBottomHUDActive(true);
        Input.SetHumanKeysEnabled(true);
    }

    function AddValues() {}
    function CreateDice(diceNum) {return UI.Label("[ " + diceNum + " ]");}
    function Update() {self.UpdateDisplay();}
    function ResetContainers() {}
    function RollAll() {}
    function AddValuesToDict(list) {}
    function Sort(hand) {hand.SortCustom(self.SortDescending); return hand;}
    function ComparePlayer(a, b) {return self.SortDescending(a, b);}
    function CompareDealer(a, b) {return self.SortDescending(a, b);}
    function SortAscending(a, b) {return self.SortDescending(a, b);}
    function EvaluateHand(hand) {return self.GetRankName(self.EvaluateStrength(hand));}
    function CheckDraw() {}
    function FindWinner() {return "";}
    function ResetBools() {}
    function HideButtons() {if (self._rollBTN != null) {self._rollBTN.Active(false);}}
    function ShowButtons() {if (self._rollBTN != null) {self._rollBTN.Active(true);}}
}
