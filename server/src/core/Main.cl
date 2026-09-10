class Main
{
    Description = "Pim Server";

    Coins = 100;
    _savings = 0;

    # game mode config

    PreventAlts = false;
    GameMode = "Endless";
    GameModeDropbox = "Waves, Endless";
    GameModeTooltip = "World titan mode used when the lobby starts. The host can switch it later with /mode waves or /mode endless.";
    StartTitans = 8;
    AddTitansPerWave = 2;
    MaxWaves = 250;
    RespawnOnWave = true;
    GradualSpawn = true;
    GradualSpawnDelay = 0.15;
    MaxTitans = 10;
    TitanSpawnEvery = 3.0;
    RespawnDelay = 1.0;
    ForestTitanType = "Default";
    ForestTitanTypeDropbox = "Default, Normal, Abnormal, Jumper, Crawler, Thrower, Punk, Random";
    ForestTitanTypeTooltip = "Titan type spawned by the Waves and Endless world modes.";
    ForestTitanSizeMin = 2.5;
    ForestTitanSizeMinTooltip = "Minimum size for world-mode titans. Values are clamped above zero.";
    ForestTitanSizeMax = 3.0;
    ForestTitanSizeMaxTooltip = "Maximum size for world-mode titans. Reversed min/max values are handled safely.";
    CageFightTitansPerLane = 5;
    CageFightTitansPerLaneTooltip = "Number of cage-fight titans spawned in each fighter's lane.";
    CageFightTitanType = "Default";
    CageFightTitanTypeDropbox = "Default, Normal, Abnormal, Jumper, Crawler, Thrower, Punk, Random";
    CageFightTitanTypeTooltip = "Titan type used only inside cage-fight lanes.";
    CageFightTitanSizeMin = 2.5;
    CageFightTitanSizeMinTooltip = "Minimum size for cage-fight titans.";
    CageFightTitanSizeMax = 3.0;
    CageFightTitanSizeMaxTooltip = "Maximum size for cage-fight titans.";
    _wavesEnabled = true;
    _endlessEnabled = false;
    enableNames = true;

    _currentWave = 0;
    _hasSpawned = false;
    _waveSpawning = false;
    _waveGeneration = 0;
    _waveTitans = Set();
    _endlessTitans = Set();
    _endlessSpawning = false;
    _processedTitanKills = Set();
    _spawnTimeLeft = 0.0;
    _dieTimeLeft = 0.0;

    _selectedSpecial = "Escape";
    _currentSpecial = "Escape";
    _savedSpecial = "Escape";
    _passiveOn = false;
    _fireDamage = false;
    _titanNames = List();
    _guillotineMount = null;
    _pimHead = null;
    dieList = List();
    _commandsRegistered = false;
    _adminCommandsRegistered = false;

    # freecam config
    MoveSpeed = 10.0;
    FastMoveSpeed = 150.0;
    LookSpeed = 150.0;
    FastLookSpeed = 180.0;
    MoveSmoothSpeed = 10.0;
    LookSmoothSpeed = 10.0;
    _xCameraPos = 0.0;
    _yCameraPos = 0.0;
    _zCameraPos = 0.0;
    _xCameraRot = 0.0;
    _yCameraRot = 0.0;
    _xTargetCameraPos = 0.0;
    _yTargetCameraPos = 0.0;
    _zTargetCameraPos = 0.0;
    _xTargetCameraRot = 0.0;
    _yTargetCameraRot = 0.0;
    _enabled = false;

    _pimPrefab = Prefab("Scene,Custom/casino/pokemonguy,1307,0,1,1,1,0,pokemonguy,-147.9688,1.332116,-817.9247,0,0,0,0.2911284,0.2911284,0.2911284,Physical,Entities,Default,DefaultNoTint|255/255/255/255,", false);
    _dieObj = Prefab("Scene,Geometry/Capsule1,6056,0,1,0,0,0,Capsule1,0,0,0,0,0,0,1,1,1,Physical,Entities,Default,Default|255/255/255/255,Rigidbody|Mass:1|Gravity:0/-40/0|FreezeRotation:false|Interpolate:false", false);

    function Init()
    {
        Game.DefaultAddKillScore = false;
        if (Network.IsMasterClient)
        {
            ServerID.LoadPrivateStorageFileNames();
            ServerID.LoadFileNames();
            ServerID.LoadDataFiles();
            MoneyData.LoadAllPlayersData();
            GachaData.LoadAllPlayersData();
            KDData.LoadALLPlayersData();
            ServerID.GetHostServerID();
        }
    }

    function OnGameStart()
    {
        self.ApplyModeState(self.GameMode);
        Interface.Init();
        HandleBakery.Init();
        CardTrading.Init();
        Race.Init();
        DmgRace.Init();
        CFMatchmaking.Init();
        TVController.Init();
        SpectateSpeedSingleton.Init();
        InfiniteResourceSingleton.Init();
        Leaderboard.OnGameStart();

        self.SetCommands();
        ServerID.CheckIfImBanned();
        self._guillotineMount = Map.FindMapObjectByName("GuillotineMount");
        if (self.enableNames) {self.ResetTitanNames();}

        if (Network.IsMasterClient)
        {
            GachaData.LoadMyData(Network.MyPlayer.ID);
            if (self._wavesEnabled) {self.NextWave();}
            elif (self._endlessEnabled) {self.StartEndless();}
            Network.SendMessageAll("Mode.Changed|" + self.GameMode);
            self.SpawnHumans();
        }
        else
        {
            self.WaitAndGetData();
        }
    }

    coroutine WaitAndGetData()
    {
        wait 3;
        if (Network.IsMasterClient) {return;}
        GachaData.LoadMyData(Network.MyPlayer.ID);
        Network.SendMessage(Network.MasterClient, "GetMyKD");
    }

    function SpawnHumans()
    {
        if (!Network.IsMasterClient) {return;}
        for (obj in Map.FindMapObjectsByName("HumanSpawn"))
        {
            if (obj == null) {continue;}
            human = Game.SpawnHumanAt(-1, Data.Grape, LoadoutEnum.HumanBlades, obj.Position, 0.0);
            if (human != null) {human.AllowSkin = true;}
        }
    }

    function SetCommands()
    {
        if (!self._commandsRegistered)
        {
            Commands.RegisterCommand("die", self.DieCommand, "/die: ragdoll your character; /recover restores control");
            Commands.RegisterCommand("passive", self.PassiveCommand, "/passive: toggle passive mode");
            Commands.RegisterCommand("recover", self.RecoverCommand, "/recover: leave ragdoll mode");
            Commands.RegisterCommand("cam", self.CamCommand, "/cam: toggle free camera");
            Commands.RegisterCommand("commands", self.CommandsCommand, "/commands: show available commands");
            Commands.RegisterCommand("give", self.GiveCommand, "/give [playerID] [amount]");
            Commands.RegisterCommand("coins", self.CoinsCommand, "/coins: show wallet and savings");
            Commands.RegisterCommand("getKD", self.GetKDCommand, "/getKD: reload saved scoreboard statistics");
            self._commandsRegistered = true;
        }

        if ((Network.IsMasterClient || ServerID._isAuthorized) && !self._adminCommandsRegistered)
        {
            Commands.RegisterCommand("tp", Command.tpCMD, "/tp [playerID]");
            Commands.RegisterCommand("tpto", Command.TptoCMD, "/tpto [playerID]");
            Commands.RegisterCommand("tpall", Command.tpallCMD, "/tpall");
            Commands.RegisterCommand("smite", Command.SmiteCMD, "/smite [playerID]");
            Commands.RegisterCommand("fire", Command.FireCMD, "/fire [playerID]");
            Commands.RegisterCommand("fireoff", Command.FireOffCMD, "/fireoff [playerID]");
            Commands.RegisterCommand("execute", self.ExecuteCommand, "/execute [playerID]");
            Commands.RegisterCommand("suck", self.BrainSuckCommand, "/suck [playerID]");
            Commands.RegisterCommand("n", self.NukeCommand, "/n [playerID]");
            Commands.RegisterCommand("heli", self.HeliCMD, "/heli");
            if (Network.IsMasterClient)
            {
                Commands.RegisterCommand("op", Command.opCMD, "/op [playerID]");
                Commands.RegisterCommand("deop", Command.deopCMD, "/deop [playerID]");
            }
            self._adminCommandsRegistered = true;
        }
    }

    function RequestAdminTarget(action, args, usage)
    {
        if (args.Count < 1) {Game.Print(usage); return;}
        Network.SendMessage(Network.MasterClient, "Admin.Request|" + action + "|" + Convert.ToInt(args.Get(0)));
    }

    function HeliCMD() {Network.SendMessage(Network.MasterClient, "Admin.Request|heli|-1");}
    function BrainSuckCommand(cmd, args) {self.RequestAdminTarget("suck", args, "Usage: /suck [playerID]");}
    function NukeCommand(cmd, args) {self.RequestAdminTarget("nuke", args, "Usage: /n [playerID]");}
    function ExecuteCommand(cmd, args) {self.RequestAdminTarget("execute", args, "Usage: /execute [playerID]");}
    function GetKDCommand() {Network.SendMessage(Network.MasterClient, "GetMyKD");}

    function CoinsCommand()
    {
        Game.Print("Wallet: " + self.Coins + " | Savings: " + self._savings);
    }

    coroutine SpawnFX()
    {
        character = Network.MyPlayer.Character;
        if (character == null) {return;}
        position = character.Position;
        character.GetKilled("<color=orange>NUKED</color>");
        for (i in Range(12))
        {
            Game.SpawnEffect(EffectNameEnum.Boom5, position + Vector3(0, 30 * i, 0), Vector3(90, 0, 0), 25.0 + i);
            wait 0.03;
        }
        for (i in Range(8))
        {
            Game.SpawnEffect(EffectNameEnum.ShifterThunder, position, Vector3.Zero, 180.0 - (15.0 * i));
            wait 0.05;
        }
    }

    function ResetTitanNames()
    {
        names = "Foid|Norman|Big Dick Randy|Bellend|Dave|Frank|Waltuh|Moid|Dildo|Ambatukam|Genital Warts|Toe Jam|Nostril Hair|Gabriel|Bethanie|Olga|Gaping Anus|Sheryl|Succulent Chinese Meal|Nigel|Gertrude|Bel|Blathers|Robyn|Clar3inet|Lukey|Carlaaa|Envy|Cherry|Chupo|Mythos|Fabel|KittyKat|Nubi|Muti|Chez|Miguel|Misfit|Rai|Crab|Sigil|Tadex|Vivi|Xenny|Pudding|Spunk|Smegmoid|idiot|Foreskin|Mythos' Gay Cousin|Envy's Ego|Cami's Freak|Bykhovsky|Clare|BloodTomb|Tel Aviv|Benjamin Netanyahu|Chud|Baka|The Feminist Movement|Vurucu|Nipple|Adolf|Pim Enemy|Smoliv Hunter|Squimshbot Hacker|Elbow Juice|Hours that Muti is AFK|7s|Scythe|mr wide mouth|KC's Monster Collection|Hopes & Dreams|CJ|Markiplier";
        self._titanNames = String.Split(names, "|", true).Randomize();
    }

    function OnPlayerJoin(player)
    {
        ServerID.OnPlayerJoin(player);
        BodySizeManager.OnPlayerJoin(player);
        if (Network.IsMasterClient && player != null) {Network.SendMessage(player, "Mode.Changed|" + self.GameMode);}
    }

    function OnPlayerLeave(player)
    {
        if (Network.IsMasterClient) {KDData.Flush(); MoneyData.Flush(); GachaData.Flush();}
        ServerID.RemovePlayerFromStorage(player);
        Race.OnPlayerLeave(player);
        DmgRace.OnPlayerLeave(player);
        CFMatchmaking.OnPlayerLeave(player);
        CageFight.OnPlayerLeave(player);
        HandleBakery.OnPlayerLeave(player);
    }

    function OnPlayerSpawn(player, character)
    {
        CFMatchmaking.OnPlayerSpawn(player, character);
        Race.OnPlayerSpawn(player, character);
        DmgRace.OnPlayerSpawn(player, character);
        if (character != null && character.IsMainCharacter)
        {
            Input.SetKeyDefaultEnabled(InputHumanEnum.AttackDefault, true);
            self._dieTimeLeft = self.RespawnDelay;
        }
    }

    function OnCharacterSpawn(character)
    {
        if (character == null) {return;}
        CageFight.OnCharacterSpawn(character);
        if (character.IsMine && character.Type == "Titan" && self.enableNames)
        {
            if (self._titanNames.Count == 0) {self.ResetTitanNames();}
            character.Name = self._titanNames.Get(0);
            self._titanNames.RemoveAt(0);
        }
    }

    function OnSecond()
    {
        ServerID.DelaySIDSendOnSec();
        Race.OnSecond();
        DmgRace.OnSecond();
        CageFight.OnSecond();
        KDData.OnSecond();
        MoneyData.OnSecond();
        GachaData.OnSecond();
        if (self._fireDamage && Network.MyPlayer.Character != null)
        {
            Network.MyPlayer.Character.GetDamaged("Fire", 2);
        }
    }

    function OnTick()
    {
        HandleBakery.OnTick();
        if (self._endlessEnabled) {self.UpdateEndless();}
        elif (self._wavesEnabled) {self.UpdateWaves();}
    }

    function UpdateEndless()
    {
        if (Network.MyPlayer.Status == PlayerStatusEnum.Dead)
        {
            self._dieTimeLeft -= Time.TickTime;
            if (self._dieTimeLeft <= 0.0)
            {
                self._dieTimeLeft = self.RespawnDelay;
                Game.SpawnPlayer(Network.MyPlayer, false);
            }
        }

        if (!Network.IsMasterClient || Game.IsEnding) {return;}
        count = self._endlessTitans.Count;
        if (self._endlessSpawning)
        {
            if (!CageFight._enabled) {UI.SetLabelAll(UILabelEnum.TopCenter, "Titans: " + count + " | Endless");}
            return;
        }
        if (count < self.MaxTitans)
        {
            self._spawnTimeLeft -= Time.TickTime;
            if (self._spawnTimeLeft <= 0.0)
            {
                titan = self.SpawnForestTitan();
                if (titan != null) {self._endlessTitans.Add(titan);}
                self._spawnTimeLeft = self.TitanSpawnEvery;
            }
        }
        else {self._spawnTimeLeft = self.TitanSpawnEvery;}
        if (!CageFight._enabled) {UI.SetLabelAll(UILabelEnum.TopCenter, "Titans: " + self._endlessTitans.Count + " | Endless");}
    }

    function UpdateWaves()
    {
        if (!Network.IsMasterClient || Game.IsEnding) {return;}
        humans = Game.PlayerHumans.Count;
        shifters = Game.PlayerShifters.Count;
        if (humans > 0 || shifters > 0) {self._hasSpawned = true;}
        if (humans == 0 && shifters == 0 && self._hasSpawned)
        {
            UI.SetLabelAll(UILabelEnum.MiddleCenter, "All players were defeated.");
            Game.End(10.0);
            return;
        }
        
        if (!self._waveSpawning && self._waveTitans.Count == 0) {self.NextWave();}
        if (!CageFight._enabled)
        {
            UI.SetLabelAll(UILabelEnum.TopCenter, "Titans Left: " + self._waveTitans.Count + "  Wave: " + self._currentWave);
        }
    }

    function NextWave()
    {
        if (!Network.IsMasterClient || !self._wavesEnabled || Game.IsEnding || self._waveSpawning || self._waveTitans.Count > 0) {return;}
        self._currentWave += 1;
        if (self._currentWave > self.MaxWaves)
        {
            UI.SetLabelAll(UILabelEnum.MiddleCenter, "All waves cleared!");
            Game.End(10.0);
            return;
        }
        self._processedTitanKills.Clear();
        self._waveGeneration += 1;
        amount = self.StartTitans + self.AddTitansPerWave * (self._currentWave - 1);
        self._waveSpawning = true;
        self.SpawnWave(self._waveGeneration, amount);
        if (self.RespawnOnWave) {Game.SpawnPlayerAll(false);}
    }

    coroutine SpawnWave(generation, amount)
    {
        self._waveSpawning = true;
        if (!self.GradualSpawn)
        {
            spawned = Game.SpawnTitans(self.NormalizeTitanType(self.ForestTitanType), amount);
            if (spawned != null)
            {
                for (titan in spawned)
                {
                    if (titan != null) {self.ConfigureTitanSize(titan, self.ForestTitanSizeMin, self.ForestTitanSizeMax); self._waveTitans.Add(titan);}
                }
            }
        }
        else
        {
            for (i in Range(amount))
            {
                if (!self._wavesEnabled || generation != self._waveGeneration) {break;}
                titan = self.SpawnForestTitan();
                if (titan != null) {self._waveTitans.Add(titan);}
                wait self.GradualSpawnDelay;
            }
        }
        if (generation == self._waveGeneration) {self._waveSpawning = false;}
    }

    function ClearWaveTitans()
    {
        self._waveGeneration += 1;
        self._waveSpawning = false;
        self.ClearTitanSet(self._waveTitans);
    }

    function ClearModeTitans()
    {
        self._waveGeneration += 1;
        self._waveSpawning = false;
        self._endlessSpawning = false;
        self.ClearTitanSet(self._waveTitans);
        self.ClearTitanSet(self._endlessTitans);
    }

    function ClearTitanSet(titans)
    {
        for (titan in titans.ToList()) {if (titan != null) {titan.GetKilled("");}}
        titans.Clear();
    }

    function StartEndless()
    {
        if (!Network.IsMasterClient || !self._endlessEnabled || Game.IsEnding) {return;}
        self._spawnTimeLeft = self.TitanSpawnEvery;
        self._endlessSpawning = true;
        self.SpawnInitialEndless(self._waveGeneration);
    }

    coroutine SpawnInitialEndless(generation)
    {
        amount = Math.Max(0, self.MaxTitans);
        for (i in Range(amount))
        {
            if (!self._endlessEnabled || generation != self._waveGeneration) {break;}
            titan = self.SpawnForestTitan();
            if (titan != null) {self._endlessTitans.Add(titan);}
            wait Math.Max(0.02, self.GradualSpawnDelay);
        }
        if (generation == self._waveGeneration) {self._endlessSpawning = false;}
    }

    function NormalizeMode(mode)
    {
        value = String.ToLower(String.Trim(Convert.ToString(mode)));
        if (value == "endless") {return "Endless";}
        return "Waves";
    }

    function ApplyModeState(mode)
    {
        self.GameMode = self.NormalizeMode(mode);
        self._wavesEnabled = self.GameMode == "Waves";
        self._endlessEnabled = self.GameMode == "Endless";
    }

    function NormalizeTitanType(titanType)
    {
        value = String.ToLower(String.Trim(Convert.ToString(titanType)));
        if (value == "normal") {return TitanTypeEnum.Normal;}
        if (value == "abnormal") {return TitanTypeEnum.Abnormal;}
        if (value == "jumper") {return TitanTypeEnum.Jumper;}
        if (value == "crawler") {return TitanTypeEnum.Crawler;}
        if (value == "thrower") {return TitanTypeEnum.Thrower;}
        if (value == "punk") {return TitanTypeEnum.Punk;}
        if (value == "random") {return TitanTypeEnum.Random;}
        return TitanTypeEnum.Default;
    }

    function ConfigureTitanSize(titan, minimum, maximum)
    {
        if (titan == null) {return;}
        first = Math.Max(0.1, Convert.ToFloat(minimum));
        second = Math.Max(0.1, Convert.ToFloat(maximum));
        low = Math.Min(first, second);
        high = Math.Max(first, second);
        if (low == high) {titan.Size = low;}
        else {titan.Size = Random.RandomFloat(low, high);}
    }

    function SpawnForestTitan()
    {
        titan = Game.SpawnTitan(self.NormalizeTitanType(self.ForestTitanType));
        self.ConfigureTitanSize(titan, self.ForestTitanSizeMin, self.ForestTitanSizeMax);
        return titan;
    }

    function SpawnCageTitanAt(position)
    {
        titan = Game.SpawnTitanAt(self.NormalizeTitanType(self.CageFightTitanType), position);
        self.ConfigureTitanSize(titan, self.CageFightTitanSizeMin, self.CageFightTitanSizeMax);
        return titan;
    }

    function SetMode(mode)
    {
        if (!Network.IsMasterClient) {return;}
        nextMode = self.NormalizeMode(mode);
        if (nextMode == self.GameMode) {Game.Print("World mode is already " + self.GameMode + "."); return;}
        self.ClearModeTitans();
        self._currentWave = 0;
        self._hasSpawned = false;
        self.ApplyModeState(nextMode);
        if (self._wavesEnabled) {self.NextWave();}
        elif (self._endlessEnabled) {self.StartEndless();}
        Network.SendMessageAll("Mode.Changed|" + self.GameMode);
        Game.PrintAll("<color=#ffd166>World mode changed to <b>" + self.GameMode + "</b>.</color>");
    }

    function CheckInputs()
    {
        character = Network.MyPlayer.Character;
        if (Input.GetKeyDown(InputInteractionEnum.Function3)) {self.BreakBlades();}
        if (Input.GetKeyDown("Interaction/QuickSelect7") && character != null && character.Type == "Human")
        {
            current = character.CurrentSpecial;
            if (current != SpecialEnum.Carry)
            {
                self._savedSpecial = current;
                self._currentSpecial = SpecialEnum.Carry;
            }
            else
            {
                self._currentSpecial = self._savedSpecial;
                if (self._currentSpecial == null || self._currentSpecial == "") {self._currentSpecial = SpecialEnum.Escape;}
            }
            character.SetSpecial(self._currentSpecial);
        }
        if (Input.GetKeyDown(InputInteractionEnum.Function2))
        {
            UI.ShowPopup("Leaderboard");
            Network.SendMessage(Network.MasterClient, "Leaderboard.Request");
        }
    }

    coroutine BreakBlades()
    {
        character = Network.MyPlayer.Character;
        if (character == null || character.Type != "Human" || character.CurrentBladeDurability <= 0) {return;}
        character.ForceAnimation(HumanAnimationEnum.ChangeBlade, 3);
        wait 0.71;
        if (Network.MyPlayer.Character != character) {return;}
        character.CurrentBladeDurability = 0;
        character.CurrentBlade += 1;
    }

    function OnFrame()
    {
        HandleBakery.OnFrame();
        self.CheckInputs();
        if (!self._enabled) {return;}

        moveSpeed = self.MoveSpeed;
        lookSpeed = self.LookSpeed;
        if (Input.GetKeyHold("MapEditor/Fast") || Input.GetKeyHold("MapEditor/Slow"))
        {
            moveSpeed = self.FastMoveSpeed;
            lookSpeed = self.FastLookSpeed;
        }
        xInput = self.GetAxisFromKeys("MapEditor/Right", "MapEditor/Left") * moveSpeed * Time.FrameTime;
        yInput = self.GetAxisFromKeys("MapEditor/Up", "MapEditor/Down") * moveSpeed * Time.FrameTime;
        zInput = self.GetAxisFromKeys("MapEditor/Forward", "MapEditor/Back") * moveSpeed * Time.FrameTime;
        targetPos = Vector3(self._xTargetCameraPos, self._yTargetCameraPos, self._zTargetCameraPos);
        targetPos += Camera.Forward * zInput + Camera.Up * yInput + Camera.Right * xInput;
        self._xTargetCameraPos = targetPos.X;
        self._yTargetCameraPos = targetPos.Y;
        self._zTargetCameraPos = targetPos.Z;
        self._xTargetCameraRot = Math.Clamp(self._xTargetCameraRot - Input.GetMouseSpeed().Y * lookSpeed * Time.FrameTime, -85, 85);
        self._yTargetCameraRot += Input.GetMouseSpeed().X * lookSpeed * Time.FrameTime;
        self._xCameraPos = Math.Lerp(self._xCameraPos, self._xTargetCameraPos, self.MoveSmoothSpeed * Time.FrameTime);
        self._yCameraPos = Math.Lerp(self._yCameraPos, self._yTargetCameraPos, self.MoveSmoothSpeed * Time.FrameTime);
        self._zCameraPos = Math.Lerp(self._zCameraPos, self._zTargetCameraPos, self.MoveSmoothSpeed * Time.FrameTime);
        self._xCameraRot = Math.Lerp(self._xCameraRot, self._xTargetCameraRot, self.LookSmoothSpeed * Time.FrameTime);
        self._yCameraRot = Math.Lerp(self._yCameraRot, self._yTargetCameraRot, self.LookSmoothSpeed * Time.FrameTime);
        Camera.SetRotation(Vector3(self._xCameraRot, self._yCameraRot, 0));
        Camera.SetPosition(Vector3(self._xCameraPos, self._yCameraPos, self._zCameraPos));
    }

    function Toggle() {self.SetEnabled(!self._enabled);}

    function SetEnabled(enabled)
    {
        if (self._enabled == enabled) {return;}
        self._enabled = enabled;
        self.SetPlayerInputEnabled(!enabled);
        if (enabled)
        {
            pos = Camera.Position;
            rot = Camera.Rotation;
            targetPos = pos - Camera.Forward * 10;
            self._xCameraPos = pos.X;
            self._yCameraPos = pos.Y;
            self._zCameraPos = pos.Z;
            self._xCameraRot = rot.X;
            self._yCameraRot = rot.Y;
            self._xTargetCameraPos = targetPos.X;
            self._yTargetCameraPos = targetPos.Y;
            self._zTargetCameraPos = targetPos.Z;
            self._xTargetCameraRot = rot.X;
            self._yTargetCameraRot = rot.Y;
        }
        Camera.SetManual(enabled);
    }

    function GetAxisFromKeys(positive, negative)
    {
        if (Input.GetKeyHold(positive)) {return 1.0;}
        if (Input.GetKeyHold(negative)) {return -1.0;}
        return 0.0;
    }

    function SetPlayerInputEnabled(enabled)
    {
        Input.SetCategoryKeysEnabled(InputCategoryEnum.General, enabled);
        Input.SetCategoryKeysEnabled(InputCategoryEnum.Human, enabled);
        Input.SetCategoryKeysEnabled(InputCategoryEnum.Titan, enabled);
        Input.SetCategoryKeysEnabled(InputCategoryEnum.AnnieShifter, enabled);
        Input.SetCategoryKeysEnabled(InputCategoryEnum.ErenShifter, enabled);
    }

    function OnCharacterDie(victim, killer, killerName)
    {
        if (victim == null) {return;}
        Race.OnCharacterDie(victim, killer, killerName);
        CageFight.OnCharacterDie(victim, killer, killerName);
        if (self._waveTitans.Contains(victim)) {self._waveTitans.Remove(victim);}
        if (self._endlessTitans.Contains(victim)) {self._endlessTitans.Remove(victim);}

        if (victim.Type == "Human")
        {
            if (victim.IsMainCharacter)
            {
                Input.SetKeyDefaultEnabled(InputGeneralEnum.ChangeCharacter, true);
                self._dieTimeLeft = self.RespawnDelay;
            }
            if (Network.IsMasterClient && victim.Player != null) {KDData.RecordDeath(victim.Player);}
        }
        elif (victim.Type == "Titan" && Network.IsMasterClient && killer != null && killer.Type == "Human" && killer.Player != null)
        {
            if (!self._processedTitanKills.Contains(victim))
            {
                self._processedTitanKills.Add(victim);
                KDData.RecordKill(killer.Player);
            }
        }
    }

    function OnCharacterDamaged(victim, killer, killerName, damage)
    {
        if (victim == null) {return;}
        DmgRace.OnCharacterDamaged(victim, killer, killerName, damage);
        if (victim.Type == "Human" && victim.IsMine)
        {
            Game.SpawnEffect(EffectNameEnum.Blood1, victim.Position, Vector3.Zero, 4);
            victim.PlaySound(HumanSoundEnum.CrashLand);
        }
        elif (victim.Type == "Titan" && killer != null && killer.Type == "Human" && killer.Player != null && Network.IsMasterClient)
        {
            KDData.RecordDamage(killer.Player, damage);
        }
    }

    function OnChatInput(message)
    {
        args = String.Split(message, " ", true);
        if (args.Count == 0) {return true;}
        if (!BodySizeManager.OnChatInput(message)) {return false;}
        ServerID.HandleServerIDCommands(args);
        command = args.Get(0);
        character = Network.MyPlayer.Character;

        if (Network.IsMasterClient)
        {
            if (command == "/kill")
            {
                for (titan in Game.Titans) {if (titan != null) {titan.GetKilled("");}}
                return false;
            }
            if (command == "/refill")
            {
                if (character != null) {character.CurrentGas = character.MaxGas;}
                return false;
            }
            if (command == "/skip")
            {
                if (args.Count < 2) {Game.Print("Usage: /skip [wave]"); return false;}
                if (!self._wavesEnabled) {Game.Print("/skip is only available in Waves mode."); return false;}
                targetWave = Math.Clamp(Convert.ToInt(args.Get(1)), 1, self.MaxWaves);
                self.ClearWaveTitans();
                self._currentWave = targetWave - 1;
                self.NextWave();
                return false;
            }
            if (command == "/effect")
            {
                if (args.Count != 3 || character == null) {Game.Print("Usage: /effect [effect] [scale]"); return false;}
                Game.SpawnEffect(args.Get(1), character.Position, Vector3.Zero, Math.Max(0.1, Convert.ToFloat(args.Get(2))));
                return false;
            }
            if (command == "/mode")
            {
                if (args.Count < 2) {Game.Print("Usage: /mode [waves|endless]"); return false;}
                requestedMode = String.ToLower(args.Get(1));
                if (requestedMode != "waves" && requestedMode != "endless") {Game.Print("Mode must be waves or endless."); return false;}
                self.SetMode(requestedMode);
                return false;
            }
            if (command == "/endless") {self.SetMode("endless"); return false;}
            if (command == "/waves") {self.SetMode("waves"); return false;}
            if (command == "/kd")
            {
                if (args.Count != 4) {Game.Print("Usage: /kd [playerID] [kills] [deaths]"); return false;}
                player = Network.FindPlayer(Convert.ToInt(args.Get(1)));
                if (player != null) {KDData.SetScore(player, Convert.ToInt(args.Get(2)), Convert.ToInt(args.Get(3)));}
                return false;
            }
        }

        if (command == "/tkick" || command == "/pban" || command == "/auth") {return false;}
        if (command == "/particle" || command == "/pdisable")
        {
            if (args.Count != 2 || character == null || character.Type != "Human") {return false;}
            character.SetParticleEffect(args.Get(1), command == "/particle");
            return false;
        }
        return true;
    }

    function GiveCommand(cmd, args)
    {
        if (args.Count < 2) {Game.Print("Usage: /give [playerID] [amount]"); return;}
        targetID = Convert.ToInt(args.Get(0));
        amount = Convert.ToInt(args.Get(1));
        if (Network.FindPlayer(targetID) == null) {Game.Print("Player not found."); return;}
        if (amount <= 0) {Game.Print("Amount must be positive."); return;}
        if (self.Coins < amount) {Game.Print("Not enough coins."); return;}
        Network.SendMessage(Network.MasterClient, "GiveMoney|" + targetID + "|" + amount);
    }

    function CommandsCommand()
    {
        nl = String.Newline;
        text = "/passive — toggle passive mode" + nl;
        text += "/csize [x] [y] [z] — change character size" + nl;
        text += "/die and /recover — toggle ragdoll state" + nl;
        text += "/cam — toggle free camera" + nl;
        text += "/particle [name] and /pdisable [name] — toggle an effect" + nl;
        text += "/give [playerID] [amount] — transfer coins" + nl;
        text += "/cf — join the cage-fight queue; /cfcancel — leave it" + nl;
        if (Network.IsMasterClient) {text += "/mode [waves|endless] — switch the world mode" + nl;}
        text += "/startrace [kills] — start a kill race";
        Game.Print(text);
    }

    function CamCommand() {self.Toggle();}

    function RecoverCommand()
    {
        character = Network.MyPlayer.Character;
        if (character == null) {return;}
        character.Unmount(true);
        self.DieDelete();
    }

    function DieCommand()
    {
        character = Network.MyPlayer.Character;
        if (character == null) {return;}
        obj = Map.CreateMapObject(self._dieObj, character.Position, Vector3(character.Rotation.X, character.Rotation.Y, character.Rotation.Z), Vector3(1, 1, 1));
        if (obj == null) {return;}
        self.dieList.Add(obj);
        obj.AddSphereCollider("Physical", "All", Vector3.Zero, 0.5);
        character.MountMapObject(obj, Vector3(0, -1, 0), Vector3.Zero);
        obj.Rigidbody.AddForce(Vector3(0, 0, 5), ForceModeEnum.Impulse);
        obj.Rigidbody.AddTorque(Vector3(0, 0, 8), ForceModeEnum.Impulse);
    }

    coroutine DieDelete()
    {
        wait 3;
        while (self.dieList.Count > 0)
        {
            obj = self.dieList.Get(self.dieList.Count - 1);
            if (obj != null) {Map.DestroyMapObject(obj, true);}
            self.dieList.RemoveAt(self.dieList.Count - 1);
        }
    }

    function PassiveCommand()
    {
        character = Network.MyPlayer.Character;
        if (character == null) {return;}
        if (self._passiveOn)
        {
            character.Team = TeamEnum.Human;
            self._passiveOn = false;
            Game.Print("Passive Mode Off");
        }
        else
        {
            character.Team = TeamEnum.Blue;
            self._passiveOn = true;
            Game.Print("Passive Mode On");
        }
    }

    function SuckMe(id)
    {
        player = Network.FindPlayer(id);
        if (player == null || player.Character == null) {return;}
        transform = player.Character.Transform.GetTransform("Armature/Core/Controller_Body/hip/spine/chest/neck/head");
        if (transform == null) {return;}
        self._pimHead = Map.CreateMapObject(self._pimPrefab, transform.Position, transform.Forward, Vector3(0.38, 0.38, 0.38));
        if (self._pimHead != null) {self._pimHead.Parent = transform;}
    }

    function OnNetworkMessage(sender, message)
    {
        args = String.Split(message, "|", false);
        if (args.Count == 0) {return;}
        rpc = args.Get(0);

        BodySizeManager.OnNetworkMessage(sender, message);
        Leaderboard.OnNetworkMessage(sender, message, args);
        ServerID.HandleServerIDRpcs(sender, args);
        CmdsNetworking.OnNetworkMessage(sender, message, args);
        Race.OnNetworkMessage(sender, message, args);
        CardTrading.OnNetworkMessage(sender, message, args);
        HandleBakery.OnNetworkMessage(sender, message, args);
        DmgRace.OnNetworkMessage(sender, message, args);
        CFMatchmaking.OnNetworkMessage(sender, message, args);
        TVController.OnNetworkMessage(sender, message, args);

        if (sender == Network.MasterClient)
        {
            if (rpc == "Economy.Sync" && args.Count >= 3)
            {
                self.Coins = Math.Max(0, Convert.ToInt(args.Get(1)));
                self._savings = Math.Max(0, Convert.ToInt(args.Get(2)));
                if (Interface.Gacha != null) {Interface.Gacha.UpdateUI(null);}
            }
            elif (rpc == "Mode.Changed" && args.Count >= 2) {self.ApplyModeState(args.Get(1));}
            elif (rpc == "Economy.Notice" && args.Count >= 2) {Game.Print(args.Get(1));}
            elif (rpc == "YourGachaData" && args.Count >= 2) {GachaData.LoadItemToInv(Json.LoadFromString(args.Get(1)));}
            elif (rpc == "SendToTheGallows")
            {
                character = Network.MyPlayer.Character;
                if (character != null && self._guillotineMount != null)
                {
                    character.MountMapObject(self._guillotineMount, Vector3.Zero, Vector3.Zero, false);
                    Input.SetKeyDefaultEnabled(InputGeneralEnum.ChangeCharacter, false);
                    Game.PrintAll(Network.MyPlayer.Name + " HAS BEEN SENT TO THE GUILLOTINE");
                }
            }
            elif (rpc == "NukeME") {self.SpawnFX();}
            elif (rpc == "SuckPlayer" && args.Count >= 2) {self.SuckMe(Convert.ToInt(args.Get(1)));}
        }

        if (!Network.IsMasterClient) {return;}
        senderServerID = ServerID._playerServerIDs.Get(sender.ID);
        if (senderServerID == null) {return;}

        if (rpc == "GiveMoney" && args.Count >= 3)
        {
            target = Network.FindPlayer(Convert.ToInt(args.Get(1)));
            amount = Convert.ToInt(args.Get(2));
            if (target == null) {return;}
            targetServerID = ServerID._playerServerIDs.Get(target.ID);
            if (targetServerID != null) {MoneyData.TransferWallet(sender, senderServerID, target, targetServerID, amount);}
        }
        elif (rpc == "Economy.Flush" && (sender == Network.MasterClient || ServerID._authorizedUsers.Contains(sender)))
        {
            MoneyData.Flush();
            KDData.Flush();
            GachaData.Flush();
        }
        elif (rpc == "GetMyKD") {KDData.SyncPlayer(senderServerID, sender);}
        elif (rpc == "LoadMyGacha") {GachaData.LoadMyData(sender.ID);}
    }
}
