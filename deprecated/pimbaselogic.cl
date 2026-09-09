class Main
{
    Description = "Survive multiple waves of titans.";

    Coins = 100;
    _savings = null;
    PreventAlts = false;
    StartTitans = 8;
    AddTitansPerWave = 2;
    MaxWaves = 250;
    RespawnOnWave = true;
    GradualSpawn = true;
    GradualSpawnTooltip = "Spawn new titans gradually over time. Helpful for reducing lag.";
    wavesEnabled = true;
    endlessEnabled = false;
    enableNames = true;

    #==========ENDLESS SETTINGS==========#
        MaxTitans = 10;
        TitanSpawnEvery = 3.0;
        RespawnDelay = 5.0;
        _spawnTimeLeft = 0.0;
        _dieTimeLeft = 0.0;
    #----------DEFAULT WAVE VARS----------#
        _currentWave = 0;
        _hasSpawned = false;
    #----------SKILL SWITCH VARS----------#
        _selectedSpecial = "Escape";
        _currentSpecial = "Escape";
        _savedSpecial = "Escape";
    #----------FREE CAM SETTINGS----------#
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
    #-----------VARIOUS VARS----------#
        _passiveOn = false;
        _titanNames = List();
        _guillotineMount = null;
        _pimHead = null;
        _pimHeadList = List();
    #----------PREFABS----------#
        _pimPrefab = Prefab("Scene,Custom/casino/pokemonguy,1307,0,1,1,1,0,pokemonguy,-147.9688,1.332116,-817.9247,0,0,0,0.2911284,0.2911284,0.2911284,Physical,Entities,Default,DefaultNoTint|255/255/255/255,",false);
    #----------ON GAME START----------#
        function Init()
        {
            if (Network.IsMasterClient)
            {
                ServerID.LoadPrivateStorageFileNames();
                ServerID.LoadFileNames();
                ServerID.LoadDataFiles();
                ServerID.GetHostServerID();

                MoneyData.LoadAllPlayersData();
                GachaData.LoadAllPlayersData();
                KDData.LoadALLPlayersData();
            }
        }

        function OnGameStart()
        {
            Leaderboard.OnGameStart();
            ServerID.CheckIfImBanned();
            self._guillotineMount = Map.FindMapObjectByName("GuillotineMount");
            if (self.enableNames)
            {
               self.AddNamesToList();
               self.RandomizeNames();  
            }

            if (Network.IsMasterClient) 
            {
                GachaData.LoadMyData(Network.MyPlayer.ID);
                if (self.wavesEnabled)
                {
                    self.NextWave();
                }
                elif (self.endlessEnabled)
                {
                    Game.SpawnTitans("Default", self.MaxTitans);
                }
            }
             self.WaitAndGetData();

            self.SetCommands();
            self.SpawnHumans();
        }

        coroutine WaitAndGetData()
        {
            if (Network.IsMasterClient) {return;}
            wait 8;
            GachaData.LoadMyData(Network.MyPlayer.ID);
            #Game.Print("Loadng");
            Network.SendMessage(Network.MasterClient,"GetMyKD");
        }

        function SpawnHumans()
        {
            objs = Map.FindMapObjectsByName("HumanSpawn");

            for (obj in objs)
            {
                human = Game.SpawnHumanAt(-1, Data.Grape,"Blades", obj.Position, obj.Position.Y);
                human.AllowSkin = true;
            }
        }

        function SetCommands()
        {
            Commands.RegisterCommand("die", self.DieCommand, "/die [Ragdolls your character] [/recover to recover]");
            Commands.RegisterCommand("passive", self.PassiveCommand, "/passive [Same command to turn it off and on]");
            Commands.RegisterCommand("recover", self.RecoverCommand,"/recover [Recovers character from ragdoll]");
            Commands.RegisterCommand("cam", self.CamCommand,"/cam [Enters free cam]");
            Commands.RegisterCommand("commands", self.CommandsCommand,"/commands [Shows the list of commands]");
            Commands.RegisterCommand("give", self.GiveCommand,"/give [playerID] [amount]");
            Commands.RegisterCommand("coins", self.CoinsCommand,"/coins");
            Commands.RegisterCommand("getKD", self.GetKDCommand,"/getKD");

            if (Network.IsMasterClient || Network.MyPlayer.GetCustomProperty("IsOp") == true)
            {
                Commands.RegisterCommand("tp",Command.tpCMD,"/tp [playerID]");
                Commands.RegisterCommand("tpto",Command.TptoCMD,"/tpto [playerID]");
                Commands.RegisterCommand("tpall",Command.tpallCMD,"/tpall");
                Commands.RegisterCommand("smite",Command.SmiteCMD,"/smite [playerID]");
                Commands.RegisterCommand("fire",Command.FireCMD,"/fire [playerID]");
                Commands.RegisterCommand("fireoff",Command.FireOffCMD,"/fireoff [playerID]");
                Commands.RegisterCommand("execute",self.ExecuteCommand,"/execute [playerID]");
                Commands.RegisterCommand("suck",self.BrainSuckCommand,"/suck [playerID]");
                Commands.RegisterCommand("n",self.NukeCommand,"/n [playerID]");
                Commands.RegisterCommand("test",self.TestCMD,"/test");
                Commands.RegisterCommand("heli",self.HeliCMD,"/heli");
            }
        }

    function TestCMD()
    {
        
    }

    function HeliCMD()
    {
        heli = Map.FindMapObjectByName("helicopter");

        heli.Position += Vector3.Up * 6;
    }

    function BrainSuckCommand(cmd,args)
    {
        pID = Convert.ToInt(args.Get(0));

        Network.SendMessageAll("SuckPlayer|" + pID);
    }
    
    function NukeCommand(cmd,args)
    {
        pID = Convert.ToInt(args.Get(0));
        player = Network.FindPlayer(pID);
        Network.SendMessage(player, "NukeME");
    }
    coroutine SpawnFX() 
    {
        charPos = Network.MyPlayer.Character.Position;
        pos = Vector3(charPos.X,charPos.Y,charPos.Z);
        posf = Vector3(charPos.X,charPos.Y,charPos.Z);
        posog = Vector3(charPos.X,charPos.Y,charPos.Z); 
        pose = Vector3(charPos.X,charPos.Y,charPos.Z);
        
        for (i in Range(0, 70, 1)) {   
        yOffset = 100 + (25 * i);
        Game.SpawnEffect("Boom5", pos + Vector3(0, yOffset, 0), Vector3(90, 0, 0), 25.0);
        }
        Network.MyPlayer.Character.GetKilled("<color=orange>NUKED</color>");
        Game.SpawnEffect("Boom2", posf, Vector3(90, 0, 0), 30.0);
        Game.SpawnEffect("Boom2", posf + Vector3(0,25,0), Vector3(90, 0, 0), 30.0);
        Game.SpawnEffect("Boom2", posf + Vector3(0,75,0), Vector3(90, 0, 0), 40.0);
        Game.SpawnEffect("Boom2", posf + Vector3(0,125,0), Vector3(90, 0, 0), 50.0);
        Game.SpawnEffect("Boom2", posf + Vector3(0,175,0), Vector3(90, 0, 0), 60.0);
        Game.SpawnEffect("Boom2", posf + Vector3(0,225,0), Vector3(90, 0, 0), 70.0);
        Game.SpawnEffect("Boom2", posf + Vector3(0,275,0), Vector3(90, 0, 0), 60.0);
        Game.SpawnEffect("Boom2", posf + Vector3(0,295,0), Vector3(90, 0, 0), 50.0);
        Game.SpawnEffect("Boom2", posf + Vector3(0,315,0), Vector3(90, 0, 0), 40.0);
        Game.SpawnEffect("Boom2", posf + Vector3(0,335,0), Vector3(90, 0, 0), 30.0);
        Game.SpawnEffect("Boom2", posf + Vector3(0,355,0), Vector3(90, 0, 0), 20.0);

        for(i in Range(0, 100, 1)) {   
        fxrad = 700 - (7 * i);
        Game.SpawnEffect("ShifterThunder", pose, Vector3.Zero, 150 + fxrad);
        }

        wait 0.8;
        for(i in Range(0, 15, 1)) {
        wait 0.25;
        radius = 25 + (20 * i);
        Game.SpawnEffect("Boom6", posog, Vector3(90, 0, 0), 25.0 + radius);
        }
    }

        function ExecuteCommand(cmd,args)
        {
            pID = Convert.ToInt(args.Get(0));

            player = Network.FindPlayer(pID);

            Network.SendMessage(player, "SendToTheGallows");
        }

        function GetKDCommand()
        {
            Network.SendMessage(Network.MasterClient,"GetMyKD");
        }

        function CoinsCommand()
        {
            Game.Print(Main.Coins);
        }

        function AddNamesToList()
        {
            self._titanNames.Add("Foid");
            self._titanNames.Add("Norman");
            self._titanNames.Add("Big Dick Randy");
            self._titanNames.Add("Bellend");
            self._titanNames.Add("Dave");
            self._titanNames.Add("Frank");
            self._titanNames.Add("Waltuh");
            self._titanNames.Add("Moid");
            self._titanNames.Add("Dildo");
            self._titanNames.Add("Ambatukam");
            self._titanNames.Add("Genital Warts");
            self._titanNames.Add("Toe Jam");
            self._titanNames.Add("Nostril Hair");
            self._titanNames.Add("Gabriel");
            self._titanNames.Add("Bethanie");
            self._titanNames.Add("Olga");
            self._titanNames.Add("Gaping Anus");
            self._titanNames.Add("Sheryl");
            self._titanNames.Add("Succulent Chinese Meal");
            self._titanNames.Add("Nigel");
            self._titanNames.Add("Gertrude");
            self._titanNames.Add("Bel");  
            self._titanNames.Add("Blathers");
            self._titanNames.Add("Robyn");
            self._titanNames.Add("Clar3inet");
            self._titanNames.Add("Lukey");
            self._titanNames.Add("Carlaaa");
            self._titanNames.Add("Envy");
            self._titanNames.Add("Cherry");
            self._titanNames.Add("Chupo");
            self._titanNames.Add("Mythos");    
            self._titanNames.Add("Fabel");
            self._titanNames.Add("KittyKat");
            self._titanNames.Add("Nubi");
            self._titanNames.Add("Muti");
            self._titanNames.Add("Chez");
            self._titanNames.Add("Miguel");
            self._titanNames.Add("Misfit");
            self._titanNames.Add("Rai");
            self._titanNames.Add("Crab");
            self._titanNames.Add("Sigil");
            self._titanNames.Add("Tadex");
            self._titanNames.Add("Vivi");
            self._titanNames.Add("Xenny");  
            self._titanNames.Add("Pudding");    
            self._titanNames.Add("Spunk"); 
            self._titanNames.Add("Smegmoid");      
            self._titanNames.Add("idiot");
            self._titanNames.Add("Foreskin"); 
            self._titanNames.Add("Mythos' Gay Cousin");
            self._titanNames.Add("Envy's Ego");
            self._titanNames.Add("Cami's Freak"); 
            self._titanNames.Add("Bykhovsky"); 
            self._titanNames.Add("Clare");         
            self._titanNames.Add("BloodTomb"); 
            self._titanNames.Add("Tel Aviv");
            self._titanNames.Add("Benjamin Netanyahu");
            self._titanNames.Add("Chud");
            self._titanNames.Add("Baka");
            self._titanNames.Add("The Feminist Movement");
            self._titanNames.Add("Chud");
            self._titanNames.Add("Vurucu");
            self._titanNames.Add("Nipple");
            self._titanNames.Add("Adolf");
            self._titanNames.Add("Pim Enemy");
            self._titanNames.Add("Smoliv Hunter");
            self._titanNames.Add("Squimshbot Hacker");
            self._titanNames.Add("Elbow Juice");
            self._titanNames.Add("Hours that Muti is AFK");
            self._titanNames.Add("7s");
            self._titanNames.Add("Scythe");
            self._titanNames.Add("mr wide mouth");
            self._titanNames.Add("KC's Monster Collection");
            self._titanNames.Add("Hopes & Dreams");
            self._titanNames.Add("CJ");
            self._titanNames.Add("Markiplier");
        }
    
    #----------ON PLAYER JOIN----------#
        function OnPlayerJoin(player)
        {
            BodySizeManager.OnPlayerJoin(player);
        }

        function OnPlayerLeave(player)
        {
            ServerID.RemovePlayerFromStorage(player);
            Race.OnPlayerLeave(player);
            DmgRace.OnPlayerLeave(player);
            CageFight.OnPlayerLeave(player);
        }
    #----------ON PLAYER SPAWN----------#
        function OnPlayerSpawn(player, character)
        {
            CFMatchmaking.OnPlayerSpawn(player, character);
            if (character.IsMainCharacter)
            {
                Input.SetKeyDefaultEnabled(InputHumanEnum.AttackDefault, true);
            }
            
        }
    #----------ON CHARACTER SPAWN----------#
        function OnCharacterSpawn(character)
        {
            CageFight.OnCharacterSpawn(character);
            
            if (character.IsMine && character.Type == "Titan")
            {
                if (!self.enableNames) {return;}
                titan = character;
                titan.Name = self._titanNames.Get(0);
                self._titanNames.RemoveAt(0);

                if (self._titanNames.Count <= 0)
                {
                    self.AddNamesToList();
                    self.RandomizeNames();
                }
            }
        }

        function RandomizeNames()
        {
            for(i in Range(self._titanNames.Count - 1, 0, -1))
            {
                j = Random.RandomInt(0, i + 1);
                temp = self._titanNames.Get(i);
                self._titanNames.Set(i, self._titanNames.Get(j));
                self._titanNames.Set(j, temp);
            }
        }

    ##----------ON SECOND----------#
        _fireDamage = false;
        function OnSecond()
        {   
            ServerID.DelaySIDSendOnSec();
            Race.OnSecond();
            DmgRace.OnSecond();
            CageFight.OnSecond();
            

            if (self._fireDamage && Network.MyPlayer.Character != null)
            {
                Network.MyPlayer.Character.GetDamaged("Fire", 2);
            }
        }
            
    #------------ON TICK----------#
        function OnTick()
        {
            player = Network.MyPlayer;
            char = Network.MyPlayer.Character;
            HandleBakery.OnTick();

            #ENDLESS MODE#
            if (self.endlessEnabled)
            {
                    self._dieTimeLeft = self._dieTimeLeft - Time.TickTime;
                    if (Network.MyPlayer.Status == "Dead" && self._dieTimeLeft <= 0.0)
                    {
                        Game.SpawnPlayer(Network.MyPlayer, false);
                    }
                    if (Network.IsMasterClient)
                    {
                        if (CageFight._enabled) {
                            titans = Game.Titans.Count + 10;
                        }
                        elif (CageFight._matchPlayed)
                        {
                            titans = Game.Titans.Count - 10;
                        }
                        else
                        {
                            titans = Game.Titans.Count;
                        }
                        if (titans < self.MaxTitans)
                        {
                            self._spawnTimeLeft = self._spawnTimeLeft - Time.TickTime;
                            if (self._spawnTimeLeft <= 0.0)
                            {
                                Game.SpawnTitans("Default", 1);
                                self._spawnTimeLeft = self.TitanSpawnEvery;
                            }
                        }
                        else
                        {
                            self._spawnTimeLeft = self.TitanSpawnEvery;
                        }
                        if (CageFight._enabled){return;}
                        UI.SetLabelAll("TopCenter", "Titans: " + Convert.ToString(titans));
                    }
            }

            #WAVES DEFAULT

            if (self.wavesEnabled)
            {
                if (Network.IsMasterClient && !Game.IsEnding)
                {
                    titan = Game.Titans;
                    titans = Game.Titans.Count;
                    humans = Game.Humans.Count;
                    playerShifters = Game.PlayerShifters.Count;
                    if (humans > 0 || playerShifters > 0)
                    {
                        self._hasSpawned = true;
                    }
                    if (titans == 0)
                    {
                        self.NextWave();
                    }
                    if (humans == 0 && playerShifters == 0 && self._hasSpawned)
                    {
                        UI.SetLabelAll("MiddleCenter", "u lost shithead");
                        Game.End(10.0);
                        return;
                    }
                    if (CageFight._enabled) {return;}
                    UI.SetLabelAll("TopCenter", "Titans Left: " + Convert.ToString(titans) + "  " + "Wave: " + Convert.ToString(self._currentWave));
                }   
            }
        }
    #----------DEFAULT WAVES FUNCTION----------#
        function NextWave()
        {
            self._currentWave = self._currentWave + 1;
            if (self._currentWave > self.MaxWaves)
            {
                UI.SetLabelAll("MiddleCenter", "All waves cleared, good job pros!");
                Game.End(10.0);
                return;
            }
            amount = self.AddTitansPerWave * (self._currentWave - 1) + self.StartTitans;
            type = "Default";
            if (self.GradualSpawn)
            {
                Game.SpawnTitansAsync(type, amount);
            }
            else
            {
                Game.SpawnTitans(type, amount);
            }
            if (self.RespawnOnWave)
            {
                Game.SpawnPlayerAll(false);
            }
        }
    #----------ON CHARACTER RELOADED----------#
        function OnCharacterReloaded(character)
        {

        }

        function PokerGuide()
        {
            nl = String.Newline;
            UI.CreatePopup("PokerGuide", "Texas Hold'em Poker Guide", 700, 800);
            UI.ClearPopup("PokerGuide");

            text = "Hey there! This is my guide to Texas Hold'em Poker!" + nl + nl;
            text += ;
        }

    #----------CHECK INPUTS----------#
        function CheckInputs()
        {
            myPlayer = Network.MyPlayer;
            character = Network.MyPlayer.Character;
            func3Pressed = Input.GetKeyDown(InputInteractionEnum.Function3);

            if (func3Pressed)
            {
                self.BreakBlades();
            }
            elif (Input.GetKeyDown(InputTitanEnum.Sit))
            {
                #self.PokerGuide();
                #UI.ShowPopup("PokerGuide");
            }

            if (Input.GetKeyDown("Interaction/QuickSelect7"))
            {
                if (character != null && character.Type == "Human")
                {
                    current = character.CurrentSpecial;

                    ####### Toggle Carry on/off
                    if (current != "Carry")
                    {
                        # Save what you actually had (not the cached self._currentSpecial, which can be stale and become "Escape").
                        self._savedSpecial = current;
                        self._currentSpecial = "Carry";
                    }
                    else
                    {
                        # Restore the saved special (fallback to Escape only if nothing was saved)
                        if (self._savedSpecial != null && self._savedSpecial != "")
                        {
                            self._currentSpecial = self._savedSpecial;
                        }
                        else
                        {
                            self._currentSpecial = "Escape";
                        }
                    }

                    character.SetSpecial(self._currentSpecial);
                }
            }

            if (Input.GetKeyDown(InputInteractionEnum.Function2))
            {
                UI.ClearPopup("Leaderboard");
                UI.ShowPopup("Leaderboard");
                Network.SendMessage(Network.MasterClient, "SyncBoard");
            }
            
        }
    #----------BREAK BLADES----------#

        coroutine BreakBlades()
        {
            character = Network.MyPlayer.Character;

            if (character != null && character.Type == "Human")
            {
                if (character.CurrentBladeDurability > 0)
                {
                    character.ForceAnimation(HumanAnimationEnum.ChangeBlade, 3);
                    wait 0.71;
                    character.CurrentBladeDurability = 0;
                    character.CurrentBlade += 1;  
                }
                
            }

        }
    #----------ON FRAME----------#
        function OnFrame()
        {
            player = Network.MyPlayer;
            character = Network.MyPlayer.Character;
            HandleBakery.OnFrame();
            
            self.CheckInputs();        
            
            changeCharacterPressed = Input.GetKeyDown(InputGeneralEnum.ChangeCharacter);
            if (changeCharacterPressed && character != null && player.Deaths >= 1)
            {
                player.Deaths -= 1;
            }

            if (!self._enabled)
            {
                return;
            }

            moveSpeed = self.MoveSpeed;
            lookSpeed = self.LookSpeed;
            holdingSpeedModifier = Input.GetKeyHold("MapEditor/Fast") || Input.GetKeyHold("MapEditor/Slow");

            if (holdingSpeedModifier)
            {
                moveSpeed = self.FastMoveSpeed;
                lookSpeed = self.FastLookSpeed;
            }

            xInput = self.GetAxisFromKeys("MapEditor/Right", "MapEditor/Left") * moveSpeed * Time.FrameTime;
            yInput = self.GetAxisFromKeys("MapEditor/Up", "MapEditor/Down") * moveSpeed * Time.FrameTime;
            zInput = self.GetAxisFromKeys("MapEditor/Forward", "MapEditor/Back") * moveSpeed * Time.FrameTime;
            mouseX = Input.GetMouseSpeed().X;
            mouseY = Input.GetMouseSpeed().Y;

            forward = Camera.Forward;
            up = Camera.Up;
            right = Camera.Right;

            targetPos = Vector3(self._xTargetCameraPos, self._yTargetCameraPos, self._zTargetCameraPos);
            targetPos += forward * zInput + up * yInput + right * xInput;

            self._xTargetCameraPos = targetPos.X;
            self._yTargetCameraPos = targetPos.Y;
            self._zTargetCameraPos = targetPos.Z;

            self._xTargetCameraRot -= mouseY * lookSpeed * Time.FrameTime;
            self._yTargetCameraRot += mouseX * lookSpeed * Time.FrameTime;

            self._xTargetCameraRot = Math.Clamp(self._xTargetCameraRot, -85, 85);

            self._xCameraPos = Math.Lerp(self._xCameraPos, self._xTargetCameraPos, self.MoveSmoothSpeed * Time.FrameTime);
            self._yCameraPos = Math.Lerp(self._yCameraPos, self._yTargetCameraPos, self.MoveSmoothSpeed * Time.FrameTime);
            self._zCameraPos = Math.Lerp(self._zCameraPos, self._zTargetCameraPos, self.MoveSmoothSpeed * Time.FrameTime);

            self._xCameraRot = Math.Lerp(self._xCameraRot, self._xTargetCameraRot, self.LookSmoothSpeed * Time.FrameTime);
            self._yCameraRot = Math.Lerp(self._yCameraRot, self._yTargetCameraRot, self.LookSmoothSpeed * Time.FrameTime);

            Camera.SetRotation(Vector3(self._xCameraRot, self._yCameraRot, 0));
            Camera.SetPosition(Vector3(self._xCameraPos, self._yCameraPos, self._zCameraPos));

        }
    #----------FREE CAM FUNCTIONS----------#
        function Toggle()
        {
            self.SetEnabled(!self._enabled);
        }

        function SetEnabled(enabled)
        {
            if (self._enabled == enabled)
            {
                return;
            }

            self._enabled = enabled;
            self.SetPlayerInputEnabled(!self._enabled);

            if (self._enabled)
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

            Camera.SetManual(self._enabled);
        }

        function GetAxisFromKeys(positive, negative)
        {
            if (Input.GetKeyHold(positive))
            {
                return 1.0;
            }
            elif (Input.GetKeyHold(negative))
            {
                return -1.0;
            }

            return 0.0;
        }

        function SetPlayerInputEnabled(enabled)
        {
            inputs = List();

            inputs.Add("General/Forward");
            inputs.Add("General/Back");
            inputs.Add("General/Left");
            inputs.Add("General/Right");
            inputs.Add("General/Up");
            inputs.Add("General/Down");
            inputs.Add("General/Autorun");
            inputs.Add("General/ChangeCharacter");

            inputs.Add("Human/AttackDefault");
            inputs.Add("Human/AttackSpecial");
            inputs.Add("Human/HookLeft");
            inputs.Add("Human/HookRight");
            inputs.Add("Human/HookBoth");
            inputs.Add("Human/Dash");
            inputs.Add("Human/ReelIn");
            inputs.Add("Human/ReelOut");
            inputs.Add("Human/Dodge");
            inputs.Add("Human/Jump");
            inputs.Add("Human/Reload");
            inputs.Add("Human/HorseMount");
            inputs.Add("Human/HorseWalk");
            inputs.Add("Human/HorseJump");
            inputs.Add("Human/NapeLock");

            inputs.Add("AnnieShifter/Kick");
            inputs.Add("AnnieShifter/Jump");
            inputs.Add("AnnieShifter/Walk");
            inputs.Add("AnnieShifter/AttackCombo");
            inputs.Add("AnnieShifter/AttackSwing");
            inputs.Add("AnnieShifter/AttackStomp");
            inputs.Add("AnnieShifter/AttackBite");
            inputs.Add("AnnieShifter/AttackHead");
            inputs.Add("AnnieShifter/AttackBrushBack");
            inputs.Add("AnnieShifter/AttackBrushFront");
            inputs.Add("AnnieShifter/AttackBrushHead");
            inputs.Add("AnnieShifter/AttackGrabBottom");
            inputs.Add("AnnieShifter/AttackGrabMid");
            inputs.Add("AnnieShifter/AttackGrabUp");

            inputs.Add("ErenShifter/Kick");
            inputs.Add("ErenShifter/Jump");
            inputs.Add("ErenShifter/Walk");
            inputs.Add("ErenShifter/AttackCombo");

            inputs.Add("Titan/Kick");
            inputs.Add("Titan/Jump");
            inputs.Add("Titan/Sit");
            inputs.Add("Titan/Walk");
            inputs.Add("Titan/Sprint");
            inputs.Add("Titan/CoverNape");
            inputs.Add("Titan/AttackPunch");
            inputs.Add("Titan/AttackBellyFlop");
            inputs.Add("Titan/AttackSlapL");
            inputs.Add("Titan/AttackSlapR");
            inputs.Add("Titan/AttackRockThrow");
            inputs.Add("Titan/AttackBiteL");
            inputs.Add("Titan/AttackBiteF");
            inputs.Add("Titan/AttackBiteR");
            inputs.Add("Titan/AttackHitFace");
            inputs.Add("Titan/AttackHitBack");
            inputs.Add("Titan/AttackSlam");
            inputs.Add("Titan/AttackStomp");
            inputs.Add("Titan/AttackSwing");
            inputs.Add("Titan/AttackGrabAirFar");
            inputs.Add("Titan/AttackGrabAir");
            inputs.Add("Titan/AttackGrabBody");
            inputs.Add("Titan/AttackGrabCore");
            inputs.Add("Titan/AttackGrabGround");
            inputs.Add("Titan/AttackGrabHead");
            inputs.Add("Titan/AttackGrabHigh");
            inputs.Add("Titan/AttackSlapHighL");
            inputs.Add("Titan/AttackSlapHighR");
            inputs.Add("Titan/AttackSlapLowL");
            inputs.Add("Titan/AttackSlapLowR");
            inputs.Add("Titan/AttackBrushChest");

            for(i in inputs)
            {
                Input.SetKeyDefaultEnabled(i, enabled);
            }
        }

        function OnCharacterDie(victim, killer, killerName)
        {
            Race.OnCharacterDie(victim, killer, killerName);
            CageFight.OnCharacterDie(victim, killer, killerName);
            if (Network.IsMasterClient && killerName == "") 
            {
                killerName = UI.WrapStyleTag("GAY FORCE", "color", "Red");
                Game.ShowKillFeedAll(killerName, victim.Name, 1000, "Blade");
            }  

            if (victim.Type == "Human" && victim.IsMainCharacter)
            {
                self._deathCounter += 1;
                Input.SetKeyDefaultEnabled(InputGeneralEnum.ChangeCharacter, true);
            }
        }
        _killCounter = 0;
        _TDCounter = 0;
        _deathCounter = 0;
    #----------ON CHARACTER DAMAGED-----------#
        function OnCharacterDamaged(victim, killer, killerName, damage)
        {   
            player = Network.MyPlayer;
            char = Network.MyPlayer.Character;
            nl = String.Newline;

            DmgRace.OnCharacterDamaged(victim, killer, killerName, damage);

            if (victim.Type == "Human")
            {
                if (victim != null && victim.IsMine)
                {
                    Game.SpawnEffect(EffectNameEnum.Blood1, victim.Position, Vector3.Zero , 4);
                    victim.PlaySound("CrashLand");
                }
            }
            elif (victim.Type == "Titan" && victim.Health <= 0 && killer.IsMainCharacter && killer.Type == "Human")
            {
                self._killCounter += 1;
                self._TDCounter += damage;

                if (self._killCounter >= 5) {
                    kills = self._killCounter;
                    deaths = self._deathCounter;
                    HD = killer.Player.HighestDamage;
                    TD = self._TDCounter;
                    Network.SendMessage(Network.MasterClient, "SaveMyKD|" + kills + "|" + deaths + "|" + HD + "|" + TD);
                    #Game.Print("Stats Saved");
                    self._killCounter = 0;
                    self._deathCounter = 0;
                    self._TDCounter = 0;
                }
            } 

        }
    #-----------ON BUTTON CLICK----------#
        function OnButtonClick(button)
        {
            
        }
    #----------ON CHAT INPUT----------#
        coroutine DieDelete()
        {
            wait 3;
            for (obj in self.dieList)
            {
                Map.DestroyMapObject(obj, true);
                self.dieList.Remove(obj);
            }
        }
        # @type MapObject
        _dieObj = Prefab("Scene,Geometry/Capsule1,6056,0,1,0,0,0,Capsule1,0,0,0,0,0,0,1,1,1,Physical,Entities,Default,Default|255/255/255/255,Rigidbody|Mass:1|Gravity:0/-40/0|FreezeRotation:false|Interpolate:false", false);
        # @type List
        dieList = List();
        function OnChatInput(message)
        {
            args = String.Split(message, " ", true);
            ServerID.HandleServerIDCommands(args);
            command = args.Get(0);
            char = Network.MyPlayer.Character;
            myPlayer = Network.MyPlayer;

            if (Network.IsMasterClient)
            {
                if (command == "/kill" && Network.IsMasterClient)
                {
                    for (titan in Game.Titans)
                    {
                        titan.GetKilled("KITTYFORCE");
                    }
                    return false;
                }
                elif(command == "/refill") 
                {
                    me = Network.MyPlayer.Character;
                    if(me == null) { return false; }
                    me.CurrentGas = me.MaxGas;
                    return false;
                }
                elif(command == "/skip") 
                {
                    targetWave = Convert.ToInt(args.Get(1));

                    self._currentWave = targetWave - 1;
                    self.NextWave();
                    return false;
                }
                elif (command == "/effect" && args.Count == 3)
                {
                    one = Convert.ToString(args.Get(1));
                    two = Convert.ToFloat(args.Get(2));

                    Game.SpawnEffect(one, Vector3(char.Position.X,char.Position.Y,char.Position.Z), Vector3.Zero, two);
                    return false;
                }
                elif (command == "/endless")
                {
                    self.endlessEnabled = true;
                    self.wavesEnabled = false;
                    return false;
                }
                elif (command == "/waves")
                {
                    self.endlessEnabled = false;
                    self.wavesEnabled = true;
                    return false;
                }
                elif (command == "/kd" && args.Count == 4)
                {
                    id = Convert.ToInt(args.Get(1));

                    for (player in Network.Players)
                    {
                        if (player.ID == id)
                        {
                            player.Kills = Convert.ToInt(args.Get(2));
                            player.Deaths = Convert.ToInt(args.Get(3));
                        }
                        
                    }
                    return false;
                }
            }  
            
            if  (command == "/tkick")
            {
                return false;
            } 
            elif (command == "/pban")
            {
                return false;
            }
            elif (command == "/auth")
            {
                return false;
            }
            
            elif (command == "/particle" && args.Count == 2 && char.Type == "Human")
            {
                one = Convert.ToString(args.Get(1));

                char.SetParticleEffect(one, true);
                return false;
            }

            elif (command == "/pdisable" && args.Count == 2 && char.Type == "Human")
            {
                one = Convert.ToString(args.Get(1));

                char.SetParticleEffect(one, false);
                return false;
            }

            elif (command == "/save")
            {
                money = self.Coins;
                Network.SendMessage(Network.MasterClient,"SaveMoney|" + money);
                return false;
            }
        }

        function GiveCommand(cmd,args)
        {
            pID = Convert.ToInt(args.Get(0));
            amount = Convert.ToInt(args.Get(1));

            player = Network.FindPlayer(pID);
            if (Main.Coins < amount) {Game.Print("You dont have that many coins."); return;}
            Network.SendMessage(player, "GivenMoney|" + amount);
            Main.Coins -= amount;
            Game.Print("Gave " + player.Name + " " + amount + " coins");
        }

        function CommandsCommand()
        {
            nl = String.Newline;
            text = "Type /passive to enter/leave passive mode" + nl + nl;
            text += "Type /csize <sizeX> <sizeY> <sizeZ> to change character size" + nl +nl;
            text += "Type /die to ragdoll and /recover to get out of it" + nl + nl;
            text += "Type /cam to use freecam" + nl +nl;
            text += "Type /particle <particle name> to enable a particle effect" + nl + nl;
            text += "Available particles = Buff1, Buff2, Fire1. /pdisable <particle> to disable particle effect" + nl + nl;
            text += "Type /give to give money" + nl + nl;
            text += "Type /startrace to start a kill race" + nl + nl;
            
            Game.Print(text);
        }

        function CamCommand()
        {
            self.Toggle();
        }

        function RecoverCommand()
        {
            char = Network.MyPlayer.Character;
            char.Unmount(true);
            self.DieDelete();
        }

        function DieCommand()
        {
            char = Network.MyPlayer.Character;
            pos = Vector3(char.Position.X, char.Position.Y, char.Position.Z);
            rot = Vector3(char.Rotation.X, char.Rotation.Y, char.Rotation.Z);

            obj = Map.CreateMapObject(self._dieObj, pos, rot, Vector3(1,1,1));
            self.dieList.Add(obj);
            obj.AddSphereCollider("Physical", "All", Vector3.Zero, 0.5);
            char.MountMapObject(obj, Vector3(0, -1, 0), Vector3.Zero);
            obj.Rigidbody.AddForce(Vector3(0,0,5), ForceModeEnum.Impulse);
            obj.Rigidbody.AddTorque(Vector3(0,0,8), ForceModeEnum.Impulse);
        }

        function PassiveCommand()
        {
            char = Network.MyPlayer.Character;
            if (char == null) {return;}
            if (self._passiveOn)
            {
                char.Team = TeamEnum.Human;
                Game.SpawnPlayerAt(Network.MyPlayer, true, char.Position);
                Network.MyPlayer.Deaths -= 1;
                self._passiveOn = false;
                Game.Print("Passive Mode Off");
            }
            elif (!self._passiveOn)
            {
                char.Team = TeamEnum.Blue;
                self._passiveOn = true;
                Game.Print("Passive Mode On"); 
            }
        }

        function SuckMe(id)
        {
            player = Network.FindPlayer(id);
            char = player.Character;
            trans = char.Transform.GetTransform("Armature/Core/Controller_Body/hip/spine/chest/neck/head");
            if (trans == null) {Game.Print("Transform null");return;}
            position = trans.Position;
            rotation = trans.Forward;

            self._pimHead = Map.CreateMapObject(self._pimPrefab, position, rotation, Vector3(0.38,0.38,0.38));
            self._pimHead.Parent = trans;
        }

    #----------ON NETWORK MESSAGE----------#
        function OnNetworkMessage(sender, message)
        {   
            args = String.Split(message, "|");
            rpc = args.Get(0);
 
            BodySizeManager.OnNetworkMessage(sender, message);
            Leaderboard.OnNetworkMessage(sender, message, args);
            ServerID.HandleServerIDRpcs(sender, args);
            CmdsNetworking.OnNetworkMessage(sender, message, args);
            Race.OnNetworkMessage(sender, message, args);
            CardTrading.OnNetworkMessage(sender, message, args);
            HandleBakery.OnNetworkMessage(sender, message, args);
            DmgRace.OnNetworkMessage(sender,message,args);
            CFMatchmaking.OnNetworkMessage(sender, message, args);
            TVController.OnNetworkMessage(sender, message, args);
            #@type Human
            myCharacter = Network.MyPlayer.Character;
            myPlayer = Network.MyPlayer;
 
            if (rpc == "PlusCoins")
            {
                amt = args.Get(1);
 
                Main.Coins += Convert.ToInt(amt);
            }
            if (rpc == "MinusCoins")
            {
                amt = args.Get(1);
 
                if (amt == "all") {Main.Coins = 0; return;}
                Main.Coins -= Convert.ToInt(amt);
            }

            if (rpc == "YourGachaData")
            {
                data = Json.LoadFromString(args.Get(1));

                GachaData.LoadItemToInv(data);
            }
 
            if (rpc == "YourSavings")
            {
                chedda = Convert.ToInt(args.Get(1));
 
                self._savings = chedda;
            }
            
            if (rpc == "GivenMoney")
            {
                amount = Convert.ToInt(args.Get(1));

                Main.Coins += amount;
                Game.Print(sender.Name + " has given you " + amount + " coins");
            }
            elif (rpc == "SendToTheGallows")
            {
                obj = self._guillotineMount;

                myCharacter.MountMapObject(obj, Vector3.Zero, Vector3.Zero, false);
                Input.SetKeyDefaultEnabled(InputGeneralEnum.ChangeCharacter, false);
                Game.PrintAll(Network.MyPlayer.Name + " HAS BEEN SENT TO THE GUILLOTINE");
            }
            elif (rpc == "NukeME")
            {
                self.SpawnFX();
            }
            elif (rpc == "SuckPlayer")
            {
                id = Convert.ToInt(args.Get(1));

                self.SuckMe(id);
            }
 
            if(!Network.IsMasterClient) { return; }
 
            senderServerID = ServerID._playerServerIDs.Get(sender.ID);
            if(senderServerID == null || senderServerID == "" || String.Length(senderServerID) < 32) { Game.Debug("ID Null"); return; }
            #@type Dict
            playerData = MoneyData.LoadPlayerData(senderServerID);
 

            if (rpc == "SaveMoney")
            {
                money = Convert.ToInt(args.Get(1));
 
                MoneyData.SaveMoney(money, senderServerID);
            }
            elif (rpc == "SaveItem")
            {
                itemName = args.Get(1);

                GachaData.SaveItem(itemName, senderServerID);
            }
            elif (rpc == "SaveMyKD")
            {
                kills = Convert.ToInt(args.Get(1));
                deaths = Convert.ToInt(args.Get(2));
                HD = Convert.ToInt(args.Get(3));
                TD = Convert.ToInt(args.Get(4));

                KDData.Save(kills, deaths, HD, TD, senderServerID); 
            }
            elif (rpc == "GetMyKD")
            {
                playerData = KDData.LoadPlayerData(senderServerID);
                kills = Convert.ToInt(playerData.Get("Kills"));
                deaths = Convert.ToInt(playerData.Get("Deaths"));
                highestDmg = Convert.ToInt(playerData.Get("HighestDmg"));
                totalDmg = Convert.ToInt(playerData.Get("TotalDmg"));

                sender.Kills = kills;
                sender.Deaths = deaths;
                sender.HighestDamage = highestDmg;
                sender.TotalDamage = totalDmg;
            }
            elif (rpc == "LoadMyGacha")
            {
                id = Convert.ToInt(args.Get(1));
                Game.Print("Recieved " + id);
                GachaData.LoadMyData(id);
            }
        }
}
##==========EXTENSIONS==========##
extension TVController
{
    #@type VideoPlayer
    _CapyVP = null;
    _CapyBaras = null;
    #@type VideoPlayer
    _SpongeVP = null;
    _Sponge = null;

