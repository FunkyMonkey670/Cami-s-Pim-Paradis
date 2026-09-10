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
    _colorSlots = Dict();
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
                state = Json.LoadFromString(args.Get(1));
                if (state != null)
                {
                    racers = state.Get("Players", null);
                    progress = state.Get("Progress", null);
                    colors = state.Get("Colors", null);
                    if (racers != null) {self._trackPlayers = racers;}
                    if (progress != null) {self._progress = progress;}
                    if (colors != null) {self._colorSlots = colors;}
                    self.UpdateTrackedDamage();
                }
                self.ApplyOutlines();
                self.UpdateRaceList();
            }
            elif (rpc == "DmgRace.Rankings" && args.Count >= 2)
            {
                progress = Json.LoadFromString(args.Get(1));
                if (progress != null)
                {
                    self._progress = progress;
                    self.UpdateTrackedDamage();
                    self.UpdateRaceList();
                }
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
        Network.SendMessageAll("DmgRace.Racers|" + Json.SaveToString(state));
    }

    function SyncRankings()
    {
        if (!Network.IsMasterClient) {return;}
        Network.SendMessageAll("DmgRace.Rankings|" + Json.SaveToString(self._progress));
    }

    function OnSecond()
    {
        if (Network.IsMasterClient) {self.FlushProgress();}
        if (self._prepStarted)
        {
            if (self._prepTimer > 0)
            {
                timerText = "<b><color=#64d8ff>DAMAGE RACE</color></b>" + String.Newline +
                    "<color=#ffffff>Starts in </color><color=#ffd43b><b>" + self._prepTimer + "</b></color><color=#ffffff>s</color>" +
                    String.Newline + String.Newline + String.Newline + String.Newline;
                UI.SetLabelForTime(UILabelEnum.BottomCenter, timerText, 1.1);
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
        if (self._dirtyProgress.Count == 0) {return;}
        for (key in self._dirtyProgress.ToList())
        {
            player = Network.FindPlayer(Convert.ToInt(key));
            value = self._progress.Get(key, 0);
            if (player == Network.MyPlayer) {self._trackedDmg = value;}
        }
        self._dirtyProgress.Clear();
        self.SyncRankings();
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

    function UpdateTrackedDamage()
    {
        key = Convert.ToString(Network.MyPlayer.ID);
        self._trackedDmg = Convert.ToInt(self._progress.Get(key, 0));
    }

    function UpdateRaceList()
    {
        keys = self._trackPlayers.Keys.Copy();
        keys.SortCustom(self.CompareRankKeys);
        text = "<b><color=#64d8ff>DAMAGE RACE</color></b> <color=#ffd43b>First to " + self._dmgToWin + "</color>" + String.Newline;
        rank = 1;
        for (key in keys)
        {
            color = RaceVisuals.GetColorHex(self._colorSlots.Get(key, -1));
            score = Convert.ToInt(self._progress.Get(key, 0));
            text += "<color=" + color + "><b>#" + rank + "</b></color> " + self._trackPlayers.Get(key) +
                " <color=#e2e8f0>- " + score + "/" + self._dmgToWin + " damage</color>" + String.Newline;
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
        self._trackedDmg = 0;
        self._countUpTimer = 0;
        self._trackPlayers.Clear();
        self._progress.Clear();
        self._colorSlots.Clear();
        self._dirtyProgress.Clear();
        UI.SetLabel(UILabelEnum.MiddleLeft, "");
    }
}
