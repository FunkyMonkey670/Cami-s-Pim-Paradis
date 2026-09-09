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
                self.RemoveOutlines();
                racers = Json.LoadFromString(args.Get(1));
                if (racers != null) {self._trackPlayers = racers;}
                self.ApplyOutlines();
            }
            elif (rpc == "Race.Start")
            {
                self._prepStarted = false;
                self._raceStarted = true;
                self._countUpTimer = 0;
                Game.Print("<color=#ff67ff>The kill race has started.</color>");
            }
            elif (rpc == "Race.Progress" && args.Count >= 2)
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
        self._trackPlayers.Set(key, player.Name);
        self._progress.Set(key, 0);
    }

    function SyncRacers()
    {
        if (Network.IsMasterClient) {Network.SendMessageAll("Race.Racers|" + Json.SaveToString(self._trackPlayers));}
    }

    function OnSecond()
    {
        if (self._prepStarted)
        {
            if (self._prepTimer > 0)
            {
                UI.SetLabelForTime(UILabelEnum.BottomCenter, "Kill race starts in " + self._prepTimer + String.Newline + String.Newline, 1.1);
                self._prepTimer -= 1;
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
            key = Convert.ToString(Network.MyPlayer.ID);
            if (self._trackPlayers.Contains(key))
            {
                UI.SetLabelForTime(UILabelEnum.MiddleRight, "Kills: " + self._trackedKills + "/" + self._killsToWin + String.Newline + self._countUpTimer + "s", 1.1);
            }
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
        if (killer.Player == Network.MyPlayer) {self._trackedKills = value;}
        Network.SendMessage(killer.Player, "Race.Progress|" + value);
        if (value >= self._killsToWin) {self.EndHost(killer.Player);}
    }

    function OnPlayerSpawn(player, character)
    {
        if (player == null || character == null || !self._trackPlayers.Contains(Convert.ToString(player.ID))) {return;}
        character.AddOutline(Color("#ff67ff"), OutlineModeEnum.OutlineVisible);
    }

    function OnPlayerLeave(player)
    {
        if (!Network.IsMasterClient || player == null) {return;}
        key = Convert.ToString(player.ID);
        if (self._trackPlayers.Contains(key)) {self._trackPlayers.Remove(key);}
        if (self._progress.Contains(key)) {self._progress.Remove(key);}
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
        text = "<b>Active Kill Racers</b>" + String.Newline;
        for (key in self._trackPlayers.Keys)
        {
            text += self._trackPlayers.Get(key) + String.Newline;
            player = Network.FindPlayer(Convert.ToInt(key));
            if (player != null && player.Character != null) {player.Character.AddOutline(Color("#ff67ff"), OutlineModeEnum.OutlineVisible);}
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
        self._processedTitans.Clear();
        UI.SetLabel(UILabelEnum.MiddleLeft, "");
    }
}