    _colliding = false;

    function Init()
    {
        self._CapyBaras = Map.FindMapObjectByName("capybaras");
        self._CapyVP = Map.FindMapObjectByName("capybaras").GetUnityComponent("VideoPlayer");
        self._Sponge = Map.FindMapObjectByName("spongebob");
        self._SpongeVP = Map.FindMapObjectByName("spongebob").GetUnityComponent("VideoPlayer");

        Commands.RegisterCommand("play1",self.Play1, "/play1");
        Commands.RegisterCommand("play2",self.Play2, "/play2");
        Commands.RegisterCommand("nextep",self.NextSPEp, "/play2");
    }

    function Play1()
    {
        if (!self._colliding) {return;}
        if (self._Sponge.Active) {
            self._Sponge.Active = false;
        }
        if (!self._CapyBaras.Active) {
            self._CapyBaras.Active = true;
        }
        #self._CapyVP.Play();
    }

    function Play2()
    {
        if (!self._colliding) {return;}
        if (self._CapyBaras.Active) {
            self._CapyBaras.Active = false;
        }
        if (!self._Sponge.Active) {
            self._Sponge.Active = true;
        }
    }

    function NextSPEp()
    {
        if (self._Sponge.Active)
        {
            self._SpongeVP.Time += 1200.0;
        }
        
    }

