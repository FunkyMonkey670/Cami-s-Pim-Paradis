extension DmgRace
{
    PrepDuration = 30;
    DefaultTarget = 50000;
    MaxTarget = 1000000000;

    _raceStarted = false;
    _prepStarted = false;
    _prepTimer = 0;
    _trackedDmg = 0;
    _trackPlayers = Dict();
    _progress = Dict();
    _dirtyProgress = Set();
    _countUpTimer = 0;
    _dmgToWin = 50000;

    function Init()
    {
        Commands.RegisterCommand("startdmg", self.StartCmd, "/startdmg [damage]: start a damage race");
        Commands.RegisterCommand("joindmg", self.JoinCmd, "/joindmg: join the pending damage race");
        if (Network.IsMasterClient) {Commands.RegisterCommand("enddmg", self.EndCommand, "/enddmg: end the damage race");}
    }

    function StartCmd(cmd, args)
    {
        target = self.DefaultTarget;
        if (args.Count > 0) {target = Convert.ToInt(args.Get(0));}
        Network.SendMessage(Network.MasterClient, "DmgRace.RequestStart|" + Math.Clamp(target, 1, self.MaxTarget));
    }

    function JoinCmd() {Network.SendMessage(Network.MasterClient, "DmgRace.Join");}
    function EndCommand() {if (Network.IsMasterClient) {self.EndHost(null);}}

    function OnNetworkMessage(sender, message, args)
    {
        if (args.Count == 0) {return;}
        rpc = args.Get(0);
        if (sender == Network.MasterClient)
        {
            if (rpc == "DmgRace.Prep" && args.Count >= 2)
            {
                self.ResetLocal();
                self._dmgToWin = Math.Clamp(Convert.ToInt(args.Get(1)), 1, self.MaxTarget);
                self._prepTimer = self.PrepDuration;
                self._prepStarted = true;
                Game.Print("<color=#64d8ff>Damage race:</color> first to " + self._dmgToWin + " damage. Type <color=#ffd166>/joindmg</color> to enter.");
            }
            elif (rpc == "DmgRace.Racers" && args.Count >= 2)
            {
                self.RemoveOutlines();
                racers = Json.LoadFromString(args.Get(1));
                if (racers != null) {self._trackPlayers = racers;}
                self.ApplyOutlines();
            }
            elif (rpc == "DmgRace.Start")
            {
                self._prepStarted = false;
                self._raceStarted = true;
                self._countUpTimer = 0;
                Game.Print("<color=#64d8ff>The damage race has started.</color>");
            }
            elif (rpc == "DmgRace.Progress" && args.Count >= 2) {self._trackedDmg = Convert.ToInt(args.Get(1));}
            elif (rpc == "DmgRace.End" && args.Count >= 3)
            {
                winner = Network.FindPlayer(Convert.ToInt(args.Get(1)));
                elapsed = Convert.ToInt(args.Get(2));
                if (winner != null) {Game.Print("<color=#64d8ff>" + winner.Name + " won the damage race in " + elapsed + " seconds.</color>");}
                else {Game.Print("The damage race ended.");}
                self.ResetLocal();
            }
        }

        if (!Network.IsMasterClient) {return;}
        if (rpc == "DmgRace.RequestStart" && args.Count >= 2)
        {
            if (self._raceStarted || self._prepStarted || Race._raceStarted || Race._prepStarted)
            {
                Network.SendMessage(sender, "Economy.Notice|A competitive race is already active.");
                return;
            }
            self.ResetLocal();
            self._dmgToWin = Math.Clamp(Convert.ToInt(args.Get(1)), 1, self.MaxTarget);
            self._prepTimer = self.PrepDuration;
            self._prepStarted = true;
            self.AddRacer(sender);
            Network.SendMessageAll("DmgRace.Prep|" + self._dmgToWin);
            self.SyncRacers();
        }
        elif (rpc == "DmgRace.Join")
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
        if (Network.IsMasterClient) {Network.SendMessageAll("DmgRace.Racers|" + Json.SaveToString(self._trackPlayers));}
    }

    function OnSecond()
    {
        if (Network.IsMasterClient) {self.FlushProgress();}
        if (self._prepStarted)
        {
            if (self._prepTimer > 0)
            {
                UI.SetLabelForTime(UILabelEnum.BottomCenter, "Damage race starts in " + self._prepTimer + String.Newline + String.Newline, 1.1);
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
                    Network.SendMessageAll("DmgRace.Start");
                }
            }
        }
        elif (self._raceStarted)
        {
            self._countUpTimer += 1;
            if (self._trackPlayers.Contains(Convert.ToString(Network.MyPlayer.ID)))
            {
                UI.SetLabelForTime(UILabelEnum.MiddleRight, "Damage: " + self._trackedDmg + "/" + self._dmgToWin + String.Newline + self._countUpTimer + "s", 1.1);
            }
        }
    }

    function OnCharacterDamaged(victim, killer, killerName, damage)
    {
        if (!Network.IsMasterClient || !self._raceStarted || victim == null || killer == null || damage <= 0) {return;}
        if (victim.Type != "Titan" || killer.Type != "Human" || killer.Player == null) {return;}
        key = Convert.ToString(killer.Player.ID);
        if (!self._trackPlayers.Contains(key)) {return;}
        value = Convert.ToInt(self._progress.Get(key, 0)) + Convert.ToInt(damage);
        self._progress.Set(key, value);
        self._dirtyProgress.Add(key);
        if (value >= self._dmgToWin) {self.EndHost(killer.Player);}
    }

    function FlushProgress()
    {
        for (key in self._dirtyProgress.ToList())
        {
            player = Network.FindPlayer(Convert.ToInt(key));
            value = self._progress.Get(key, 0);
            if (player == Network.MyPlayer) {self._trackedDmg = value;}
            if (player != null) {Network.SendMessage(player, "DmgRace.Progress|" + value);}
        }
        self._dirtyProgress.Clear();
    }

    function OnPlayerSpawn(player, character)
    {
        if (player == null || character == null || !self._trackPlayers.Contains(Convert.ToString(player.ID))) {return;}
        character.AddOutline(Color("#64d8ff"), OutlineModeEnum.OutlineVisible);
    }

    function OnPlayerLeave(player)
    {
        if (!Network.IsMasterClient || player == null) {return;}
        key = Convert.ToString(player.ID);
        if (self._trackPlayers.Contains(key)) {self._trackPlayers.Remove(key);}
        if (self._progress.Contains(key)) {self._progress.Remove(key);}
        if (self._dirtyProgress.Contains(key)) {self._dirtyProgress.Remove(key);}
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
        Network.SendMessageAll("DmgRace.End|" + winnerID + "|" + self._countUpTimer);
        self.ResetLocal();
    }

    function ApplyOutlines()
    {
        text = "<b>Active Damage Racers</b>" + String.Newline;
        for (key in self._trackPlayers.Keys)
        {
            text += self._trackPlayers.Get(key) + String.Newline;
            player = Network.FindPlayer(Convert.ToInt(key));
            if (player != null && player.Character != null) {player.Character.AddOutline(Color("#64d8ff"), OutlineModeEnum.OutlineVisible);}
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
        self._trackedDmg = 0;
        self._countUpTimer = 0;
        self._trackPlayers.Clear();
        self._progress.Clear();
        self._dirtyProgress.Clear();
        UI.SetLabel(UILabelEnum.MiddleLeft, "");
    }
}
