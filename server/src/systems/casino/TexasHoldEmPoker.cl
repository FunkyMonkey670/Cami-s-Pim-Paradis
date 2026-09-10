component TexasHoldEmPoker
{
    SmallBlind = 10;
    BigBlind = 20;
    MinRaise = 20;
    TurnTimeout = 30.0;
    InteractionDistance = 25.0;

    _isActive = false;
    _collidingHuman = null;
    _root = null;
    _container = null;
    _tableLabel = null;
    _opponentsLabel = null;
    _communityLabel = null;
    _handLabel = null;
    _messageLabel = null;
    _walletLabel = null;
    _readyBTN = null;
    _checkBTN = null;
    _callBTN = null;
    _raiseBTN = null;
    _foldBTN = null;
    _allInBTN = null;
    _leaveBTN = null;
    _requestPending = false;
    _nearUntil = 0.0;
    _raisePopupCreated = false;
    _myHand = List();
    _communityCards = List();

    _seats = Dict();
    _seatByPlayer = Dict();
    _viewers = Set();
    _readyPlayers = Set();
    _handPlayers = List();
    _hands = Dict();
    _deck = List();
    _folded = Set();
    _allIn = Set();
    _acted = Set();
    _roundBets = Dict();
    _totalBets = Dict();
    _payouts = Dict();
    _communityCardsHost = List();
    _handActive = false;
    _phase = 0;
    _pot = 0;
    _currentBet = 0;
    _currentTurn = -1;
    _turnIndex = -1;
    _turnDeadline = 0.0;
    _dealerCursor = -1;
    _dealerID = -1;
    _smallBlindID = -1;
    _bigBlindID = -1;
    _handGeneration = 0;
    _lastRequests = Dict();

    function OnGameStart()
    {
        for (slot in Range(1, 5, 1)) {self._seats.Set("P" + slot, -1);}
        self.BuildUI();
        self.Hide();
    }

    function OnCollisionStay(obj)
    {
        if (obj == null || !obj.IsCharacter || !obj.IsMine || obj.Type != "Human") {return;}
        self._collidingHuman = obj;
        self._nearUntil = Time.GameTime + 0.25;
        if (!self._isActive) {UI.SetLabelForTime(UILabelEnum.MiddleCenter, "Press " + Input.GetKeyName(InputInteractionEnum.Function1) + " to open poker.", 0.2);}
    }

    function OnCollisionExit(obj)
    {
        if (obj != null && obj.IsCharacter && obj.IsMine) {self._collidingHuman = null; self._nearUntil = 0.0;}
    }

    function OnFrame()
    {
        if (self._collidingHuman != null && Time.GameTime <= self._nearUntil && Input.GetKeyDown(InputInteractionEnum.Function1))
        {
            if (self._isActive) {self.Hide();}
            else {self.Show();}
        }
        if (self._isActive && Input.GetKeyDown(InputGeneralEnum.Pause)) {self.Hide();}
        if (Time.GameTime > self._nearUntil) {self._collidingHuman = null;}
    }

    function OnSecond()
    {
        if (!Network.IsMasterClient || !self._handActive || self._currentTurn < 0 || Time.GameTime < self._turnDeadline) {return;}
        player = Network.FindPlayer(self._currentTurn);
        if (player == null) {self.FoldHost(self._currentTurn, "Disconnected"); return;}
        if (Convert.ToInt(self._roundBets.Get(self._currentTurn, 0)) >= self._currentBet)
        {
            self.CheckHost(self._currentTurn, "Turn timed out — automatic check.");
        }
        else {self.FoldHost(self._currentTurn, "Turn timed out — automatic fold.");}
    }

    function OnPlayerLeave(player)
    {
        if (!Network.IsMasterClient || player == null) {return;}
        self._viewers.Remove(player.ID);
        self._readyPlayers.Remove(player.ID);
        self.ForceFold(player.ID, self.SafeName(player) + " left the table.");
        self.RemoveSeat(player.ID);
        self.SendStateToAll("Table updated.", false);
    }

    function SendMessageToPlayers(message)
    {
        for (playerID in self.GetSeatedPlayerIDs())
        {
            player = Network.FindPlayer(playerID);
            if (player != null) {self.NetworkView.SendMessage(player, message);}
        }
    }

    function OnNetworkMessage(sender, message)
    {
        args = String.Split(message, "|", false);
        if (args.Count == 0) {return;}
        rpc = args.Get(0);

        if (sender == Network.MasterClient)
        {
            if (rpc == "Poker.State" && args.Count >= 2)
            {
                state = Json.LoadFromString(args.Get(1));
                if (state != null) {self.ApplyState(state);}
                return;
            }
            if (rpc == "Poker.Error" && args.Count >= 2)
            {
                self._requestPending = false;
                self._messageLabel.Text = args.Get(1);
                Game.Print(args.Get(1));
                return;
            }
        }

        if (!Network.IsMasterClient) {return;}
        if (rpc == "Poker.Unwatch") {self._viewers.Remove(sender.ID); return;}
        if (!self.AllowRequest(sender)) {self.SendError(sender, "Poker request was rate-limited."); return;}
        if (rpc == "Poker.Sync") {self._viewers.Add(sender.ID); self.SendState(sender, "Table synchronized.", false);}
        elif (rpc == "Poker.Seat" && args.Count >= 2) {self.AssignSeat(sender, Convert.ToInt(args.Get(1)));}
        elif (rpc == "Poker.Leave") {self.LeaveSeat(sender);}
        elif (rpc == "Poker.Ready") {self.ToggleReady(sender);}
        elif (rpc == "Poker.Check") {self.CheckHost(sender.ID, self.SafeName(sender) + " checked.");}
        elif (rpc == "Poker.Call") {self.CallHost(sender.ID);}
        elif (rpc == "Poker.Raise" && args.Count >= 2) {self.RaiseHost(sender.ID, Convert.ToInt(args.Get(1)));}
        elif (rpc == "Poker.Fold") {self.FoldHost(sender.ID, self.SafeName(sender) + " folded.");}
        elif (rpc == "Poker.AllIn") {self.AllInHost(sender.ID);}
    }

    function AllowRequest(player)
    {
        if (player == null) {return false;}
        last = Convert.ToFloat(self._lastRequests.Get(player.ID, -100.0));
        if (Time.GameTime - last < 0.1) {return false;}
        self._lastRequests.Set(player.ID, Time.GameTime);
        return true;
    }

    function AssignSeat(player, slot)
    {
        if (player == null || slot < 1 || slot > 4) {return;}
        if (self._handActive && self._handPlayers.Contains(player.ID)) {self.SendError(player, "You cannot change seats during a hand."); return;}
        seatObj = Map.FindMapObjectByName("Player" + slot);
        if (player.Character == null || seatObj == null || Vector3.Distance(player.Character.Position, seatObj.Position) > 12.0)
        {
            self.SendError(player, "Move into that poker seat first.");
            return;
        }
        seatKey = "P" + slot;
        occupant = Convert.ToInt(self._seats.Get(seatKey, -1));
        if (occupant >= 0 && occupant != player.ID) {self.SendError(player, "That seat is occupied."); return;}
        self.RemoveSeat(player.ID);
        self._seats.Set(seatKey, player.ID);
        self._seatByPlayer.Set(player.ID, seatKey);
        self._viewers.Add(player.ID);
        self.SendStateToAll(self.SafeName(player) + " took seat " + slot + ".", false);
    }

    function RemoveSeat(playerID)
    {
        if (!self._seatByPlayer.Contains(playerID)) {return;}
        seatKey = self._seatByPlayer.Get(playerID);
        self._seats.Set(seatKey, -1);
        self._seatByPlayer.Remove(playerID);
        self._readyPlayers.Remove(playerID);
    }

    function LeaveSeat(player)
    {
        if (player == null) {return;}
        self.ForceFold(player.ID, self.SafeName(player) + " left and folded.");
        self.RemoveSeat(player.ID);
        self.SendStateToAll(self.SafeName(player) + " left the table.", false);
    }

    function ToggleReady(player)
    {
        if (player == null || !self._seatByPlayer.Contains(player.ID)) {self.SendError(player, "Take a seat before readying."); return;}
        if (self._handActive) {self.SendError(player, "A hand is already active."); return;}
        serverID = ServerID._playerServerIDs.Get(player.ID);
        if (serverID == null || MoneyData.GetWallet(serverID) <= 0) {self.SendError(player, "You need at least 1 CC to play."); return;}
        if (self._readyPlayers.Contains(player.ID)) {self._readyPlayers.Remove(player.ID);}
        else {self._readyPlayers.Add(player.ID);}
        self.SendStateToAll("Ready status updated.", false);
        self.TryStartHand();
    }

    function TryStartHand()
    {
        if (!Network.IsMasterClient || self._handActive) {return;}
        seated = self.GetSeatedPlayerIDs();
        ready = List();
        for (playerID in seated)
        {
            player = Network.FindPlayer(playerID);
            serverID = ServerID._playerServerIDs.Get(playerID);
            if (self._readyPlayers.Contains(playerID) && player != null && serverID != null && MoneyData.GetWallet(serverID) > 0) {ready.Add(playerID);}
        }
        if (ready.Count < 2 || ready.Count != seated.Count) {return;}
        self.StartHand(ready);
    }

    function StartHand(players)
    {
        self._handGeneration += 1;
        self._handActive = true;
        self._phase = GamePhaseEnum.preflop;
        self._pot = 0;
        self._currentBet = 0;
        self._currentTurn = -1;
        self._turnIndex = -1;
        self._hands.Clear();
        self._folded.Clear();
        self._allIn.Clear();
        self._acted.Clear();
        self._roundBets.Clear();
        self._totalBets.Clear();
        self._payouts.Clear();
        self._communityCardsHost.Clear();
        self._readyPlayers.Clear();
        self._handPlayers = players;
        self._deck = self.BuildDeck();

        for (playerID in self._handPlayers)
        {
            hand = List();
            self.DealCard(hand);
            self.DealCard(hand);
            self._hands.Set(playerID, hand);
            self._roundBets.Set(playerID, 0);
            self._totalBets.Set(playerID, 0);
        }

        self._dealerCursor = (self._dealerCursor + 1) % self._handPlayers.Count;
        self._dealerID = self._handPlayers.Get(self._dealerCursor);
        smallIndex = (self._dealerCursor + 1) % self._handPlayers.Count;
        if (self._handPlayers.Count == 2) {smallIndex = self._dealerCursor;}
        bigIndex = (smallIndex + 1) % self._handPlayers.Count;
        self._smallBlindID = self._handPlayers.Get(smallIndex);
        self._bigBlindID = self._handPlayers.Get(bigIndex);
        self.CommitToTarget(self._smallBlindID, self.SmallBlind);
        self.CommitToTarget(self._bigBlindID, self.BigBlind);
        self._currentBet = Math.Max(Convert.ToInt(self._roundBets.Get(self._smallBlindID, 0)), Convert.ToInt(self._roundBets.Get(self._bigBlindID, 0)));

        firstIndex = (bigIndex + 1) % self._handPlayers.Count;
        if (self._handPlayers.Count == 2) {firstIndex = smallIndex;}
        self.SetNextTurn(firstIndex, true);
        if (self._currentTurn < 0) {self.RunOutBoard();}
        else {self.SendStateToAll("A new hand has begun.", false);}
    }

    function CommitToTarget(playerID, targetRoundBet)
    {
        player = Network.FindPlayer(playerID);
        serverID = ServerID._playerServerIDs.Get(playerID);
        if (player == null || serverID == null) {return 0;}
        already = Convert.ToInt(self._roundBets.Get(playerID, 0));
        need = Math.Max(0, targetRoundBet - already);
        wallet = MoneyData.GetWallet(serverID);
        paid = Math.Min(need, wallet);
        if (paid <= 0) {if (wallet <= 0) {self._allIn.Add(playerID);} return 0;}
        if (!MoneyData.TrySpendWallet(player, serverID, paid)) {return 0;}
        self._roundBets.Set(playerID, already + paid);
        self._totalBets.Set(playerID, Convert.ToInt(self._totalBets.Get(playerID, 0)) + paid);
        self._pot += paid;
        if (MoneyData.GetWallet(serverID) <= 0) {self._allIn.Add(playerID);}
        return paid;
    }

    function ValidateTurn(playerID)
    {
        return self._handActive && playerID == self._currentTurn && self._handPlayers.Contains(playerID) && !self._folded.Contains(playerID) && !self._allIn.Contains(playerID);
    }

    function CheckHost(playerID, message)
    {
        if (!self.ValidateTurn(playerID)) {self.SendActionError(playerID, "It is not your turn."); return;}
        if (Convert.ToInt(self._roundBets.Get(playerID, 0)) < self._currentBet) {self.SendActionError(playerID, "Call, raise, or fold."); return;}
        self._acted.Add(playerID);
        self.AfterAction(message);
    }

    function CallHost(playerID)
    {
        if (!self.ValidateTurn(playerID)) {self.SendActionError(playerID, "It is not your turn."); return;}
        before = Convert.ToInt(self._roundBets.Get(playerID, 0));
        self.CommitToTarget(playerID, self._currentBet);
        after = Convert.ToInt(self._roundBets.Get(playerID, 0));
        self._acted.Add(playerID);
        self.AfterAction(self.SafeName(Network.FindPlayer(playerID)) + " called " + (after - before) + " CC.");
    }

    function RaiseHost(playerID, amount)
    {
        if (!self.ValidateTurn(playerID)) {self.SendActionError(playerID, "It is not your turn."); return;}
        amount = Math.Max(self.MinRaise, Convert.ToInt(amount));
        oldCurrent = self._currentBet;
        self.CommitToTarget(playerID, oldCurrent + amount);
        newBet = Convert.ToInt(self._roundBets.Get(playerID, 0));
        if (newBet > oldCurrent)
        {
            self._currentBet = newBet;
            self._acted.Clear();
        }
        self._acted.Add(playerID);
        player = Network.FindPlayer(playerID);
        self.AfterAction(self.SafeName(player) + " raised to " + newBet + " CC.");
    }

    function AllInHost(playerID)
    {
        if (!self.ValidateTurn(playerID)) {self.SendActionError(playerID, "It is not your turn."); return;}
        player = Network.FindPlayer(playerID);
        serverID = ServerID._playerServerIDs.Get(playerID);
        oldCurrent = self._currentBet;
        target = Convert.ToInt(self._roundBets.Get(playerID, 0)) + MoneyData.GetWallet(serverID);
        self.CommitToTarget(playerID, target);
        newBet = Convert.ToInt(self._roundBets.Get(playerID, 0));
        if (newBet > oldCurrent) {self._currentBet = newBet; self._acted.Clear();}
        self._allIn.Add(playerID);
        self._acted.Add(playerID);
        self.AfterAction(self.SafeName(player) + " went all in for " + newBet + " CC.");
    }

    function FoldHost(playerID, message)
    {
        if (!self.ValidateTurn(playerID)) {self.SendActionError(playerID, "It is not your turn."); return;}
        self._folded.Add(playerID);
        self._acted.Add(playerID);
        self.AfterAction(message);
    }

    function ForceFold(playerID, message)
    {
        if (!self._handActive || !self._handPlayers.Contains(playerID) || self._folded.Contains(playerID)) {return;}
        wasCurrent = playerID == self._currentTurn;
        self._folded.Add(playerID);
        self._acted.Add(playerID);
        remaining = self.GetPlayersInHand();
        if (remaining.Count <= 1)
        {
            if (remaining.Count == 1) {self.AwardFoldWin(remaining.Get(0), message);}
            else {self.FinishHand("The hand ended without a winner.", true);}
        }
        elif (wasCurrent) {self.CheckHandContinuation(message);}
        else {self.SendStateToAll(message, false);}
    }

    function SendActionError(playerID, text)
    {
        self.SendError(Network.FindPlayer(playerID), text);
    }

    function AfterAction(message)
    {
        self.CheckHandContinuation(message);
    }

    function CheckHandContinuation(message)
    {
        remaining = self.GetPlayersInHand();
        if (remaining.Count <= 1)
        {
            if (remaining.Count == 1) {self.AwardFoldWin(remaining.Get(0), message);}
            else {self.FinishHand("The hand ended without a winner.", true);}
            return;
        }
        actionable = self.GetActionablePlayers();
        if (actionable.Count == 0) {self.RunOutBoard(); return;}
        roundComplete = true;
        for (playerID in actionable)
        {
            if (!self._acted.Contains(playerID) || Convert.ToInt(self._roundBets.Get(playerID, 0)) < self._currentBet) {roundComplete = false;}
        }
        if (roundComplete) {self.AdvancePhase();}
        else
        {
            self.SetNextTurn((self._turnIndex + 1) % self._handPlayers.Count, true);
            self.SendStateToAll(message, false);
        }
    }

    function GetPlayersInHand()
    {
        players = List();
        for (playerID in self._handPlayers) {if (!self._folded.Contains(playerID)) {players.Add(playerID);}}
        return players;
    }

    function GetActionablePlayers()
    {
        players = List();
        for (playerID in self._handPlayers)
        {
            if (!self._folded.Contains(playerID) && !self._allIn.Contains(playerID)) {players.Add(playerID);}
        }
        return players;
    }

    function SetNextTurn(startIndex, includeStart)
    {
        self._currentTurn = -1;
        count = self._handPlayers.Count;
        if (count == 0) {return;}
        offsetStart = 0;
        if (!includeStart) {offsetStart = 1;}
        for (offset in Range(offsetStart, count + offsetStart, 1))
        {
            index = (startIndex + offset) % count;
            playerID = self._handPlayers.Get(index);
            if (!self._folded.Contains(playerID) && !self._allIn.Contains(playerID))
            {
                self._turnIndex = index;
                self._currentTurn = playerID;
                self._turnDeadline = Time.GameTime + self.TurnTimeout;
                return;
            }
        }
    }

    function AdvancePhase()
    {
        if (self._phase == GamePhaseEnum.river) {self.Showdown(); return;}
        if (self._phase == GamePhaseEnum.preflop) {self._phase = GamePhaseEnum.flop; self.DealCommunityCards(3);}
        elif (self._phase == GamePhaseEnum.flop) {self._phase = GamePhaseEnum.turn; self.DealCommunityCards(1);}
        elif (self._phase == GamePhaseEnum.turn) {self._phase = GamePhaseEnum.river; self.DealCommunityCards(1);}
        self._roundBets.Clear();
        for (playerID in self._handPlayers) {self._roundBets.Set(playerID, 0);}
        self._currentBet = 0;
        self._acted.Clear();
        actionable = self.GetActionablePlayers();
        if (actionable.Count == 0) {self.RunOutBoard(); return;}
        self.SetNextTurn((self._dealerCursor + 1) % self._handPlayers.Count, true);
        self.SendStateToAll("Betting advanced to " + self.GetPhaseName() + ".", false);
    }

    function RunOutBoard()
    {
        while (self._communityCardsHost.Count < 5) {self.DealCommunityCards(1);}
        self._phase = 4;
        self.Showdown();
    }

    function DealCommunityCards(amount)
    {
        for (i in Range(amount)) {self.DealCard(self._communityCardsHost);}
    }

    function DealCard(hand)
    {
        if (self._deck.Count == 0) {return null;}
        card = self._deck.Get(0);
        self._deck.RemoveAt(0);
        hand.Add(card);
        return card;
    }

    function BuildDeck()
    {
        deck = List();
        suits = List("hearts", "diamonds", "clubs", "spades");
        values = List("A", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K");
        for (suit in suits) {for (value in values) {deck.Add(value + " of " + suit);}}
        return deck.Randomize();
    }

    function AwardFoldWin(winnerID, message)
    {
        player = Network.FindPlayer(winnerID);
        serverID = ServerID._playerServerIDs.Get(winnerID);
        if (player != null && serverID != null)
        {
            MoneyData.CreditWallet(player, serverID, self._pot);
            self._payouts.Set(winnerID, self._pot);
            MoneyData.Flush();
        }
        self.FinishHand(message + " " + self.SafeName(player) + " wins " + self._pot + " CC.", false);
    }

    function Showdown()
    {
        self._phase = 4;
        levels = List();
        for (playerID in self._handPlayers)
        {
            contribution = Convert.ToInt(self._totalBets.Get(playerID, 0));
            if (contribution > 0 && !levels.Contains(contribution)) {levels.Add(contribution);}
        }
        levels.SortCustom(self.SortAscending);
        previous = 0;
        for (level in levels)
        {
            contributorCount = 0;
            candidates = List();
            for (playerID in self._handPlayers)
            {
                contribution = Convert.ToInt(self._totalBets.Get(playerID, 0));
                if (contribution >= level)
                {
                    contributorCount += 1;
                    if (!self._folded.Contains(playerID)) {candidates.Add(playerID);}
                }
            }
            sidePot = (level - previous) * contributorCount;
            if (sidePot > 0 && candidates.Count > 0) {self.AwardPot(candidates, sidePot);}
            previous = level;
        }
        self.CreditPayouts();
        self.FinishHand("Showdown complete.", true);
    }

    function AwardPot(candidates, amount)
    {
        winners = List();
        best = -1;
        for (playerID in candidates)
        {
            strength = self.EvaluateBestHand(self.CombineHands(self._hands.Get(playerID), self._communityCardsHost));
            if (strength > best) {best = strength; winners.Clear(); winners.Add(playerID);}
            elif (strength == best) {winners.Add(playerID);}
        }
        if (winners.Count == 0) {return;}
        share = Math.Floor(amount / winners.Count);
        remainder = amount - share * winners.Count;
        for (i in Range(winners.Count))
        {
            playerID = winners.Get(i);
            payout = share;
            if (i < remainder) {payout += 1;}
            self._payouts.Set(playerID, Convert.ToInt(self._payouts.Get(playerID, 0)) + payout);
        }
    }

    function CreditPayouts()
    {
        for (playerID in self._payouts.Keys)
        {
            player = Network.FindPlayer(playerID);
            serverID = ServerID._playerServerIDs.Get(playerID);
            if (player != null && serverID != null) {MoneyData.CreditWallet(player, serverID, self._payouts.Get(playerID));}
        }
        MoneyData.Flush();
    }

    function FinishHand(message, reveal)
    {
        self._handActive = false;
        self._currentTurn = -1;
        self._turnDeadline = 0.0;
        self.SendStateToAll(message, reveal);
        self.CleanupHand(self._handGeneration);
    }

    coroutine CleanupHand(generation)
    {
        wait 10.0;
        if (generation != self._handGeneration || self._handActive) {return;}
        self._hands.Clear();
        self._communityCardsHost.Clear();
        self._folded.Clear();
        self._allIn.Clear();
        self._roundBets.Clear();
        self._totalBets.Clear();
        self._payouts.Clear();
        self._pot = 0;
        self._currentBet = 0;
        self._phase = 0;
        self.SendStateToAll("Ready for the next hand.", false);
    }

    function CombineHands(first, second)
    {
        combined = List();
        if (first != null) {for (card in first) {combined.Add(card);}}
        if (second != null) {for (card in second) {combined.Add(card);}}
        return combined;
    }

    function CardValue(card)
    {
        value = String.Split(card, " ", true).Get(0);
        if (value == "A") {return 14;}
        if (value == "K") {return 13;}
        if (value == "Q") {return 12;}
        if (value == "J") {return 11;}
        return Convert.ToInt(value);
    }

    function CardSuit(card)
    {
        parts = String.Split(card, " ", true);
        if (parts.Count < 3) {return "";}
        return parts.Get(2);
    }

    function EvaluateBestHand(cards)
    {
        if (cards == null || cards.Count < 5) {return 0;}
        best = 0;
        count = cards.Count;
        for (a in Range(0, count - 4, 1))
        {
            for (b in Range(a + 1, count - 3, 1))
            {
                for (c in Range(b + 1, count - 2, 1))
                {
                    for (d in Range(c + 1, count - 1, 1))
                    {
                        for (e in Range(d + 1, count, 1))
                        {
                            strength = self.EvaluateFive(List(cards.Get(a), cards.Get(b), cards.Get(c), cards.Get(d), cards.Get(e)));
                            if (strength > best) {best = strength;}
                        }
                    }
                }
            }
        }
        return best;
    }

    function EvaluateFive(cards)
    {
        values = List();
        counts = Dict();
        suit = self.CardSuit(cards.Get(0));
        flush = true;
        for (card in cards)
        {
            value = self.CardValue(card);
            values.Add(value);
            counts.Set(value, Convert.ToInt(counts.Get(value, 0)) + 1);
            if (self.CardSuit(card) != suit) {flush = false;}
        }
        values.SortCustom(self.SortDescending);
        straightHigh = self.GetStraightHigh(values);
        if (flush && straightHigh > 0) {return self.EncodeStrength(9, straightHigh, 0, 0, 0, 0);}

        four = 0;
        triple = 0;
        pairs = List();
        singles = List();
        for (value in Range(14, 1, -1))
        {
            count = Convert.ToInt(counts.Get(value, 0));
            if (count == 4) {four = value;}
            elif (count == 3) {triple = value;}
            elif (count == 2) {pairs.Add(value);}
            elif (count == 1) {singles.Add(value);}
        }
        if (four > 0) {return self.EncodeStrength(8, four, singles.Get(0), 0, 0, 0);}
        if (triple > 0 && pairs.Count > 0) {return self.EncodeStrength(7, triple, pairs.Get(0), 0, 0, 0);}
        if (flush) {return self.EncodeStrength(6, values.Get(0), values.Get(1), values.Get(2), values.Get(3), values.Get(4));}
        if (straightHigh > 0) {return self.EncodeStrength(5, straightHigh, 0, 0, 0, 0);}
        if (triple > 0) {return self.EncodeStrength(4, triple, singles.Get(0), singles.Get(1), 0, 0);}
        if (pairs.Count >= 2) {return self.EncodeStrength(3, pairs.Get(0), pairs.Get(1), singles.Get(0), 0, 0);}
        if (pairs.Count == 1) {return self.EncodeStrength(2, pairs.Get(0), singles.Get(0), singles.Get(1), singles.Get(2), 0);}
        return self.EncodeStrength(1, values.Get(0), values.Get(1), values.Get(2), values.Get(3), values.Get(4));
    }

    function GetStraightHigh(values)
    {
        unique = List();
        for (value in values) {if (!unique.Contains(value)) {unique.Add(value);}}
        unique.SortCustom(self.SortDescending);
        if (unique.Count != 5) {return 0;}
        if (unique.Get(0) == 14 && unique.Get(1) == 5 && unique.Get(2) == 4 && unique.Get(3) == 3 && unique.Get(4) == 2) {return 5;}
        if (unique.Get(0) - unique.Get(4) == 4) {return unique.Get(0);}
        return 0;
    }

    function EncodeStrength(rank, a, b, c, d, e)
    {
        return rank * 1000000 + a * 50625 + b * 3375 + c * 225 + d * 15 + e;
    }

    function GetRankName(strength)
    {
        rank = Math.Floor(strength / 1000000);
        if (rank == 9) {return "Straight Flush";}
        if (rank == 8) {return "Four of a Kind";}
        if (rank == 7) {return "Full House";}
        if (rank == 6) {return "Flush";}
        if (rank == 5) {return "Straight";}
        if (rank == 4) {return "Three of a Kind";}
        if (rank == 3) {return "Two Pair";}
        if (rank == 2) {return "Pair";}
        return "High Card";
    }

    function SortAscending(a, b)
    {
        if (a < b) {return -1;}
        if (a > b) {return 1;}
        return 0;
    }

    function SortDescending(a, b)
    {
        if (a < b) {return 1;}
        if (a > b) {return -1;}
        return 0;
    }

    function GetSeatedPlayerIDs()
    {
        players = List();
        for (slot in Range(1, 5, 1))
        {
            playerID = Convert.ToInt(self._seats.Get("P" + slot, -1));
            if (playerID >= 0 && Network.FindPlayer(playerID) != null) {players.Add(playerID);}
        }
        return players;
    }

    function SendStateToAll(message, reveal)
    {
        recipients = Set();
        for (playerID in self.GetSeatedPlayerIDs()) {recipients.Add(playerID);}
        for (playerID in self._viewers.ToList()) {recipients.Add(playerID);}
        for (playerID in recipients.ToList())
        {
            player = Network.FindPlayer(playerID);
            if (player != null) {self.SendState(player, message, reveal);}
        }
    }

    function SendState(player, message, reveal)
    {
        payload = Dict();
        playerID = player.ID;
        serverID = ServerID._playerServerIDs.Get(playerID);
        payload.Set("Seated", self._seatByPlayer.Contains(playerID));
        payload.Set("Seat", self._seatByPlayer.Get(playerID, ""));
        payload.Set("Ready", self._readyPlayers.Contains(playerID));
        payload.Set("Active", self._handActive);
        payload.Set("Phase", self.GetPhaseName());
        payload.Set("Pot", self._pot);
        payload.Set("CurrentBet", self._currentBet);
        payload.Set("MyBet", self._roundBets.Get(playerID, 0));
        payload.Set("Wallet", MoneyData.GetWallet(serverID));
        payload.Set("TurnID", self._currentTurn);
        turnPlayer = Network.FindPlayer(self._currentTurn);
        payload.Set("TurnName", self.SafeName(turnPlayer));
        payload.Set("Message", message);
        payload.Set("Community", self._communityCardsHost);
        payload.Set("Hand", self._hands.Get(playerID, List()));
        payload.Set("MyTurn", self.ValidateTurn(playerID));
        payload.Set("CanCheck", self.ValidateTurn(playerID) && Convert.ToInt(self._roundBets.Get(playerID, 0)) >= self._currentBet);
        payload.Set("ToCall", Math.Max(0, self._currentBet - Convert.ToInt(self._roundBets.Get(playerID, 0))));
        payload.Set("Payout", self._payouts.Get(playerID, 0));

        seats = List();
        opponents = List();
        for (slot in Range(1, 5, 1))
        {
            seatedID = Convert.ToInt(self._seats.Get("P" + slot, -1));
            seatedPlayer = Network.FindPlayer(seatedID);
            seatText = "Seat " + slot + ": Empty";
            if (seatedPlayer != null)
            {
                seatText = "Seat " + slot + ": " + self.SafeName(seatedPlayer);
                if (self._readyPlayers.Contains(seatedID)) {seatText += " [Ready]";}
            }
            seats.Add(seatText);
            if (seatedID >= 0 && seatedID != playerID && self._handPlayers.Contains(seatedID))
            {
                status = "2 hidden cards";
                if (self._folded.Contains(seatedID)) {status = "Folded";}
                if (reveal && !self._folded.Contains(seatedID))
                {
                    hand = self._hands.Get(seatedID, List());
                    status = self.FormatCards(hand) + " — " + self.GetRankName(self.EvaluateBestHand(self.CombineHands(hand, self._communityCardsHost)));
                }
                opponents.Add(self.SafeName(seatedPlayer) + ": " + status);
            }
        }
        payload.Set("Seats", seats);
        payload.Set("Opponents", opponents);
        self.NetworkView.SendMessage(player, "Poker.State|" + Json.SaveToString(payload));
    }

    function SafeName(player)
    {
        if (player == null) {return "";}
        return String.Replace(player.Name, "|", "/");
    }

    function GetPhaseName()
    {
        if (self._phase == GamePhaseEnum.preflop) {return "Preflop";}
        if (self._phase == GamePhaseEnum.flop) {return "Flop";}
        if (self._phase == GamePhaseEnum.turn) {return "Turn";}
        if (self._phase == GamePhaseEnum.river) {return "River";}
        if (self._phase == 4) {return "Showdown";}
        return "Waiting";
    }

    function SendError(player, text)
    {
        if (player != null) {self.NetworkView.SendMessage(player, "Poker.Error|" + text);}
    }

    function BuildUI()
    {
        self._root = UI.GetRootVisualElement();
        self._container = UI.VisualElement()
            .Absolute(true).Width(900, false).Height(680, false).AlignSelf(AlignEnum.Center)
            .Padding(18, false).BackgroundColor(Color("#073f24f5"))
            .BorderColor(Color("#d1aa45")).BorderWidth(4).BorderRadius(18)
            .FlexDirection(FlexDirectionEnum.Column);
        self._root.Add(self._container);
        self._container.Add(UI.Label("TEXAS HOLD'EM").Height(45, false).FontSize(30).FontStyle(FontStyleEnum.Bold).TextAlign(TextAlignEnum.MiddleCenter));
        self._tableLabel = UI.Label("Waiting for table state...").Height(105, false).FontSize(17).TextWrap(true).TextAlign(TextAlignEnum.MiddleCenter);
        self._container.Add(self._tableLabel);
        self._opponentsLabel = UI.Label("Seats are empty.").Height(100, false).FontSize(16).TextWrap(true).BackgroundColor(Color("#0b5333"));
        self._container.Add(self._opponentsLabel);
        self._communityLabel = UI.Label("Community: —").Height(90, false).FontSize(19).TextWrap(true).TextAlign(TextAlignEnum.MiddleCenter).BackgroundColor(Color("#0b5333"));
        self._container.Add(self._communityLabel);
        self._handLabel = UI.Label("Your hand: —").Height(90, false).FontSize(19).TextWrap(true).TextAlign(TextAlignEnum.MiddleCenter).BackgroundColor(Color("#0b5333"));
        self._container.Add(self._handLabel);
        self._messageLabel = UI.Label("Take a seat to play.").Height(55, false).FontSize(17).TextWrap(true).TextAlign(TextAlignEnum.MiddleCenter);
        self._container.Add(self._messageLabel);
        self._walletLabel = UI.Label("Wallet: 0 CC").Height(35, false).FontSize(17).TextAlign(TextAlignEnum.MiddleCenter);
        self._container.Add(self._walletLabel);

        actions = UI.VisualElement().Height(55, false).FlexDirection(FlexDirectionEnum.Row).JustifyContent(JustifyEnum.Center);
        self._container.Add(actions);
        self._readyBTN = UI.Button("Ready", self.OnReadyClicked).Width(105, false);
        self._checkBTN = UI.Button("Check", self.OnCheckClicked).Width(105, false);
        self._callBTN = UI.Button("Call", self.OnCallClicked).Width(105, false);
        self._raiseBTN = UI.Button("Raise", self.OnRaiseClicked).Width(105, false);
        self._allInBTN = UI.Button("All in", self.OnAllInClicked).Width(105, false);
        self._foldBTN = UI.Button("Fold", self.OnFoldClicked).Width(105, false);
        self._leaveBTN = UI.Button("Leave", self.OnLeaveClicked).Width(105, false);
        actions.Add(self._readyBTN); actions.Add(self._checkBTN); actions.Add(self._callBTN); actions.Add(self._raiseBTN);
        actions.Add(self._allInBTN); actions.Add(self._foldBTN); actions.Add(self._leaveBTN);
    }

    function Show()
    {
        if (self._container == null) {self.BuildUI();}
        self._isActive = true;
        self._container.Active(true);
        self.DisableInputs();
        self._requestPending = true;
        self.NetworkView.SendMessage(Network.MasterClient, "Poker.Sync");
    }

    function Hide()
    {
        wasActive = self._isActive;
        self._isActive = false;
        if (self._container != null) {self._container.Active(false);}
        self.EnableInputs();
        if (wasActive) {self.NetworkView.SendMessage(Network.MasterClient, "Poker.Unwatch");}
    }

    function ApplyState(state)
    {
        self._requestPending = false;
        Main.Coins = Convert.ToInt(state.Get("Wallet", Main.Coins));
        self._myHand = state.Get("Hand", List());
        self._communityCards = state.Get("Community", List());
        seats = state.Get("Seats", List());
        opponents = state.Get("Opponents", List());
        self._tableLabel.Text = String.Join(seats, String.Newline) + String.Newline + "Phase: " + state.Get("Phase") + " | Pot: " + state.Get("Pot") + " CC | Current bet: " + state.Get("CurrentBet") + " CC";
        self._opponentsLabel.Text = "Opponents" + String.Newline + String.Join(opponents, String.Newline);
        self._communityLabel.Text = "Community" + String.Newline + self.FormatCards(self._communityCards);
        handText = self.FormatCards(self._myHand);
        if (self._myHand.Count >= 2 && self._communityCards.Count >= 3)
        {
            handText += String.Newline + self.GetRankName(self.EvaluateBestHand(self.CombineHands(self._myHand, self._communityCards)));
        }
        self._handLabel.Text = "Your hand" + String.Newline + handText;
        message = state.Get("Message", "");
        payout = Convert.ToInt(state.Get("Payout", 0));
        if (payout > 0) {message += " You received " + payout + " CC.";}
        if (state.Get("MyTurn", false)) {message += " Your turn — " + state.Get("ToCall", 0) + " CC to call.";}
        self._messageLabel.Text = message;
        self._walletLabel.Text = "Wallet: " + Main.Coins + " CC | Your round bet: " + state.Get("MyBet", 0) + " CC | Turn: " + state.Get("TurnName", "");
        seated = state.Get("Seated", false);
        active = state.Get("Active", false);
        myTurn = state.Get("MyTurn", false);
        self._readyBTN.Active(seated && !active && !self._requestPending);
        self._checkBTN.Active(myTurn && state.Get("CanCheck", false));
        self._callBTN.Active(myTurn && state.Get("ToCall", 0) > 0);
        self._raiseBTN.Active(myTurn);
        self._allInBTN.Active(myTurn);
        self._foldBTN.Active(myTurn);
        self._leaveBTN.Active(seated && !active);
    }

    function FormatCards(cards)
    {
        if (cards == null || cards.Count == 0) {return "—";}
        return String.Join(cards, "   |   ");
    }

    function SendAction(message)
    {
        if (self._requestPending) {return;}
        self._requestPending = true;
        self.NetworkView.SendMessage(Network.MasterClient, message);
    }

    function OnReadyClicked() {self.SendAction("Poker.Ready");}
    function OnFoldClicked() {self.SendAction("Poker.Fold");}
    function OnCallClicked() {self.SendAction("Poker.Call");}
    function OnCheckClicked() {self.SendAction("Poker.Check");}
    function OnAllInClicked() {self.SendAction("Poker.AllIn");}
    function OnLeaveClicked() {self.SendAction("Poker.Leave");}

    function OnRaiseClicked()
    {
        if (!self._raisePopupCreated)
        {
            UI.CreatePopup("PokerRaise", "Raise", 400, 400);
            self._raisePopupCreated = true;
        }
        else {UI.ClearPopup("PokerRaise");}
        UI.AddPopupButton("PokerRaise", "Raise_20", "Raise 20");
        UI.AddPopupButton("PokerRaise", "Raise_40", "Raise 40");
        UI.AddPopupButton("PokerRaise", "Raise_60", "Raise 60");
        UI.ShowPopup("PokerRaise");
    }

    function OnButtonClick(buttonName)
    {
        if (buttonName == "Raise_20") {self.SendAction("Poker.Raise|20");}
        elif (buttonName == "Raise_40") {self.SendAction("Poker.Raise|40");}
        elif (buttonName == "Raise_60") {self.SendAction("Poker.Raise|60");}
        UI.HidePopup("PokerRaise");
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

    function CheckVotes() {return self._readyPlayers.Count >= 2;}
    function PreflopBlinds() {}
    function StartBetting(phase) {}
    function NextTurn() {self.CheckHandContinuation("Turn advanced.");}
    function NextPhase() {self.AdvancePhase();}
    function GetActivePlayers() {return self.GetActionablePlayers();}
    function FindIndex(playerList, playerID) {for (i in Range(playerList.Count)) {if (playerList.Get(i) == playerID) {return i;}} return -1;}
    function TurnUpdate() {self.SendStateToAll("Turn updated.", false);}
    function CheckRoundEnd() {return false;}
    function DealOut(hand) {}
    function Deal() {self.TryStartHand();}
    function EndHand(winner) {if (winner != null) {self.AwardFoldWin(Convert.ToInt(winner), "Hand ended.");}}
    function RevealAll() {self.SendStateToAll("Cards revealed.", true);}
    function Raise(amount, playerID) {self.RaiseHost(playerID, amount);}
    function Check(playerID) {self.CheckHost(playerID, "Player checked.");}
    function Call(playerID) {self.CallHost(playerID);}
    function Fold(playerID) {self.FoldHost(playerID, "Player folded.");}
    function Allin(playerID) {self.AllInHost(playerID);}
    function EvaluateHand(hand) {return self.GetRankName(self.EvaluateBestHand(hand));}
    function HasStraight(hand) {return self.GetStraightHigh(hand) > 0;}
    function AddSuits() {}
    function AddValues() {}
    function UpdateUI() {self.SendAction("Poker.Sync");}
    function ResetGameState() {}
    function ResetUI() {}
    function ClearHands() {self._myHand.Clear(); self._communityCards.Clear();}
    function ResetProperties() {}
    function RevealCards(hand) {}
    function CreateCardUI(card) {return UI.Label(card);}
    function HiddenCard() {return UI.Label("Hidden card");}
    function HorizontalCard(card) {return UI.Label(card);}
    function HiddenHoriCard() {return UI.Label("Hidden card");}
}