    function OnNetworkMessage(sender,message,args)
    {
        rpc = args.Get(0);

        if (rpc == "NearTV")
        {
            self._colliding = true;
        }
        elif (rpc == "OffTV")
        {
            self._colliding = false;
        }
    }
}
extension CageFight
{
    StartTitans = 5;
    StartTitansTooltip = "The amount of titans in each cage.";

    _redTitans = List();
    _blueTitans = List();

    _enabled = false;
    _matchPlayed = false;
    _gameEnded = false;
    _titanSpawnPointsA = null;
    _titanSpawnPointsB = null;
    _round = 0;
    _winner = null;

    _p1Score = 0;
    _p2Score = 0;

    function CFInit()
    {
        if (Network.IsMasterClient)
        {
            self._enabled = true;
            self._matchPlayed = true;
            self._titanSpawnPointsA = Map.FindMapObjectsByName("Titan A");
            self._titanSpawnPointsB = Map.FindMapObjectsByName("Titan B");

            if (self._titanSpawnPointsA.Count <= 0 || self._titanSpawnPointsB.Count <= 0)
            {
                Game.Print("<b><color=#f75348>[Error]: </color></b>Missing Titan spawn points. Are you on a cage fight map?");
                self._enabled = false;
                return;
            }

            self.ClearTitans();
            self.SpawnTitans(self._redTitans, self._titanSpawnPointsA);
            self.SpawnTitans(self._blueTitans, self._titanSpawnPointsB);

            UI.SetLabelAll(UILabelEnum.TopCenter, self.GetRemainingTitansLabel());
            CFMatchmaking._killZone.Active = false;
            self._round = 1;
        }
    }

    coroutine CageFightRND2()
    {
        wait 2;
        self.SpawnTitans(self._redTitans, self._titanSpawnPointsA);
        self.SpawnTitans(self._blueTitans, self._titanSpawnPointsB);

        UI.SetLabelAll(UILabelEnum.TopCenter, self.GetRemainingTitansLabel());
        self._round = 2;
    }

    coroutine CageFightRND3()
    {
        wait 2;
        self.SpawnTitans(self._redTitans, self._titanSpawnPointsA);
        self.SpawnTitans(self._blueTitans, self._titanSpawnPointsB);

        UI.SetLabelAll(UILabelEnum.TopCenter, self.GetRemainingTitansLabel());
        self._round = 3;
    }
    
    function OnCharacterSpawn(character)
    {
        if (self._enabled)
        {
            if (character.Type == "Titan" && self._redTitans.Contains(character))
            {
                character.Team = "Blue";
            }
            elif (character.Type == "Titan" && self._blueTitans.Contains(character))
            {
                character.Team = "Red";
            }
        }
    }

    function OnCharacterDie(victim, killer, killerName)
    {
        if (self._enabled && Network.IsMasterClient)
        {
            if (victim.Type == "Titan")
            {
                if (killer == null) {return;}
                if (killer.Team == TeamEnum.Red)
                {
                    self._redTitans.Remove(victim);
                    self.SpawnTitan(self._blueTitans, self._titanSpawnPointsB);
                    self.CheckIfTitansAreDead();
                }
                elif (killer.Team == TeamEnum.Blue)
                {
                    self._blueTitans.Remove(victim);
                    self.SpawnTitan(self._redTitans, self._titanSpawnPointsA);
                    self.CheckIfTitansAreDead();
                }

                UI.SetLabelAll(UILabelEnum.TopCenter, self.GetRemainingTitansLabel());
            }
            /*elif (victim.Type == "Human")
            {
                self.CheckIfTeamPlayersAreDead();
            }*/
        }
    }

    function OnPlayerLeave(player)
    {
        if (self._enabled && Network.IsMasterClient && CFMatchmaking._activePlayers.Contains(player))
        {
            CFMatchmaking.EndMatch();
        }
    }

    function OnSecond()
    {
        if (!self._enabled || !Network.IsMasterClient || self._gameEnded)
        {
            return;
        }

        redPlayers = self.GetPlayersOfTeam(TeamEnum.Red);
        bluePlayers = self.GetPlayersOfTeam(TeamEnum.Blue);

        for(bt in self._blueTitans)
        {
            if (bt != null)
            {
                target = self.GetNearestPlayer(bluePlayers, bt.Position);
                if (target != null)
                {
                    bt.Target(target, Math.Infinity);
                }
            }
        }

        for(rt in self._redTitans)
        {
            if (rt != null)
            {
                target = self.GetNearestPlayer(redPlayers, rt.Position);
                if (target != null)
                {
                    rt.Target(target, Math.Infinity);
                }
            }
        }
    }

    function CheckWinner()
    {
        if (self._p1Score > self._p2Score)
        {
            self._winner = CFMatchmaking._player1;
            Game.PrintAll(self._winner.Name + " HAS WON THE MATCH!!");
            CFMatchmaking.EndMatch();
            self.ClearTitans();
            return;
        }
        elif (self._p1Score < self._p2Score)
        {
            self._winner = CFMatchmaking._player2;
            Game.PrintAll(self._winner.Name + " HAS WON THE MATCH!!");
            CFMatchmaking.EndMatch();
            self.ClearTitans();
            return;
        }
    }

    function CheckIfTitansAreDead()
    {
        if (self._round == 1)
        {
            if (self._redTitans.Count <= 0)
            {
                Game.PrintAll(CFMatchmaking._player1.Name + " HAS WON ROUND 1!");
                self._round += 1;
                self._p1Score += 1;
                self.ClearTitans();
                Network.SendMessage(Network.MasterClient, "StartRound2CF");
                return;
            }
            elif (self._blueTitans.Count <= 0)
            {
                Game.PrintAll(CFMatchmaking._player2.Name + " HAS WON ROUND 1!");
                self._round += 1;
                self._p2Score += 1;
                self.ClearTitans();
                Network.SendMessage(Network.MasterClient, "StartRound2CF");
                return;
            }
        }
        elif (self._round == 2)
        {
            if (self._redTitans.Count <= 0)
            {
                Game.PrintAll(CFMatchmaking._player1.Name + " HAS WON ROUND 2!");
                CFMatchmaking._round += 1;
                self._round += 1;
                self._p1Score += 1;
                self.ClearTitans();
                self.CheckWinner();
                Network.SendMessage(Network.MasterClient, "StartRound3CF");    
            }
            elif (self._blueTitans.Count <= 0)
            {
                Game.PrintAll(CFMatchmaking._player2.Name + " HAS WON ROUND 2!");
                CFMatchmaking._round += 1;
                self._round += 1;
                self._p2Score += 1;
                self.ClearTitans();
                self.CheckWinner();
                Network.SendMessage(Network.MasterClient, "StartRound3CF");
            }
            
        }
        elif (self._round == 3)
        {
            if (self._redTitans.Count <= 0)
            {
                Game.PrintAll(CFMatchmaking._player1.Name + " HAS WON ROUND 3!");
                CFMatchmaking._round += 1;
                self._p1Score += 1;
                self._round += 1;
                self.CheckWinner();
            }
            elif (self._blueTitans.Count <= 0)
            {
                Game.PrintAll(CFMatchmaking._player2.Name + " HAS WON ROUND 3!");
                CFMatchmaking._round += 1;
                self._p2Score += 1;
                self._round += 1;
                self.CheckWinner();
            }
            
        }
    }

    function SpawnTitan(list, spawnPoints)
    {
        position = self.GetRandomListElement(spawnPoints).Position;
        titan = self.SpawnTitanAt(position);
        list.Add(titan);
    }

    function SpawnTitans(list, spawnPoints)
    {
        if (spawnPoints.Count <= 0)
        {
            return;
        }
        randomSpawnPoint = false;
        if (self.StartTitans > spawnPoints.Count)
        {
            randomSpawnPoint = true;
        }

        for(i in Range(0, self.StartTitans, 1))
        {
            position = Vector3.Zero;
            if (randomSpawnPoint)
            {
                position = self.GetRandomListElement(spawnPoints).Position;
            }
            else
            {
                position = spawnPoints.Get(i).Position;
            }

            titan = self.SpawnTitanAt(position);
            list.Add(titan);
        }
    }

    function SpawnTitanAt(position)
    {
        titan = Game.SpawnTitanAt(TitanTypeEnum.Default, position);
        titan.DetectRange = 800;
        return titan;
    }

    function GetPlayersOfTeam(team)
    {
        players = List();
        for(p in Network.Players)
        {
            if (p.Status == PlayerStatusEnum.Alive && p.Team == team)
            {
                players.Add(p.Character);
            }
        }

        return players;
    }

    function GetNearestPlayer(players, position)
    {
        n = null;
        nn = Math.Infinity;
        for(p in players)
        {
            if (p != null)
            {
                dist = Vector3.Distance(p.Position, position);
                if (dist < nn)
                {
                    n = p;
                    nn = dist;
                }
            }
        }

        return n;
    }

    function GetRemainingTitansLabel()
    {
        redStr = Convert.ToString(self._redTitans.Count);
        blueStr = Convert.ToString(self._blueTitans.Count);

        if (CFMatchmaking._player1 == null) {
            return;
        }
        elif (CFMatchmaking._player2 == null) {
            return;
        }

        return "[" + self._p1Score + "] " + CFMatchmaking._player1.Name + " <color=#f06464>[" + redStr + "]</color> | " + "<color=#62b7f0>[" + blueStr + "]</color>" + CFMatchmaking._player2.Name + " [" + self._p2Score + "]";
    }

    function GetRandomListElement(list)
    {
        index = Random.RandomInt(0, list.Count);
        return list.Get(index);
    }

    function ClearTitans()
    {
        for(bt in self._blueTitans)
        {
            if (bt != null) {
                bt.GetKilled("");
            }
        }

        for(rt in self._redTitans)
        {
            if (rt != null) {
                rt.GetKilled("");
            }
        }
        if (self._blueTitans.Count > 0) {
           self._blueTitans.Clear();
        }
        if (self._redTitans.Count > 0) {
            self._redTitans.Clear();
        }
    }
}
extension CFMatchmaking
{
    _matchStarted = false;
    _activePlayers = List();
    /*@type Player*/ _player1 = null;
    /*@type Player*/ _player2 = null;
    _round = 0;
    _queuedPlayers = List();
    _placeInQueue = 0;
    _p1Score = 0;
    _p2Score = 0;
    _winner = null;
    _spawn1 = null;
    _spawn2 = null;
    _killZone = null;

