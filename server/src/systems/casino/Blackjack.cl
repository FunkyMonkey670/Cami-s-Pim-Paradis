component BlackJack
{
    MinBet = 5;
    InteractionDistance = 15.0;

    _root = null;
    _mainContainer = null;
    _walletLabel = null;
    _betLabel = null;
    _dealerLabel = null;
    _playerLabel = null;
    _resultLabel = null;
    _dealBtn = null;
    _hitBtn = null;
    _standBtn = null;
    _bet = 0;
    _isActive = false;
    _nearUntil = 0.0;
    _gameActive = false;
    _requestPending = false;

    _games = Dict();
    _lastRequests = Dict();

    function OnGameStart()
    {
        self.BuildUI();
        self.Hide();
    }

    function OnCollisionStay(obj)
    {
        if (obj == null || !obj.IsCharacter || !obj.IsMine || obj.Type != "Human") {return;}
        self._nearUntil = Time.GameTime + 0.25;
        if (!self._isActive) {UI.SetLabelForTime(UILabelEnum.MiddleCenter, "Press " + Input.GetKeyName(InputInteractionEnum.Function1) + " to open blackjack.", 0.1);}
    }

    function OnCollisionExit(obj)
    {
        if (obj != null && obj.IsCharacter && obj.IsMine) {self._nearUntil = 0.0; self.Hide();}
    }

    function OnCharacterDie(victim, killer, killerName)
    {
        if (victim != null && victim.Type == "Human" && victim.IsMainCharacter) {self.Hide();}
    }

    function OnPlayerLeave(player)
    {
        if (!Network.IsMasterClient || player == null) {return;}
        self._games.Remove(player.ID);
        self._lastRequests.Remove(player.ID);
    }

    function OnFrame()
    {
        if (Time.GameTime <= self._nearUntil && Input.GetKeyDown(InputInteractionEnum.Function1))
        {
            if (self._isActive) {self.Hide();}
            else {self.Show();}
        }
        if (self._isActive && Input.GetKeyDown(InputGeneralEnum.Pause)) {self.Hide();}
    }

    function OnTick() {}

    function BuildUI()
    {
        self._root = UI.GetRootVisualElement();
        self._mainContainer = UI.VisualElement()
            .Absolute(true)
            .Width(620, false)
            .Height(610, false)
            .AlignSelf(AlignEnum.Center)
            .Padding(18, false)
            .BackgroundColor(Color("#063d24f2"))
            .BorderColor(Color("#e6c34f"))
            .BorderWidth(3)
            .BorderRadius(14)
            .FlexDirection(FlexDirectionEnum.Column);
        self._root.Add(self._mainContainer);

        title = UI.Label("BLACKJACK")
            .Height(45, false)
            .FontSize(30)
            .FontStyle(FontStyleEnum.Bold)
            .TextAlign(TextAlignEnum.MiddleCenter);
        self._mainContainer.Add(title);

        summary = UI.VisualElement().Height(45, false).FlexDirection(FlexDirectionEnum.Row).JustifyContent(JustifyEnum.SpaceBetween);
        self._mainContainer.Add(summary);
        self._walletLabel = UI.Label("Wallet: 0 CC").FontSize(18);
        self._betLabel = UI.Label("Bet: 0 CC").FontSize(18);
        summary.Add(self._walletLabel);
        summary.Add(self._betLabel);

        self._dealerLabel = UI.Label("Dealer" + String.Newline + "No cards")
            .Height(150, false).FontSize(20).TextAlign(TextAlignEnum.MiddleCenter)
            .BackgroundColor(Color("#0b5333"));
        self._mainContainer.Add(self._dealerLabel);

        self._playerLabel = UI.Label("Player" + String.Newline + "No cards")
            .Height(150, false).FontSize(20).TextAlign(TextAlignEnum.MiddleCenter)
            .BackgroundColor(Color("#0b5333"));
        self._mainContainer.Add(self._playerLabel);

        self._resultLabel = UI.Label("Place a bet to begin.")
            .Height(55, false).FontSize(18).TextAlign(TextAlignEnum.MiddleCenter).TextWrap(true);
        self._mainContainer.Add(self._resultLabel);

        betRow = UI.VisualElement().Height(50, false).FlexDirection(FlexDirectionEnum.Row).JustifyContent(JustifyEnum.Center);
        self._mainContainer.Add(betRow);
        betRow.Add(UI.Button("-100", self.Minus100).Width(90, false));
        betRow.Add(UI.Button("-5", self.Minus5).Width(70, false));
        betRow.Add(UI.Button("+5", self.Bet5).Width(70, false));
        betRow.Add(UI.Button("+100", self.Bet100).Width(90, false));
        betRow.Add(UI.Button("All in", self.AllIn).Width(100, false));

        actionRow = UI.VisualElement().Height(55, false).FlexDirection(FlexDirectionEnum.Row).JustifyContent(JustifyEnum.Center);
        self._mainContainer.Add(actionRow);
        self._dealBtn = UI.Button("Deal", self.Deal).Width(150, false).BackgroundColor(Color("#e6c34f"));
        self._hitBtn = UI.Button("Hit", self.Hit).Width(150, false).BackgroundColor(Color("#7bd389"));
        self._standBtn = UI.Button("Stand", self.Stand).Width(150, false).BackgroundColor(Color("#f28f79"));
        actionRow.Add(self._dealBtn);
        actionRow.Add(self._hitBtn);
        actionRow.Add(self._standBtn);
        self.UpdateDisplay();
    }

    function Show()
    {
        if (self._mainContainer == null) {self.BuildUI();}
        self._isActive = true;
        self._mainContainer.Active(true);
        self.DisableInputs();
        self.UpdateDisplay();
    }

    function Hide()
    {
        if (!self._isActive && self._mainContainer != null) {self._mainContainer.Active(false); return;}
        self._isActive = false;
        if (self._mainContainer != null) {self._mainContainer.Active(false);}
        self.EnableInputs();
    }

    function SetBet(value)
    {
        if (self._gameActive || self._requestPending) {return;}
        self._bet = Math.Clamp(Convert.ToInt(value), 0, Math.Max(0, Main.Coins));
        self.UpdateDisplay();
    }

    function Bet5() {self.SetBet(self._bet + 5);}
    function Minus5() {self.SetBet(self._bet - 5);}
    function Bet100() {self.SetBet(self._bet + 100);}
    function Minus100() {self.SetBet(self._bet - 100);}
    function AllIn() {self.SetBet(Main.Coins);}

    function Deal()
    {
        if (self._requestPending || self._gameActive) {return;}
        if (self._bet < self.MinBet) {Game.Print("Minimum blackjack bet: " + self.MinBet + " CC."); return;}
        self._requestPending = true;
        self.NetworkView.SendMessage(Network.MasterClient, "BJ.Deal|" + self._bet);
    }

    function Hit()
    {
        if (!self._gameActive || self._requestPending) {return;}
        self._requestPending = true;
        self.NetworkView.SendMessage(Network.MasterClient, "BJ.Hit");
    }

    function Stand()
    {
        if (!self._gameActive || self._requestPending) {return;}
        self._requestPending = true;
        self.NetworkView.SendMessage(Network.MasterClient, "BJ.Stand");
    }

    function OnNetworkMessage(sender, message)
    {
        args = String.Split(message, "|", false);
        if (args.Count == 0) {return;}
        rpc = args.Get(0);
        if (sender == Network.MasterClient)
        {
            if (rpc == "BJ.State" && args.Count >= 2)
            {
                state = Json.LoadFromString(args.Get(1));
                if (state != null) {self.ApplyState(state);}
                return;
            }
            if (rpc == "BJ.Error" && args.Count >= 2)
            {
                self._requestPending = false;
                Game.Print(args.Get(1));
                return;
            }
        }

        if (!Network.IsMasterClient) {return;}
        if (!self.AllowRequest(sender)) {self.SendError(sender, "Move closer to the blackjack table."); return;}
        if (rpc == "BJ.Deal" && args.Count >= 2) {self.StartGame(sender, Convert.ToInt(args.Get(1)));}
        elif (rpc == "BJ.Hit") {self.PlayerHit(sender);}
        elif (rpc == "BJ.Stand") {self.PlayerStand(sender);}
    }

    function AllowRequest(player)
    {
        if (player == null || player.Character == null || player.Character.Type != "Human") {return false;}
        if (Vector3.Distance(player.Character.Position, self.MapObject.Position) > self.InteractionDistance) {return false;}
        last = Convert.ToFloat(self._lastRequests.Get(player.ID, -100.0));
        if (Time.GameTime - last < 0.1) {return false;}
        self._lastRequests.Set(player.ID, Time.GameTime);
        return true;
    }

    function StartGame(player, bet)
    {
        if (self.GetPlayingGame(player) != null) {self.SendError(player, "Finish the active blackjack hand first."); return;}
        serverID = ServerID._playerServerIDs.Get(player.ID);
        bet = Math.Max(0, Convert.ToInt(bet));
        if (serverID == null) {self.SendError(player, "Your economy data is not ready yet."); return;}
        if (bet < self.MinBet) {self.SendError(player, "Minimum blackjack bet: " + self.MinBet + " CC."); return;}
        if (!MoneyData.TrySpendWallet(player, serverID, bet)) {self.SendError(player, "Not enough coins."); return;}

        game = Dict();
        game.Set("Bet", bet);
        game.Set("Deck", self.BuildDeck());
        game.Set("PlayerHand", List());
        game.Set("DealerHand", List());
        game.Set("State", "playing");
        game.Set("Message", "Choose hit or stand.");
        game.Set("Natural", true);
        self.DealCard(game.Get("Deck"), game.Get("PlayerHand"));
        self.DealCard(game.Get("Deck"), game.Get("DealerHand"));
        self.DealCard(game.Get("Deck"), game.Get("PlayerHand"));
        self.DealCard(game.Get("Deck"), game.Get("DealerHand"));
        self._games.Set(player.ID, game);

        playerScore = self.CalculateScore(game.Get("PlayerHand"));
        dealerScore = self.CalculateScore(game.Get("DealerHand"));
        if (playerScore == 21 && dealerScore == 21) {self.FinishGame(player, game, bet, "Both sides have blackjack — push.");}
        elif (playerScore == 21) {self.FinishGame(player, game, Math.Round(bet * 2.5), "Blackjack! You win.");}
        elif (dealerScore == 21) {self.FinishGame(player, game, 0, "Dealer blackjack. You lose.");}
        else {self.SendState(player, game);}
    }

    function PlayerHit(player)
    {
        game = self.GetPlayingGame(player);
        if (game == null) {self.SendError(player, "No blackjack hand is active."); return;}
        game.Set("Natural", false);
        self.DealCard(game.Get("Deck"), game.Get("PlayerHand"));
        score = self.CalculateScore(game.Get("PlayerHand"));
        if (score > 21) {self.FinishGame(player, game, 0, "Bust. You lose.");}
        elif (score == 21) {self.ResolveDealer(player, game);}
        else {self.SendState(player, game);}
    }

    function PlayerStand(player)
    {
        game = self.GetPlayingGame(player);
        if (game == null) {self.SendError(player, "No blackjack hand is active."); return;}
        game.Set("Natural", false);
        self.ResolveDealer(player, game);
    }

    function ResolveDealer(player, game)
    {
        dealerHand = game.Get("DealerHand");
        while (self.CalculateScore(dealerHand) < 17) {self.DealCard(game.Get("Deck"), dealerHand);}
        playerScore = self.CalculateScore(game.Get("PlayerHand"));
        dealerScore = self.CalculateScore(dealerHand);
        bet = Convert.ToInt(game.Get("Bet"));
        if (dealerScore > 21) {self.FinishGame(player, game, bet * 2, "Dealer busts. You win.");}
        elif (playerScore > dealerScore) {self.FinishGame(player, game, bet * 2, "You beat the dealer.");}
        elif (playerScore == dealerScore) {self.FinishGame(player, game, bet, "Push. Your bet was returned.");}
        else {self.FinishGame(player, game, 0, "Dealer wins.");}
    }

    function FinishGame(player, game, payout, message)
    {
        payout = Math.Max(0, Convert.ToInt(payout));
        game.Set("State", "finished");
        game.Set("Message", message);
        serverID = ServerID._playerServerIDs.Get(player.ID);
        if (payout > 0 && serverID != null) {MoneyData.CreditWallet(player, serverID, payout);}
        MoneyData.Flush();
        self.SendState(player, game);
    }

    function GetPlayingGame(player)
    {
        if (player == null || !self._games.Contains(player.ID)) {return null;}
        game = self._games.Get(player.ID);
        if (game.Get("State") != "playing") {return null;}
        return game;
    }

    function BuildDeck()
    {
        deck = List();
        suits = List("hearts", "diamonds", "clubs", "spades");
        values = List("A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K");
        for (suit in suits) {for (value in values) {deck.Add(value + " of " + suit);}}
        return deck.Randomize();
    }

    function DealCard(deck, hand)
    {
        if (deck.Count == 0) {return null;}
        card = deck.Get(0);
        deck.RemoveAt(0);
        hand.Add(card);
        return card;
    }

    function CalculateScore(hand)
    {
        score = 0;
        aces = 0;
        for (card in hand)
        {
            value = String.Split(card, " ", true).Get(0);
            if (value == "A") {score += 11; aces += 1;}
            elif (value == "J" || value == "Q" || value == "K") {score += 10;}
            else {score += Convert.ToInt(value);}
        }
        while (score > 21 && aces > 0) {score -= 10; aces -= 1;}
        return score;
    }

    function SendState(player, game)
    {
        payload = Dict();
        playerHand = game.Get("PlayerHand");
        dealerHand = game.Get("DealerHand");
        visibleDealer = List();
        if (game.Get("State") == "playing")
        {
            visibleDealer.Add("Hidden card");
            if (dealerHand.Count > 1) {visibleDealer.Add(dealerHand.Get(1));}
            payload.Set("DealerScore", self.CalculateScore(List(dealerHand.Get(1))));
        }
        else
        {
            for (card in dealerHand) {visibleDealer.Add(card);}
            payload.Set("DealerScore", self.CalculateScore(dealerHand));
        }
        serverID = ServerID._playerServerIDs.Get(player.ID);
        payload.Set("PlayerHand", playerHand);
        payload.Set("DealerHand", visibleDealer);
        payload.Set("PlayerScore", self.CalculateScore(playerHand));
        payload.Set("State", game.Get("State"));
        payload.Set("Message", game.Get("Message"));
        payload.Set("Bet", game.Get("Bet"));
        payload.Set("Wallet", MoneyData.GetWallet(serverID));
        self.NetworkView.SendMessage(player, "BJ.State|" + Json.SaveToString(payload));
    }

    function SendError(player, text)
    {
        if (player != null) {self.NetworkView.SendMessage(player, "BJ.Error|" + text);}
    }

    function ApplyState(state)
    {
        self._requestPending = false;
        self._gameActive = state.Get("State") == "playing";
        self._bet = Convert.ToInt(state.Get("Bet", 0));
        Main.Coins = Convert.ToInt(state.Get("Wallet", Main.Coins));
        self._playerLabel.Text = "Player — " + state.Get("PlayerScore", 0) + String.Newline + String.Join(state.Get("PlayerHand"), String.Newline);
        self._dealerLabel.Text = "Dealer — " + state.Get("DealerScore", 0) + String.Newline + String.Join(state.Get("DealerHand"), String.Newline);
        self._resultLabel.Text = state.Get("Message", "");
        if (!self._gameActive) {self._bet = 0;}
        self.UpdateDisplay();
    }

    function UpdateDisplay()
    {
        if (self._walletLabel == null) {return;}
        self._walletLabel.Text = "Wallet: " + Main.Coins + " CC";
        self._betLabel.Text = "Bet: " + self._bet + " CC";
        self._dealBtn.Active(!self._gameActive && !self._requestPending);
        self._hitBtn.Active(self._gameActive && !self._requestPending);
        self._standBtn.Active(self._gameActive && !self._requestPending);
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

    function Reset()
    {
        self._bet = 0;
        self._gameActive = false;
        self._requestPending = false;
        self.UpdateDisplay();
    }

    function UpdateDiplay(hideCard) {self.UpdateDisplay();}
    function AddSuits() {}
    function AddValues() {}
    function Shuffle() {}
    function CreateCard(card) {return UI.Label(card);}
    function CreateHiddenCard() {return UI.Label("Hidden card");}
    function DetermineWinner() {}
}
