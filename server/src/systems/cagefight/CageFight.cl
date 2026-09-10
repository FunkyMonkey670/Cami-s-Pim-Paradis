extension CageFight
{
    RoundDelay = 2.0;

    _redTitans = Set();
    _blueTitans = Set();
    _enabled = false;
    _transitioning = false;
    _clearing = false;
    _round = 0;
    _p1Score = 0;
    _p2Score = 0;
    _matchGeneration = 0;
    _matchPlayer1ID = -1;
    _matchPlayer2ID = -1;
    _titanSpawnPointsA = List();
    _titanSpawnPointsB = List();

    function Start()
    {
        if (!Network.IsMasterClient || CFMatchmaking._player1 == null || CFMatchmaking._player2 == null) {return false;}
        self._titanSpawnPointsA = Map.FindMapObjectsByName("Titan A");
        self._titanSpawnPointsB = Map.FindMapObjectsByName("Titan B");
        if (self._titanSpawnPointsA.Count == 0 || self._titanSpawnPointsB.Count == 0)
        {
            Game.Print("<b><color=#f75348>[Cage Fight]</color></b> Missing Titan A or Titan B spawn points.");
            return false;
        }

        self._matchGeneration += 1;
        generation = self._matchGeneration;
        self._matchPlayer1ID = CFMatchmaking._player1.ID;
        self._matchPlayer2ID = CFMatchmaking._player2.ID;
        self._enabled = true;
        self._transitioning = false;
        self._round = 0;
        self._p1Score = 0;
        self._p2Score = 0;
        self.BeginRoundForMatch(1, generation);
        return true;
    }

    function BeginRound(round)
    {
        self.BeginRoundForMatch(round, self._matchGeneration);
    }

    function BeginRoundForMatch(round, generation)
    {
        if (!self._enabled || !Network.IsMasterClient || generation != self._matchGeneration || !self.HasCurrentPair()) {return;}
        self._transitioning = true;
        self._round = round;
        self.ClearTitans();
        self.StartRoundAfterDelay(round, generation);
    }

    coroutine StartRoundAfterDelay(round, generation)
    {
        wait self.RoundDelay;
        if (!self._enabled || generation != self._matchGeneration || self._round != round || !self.HasCurrentPair() || !CFMatchmaking.HasActiveFighters()) {return;}
        CFMatchmaking.PlaceFighters();
        self.SpawnLane(self._redTitans, self._titanSpawnPointsA, TeamEnum.Blue);
        self.SpawnLane(self._blueTitans, self._titanSpawnPointsB, TeamEnum.Red);
        self._transitioning = false;
        UI.SetLabelAll(UILabelEnum.TopCenter, self.GetRemainingTitansLabel());
        Game.PrintAll("<color=#ffd166>Cage Fight round " + round + " has begun.</color>");
    }

    function OnCharacterSpawn(character)
    {
        # for forwarding
    }

    function OnCharacterDie(victim, killer, killerName)
    {
        if (!Network.IsMasterClient || !self._enabled || self._clearing || self._transitioning || victim == null) {return;}
        if (victim.Type != "Titan") {return;}

        lane = "";
        if (self._redTitans.Contains(victim))
        {
            self._redTitans.Remove(victim);
            lane = "red";
        }
        elif (self._blueTitans.Contains(victim))
        {
            self._blueTitans.Remove(victim);
            lane = "blue";
        }
        else {return;}

        killerPlayer = null;
        if (killer != null && killer.Type == "Human") {killerPlayer = killer.Player;}
        if (lane == "red" && CFMatchmaking.IsSamePlayer(killerPlayer, CFMatchmaking._player1))
        {
            self.SpawnOne(self._blueTitans, self._titanSpawnPointsB, TeamEnum.Red);
        }
        elif (lane == "blue" && CFMatchmaking.IsSamePlayer(killerPlayer, CFMatchmaking._player2))
        {
            self.SpawnOne(self._redTitans, self._titanSpawnPointsA, TeamEnum.Blue);
        }
        elif ((lane == "red" && !CFMatchmaking.IsSamePlayer(killerPlayer, CFMatchmaking._player1)) ||
            (lane == "blue" && !CFMatchmaking.IsSamePlayer(killerPlayer, CFMatchmaking._player2)))
        {
            if (lane == "red") {self.SpawnOne(self._redTitans, self._titanSpawnPointsA, TeamEnum.Blue);}
            else {self.SpawnOne(self._blueTitans, self._titanSpawnPointsB, TeamEnum.Red);}
        }

        self.CheckRoundWinner();
        if (self._enabled) {UI.SetLabelAll(UILabelEnum.TopCenter, self.GetRemainingTitansLabel());}
    }

    function OnPlayerLeave(player)
    {
        if (Network.IsMasterClient && self._enabled && CFMatchmaking.IsActiveFighter(player))
        {
            remaining = CFMatchmaking.GetOpponent(player);
            if (remaining != null) {Game.PrintAll("<color=#ffd166>" + remaining.Name + " wins because their opponent left.</color>");}
            CFMatchmaking.EndMatch();
        }
    }

    function OnSecond()
    {
        if (!Network.IsMasterClient || !self._enabled || self._transitioning) {return;}
        self.TargetLane(self._redTitans, CFMatchmaking._player1);
        self.TargetLane(self._blueTitans, CFMatchmaking._player2);
    }

    function TargetLane(titans, player)
    {
        if (player == null || player.Character == null) {return;}
        for (titan in titans.ToList())
        {
            if (titan != null) {titan.Target(player.Character, Math.Infinity);}
        }
    }

    function CheckRoundWinner()
    {
        if (self._transitioning || !self.HasCurrentPair()) {return;}
        winner = null;
        if (self._redTitans.Count == 0) {winner = CFMatchmaking._player1; self._p1Score += 1;}
        elif (self._blueTitans.Count == 0) {winner = CFMatchmaking._player2; self._p2Score += 1;}
        if (winner == null) {return;}

        self._transitioning = true;
        Game.PrintAll("<color=#ffd166>" + winner.Name + " won round " + self._round + ".</color>");
        if (self._p1Score >= 2 || self._p2Score >= 2 || self._round >= 3)
        {
            matchWinner = CFMatchmaking._player1;
            if (self._p2Score > self._p1Score) {matchWinner = CFMatchmaking._player2;}
            Game.PrintAll("<b><color=#f7c948>" + matchWinner.Name + " won the cage fight " + self._p1Score + "-" + self._p2Score + "!</color></b>");
            CFMatchmaking.EndMatch();
        }
        else {self.BeginRoundForMatch(self._round + 1, self._matchGeneration);}
    }

    function SpawnLane(lane, spawnPoints, titanTeam)
    {
        count = Math.Max(1, Main.CageFightTitansPerLane);
        for (i in Range(count)) {self.SpawnOne(lane, spawnPoints, titanTeam);}
    }

    function SpawnOne(lane, spawnPoints, titanTeam)
    {
        if (spawnPoints == null || spawnPoints.Count == 0) {return null;}
        spawn = spawnPoints.Get(Random.RandomInt(0, spawnPoints.Count));
        if (spawn == null) {return null;}
        titan = Main.SpawnCageTitanAt(spawn.Position);
        if (titan != null)
        {
            titan.Team = titanTeam;
            titan.DetectRange = 800;
            lane.Add(titan);
        }
        return titan;
    }

    function GetRemainingTitansLabel()
    {
        if (CFMatchmaking._player1 == null || CFMatchmaking._player2 == null) {return "";}
        return "[" + self._p1Score + "] " + CFMatchmaking._player1.Name + " <color=#f06464>[" + self._redTitans.Count + "]</color> | " +
            "<color=#62b7f0>[" + self._blueTitans.Count + "]</color> " + CFMatchmaking._player2.Name + " [" + self._p2Score + "]";
    }

    function HasCurrentPair()
    {
        return CFMatchmaking._player1 != null && CFMatchmaking._player2 != null &&
            CFMatchmaking._player1.ID == self._matchPlayer1ID && CFMatchmaking._player2.ID == self._matchPlayer2ID;
    }

    function ClearTitans()
    {
        self._clearing = true;
        for (titan in self._redTitans.ToList()) {if (titan != null) {titan.GetKilled("");}}
        for (titan in self._blueTitans.ToList()) {if (titan != null) {titan.GetKilled("");}}
        self._redTitans.Clear();
        self._blueTitans.Clear();
        self._clearing = false;
    }

    function Reset()
    {
        self._matchGeneration += 1;
        self._enabled = false;
        self._transitioning = true;
        self.ClearTitans();
        self._transitioning = false;
        self._round = 0;
        self._p1Score = 0;
        self._p2Score = 0;
        self._matchPlayer1ID = -1;
        self._matchPlayer2ID = -1;
        UI.SetLabelAll(UILabelEnum.TopCenter, "");
    }
}