    _savedGas = 0;
    _savedSpecial = null;
    function Init()
    {
        char = Network.MyPlayer.Character;
        Commands.RegisterCommand("cf",self.QueueCFCmd,"/cf: Queue for cage fight.");
        Commands.RegisterCommand("leavecf",self.LeaveCFQUeue,"/leavecf: leave queue.");

        if (Network.IsMasterClient) {
            Commands.RegisterCommand("cfend",self.EndCMD,"/cfend: ends cf match.");
            Commands.RegisterCommand("clearqueue",self.clearqueueCMD,"/clearqueue: ends cf match.");
            Commands.RegisterCommand("cfstart",self.cfstartCMD,"/cfstart: ends cf match.");
        }

        self._spawn1 = Map.FindMapObjectByName("Player1CFSpawn").Position;
        self._spawn2 = Map.FindMapObjectByName("Player2CFSpawn").Position;
        self._killZone = Map.FindMapObjectByName("CFKillZone");
    }  

    function cfstartCMD()
    {
        Network.SendMessage(Network.MasterClient,"StartCFMatch");
    }

    function clearqueueCMD()
    {
        self._queuedPlayers.Clear();
        Network.SendMessageAll("QueuedCFPlayers|" + Json.SaveToString(self._queuedPlayers));
    }
    function QueueCFCmd(cmd,args)
    {
        Network.SendMessage(Network.MasterClient, "JoinCFQueue");
    }

    function LeaveCFQUeue()
    {
        Network.SendMessage(Network.MasterClient, "LeaveCFQueue");
    }

    function EndCMD()
    {
        self.EndMatch();
    }

    function OnPlayerSpawn(player,character)
    {
        if (self._matchStarted)
        {
            if (player == self._player1)
            {
                self._player1.Character.Team = TeamEnum.Red;               
            }
            elif (player == self._player2)
            {
                self._player2.Character.Team = TeamEnum.Blue; 
            }
        }
    }

    function OnPlayerLeave(player)
    {
        if (self._queuedPlayers.Contains(player.ID) && Network.IsMasterClient)
        {
            self._queuedPlayers.Remove(player.ID);
            Network.SendMessageAll("QueuedCFPlayers|" + Json.SaveToString(self._queuedPlayers));
        }
    }

    function OnNetworkMessage(sender,message,args)
    {
        rpc = args.Get(0);

        if (rpc == "ImPlayer1")
        {
            self._player1 = Network.MyPlayer;
            Network.MyPlayer.Character.Rigidbody.MovePosition(self._spawn1);
            Network.MyPlayer.Character.Team = "Red";
        }
        elif (rpc == "ImPlayer2")
        {
            self._player2 = Network.MyPlayer;
            Network.MyPlayer.Character.Rigidbody.MovePosition(self._spawn2);
            Network.MyPlayer.Character.Team = "Blue";
        }     
        elif (rpc == "MoveMyBody")
        {
            Network.MyPlayer.Character.Rigidbody.MovePosition(Network.MyPlayer.SpawnPoint);
            Network.MyPlayer.Character.Velocity = Vector3.Zero;

            if (Network.MyPlayer == self._player1) {
                Network.MyPlayer.Character.Team = "Red";
            }
            elif (Network.MyPlayer == self._player2) {
                Network.MyPlayer.Character.Team = "Blue";
            }
        }     
        elif (rpc == "QueuedCFPlayers")
        {
            queue = Json.LoadFromString(args.Get(1));

            self._queuedPlayers = queue;

            text = "--CF Queue--" + String.Newline;

            for (i in Range(0,self._queuedPlayers.Count,2))
            {
                if (self._queuedPlayers.Count == 1) {
                    text += Network.FindPlayer(self._queuedPlayers.Get(0)).Name;
                    UI.SetLabel("MiddleRight", text);
                    return;
                }
                p1Name = Network.FindPlayer(self._queuedPlayers.Get(i)).Name;
                p2Name = Network.FindPlayer(self._queuedPlayers.Get(i + 1)).Name;
                text +=  + p1Name + " VS " + p2Name + String.Newline;              
            }
            UI.SetLabel("MiddleRight", text);
        }

        if (rpc == "YourCFQueuePlace")
        {
            queue = Convert.ToInt(args.Get(1));

            Game.Print("In Queue: [" + queue + "]");
            Game.PrintAll(Network.MyPlayer.Name + " Has Joined the CF Queue!");
        }
        
        
        if (!Network.IsMasterClient) {return;}
        if (rpc == "JoinCFQueue")
        {
            if (self._queuedPlayers.Contains(sender.ID))
            {
                Game.Print("Already Contains Player");
                return;
            }
            if (!self._queuedPlayers.Contains(sender.ID)) {self._queuedPlayers.Add(sender.ID);}
            if (!self._matchStarted){
                self.CheckQueue();
            }
            for (i in Range(self._queuedPlayers.Count)) {
                if (self._queuedPlayers.Get(i) == sender.ID)
                {
                    self._placeInQueue = i + 1;
                    Network.SendMessage(sender, "YourCFQueuePlace|" + self._placeInQueue);
                    Network.SendMessageAll("QueuedCFPlayers|" + Json.SaveToString(self._queuedPlayers));
                    return;                    
                }
            }
        } 
        elif (rpc == "LeaveCFQueue")
        {
            if (self._queuedPlayers.Contains(sender.ID))
            {
                self._queuedPlayers.Remove(sender.ID);
                Network.SendMessageAll("QueuedCFPlayers|" + Json.SaveToString(self._queuedPlayers));
                return;
            }
            else
            {
                Game.Print("Player not in queue");
            }
        }
        elif (rpc == "StartCFMatch")
        {
            self.Lists();
            self.StartMatch();
        }
        elif (rpc == "StartRound2CF")
        {
            self.Round2();
        }
        elif (rpc == "StartRound3CF")
        {
            self.Round3();
        }
    }

  function Lists()
  {
    self._player1 = Network.FindPlayer(self._queuedPlayers.Get(0));
    self._player2 = Network.FindPlayer(self._queuedPlayers.Get(1));

    self._queuedPlayers.RemoveAt(0);
    self._queuedPlayers.RemoveAt(1);

    self._activePlayers.Add(self._player1);
    self._activePlayers.Add(self._player2);
  }

  function StartMatch()
  {
    self._matchStarted = true;
    self._round = 1;

    if (self._player1 == null) {Game.Print("P1 null");}
    if (self._player2 == null) {Game.Print("P2 null");}
    Network.SendMessage(self._player1, "ImPlayer1");
    Network.SendMessage(self._player2, "ImPlayer2");

    self._player1.Character.Team = TeamEnum.Red;
    self._player2.Character.Team = TeamEnum.Blue;

    self._player1.SpawnPoint = self._spawn1;
    self._player2.SpawnPoint = self._spawn2;

    Game.PrintAll("CF MATCH START! " + self._player1.Name + " VS " + self._player2.Name);
    CageFight.CFInit();
  }

  function Round2()
  {
    self._round = 2;

    self.SendMessageToFighters("MoveMyBody");
    CageFight.CageFightRND2();
  }

  function Round3()
  {
    self._round = 3;
    self.SendMessageToFighters("MoveMyBody");
    CageFight.CageFightRND3();
  }

  coroutine EndMatch()
  {
    self._player1.Character.GetKilled(" ");
    self._player2.Character.GetKilled(" ");
    self._player1.SpawnPoint = null;
    self._player2.SpawnPoint = null;
    self._player1 = null;
    self._player2 = null;
    CageFight._p1Score = 0;
    CageFight._p2Score = 0;
    self._activePlayers.Clear();
    self._matchStarted = false;
    CageFight._enabled = false;
    self._killZone.Active = true;
    Network.SendMessageAll("QueuedCFPlayers|" + Json.SaveToString(self._queuedPlayers));
  }

  function DetermineWinner()
  {
    if (self._p1Score > self._p2Score)
    {
        Game.PrintAll(self._player1.Name + " HAS WON THE MATCH!!!");
        self._winner = self._player1;
        self.EndMatch();
        self.CheckQueue();
    }
    elif (self._p2Score > self._p1Score)
    {
        Game.PrintAll(self._player2.Name + " HAS WON THE MATCH!!!");
        self._winner = self._player2;
        self.EndMatch();
        self.CheckQueue();
    }
    else
    {
        Game.PrintAll("MATCH ENDS IN DRAW!");
        return;
    }
  }

  function CheckQueue()
  {
    count = self._queuedPlayers.Count;

    if (count < 2) {return;}

    Network.SendMessage(Network.MasterClient, "StartCFMatch");
  }

  function SendMessageToFighters(message)
  {
    if (self._player1 != null){
        Network.SendMessage(self._player1, message);
    }
    if (self._player2 != null) {
        Network.SendMessage(self._player2, message);
    }
  }

}
extension Command
{
    function FireOffCMD(cmd,args)
    {
        id = Convert.ToInt(args.Get(0));
        for (player in Network.Players)
        {
            if (player.ID == id)
            {
                Network.SendMessage(player, "fireoff");
            }
            
        }
    }

    function FireCMD(cmd,args)
    {
        id = Convert.ToInt(args.Get(0));
        for (player in Network.Players)
        {
            if (player.ID == id)
            {
                Network.SendMessage(player, "fire");
            }
            
        }
    }
    function SmiteCMD (cmd,args)
    {
        id = Convert.ToInt(args.Get(0));
        
        for (player in Network.Players)
        {
            if (player.ID == id)
            {
                Network.SendMessage(player, "Smited");                   
            }
        }
    }

    function TptoCMD(cmd,args)
    {
        p = Convert.ToInt(args.Get(0));

        Network.SendMessage(Network.FindPlayer(p),"TpTo");
    }

    function tpCMD(cmd,args)
    {
        id = Convert.ToInt(args.Get(0));

        for (p in Network.Players)
        {
            if (p.ID == id)
            {
                Network.SendMessage(p, "TP");
                return;
            }
        }
    }

    function tpallCMD(cmd,args)
    {
        Network.SendMessageAll("Tpall");
    }

    function deopCMD(cmd,args)
    {
        id = Convert.ToInt(args.Get(0));

        for (p in Network.Players)
        {
            if (p.ID == id)
            {
                p.SetCustomProperty("IsOp", false);   
                Game.PrintAll(p.Name + " has been deopped");
            }
        }  
    }
    
    function opCMD(cmd,args)
    {
        id = Convert.ToInt(args.Get(0));

        for (p in Network.Players)
        {
            if (p.ID == id)
            {
                p.SetCustomProperty("IsOp", true);   
                Network.SendMessage(p, "Cmd");
                Game.PrintAll(p.Name + " has been opped");
            }
        }
    }
}
extension CmdsNetworking
{
    _objList = List();

    Lightning = Prefab("Scene,FX/Lightning1a,105,0,1,0,1,0,Lightning1a,179.4736,263.2018,-236.1912,0,0,0,1,1,1,None,Entities,Default,DefaultNoTint|255/255/255/255,", false);
    _lightning = null;
    function OnNetworkMessage(sender,message,args)
    {
        rpc = args.Get(0);
        if (rpc == "TP")
        {
            Game.SpawnPlayerAt(Network.MyPlayer, true, sender.Character.Position);
        }
        elif (rpc == "Tpall")
        {
            Game.SpawnPlayerAt(Network.MyPlayer, true, sender.Character.Position);
        }
        elif (rpc == "TpTo")
        {
            Game.SpawnPlayerAt(sender, true, Network.MyPlayer.Character.Position);
        }
        elif (rpc == "Cmd")
        {
            Main.SetCommands();
        }
        elif (rpc == "Smited")
        {
            self.CreateThenDestroy();
        }
        elif (rpc == "Pim Zap")
        {
            charPos = Vector3(sender.Character.Position.X,sender.Character.Position.Y + 200, sender.Character.Position.Z);
            self._lightning = Map.CreateMapObject(self.Lightning, charPos, Vector3(90,90,90), Vector3.One * 2);
            self._objList.Add(self._lightning);
            self.Destroy();
        }
        elif (rpc == "fire")
        {
            Main._fireDamage = true;
        }
        elif (rpc == "fireoff")
        {
            Main._fireDamage = false;  
        }
    }

    coroutine CreateThenDestroy()
    {
        charPos = Network.MyPlayer.Character.Position;
        Network.SendMessageAll("Pim Zap");
        Game.SpawnEffect(EffectNameEnum.ThunderspearExplode, charPos, self._lightning.Rotation, 10, Color("#ffee00"));
        Game.SpawnEffect(EffectNameEnum.ShifterThunder, charPos, self._lightning.Rotation, 2);
        Network.MyPlayer.Character.GetKilled("Pim Zap");
        Network.MyPlayer.Deaths -= 1;
    }

    coroutine Destroy()
    {
        wait 3;
        for (obj in self._objList)
        {
            Map.DestroyMapObject(obj, true);
            self._objList.Remove(obj);
        }
    }
}
extension BodySizeManager
{
    message_prefix = "ChangeChacterSize";
    character_sizes = Dict();

    function OnChatInput(message)
    {
        args = String.Split(message, " ", true);
        command = args.Get(0);

            if (command == "/csize" && (args.Count == 4 || args.Count == 5))
            {
                playerID = Network.MyPlayer.ID;
                if (args.Count == 4)
                {
                    x = Convert.ToFloat(args.Get(1));
                    y = Convert.ToFloat(args.Get(2));
                    z = Convert.ToFloat(args.Get(3));
                }
                else
                {
                    playerID = Convert.ToFloat(args.Get(1));
                    x = Convert.ToFloat(args.Get(2));
                    y = Convert.ToFloat(args.Get(3));
                    z = Convert.ToFloat(args.Get(4));
                }

                scale = Vector3(x,y,z);
                Network.SendMessageAll(self.GetMessage(playerID,scale));

                return false;
            }

        return true;
    }

    function OnNetworkMessage(sender, message)
    {
            args = String.Split(message, " ", true);

            if (args.Get(0) == self.message_prefix)
            {
                playerID = Convert.ToFloat(args.Get(1));
                x = Convert.ToFloat(args.Get(2));
                y = Convert.ToFloat(args.Get(3));
                z = Convert.ToFloat(args.Get(4));
                scale = Vector3(x,y,z);

                self.ChangeSize(playerID, scale);
            }
    }

    function ChangeSize(playerID, scale)
    {
        player = Network.FindPlayer(playerID);

        if (player == null)
        {
            return;
        }

        character = player.Character;

        if (character == null)
        {
            return;
        }

        character.Transform.Scale = scale;
        self.character_sizes.Set(character.ViewID, scale);
    }

    function GetMessage(playerID, scale)
    {
        return String.FormatFromList(self.message_prefix + " {0} {1} {2} {3}", List(playerID,scale.X,scale.Y,scale.Z));
    }

