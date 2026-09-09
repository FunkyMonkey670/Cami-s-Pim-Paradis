extension CFMatchmaking
{
    _matchStarted = false;
    _activePlayers = Set();
    _player1 = null;
    _player2 = null;
    _queuedPlayers = List();
    _spawn1 = null;
    _spawn2 = null;
    _killZone = null;

    function Init()
    {
        Commands.RegisterCommand("cf", self.QueueCFCmd, "/cf: join the cage-fight queue");
        Commands.RegisterCommand("leavecf", self.LeaveCFQueue, "/leavecf: leave the cage-fight queue");
        if (Network.IsMasterClient)
        {
            Commands.RegisterCommand("cfend", self.EndCMD, "/cfend: end the active cage fight");
            Commands.RegisterCommand("clearqueue", self.ClearQueueCMD, "/clearqueue: empty the cage-fight queue");
            Commands.RegisterCommand("cfstart", self.StartCMD, "/cfstart: start a match from the queue");
        }

        first = Map.FindMapObjectByName("Player1CFSpawn");
        second = Map.FindMapObjectByName("Player2CFSpawn");
        if (first != null) {self._spawn1 = first.Position;}
        if (second != null) {self._spawn2 = second.Position;}
        self._killZone = Map.FindMapObjectByName("CFKillZone");
        if (Network.IsMasterClient) {self.BroadcastQueue();}
    }

    function QueueCFCmd(cmd, args) {Network.SendMessage(Network.MasterClient, "CF.Join");}
    function LeaveCFQueue() {Network.SendMessage(Network.MasterClient, "CF.Leave");}
    function StartCMD() {self.TryStartMatch();}
    function EndCMD() {self.EndMatch();}

    function ClearQueueCMD()
    {
        if (!Network.IsMasterClient) {return;}
        self._queuedPlayers.Clear();
        self.BroadcastQueue();
    }

    function OnPlayerSpawn(player, character)
    {
        if (!Network.IsMasterClient || !self._matchStarted || character == null) {return;}
        if (player == self._player1) {character.Team = TeamEnum.Red;}
        elif (player == self._player2) {character.Team = TeamEnum.Blue;}
    }

    function OnPlayerLeave(player)
    {
        if (!Network.IsMasterClient || player == null) {return;}
        if (self._queuedPlayers.Contains(player.ID))
        {
            self._queuedPlayers.Remove(player.ID);
            self.BroadcastQueue();
        }
    }

    function OnNetworkMessage(sender, message, args)
    {
        if (args.Count == 0) {return;}
        rpc = args.Get(0);

        if (Network.IsMasterClient)
        {
            if (rpc == "CF.Join") {self.Enqueue(sender); return;}
            if (rpc == "CF.Leave") {self.Dequeue(sender); return;}
        }

        if (sender != Network.MasterClient) {return;}
        if (rpc == "CF.Queue" && args.Count >= 2)
        {
            queue = Json.LoadFromString(args.Get(1));
            if (queue != null) {self._queuedPlayers = queue;}
            self.RenderQueue();
        }
        elif (rpc == "CF.Assigned" && args.Count >= 2)
        {
            slot = Convert.ToInt(args.Get(1));
            Game.Print("<color=#ffd166>You are fighter " + slot + ".</color>");
        }
        elif (rpc == "CF.Ended")
        {
            UI.SetLabel(UILabelEnum.MiddleRight, "");
        }
    }

    function Enqueue(player)
    {
        if (player == null || self.IsActiveFighter(player)) {return;}
        if (!self._queuedPlayers.Contains(player.ID)) {self._queuedPlayers.Add(player.ID);}
        self.BroadcastQueue();
        place = 0;
        for (i in Range(self._queuedPlayers.Count))
        {
            if (self._queuedPlayers.Get(i) == player.ID) {place = i + 1;}
        }
        Network.SendMessage(player, "Economy.Notice|Cage-fight queue position: " + place);
        self.TryStartMatch();
    }

    function Dequeue(player)
    {
        if (player == null || !self._queuedPlayers.Contains(player.ID)) {return;}
        self._queuedPlayers.Remove(player.ID);
        self.BroadcastQueue();
    }

    function PruneQueue()
    {
        clean = List();
        for (playerID in self._queuedPlayers)
        {
            player = Network.FindPlayer(playerID);
            if (player != null && player.Connected && !clean.Contains(playerID)) {clean.Add(playerID);}
        }
        self._queuedPlayers = clean;
    }

    function TryStartMatch()
    {
        if (!Network.IsMasterClient || self._matchStarted) {return;}
        self.PruneQueue();
        if (self._queuedPlayers.Count < 2) {self.BroadcastQueue(); return;}

        self._player1 = Network.FindPlayer(self._queuedPlayers.Get(0));
        self._player2 = Network.FindPlayer(self._queuedPlayers.Get(1));
        self._queuedPlayers.RemoveAt(0);
        self._queuedPlayers.RemoveAt(0);
        if (self._player1 == null || self._player2 == null)
        {
            self._player1 = null;
            self._player2 = null;
            self.BroadcastQueue();
            self.TryStartMatch();
            return;
        }
        if (self._spawn1 == null || self._spawn2 == null || self._killZone == null)
        {
            Game.Print("<color=#f75348>[Cage Fight]</color> Required spawn or kill-zone objects are missing.");
            self._queuedPlayers.InsertAt(0, self._player2.ID);
            self._queuedPlayers.InsertAt(0, self._player1.ID);
            self._player1 = null;
            self._player2 = null;
            self.BroadcastQueue();
            return;
        }

        self._matchStarted = true;
        self._activePlayers.Clear();
        self._activePlayers.Add(self._player1);
        self._activePlayers.Add(self._player2);
        self._killZone.Active = false;
        Network.SendMessage(self._player1, "CF.Assigned|1");
        Network.SendMessage(self._player2, "CF.Assigned|2");
        self.BroadcastQueue();
        Game.PrintAll("<b><color=#ffd166>CAGE FIGHT:</color></b> " + self._player1.Name + " <color=#aaaaaa>vs</color> " + self._player2.Name);

        if (!CageFight.Start()) {self.EndMatch();}
    }

    function PlaceFighters()
    {
        if (!self.HasActiveFighters()) {return;}
        self._player1.SpawnPoint = self._spawn1;
        self._player2.SpawnPoint = self._spawn2;
        Game.SpawnPlayerAt(self._player1, true, self._spawn1);
        Game.SpawnPlayerAt(self._player2, true, self._spawn2);
        if (self._player1.Character != null) {self._player1.Character.Team = TeamEnum.Red;}
        if (self._player2.Character != null) {self._player2.Character.Team = TeamEnum.Blue;}
    }

    function HasActiveFighters()
    {
        return self._player1 != null && self._player2 != null && self._player1.Connected && self._player2.Connected;
    }

    function IsActiveFighter(player)
    {
        return player != null && (player == self._player1 || player == self._player2);
    }

    function GetOpponent(player)
    {
        if (player == self._player1) {return self._player2;}
        if (player == self._player2) {return self._player1;}
        return null;
    }

    function EndMatch()
    {
        if (!Network.IsMasterClient || !self._matchStarted) {return;}
        first = self._player1;
        second = self._player2;
        CageFight.Reset();
        self._matchStarted = false;
        self._activePlayers.Clear();
        self._player1 = null;
        self._player2 = null;
        if (self._killZone != null) {self._killZone.Active = true;}
        self.ReleaseFighter(first);
        self.ReleaseFighter(second);
        Network.SendMessageAll("CF.Ended");
        self.BroadcastQueue();
        self.TryStartMatch();
    }

    function ReleaseFighter(player)
    {
        if (player == null || !player.Connected) {return;}
        player.SpawnPoint = null;
        Game.SpawnPlayer(player, true);
    }

    function BroadcastQueue()
    {
        if (!Network.IsMasterClient) {return;}
        self.PruneQueue();
        Network.SendMessageAll("CF.Queue|" + Json.SaveToString(self._queuedPlayers));
    }

    function RenderQueue()
    {
        text = "<b>-- Cage Fight Queue --</b>" + String.Newline;
        if (self._queuedPlayers.Count == 0) {text += "Queue is empty.";}
        for (i in Range(self._queuedPlayers.Count))
        {
            player = Network.FindPlayer(self._queuedPlayers.Get(i));
            if (player != null) {text += (i + 1) + ". " + player.Name + String.Newline;}
        }
        UI.SetLabel(UILabelEnum.MiddleRight, text);
    }
    
    function Lists() {return self._queuedPlayers.Count >= 2;}
    function StartMatch() {self.TryStartMatch();}
    function Round2() {CageFight.BeginRound(2);}
    function Round3() {CageFight.BeginRound(3);}
    function DetermineWinner() {CageFight.CheckRoundWinner();}
    function CheckQueue() {self.TryStartMatch();}
    function SendMessageToFighters(message) {}
}
