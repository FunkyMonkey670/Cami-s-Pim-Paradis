extension Race
{
    PrepDuration = 30;
    DefaultTarget = 50;
    MaxTarget = 10000;

    _raceStarted = false;
    _prepStarted = false;
    _prepTimer = 0;
    _trackedKills = 0;
    _trackPlayers = Dict();
    _progress = Dict();
    _colorSlots = Dict();
    _rankingsDirty = false;
    _countUpTimer = 0;
    _killsToWin = 50;
    _processedTitans = Set();

    function Init()
    {
        Commands.RegisterCommand("startrace", self.StartCmd, "/startrace [kills]: start a kill race");
        Commands.RegisterCommand("joinrace", self.JoinCmd, "/joinrace: join the pending kill race");
        if (Network.IsMasterClient) {Commands.RegisterCommand("endrace", self.EndCommand, "/endrace: end the kill race");}
    }

    function StartCmd(cmd, args)
    {
        target = self.DefaultTarget;
        if (args.Count > 0) {target = Convert.ToInt(args.Get(0));}
        target = Math.Clamp(target, 1, self.MaxTarget);
        Network.SendMessage(Network.MasterClient, "Race.RequestStart|" + target);
    }

    function JoinCmd() {Network.SendMessage(Network.MasterClient, "Race.Join");}
    function EndCommand() {if (Network.IsMasterClient) {self.EndHost(null);}}

    function OnNetworkMessage(sender, message, args)
    {
        if (args.Count == 0) {return;}
        rpc = args.Get(0);
        if (sender == Network.MasterClient)
        {
            if (rpc == "Race.Prep" && args.Count >= 2)
            {
                self.ResetLocal();
                self._killsToWin = Math.Clamp(Convert.ToInt(args.Get(1)), 1, self.MaxTarget);
                self._prepTimer = self.PrepDuration;
                self._prepStarted = true;
                Game.Print("<color=#ff67ff>Kill race:</color> first to " + self._killsToWin + " kills. Type <color=#ffd166>/joinrace</color> to enter.");
            }
            elif (rpc == "Race.Racers" && args.Count >= 2)
            {
                if (!self._prepStarted && !self._raceStarted) {return;}
                self.RemoveOutlines();
                state = Json.LoadFromString(args.Get(1));
                if (state != null)
                {
                    racers = state.Get("Players", null);
                    progress = state.Get("Progress", null);
                    colors = state.Get("Colors", null);
                    if (racers != null) {self._trackPlayers = racers;}
                    if (progress != null) {self._progress = progress;}
                    if (colors != null) {self._colorSlots = colors;}
                    self.UpdateTrackedKills();
                }
                self.ApplyOutlines();
                self.UpdateRaceList();
            }
            elif (rpc == "Race.Rankings" && args.Count >= 2)
            {
                if (!self._prepStarted && !self._raceStarted) {return;}
                progress = Json.LoadFromString(args.Get(1));
                if (progress != null)
                {
                    self._progress = progress;
                    self.UpdateTrackedKills();
                    self.UpdateRaceList();
                }
            }
            elif (rpc == "Race.Start" && self._prepStarted)
            {
                self._prepStarted = false;
                self._raceStarted = true;
                self._countUpTimer = 0;
                self.UpdateRaceList();
                Game.Print("<color=#ff67ff>The kill race has started.</color>");
            }
            elif (rpc == "Race.Progress" && args.Count >= 2 && self._raceStarted)
            {
                self._trackedKills = Convert.ToInt(args.Get(1));
            }
            elif (rpc == "Race.End" && args.Count >= 3)
            {
                winner = Network.FindPlayer(Convert.ToInt(args.Get(1)));
                elapsed = Convert.ToInt(args.Get(2));
                if (winner != null) {Game.Print("<color=#ff67ff>" + winner.Name + " won the kill race in " + elapsed + " seconds.</color>");}
                else {Game.Print("The kill race ended.");}
                self.ResetLocal();
            }
        }

        if (!Network.IsMasterClient) {return;}
        if (rpc == "Race.RequestStart" && args.Count >= 2)
        {
            if (self._raceStarted || self._prepStarted || DmgRace._raceStarted || DmgRace._prepStarted)
            {
                Network.SendMessage(sender, "Economy.Notice|A competitive race is already active.");
                return;
            }
            self.ResetLocal();
            self._killsToWin = Math.Clamp(Convert.ToInt(args.Get(1)), 1, self.MaxTarget);
            self._prepTimer = self.PrepDuration;
            self._prepStarted = true;
            self.AddRacer(sender);
            Network.SendMessageAll("Race.Prep|" + self._killsToWin);
            self.SyncRacers();
        }
        elif (rpc == "Race.Join")
        {
            if (!self._prepStarted || self._raceStarted) {return;}
            self.AddRacer(sender);
            self.SyncRacers();
        }
    }

    function AddRacer(player)
    {
        if (player == null) {return;}
        key = Convert.ToString(player.ID);
        if (self._trackPlayers.Contains(key))
        {
            self._trackPlayers.Set(key, player.Name);
            return;
        }
        self._trackPlayers.Set(key, player.Name);
        self._progress.Set(key, 0);
        self._colorSlots.Set(key, RaceVisuals.FindAvailableSlot(self._colorSlots));
    }

    function SyncRacers()
    {
        if (!Network.IsMasterClient) {return;}
        state = Dict();
        state.Set("Players", self._trackPlayers);
        state.Set("Progress", self._progress);
        state.Set("Colors", self._colorSlots);
        self._rankingsDirty = false;
        Network.SendMessageAll("Race.Racers|" + Json.SaveToString(state));
    }

    function SyncRankings()
    {
        if (!Network.IsMasterClient || !self._rankingsDirty) {return;}
        self._rankingsDirty = false;
        Network.SendMessageAll("Race.Rankings|" + Json.SaveToString(self._progress));
    }

    function OnSecond()
    {
        if (Network.IsMasterClient && self._raceStarted) {self.SyncRankings();}
        if (self._prepStarted)
        {
            if (self._prepTimer > 0)
            {
                timerText = "<b><color=#ff67ff>KILL RACE</color></b>" + String.Newline +
                    "<color=#ffffff>Starts in </color><color=#ffd43b><b>" + self._prepTimer + "</b></color><color=#ffffff>s</color>" +
                    String.Newline + String.Newline + String.Newline + String.Newline;
                UI.SetLabelForTime(UILabelEnum.BottomCenter, timerText, 1.1);
                self._prepTimer -= 1;
                self.UpdateRaceList();
            }
            if (Network.IsMasterClient && self._prepTimer <= 0)
            {
                if (self._trackPlayers.Count < 2) {self.EndHost(null);}
                else
                {
                    self._prepStarted = false;
                    self._raceStarted = true;
                    self._countUpTimer = 0;
                    self._processedTitans.Clear();
                    Network.SendMessageAll("Race.Start");
                }
            }
        }
        elif (self._raceStarted)
        {
            self._countUpTimer += 1;
            self.UpdateRaceList();
        }
    }

    function OnCharacterDie(victim, killer, killerName)
    {
        if (!Network.IsMasterClient || !self._raceStarted || victim == null || killer == null) {return;}
        if (victim.Type != "Titan" || killer.Type != "Human" || killer.Player == null || self._processedTitans.Contains(victim)) {return;}
        key = Convert.ToString(killer.Player.ID);
        if (!self._trackPlayers.Contains(key)) {return;}
        self._processedTitans.Add(victim);
        value = Convert.ToInt(self._progress.Get(key, 0)) + 1;
        self._progress.Set(key, value);
        self._rankingsDirty = true;
        if (killer.Player == Network.MyPlayer) {self._trackedKills = value;}
        Network.SendMessage(killer.Player, "Race.Progress|" + value);
        if (value >= self._killsToWin) {self.EndHost(killer.Player);}
    }

    function OnPlayerSpawn(player, character)
    {
        if (player == null || character == null) {return;}
        key = Convert.ToString(player.ID);
        if (!self._trackPlayers.Contains(key)) {return;}
        character.AddOutline(RaceVisuals.GetColor(self._colorSlots.Get(key, -1)), OutlineModeEnum.OutlineVisible);
    }

    function OnPlayerLeave(player)
    {
        if (!Network.IsMasterClient || player == null) {return;}
        key = Convert.ToString(player.ID);
        if (self._trackPlayers.Contains(key)) {self._trackPlayers.Remove(key);}
        if (self._progress.Contains(key)) {self._progress.Remove(key);}
        if (self._colorSlots.Contains(key)) {self._colorSlots.Remove(key);}
        self.SyncRacers();
        if (self._raceStarted && self._trackPlayers.Count < 2) {self.EndHost(self.GetRemainingPlayer());}
    }

    function GetRemainingPlayer()
    {
        for (key in self._trackPlayers.Keys) {return Network.FindPlayer(Convert.ToInt(key));}
        return null;
    }

    function EndHost(winner)
    {
        if (!Network.IsMasterClient || (!self._raceStarted && !self._prepStarted)) {return;}
        winnerID = -1;
        if (winner != null) {winnerID = winner.ID;}
        Network.SendMessageAll("Race.End|" + winnerID + "|" + self._countUpTimer);
        self.ResetLocal();
    }

    function ApplyOutlines()
    {
        for (key in self._trackPlayers.Keys)
        {
            player = Network.FindPlayer(Convert.ToInt(key));
            if (player != null && player.Character != null)
            {
                player.Character.AddOutline(RaceVisuals.GetColor(self._colorSlots.Get(key, -1)), OutlineModeEnum.OutlineVisible);
            }
        }
    }

    function CompareRankKeys(a, b)
    {
        aScore = Convert.ToInt(self._progress.Get(a, 0));
        bScore = Convert.ToInt(self._progress.Get(b, 0));
        if (aScore > bScore) {return -1;}
        if (aScore < bScore) {return 1;}
        aID = Convert.ToInt(a);
        bID = Convert.ToInt(b);
        if (aID < bID) {return -1;}
        if (aID > bID) {return 1;}
        return 0;
    }

    function UpdateTrackedKills()
    {
        key = Convert.ToString(Network.MyPlayer.ID);
        self._trackedKills = Convert.ToInt(self._progress.Get(key, 0));
    }

    function UpdateRaceList()
    {
        keys = self._trackPlayers.Keys.Copy();
        keys.SortCustom(self.CompareRankKeys);
        status = "<color=#ffd43b>Starts in " + self._prepTimer + "s</color>";
        if (self._raceStarted)
        {
            status = "<color=#ffffff>TIME ELAPSED</color> <color=#ffd43b><b>" + RaceVisuals.FormatElapsed(self._countUpTimer) + "</b></color>";
        }
        text = status + String.Newline +
            "<b><color=#ff67ff>KILL RACE</color></b> <color=#ffd43b>First to " + self._killsToWin + "</color>" + String.Newline;
        rank = 1;
        for (key in keys)
        {
            color = RaceVisuals.GetColorHex(self._colorSlots.Get(key, -1));
            score = Convert.ToInt(self._progress.Get(key, 0));
            text += "<color=" + color + "><b>#" + rank + "</b></color> " + self._trackPlayers.Get(key) +
                " <color=#e2e8f0>- " + score + "/" + self._killsToWin + " kills</color>" + String.Newline;
            rank += 1;
        }
        UI.SetLabel(UILabelEnum.MiddleLeft, text);
    }

    function RemoveOutlines()
    {
        for (key in self._trackPlayers.Keys)
        {
            player = Network.FindPlayer(Convert.ToInt(key));
            if (player != null && player.Character != null) {player.Character.RemoveOutline();}
        }
    }

    function ResetLocal()
    {
        self.RemoveOutlines();
        self._raceStarted = false;
        self._prepStarted = false;
        self._prepTimer = 0;
        self._trackedKills = 0;
        self._countUpTimer = 0;
        self._trackPlayers.Clear();
        self._progress.Clear();
        self._colorSlots.Clear();
        self._processedTitans.Clear();
        self._rankingsDirty = false;
        UI.SetLabel(UILabelEnum.MiddleLeft, "");
        UI.SetLabel(UILabelEnum.BottomCenter, "");
    }
}