    function OnPlayerJoin(player)
    {
        for (viewID in self.character_sizes.Keys)
        {
            char = Game.FindCharacterByViewID(viewID);
            if (char != null)
            {
                scale = self.character_sizes.Get(viewID);
                Network.SendMessage(player, self.GetMessage(char.Player.ID, scale));
            }
            else
            {
                self.character_sizes.Remove(viewID);
            }
        }

    }
}
extension TextUtil
{
    # The following info was discovered via trial and error, not datamined:
    # Rich text legal opening tags (regex)
    # <[bi][=>]
    # <(?:size|color|material)(?:=[^>]*>?|>)
    # <(?:quad|a)(?:[ =][^>]*>?|>)
    # closing tags:
    # </(?:[bi]|size|color|material)>
    # </(?:quad|a)[ >]
    # "type 1" tags: b, i
    #   no parameters, needs closed ("<tag>inner content</tag>")
    # "type 2" tags: size, color, material
    #   single parameter, has inner content ("<tag=value>inner content</tag>")
    # "type 3" tag: a
    #   named parameters, has inner content ("<tag name=value>inner content</tag>")
    # "type 3.5" tag: quad
    #   named parameters, no inner content ("<tag name=value>")
    # Any text not recognized as part of a opening or closing tag will be left as plaintext
    # Additionally, there are two cases which will cause the entire input to be rejected:
    # - For tags that have inner content, a valid closing tag is required or the entire input to fail to parse (aka treated as plaintext)
    #     Note that the '>' is not required for an opening tag, but types 2+ will gobble characters until reaching '>' if their alternate terminator characters are used
    #     This means that only types 1 and 3.5 can actually use an opening tag not ending in '>' in a way that does not cause the string to fail to parse
    #       (type 1 because it does not gobble characters up to '>', type 3.5 because it does not use a closing tag)
    # - For tags that cannot have inner content, parsing their closing tag will cause the entire input to fail to parse
    #     (this means that, e.g. "<b></IllegalTagInBold></b>" parses but "<b></quad></b>" and "<b></quad </b>" do not)
    function GetPlainText(richText)
    {
        STR_EMPTY = "";
        SEP_LT = "<";
        SEP_GT = ">";
        SEP_EQ = "=";
        SEP_SP = " ";
        SEP_FS = "/";
        SEP_LTFS = "</";

        TAG_B = "b";
        TAG_I = "i";
        TAG_COLOR = "color";
        TAG_SIZE = "size";
        TAG_MATERIAL = "material";
        TAG_A = "a";
        TAG_QUAD = "quad";

        tagNames = List();
        tagNames.Add(TAG_MATERIAL);
        tagNames.Add(TAG_COLOR);
        tagNames.Add(TAG_SIZE);
        tagNames.Add(TAG_QUAD);
        tagNames.Add(TAG_A);
        tagNames.Add(TAG_B);
        tagNames.Add(TAG_I);

        openSplit = String.Split(richText, SEP_LT, false);
        # @type List<string>
        plainText = List();
        plainText.Add(openSplit.Get(0));
        openSplit.RemoveAt(0);

        # @type List<string>
        openTags = List();

        # @type string
        incompleteTag = null;
        # @type List<string>
        incompletePlaintext = List();

        for (openPart in openSplit)
        {
            if (incompleteTag != null)
            {
                closeIdx = String.IndexOf(openPart, SEP_GT);
                if (closeIdx >= 0)
                {
                    if (incompleteTag != TAG_QUAD)
                    {
                        openTags.Add(incompleteTag);
                    }
                    openPart = String.Substring(openPart, closeIdx + 1);
                }
                else
                {
                    incompletePlaintext.Add(openPart);
                    continue;
                }
                incompleteTag = null;
                incompletePlaintext.Clear();
            }

            isClosingTag = false;
            if (String.StartsWith(openPart, SEP_FS))
            {
                isClosingTag = true;
                openPart = String.Substring(openPart, 1);
            }
            openPartToLower = String.ToLower(openPart);
            for (tag in tagNames)
            {
                if (String.StartsWith(openPartToLower, tag))
                {
                    endChar = String.SubstringWithLength(openPart, String.Length(tag), 1);
                    if (isClosingTag)
                    {
                        if (endChar == SEP_GT || (endChar == SEP_SP && (tag == TAG_A || tag == TAG_QUAD)))
                        {
                            if (tag == TAG_QUAD || openTags.Count <= 0 || openTags.Get(openTags.Count - 1) != tag)
                            {
                                return richText;
                            }
                            openTags.RemoveAt(openTags.Count - 1);
                            openPart = String.Substring(openPart, String.Length(tag) + 1);
                        }
                        else
                        {
                            plainText.Add(SEP_LTFS);
                        }
                    }
                    else
                    {
                        if (endChar == SEP_GT)
                        {
                            if (tag != TAG_QUAD)
                            {
                                openTags.Add(tag);
                            }
                            openPart = String.Substring(openPart, String.Length(tag) + 1);
                        }
                        elif (endChar == SEP_EQ)
                        {
                            if (tag == TAG_B || tag == TAG_I)
                            {
                                openTags.Add(tag);
                                openPart = String.Substring(openPart, String.Length(tag) + 1);
                            }
                            else
                            {
                                closeIdx = String.IndexOf(openPart, SEP_GT);
                                if (closeIdx >= 0)
                                {
                                    if (tag != TAG_QUAD)
                                    {
                                        openTags.Add(tag);
                                    }
                                    openPart = String.Substring(openPart, closeIdx + 1);
                                }
                                else
                                {
                                    incompleteTag = tag;
                                    incompletePlaintext.Clear();
                                    incompletePlaintext.Add(SEP_LT);
                                    incompletePlaintext.Add(openPart);
                                    openPart = STR_EMPTY;
                                }
                            }
                        }
                        elif (endChar == SEP_SP && (tag == TAG_A || tag == TAG_QUAD))
                        {
                            closeIdx = String.IndexOf(openPart, SEP_GT);
                            if (closeIdx >= 0)
                            {
                                if (tag != TAG_QUAD)
                                {
                                    openTags.Add(tag);
                                }
                                openPart = String.Substring(openPart, closeIdx + 1);
                            }
                            else
                            {
                                incompleteTag = tag;
                                incompletePlaintext.Clear();
                                incompletePlaintext.Add(SEP_LT);
                                incompletePlaintext.Add(openPart);
                                openPart = STR_EMPTY;
                            }
                        }
                        else
                        {
                            plainText.Add(SEP_LT);
                        }
                    }

                    break;
                }
            }
            plainText.Add(openPart);
        }

        if (incompleteTag != null)
        {
            plainText.Add(String.Join(incompletePlaintext, STR_EMPTY));
        }

        return String.Join(plainText, STR_EMPTY);
    }

    _color = "";

    function SetColor(color)
    {
        self._color = color;
    }

    function ColorStr(text, color) {
        return "<color=#" + color + ">" + text + "</color>";
    }

    function LazyColorStr(text) {
        return "<color=#" + self._color + ">" + text + "</color>";
    }

    function SizeStr(string, size)
    {
        return "<size=" + size + ">" + string + "</size>";
    }

    function BoldStr(string)
    {
        return "<b>" + string + "</b>";
    }
}
extension ServerID
{   
    PreventAltClients = false;

    _playerServerIDs = Dict(); #Temp(dependent on non host clients)
    _serverIDNames = Dict(); #Permanent for host
    _activeServerIDs = Set(); #Temp(dependent on non host clients)
    _authorizedUsers = Set(); #Temp(dependent on non host clients)
    _authorizedUserServerIDs = List(); #Permanent for host

    _isAuthorized = false;
    
    _bannedServerIDs = List();
    _bannedServerNames = List();

    #Client
    _myServerIDFileName = "ServerID_Cami";
    _myServerIDPropName = "SID_Cami";

    #Host Only
    _serverIDNamesFileName = "";
    _serverIDNamesPropName = "";
    _serverAdminServerIDsFileName = "";
    _serverAdminServerIdsPropName = "";

    _bannedServerIDFileName = "";
    _bannedServerIDPropName = "";
    _bannedServerNamesFileName = "";
    _bannedServerNamesPropName = "";

    #File Name Load
    _fileNameStorageFile = "";

    _prop_serverIDNamesFile = "";
    _prop_ServerIDNamesProp = "";
    _prop_ServerAdminIDsFile = "";
    _prop_ServerAdminIDsProp = "";
    _prop_bannedServerIDsFile = "";
    _prop_bannedServerIDsProp = "";
    _prop_BannedServerNamesFile = "";
    _prop_BannedServerNamesProp = "";

    _sidDelayTimer = 0;

    function LoadPrivateStorageFileNames()
    {  
        if(!Network.IsMasterClient) { return; } 
        self._fileNameStorageFile = "FileNames_Cami";

        self._prop_serverIDNamesFile = "FileServerIDNames";
        self._prop_ServerIDNamesProp = "Prop_ServerIDNames";
        self._prop_ServerAdminIDsFile = "File_ServerAdminIDs";
        self._prop_ServerAdminIDsProp = "Prop_ServerAdminIDs";
        self._prop_bannedServerIDsFile = "File_BannedServerIDs";
        self._prop_bannedServerIDsProp = "Prop_BannedServerIDs";
        self._prop_BannedServerNamesFile = "File_BannedServerNames";
        self._prop_BannedServerNamesProp = "Prop_BannedServerNames";

        PrivateFileManager.SetupStorage(self._fileNameStorageFile);
    }

    function LoadFileNames()
    {
        if(!Network.IsMasterClient) { return; } 
        PersistentData.Clear();

        self._serverIDNamesFileName = PrivateFileManager.LoadFileName(self._prop_serverIDNamesFile, false, false);
        self._serverIDNamesPropName = PrivateFileManager.LoadFileName(self._prop_ServerIDNamesProp, false, false);
        self._serverAdminServerIDsFileName = PrivateFileManager.LoadFileName(self._prop_ServerAdminIDsFile, false, false);
        self._serverAdminServerIdsPropName = PrivateFileManager.LoadFileName(self._prop_ServerAdminIDsProp, false, false);
        self._bannedServerIDFileName = PrivateFileManager.LoadFileName(self._prop_bannedServerIDsFile, false, false);
        self._bannedServerIDPropName = PrivateFileManager.LoadFileName(self._prop_bannedServerIDsProp, false, false);
        self._bannedServerNamesFileName = PrivateFileManager.LoadFileName(self._prop_BannedServerNamesFile, false, false);
        self._bannedServerNamesPropName = PrivateFileManager.LoadFileName(self._prop_BannedServerNamesProp, false, false);
    }

    function LoadDataFiles()
    {
        if(!Network.IsMasterClient) { return; }

        serverIDNames = PData.LoadDataFromFile(self._serverIDNamesFileName, self._serverIDNamesPropName, false, true);
        if(serverIDNames != null) { self._serverIDNames = serverIDNames; }
        authorizedUsers = PData.LoadDataFromFile(self._serverAdminServerIDsFileName, self._serverAdminServerIdsPropName, false, true);
        if(authorizedUsers != null) { self._authorizedUserServerIDs = authorizedUsers; }
        bannedServerIDs = PData.LoadDataFromFile(self._bannedServerIDFileName, self._bannedServerIDPropName, false, true);
        if(bannedServerIDs != null) { self._bannedServerIDs = bannedServerIDs; }
        bannedServerNames = PData.LoadDataFromFile(self._bannedServerNamesFileName, self._bannedServerNamesPropName, false, true);
        if(bannedServerNames != null) { self._bannedServerNames = bannedServerNames; }
    }

    function GeneratePlayerServerID()
    {
        attempts = 0;
        while (true)
        {
            a = Random.RandomInt(0, 2147483647);
            b = Random.RandomInt(0, 2147483647);
            c = Random.RandomInt(0, 2147483647);
            d = Random.RandomInt(0, 2147483647);

            sID =
                Convert.ToString(a) + "-" +
                Convert.ToString(b) + "-" +
                Convert.ToString(c) + "-" +
                Convert.ToString(d);

            if(String.Length(sID) >= 32)
            {
                return sID;
                break;
            }

            attempts += 1;
            if (attempts > 50)
            {
                return sID;
                break;
            }
        }
    }

    function GetHostServerID()
    {   
        if(!Network.IsMasterClient) { return; }
        ServerID.PreventAltClients = Main.PreventAlts;

        myPlayer = Network.MyPlayer;
        myID = myPlayer.ID;

        myServerIDFileName = self._myServerIDFileName;
        myServerIDPropName = self._myServerIDPropName;

        serverIDFileExists = PersistentData.FileExists(myServerIDFileName);

        if(!serverIDFileExists) {
            hostServerID = self.GeneratePlayerServerID();
            PData.SaveToFile(myServerIDFileName, myServerIDPropName, hostServerID, true, false);
        }
        else { hostServerID = PData.LoadDataFromFile(myServerIDFileName, myServerIDPropName, true, false); }

        self.SaveServerName(myPlayer.Name, hostServerID);

        serverAdminFileName = self._serverAdminServerIDsFileName;
        adminIDFileExists = PersistentData.FileExists(serverAdminFileName); 

        if(!adminIDFileExists) {
            self._authorizedUserServerIDs.Add(hostServerID);
            PData.SaveToFile(serverAdminFileName, self._serverAdminServerIdsPropName, self._authorizedUserServerIDs, false, true);
        } 
        else { self._authorizedUserServerIDs = PData.LoadDataFromFile(serverAdminFileName, self._serverAdminServerIdsPropName, false, true); }
        TextUtil.SetColor("#fdcaff");
        Game.Print(myPlayer.Name + " SID: " + UI.WrapStyleTag(hostServerID, "color", "#035a03"));
        self._playerServerIDs.Set(myID, hostServerID);
        self._activeServerIDs.Add(hostServerID);
        self._authorizedUsers.Add(myPlayer);
        self._isAuthorized = true;
    }

    function DelaySIDSendOnSec()
    {
        if(self._sidDelayTimer > 0) { self._sidDelayTimer -= 1; }
        elif(self._sidDelayTimer == 0) { self.SendSIDToHost(); self._sidDelayTimer = -1; }
    }

    function SendSIDToHost()
    {
        if(Network.IsMasterClient) { return; }

        fileName = self._myServerIDFileName;
        propName = self._myServerIDPropName;

        serverIDFileExists = PersistentData.FileExists(fileName);

        if(!serverIDFileExists) {
            serverID = self.GeneratePlayerServerID();
            self.SaveMyServerID(serverID);
            Network.SendMessage(Network.MasterClient, "SID|" + serverID);
            Main.Coins += 500;

            return;
        }

        serverID = PData.LoadDataFromFile(fileName, propName, true, false);
        if(serverID == null) { serverID = ""; }

        Network.SendMessage(Network.MasterClient, "SID|" + serverID);
    }

    function HandleServerIDRpcs(sender, args)
    {
        rpc = args.Get(0);

        if(Network.IsMasterClient) {
            if(rpc == "SID") {
                senderServerID = args.Get(1);

                senderName = sender.Name;
                senderID = sender.ID;
                if(senderName == "" || senderName == null) {
                    Network.KickPlayer(sender, " Empty Name");
                    return; 
                }
                if(senderServerID == null) {
                    #Network.KickPlayer(sender); 
                    Game.Print("Server ID null");
                    return; 
                }
                if(senderServerID == "" || String.Length(senderServerID) < 30) {
                    #Network.KickPlayer(sender);
                    return;
                }
                if(self.CheckIfBanned(senderServerID, sender)) {
                    Network.KickPlayer(sender, " Perma Banned");
                    return;
                }
                if(self._activeServerIDs.Contains(senderServerID)) {
                    if(self.PreventAltClients) { Network.KickPlayer(sender, " Alt Clients Not Allowed"); }
                    return;
                }
                if(self._playerServerIDs.Contains(sender.ID)) {
                    if(self.PreventAltClients) { Network.KickPlayer(sender, " Alt Clients Not Allowed"); }
                    return;
                }

                if(self._authorizedUserServerIDs.Contains(senderServerID)) {
                    self._authorizedUsers.Add(sender);
                }

                Game.Print(senderName + " SID: " + UI.WrapStyleTag(senderServerID, "color", "#035a03"));
                self.SaveValidServerID(senderServerID, senderName, senderID);

                return;
            }
            elif(rpc == "IAmBanned") {
                Network.KickPlayer(sender, " Perma Banned");
                return;
            }

            if(!self._authorizedUsers.Contains(sender)) { return; }
            if(rpc == "PermaBanPlayer") {
                senderServerID = self._playerServerIDs.Get(sender.ID);
                if(!self._authorizedUserServerIDs.Contains(senderServerID)) { #In case someone somehow gets onto the hosts list of server admin players
                    Network.KickPlayer(sender, " Faking Admin");
                    return;
                }

                playerID = Convert.ToInt(args.Get(1));
                player = Network.FindPlayer(playerID);
                playerName = player.Name;
                sanitizedName = TextUtil.GetPlainText(playerName);
                playerServerID = self._playerServerIDs.Get(playerID);

                if(playerServerID == null || playerServerID == "" || String.Length(playerServerID) < 30) {
                    
                    self.SaveBannedName(sanitizedName);
                    self.SaveBannedName(playerName);

                    Network.KickPlayer(player);
                    return;
                }

                self.SaveBannedPlayer(playerServerID, sanitizedName);
                self.SaveBannedName(playerName);
                Network.SendMessage(player, "Banned");
                self.DelayKick(1, player, "Perma Banned");
            }
            elif(rpc == "KickPlayer") {
                senderServerID = self._playerServerIDs.Get(sender.ID);
                if(!self._authorizedUserServerIDs.Contains(senderServerID)) { #In case someone somehow gets onto the hosts list of server admin players
                    Network.KickPlayer(sender, " Faking Admin");
                    return;
                }

                playerID = Convert.ToInt(args.Get(1));
                player = Network.FindPlayer(playerID);
                if(player == null) { return; }
                Network.KickPlayer(player);
                return;
            }
        }
        if(sender == Network.MasterClient) {
            if(rpc == "Auth") {
                self._isAuthorized = true;
                Game.Print(Network.MyPlayer.Name + " Received Admin");
                return;
            }
            elif(rpc == "Banned") {
                #Save Ban File
                self.SaveBan();
                return;
            }
        }
    }

    function SaveBan()
    {
        if(!PersistentData.FileExists("FUCKU")) {
            PData.SaveToFile("FUCKU", "Banned", true, true, false);
            return;
        }
    }

    function CheckIfImBanned()
    {   
        self._sidDelayTimer = 3;
        if(PersistentData.FileExists("FUCKU")) {
            PersistentData.LoadFromFile("FUCKU", true);
            if(PersistentData.GetProperty("Banned", null) == true) {
                Network.SendMessage(Network.MasterClient, "IAmBanned");
                return;
            }
        }
    }

    function SaveMyServerID(serverID)
    {   
        fileName = self._myServerIDFileName;
        propName = self._myServerIDPropName;

        myServerIDFileExists = PersistentData.FileExists(fileName);
        if(!myServerIDFileExists) {
            PData.SaveToFile(fileName, propName, serverID, true, false);
        }
    }

    function SaveServerName(playerName, playerServerID)
    {   
        if(!Network.IsMasterClient) { return; }

        if(!self._serverIDNames.Contains(playerServerID)) {
            self._serverIDNames.Set(playerServerID, playerName);
            PData.SaveToFile(self._serverIDNamesFileName, self._serverIDNamesPropName, self._serverIDNames, false, true);
            return;
        }
        savedName = self._serverIDNames.Get(playerServerID);
        if(savedName == "" || savedName == null) {
            self._serverIDNames.Remove(playerServerID);
            PData.SaveToFile(self._serverIDNamesFileName, self._serverIDNamesPropName, self._serverIDNames, false, true);
            return;
        }

        if(savedName != playerName) {
            
            self._serverIDNames.Set(playerServerID, playerName);
            PData.SaveToFile(self._serverIDNamesFileName, self._serverIDNamesPropName, self._serverIDNames, false, true);
        }
    }

    function SaveValidServerID(senderServerID, senderName, senderID)
    {
        self._playerServerIDs.Set(senderID, senderServerID); 
        if(!self._activeServerIDs.Contains(senderServerID)) { self._activeServerIDs.Add(senderServerID); } 
        self.SaveServerName(senderName, senderServerID);
    }

    #Ban

    function CheckIfBanned(serverID, sender)
    {
        isBanned = false;
        senderName = sender.Name;
        santizedName = TextUtil.GetPlainText(senderName);

        if(self._bannedServerIDs.Contains(serverID)) { isBanned = true; }
        nameIsBanned = self._bannedServerNames.Contains(senderName) || self._bannedServerNames.Contains(santizedName);
        if(nameIsBanned) { isBanned = true; }

        return isBanned;
    }

    function SaveBannedPlayer(bannedID, bannedName)
    {   
        bannedServerID = self._playerServerIDs.Get(bannedID);
        
        self.SaveBannedName(bannedName);
        self.SaveBannedServerID(bannedServerID);
    }

    function SaveBannedName(bannedName)
    {   
        sanitizedName = TextUtil.GetPlainText(bannedName);
        changed = false;

        if(!self._bannedServerNames.Contains(bannedName)) {
            self._bannedServerNames.Add(bannedName);
            changed = true;
        }
        if(!self._bannedServerNames.Contains(sanitizedName)) {
            self._bannedServerNames.Add(sanitizedName);
            changed = true;
        }

        if(changed) { PData.SaveToFile(self._bannedServerNamesFileName, self._bannedServerNamesPropName, self._bannedServerNames, false, true); }
    }

    function SaveBannedServerID(bannedServerID)
    {
        if(!self._bannedServerIDs.Contains(bannedServerID)) {

            self._bannedServerIDs.Add(bannedServerID);
            PData.SaveToFile(self._bannedServerIDFileName, self._bannedServerIDPropName, self._bannedServerIDs, false, true);
        }
    }

    function HandleServerIDCommands(args)
    {
        command = args.Get(0);
        if(!self._isAuthorized) { return; }

        if(command == "/pban") {
            playerID = Convert.ToInt(args.Get(1));

            if(!Network.IsMasterClient) {
                Network.SendMessage(Network.MasterClient, "PermaBanPlayer|" + playerID);
                return;
            }

            player = Network.FindPlayer(playerID);
            playerName = player.Name;
            sanitizedName = TextUtil.GetPlainText(playerName);
            playerServerID = self._playerServerIDs.Get(playerID);

            if(playerServerID == null || playerServerID == "" || String.Length(playerServerID) < 30) {
                
                self.SaveBannedName(sanitizedName);
                self.SaveBannedName(playerName);
                Network.SendMessage(player, "Banned");
                self.DelayKick(1, player, " Perma Banned");
                return;
            }
            Network.SendMessage(player, "Banned");
            self.SaveBannedPlayer(playerServerID, sanitizedName);
            self.SaveBannedName(playerName);
            
            self.DelayKick(1, player, " Perma Banned");
        }
        elif(command == "/tkick") {
            playerID = Convert.ToInt(args.Get(1));
            if(!Network.IsMasterClient) { Network.SendMessage(Network.MasterClient, "KickPlayer|" + playerID); }
            Network.KickPlayer(playerID);
            return;
        }
        if(!Network.IsMasterClient) { return; }
        if(command == "/auth" && Network.IsMasterClient) {
            playerID = Convert.ToInt(args.Get(1));
            authPlayer = Network.FindPlayer(playerID);
            if(authPlayer == null) { return false; }

            fileName = self._serverAdminServerIDsFileName;
            propName = self._serverAdminServerIdsPropName;
            
            self._authorizedUsers.Add(authPlayer);

            serverID = self._playerServerIDs.Get(playerID);
            if(serverID == null || serverID == "" || String.Length(serverID) < 10) {
                Game.Print("Player has Modified their Server ID");
                Network.KickPlayer(authPlayer);
                return;
            }

            data = PData.LoadDataFromFile(fileName, propName, false, true);
            if(data != null) { self._authorizedUserServerIDs = data; }
            Game.Print("Number of Admins: " + self._authorizedUserServerIDs.Count);

            if(!self._authorizedUserServerIDs.Contains(serverID)) {
                self._authorizedUserServerIDs.Add(serverID);
            }
            else {
                Game.Print("Player is already an Admin");
                return;
            }
            PData.SaveToFile(fileName, propName, self._authorizedUserServerIDs, false, true);

            Network.SendMessage(authPlayer, "Auth");
            Game.Print("Gave " + authPlayer.Name + " Server Admin"); 
        }
        
    }

    coroutine DelayKick(delay, player, reason)
    {
        wait delay;
        Network.KickPlayer(player, reason);
    }
    
    function RemovePlayerFromStorage(player)
    {   
        if(!Network.IsMasterClient) { return; }

        playerID = player.ID;
        playerServerID = self._playerServerIDs.Get(playerID);
        if(self._playerServerIDs.Contains(playerID)) { self._playerServerIDs.Remove(playerID); }
        if(playerServerID == null) { return; }
        if(self._activeServerIDs.Contains(playerServerID)) { self._activeServerIDs.Remove(playerServerID); } 
    }
}
extension PrivateFileManager
{      
    _storageFileName = "";
    _serializedFile = false;

    function SetupStorage(fileName)
    {
        self._storageFileName = fileName;
        #Game.PrintAll("Storage File Name: " + fileName);
    }

    function LoadFileName(storagePropName, encrypted, serialized)
    {
        data = PData.LoadDataFromFile(self._storageFileName, storagePropName, encrypted, serialized);
        #Game.PrintAll("File Name: " + data);
        if(data == "" || data == null) {  
            #Game.Print("[" + self._storageFileName + "] Persistent Data Property is Empty");
            return null;
        }
        return data;
    }
}
extension PData
{
    _lastSaveFile = "";

    function SaveToFile(fileName, propName, data, encrypted, serialized)
    {
        if(self._lastSaveFile != fileName) {
            PersistentData.Clear();
            self._lastSaveFile = fileName;
        }
        
        if(serialized) { data = Json.SaveToString(data); }
        PersistentData.SetProperty(propName, data);
        PersistentData.SaveToFile(fileName, encrypted);
        return;
    }

    function TryLoadDataFromFile(fileName, propName, data, encrypted, serialized)
    {
        isValidFileName = PersistentData.IsValidFileName(fileName);
        if(!isValidFileName) { return Game.Print("Invalid File Name"); }
        fileExists = PersistentData.FileExists(fileName);
        if(!fileExists) {
            PersistentData.Clear();
            self.SaveToFile(fileName, propName, data, encrypted, serialized);
            return;
        }
        self.LoadDataFromFile(fileName, propName, encrypted, serialized);
    }

    function LoadDataFromFile(fileName, propName, encrypted, serialized)
    {
        if(serialized) {
            PersistentData.LoadFromFile(fileName, encrypted);
            data = PersistentData.GetProperty(propName, "");
            unserializedData = Json.LoadFromString(data);
            return unserializedData; 
        }
        else {
            PersistentData.LoadFromFile(fileName, encrypted);
            return PersistentData.GetProperty(propName, "");
        }
    }
}
extension MoneyData
{
    FileName = "CamiMoneyData";
    PropName_Money = "PropMoneyData";

    _allPlayersData = Dict();
    function LoadPlayerData(serverID)
    {
        allPlayerData = self._allPlayersData;

        if (!allPlayerData.Contains(serverID))
        {
            #Game.Print("Does not contain players data");
            playerDataDict = Dict();

            playerDataDict.Set("Money", 0);
            allPlayerData.Set(serverID,playerDataDict); 
            return playerDataDict;
        }

        serializedPlayerData = allPlayerData.Get(serverID);

        return serializedPlayerData;
    }

    function LoadAllPlayersData() 
    {
        fileName = self.FileName;
        propName = self.PropName_Money;

        data = PData.LoadDataFromFile(fileName, propName, false, true);
        if(data == null) { return; }
        if(data.Count == 0) { return; }
        
        self._allPlayersData = data;
    }

    function LoadHostPlayerData(hostServerID)
    {
        hostData = self.LoadPlayerData(hostServerID);
       # Game.Print("HD" + hostData);
        
        score = hostData.Get("Money");
        #Game.Print("HA" + score);
    }

    function LoadClientPlayerData(serverID, player)
    {
        if(!Network.IsMasterClient) { return; }
        if(serverID == null) {
            Game.Print(player.Name + " ServerID is null");
            return;
        }
 
        playerDataDict = self.LoadPlayerData(serverID);
        playerScore = playerDataDict.Get("Money");
        
        if(playerScore == null) { Game.Print("Score is null " + player.Name); return; }
        Network.SendMessage(player, "SyncData|" + playerScore);
    }

    function SaveMoney(money, serverID)
    {
        if(!Network.IsMasterClient) { return; }

        fileName = self.FileName;
        propName = self.PropName_Money;

        senderData = self.LoadPlayerData(serverID);
        if(senderData == null) { Game.Print("SenderData is null"); return; }
        savedScore = senderData.Get("Money");

        senderData.Set("Money", money);
        self._allPlayersData.Set(serverID, senderData);

        PData.SaveToFile(fileName, propName, self._allPlayersData, false, true);
        Leaderboard.Save(serverID);
    }
}
extension KDData
{
    FileName = "CamiKDData";
    PropName_KD = "PropCamiKD";

    _allPlayersData = Dict();
    function LoadPlayerData(serverID)
    {
        if (!self._allPlayersData.Contains(serverID))
        {
            #Game.Print("Doesnt contain player data");
            playerDataDict = Dict();

            playerDataDict.Set("Kills", 0);
            playerDataDict.Set("Deaths", 0);
            playerDataDict.Set("HighestDmg", 0);
            playerDataDict.Set("TotalDmg", 0);

            self._allPlayersData.Set(serverID, playerDataDict);
            return playerDataDict;
        }
        
        cerealPlayerData = self._allPlayersData.Get(serverID);

        return cerealPlayerData;
    }

    function LoadALLPlayersData()
    {
        data = PData.LoadDataFromFile(self.FileName, self.PropName_KD,false, true);
        if (data == null) {return;}
        if (data.Count <= 0) {return;}

        self._allPlayersData = data;
    }

    function SaveAllData()
    {
        PData.SaveToFile(self.FileName, self.PropName_KD,self._allPlayersData, false, true);
    }

    function Save(kills,deaths,highestDmg, totalDmg, serverID)
    {
        if (!Network.IsMasterClient){return;}

        senderData = self.LoadPlayerData(serverID);
        if (senderData == null) {Game.Print("Sender Data Null"); return;}
        savedKills = senderData.Get("Kills");
        savedDeaths = senderData.Get("Deaths");
        HD = senderData.Get("HighestDmg");
        TD = senderData.Get("TotalDmg");

        senderData.Set("Kills", kills + savedKills);
        senderData.Set("Deaths", deaths + savedDeaths);
        if (highestDmg > HD) {senderData.Set("HighestDmg", highestDmg);}
        senderData.Set("TotalDmg", totalDmg + TD);
        self._allPlayersData.Set(serverID, senderData);

        PData.SaveToFile(self.FileName, self.PropName_KD, self._allPlayersData, false, true);
    }
}
extension Leaderboard
{
    FileName = "CamiLeaderboard";
    PropName_LB = "LBProp";

    NamesList = List();
    SortedKeys = List();
    dataDict = Dict();


    function OnGameStart()
    {
        UI.CreatePopup("Leaderboard", "❤Money Leaderboard❤", 600, 800);
    }

    function OnNetworkMessage(sender, message, args)
    {
        rpc = args.Get(0);

        if (rpc == "Synced")
        {
            self.NamesList.Clear();
            list = Json.LoadFromString(args.Get(1));

            for (name in list)
            {
                UI.AddPopupButton("Leaderboard", "BTN", name);
            }
            #UI.AddPopupButtons("Leaderboard", self.NamesList, self.NamesList);
        }
        

        if (!Network.IsMasterClient) {return;}
        if (rpc == "SyncBoard")
        {
            self.Load();
            self.NamesList.Clear();
            senderServID = ServerID._playerServerIDs.Get(sender.ID);

            servIDList = self.SortKeys();
            namelist = List();
            
            for (id in servIDList)
            {
                name = ServerID._serverIDNames.Get(id);
                m = MoneyData.LoadPlayerData(id);
                money = m.Get("Money");

                namelist.Add(name + "  <color=#00FF00>$</color>" + UI.WrapStyleTag(Convert.ToString(money), "color", "#f691ff"));
            }

            json = Json.SaveToString(namelist);
            Network.SendMessage(sender, "Synced|" + json);
            self.Save(senderServID);
        }   
    }

    function Load()
    {
        fileName = self.FileName;
        fileExisits = PersistentData.FileExists(fileName);

        if (!fileExisits)
        {
            firstSave = Dict();

            hostSID = PData.LoadDataFromFile(ServerID._myServerIDFileName, ServerID._myServerIDPropName, true,false);
            hostData = MoneyData.LoadPlayerData(hostSID);
            hostMoney = Convert.ToInt(hostData.Get("Money"));

            self.dataDict.Set(hostSID, hostMoney);
            self.SortedKeys.Add(hostSID);

            firstSave.Set("Dict", self.dataDict);
            firstSave.Set("List", self.SortedKeys);

            PData.SaveToFile(fileName, self.PropName_LB, firstSave, false, true);
            return;
        }

        loadData = PData.LoadDataFromFile(self.FileName,self.PropName_LB, false, true);
        if (loadData != null)
        {
            dict = loadData.Get("Dict");
            list = loadData.Get("List");

            if (dict != null && dict.Count > 0)
            {
                self.dataDict = dict;
            }
            if (list != null && list.Count > 0)
            {
                self.SortedKeys = list;
            }
        }
    }

    function Save(serverID)
    {
        M = MoneyData.LoadPlayerData(serverID);
        senderMoney = M.Get("Money");

        self.dataDict.Set(serverID, senderMoney);

        savedData = Dict();
        savedData.Set("Dict", self.dataDict);
        savedData.Set("List", self.SortedKeys);

        PData.SaveToFile(self.FileName, self.PropName_LB, savedData,false, true);
    }

    function SortKeys()
    {
        self.SortedKeys.Clear();

        for (key in self.dataDict.Keys)
        {
            self.SortedKeys.Add(key);
        }
        self.SortedKeys.SortCustom(self.CompareDescending);
        return self.SortedKeys;
    }

    function ParseScore(rawScore)
    {
        strScore = Convert.ToString(rawScore);
        
        if (String.Contains(strScore, "x")) {
            parts = String.Split(strScore, "x");
            if (parts.Count > 1) {
                return Convert.ToFloat(parts.Get(1)); 
            }
        }

        return Convert.ToFloat(rawScore);
    }

    function CompareDescending(a, b)
    {
        /*Game.Print("A|" + a);
        Game.Print("B|" + b);*/
        indexA = self.dataDict.Get(a);
        indexB = self.dataDict.Get(b);

        scoreA = indexA;
        scoreB = indexB;

        /*Game.Print("ScoreA|" + scoreA);
        Game.Print("ScoreB|" + scoreB);
        Game.Print("DATADICT|" + self.dataDict);*/

        if(scoreA < scoreB) { return 1; }
        if(scoreA > scoreB) { return -1; }
        return 0;
    }
}
extension Race
{
    _raceStarted = false;
    _prepStarted = false;
    _prepTimer = 0;
    _trackedKills = 0;
    _trackPlayers = Dict();
    _countUpTimer = 0;
    _killsToWin = 0;
    function Init()
    {
        Commands.RegisterCommand("startrace",self.StartCmd,"/startrace [kills(null for 50)]: starts a race");
        Commands.RegisterCommand("joinrace",self.JoinCmd,"/joinrace: joins a race");

        if (Network.IsMasterClient) {
            Commands.RegisterCommand("endrace",self.EndCommand,"/endrace: ends current race");
        }
    }

    function EndCommand()
    {
        Network.SendMessageAll("RaceEnd");
    }

    function StartCmd(cmd,args)
    {
        self._killsToWin = Convert.ToInt(args.Get(0));
        if (self._killsToWin == 0 || self._killsToWin <= 0) {self._killsToWin = 50;}
        if (!self._raceStarted && !self._prepStarted)
        {
            Network.SendMessage(Network.MasterClient, "RacePrep|" + self._killsToWin);
            Game.PrintAll("Player started a race to "+ self._killsToWin + " kills! Type /joinrace to join!");
            self.DelaySend(Network.MasterClient, "AddMeToRace");
        }
        else
        {
            Game.Print("Cant start race right now.");
        }
    }

    function OnNetworkMessage(sender,message,args)
    {
        rpc = args.Get(0);

        if (rpc == "RacePrepStarted")
        {
            KTW = Convert.ToInt(args.Get(1));
            self._killsToWin = KTW;
            self.RacePrep();
        }
        elif (rpc == "CurrentRacers")
        {
            dict = Json.LoadFromString(args.Get(1));

            self._trackPlayers = dict;
            text = "-Active Racers-" + String.Newline;
            for (pName in self._trackPlayers.Values)
            {
                text += pName + String.Newline; 
            }
            UI.SetLabel(UILabelEnum.MiddleLeft, text);
        }
        elif (rpc == "RaceStart")
        {
            self.LockRace();
        }
        elif (rpc == "RaceEnd")
        {
            Game.Print(sender.Name + " Has won the race in " + self._countUpTimer + " seconds!");
            UI.SetLabelActive("MiddleLeft", false);
            self.RaceEnd();
        }
        if (!Network.IsMasterClient) {return;}
        if (rpc == "RacePrep")
        {
            if (self._raceStarted) {return;}
            KTW = Convert.ToInt(args.Get(1));
            Network.SendMessageAll("RacePrepStarted|" + KTW);
        }
        elif (rpc == "AddMeToRace")
        {
            if (self._raceStarted) {return;}
            if (self._trackPlayers.Contains(Convert.ToString(sender.ID)))
            {
                self._trackPlayers.Remove(Convert.ToString(sender.ID));
            }
            self._trackPlayers.Set(Convert.ToString(sender.ID), sender.Name);
            text = "-Active Racers-" + String.Newline;
            for (pName in self._trackPlayers.Values)
            {
                text += pName + String.Newline; 
            }
            UI.SetLabel(UILabelEnum.MiddleLeft, text);
            Game.PrintAll(sender.Name + " Has joined the race!");
        }
    }

    function OnPlayerLeave(player)
    {
        if (self._trackPlayers.Contains(Convert.ToString(player.ID)))
        {
            self._trackPlayers.Remove(Convert.ToString(player.ID));
        }   
    }
    
    function OnSecond()
    {
        if (self._prepTimer > 0) {UI.SetLabelForTime(UILabelEnum.BottomCenter,"Race Starting In " + Convert.ToString(self._prepTimer) + String.Newline + String.Newline +String.Newline, 1.1); self._prepTimer -= 1;}
        elif (self._prepTimer <= 0 && self._prepStarted) {Network.SendMessageAll("RaceStart"); self._prepStarted = false;}
        elif (self._prepTimer <= 0 &&  self._raceStarted && self._trackPlayers.Contains(Convert.ToString(Network.MyPlayer.ID))) {UI.SetLabelForTime("MiddleRight", String.Newline + String.Newline + String.Newline + String.Newline + String.Newline + String.Newline + String.Newline + "Kills: " + Convert.ToString(self._trackedKills) + String.Newline + Convert.ToString(self._countUpTimer), 1.1);}

        if (self._raceStarted) {self._countUpTimer += 1;}

        if (!self._trackPlayers.Contains(Convert.ToString(Network.MyPlayer.ID))) {return;}
        if (self._trackedKills >= Convert.ToInt(self._killsToWin) && self._raceStarted)
        {
            Network.SendMessageAll("RaceEnd");
        }
    }

    function OnCharacterDie(victim,killer,killerName)
    {
        if (victim.Type == "Titan" && self._raceStarted && killer.Type == "Human" && killer.IsMainCharacter)
        {
            self._trackedKills += 1;
        }
    }

    function RacePrep()
    {
        self._prepStarted = true;
        self._prepTimer = 30;
    }

    coroutine LockRace()
    {
        if (Network.IsMasterClient) {Network.SendMessageAll("CurrentRacers|" + Json.SaveToString(self._trackPlayers));}
       /* if (self._trackPlayers.Count < 2) 
        {
            Game.Print("Not Enough Players For Race.");
            return;
        }*/
        wait 0.3;
        self.ApplyOutlines();
        self._raceStarted = true;
    }

    function RaceEnd()
    {
        self._raceStarted = false;
        self.RemoveOutlines();
        self._trackPlayers.Clear();
        self._trackedKills = 0;
        self._countUpTimer = 0;
    }

    function JoinCmd()
    {
        if (!self._raceStarted)
        {
            Network.SendMessage(Network.MasterClient, "AddMeToRace");
        }
        elif (self._raceStarted)
        {
            Game.Print("Race active, join the next one.");
            return;
        }
    }

    function ApplyOutlines()
    {
        for (player in Network.Players)
        {
            for (key in self._trackPlayers.Keys)
            {
                if (player.ID == Convert.ToInt(key))
                {
                    player.Character.AddOutline(Color("#ff67ff"), OutlineModeEnum.OutlineVisible);
                }
            }
        }
    }

    function RemoveOutlines()
    {
        for (player in Network.Players)
        {
            for (key in self._trackPlayers.Keys)
            {
                if (player.ID == Convert.ToInt(key))
                {
                    player.Character.RemoveOutline();
                }
            }
        }   
    }

    coroutine DelaySend(target,message)
    {
        wait 0.5;
        Network.SendMessage(target,message);
    }
}
extension DmgRace
{
    _raceStarted = false;
    _prepStarted = false;
    _prepTimer = 0;
    _trackedDmg = 0;
    _trackPlayers = Dict();
    _countUpTimer = 0;
    _dmgToWin = 0;
    function Init()
    {
        Commands.RegisterCommand("startdmg",self.StartCmd,"/startdmg [damage]: starts a race");
        Commands.RegisterCommand("joindmg",self.JoinCmd,"/joindm: joins a race");

        if (Network.IsMasterClient) {
            Commands.RegisterCommand("enddmg",self.EndCommand,"/enddmg: ends current race");
        }
    }

    function EndCommand()
    {
        Network.SendMessageAll("DmgRaceEnd");
    }

    function StartCmd(cmd,args)
    {
        self._dmgToWin = Convert.ToInt(args.Get(0));
        if (self._dmgToWin == 0 || self._dmgToWin <= 0) {self._dmgToWin = 50000;}
        if (!self._raceStarted && !self._prepStarted)
        {
            Network.SendMessage(Network.MasterClient, "DmgRacePrep|" + self._dmgToWin);
            Game.PrintAll("Player started a race to "+ self._dmgToWin + " Damage! Type /joindmg to join!");
            self.DelaySend(Network.MasterClient, "AddMeToDmgRace");
        }
        else
        {
            Game.Print("Cant start race right now.");
        }
    }

    function OnNetworkMessage(sender,message,args)
    {
        rpc = args.Get(0);

        if (rpc == "DmgRacePrepStarted")
        {
            KTW = Convert.ToInt(args.Get(1));
            self._dmgToWin = KTW;
            self.RacePrep();
        }
        elif (rpc == "CurrentDmgRacers")
        {
            dict = Json.LoadFromString(args.Get(1));

            self._trackPlayers = dict;
            text = "-Active Racers-" + String.Newline;
            for (pName in self._trackPlayers.Values)
            {
                text += pName + String.Newline; 
            }
            UI.SetLabel(UILabelEnum.MiddleLeft, text);
        }
        elif (rpc == "DmgRaceStart")
        {
            self.LockRace();
        }
        elif (rpc == "DmgRaceEnd")
        {
            Game.Print(sender.Name + " Has won the race in " + self._countUpTimer + " seconds!");
            UI.SetLabelActive("MiddleLeft", false);
            self.RaceEnd();
        }
        if (!Network.IsMasterClient) {return;}
        if (rpc == "DmgRacePrep")
        {
            if (self._raceStarted) {return;}
            KTW = Convert.ToInt(args.Get(1));
            Network.SendMessageAll("RacePrepStarted|" + KTW);
        }
        elif (rpc == "AddMeToDmgRace")
        {
            if (self._raceStarted) {return;}
            if (self._trackPlayers.Contains(Convert.ToString(sender.ID)))
            {
                self._trackPlayers.Remove(Convert.ToString(sender.ID));
            }
            self._trackPlayers.Set(Convert.ToString(sender.ID), sender.Name);
            text = "-Active Racers-" + String.Newline;
            for (pName in self._trackPlayers.Values)
            {
                text += pName + String.Newline; 
            }
            UI.SetLabel(UILabelEnum.MiddleLeft, text);
            Game.PrintAll(sender.Name + " Has joined the race!");
        }
    }

    function OnPlayerLeave(player)
    {
        if (self._trackPlayers.Contains(Convert.ToString(player.ID)))
        {
            self._trackPlayers.Remove(Convert.ToString(player.ID));
        }   
    }
    
    function OnSecond()
    {
        if (self._prepTimer > 0) {UI.SetLabelForTime(UILabelEnum.BottomCenter,"Race Starting In " + Convert.ToString(self._prepTimer) + String.Newline + String.Newline +String.Newline, 1.1); self._prepTimer -= 1;}
        elif (self._prepTimer <= 0 && self._prepStarted) {Network.SendMessageAll("DmgRaceStart"); self._prepStarted = false;}
        elif (self._prepTimer <= 0 &&  self._raceStarted && self._trackPlayers.Contains(Convert.ToString(Network.MyPlayer.ID))) {UI.SetLabelForTime("MiddleRight", String.Newline + String.Newline + String.Newline + String.Newline + String.Newline + String.Newline + String.Newline + "Dmg: " + Convert.ToString(self._trackedDmg) + String.Newline + Convert.ToString(self._countUpTimer), 1.1);}

        if (self._raceStarted) {self._countUpTimer += 1;}

        if (!self._trackPlayers.Contains(Convert.ToString(Network.MyPlayer.ID))) {return;}
        if (self._trackedDmg >= Convert.ToInt(self._dmgToWin) && self._raceStarted)
        {
            Network.SendMessageAll("DmgRaceEnd");
        }
    }

    function OnCharacterDamaged(victim,killer,killerName,damage)
    {
        if (victim.Type == "Titan" && victim.Health <= 0 && self._raceStarted && killer.Type == "Human" && killer.IsMainCharacter)
        {
            self._trackedDmg += damage;
        }
    }

    function RacePrep()
    {
        self._prepStarted = true;
        self._prepTimer = 30;
    }

    coroutine LockRace()
    {
        if (Network.IsMasterClient) {Network.SendMessageAll("CurrentDmgRacers|" + Json.SaveToString(self._trackPlayers));}
       /* if (self._trackPlayers.Count < 2) 
        {
            Game.Print("Not Enough Players For Race.");
            return;
        }*/
        wait 0.3;
        self.ApplyOutlines();
        self._raceStarted = true;
    }

    function RaceEnd()
    {
        self._raceStarted = false;
        self.RemoveOutlines();
        self._trackPlayers.Clear();
        self._trackedDmg = 0;
        self._countUpTimer = 0;
    }

    function JoinCmd()
    {
        if (!self._raceStarted)
        {
            Network.SendMessage(Network.MasterClient, "AddMeToDmgRace");
        }
        elif (self._raceStarted)
        {
            Game.Print("Race active, join the next one.");
            return;
        }
    }

    function ApplyOutlines()
    {
        for (player in Network.Players)
        {
            for (key in self._trackPlayers.Keys)
            {
                if (player.ID == Convert.ToInt(key))
                {
                    player.Character.AddOutline(Color("#ff67ff"), OutlineModeEnum.OutlineVisible);
                }
            }
        }
    }

    function RemoveOutlines()
    {
        for (player in Network.Players)
        {
            for (key in self._trackPlayers.Keys)
            {
                if (player.ID == Convert.ToInt(key))
                {
                    player.Character.RemoveOutline();
                }
            }
        }   
    }

    coroutine DelaySend(target,message)
    {
        wait 0.5;
        Network.SendMessage(target,message);
    }
}
extension StaminaBar
{
 /*@type VisualElement*/_container = null;

 _speed = null;

 _active = false;
 _barWidth = 500;

 _barColor = "#23d7f7";

 _stamina = 100;
 _staminaReductionRate = 10;
 _staminaRegenerationRate = 10;
 _isRegenerating = false;
 _isExpending = false;
 _displayPercent = 0.0;
 _targetPercent = 0.0;
 SmoothFactor = 2;

 function OnPlayerSpawn(player, character)
 {
    self._speed = character.Speed;
 }

 function OnFrame()
 {
    #@type Human
    char = Network.MyPlayer.Character;
    if ((Input.GetKeyDown(InputHumanEnum.AttackDefault) || Input.GetKeyDown(InputHumanEnum.AttackSpecial)) || Input.GetKeyDown(InputHumanEnum.ReelIn) && self._stamina > 0.0)
    {
       self.ReduceStamina(25);
       self._isRegenerating = false;
    }
    elif (self._stamina < 100 && (!Input.GetKeyDown(InputHumanEnum.AttackDefault) || !Input.GetKeyDown(InputHumanEnum.AttackSpecial)))
    {
       self.RegenStamina(self._staminaRegenerationRate);
       self._isExpending = false;
       Network.MyPlayer.Character.Speed = self._speed;
    }
 }

 function OnTick()
 {
    UI.SetLabelForTime("BottomCenter", "Stamina: " + Convert.ToInt(self._stamina) + String.Newline + String.Newline + String.Newline,0.1);

    if (self._stamina > 100)
    {
        self._stamina = 100;
    }

    if (self._stamina < 0)
    {
      self._stamina = 0;
    }
    
 }

 function ReduceStamina(amount)
 {
     if (self._stamina < 0.0) {return;}
     self._stamina -= amount;
     self._isRegenerating = false;
     self._isExpending = true;
 }   

 coroutine RegenStamina(amount)
 {
     wait 5;
     #if(self._isRegenerating) {return;}
     self._stamina += amount * Time.TickTime;
     self._isRegenerating = true;
     self._isExpending = false;
  }
}
extension DirectionalAttack
{

  function OnTick()
  {
    myCharacter = Network.MyPlayer.Character;
    if (myCharacter == null) {return;}
    myCharacter.Forward = Camera.Forward;

    if (myCharacter != null && (!myCharacter.Grounded || myCharacter.State == "Attack")){
      myCharacter.Forward = Camera.Forward;
    }
  }
}
extension GachaData
{
    FileName = "CamiGacha";
    PropName_Gacha = "PropCamiGacha";

    _allPlayersData = Dict();
    function LoadPlayerData(serverID)
    {
        allPlayerData = self._allPlayersData;

        if (!allPlayerData.Contains(serverID))
        {
            Game.Print("Does not contain players data");
            playerDataDict = Dict();

            playerDataDict.Set("Item", "_");
            allPlayerData.Set(serverID,playerDataDict); 
            return playerDataDict;
        }

        serializedPlayerData = allPlayerData.Get(serverID);

        return serializedPlayerData;
    }

    function LoadAllPlayersData() 
    {
        fileName = self.FileName;
        propName = self.PropName_Gacha;

        data = PData.LoadDataFromFile(fileName, propName, false, true);
        if(data == null) { return; }
        if(data.Count == 0) { return; }
        
        self._allPlayersData = data;
    }

    function LoadHostPlayerData(hostServerID)
    {
        hostData = self.LoadPlayerData(hostServerID);
       # Game.Print("HD" + hostData);
        
        item = hostData.Get("Item");
        #Game.Print("HA" + score);
    }

    function LoadClientPlayerData(serverID, player)
    {
        if(!Network.IsMasterClient) { return; }
        if(serverID == null) {
            Game.Print(player.Name + " ServerID is null");
            return;
        }
 
        playerDataDict = self.LoadPlayerData(serverID);
        playerItems = playerDataDict.Get("Item");
        
        if(playerItems == null) { Game.Print("Score is null " + player.Name); return; }
        Network.SendMessage(player, "SyncData|" + playerItems);
    }

    function SaveItem(item, serverID)
    {
        if(!Network.IsMasterClient) { return; }
        if (item == null) {Game.Print("Item null at save"); return;}

        fileName = self.FileName;
        propName = self.PropName_Gacha;

        senderData = self.LoadPlayerData(serverID);
        if(senderData == null) { Game.Print("SenderData is null"); return; }
        prevItem = senderData.Get("Item");
        if (prevItem != null)
        {
            splitB4 = String.Split(prevItem, "_", true);
            if (splitB4.Contains(item))
            {
                return;
            }
        }
        /*if (!Interface.MainInventory._items.Contains(item)){
            Game.Print("dooesnt contains");
            return;
        }*/
        senderData.Set("Item", item + "_" + prevItem);
        self._allPlayersData.Set(serverID, senderData);

        PData.SaveToFile(fileName, propName, self._allPlayersData, false, true);
        #Game.Print("Item saved");
    }

    function RemoveItemS(itemName, serverID)
    {
        if (itemName == null) {return;}

        fileName = self.FileName;
        propName = self.PropName_Gacha;

        senderData = self.LoadPlayerData(serverID);
        if(senderData == null) { Game.Print("SenderData is null"); return; }
        prevItem = senderData.Get("Item");
        if (prevItem != null)
        {
            splitB4 = String.Split(prevItem, "_", true);
            if (splitB4.Contains(itemName))
            {
                splitB4.Remove(itemName);
            }
        }
        if (!Interface.MainInventory._items.Contains(itemName)){
            return;
        }
        joined = String.Join(splitB4, "_");
        senderData.Set("Item", joined);
        self._allPlayersData.Set(serverID, senderData);

        PData.SaveToFile(fileName, propName, self._allPlayersData, false, true);
    }

    function LoadMyData(id)
    {
        if (!PersistentData.FileExists(self.FileName) && Network.IsMasterClient)
        {
            PData.SaveToFile(self.FileName, self.PropName_Gacha, self._allPlayersData, false, true);
            Game.Print("File created");
            return;
        }

        if (!Network.IsMasterClient) {Network.SendMessage(Network.MasterClient, "LoadMyGacha|" + id); /*Game.Print("Sent");*/ return;}
        data = PData.LoadDataFromFile(self.FileName, self.PropName_Gacha, false, true);   

        if (data == null) {Game.Print("Gacha Data null"); return;}
        ServID = ServerID._playerServerIDs.Get(id);
        itemData = data.Get(ServID);
        if (itemData == null) {/*Game.Print("Item data null");*/ return;}
        final = itemData.Get("Item");
        Network.SendMessage(Network.FindPlayer(id), "YourGachaData|" + Json.SaveToString(final));
    }

    coroutine LoadItemToInv(data)
    {
        Comp = Map.FindMapObjectByComponent("Gacha").GetComponent("Gacha");
        itemNames = String.Split(data, "_", true);
        for (i in Range(0,itemNames.Count,1))
        {
            itemName = itemNames.Get(i);
            iteM = Comp._items.Get(itemName);
            Interface.MainInventory.AddItem(iteM);
            wait 0.1;
        }
    }
}
extension CardTrading
{
    function Init()
    {
        Commands.RegisterCommand("trade",self.TradeCmd,"/trade [playerID] [card name]");
    }

    function OnNetworkMessage(sender,message,args)
    {
        rpc = args.Get(0);

        if (rpc == "TradedCard")
        {
            cardName = args.Get(1);

            Game.Print(sender.Name + " has given you " + cardName);
            GachaItem = Interface.Gacha._items.Get(cardName);
            Interface.MainInventory.AddItem(GachaItem);

            Network.SendMessage(Network.MasterClient, "SaveItem|" + cardName);
        }
        if (!Network.IsMasterClient) {return;}
        senderServerID = ServerID._playerServerIDs.Get(sender.ID);
        if(senderServerID == null || senderServerID == "" || String.Length(senderServerID) < 32) { Game.Debug("ID Null"); return; }
        if (rpc == "SaveItems")
        {
            itemName = args.Get(1);

            data = GachaData._allPlayersData.Get(senderServerID);
            split = String.Split(data.Get("Item"),"_",true);

            if (split.Contains(itemName))
            {
                split.Remove(itemName);
            }
            else
            {
                Game.Print("Doesnt contain item");
                return;
            }
            GachaData.RemoveItemS(itemName, senderServerID);
        }
    }

    function TradeCmd(cmd,args)
    {
        pID = Convert.ToInt(args.Get(0));
        if (args.Count == 3)
        {
            cardName1 = Convert.ToString(args.Get(1));
            cardName2 = Convert.ToString(args.Get(2));

            cardName = cardName1 + " " + cardName2;
        } 
        elif (args.Count == 4)
        {
            cardName1 = Convert.ToString(args.Get(1));
            cardName2 = Convert.ToString(args.Get(2));
            cardName3 = Convert.ToString(args.Get(3));

            cardName = cardName1 + " " + cardName2 + " " + cardName3;
        }
        else
        {
            cardName = Convert.ToString(args.Get(1));
        }

        if (!Interface.MainInventory._items.Contains(cardName))
        {
            Game.Print("You dont own that card");
            return;
        }

        player = Network.FindPlayer(pID);
        Network.SendMessage(player, "TradedCard|" + cardName);
        #@type GachaItem
        item = Interface.Gacha._items.Get(cardName);
        Game.Print("Gave " + player.Name + " " + cardName);
        Interface.MainInventory.RemoveItem(item);
        Interface.MainInventory._items.Remove(cardName);

        Network.SendMessage(Network.MasterClient, "SaveItems|" + cardName);
    }
}
extension HandleBakery
{
    _nearIngredients = false;
    _nearKneading = false;
    _isKneading = false;
    _hasKneaded = false;
    _nearMixing = false;
    _isMixing = false;
    _hasMixed = false;
    _nearWater = false;
    _nearProof = false;
    _hasProofed = false;
    _nearOven = false;
    _hasCocked = false;
    _nearRegister = false;

    _cookCookies = false;
    _cookBreak = false;

    _playAnim = false;

    #@type Dict<string,BakeryItem>
    _items = Dict();

    function Init()
    {
        self._items.Set("Water", BakeryItem("Water",0));
        self._items.Set("Ingredients", BakeryItem("Ingredients",0));
        self._items.Set("Raw Dough", BakeryItem("Raw Dough",0));
        self._items.Set("Kneaded Dough", BakeryItem("Kneaded Dough",0));
        self._items.Set("Proofed Dough", BakeryItem("Proofed Dough",0));
        self._items.Set("Cookies", BakeryItem("Cookies",0));

        self.CreatePopups();
    }

    function CreatePopups()
    {
        UI.CreatePopup("BakeryMenu", "Bakery Menu", 700, 800);
    }

    function SetMenuContent()
    {
        nl = String.Newline;
        waters = self._items.Get("Water").Count;
        ings = self._items.Get("Ingredients").Count;
        Rdoughs = self._items.Get("Raw Dough").Count;
        Kdoughs = self._items.Get("Kneaded Dough").Count;
        Pdoughs = self._items.Get("Proofed Dough").Count;
        cookies = self._items.Get("Cookies").Count;

        text = UI.WrapStyleTag(Sprites.NPC2, "size", "4") + nl + nl;

        
        text += "<color=#fd8d8d>Ingredient</color> Count: " + ings + nl + nl;
        text += "<color=#4dafff>Water</color> Count: " + waters + nl + nl;
        text += "<color=#fff78b>Raw Dough</color> Count: " + Rdoughs + nl + nl;
        text += "<color=#b0ff8b>Kneaded Dough</color> Count: " + Kdoughs + nl + nl;
        text += "<color=#51ff01>Proofed Dough</color> Count: " + Pdoughs + nl + nl;
        text += "<color=#a17922>Cookie</color> Count: " + cookies + nl + nl;

        UI.AddPopupLabel("BakeryMenu", text);
    }

    function RefreshMenu()
    {
        UI.HidePopup("BakeryMenu");
        UI.ClearPopup("BakeryMenu");
        self.SetMenuContent();
        UI.ShowPopup("BakeryMenu");
    }

    function OnFrame()
    {
        waters = self._items.Get("Water").Count;
        ingredients = self._items.Get("Ingredients").Count;
        Rdoughs = self._items.Get("Raw Dough").Count;
        Kdoughs = self._items.Get("Kneaded Dough").Count;
        Pdoughs = self._items.Get("Proofed Dough").Count;
        cookies = self._items.Get("Cookies").Count;
        if (Input.GetKeyDown("Interaction/QuickSelect8"))
        {
            UI.ClearPopup("BakeryMenu");
            self.SetMenuContent();
            UI.ShowPopup("BakeryMenu");
        }

        if (self._nearMixing && waters > 0 && ingredients > 0 && Input.GetKeyDown("Interaction/Function1"))
        {
            Game.Print("<color=#09db2c>Mixing</color>");
            self.RemoveItem(self._items.Get("Water"));
            self.RemoveItem(self._items.Get("Ingredients"));

            self.Mix();
        }
        elif (self._nearMixing && waters <= 0 && ingredients > 0 && Input.GetKeyDown("Interaction/Function1"))
        {
            Game.Print("You have no waters!!");
            return;
        }
        elif (self._nearMixing && waters > 0 && ingredients <= 0 && Input.GetKeyDown("Interaction/Function1"))
        {
            Game.Print("You have no ingredients!!");
            return;   
        }
        elif(self._nearMixing && waters <= 0 && ingredients <= 0 && Input.GetKeyDown("Interaction/Function1"))
        {
            Game.Print("You have no ingredients or water!!");
            return; 
        }
        if (self._nearKneading && Rdoughs > 0 && Input.GetKeyDown("Interaction/Function1"))
        {
            Game.Print("<color=#09db2c>Kneading</color>");
            self.RemoveItem(self._items.Get("Raw Dough"));

            self.Knead();
        }
        elif (self._nearKneading && Rdoughs <= 0 && Input.GetKeyDown("Interaction/Function1"))
        {
            Game.Print("You have no raw dough!!");
            return;
        }
        if (self._nearProof && Kdoughs > 0 && Input.GetKeyDown("Interaction/Function1"))
        {
            Game.Print("<color=#09db2c>Proofing</color>");
            self.RemoveItem(self._items.Get("Kneaded Dough"));

            self.Proof();
        }
        elif (self._nearProof && Kdoughs <= 0 && Input.GetKeyDown("Interaction/Function1"))
        {
            Game.Print("You have no kneaded dough!!");
            return;
        }
        if (self._nearOven && Pdoughs > 0 && Input.GetKeyDown("Interaction/Function1"))
        {
            Game.Print("<color=#09db2c>Baking</color>");
            self.RemoveItem(self._items.Get("Proofed Dough"));

            self.Cook();
        }
        elif (self._nearOven && Pdoughs <= 0 && Input.GetKeyDown("Interaction/Function1"))
        {
            Game.Print("You have no proofed dough!!");
            return;
        }
        if (self._nearRegister && cookies > 0 && Input.GetKeyDown("Interaction/Function1"))
        {
            Game.Print("<color=#ffec3d>Sold Cookie! </color>+50 Coins!");

            self.Sell();
        }
        elif (self._nearRegister && cookies <= 0 && Input.GetKeyDown("Interaction/Function1"))
        {
            Game.Print("You have no cookies to sell!!");
            return;
        }
        
        
    }

    function OnTick()
    {
        if (self._playAnim)
        {
            self.AnimLoop();
        }
    }

    function OnNetworkMessage(sender,message,args)
    {
        rpc = args.Get(0);

        if (rpc == "NearKneading")
        {
            self._nearKneading = true;
        }
        elif (rpc == "OffKneading")
        {
            self._nearKneading = false;
        }
        elif (rpc == "NearMixing")
        {
            self._nearMixing = true;
        }
        elif (rpc == "OffMixing")
        {
            self._nearMixing = false;
        }  
        elif (rpc == "NearProof")
        {
            self._nearProof = true;
        }
        elif (rpc == "OffProof")
        {
            self._nearProof = false;
        }  
        elif (rpc == "NearOven")
        {
            self._nearOven = true;
        }
        elif (rpc == "OffOven")
        {
            self._nearOven = false;
        }
        elif (rpc == "NearRegister")
        {
            self._nearRegister = true;
        }
        elif (rpc == "OffRegister")
        {
            self._nearRegister = false;
        }
        
    }

    function Sell()
    {
        if (self._nearRegister)
        {
            self.RemoveItem(self._items.Get("Cookies"));
            Main.Coins += 200;
        }
    }

    coroutine Mix()
    {
        if (self._nearMixing)
        {
            self._playAnim = true;
            wait 5;
            Game.Print("<color=#90fa66>Mixing Done</color>");
            self.AddItem(self._items.Get("Raw Dough"));
            self._hasMixed = true;
            self._playAnim = false;
        }
    }

    coroutine Knead()
    {
        if (self._nearKneading)
        {
            self._playAnim = true;
            wait 5;
            Game.Print("<color=#90fa66>Kneading Done</color>");
            self.AddItem(self._items.Get("Kneaded Dough"));
            self._hasKneaded = true;
            self._playAnim = false;
        }  
    }

    coroutine Proof()
    {
        if (self._nearProof)
        {
            self._playAnim = true;
            wait 0.5;
            self._playAnim = false;
            wait 19.5;
            Game.Print("<color=#90fa66>Proofing Done</color>");
            self.AddItem(self._items.Get("Proofed Dough"));
            self._hasProofed = true;
        }
        
    }

    coroutine Cook()
    {
        if (self._nearOven)
        {
            self._playAnim = true;
            wait 0.5;
            self._playAnim = false;
            wait 19.5;
            Game.Print("<color=#90fa66>Baking Done</color>");
            self.AddItem(self._items.Get("Cookies"));
            self._hasCocked = true;
        }
        
    }

    #@param BakeryItem BakeryItem
    function AddItem(BakeryItem)
    {
        if (self._items.Contains(BakeryItem.Name))
        {
            item = self._items.Get(BakeryItem.Name);
            item.Count += 1;
            return;
        }
        
        self._items.Set(BakeryItem.Name, BakeryItem);
    }

    #@param BakeryItem BakeryItem
    function RemoveItem(BakeryItem)
    {
        if (self._items.Contains(BakeryItem.Name))
        {
            item = self._items.Get(BakeryItem.Name);
            item.Count -= 1;
            return;
        }
    }

    coroutine AnimLoop()
    {
        animLength = Network.MyPlayer.Character.GetAnimationLength(HumanAnimationEnum.TSShootL);

        i = 0;
        while (i < 1)
        {
            Network.MyPlayer.Character.ForceAnimation(HumanAnimationEnum.TSShootL);
            wait animLength;
            i += 1;
        }
    }
}
class BakeryItem
{
    Name = null;
    Count = 0;

    function Init(Name, Count)
    {
        self.Name = Name;
        self.Count = Count;
    }
}
extension Data
{
    Grape = "{\n\"Sex\" : 1,\n\"Eye\" : 22,\n\"Face\" : \"FaceNone\",\n\"Glass\" : \"GlassNone\",\n\"Hair\" : \"HairF8\",\n\"Costume\" : 7,\n\"Boots\" : 0,\n\"Cape\" : 1,\n\"Logo\" : 0,\n\"Hat\" : \"HatNone\",\n\"Head\" : \"HeadNone\",\n\"Back\" : \"BackNone\",\n\"SkinColor\" : [\n255,\n220,\n196,\n255\n],\n\"HairColor\" : [\n128,\n128,\n128,\n255\n],\n\"ShirtColor\" : [\n255,\n255,\n255,\n255\n],\n
    \"StrapsColor\" : [\n98,\n81,\n65,\n255\n],\n\"PantsColor\" : [\n255,\n255,\n255,\n255\n],\n
    \"JacketColor\" : [\n183,\n144,\n107,\n255\n],\n\"BootsColor\" : [\n49,\n36,\n33,\n255\n],\n\"HairEffect\" : \"None\",\n\"HairEffectColor\" : [\n0,\n255,\n255,\n255\n],\n\"BladeEffect\" : \"None\",\n\"BladeEffectColor\" : [\n0,\n255,\n255,\n255\n],\n\"Stats\" : \"{\"Speed\":\"80\",\"Gas\":\"80\",\"Ammunition\":\"80\",\"Acceleration\":\"80\",\"Perks\":{}}\",\n\"SkinHair\" : \"https://i.ibb.co/Pv009RBY/grapehair.jpg\",\n\"SkinEye\" : \"\",\n\"SkinGlass\" : \"\",\n\"SkinFace\" : \"\",\n\"SkinSkin\" : \"https://i.ibb.co/Mys220m0/grapeskin.png\",\n\"SkinCostume\" : \"\",\n\"SkinLogo\" : \"https://i.ibb.co/MmttKKR/grapecape.png\",\n\"SkinGearL\" : \"https://i.ibb.co/BKPmHj4F/grapegear.png\",\n\"SkinGearR\" : \"https://i.ibb.co/BKPmHj4F/grapegear.png\",\n\"SkinGas\" : \"\",\n\"SkinHoodie\" : \"\"\n,\"SkinWeaponTrail\" : \"\",\n\"SkinHorse\" : \"\",\n\"SkinThunderspearL\" : \"\",\n\"SkinThunderspearR\" : \"\",\n\"SkinHookL\" : \"\",\n\"SkinHookLTiling\" : 1,\n\"SkinHookR\" : \"\",\n\"SkinHookRTiling\" : 1,\n\"SkinHat\" : \"\",\n\"SkinHead\" : \"\",\n\"SkinBack\" : \"\",\n\"Name\" : \"Grape\",\n\"Preset\" : false,\n\"UniqueId\" : \"2e5ae0f4-7177-4845-bb2b-3b34c35a568e\"\n}";

}
