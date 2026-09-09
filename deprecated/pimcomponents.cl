component TVZone
{
    function OnCollisionEnter(obj)
    {
        if (obj.Type == "Human" && obj.IsMainCharacter) {
            Network.SendMessage(obj.Player, "NearTV");
        }
    } 

    function OnCollisionExit(obj)
    {
        if (obj.Type == "Human" && obj.IsMainCharacter) {
            Network.SendMessage(obj.Player, "OffTV");
        }
    } 
}
component Register
{
    _collidingHuman = null;
    function OnCollisionStay(obj)
    {
        if (obj.Type == "Human" && obj.IsMainCharacter)
        {
            UI.SetLabelForTime("MiddleCenter", "Press F1 To Sell Cookies.", 0.2);
            self._collidingHuman = obj;
        }
    }


    function OnCollisionEnter(obj)
    {
        if (obj.Type == "Human" && obj.IsMainCharacter)
        {
            Network.SendMessage(obj.Player, "NearRegister");
        }
    }
    function OnCollisionExit(obj)
    {
        if (obj.Type == "Human" && obj.IsMainCharacter)
        {
            Network.SendMessage(obj.Player, "OffRegister");
        }
    }  

    function OnTick()
    {
        self._collidingHuman = null;
    }    
}
component Oven
{
    _collidingHuman = null;
    function OnCollisionStay(obj)
    {
        if (obj.Type == "Human" && obj.IsMainCharacter)
        {
            UI.SetLabelForTime("MiddleCenter", "Press F1 To Bake.", 0.2);
            self._collidingHuman = obj;
        }
        
    }

    function OnCollisionEnter(obj)
    {
        if (obj.Type == "Human" && obj.IsMainCharacter)
        {
            Network.SendMessage(obj.Player, "NearOven");
        }
    }
    function OnCollisionExit(obj)
    {
        if (obj.Type == "Human" && obj.IsMainCharacter)
        {
            Network.SendMessage(obj.Player, "OffOven");
        }
    }  

    function OnTick()
    {
        self._collidingHuman = null;
    }    
}
component ProofZone
{
    _collidingHuman = null;
    function OnCollisionStay(obj)
    {
        if (obj.Type == "Human" && obj.IsMainCharacter)
        {
            UI.SetLabelForTime("MiddleCenter", "Press F1 To Proof.", 0.2);
            self._collidingHuman = obj;
        }
        
    }

    function OnCollisionEnter(obj)
    {
        if (obj.Type == "Human" && obj.IsMainCharacter)
        {
            Network.SendMessage(obj.Player, "NearProof");
        }
    }
    function OnCollisionExit(obj)
    {
        if (obj.Type == "Human" && obj.IsMainCharacter)
        {
            Network.SendMessage(obj.Player, "OffProof");
        }
    }   
    
    function OnTick()
    {
        self._collidingHuman = null;
    }    
}
component IngredientZone
{
    _collidingHuman = null;
    function OnCollisionStay(obj)
    {
        if (obj.Type == "Human" && obj.IsMainCharacter)
        {
            UI.SetLabelForTime("MiddleCenter", "Press F1 To gather ingredients.", 0.2);
            self._collidingHuman = obj;
        }
        
    }

    function OnFrame()
    {
        if (self._collidingHuman != null)
        {
            if (Input.GetKeyDown("Interaction/Function1"))
            {
                newItem = BakeryItem("Ingredients", 1);
                HandleBakery.AddItem(newItem);
                Game.Print("+1 Ingredient");
            }   
        }
    }

    function OnTick()
    {
        self._collidingHuman = null;
    }
}
component WaterZone
{
    _collidingHuman = null;
    function OnCollisionStay(obj)
    {
        if (obj.Type == "Human" && obj.IsMainCharacter)
        {
            UI.SetLabelForTime("MiddleCenter", "Press F1 To gather water.", 0.2);
            self._collidingHuman = obj;
        }
        
    }

    function OnFrame()
    {
        if (self._collidingHuman != null)
        {
            if (Input.GetKeyDown("Interaction/Function1"))
            {
                newItem = BakeryItem("Water", 1);
                HandleBakery.AddItem(newItem);
                Game.Print("+1 Water");
            }
        }
        
    }

    function OnTick()
    {
        self._collidingHuman = null;
    }    
}
component MixingZone
{
    _collidingHuman = null;
    function OnCollisionStay(obj)
    {
        if (obj.Type == "Human" && obj.IsMainCharacter)
        {
            UI.SetLabelForTime("MiddleCenter", "Press F1 To Mix.", 0.2);
            self._collidingHuman = obj;
        }
        
    }

    function OnCollisionEnter(obj)
    {
        if (obj.Type == "Human" && obj.IsMainCharacter)
        {
            Network.SendMessage(obj.Player, "NearMixing");
        }
    }
    function OnCollisionExit(obj)
    {
        if (obj.Type == "Human" && obj.IsMainCharacter)
        {
            Network.SendMessage(obj.Player, "OffMixing");
        }
    }     

    function OnTick()
    {
        self._collidingHuman = null;
    }    
}
component KneadingZone
{
    _collidingHuman = null;
    function OnCollisionStay(obj)
    {
        if (obj.Type == "Human" && obj.IsMainCharacter)
        {
            UI.SetLabelForTime("MiddleCenter", "Press F1 To Knead.", 0.2);
            self._collidingHuman = obj;
        }
        
    }

    function OnCollisionEnter(obj)
    {
        if (obj.Type == "Human" && obj.IsMainCharacter)
        {
            Network.SendMessage(obj.Player, "NearKneading");
        }
    }
    function OnCollisionExit(obj)
    {
        if (obj.Type == "Human" && obj.IsMainCharacter)
        {
            Network.SendMessage(obj.Player, "OffKneading");
        }
    }   

    function OnTick()
    {
        self._collidingHuman = null;
    }    
}
component FistFight
{
  #fist fight
  DmgMultiplier = 1.3;
  SpawnOnEnter = true;
  _cooldown = false;
  _speed = null;
  _directionalAttackEnabled = false;
  _enabled = false;

  _human = null;
  #@param obj Human
  function OnCollisionStay(obj)
  {
    if (obj.Type == "Human" && obj.IsMainCharacter)
    {
        self._human = obj;
        character = obj;

        Input.SetKeyDefaultEnabled(InputHumanEnum.AttackDefault, false);
        if (character != null && character.Type == "Human")
        {
            StaminaBar.OnPlayerSpawn(obj.Player, character);
            character.CurrentBladeDurability = 0;
            character.CurrentBlade = 0;  
            character.Speed = 70;
            character.MaxGas = 0;
            character.CurrentGas = 0;
            self._speed = Network.MyPlayer.Character.Speed;
            Network.MyPlayer.Character.SetSpecial("None");
        }  
    }
  }

  function OnCollisionExit(obj)
  {
    Input.SetKeyDefaultEnabled(InputHumanEnum.AttackDefault, true);
  }

  function OnCharacterDamaged(victim, killer, killerName, damage)
  {
      if (victim.Type == "Human")
      {
          victim.PlaySound(HumanSoundEnum.CrashLand);
          if (victim == null) {return;}
          Game.SpawnEffect(EffectNameEnum.Blood1, victim.Position, Vector3.Zero, 1);
      }
  }

  function OnFrame()
  {
    if (self._human == null) {return;}
      StaminaBar.OnFrame();
      char = Network.MyPlayer.Character;

      if (char == null) {return;}
      if (StaminaBar._stamina <= 0) {return;}  
      if (Input.GetKeyDown(InputHumanEnum.AttackDefault) && !self._cooldown)
      {
          self.AttackLeft();
          self.Cooldown();
      }
      elif (Input.GetKeyDown(InputHumanEnum.AttackSpecial) && !self._cooldown)
      {
          self.AttackRight();
          self.Cooldown();
      }   
      elif (Input.GetKeyDown(InputInteractionEnum.Interact))
      {
          self.Dodge();
      }
      elif (Input.GetKeyDown(InputInteractionEnum.Function4))
      {
            if (!self._enabled)
            {
                self._directionalAttackEnabled = true;
                self._enabled = true;
            }
            else
            {
                self._directionalAttackEnabled = false;
                self._enabled = false;
            }
      }
      
      if (char.IsPlayingAnimation(HumanAnimationEnum.Dodge)) {return;}
      if (Input.GetKeyDown(InputHumanEnum.Dodge))
      {
           self.SetSpeed();
      }
      
  }

  coroutine SetSpeed()
  {
       animLength = Network.MyPlayer.Character.GetAnimationLength(HumanAnimationEnum.Dodge);
       Network.MyPlayer.Character.Speed = 50;
       wait animLength;
       Network.MyPlayer.Character.Speed = self._speed;
  }

  function OnSecond()
  {
    if (self._human == null) {return;}
  }

  function OnTick()
  {
    if (self._human == null) {return;}
      self._human = null;
      StaminaBar.OnTick();
      if (self._directionalAttackEnabled) {DirectionalAttack.OnTick();}
  }

  coroutine AttackLeft()
  {
      self._cooldown = true;
      char = Network.MyPlayer.Character;
      if (char == null) {return;}
      if (char.IsPlayingAnimation("Armature|TS_shoot_L")) {return;}
      for (human in Game.Humans)
      {
          self.CheckForHit(human);
      }
      char.ForceAnimation("Armature|TS_shoot_L", 0.3);
  }

  function AttackRight()
  {
      self._cooldown = true;
      char = Network.MyPlayer.Character;
      if (char == null) {return;}
      if (char.IsPlayingAnimation("Armature|TS_shoot_R")) {return;}
      for (human in Game.Humans)
      {
          if (human == null) {return;}
          self.CheckForHitR(human);
      }

      char.ForceAnimation("Armature|TS_shoot_R",0.3);
      if (!char.Grounded) {return;}
      char.AddForce(char.Forward * 20, ForceModeEnum.Impulse);
  }

  function Dodge()
  {
      #self._cooldown = true;
      #@type Human
      char = Network.MyPlayer.Character;

      char.ForceAnimation(HumanAnimationEnum.Air2Backward);
  }

  coroutine CheckForHit(char)
  {
      if (char == null) {return;}
      _gotDamaged = false;

      wait 0.1;
      for (i in Range(0,6,1))
      {
          if (!_gotDamaged)
          {
              # Calculate the direction vector from the character to the char
              directionToChar = char.Position - Network.MyPlayer.Character.Position;
              directionToChar = directionToChar.Normalized;  # Normalize to only get direction, not magnitude

              # Check if the char is within a certain angle threshold from the target direction
              angleThreshold = 180.0;  # Angle threshold (e.g., 45 degrees)
              angle = Vector3.Angle(Network.MyPlayer.Character.TargetDirection, directionToChar);
              charSpeed = Network.MyPlayer.Character.Velocity.Magnitude;
              dmg = charSpeed * self.DmgMultiplier;

              randomDmg = Random.RandomInt(2, 20);

              dmg = randomDmg;
              if (angle <= angleThreshold && Vector3.Distance(char.Position, Network.MyPlayer.Character.Position) <= 2)
              {
                  if (!char.IsAI)
                  {
                      if (char.Player != Network.MyPlayer)
                      {
                          char.GetDamaged(Network.MyPlayer.Name, dmg);
                          _gotDamaged = true;
                      }
                  }
              }
          }
          wait 0.1;
      }
  }
  coroutine CheckForHitR(char)
  {
      if (char == null) {return;}
      _gotDamaged = false;

      wait 0.1;
      for (i in Range(0,6,1))
      {
          if (!_gotDamaged)
          {
              # Calculate the direction vector from the character to the char
              directionToChar = char.Position - Network.MyPlayer.Character.Position;
              directionToChar = directionToChar.Normalized;  # Normalize to only get direction, not magnitude

              # Check if the char is within a certain angle threshold from the target direction
              angleThreshold = 180.0;  # Angle threshold (e.g., 45 degrees)
              angle = Vector3.Angle(Network.MyPlayer.Character.TargetDirection, directionToChar);
              charSpeed = Network.MyPlayer.Character.Velocity.Magnitude;
              dmg = charSpeed * self.DmgMultiplier;

              randomDmg = Random.RandomInt(7, 30);

              dmg = randomDmg;
              if (angle <= angleThreshold && Vector3.Distance(char.Position, Network.MyPlayer.Character.Position) <= 3.4)
              {
                  if (!char.IsAI)
                  {
                      if (char.Player != Network.MyPlayer)
                      {
                          char.GetDamaged(Network.MyPlayer.Name, dmg);
                          _gotDamaged = true;
                      }
                  }
              }
          }
          wait 0.1;
      }
  }
  coroutine Cooldown()
  {
      wait 0.4;
      self._cooldown = false;
  }
}
component Guillotine
{
    Description = "Needs Static OFF and Networked ON!";

    killerName = "Guillotine";
    damage = 1000;

    RelativePositions = true;
    StartPosition = Vector3(0, 0, 0);
    EndPosition = Vector3(0, 0, 0);
    Speed = 25.0;
    ReturningSpeed = 5.0;
    _currentProgress = 0.0;
    _backwards = false;
    _step = 0.0;
    _returningStep = 0.0;

    _state = "ready";

    function OnNetworkMessage(sender, message)
    {
        if (message == "request" && Network.IsMasterClient)
        {                
            if(self._state == "ready")
            {
                self.NetworkView.SendMessageAll("drop");
            }
        }
        if (message == "drop" && sender == Network.MasterClient)
        {
            self._state = "in use";
        }
    }

    function Init()
    {
        if (self.RelativePositions)
        {
            self.StartPosition = self.MapObject.Position + self.StartPosition;
            self.EndPosition = self.MapObject.Position + self.EndPosition;
        }

        distance = Vector3.Distance(self.StartPosition, self.EndPosition);
        self._step = 1.0;
        self._returningStep = 1.0;
        if (distance > 0)
        {
            self._step = self.Speed / distance;
            self._returningStep = self.ReturningSpeed / distance;
        }
    }

    function OnFrame()
    {
        if (self._state == "ready")
        {
            return;
        }
        if (self._backwards)
        {
            self._currentProgress = self._currentProgress - Time.FrameTime * self._returningStep;
            if (self._currentProgress <= 0.0)
            {
                self._currentProgress = 0.0;
                self._backwards = false;
                self._state = "ready";
            }
            self.MapObject.Position = Vector3.Lerp(self.StartPosition, self.EndPosition, self._currentProgress);
        }
        else
        {
            self._currentProgress = self._currentProgress + Time.FrameTime * self._step;
            if (self._currentProgress >= 1.0)
            {
                self._currentProgress = 1.0;
                self._backwards = true;
            }
            self.MapObject.Position = Vector3.Lerp(self.StartPosition, self.EndPosition, self._currentProgress);
        }
    }

    function OnCollisionEnter(obj)
    {
        if(obj.IsCharacter && obj.IsMainCharacter)
        {
            obj.GetDamaged(self.killerName, self.damage);
        }
    }

    function Activate()
    {
        self.NetworkView.SendMessage(Network.MasterClient, "request");
    }
}
component GuillotineButton
{
    GuillotineId = "";
    ObjectToActivateTooltip = "Guillotine Object ID";

    cooldown = 1.0;
    buttonText = "";
    key = "Interaction/Interact";

    _timer = 1.0;
    _isInteracting = false;
    _guillotine = null;

    function Init()
    {
        id = Convert.ToInt(self.GuillotineId);
        obj = Map.FindMapObjectByID(id);
        self._guillotine = obj.GetComponent("Guillotine");
    }

    function OnCollisionStay(obj)
    {
        if(obj.IsCharacter && obj.IsMainCharacter)
        {
            self._isInteracting = true;
        }
    }
    function OnTick()
    {
        if(self._isInteracting)
        {
            UI.SetLabelForTime("MiddleCenter", "<color=orange>[" + Input.GetKeyName(self.key) + "]</color> " + self.buttonText, 0.3);
        }
        self._isInteracting = false;
    }
    function OnFrame()
    {
        if(Input.GetKeyDown(self.key) && self._isInteracting)
        {
            self._guillotine.Activate();
        }
    }
}
component Slots
{
    #Slot Machine
    
    ## Configuration
    SlotSize = 120;
    SlotSpacing = 15;
    SpinDuration = 3.0;
    RandomSpinDuration = false;
    
    _slotBackgroundOpacity = 200;
    
    _root = null;
    _mainContainer = null;
    _slotContainer = null;
    _slots = null;
    _slotLabels = null;
    
    _symbols = List();
    _isSpinning = false;
    _isActive = false;
    _uiBuilt = false;

    _collidingHuman = null;

    _coins = 0;
    _sound = null;

    function OnGameStart()
    {
        self._slots = List();
        self._slotLabels = List();
        
        self._symbols.Add("#");
        self._symbols.Add("$");
        self._symbols.Add("7");
        self._symbols.Add("⚠");
        self._symbols.Add("meow");
        self._symbols.Add("❤︎");
        self._symbols.Add("-`♡´-");
        self._symbols.Add("★");

        self._isSpinning = false;
        self._isActive = false;
        self._uiBuilt = false;
        
        self._sound = Map.FindMapObjectByName("slotssound");
    }

    function OnCollisionStay(obj)
    {
        if (obj.Type == "Human" && obj.IsMainCharacter)
        {
            self._collidingHuman = obj;
            if (!self._isActive)
            {
                UI.SetLabelForTime("MiddleCenter", "Press F1 to open slots", 0.1);   
            }
        }
        
    }

    function OnFrame()
    {
        if (self._collidingHuman != null)
        {
            f1 = Input.GetKeyDown("Interaction/Function1");
            if (!self._isActive && f1)
            {
                self.ShowUI();
            }
            elif (self._isActive && f1)
            {
                self.HideUI();
            }
            
            
        }
        
    }

    function OnTick()
    {
        self._collidingHuman = null;
    }

    function SetupSlotMachine()
    {
        if(self.RandomSpinDuration) { self.SpinDuration = Random.RandomFloat(2.5, 5.0); }
        self._root = UI.GetRootVisualElement();
        self.BuildUI();
        self.HideUI();
    }

    function BuildUI()
    {
        self._mainContainer = UI.VisualElement()
            .Absolute(true)
            .Top(0, false)
            .Left(0, false)
            .Width(100, true)
            .Height(100, true)
            .BackgroundColor(Color(0, 0, 0, 180))
            .JustifyContent(JustifyEnum.Center)
            .AlignItems(AlignEnum.Center);

        self._root.Add(self._mainContainer);

        centerBox = UI.VisualElement()
            .Width(500)
            .Height(400)
            .BackgroundColor(Color(40, 40, 40, 255))
            .BorderRadius(15)
            .BorderWidth(4)
            .BorderColor(Color("#ffd700"))
            .FlexDirection(FlexDirectionEnum.Column)
            .JustifyContent(JustifyEnum.Center)
            .AlignItems(AlignEnum.Center);

        self._mainContainer.Add(centerBox);

        title = UI.Label("SLOT MACHINE")
            .FontSize(28)
            .Color(Color("#ffd700"))
            .MarginTop(20)
            .MarginBottom(30);
            
        centerBox.Add(title);

        slotsRow = UI.VisualElement()
            .FlexDirection(FlexDirectionEnum.Row)
            .JustifyContent(JustifyEnum.Center)
            .AlignItems(AlignEnum.Center)
            .MarginTop(10)
            .MarginBottom(30);

        centerBox.Add(slotsRow);

        self._slots.Clear();
        self._slotLabels.Clear();

        for(i in Range(0, 3, 1))
        {
            slot = UI.VisualElement()
                .Width(self.SlotSize)
                .Height(self.SlotSize)
                .BackgroundColor(Color(30, 30, 30, 255))
                .BorderRadius(10)
                .BorderWidth(3)
                .BorderColor(Color("#ffd700"))
                .JustifyContent(JustifyEnum.Center)
                .AlignItems(AlignEnum.Center)
                .OverflowX(OverflowEnum.Hidden)
                .OverflowY(OverflowEnum.Hidden);
                
            if(i > 0) {
                slot.MarginLeft(self.SlotSpacing);
            }
            
            self._slots.Add(slot);
            slotsRow.Add(slot);
            
            label = UI.Label("?")
                .FontSize(36)
                .Color(Color(255, 255, 255, 255))
                .TextAlign(TextAlignEnum.MiddleCenter);
                
            self._slotLabels.Add(label);
            slot.Add(label);
        }

        spinButton = UI.Button("SPIN", self.OnSpinButtonClicked)
            .Height(55)
            .Width(200)
            .FontSize(22)
            .BackgroundColor(Color(218, 165, 32, 255))
            .Color(Color(0, 0, 0, 255))
            .BorderRadius(8)
            .MarginBottom(30);

        centerBox.Add(spinButton);

        self._uiBuilt = true;
        self._isActive = true;
    }

    function OnSpinButtonClicked()
    {
        if ( Main.Coins < 5)
        {
            Game.Print("No Coins Left, buy more with your SOUL");
            return;
        }
        
        self.Spin();
    }

    function Spin()
    {
        if(self._isSpinning) { return; }
        if(self._slots == null) { return; }
        if(self._slots.Count == 0) { return; }
        
        self._isSpinning = true;
        self._sound.Active = true;

        results = List();
        for(i in Range(0, 3, 1))
        {
            randomIndex = Random.RandomInt(0, self._symbols.Count);
            results.Add(self._symbols.Get(randomIndex));
        }

        self.AnimateSpin(results);
    }

    coroutine AnimateSpin(results)
    {
        duration = self.SpinDuration;
        elapsed = 0.0;
        cyclingSpeed = 0.05;

        while(elapsed < duration)
        {
            for(i in Range(0, self._slots.Count, 1))
            {
                if(elapsed / duration > (i * 0.3)) {
                    continue;
                }
                
                slot = self._slots.Get(i);
                if(slot == null) { continue; }
                
                slot.Clear();
                
                randomSymbol = self._symbols.Get(Random.RandomInt(0, self._symbols.Count));
                label = UI.Label(randomSymbol)
                    .FontSize(36)
                    .Color(Color(255, 255, 255, 255))
                    .TextAlign(TextAlignEnum.MiddleCenter);
                    
                slot.Add(label);
            }

            wait cyclingSpeed;
            elapsed += cyclingSpeed;
            cyclingSpeed *= 1.15;
        }

        for(i in Range(0, self._slots.Count, 1))
        {
            slot = self._slots.Get(i);
            if(slot == null) { continue; }
            
            slot.Clear();
            
            symbol = results.Get(i);
            
            if(symbol == "7") 
            {
                resultColor = Color(255, 0, 0, 255);
                displayText = "7";
            } 
            elif(symbol == "#") 
            {
                resultColor = Color(255, 215, 0, 255);
                displayText = "#";
            } 
            else 
            {
                resultColor = Color(255, 255, 255, 255);
                displayText = symbol;
            }
            
            label = UI.Label(displayText)
                .FontSize(36)
                .Color(resultColor)
                .TextAlign(TextAlignEnum.MiddleCenter);
                
            slot.Add(label);
        }

        self._sound.Active = false;
        self._isSpinning = false;
        self.CheckResults(results);
    }

    function CheckResults(results)
    {
        uniqueResults = List();
        for(result in results) {
            if(!uniqueResults.Contains(result)) {
                uniqueResults.Add(result);
            }
        }

        resultString = "";
        for(i in Range(0, results.Count, 1))
        {
            if(i > 0) { resultString += " | "; }
            resultString += results.Get(i);
        }

        if(uniqueResults.Count == 1) 
        {
            randomNum = Random.RandomInt(10, 50);
            Game.Print(UI.WrapStyleTag("JACKPOT!!! +" + randomNum + " Coins!!!", "color", "yellow"));
            Main.Coins += randomNum;
        } 
        elif (uniqueResults.Count == 1 && uniqueResults.Contains("⚠"))
        {
            Game.Print("YOU HIT THE SHITTY POT!! -200 Coins!!");
            Main.Coins -= 200;
        }
        
        elif(uniqueResults.Count == 2) 
        {
            Game.Print(UI.WrapStyleTag("Match! +5 Coins!", "color", "green"));
            Main.Coins += 5;
        } 
        else 
        {
            # No match
            Game.Print(UI.WrapStyleTag("No match! Try again!", "color", "red"));
            Main.Coins -= 5;
        }
        Game.Print("Slot: " + resultString + " Coins Left: " +  Main.Coins);
    }

    function HideUI()
    {
        if(!self._isActive) { return; }
        if(self._mainContainer != null) 
        {
            self._mainContainer.Active(false);
        }
        self._isActive = false;
        UI.ForceHideNames = false;
        Camera.SetCursorVisible(false);
        Input.SetHumanKeysEnabled(true);
        UI.SetLabelActive("MiddleCenter", true);
    }

    function ShowUI()
    {
        if(!self._uiBuilt) 
        {
            self.SetupSlotMachine();
        }
        
        if(self._mainContainer != null) 
        {
            self._mainContainer.Active(true);
        }
        
        self._isActive = true;

        UI.ForceHideNames = true;
        UI.SetLabelActive("MiddleCenter", false);
        if(self._slots != null) 
        {
            for(i in Range(0, self._slots.Count, 1))
            {
                slot = self._slots.Get(i);
                if(slot == null) { continue; }
                
                slot.Clear();
                
                label = UI.Label("?")
                    .FontSize(36)
                    .Color(Color(255, 255, 255, 255))
                    .TextAlign(TextAlignEnum.MiddleCenter);
                    
                slot.Add(label);
            }
        }

        Input.SetHumanKeysEnabled(false);
        Camera.SetCursorVisible(true);
    }
}
component Bank
{
    _isWaiting = false;
    _isActive = false;
    _collidingHuman = null;

    _buttons = List();
    _amountButtons = List();
    _coins = 0;

    function OnGameStart()
    {
        UI.CreatePopup("Bank", "Bank", 600, 800);  
        UI.CreatePopup("Depositing", "Deposits", 600, 800);  
        UI.CreatePopup("Withdrawing", "Withdrawls", 600, 800);  
    }
    
    function OnCollisionStay(obj)
    {
        if (obj.Type == "Human" && obj.IsMainCharacter)
        {
            self._collidingHuman = obj;
        }
    }

    function OnCollisionExit(obj)
    {
        if (obj.Type == "Human" && obj.IsMainCharacter)
        {
            UI.HidePopup("Bank");
        } 
    }

    function OnTick()
    {
        self._collidingHuman = null;
    }

    function OnFrame()
    {
        if (self._collidingHuman != null)
        {
            UI.SetLabelForTime("MiddleCenter", "Press " + Input.GetKeyName(InputInteractionEnum.Function1) + " To open bank", 0.1);
            
            if (Input.GetKeyDown(InputInteractionEnum.Function1))
            {
                self.Show();
            }
        }
    }

    function OnButtonClick(buttonName)
    {
        if (buttonName == "Withdraw")
        {
            UI.ClearPopup("Withdrawing");
            self.SetWithdrawlContent();
            UI.ShowPopup("Withdrawing");
            UI.HidePopup("Bank");
        }
        elif (buttonName == "Deposit")
        {
            UI.ClearPopup("Depositing");
            self.SetDepositContent();
            UI.ShowPopup("Depositing");
            UI.HidePopup("Bank");
        }
        elif (buttonName == "All" && UI.IsPopupActive("Depositing"))
        {
            self.NetworkView.SendMessage(Network.MasterClient, "DepositAll|" + Main.Coins);
            Game.Print("Deposited");
        }
        elif (buttonName == "All" && UI.IsPopupActive("Withdrawing"))
        {
            self.NetworkView.SendMessage(Network.MasterClient, "WithdrawAll");
            Game.Print("Withdrew");
        }
        elif (buttonName == "50" && UI.IsPopupActive("Depositing"))
        {
            self.NetworkView.SendMessage(Network.MasterClient, "Deposit50");
            Game.Print("Deposited");
        }
        elif (buttonName == "50" && UI.IsPopupActive("Withdrawing"))
        {
            self.NetworkView.SendMessage(Network.MasterClient, "Withdraw50");
            Game.Print("Withdrew");
        }
        elif (buttonName == "100" && UI.IsPopupActive("Depositing"))
        {
            self.NetworkView.SendMessage(Network.MasterClient, "Deposit100");
            Game.Print("Deposited");
        }
        elif (buttonName == "100" && UI.IsPopupActive("Withdrawing"))
        {
            self.NetworkView.SendMessage(Network.MasterClient, "Withdraw100");
            Game.Print("Withdrew");
        }
        elif (buttonName == "500" && UI.IsPopupActive("Depositing"))
        {
            self.NetworkView.SendMessage(Network.MasterClient, "Deposit500");
            Game.Print("Deposited");
        }
        elif (buttonName == "500" && UI.IsPopupActive("Withdrawing"))
        {
            self.NetworkView.SendMessage(Network.MasterClient, "Withdraw500");
            Game.Print("Withdrew");
        }
        elif (buttonName == "1000" && UI.IsPopupActive("Depositing"))
        {
            self.NetworkView.SendMessage(Network.MasterClient, "Deposit1000");
            Game.Print("Deposited");
        }
        elif (buttonName == "1000" && UI.IsPopupActive("Withdrawing"))
        {
            self.NetworkView.SendMessage(Network.MasterClient, "Withdraw1000");
            Game.Print("Withdrew");
        }
        elif (buttonName == "5000" && UI.IsPopupActive("Depositing"))
        {
            self.NetworkView.SendMessage(Network.MasterClient, "Deposit5000");
            Game.Print("Deposited");
        }
        elif (buttonName == "5000" && UI.IsPopupActive("Withdrawing"))
        {
            self.NetworkView.SendMessage(Network.MasterClient, "Withdraw5000");
            Game.Print("Withdrew");
        }
    }

    coroutine Show()
    {
        UI.HidePopup("Bank");
        UI.ClearPopup("Bank");
        self.MapObject.NetworkView.SendMessage(Network.MasterClient, "RequestCoins");
        self.SetBankContent();

        UI.ShowPopup("Bank");
    }

    function Hide()
    {
        if (UI.IsPopupActive("Bank")) {
            UI.HidePopup("Bank");
        }
        elif (UI.IsPopupActive("Withdrawing")) {
            UI.HidePopup("Withdrawing");
        }
        elif (UI.IsPopupActive("Depositing")) {
            UI.HidePopup("Depositing");
        }
    }

    function OnNetworkMessage(sender, message)
    {
        args = String.Split(message, "|", true);
        rpc = args.Get(0);

        if (rpc == "YourCoins")
        {
            coins = Convert.ToInt(args.Get(1));
            self._coins = coins;
        }
        elif (rpc == "PlusCoins")
        {
            amt = args.Get(1);

            Main.Coins += Convert.ToInt(amt);
        }
        elif (rpc == "MinusCoins")
        {
            amt = args.Get(1);

            if (amt == "all") {Main.Coins = 0; return;}
            Main.Coins -= Convert.ToInt(amt);
        }

        if (!Network.IsMasterClient) {return;}
        senderServerID = ServerID._playerServerIDs.Get(sender.ID);
        playerData  = MoneyData.LoadPlayerData(senderServerID);

        chedda = Convert.ToInt(playerData.Get("Money"));

        if (rpc == "RequestCoins")
        {
            self.NetworkView.SendMessage(sender, "YourCoins|" + playerData.Get("Money"));
        }

        elif (rpc == "DepositAll")
        {
            coins = Convert.ToInt(args.Get(1));

            saved = coins + chedda;

            MoneyData.SaveMoney(saved, senderServerID);
            self.NetworkView.SendMessage(sender, "MinusCoins|" + "all");
        }
        elif (rpc == "WithdrawAll")
        {
            self.NetworkView.SendMessage(sender, "PlusCoins|" + Convert.ToInt(chedda));
            MoneyData.SaveMoney(0, senderServerID);
        }
        elif (rpc == "Deposit50" && Main.Coins >= 50)
        {
            monet = playerData.Get("Money");
        
            coins = monet + 50;

            self.NetworkView.SendMessage(sender, "MinusCoins|" + 50);
            MoneyData.SaveMoney(coins, senderServerID);
        }
        elif (rpc == "Withdraw50" && chedda >= 50)
        {
            monet = playerData.Get("Money");

            coins = monet - 50;
            self.NetworkView.SendMessage(sender, "PlusCoins|" + 50);
            MoneyData.SaveMoney(coins, senderServerID);
        }
        elif (rpc == "Deposit100" && Main.Coins >= 100)
        {
            monet = playerData.Get("Money");

            coins = monet + 100;

            self.NetworkView.SendMessage(sender, "MinusCoins|" + 100);
            MoneyData.SaveMoney(coins, senderServerID);
        }
        elif (rpc == "Withdraw100" && chedda >= 100)
        {
            monet = playerData.Get("Money");

            coins = monet - 100;

            self.NetworkView.SendMessage(sender, "PlusCoins|" + 100);
            MoneyData.SaveMoney(coins, senderServerID);
        }
        elif (rpc == "Deposit500" && Main.Coins >= 500)
        {
            monet = playerData.Get("Money");

            coins = monet + 500;

            self.NetworkView.SendMessage(sender, "MinusCoins|" + 500);
            MoneyData.SaveMoney(coins, senderServerID);
        }
        elif (rpc == "Withdraw500" && chedda >= 500)
        {
            monet = playerData.Get("Money");

            self.NetworkView.SendMessage(sender, "PlusCoins|" + 500);

            coins = monet - 500;
            MoneyData.SaveMoney(coins, senderServerID);
        }
        elif (rpc == "Deposit1000"  && Main.Coins >= 1000)
        {
            monet = playerData.Get("Money");

            coins = monet + 1000;

            self.NetworkView.SendMessage(sender, "MinusCoins|" + 1000);
            MoneyData.SaveMoney(coins, senderServerID);
        }
        elif (rpc == "Withdraw1000" && chedda >= 1000)
        {
            monet = playerData.Get("Money");

            self.NetworkView.SendMessage(sender, "PlusCoins|" + 1000);

            coins = monet - 1000;
            MoneyData.SaveMoney(coins, senderServerID);
        }
        elif (rpc == "Deposit5000" && Main.Coins >= 5000)
        {
            monet = playerData.Get("Money");

            coins = monet + 5000;

            self.NetworkView.SendMessage(sender, "MinusCoins|" + 5000);
            MoneyData.SaveMoney(coins, senderServerID);
        }
        elif (rpc == "Withdraw5000" && chedda >= 5000)
        {
            monet = playerData.Get("Money");

            self.NetworkView.SendMessage(sender, "PlusCoins|" + 5000);

            coins = monet - 5000;
            MoneyData.SaveMoney(coins, senderServerID);
        }
        
        
    }

    coroutine SetBankContent()
    {
        wait 0.2;
        self.ClearLists();
        text = "In Savings: " + self._coins;
        text += String.Newline + "In Wallet: " + Main.Coins;
        UI.AddPopupLabel("Bank",text);
        self.AddButtons();

        UI.AddPopupButtons("Bank", self._buttons, self._buttons);
    }

    function SetWithdrawlContent()
    {
        self.ClearLists();
        self.AddAmountButtons();

        UI.AddPopupButtons("Withdrawing", self._amountButtons, self._amountButtons);
    }

    function SetDepositContent()
    {
        self.ClearLists();
        self.AddAmountButtons();

        UI.AddPopupButtons("Depositing", self._amountButtons, self._amountButtons);
    }

    function AddButtons()
    {
        self._buttons.Add("Withdraw");
        self._buttons.Add("Deposit");
    }

    function AddAmountButtons()
    {
        self._amountButtons.Add("All");
        self._amountButtons.Add("50");
        self._amountButtons.Add("100");
        self._amountButtons.Add("500");
        self._amountButtons.Add("1000");
        self._amountButtons.Add("5000");
    }

    function ClearLists()
    {
        self._buttons.Clear();
        self._amountButtons.Clear();
    }
}
component BlackJack
{
    #Blackjack
    _cardSpacing = 15;
    _cardWidth = 80;
    _cardHeight = 110;

    _root = null;
    _isActive = false;
    _isColliding = null;
    _mainContainer = null;

    _screenWidth = 0;
    _screenHeight = 0;
    _uiScale = 1.0;

    _width = 0;
    _height = 0;
    _label = 0;
    _containerLeft = 0;
    _containerTop = 0;

    _deck = List();
    _playerHand = List();
    _dealerHand = List();
    _pScore = 0;
    _dScore = 0;
    _cardHidden = false;
    _gameActive = false;
    _hit = false;

    _bet = 0;
    _coins = null;

    _playerCardsContainer = null;
    _dealerCardsContainer = null;

    _playerScore = null;
    _dealerScore = null;

    _hitBtn = null;
    _standBtn = null;
    _dealBtn = null;
    _allIn = null;
    _bet5Btn = null;
    _minusBet5 = null;
    _bet1Btn = null;
    _minusBet1 = null;

    _suits = List();
    _values = List();

    _bgColor = "#008300";
    _borderColor = "#fffb00";

    function CalculateLayout()
    {
        dims = Input.GetScreenDimensions();
        self._screenWidth = dims.X;
        self._screenHeight = dims.Y;

        scaleX = self._screenWidth / 1920.0;
        scaleY = self._screenHeight / 1080.0;

        self._uiScale = scaleX;
        if (scaleY < self._uiScale) { self._uiScale = scaleY; }

        if (self._uiScale < 0.75) { self._uiScale = 0.75; }
        if (self._uiScale > 2.50) { self._uiScale = 2.50; }

        s = self._uiScale;

        self._label = 23 * s;
        self._width = 600 * s;
        self._height = 500 * s;

        self._containerLeft = (self._screenWidth - (self._label + self._width)) / 2;
        self._containerLeft -= 50;
        self._containerTop = 950 * s;
    }

    function OnGameStart()
    {   
        self.AddSuits();
        self.AddValues();

        self.BuildDeck();
        #Game.Print(self._deck);

        self.CalculateLayout();
        self.BuildUI();
        self.Hide();
    }

    function OnCollisionStay(obj)
    {
        if (obj.Type == "Human" && obj.IsMainCharacter)
        {
            self._isColliding = obj;
            if (!self._isActive)
            {
                UI.SetLabelForTime("MiddleCenter", "Press F1 to open blackjack", 0.1);   
            }
        }
        
    }

    function OnCollisionExit(obj)
    {
        if (obj.Type == "Human" && obj.IsMainCharacter)
        {
            self.Hide();
        }
    }

    function OnFrame()
    {
        if (self._isColliding != null)
        {
            f1 = Input.GetKeyDown("Interaction/Function1");
            if (!self._isActive && f1)
            {
                self.CalculateLayout();
                self.BuildUI();
                self.Show();
            }
            elif (self._isActive && f1)
            {
                self.Hide();
            }
        }
    }

    function OnCharacterDie(victim,killer,killerName)
    {
        if (victim.Type == "Human" && victim.IsMainCharacter)
        {
            if (self._isActive)
            {
                self.Hide();
                self._isActive = false;
            }
            
        }
        
    }

    function OnTick()
    {
        self._isColliding = null;
    }

    function AddSuits()
    {
        self._suits.Add("hearts");
        self._suits.Add("diamonds");
        self._suits.Add("clubs");
        self._suits.Add("spades");
    }

    function AddValues()
    {
        self._values.Add("A");
        self._values.Add("2");
        self._values.Add("3");
        self._values.Add("4");
        self._values.Add("5");
        self._values.Add("6");
        self._values.Add("7");
        self._values.Add("8");
        self._values.Add("9");
        self._values.Add("10");
        self._values.Add("J");
        self._values.Add("Q");
        self._values.Add("K");
    }

    function BuildUI()
    {
        self._root = UI.GetRootVisualElement();
        s = self._uiScale;

        image = UI.Image("Backgrounds/DarkBackgroundTextured");

        self._mainContainer = UI.VisualElement()
            .Absolute(true)
            .Top(0, false)
            .Left(0, false)
            .Width(100, true)
            .Height(100, true)
            .BackgroundColor(Color(0, 0, 0, 180))
            .SetBackgroundImage(image)
            .JustifyContent(JustifyEnum.Center)
            .AlignItems(AlignEnum.Center);

        self._root.Add(self._mainContainer);

        sideBox = UI.VisualElement()
            .Width(self._width / 2)
            .Height(self._height / 2)
            .Top(22, true)
            .BackgroundColor(Color(self._bgColor))
            .BorderColor(Color(self._borderColor))
            .BorderWidth(5)
            .BorderRadius(15)
            .FlexDirection(FlexDirectionEnum.Column)
            .AlignSelf(AlignEnum.FlexStart);
        self._mainContainer.Add(sideBox);

        coinLabel = UI.Label("Coins: " + Main.Coins)
            .FontSize(20 * s)
            .MarginTop(10)
            .MarginBottom(20)
            .TextAlign(TextAlignEnum.UpperCenter);
        sideBox.Add(coinLabel);

        betLabel = UI.Label("Current Bet: " + self._bet)
            .FontSize(20 * s)
            .MarginTop(10)
            .MarginBottom(20)
            .TextAlign(TextAlignEnum.UpperCenter);
        sideBox.Add(betLabel);

        deckLabel = UI.Label("Deck Left: " + self._deck.Count)
            .FontSize(20 * s)
            .MarginTop(10)
            .MarginBottom(20)
            .TextAlign(TextAlignEnum.UpperCenter);
        sideBox.Add(deckLabel);

        mainBox = UI.VisualElement()
            .Width(self._width)
            .Height(self._height)
            .MarginBottom(25)
            .BackgroundColor(Color(self._bgColor))
            .BorderColor(Color(self._borderColor))
            .BorderWidth(5)
            .BorderRadius(10)
            .FlexDirection(FlexDirectionEnum.Column)
            .AlignItems(AlignEnum.Center);
        self._mainContainer.Add(mainBox);

        titleContainer = UI.VisualElement()
            .FlexDirection(FlexDirectionEnum.Row)
            .JustifyContent(JustifyEnum.Center)
            .AlignSelf(AlignEnum.Center)
            .Height(150);
        mainBox.Add(titleContainer);

        title = UI.Label("BLACKJACK")
            .FontSize(25 * s)
            .MarginTop(10)
            .MarginBottom(20);       
        titleContainer.Add(title);

        dealer = UI.Label("Dealer")
            .FontSize(20 * s);
        mainBox.Add(dealer);

        dealerScore = UI.Label("Score: " + self._dScore)
            .FontSize(15 * s);
        mainBox.Add(dealerScore);

        self._dealerCardsContainer = UI.VisualElement()
            .FlexDirection(FlexDirectionEnum.Row)
            .JustifyContent(JustifyEnum.Center)
            .AlignItems(AlignEnum.Center)
            .Height(210)
            .MarginTop(10)
            .MarginBottom(20);
        mainBox.Add(self._dealerCardsContainer);

        divider = UI.VisualElement()
            .Width(self._width - 50)
            .Height(2)
            .BackgroundColor(Color("#e5ff00"))
            .MarginTop(10)
            .MarginBottom(10);
        mainBox.Add(divider);

        player = UI.Label("Player")
            .FontSize(20 * s);
        mainBox.Add(player);

        playerScore = UI.Label("Score: " + self._pScore)
            .FontSize(15 * s);
        mainBox.Add(playerScore);

        self._playerCardsContainer = UI.VisualElement()
            .FlexDirection(FlexDirectionEnum.Row)
            .JustifyContent(JustifyEnum.Center)
            .AlignItems(AlignEnum.Center)
            .Height(210)
            .MarginTop(10)
            .MarginBottom(20);
        mainBox.Add(self._playerCardsContainer);

        buttonRow = UI.VisualElement()
            .FlexDirection(FlexDirectionEnum.Row)
            .JustifyContent(JustifyEnum.Center)
            .AlignItems(AlignEnum.Center)
            .MarginBottom(20);
        mainBox.Add(buttonRow);

        self._hitBtn = UI.Button("Hit", self.Hit)
            .Width(120 * s)
            .Height(40 * s)
            .BackgroundColor(Color("#2bff00"))
            .BorderRadius(15);
        buttonRow.Add(self._hitBtn);

        self._standBtn = UI.Button("Stand", self.Stand)
            .Width(120 * s)
            .Height(40 * s)
            .BackgroundColor(Color("#ff2929"))
            .BorderRadius(15);
        buttonRow.Add(self._standBtn);

        self._allIn = UI.Button("All In", self.AllIn)
            .Width(60 * s)
            .Height(40 * s)
            .BackgroundColor(Color("#ee56fc"))
            .BorderRadius(15);
        buttonRow.Add(self._allIn);

        self._bet5Btn = UI.Button("Bet +5", self.Bet5)
            .Width(60 * s)
            .Height(40 * s)
            .BackgroundColor(Color("#2dff61"))
            .BorderRadius(15);
        buttonRow.Add(self._bet5Btn);

        self._minusBet5 = UI.Button("Bet -5 ", self.Minus5)
            .Width(60 * s)
            .Height(40 * s)
            .BackgroundColor(Color("#ff2d2d"))
            .BorderRadius(15);
        buttonRow.Add(self._minusBet5);

        self._bet1Btn = UI.Button("Bet +100", self.Bet100)
            .Width(60 * s)
            .Height(40 * s)
            .BackgroundColor(Color("#2dff61"))
            .BorderRadius(15);
        buttonRow.Add(self._bet1Btn);

        self._minusBet1 = UI.Button("Bet -100", self.Minus100)
            .Width(60 * s)
            .Height(40 * s)
            .BackgroundColor(Color("#ff2d2d"))
            .BorderRadius(15);
        buttonRow.Add(self._minusBet1);

        self._dealBtn = UI.Button("Deal", self.Deal)
            .Width(120 * s)
            .Height(40 * s)
            .BackgroundColor(Color("#fbff0f"))
            .BorderRadius(15);
        buttonRow.Add(self._dealBtn);

        self._hitBtn.Active(false);
        self._standBtn.Active(false);

        #self._isActive = true;
    }

    function Show()
    {
        self.CalculateLayout();
        self._mainContainer.Active(true);
        self._isActive = true;
        if (Network.MyPlayer.Character == null) {return;}
        Network.MyPlayer.Character.Name = " ";
        Network.MyPlayer.Character.Guild = " ";
        self.DisableInputs();
        
    }

    function Hide()
    {
        self._mainContainer.Active(false);
        self._isActive = false;
        if (Network.MyPlayer.Character == null) {return;}
        Network.MyPlayer.Character.Name = Network.MyPlayer.Name;
        Network.MyPlayer.Character.Guild = Network.MyPlayer.Guild;
        self.EnableInputs();
    }

    function Bet5()
    {
        if (Main.Coins <= 0)
        {
            Game.Print("No coins left");
            return;
        }
        
        if (self._bet < Main.Coins)
        {
            self._bet += 5;
        }
        else
        {
            Game.Print("Exceeding coins!");
        }
        
        self.UpdateDiplay(false);
        #Game.Print("Bet: " + self._bet);
    }

    function Minus5()
    {
        if (Main.Coins <= 0)
        {
            Game.Print("No coins left");
            return;
        }
        
        if (self._bet <= Main.Coins && self._bet > 0)
        {
            self._bet -= 5;
        }
        else
        {
            Game.Print("Exceeding coins!");
        }
        
        self.UpdateDiplay(false);
    }

    function Bet100()
    {
        if (Main.Coins <= 0)
        {
            Game.Print("No coins left");
            return;
        }

        if (self._bet < Main.Coins)
        {
            self._bet += 100;
        }
        else
        {
            Game.Print("Exceeding coins!");
        }
        self.UpdateDiplay(false);
        #Game.Print("Bet: " + self._bet);
    }

    function Minus100()
    {
        if (Main.Coins <= 0)
        {
            Game.Print("No coins left");
            return;
        }
        
        if (self._bet <= Main.Coins && self._bet > 0)
        {
            self._bet -= 100;
        }
        else
        {
            Game.Print("Exceeding coins!");
        }

        self.UpdateDiplay(false);
    }

    function AllIn()
    {
        if (Main.Coins <= 0)
        {
            Game.Print("No coins left");
            return;
        }
        
        if (self._bet < Main.Coins)
        {
            self._bet += Main.Coins;
        }
        else
        {
            Game.Print("Exceeding coins!");
        }
        
        self.UpdateDiplay(false);
        #Game.Print("Bet: " + self._bet);
    }

    function Hit()
    {
        self.DealCard(self._playerHand);
        self._hit = true;
        self._pScore = self.CalculateScore(self._playerHand);

        if (self._pScore >= 21)
        {
            self.DetermineWinner();
        }

        if (self._dScore >= 21)
        {
            self.DetermineWinner();
        }
        
        self.UpdateDiplay(true);
    }

    coroutine Stand()
    {
        if (self._dScore >= 17) {self.DetermineWinner(); return;}
        while (self._dScore < 17)
        {
            if (self._dScore >= 17) {self.DetermineWinner(); return;}
            self.DealCard(self._dealerHand);
            self._hit = true;
            self._dScore = self.CalculateScore(self._dealerHand);
            #Game.Print(self._dScore);
            wait 0.2;
            
            self.UpdateDiplay(false);
        }
        self.DetermineWinner();
    }

    function Deal()
    {
        if (Main.Coins <= 0) {Game.Print("No coins left"); return;}
        if (self._bet <= 0) {Game.Print("Place bet to play"); return;}

        self._playerHand.Clear();
        self._dealerHand.Clear();

        self.DealCard(self._playerHand);
        self.DealCard(self._dealerHand);
        self.DealCard(self._playerHand);
        self.DealCard(self._dealerHand);

        #Game.Print("PHand " + self._playerHand);
        #Game.Print("DHAnd" + self._dealerHand);

        self._pScore = self.CalculateScore(self._playerHand);
        #Game.Print(self._pScore);
        invisScore = self.CalculateScore(self._dealerHand);
        #Game.Print(self._dScore);

        Main.Coins -= self._bet;
        Game.Print("Coins: " + Main.Coins);

        self._gameActive = true;
        self.UpdateDiplay(true);
    }


    function UpdateDiplay(hideCard)
    {
        self.Hide();

        self.BuildUI();

        self._playerCardsContainer.Clear();
        self._dealerCardsContainer.Clear();

        for (card in self._playerHand)
        {
            createdCard = self.CreateCard(card);
            self._playerCardsContainer.Add(createdCard);
        }

        for (i in Range(0, self._dealerHand.Count, 1))
        {
            card = self._dealerHand.Get(i);
            #Game.Print(i);
            #Game.Print(card);

            if (hideCard == true && i == 0)
            {
                element = self.CreateHiddenCard();
                self._cardHidden = true;
            }
            else
            {
                element = self.CreateCard(card);
            }
            self._dealerCardsContainer.Add(element);
        }

        if (self._gameActive)
        {
            self._dealBtn.Active(false);
            self._hitBtn.Active(true);
            self._standBtn.Active(true);
            self._bet5Btn.Active(false);
            self._bet1Btn.Active(false);
            self._minusBet1.Active(false);
            self._minusBet5.Active(false);
            self._allIn.Active(false);
            #Game.Print("Active");
        }
        elif (!self._gameActive)
        {
            self._dealBtn.Active(true);
            self._bet5Btn.Active(true);
            self._bet1Btn.Active(true);
            self._minusBet1.Active(true);
            self._minusBet5.Active(true);
            self._allIn.Active(true);
            self._hitBtn.Active(false);
            self._standBtn.Active(false);
            
            #Game.Print("Inactive");
        }
        
        
        
        self.Show();
    }

    function BuildDeck()
    {

        for (suit in self._suits)
        {
            for (value in self._values)
            {
                self._deck.Add(value + String.Newline + "of" + String.Newline + suit);
            }
        }

        self.Shuffle();
    }

    function CreateCard(card)
    {
        s = self._uiScale;
        cardContainer = UI.VisualElement()
            .Width(self._cardWidth * s)
            .Height(self._cardHeight * s)
            .BackgroundColor(Color(255, 255, 255, 255))
            .BorderRadius(8)
            .BorderWidth(2)
            .BorderColor(Color(0, 0, 0, 255))
            .FlexDirection(FlexDirectionEnum.Column)
            .JustifyContent(JustifyEnum.Center)
            .AlignItems(AlignEnum.Center)
            .MarginLeft(self._cardSpacing / 2)
            .MarginRight(self._cardSpacing / 2);

        label = UI.Label(card);
        cardContainer.Add(label);

        return cardContainer;
    }

    function CreateHiddenCard()
    {
        s = self._uiScale;
        HcardContainer = UI.VisualElement()
            .Width(self._cardWidth * s)
            .Height(self._cardHeight * s)
            .BackgroundColor(Color("#293fff"))
            .BorderRadius(8)
            .BorderWidth(2)
            .BorderColor(Color(0, 0, 0, 255))
            .FlexDirection(FlexDirectionEnum.Column)
            .JustifyContent(JustifyEnum.Center)
            .AlignItems(AlignEnum.Center)
            .MarginLeft(self._cardSpacing / 2)
            .MarginRight(self._cardSpacing / 2);
        return HcardContainer;
    }

    function Shuffle()
    {
        for(i in Range(self._deck.Count - 1, 0, -1))
        {
            j = Random.RandomInt(0, i + 1);
            temp = self._deck.Get(i);
            self._deck.Set(i, self._deck.Get(j));
            self._deck.Set(j, temp);
        }
    }

    function DealCard(hand)
    {
        if (self._deck.Count == 0)
        {
            self.BuildDeck();
            Game.Print("New Deck");
        }
        
        card = self._deck.Get(0);

        self._deck.RemoveAt(0);
        hand.Add(card);
        return card;
    }

    function CalculateScore(hand)
    {
        score = 0;
        for (card in hand)
        {
            #Game.Print(card);

            if (String.Contains(card, "2"))
            {
                score = score + 2;
                #Game.Print("Added Score 2 " + score);
            }
            if (String.Contains(card, "3"))
            {
                score = score + 3;
                #Game.Print("Added Score 3 " + score);
            }
            if (String.Contains(card, "4"))
            {
                score = score + 4;
                #Game.Print("Added Score 4 " + score);
            }
            if (String.Contains(card, "5"))
            {
                score = score + 5;
                #Game.Print("Added Score 5 " + score);
            }
            if (String.Contains(card, "6"))
            {
                score = score + 6;
                #Game.Print("Added Score 6 " + score);
            }
            if (String.Contains(card, "7"))
            {
                score = score + 7;
                #Game.Print("Added Score 7 " + score);
            }
            if (String.Contains(card, "8"))
            {
                score = score + 8;
                #Game.Print("Added Score 8 " + score);
            }
            if (String.Contains(card, "9"))
            {
                score = score + 9;
                #Game.Print("Added Score 9 " + score);
            }
            if (String.Contains(card, "10"))
            {
                score = score + 10;
                #Game.Print("Added Score 10 " + score);
            }
            if (String.Contains(card, "Q"))
            {
                score = score + 10;
            # Game.Print("Added Score 10 " + score);
            }
            if (String.Contains(card, "K"))
            {
                score = score + 10;
            # Game.Print("Added Score 10 " + score);
            }
            if (String.Contains(card, "J"))
            {
                score = score + 10;
            # Game.Print("Added Score 10 " + score);
            }

            if (String.Contains(card, "A"))
            {
                score = score + 1;
            # Game.Print("Added Score 10 " + score);
            }
        }
        return score;
    }

    coroutine DetermineWinner()
    {
        nl = String.Newline;
        if (self._pScore == 21 && self._dScore != 21 && !self._hit)
        {
            
            UI.SetLabelForTime(UILabelEnum.TopCenter, UI.WrapStyleTag(UI.WrapStyleTag(nl + nl + nl + "Blackjack!!! You win!", "color", "yellow"), "size", "30"), 4);
            Main.Coins += self._bet * 3;
            Game.Print("+" + self._bet + " Coins");
            wait 2.5;
            self._gameActive = false;
            self.Reset();
            self.UpdateDiplay(false);
            return;
        }
        elif (self._dScore == 21 && self._pScore != 21 && !self._hit)
        {
            UI.SetLabelForTime(UILabelEnum.TopCenter, UI.WrapStyleTag(UI.WrapStyleTag(nl + nl + nl + "Dealer Blackjack! You Lost!", "color", "red"), "size", "30"), 4);
            Game.Print("-" + self._bet + " Coins");
            wait 2.5;
            self._gameActive = false;
            self.Reset();
            self.UpdateDiplay(false);
            return;
        }

        if (self._pScore > 21)
        {
            UI.SetLabelForTime(UILabelEnum.TopCenter, UI.WrapStyleTag(UI.WrapStyleTag(nl + nl + nl + "Bust! You lost!", "color", "red"), "size", "30"), 4);
            Game.Print("-" + self._bet + " Coins");
            wait 2.5;
            self._gameActive = false;
            self.Reset();
            self.UpdateDiplay(false);
            return;
        }
        elif (self._dScore > self._pScore && self._dScore <= 21)
        {
            UI.SetLabelForTime(UILabelEnum.TopCenter, UI.WrapStyleTag(UI.WrapStyleTag(nl + nl + nl + "Dealer wins! You lost!", "color", "red"), "size", "30"), 4);
            Game.Print("+" + self._bet + " Coins");
            wait 2.5;
            self._gameActive = false;
            self.Reset();
            self.UpdateDiplay(false);
            return;
        }
        

        if (self._dScore > 21)
        {
            UI.SetLabelForTime(UILabelEnum.TopCenter, UI.WrapStyleTag(UI.WrapStyleTag(nl + nl + nl + "Dealer bust! You win!", "color", "green"), "size", "30"), 4);
            Main.Coins += self._bet * 2;
            Game.Print("+" + self._bet + " Coins");
            wait 2.5;
            self._gameActive = false;
            self.Reset();
            self.UpdateDiplay(true);
            return;
        }
        elif (self._dScore < self._pScore && self._pScore <= 21)
        {
            UI.SetLabelForTime(UILabelEnum.TopCenter, UI.WrapStyleTag(UI.WrapStyleTag(nl + nl + nl + "Dealer lost! You win!", "color", "green"), "size", "30"), 4);
            Main.Coins += self._bet * 2;
            Game.Print("+" + self._bet + " Coins");

            wait 2.5;
            self._gameActive = false;
            self.Reset();
            self.UpdateDiplay(false);
            return;
        }

        if (self._pScore == self._dScore)
        {
            UI.SetLabelForTime(UILabelEnum.TopCenter, UI.WrapStyleTag(UI.WrapStyleTag(nl + nl + nl + "Draw! No winner", "color", "yellow"), "size", "30"), 4);
            Main.Coins += self._bet;
            wait 2.5;
            self._gameActive = false;
            self.Reset();
            self.UpdateDiplay(false);
            return;
        }
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
        self._dealerHand.Clear();
        self._playerHand.Clear();
        self._dScore = 0;
        self._pScore = 0;
        self._bet = 0;
        self._hit = false;
    }
}
component CoinMachine
{
   _isActive = false;

   _inserted = false;
   _collected = false;

   _screenWidth = 0;
   _screenHeight = 0;
   _uiScale = 1.0;

   _width = 0;
   _height = 0;
   _label = 0;
   _containerLeft = 0;
   _containerTop = 0;

   _root = null;
   _container = null;

   function OnGameStart()
   {
       self.CalculateLayout();
       self.BuildUI();
       self.Hide();
   }

   function OnCollisionEnter(obj)
   {
       if (obj.Type == "Human" && obj.IsMainCharacter)
       {
           self.Show();
       }
   }

   function OnCollisionExit(obj)
   {
       if (obj.Type == "Human" && obj.IsMainCharacter)
       {
           self.Hide();
       }
   }

   function OnCharacterDie(victim,killer,killerName)
   {
       if (victim.Type == "Human" && victim.IsMainCharacter)
       {
           if (self._isActive) {self.Hide(); self._isActive = false;}
       }
   }

   function CalculateLayout()
   {
       dims = Input.GetScreenDimensions();
       self._screenWidth = dims.X;
       self._screenHeight = dims.Y;

       scaleX = self._screenWidth / 1920.0;
       scaleY = self._screenHeight / 1080.0;

       self._uiScale = scaleX;
       if (scaleY < self._uiScale) { self._uiScale = scaleY; }

       if (self._uiScale < 0.75) { self._uiScale = 0.75; }
       if (self._uiScale > 2.50) { self._uiScale = 2.50; }

       s = self._uiScale;

       self._label = 20 * s;
       self._width = 500 * s;
       self._height = 400 * s;

       self._containerLeft = (self._screenWidth - (self._label + self._width)) / 2;
       self._containerLeft -= 50;
       self._containerTop = 950 * s;
   }

   function BuildUI()
   {
       s = self._uiScale;
       self._root = UI.GetRootVisualElement();
       self._root.Clear();

       self._container = UI.VisualElement()
           .Absolute(true)
           .Top(0, false)
           .Left(0, false)
           .Width(100, true)
           .Height(100, true)
           .BackgroundColor(Color(0, 0, 0, 180))
           .JustifyContent(JustifyEnum.Center)
           .AlignItems(AlignEnum.Center);
       self._root.Add(self._container);

       coinBox = UI.VisualElement()
           .Width(self._width)
           .Height(self._height)
           .BorderRadius(20)
           .BorderWidth(10)
           .BorderColor(Color("#ffffff"))
           .BackgroundColor(Color("#1d1d1c"))
           .JustifyContent(JustifyEnum.Center)
           .AlignSelf(AlignEnum.Center);
       self._container.Add(coinBox);

       labelContainer = UI.VisualElement()
           .Width(100)
           .Height(50)
           .JustifyContent(JustifyEnum.FlexStart)
           .FlexDirection(FlexDirectionEnum.Column)
           .AlignSelf(AlignEnum.FlexStart);
       coinBox.Add(labelContainer);

       coinBoxLabel = UI.Label("Coin Machine")
           .FontSize(self._label * s)
           .FontStyle(FontStyleEnum.BoldAndItalic)
           .TextAlign(TextAlignEnum.UpperLeft)
           .Color(Color("#ffff"))
           .Margin(20);
       labelContainer.Add(coinBoxLabel);

       insLabel = UI.Label("One soul for 100 coins")
           .FontSize(16 * s)
           .TextAlign(TextAlignEnum.UpperLeft)
           .Color(Color("#fbff00"))
           .Margin(20);
       labelContainer.Add(insLabel);

       rightBox = UI.VisualElement()
           .Width(200)
           .Height(200)
           .MarginRight(20)
           .MarginTop(20)
           .BorderRadius(2)
           .BorderWidth(15)
           .BorderColor(Color("#ffff"))
           .BackgroundColor(Color("#000000"))
           .JustifyContent(JustifyEnum.FlexEnd)
           .AlignSelf(AlignEnum.FlexEnd);
       coinBox.Add(rightBox);

       rightBoxLabelContainer = UI.VisualElement()
           .Width(200)
           .Height(200)
           .Margin(10)
           .FlexDirection(FlexDirectionEnum.Column);
       rightBox.Add(rightBoxLabelContainer);

       rightBoxLabel = UI.Label("INSERT")
           .FontSize(18 * s)
           .TextShadowBlurRadius(10)
           .TextShadowColor(Color("#ff0000"))
           .Color(Color("#ffff"))
           .Margin(20)
           .TextAlign(TextAlignEnum.UpperCenter);
       rightBoxLabelContainer.Add(rightBoxLabel);

       coinSlot = UI.Button(" ", self.InsertCoin)
           .Width(5)
           .Height(40)
           .MarginLeft(30)
           .BackgroundColor(Color("#3f3e3e"))
           .BorderColor(Color("#ffffff"))
           .BorderWidth(4)
           .AlignSelf(AlignEnum.Center);
       rightBoxLabelContainer.Add(coinSlot);

       flatBox = UI.VisualElement()
           .Width(400 * s)
           .Height(200 * s)
           .MarginRight(20)
           .MarginBottom(20)
           .BorderRadius(2)
           .BorderWidth(15)
           .BorderColor(Color("#ffff"))
           .BackgroundColor(Color("#000000"))
           .AlignSelf(AlignEnum.FlexEnd);
       coinBox.Add(flatBox);

       FBLabelContainer = UI.VisualElement()
           .Width(400)
           .Height(200)
           .AlignSelf(AlignEnum.FlexEnd)
           .JustifyContent(JustifyEnum.Center)
           .FlexDirection(FlexDirectionEnum.Column);
       flatBox.Add(FBLabelContainer);

       FBLabel = UI.Label("Collection")
           .FontSize(18 * s)
           .Color(Color("#ffff"))
           .Margin(20)
           .TextAlign(TextAlignEnum.UpperCenter);
       FBLabelContainer.Add(FBLabel);

       collectionSlot = UI.Button("Collect Here", self.Collectcoins)
           .Width(200)
           .Height(50)
           .Margin(30)
           .Color(Color("#ffff"))
           .BackgroundColor(Color("#363636"))
           .BorderColor(Color("#ffff"))
           .BorderWidth(5)
           .AlignSelf(AlignEnum.Center);
       FBLabelContainer.Add(collectionSlot);
   }

   function InsertCoin()
   {
       Game.Print("Inserted SOUL");
       self._inserted = true;
       self._collected = false;
   }

   coroutine Collectcoins()
   {
       if (!self._inserted) {Game.Print("No SOUL inserted"); return;}
       Game.Print("Coins Collected");
       self._inserted = false;
       self._collected = true;
       Main.Coins += 100;

       wait 6;
       Network.MyPlayer.Character.GetKilled("<b><color=#FF0000>SOUL EXTRACTED</color></b>");
   }

   function Show()
   {
       self._isActive = true;
       self._container.Active(true);
       self.DisableInputs();
   }

   function Hide()
   {
       self._isActive = false;
       self._container.Active(false);
       self.EnableInputs();
   }

   function DisableInputs()
   {
       Camera.SetCameraLocked(true);
       Camera.SetCursorVisible(true);
       Input.SetHumanKeysEnabled(false);
   }

   function EnableInputs()
   {
       Camera.SetCameraLocked(false);
       Camera.SetCursorVisible(false);
       Input.SetHumanKeysEnabled(true);
   }
}
component DicePoker
{
    ## ui vars
    _root = null;
    _collidingHuman = null;
    _isActive = false;
    _built = false;

    /*@type VisualElement*/ _container = null;
    /*@type VisualElement*/ dealerDiceContainer = null;
    /*@type VisualElement*/ playerDiceContainer = null;
    /*@type VisualElement*/ botHand = null;
    /*@type VisualElement*/ playerHand = null;
    /*@type VisualElement*/_pHandLabelCont = null;
    /*@type VisualElement*/_bHandLabelCont = null;
    /*@type VisualElement*/_rollBTN = null;
    /*@type VisualElement*/bet5BTN = null;
    /*@type VisualElement*/bet100BTN = null;
    /*@type VisualElement*/minus5BTN = null;
    /*@type VisualElement*/minus100BTN = null;
    /*@type VisualElement*/lastBetBTN = null;

    defaultWidth = 800;
    DiceWidth = 50;
    DiceHeight = 50;
    bgColor = Color("#1a6d09");
    buttonColor = Color("#d088f1");

    _resultP = "";
    _resultB = "";

    ##game vars
    _values = List();
    _highVDict = Dict();

    _sortedP = List();
    _sortedD = List();

    _playerDice = List();
    _playersDiceDict = Dict();

    _dealerDice = List();
    _dealerDiceDict = Dict();

    _currentBet = 0;
    _lastBet = 0;

    _PhasHighValue = false;
    _PhasPair = false;
    _PhasTwoPair = false;
    _PhasThreeKind = false;
    _PhasStraight = false;
    _PhasFullHouse = false;
    _PhasFourKind = false;
    _PhasFiveKind = false;

    _DhasHighValue = false;
    _DhasPair = false;
    _DhasTwoPair = false;
    _DhasThreeKind = false;
    _DhasStraight = false;
    _DhasFullHouse = false;
    _DhasFourKind = false;
    _DhasFiveKind = false;

    _hasDrawed = false;

    _winner = "";
    _isRolling = false;
    _gameActive = false;

    /*
        ORDER OF RANKINGS  HIGHEST TO LOWEST
        5 of kind
        4 of kind
        full house
        straight
        3 of kind
        two pair
        one pair
    */  

    function Init()
    {
        self.AddValues();
    }

    function OnCollisionStay(obj)
    {
        if (obj.Type == "Human" && obj.IsMainCharacter)
        {
            self._collidingHuman = obj;
        }
    }

    function OnCollisionExit(obj)
    {
        if (obj.Type == "Human" && obj.IsMainCharacter)
        {
            if (self._isActive)
            {
                self.Hide();
                self._isActive = false;
            }
        }
    }

    function OnTick()
    {
        self._collidingHuman = null;
    }

    function OnCharacterDie(victim, killer, killerName)
    {
        if (victim.Type == "Human" && victim.IsMainCharacter)
        {
            if (self._isActive)
            {
                self.Hide();
                self._isActive = false;
            }
        }
    }

    function OnFrame()
    {
        if (self._collidingHuman != null)
        {
            if (Input.GetKeyDown(InputInteractionEnum.Function1))
            {
                if (!self._isActive)
                {
                    if (!self._built) {self.BuildUI();}
                    self.Show();
                    self._isActive = true;
                }
                elif (self._isActive)
                {
                    self.ResetContainers();
                    self.Hide();
                    self._isActive = false;
                }
            }
            
            UI.SetLabelForTime("MiddleCenter", "Press " + Input.GetKeyName(InputInteractionEnum.Function1) + " to open dice poker", 0.2);
        }
    }

    ##UI functions
    _BG = null;
    function BuildUI()
    {
        self._root = UI.GetRootVisualElement();

        self._BG = UI.VisualElement()
            .Width(100,true)
            .Height(100,true)
            .SetBackgroundImage(UI.Image("Backgrounds/DarkBackgroundTextured"));
        self._root.Add(self._BG);

        self._container = UI.VisualElement()
                .Absolute(true)
                .Width(0,true)
                .Height(65,true)
                .BackgroundColor(self.bgColor)
                .BorderWidth(5)
                .BorderColor(Color("#ff0000"))
                .BorderRadius(250)
                .AlignSelf(AlignEnum.Center)
                .FlexDirection(FlexDirectionEnum.Column)
                .Bottom(30,true);
        self._root.Add(self._container);

        titleContainer = UI.VisualElement()
            .FlexDirection(FlexDirectionEnum.Row)
            .JustifyContent(JustifyEnum.Center)
            .AlignSelf(AlignEnum.Center)
            .Height(150);
        self._container.Add(titleContainer);

        title = UI.Label("❤Dice Poker❤")
                .FontSize(30)
                .TextAlign(TextAlignEnum.UpperCenter)
                .FontStyle(FontStyleEnum.BoldAndItalic);
        titleContainer.Add(title);

        dealerTitle = UI.Label("Bot")
                .FontSize(25)
                .TextAlign(TextAlignEnum.MiddleCenter)
                .FontStyle(FontStyleEnum.Bold);
        self._container.Add(dealerTitle);

        self.dealerDiceContainer = UI.VisualElement()
                .Width(100,true)
                .Height(50)
                .FlexDirection(FlexDirectionEnum.Row)
                .AlignItems(AlignEnum.Center)
                .AlignSelf(AlignEnum.Center)
                .Margin(50)
                .JustifyContent(JustifyEnum.Center);
        self._container.Add(self.dealerDiceContainer);

        handLabel = UI.Label("Bot Hand:")
                .FontSize(25)
                .TextAlign(TextAlignEnum.MiddleCenter)
                .FontStyle(FontStyleEnum.Bold);
        self._container.Add(handLabel);

        self._bHandLabelCont = UI.VisualElement()
            .Width(20)
            .Height(18)
            .AlignSelf(AlignEnum.Center);
        self._container.Add(self._bHandLabelCont);

        self.botHand = UI.VisualElement()
                .Width(100,true)
                .Height(50)
                .FlexDirection(FlexDirectionEnum.Row)
                .AlignSelf(AlignEnum.Center)
                .AlignItems(AlignEnum.Center)
                .Margin(20);
        self._container.Add(self.botHand);

        divider = UI.VisualElement()
                .Width(100,true)
                .Height(5)
                .BackgroundColor(Color("#eeff00"))
                .Margin(20)
                .AlignSelf(AlignEnum.Center);
        self._container.Add(divider);

        playerTitle = UI.Label("Player")
                .FontSize(25)
                .TextAlign(TextAlignEnum.MiddleCenter)
                .FontStyle(FontStyleEnum.Bold);
        self._container.Add(playerTitle);

        self.playerDiceContainer = UI.VisualElement()
                .Width(100,true)
                .Height(50)
                .FlexDirection(FlexDirectionEnum.Row)
                .AlignItems(AlignEnum.Center)
                .AlignSelf(AlignEnum.Center)
                .Margin(50)
                .JustifyContent(JustifyEnum.Center);
        self._container.Add(self.playerDiceContainer);

        handLabel = UI.Label("Player Hand:")
                .FontSize(25)
                .TextAlign(TextAlignEnum.MiddleCenter)
                .FontStyle(FontStyleEnum.Bold);
        self._container.Add(handLabel);

        self._pHandLabelCont = UI.VisualElement()
            .Width(20)
            .Height(18)
            .AlignSelf(AlignEnum.Center);
        self._container.Add(self._pHandLabelCont);

        self.playerHand = UI.VisualElement()
                .Width(100,true)
                .Height(50)
                .FlexDirection(FlexDirectionEnum.Row)
                .AlignSelf(AlignEnum.Center)
                .AlignItems(AlignEnum.Center)
                .Margin(20);
        self._container.Add(self.playerHand);

        buttonContainer = UI.VisualElement()
                .Width(100,true)
                .Height(20)
                .FlexDirection(FlexDirectionEnum.Row)
                .JustifyContent(JustifyEnum.Center)
                .AlignSelf(AlignEnum.Center)
                .AlignItems(AlignEnum.Center)
                .Margin(20);
        self._container.Add(buttonContainer);

        self._rollBTN = UI.Button("Roll", self.OnRollClicked)
                .Width(60)
                .Height(30)
                .BorderRadius(10)
                .BackgroundColor(self.buttonColor)
                .AlignSelf(AlignEnum.Center);
        buttonContainer.Add(self._rollBTN);

        self.lastBetBTN = UI.Button("Bet Last", self.OnLastClicked)
                .Width(60)
                .Height(30)
                .BorderRadius(10)
                .BackgroundColor(self.buttonColor)
                .AlignSelf(AlignEnum.Center);
        buttonContainer.Add(self.lastBetBTN);

        self.bet5BTN = UI.Button("+5", self.OnBet5Clicked)
                .Width(60)
                .Height(30)
                .BorderRadius(10)
                .BackgroundColor(self.buttonColor)
                .AlignSelf(AlignEnum.Center);
        buttonContainer.Add(self.bet5BTN);

        self.minus5BTN = UI.Button("-5", self.OnMinus5Clicked)
                .Width(60)
                .Height(30)
                .BorderRadius(10)
                .BackgroundColor(self.buttonColor)
                .AlignSelf(AlignEnum.Center);
        buttonContainer.Add(self.minus5BTN);

        self.bet100BTN = UI.Button("+100", self.OnBet100Clicked)
                .Width(60)
                .Height(30)
                .BorderRadius(10)
                .BackgroundColor(self.buttonColor)
                .AlignSelf(AlignEnum.Center);
        buttonContainer.Add(self.bet100BTN);

        self.minus100BTN = UI.Button("-100", self.OnMinus100Clicked)
                .Width(60)
                .Height(30)
                .BorderRadius(10)
                .BackgroundColor(self.buttonColor)
                .AlignSelf(AlignEnum.Center);
        buttonContainer.Add(self.minus100BTN);
    }

    function Show()
    {
        UI.SetLabelActive("MiddleCenter", false);
        self._container
            .Width(self.defaultWidth)
            .MarginLeft(0.5,true)
            .MarginRight(0.5,true);
        self.DisableInputs();

        UI.SetLabel(UILabelEnum.BottomCenter,UI.WrapStyleTag("Current Bet: ", "color", "#f43ffa") + self._currentBet +  String.Newline + UI.WrapStyleTag("Coins: ", "color", "#f43ffa") + Main.Coins + String.Newline + String.Newline + String.Newline);
        UI.SetLabelActive("BottomCenter", true);
        if (Network.MyPlayer.Character == null) {return;}
        UI.ForceHideNames = true;
    }

    function Hide()
    {
        UI.SetLabelActive("MiddleCenter", true);
        self._container
            .Width(0)
            .Height(0);
        self.EnableInputs();
        self._container.Clear();
        self._container.Active(false);
        self._BG.Clear();
        self._BG.Active(false);
        self.ResetContainers();
        UI.SetLabelActive("BottomCenter", false);
        if (Network.MyPlayer.Character == null) {return;}
        UI.ForceHideNames = false;
    }

    function OnRollClicked()
    {
        if (self._currentBet <= 0) {Game.Print("Place a bet"); return;}
        Main.Coins -= self._currentBet;
        self.Roll(self._playerDice);
        self.Roll(self._dealerDice);

        self.EndResults();
    }

    function OnLastClicked()
    {
        if (Main.Coins <= 0) {Game.Print("Not enough coins"); return;}

        if (self._lastBet < Main.Coins)
        {
            self._currentBet += self._lastBet;
        }
        else
        {
            Game.Print("Exceeding coins!");
        }
        UI.SetLabel(UILabelEnum.BottomCenter,UI.WrapStyleTag("Current Bet: ", "color", "#f43ffa") + self._currentBet +  String.Newline + UI.WrapStyleTag("Coins: ", "color", "#f43ffa") + Main.Coins + String.Newline + String.Newline + String.Newline);
    }

    function OnBet5Clicked()
    {
        if (Main.Coins <= 0) {Game.Print("Not enough coins"); return;}

        if (self._currentBet < Main.Coins)
        {
            self._currentBet += 5;
        }
        else
        {
            Game.Print("Exceeding coins!");
        }
        UI.SetLabel(UILabelEnum.BottomCenter,UI.WrapStyleTag("Current Bet: ", "color", "#f43ffa") + self._currentBet +  String.Newline + UI.WrapStyleTag("Coins: ", "color", "#f43ffa") + Main.Coins + String.Newline + String.Newline + String.Newline);
    }

    function OnMinus5Clicked()
    {
        if (Main.Coins <= 0) {Game.Print("Not enough coins"); return;}

        if (self._currentBet <= Main.Coins && self._currentBet > 0)
        {
            self._currentBet -= 5;
        }
        else
        {
            Game.Print("Exceeding coins!");
        }
        UI.SetLabel(UILabelEnum.BottomCenter,UI.WrapStyleTag("Current Bet: ", "color", "#f43ffa") + self._currentBet +  String.Newline + UI.WrapStyleTag("Coins: ", "color", "#f43ffa") + Main.Coins + String.Newline + String.Newline + String.Newline);
    }

    function OnBet100Clicked()
    {
        if (Main.Coins <= 0) {Game.Print("Not enough coins"); return;}

        if (self._currentBet < Main.Coins)
        {
            self._currentBet += 100;
        }
        else
        {
            Game.Print("Exceeding coins!");
        }
        UI.SetLabel(UILabelEnum.BottomCenter,UI.WrapStyleTag("Current Bet: ", "color", "#f43ffa") + self._currentBet +  String.Newline + UI.WrapStyleTag("Coins: ", "color", "#f43ffa") + Main.Coins + String.Newline + String.Newline + String.Newline);
    }

    function OnMinus100Clicked()
    {
        if (Main.Coins <= 0) {Game.Print("Not enough coins"); return;}

        if (self._currentBet <= Main.Coins && self._currentBet > 0) 
        {
            self._currentBet -= 100;
        }
        else
        {
            Game.Print("Exceeding coins!");
        }
        UI.SetLabel(UILabelEnum.BottomCenter,UI.WrapStyleTag("Current Bet: ", "color", "#f43ffa") + self._currentBet +  String.Newline + UI.WrapStyleTag("Coins: ", "color", "#f43ffa") + Main.Coins + String.Newline + String.Newline + String.Newline);
    }

    function CreateDice(diceNum)
    {
        diceContainer = UI.VisualElement()
            .Width(self.DiceWidth)
            .Height(self.DiceHeight)
            .BackgroundColor(Color("#ffff"))
            .BorderRadius(5)
            .JustifyContent(JustifyEnum.Center)
            .MarginLeft(15 / 2)
            .MarginRight(15 / 2)
            .AlignSelf(AlignEnum.Center)
            .AlignItems(AlignEnum.Center);
        label = UI.Label(diceNum)
            .FontStyle(FontStyleEnum.Bold);
        diceContainer.Add(label);

        return diceContainer;
    }

    function Update()
    {
        self.Hide();
        self._container.Clear();
        self.BuildUI();
        self.Show();
    }

    function ResetContainers()
    {
        self.playerDiceContainer.Clear();
        self.dealerDiceContainer.Clear();
        self._pHandLabelCont.Clear();
        self._bHandLabelCont.Clear();
    } 

    #### main functions for handling the game
    function AddValues()
    {
        for (i in Range(1, 7, 1))
        {
            self._values.Add(i);
            self._values.Add(i);
            self._values.Add(i);
            self._values.Add(i);
            self._values.Add(i);
        }
        randomizedValues = self._values.Randomize();
        self._values = randomizedValues;
    }

    coroutine Roll(hand)
    {
        hand.Clear();
        self.ResetContainers();
        self._resultB = null;
        self._resultP = null;
        self.ResetBools();
        i = 0;
        self._isRolling = true;
        self.HideButtons();
        while (i < 5)
        {
            wait 1;
            if (self._values.Count <= 0) {self.AddValues();}
            value = self._values.Get(0);

            hand.Add(value);
            self._values.Remove(value);

            dice = self.CreateDice(Convert.ToString(hand.Get(i)));
            if (hand == self._playerDice)
            {
                self.playerDiceContainer.Add(dice);
            }
            elif (hand == self._dealerDice)
            {
                self.dealerDiceContainer.Add(dice);
            }
            i += 1;
        }
        self._isRolling = false;
    }

    coroutine EndResults()
    {
        wait 6;
        self.AddValuesToDict(self._playerDice);
        self.AddValuesToDict(self._dealerDice);

        self._sortedP = self.Sort(self._playerDice);
        self._sortedD = self.Sort(self._dealerDice);

        self._resultP = self.EvaluateHand(self._sortedP);
        self._resultB = self.EvaluateHand(self._sortedD);

        label = UI.Label(self._resultP)
                .FontSize(20)
                .FontStyle(FontStyleEnum.Bold)
                .TextAlign(TextAlignEnum.MiddleCenter);

        labelB = UI.Label(self._resultB)
                .FontSize(20)
                .FontStyle(FontStyleEnum.Bold)
                .TextAlign(TextAlignEnum.MiddleCenter);

        self._pHandLabelCont.Add(label);
        self._bHandLabelCont.Add(labelB);

        winner = self.FindWinner();
        self.ShowButtons();
        if (winner == "") {winner = "None";}
        if (winner == "Player") {Game.Print("Winner " + winner + " +" + self._currentBet + " Coins");}
        self._currentBet = 0;
        UI.SetLabel(UILabelEnum.BottomCenter,UI.WrapStyleTag("Current Bet: ", "color", "#f43ffa") + self._currentBet +  String.Newline + UI.WrapStyleTag("Coins: ", "color", "#f43ffa") + Main.Coins + String.Newline + String.Newline + String.Newline);
    }

    function RollAll()
    {
        self._playerDice.Clear();
        self._dealerDice.Clear();
        self.ResetBools();

        for (i in Range(1,6,1))
        {
            if (self._values.Count <= 0) {self.AddValues();}
            value = self._values.Get(0);

            self._playerDice.Add(value);
            self._values.Remove(value);
        }

        for (i in Range(1,6,1))
        {
            if (self._values.Count <= 0) {self.AddValues();}
            value = self._values.Get(0);

            self._dealerDice.Add(value);
            self._values.Remove(value);
        }

        self.AddValuesToDict(self._playerDice);
        self.AddValuesToDict(self._dealerDice);

        self._sortedP = self.Sort(self._playerDice);
        self._sortedD = self.Sort(self._dealerDice);

        Game.Print("Player|"+self._sortedP);
        Game.Print("Dealer|"+self._sortedD);

        self.EvaluateHand(self._sortedP);
        self.EvaluateHand(self._sortedD);
        self.FindWinner();
    }

    function AddValuesToDict(list)
    {
        if (list == self._playerDice)
        {
            value = list.Get(0);

            for (value in list)
            {
                if (value == 1)
                {
                    self._playersDiceDict.Set(1, value);
                }
                elif (value == 2)
                {
                    self._playersDiceDict.Set(2, value);
                }
                elif (value == 3)
                {
                    self._playersDiceDict.Set(3, value);
                }
                elif (value == 4)
                {
                    self._playersDiceDict.Set(4, value);
                }
                elif (value == 5)
                {
                    self._playersDiceDict.Set(5, value);
                }
                elif (value == 6)
                {
                    self._playersDiceDict.Set(6, value);
                }
            }
        }
        elif (list == self._dealerDice)
        {
            value = list.Get(0);

            for (value in list)
            {
                if (value == 1)
                {
                    self._dealerDiceDict.Set(1, value);
                }
                elif (value == 2)
                {
                    self._dealerDiceDict.Set(2, value);
                }
                elif (value == 3)
                {
                    self._dealerDiceDict.Set(3, value);
                }
                elif (value == 4)
                {
                    self._dealerDiceDict.Set(4, value);
                }
                elif (value == 5)
                {
                    self._dealerDiceDict.Set(5, value);
                }
                elif (value == 6)
                {
                    self._dealerDiceDict.Set(6, value);
                }
            }
        }
        
    }

    function Sort(hand)
    {
        if (hand == self._playerDice)
        {
            hand.SortCustom(self.ComparePlayer);
        }
        elif (hand == self._dealerDice)
        {
            hand.SortCustom(self.CompareDealer);
        }
        return hand;
    }

    function ComparePlayer(a, b)
    {
        valueA = self._playersDiceDict.Get(a);
        valueB = self._playersDiceDict.Get(b);

        if (valueA < valueB) {return 1;}
        if (valueA > valueB) {return -1;}
        return 0;
    }

    function CompareDealer(a, b)
    {
        valueA = self._dealerDiceDict.Get(a);
        valueB = self._dealerDiceDict.Get(b);

        if (valueA < valueB) {return 1;}
        if (valueA > valueB) {return -1;}
        return 0;
    }

    function SortAscending(a, b)
    {
        if (a < b) {return 1;}
        if (a > b) {return -1;}
        return 0;
    }

    #@param hand List
    function EvaluateHand(hand)
    {     
        freq = Dict();
        highValue = hand.Get(0);

        for (value in hand)
        {         
            if (freq.Contains(value))
            {
                freq.Set(value, freq.Get(value) + 1);
            }
            else
            {
                freq.Set(value, 1);
            }
        }
        #Game.Print(freq);

        counts = List();

        for (key in freq.Keys)
        {
            counts.Add(freq.Get(key));
        }
        counts.SortCustom(self.SortAscending);
        #Game.Print(counts);

        if (hand == self._sortedP)
        {
            self._highVDict.Set("P", highValue);
        }
        elif (hand == self._sortedD)
        {
            self._highVDict.Set("B", highValue);
        }
        

        if (hand.Get(0) == 6)
        {
            if (hand.Get(1) == 5)
            {
                if (hand.Get(2) == 4)
                {
                    if (hand.Get(3) == 3)
                    {
                        if (hand.Get(4) == 2)
                        {
                            if (hand == self._sortedP) {Game.Print("Player Straight!!!"); self._PhasStraight = true;}
                            elif (hand == self._sortedD) {Game.Print("Dealer Straight!!!"); self._DhasStraight = true;}
                            return RankingEnums.S;
                        }
                    }
                }
            }
        }
        elif (hand.Get(0) == 5)
        {
            if (hand.Get(1) == 4)
            {
                if (hand.Get(2) == 3)
                {
                    if (hand.Get(3) == 2)
                    {
                        if (hand.Get(4) == 1)
                        {
                            if (hand == self._sortedP) {Game.Print("Player Straight!!!"); self._PhasStraight = true;}
                            elif (hand == self._sortedD) {Game.Print("Dealer Straight!!!"); self._DhasStraight = true;}
                            return RankingEnums.S;
                        }
                        
                    }
                }
            }
        }

        if (counts.Count == 1)
        {
            if (hand == self._sortedP) {Game.Print("Player Has Five of A Kind!!!"); self._PhasFiveKind = true;}
            elif (hand == self._sortedD) {Game.Print("Dealer Has Five of A Kind!!!"); self._DhasFiveKind = true;}
            return RankingEnums.FvK;
        }
        elif (counts.Contains(4))
        {
            if (hand == self._sortedP) {Game.Print("Player Has Four of A Kind!!!"); self._PhasFourKind = true;}
            elif (hand == self._sortedD) {Game.Print("Dealer Has Four of A Kind!!!"); self._DhasFourKind = true;}
            return RankingEnums.FK;
        }
        elif (counts.Contains(3) && counts.Contains(2))
        {
            if (hand == self._sortedP) {Game.Print("Player Has Full House!!!"); self._PhasFullHouse = true;}
            elif (hand == self._sortedD) {Game.Print("Dealer Has Full House!!!"); self._DhasFullHouse = true;}
            return RankingEnums.FH;      
        }
        elif (counts.Contains(3))
        {
            if (hand == self._sortedP) {Game.Print("Player Has Three of A Kind!!!"); self._PhasThreeKind = true;}
            elif (hand == self._sortedD) {Game.Print("Dealer Has Three of A Kind!!!"); self._DhasThreeKind = true;}
            return RankingEnums.TK;    
        }
        elif (counts.Get(0) == 2 && counts.Get(1) == 2)
        {
            if (hand == self._sortedP) {Game.Print("Player Two Pair"); self._PhasTwoPair = true;}
            elif (hand == self._sortedD) {Game.Print("Dealer Two Pair"); self._DhasTwoPair = true;}
            return RankingEnums.TP;
        }
        elif (counts.Contains(2))
        {
            if (hand == self._sortedP) {Game.Print("Player One Pair"); self._PhasPair = true;}
            elif (hand == self._sortedD) {Game.Print("Dealer One Pair"); self._DhasPair = true;}
            return RankingEnums.OP;    
        }
        else
        {
            if (hand == self._sortedP) {Game.Print("Player High Value -- " + highValue); self._PhasHighValue = true;}
            elif (hand == self._sortedD) {Game.Print("Dealer High Value -- " + highValue); self._DhasHighValue = true;}
            return RankingEnums.HV;
        }
    }

    function CheckDraw()
    {
        if (self._hasDrawed)
        {
            playerValue = self._highVDict.Get("P");
            botValue = self._highVDict.Get("B");

            if (playerValue > botValue)
            {
                Game.Print("Player wins with high value of " + playerValue + "!");
                Main.Coins += self._currentBet * 2;
                self._winner = "Player";
            }
            elif (botValue > playerValue)
            {
                Game.Print("Bot wins with high value of " + botValue + "!");
                Main.Coins -= self._currentBet;
                self._winner = "Bot";
            }
            else
            {
                Game.Print("Draw");
                Main.Coins += self._currentBet;
            }
            self._hasDrawed = false;
        }
    }

    function FindWinner()
    {

        ##Checks 5 kind
        if (self._PhasFiveKind && self._DhasFiveKind)
        {
            self._hasDrawed = true;
            self.CheckDraw();
            self._lastBet = self._currentBet;
            return self._winner;
        }
        elif (self._PhasFiveKind && !self._DhasFiveKind)
        {
            Game.Print(UI.WrapStyleTag("Player Has Five of a Kind!! Winner!!", "color", "green"));
            self._winner = "Player";
            self._lastBet = self._currentBet;
            Main.Coins += self._currentBet * 2;
            return self._winner;
        }
        elif (!self._PhasFiveKind && self._DhasFiveKind)
        {
            Game.Print(UI.WrapStyleTag("Dealer Has Five of a Kind! Player Loses!!", "color", "red"));
            self._winner = "Bot";
            self._lastBet = self._currentBet;
            return self._winner;
        }
        ##

        ##checks 4 kind
        if (self._PhasFourKind && self._DhasFourKind)
        {
            self._hasDrawed = true;
            self.CheckDraw();
            self._lastBet = self._currentBet;
            return self._winner;
        }
        elif (self._PhasFourKind && !self._DhasFourKind)
        {
            Game.Print(UI.WrapStyleTag("Player Has Four of a Kind!! Winner!!", "color", "green"));
            self._winner = "Player";
            self._lastBet = self._currentBet;
            Main.Coins += self._currentBet * 2;
            return self._winner;
        }
        elif (!self._PhasFourKind && self._DhasFourKind)
        {
            Game.Print(UI.WrapStyleTag("Dealer Has Four of a Kind! Player Loses!!", "color", "red"));
            self._winner = "Bot";
            self._lastBet = self._currentBet;
            return self._winner;
        }
        ##

        ##checks full house
        if (self._PhasFullHouse && self._DhasFullHouse)
        {
            self._hasDrawed = true;
            self.CheckDraw();
            self._lastBet = self._currentBet;
            return self._winner;
        }
        elif (self._PhasFullHouse && !self._DhasFullHouse)
        {
            Game.Print(UI.WrapStyleTag("Player Has Full House!! Winner!!", "color", "green"));
            self._winner = "Player";
            self._lastBet = self._currentBet;
            Main.Coins += self._currentBet * 2;
            return self._winner;
        }
        elif (!self._PhasFullHouse && self._DhasFullHouse)
        {
            Game.Print(UI.WrapStyleTag("Dealer Has Full House! Player Loses!!", "color", "red"));
            self._winner = "Bot";
            self._lastBet = self._currentBet;
            return self._winner;
        }
        ##

        ##checks straight
        if (self._PhasStraight && self._DhasStraight)
        {
            self._hasDrawed = true;
            self.CheckDraw();
            self._lastBet = self._currentBet;
            return self._winner;
        }
        elif (self._PhasStraight && !self._DhasStraight)
        {
            Game.Print(UI.WrapStyleTag("Player Has Straight!! Winner!!", "color", "green"));
            self._winner = "Player";
            self._lastBet = self._currentBet;
            Main.Coins += self._currentBet * 2;
            return self._winner;
        }
        elif (!self._PhasStraight && self._DhasStraight)
        {
            Game.Print(UI.WrapStyleTag("Dealer Has Straight! Player Loses!!", "color", "red"));
            self._winner = "Bot";
            self._lastBet = self._currentBet;
            return self._winner;
        }
        ##

        ##checks 3 kind
        if (self._PhasThreeKind && self._DhasThreeKind)
        {
            self._hasDrawed = true;
            self.CheckDraw();
            self._lastBet = self._currentBet;
            return self._winner;
        }
        elif (self._PhasThreeKind && !self._DhasThreeKind)
        {
            Game.Print(UI.WrapStyleTag("Player Has Three of a Kind!! Winner!!", "color", "green"));
            self._winner = "Player";
            self._lastBet = self._currentBet;
            Main.Coins += self._currentBet * 2;
            return self._winner;
        }
        elif (!self._PhasThreeKind && self._DhasThreeKind)
        {
            Game.Print(UI.WrapStyleTag("Dealer Has Three of a Kind! Player Loses!!", "color", "red"));
            self._winner = "Bot";
            self._lastBet = self._currentBet;
            return self._winner;
        }
        ##

        ##checks two pair
        if (self._PhasTwoPair && self._DhasTwoPair)
        {
            self._hasDrawed = true;
            self.CheckDraw();
            self._lastBet = self._currentBet;
            return self._winner;
        }
        elif (self._PhasTwoPair && !self._DhasTwoPair)
        {
            Game.Print(UI.WrapStyleTag("Player Has Two Pair!! Winner!!", "color", "green"));
            self._winner = "Player";
            self._lastBet = self._currentBet;
            Main.Coins += self._currentBet * 2;
            return self._winner;
        }
        elif (!self._PhasTwoPair && self._DhasTwoPair)
        {
            Game.Print(UI.WrapStyleTag("Dealer Has Two Pair! Player Loses!!", "color", "red"));
            self._winner = "Bot";
            self._lastBet = self._currentBet;
            return self._winner;
        }
        ##

        ##checks one pair
        if (self._PhasPair && self._DhasPair)
        {
            self._hasDrawed = true;
            self.CheckDraw();
            self._lastBet = self._currentBet;
            return self._winner;
        }
        elif (self._PhasPair && !self._DhasPair)
        {
            Game.Print(UI.WrapStyleTag("Player Has Pair!! Winner!!", "color", "green"));
            self._winner = "Player";
            self._lastBet = self._currentBet;
            Main.Coins += self._currentBet * 2;
            return self._winner;
        }
        elif (!self._PhasPair && self._DhasPair)
        {
            Game.Print(UI.WrapStyleTag("Dealer Has Pair! Player Loses!!", "color", "red"));
            self._winner = "Bot";
            self._lastBet = self._currentBet;
            return self._winner;
        }
        ##

        ##checks high value
        if (self._PhasHighValue && self._DhasHighValue)
        {
            self._hasDrawed = true;
            self.CheckDraw();
            self._lastBet = self._currentBet;
            return self._winner;
        }
        elif (self._PhasHighValue && !self._DhasHighValue)
        {
            Game.Print(UI.WrapStyleTag("Player Has Highest Value!! Winner!!", "color", "green"));
            self._winner = "Player";
            self._lastBet = self._currentBet;
            Main.Coins += self._currentBet * 2;
            return self._winner;
        }
        elif (!self._PhasHighValue && self._DhasHighValue)
        {
            Game.Print(UI.WrapStyleTag("Dealer Has Highest Value! Player Loses!!", "color", "red"));
            self._winner = "Bot";
            self._lastBet = self._currentBet;
            return self._winner;
        }
        ##
    }

    function ResetBools()
    {
        self._PhasHighValue = false;
        self._PhasPair = false;
        self._PhasTwoPair = false;
        self._PhasThreeKind = false;
        self._PhasStraight = false;
        self._PhasFullHouse = false;
        self._PhasFourKind = false;
        self._PhasFiveKind = false;

        self._DhasHighValue = false;
        self._DhasPair = false;
        self._DhasTwoPair = false;
        self._DhasThreeKind = false;
        self._DhasStraight = false;
        self._DhasFullHouse = false;
        self._DhasFourKind = false;
        self._DhasFiveKind = false;
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

    function HideButtons()
    {
        self.bet5BTN.Active(false);
        self._rollBTN.Active(false);
        self.bet100BTN.Active(false);
        self.minus5BTN.Active(false);
        self.minus100BTN.Active(false);
        self.lastBetBTN.Active(false);
    }

    function ShowButtons()
    {
        self.bet5BTN.Active(true);
        self._rollBTN.Active(true);
        self.bet100BTN.Active(true);
        self.minus5BTN.Active(true);
        self.minus100BTN.Active(true);
        self.lastBetBTN.Active(true);
    }
}
extension RankingEnums
{
    FvK = "Five Of A Kind";
    FK = "Four of A Kind";    
    FH = "Full House";
    S = "Straight";
    TK = "Three of A Kind";
    TP = "Two Pair";
    OP = "One Pair";
    HV = "High Value";
}
##Poker
component TexasHoldEmPoker
{
    #Multiplayer Poker

    /*
        This will be texas hold'em poker, order of rounds go; preflop cards are dealt, flop community cards are dealt, the turn another community card dealt, the river last community card dealt
        players show their hands and combine their two cards with the 5 community cards. The strongest poker hand wins
        The dealer will be chosen at random, the player to the left of the dealer has to pay small blind, then to the left of small blind pays big blind
    */

    #UI vars
    _isActive = false;
    _root = null;
    _built = false;
    _container = null;
    _defaultWidth = 1000;
    _bgColor = Color("#026d26");

    _cardSpacing = 15;
    _cardWidth = 80;
    _cardHeight = 110;


    _myCardsContainer = null;
    _p2CardsContainer = null;
    _p3CardsContainer = null;
    _p4CardsContainer = null;
    _communityCardsContainter = null;

    _checkBTN = null;
    _callBTN = null;
    _raiseBTN = null;
    _foldBTN = null;
    _readyBTN = null;

    #Game vars
    _gameActive = false;
    _gamePhase = 0;

    _pot = 0;
    _smallBlindAmount = 10;
    _bigBlindAmount = 20;
    _smallBlind = 0;
    _bigBlind = 0;
    _raisedBet = 0;
    _currentBet = 0;

    _suits = List();
    _values = List();
    _deck = List();
    _dectDict = Dict();

    _playerDict = Dict();
    _playerHands = Dict();
    _myHand = List();
    _p1Hand = List();
    _p2Hand = List();
    _p3Hand = List();
    _p4Hand = List();
    _communityCards = List();

    _playerChips = Dict();       
    _playerBets = Dict();          
    _playerFolded = List();        
    _playerAllIn = List();       
    _readyPlayers = List();
    _actionCount = 0;
    _maxActions = 0;
    _currentTurn = null;
    _previousTurn = null;
    _lastRaiser = null;

    _voteTrigger = 0;
    _collidingHuman = null;

    function OnGameStart()
    {
        #p1Seat = Map.FindMapObjectByName("Player1").AddComponent("PokerSeat");
        #p2Seat = Map.FindMapObjectByName("Player2").AddComponent("PokerSeat");
        #p3Seat = Map.FindMapObjectByName("Player3").AddComponent("PokerSeat");
        #p4Seat = Map.FindMapObjectByName("Player4").AddComponent("PokerSeat");

        self.AddSuits();
        self.AddValues();    
        self.BuildDeck();
        
    }

    function OnCollisionStay(obj)
    {
        if (obj.Type == "Human" && obj.IsMainCharacter)
        {
            self._collidingHuman = obj;
        }
    }

    function OnFrame()
    {
        if (self._collidingHuman != null)
        {
            UI.SetLabelForTime("MiddleCenter", "Press " + Input.GetKeyName(InputInteractionEnum.Function1) + " to open poker", 0.3);
            if (Input.GetKeyDown(InputInteractionEnum.Function1) && !self._isActive)
            {
                self.Show();
                self._isActive = true;
            }
            elif (Input.GetKeyDown(InputInteractionEnum.Function1) && self._isActive)
            {
                self.Hide();
                self._isActive = false;
            }
            
        }
        
        self._collidingHuman = null;
    }

    function SendMessageToPlayers(message)
    {
        for (playerID in self._playerDict.Values)
        {
            player = Network.FindPlayer(Convert.ToInt(playerID));

            self.NetworkView.SendMessage(player, message);
        }
    }

    function OnNetworkMessage(sender, message)
    {
        args = String.Split(message, "|", true);
        rpc = args.Get(0);

        if (rpc == "Print")
        {
            winner = Convert.ToInt(args.Get(1));
            Game.Print(Network.FindPlayer(winner).ID + " wins " + self._pot + " coins!");

            self.ClearHands();
            self.ResetProperties();
            self.ResetUI();
            self.ResetGameState();
        }
        
        if (rpc == "EndHand")
        {
            winner = Convert.ToInt(args.Get(1));
            self.EndHand(winner);
        }
        

        if (rpc == "AddReady")
        {
            self._readyPlayers.Add(sender.ID);
            votes = self.CheckVotes();

            Game.Print("Players ready: " + (self._readyPlayers.Count));
            if (votes) {self.NetworkView.SendMessage(Network.MasterClient, "Go!");}
        }

        if (rpc == "WonPot") {
            coins = Convert.ToInt(args.Get(1));

            Main.Coins += coins;
        }

        if (rpc == "Action_call")
        {
            Game.Print(sender.Name + " has called");
        }
        if (rpc == "Action_check") 
        {
            Game.Print(sender.Name + " has checked");
        }
        if (rpc == "Action_fold") 
        {
            Game.Print(sender.Name + " has folded");
        }
        if (rpc == "Action_raise") 
        {
            Game.Print(sender.Name + " has raised");
            self._checkBTN.Active(false);
        }
        if (rpc == "Action_allin") 
        {
            Game.Print(sender.Name + " went all in!");
        }

        if (rpc == "MyBet")
        {
            ID = Convert.ToInt(args.Get(1));
            bet = Convert.ToInt(args.Get(2));

            self._playerBets.Set(ID, bet);
        }

        if (rpc == "TurnUpdate")
        {
            #@type Dict
            turnData = Json.LoadFromString(args.Get(1));

            self._currentTurn = turnData.Get("turn");
            self._gamePhase = turnData.Get("phase");
            self._pot = turnData.Get("pot");
            self._currentBet = turnData.Get("currentBet");
            self._actionCount = turnData.Get("actions");
            player = Network.FindPlayer(self._currentTurn);
            Game.Print("Current turn: " +  player.Name);
        }
        

        if (rpc == "StartPreflopBetting")
        {
            self.StartBetting(GamePhaseEnum.preflop);
        }

        if (rpc == "MyChips")
        {
            ID = Convert.ToInt(args.Get(1));
            chips = Convert.ToInt(args.Get(2));

            self._playerChips.Set(ID, chips);
        }
        
        if (rpc == "ActivateUI")
        {
            self.Hide();
            self.BuildUI();
            if (self._gamePhase == GamePhaseEnum.preflop) {self._checkBTN.Active(false);}
            self._readyBTN.Active(false);
            self.DealOut(self._myHand);
            self.DealOut(self._p2Hand);
            self.DealOut(self._p3Hand);
            self.DealOut(self._p4Hand);

            self.DealOut(self._communityCards);
            self.Show();
            #Game.Print("ACTIVATED");
        }
        if (rpc == "ActivateUIFlop")
        {
            self.Hide();
            #self.StartBetting(GamePhaseEnum.flop);
            self.BuildUI();
            self._checkBTN.Active(true);
            self.DealOut(self._myHand);
            self.DealOut(self._p2Hand);
            self.DealOut(self._p3Hand);
            self.DealOut(self._p4Hand);

            self.DealOut(self._communityCards);
            self.Show();
            #Game.Print("Flop");
        }
        if (rpc == "ActivateUITurn")
        {
            self.Hide();
            #self.StartBetting(GamePhaseEnum.turn);
            self.BuildUI();
            self._checkBTN.Active(true);
            self.DealOut(self._myHand);
            self.DealOut(self._p2Hand);
            self.DealOut(self._p3Hand);
            self.DealOut(self._p4Hand);

            self.DealOut(self._communityCards);
            self.Show();
            #Game.Print("Turn");
        }
        if (rpc == "ActivateUIRiver")
        {
            self.Hide();
            #self.StartBetting(GamePhaseEnum.river);
            self.BuildUI();
            self._checkBTN.Active(true);
            self.DealOut(self._myHand);
            self.DealOut(self._p2Hand);
            self.DealOut(self._p3Hand);
            self.DealOut(self._p4Hand);

            self.DealOut(self._communityCards);
            self.Show();
           # Game.Print("ACTIVATED");
        }
        if (rpc == "ActivateUISHOWDOWN")
        {
            self.Hide();
            #self.Showdown();
            self.BuildUI();
            self._checkBTN.Active(true);
            self.DealOut(self._myHand);
            self.DealOut(self._p2Hand);
            self.DealOut(self._p3Hand);
            self.DealOut(self._p4Hand);

            self.DealOut(self._communityCards);
            self.Show();
           # Game.Print("ACTIVATED");
        }

        if (rpc == "SmallBlind")
        {
            smallblindID = args.Get(1);

            self._smallBlind = smallblindID;
            Game.Print("You are small blind, you must pay " + self._smallBlindAmount + " coins");
            #self._pot += self._smallBlindAmount;
            Main.Coins -= self._smallBlindAmount;

            self.SendMessageToPlayers("UpdatePot|" + self._smallBlindAmount);
        }

        if (rpc == "BigBlind")
        {
            bigBlindID = args.Get(1);

            self._bigBlind = bigBlindID;
            Game.Print("You are big blind, you must pay " + self._bigBlindAmount + " coins");
            #self._pot += self._bigBlindAmount;
            Main.Coins -= self._bigBlindAmount;

            self.SendMessageToPlayers("UpdatePot|" + self._bigBlindAmount);
        }
        
        if (rpc == "Players")
        {
            dict = Json.LoadFromString(args.Get(1));

            self._playerDict = dict;
            #Game.Print(self._playerDict);
        }
        
        if (rpc == "UpdatePot")
        {
            potAMT = Convert.ToInt(args.Get(1));

            self._pot += potAMT;
        }

        if (rpc == "Dealing")
        {
            self.DealCard(self._myHand);
            self.DealCard(self._myHand);

            for (key in self._playerDict.Keys)
            {
                if (Convert.ToInt(self._playerDict.Get(key)) == Network.MyPlayer.ID)
                {
                    json = Json.SaveToString(self._myHand);
                    self.SendMessageToPlayers("PlayerCards|" + json + "|" + key + "|" + Network.MyPlayer.ID);
                    self._playerChips.Set(Network.MyPlayer.ID, Main.Coins);
                    self.SendMessageToPlayers("MyChips|" + Network.MyPlayer.ID + "|" + Main.Coins);
                }
                
            }
        }
        
        if (rpc == "Community")
        {
            CommunityCards = Json.LoadFromString(args.Get(1));

            self._communityCards = CommunityCards;
        }

        if (rpc == "PlayerCards")
        {
            cards = Json.LoadFromString(args.Get(1));
            key = args.Get(2);
            ID = Convert.ToInt(args.Get(3));

            if (key == "P1")
            {
                self._p1Hand = cards;
                self._playerHands.Set(ID, self._p1Hand);
                #Game.Print(cards);
            }
            elif (key == "P2")
            {
                self._p2Hand = cards;
                self._playerHands.Set(ID, self._p2Hand);
                #Game.Print(cards);
            }
            elif (key == "P3")
            {
                self._p3Hand = cards;
                self._playerHands.Set(ID, self._p3Hand);
            }
            elif (key == "P4")
            {
                self._p4Hand = cards;
                self._playerHands.Set(ID, self._p4Hand);
            }
        }
        

        if (!Network.IsMasterClient) {return;}
        if (rpc == "Player1")
        {
            ID = args.Get(1);
            self._playerDict.Set("P1", ID);
        }
        elif (rpc == "Player2")
        {
            ID = args.Get(1);
            self._playerDict.Set("P2", ID);
        }
        elif (rpc == "Player3")
        {
            ID = args.Get(1);
            self._playerDict.Set("P3", ID);
        }
        elif (rpc == "Player4")
        {
            ID = args.Get(1);
            self._playerDict.Set("P4", ID);
        }

        if (rpc == "Starting")
        {
            self.PreflopBlinds();
        }

        if (rpc == "DealTO")
        {
            self.SendMessageToPlayers("Dealing");
        }
        if (rpc == "Go!")
        {
            if(!self._triggered)
            {
                self.Deal();
                self._triggered = true;
            }
        }
        
    }

    _triggered = false;
    function CheckVotes()
    {
        count = self._playerDict.Count;
        readied = self._readyPlayers.Count;
        amount = List();

        trigger = count / 2;
        vTrigger = Math.Round(trigger);
        if (count == 2) {
            self._voteTrigger = 2;
        }
        elif (count == 3) {
            self._voteTrigger = 2;
        }
        else
        {
            self._voteTrigger = vTrigger;
        }
        
        if (readied >= self._voteTrigger)
        {
            return true;
        }
        else 
        {
            return false;
        }
    }

    function PreflopBlinds()
    {
        self._gamePhase = GamePhaseEnum.preflop;
        json = Json.SaveToString(self._playerDict);
        self.SendMessageToPlayers("Players|" + json);

        allPlayerIDs = List();
        for (id in self._playerDict.Values)
        {
            allPlayerIDs.Add(Convert.ToInt(id));
        }

        shuffled = allPlayerIDs.Randomize();

        if (shuffled.Count >= 2)
        {
            smallID = shuffled.Get(0);
            bigID = shuffled.Get(1);

            for (player in Network.Players)
            {
                if (player.ID == smallID)
                {
                    self.NetworkView.SendMessage(player, "SmallBlind|" + player.ID);
                    player.SetCustomProperty("SB", true);
                    #Game.Print(player.Name + " is Small Blind");
                }
                if (player.ID == bigID)
                {
                    self.NetworkView.SendMessage(player, "BigBlind|" + player.ID);
                    player.SetCustomProperty("BB", true);
                    #Game.Print(player.Name + " is Big Blind");
                }
            }
        }
        else
        {
            Game.Print("Not enough players for blinds");
        }   
    }

    function StartBetting(phase)
    {
        #@type List
        activePlayers = self.GetActivePlayers();

        if (activePlayers.Count < 2)
        {
            Game.Print("Not enough players");
            return;
        }
        
        self._actionCount = 0;
        self._maxActions = activePlayers.Count;
        self._lastRaiser = null;

        if (phase == GamePhaseEnum.preflop)
        {
            self._currentBet = self._bigBlindAmount;
        }
        else
        {
            self._currentBet = 0;
        }

        if (phase == GamePhaseEnum.preflop)
        {
            small = self.FindIndex(activePlayers, self._smallBlind);

            if (small == -1) {small = 0;}

            next = (small + 2) % activePlayers.Count;
            self._currentTurn = activePlayers.Get(next);

        }
        else
        {
            small = self.FindIndex(activePlayers, self._smallBlind);

            if (small != -1 )
            {
                self._currentTurn = self._smallBlind;
            }
            else
            {
                self._currentTurn = activePlayers.Get(0);
            }   
        }

        #Game.Print("Current turn: " + self._currentTurn);

        self.TurnUpdate();
    }

    function NextTurn()
    {
        #@type bool
        result = self.CheckRoundEnd();
        if (result)
        {
            self.TurnUpdate();
            self.NextPhase();
            #Game.Print("advanced to the next phase");
            Network.MyPlayer.Character.PlaySound(HumanSoundEnum.Checkpoint);
            return;
        }
        
        activePlayers = self.GetActivePlayers();
        if (activePlayers.Count == 0) { return; }
        
        currentIdx = self.FindIndex(activePlayers, self._currentTurn);
        nextIdx = (currentIdx + 1) % activePlayers.Count;
        self._currentTurn = activePlayers.Get(nextIdx);
        
        while (self._playerFolded.Contains(self._currentTurn))
        {
            nextIdx = (nextIdx + 1) % activePlayers.Count;
            self._currentTurn = activePlayers.Get(nextIdx);
        }
        
        #Game.Print("phase not advanced");
        self.TurnUpdate();
        #self.SendMessageToPlayers("ActivateUI");
    }

    function NextPhase()
    {
        self._playerBets.Clear();
        self._currentBet = 0;
        playersInHand = self.GetPlayersInHand();
        
        if (playersInHand.Count <= 1)
        {
            self.EndHand(playersInHand.Get(0));
            return;
        }
        
        if (self._gamePhase == GamePhaseEnum.preflop)
        {
            self._gamePhase = GamePhaseEnum.flop;
            self.DealCommunityCards(3);
            self.StartBetting(GamePhaseEnum.flop);
            self.SendMessageToPlayers("ActivateUIFlop");
        }
        elif (self._gamePhase == GamePhaseEnum.flop)
        {
            self._gamePhase = GamePhaseEnum.turn;
            self.DealCommunityCards(1);
            self.StartBetting(GamePhaseEnum.turn);
            self.SendMessageToPlayers("ActivateUITurn");
        }
        elif (self._gamePhase == GamePhaseEnum.turn)
        {
            self._gamePhase = GamePhaseEnum.river;
            self.DealCommunityCards(1);
            self.StartBetting(GamePhaseEnum.river);
            self.SendMessageToPlayers("ActivateUIRiver");
        }
        elif (self._gamePhase == GamePhaseEnum.river)
        {
            self.Showdown();
            self.SendMessageToPlayers("ActivateUISHOWDOWN");
        }
    }

    function GetActivePlayers()
    {
        active = List();
        for (playerID in self._playerDict.Values)
        {
            id = Convert.ToInt(playerID);
            #Game.Print(Convert.ToInt(self._playerChips.Get(id)));
            if (!self._playerFolded.Contains(id) && Convert.ToInt(self._playerChips.Get(id)) > 0)
            {
                active.Add(id);
            }
        }
        return active;
    }

    function GetPlayersInHand()
    {
        inHand = List();
        for (playerID in self._playerDict.Values)
        {
            id = Convert.ToInt(playerID);
            if (!self._playerFolded.Contains(id))
            {
                inHand.Add(id);
                #Game.Print("added " + id);
            }
        }
        return inHand;
    }

    function FindIndex(playerList, playerID)
    {
        for (i in Range(0, playerList.Count, 1))
        {
            if (playerList.Get(i) == playerID)
            {
                return i;               
            }
        }
        return -1;
    }

    function TurnUpdate()
    {
        turnData = Dict();
        turnData.Set("turn", self._currentTurn);
        turnData.Set("phase", self._gamePhase);
        turnData.Set("pot", self._pot);
        turnData.Set("currentBet", self._currentBet);
        turnData.Set("actions", self._actionCount);
        turnData.Set("community", self._communityCards);
        for (playerID in self._playerDict.Values)
        {
            player = Network.FindPlayer(Convert.ToInt(playerID));
            turnData.Set("hand", self._playerHands.Get(player.ID));
        }
        json = Json.SaveToString(turnData);
        self.SendMessageToPlayers("TurnUpdate|" + json);
    }

    function CheckRoundEnd()
    {
        playersInHand = self.GetPlayersInHand();
        #Game.Print(playersInHand);
        if (playersInHand.Count <= 1)
        {
            Game.Print("One player");
            return true;
        }
        
        if (self._actionCount >= self._maxActions && self._lastRaiser == null)
        {
            return true;
        }
        
        if (self._actionCount >= self._maxActions && self._lastRaiser != null)
        {
            allMatched = true;
            for (playerID in playersInHand)
            {
                bet = self._playerBets.Get(playerID);
                if (bet == null) { bet = 0; }
                if (bet < self._currentBet) 
                {
                    allMatched = false;
                    break;
                }
            }
            if (allMatched)
            {
                return true;
            }
        }

        allInCount = 0;
        for (playerID in playersInHand)
        {
            if (self._playerAllIn.Contains(playerID))
            {
                allInCount += 1;
            }
        }
        if (allInCount >= playersInHand.Count)
        {
            return true;
        }
        
        return false;
    }

    function DealCommunityCards(amount)
    {
        for (i in Range(1, amount + 1, 1))
        {
            self.DealCard(self._communityCards);  
        }      
        json = Json.SaveToString(self._communityCards);
        self.SendMessageToPlayers("Community|" + json);
    }

    function DealOut(hand)
    {
        if (hand.Count <= 0) { return;}
            if (hand == self._myHand)
            {
                for (card in hand)
                {
                    createdCard = self.CreateCardUI(card);
                    self._myCardsContainer.Add(createdCard);
                }
            }
            elif (hand == self._p2Hand)
            {
                for (card in hand)
                {
                    hiddenCard = self.HiddenHoriCard();
                    self._p2CardsContainer.Add(hiddenCard);
                }
            }
            elif (hand == self._p3Hand)
            {
                for (card in hand)
                {
                    hiddenCard = self.HiddenHoriCard();
                    self._p3CardsContainer.Add(hiddenCard);
                }
            }
            elif (hand == self._p4Hand)
            {
                for (card in hand)
                {
                    hiddenVert = self.HiddenCard();
                    self._p4CardsContainer.Add(hiddenVert);
                }
            }
            elif(hand == self._communityCards)
            {
                for (card in hand)
                {
                    cCard = self.CreateCardUI(card);
                    self._communityCardsContainter.Add(cCard);
                }
            }
    }
    
    coroutine Deal()
    {
        if (self._gameActive) {Game.Print("Game already active"); return;}
        self._gameActive = true;
        self.ClearHands();
        self.ResetProperties();
        self.ResetUI();
        self.ResetGameState();
        self._gamePhase = GamePhaseEnum.preflop;
        self.NetworkView.SendMessage(Network.MasterClient, "Starting");
        wait 0.5;
        self.SendMessageToPlayers("Dealing");
        wait 0.3;
        self.SendMessageToPlayers("StartPreflopBetting");
        wait 0.8;
        self.SendMessageToPlayers("ActivateUI");
    }

    _bestRanksDict = Dict();
    function Showdown()
    {
        playersInHand = self.GetPlayersInHand();
        bestRank = -1;
        winner = null;
        ranks = List();
        
        for (playerID in playersInHand)
        {
            hand = self._playerHands.Get(playerID);
            
            combined = self.CombineHands(hand, self._communityCards);
            rank = self.EvaluateHand(combined);
            numberedRank = Utils.RankingToNum(rank);
            self._bestRanksDict.Set(playerID, numberedRank);
        }

        for (value in self._bestRanksDict.Values)
        {
            ranks.Add(value);
        }
        ranks.SortCustom(Utils.SortAscending);
        highestVal = ranks.Get(0);
        for (key in self._bestRanksDict.Keys)
        {
            if(self._bestRanksDict.Get(key) == highestVal && ranks.Get(1) != ranks.Get(0))
            {
                winner = key;
                self.SendMessageToPlayers("EndHand|" + winner);
                return;
            }
            elif (ranks.Get(1) == ranks.Get(0))
            {
                winner = null;
                self.SendMessageToPlayers("EndHand|" + winner);
                return;
            }
        }
    }

    function EndHand(winner)
    {
        if (winner == null)
        {
            self.ResetUI();
            self.ResetGameState();
            return;
        }
        self.RevealAll();
        chips = self._playerChips.Get(winner,0);
        self._playerChips.Set(winner, chips + self._pot);

        player = Network.FindPlayer(winner);
        self.NetworkView.SendMessage(player, "WonPot|" + self._pot);
        
        self.SendMessageToPlayers("Print|" + winner);
    }

    function RevealAll()
    {
        self.RevealCards(self._p1Hand);
        self.RevealCards(self._p2Hand);
        self.RevealCards(self._p3Hand);
        self.RevealCards(self._p4Hand);
    }

    function CombineHands(hand, hand2)
    {
        combined = List();

        for (value in hand)
        {
            combined.Add(value);
        }
        for (value in hand2)
        {
            combined.Add(value);
        }
        return combined;
    }

    function Raise(amount, pID)
    {
        if (pID != self._currentTurn) {Game.Print("Not your turn"); return;}
        chips = self._playerChips.Get(pID);
        bet = self._playerBets.Get(pID,0);

        total = bet + amount;

        if (total > chips)
        {
            self.Allin(pID);
            Game.Print("All in instead");
            return;
        }
        
        self.SendMessageToPlayers("Action_raise");
        self._currentBet = amount;

        self._playerBets.Set(pID, self._currentBet);
        self._actionCount += 1;
        self._pot += self._currentBet;
        Main.Coins -= self._currentBet;
        self._lastRaiser = self._currentTurn;
        self.NextTurn();
    }

    function Check(pID)
    {
        if (pID != self._currentTurn) {Game.Print("Not your turn"); return;}
        pBet = Convert.ToInt(self._playerBets.Get(pID, 0));

        if (pBet < self._currentBet)
        {
            Game.Print("Must call or raise");
            return;
        }
        self.SendMessageToPlayers("Action_check");

        self._actionCount += 1;
        self.NextTurn();
    }                                                                                       

    coroutine Call(pID)
    {   
        if (pID != self._currentTurn) {Game.Print("Not your turn"); return;}
        self.SendMessageToPlayers("Action_call");
        self._playerBets.Set(pID, self._currentBet);
        self.SendMessageToPlayers("MyBet|" + Network.MyPlayer.ID + "|" + self._currentBet);
        wait 0.2;
        Main.Coins -= self._currentBet;
        self._actionCount += 1;
        self._playerChips.Set(pID, Main.Coins);
        self._pot += self._currentBet;
        self.NextTurn();
    }

    function Fold(pID)
    {
        if (pID != self._currentTurn) {Game.Print("Not your turn"); return;}
        self.SendMessageToPlayers("Action_fold");
        self._playerFolded.Add(pID);
        self._actionCount += 1;
        self.NextTurn();
    }

    function Allin(pID)
    {
        if (pID != self._currentTurn) {Game.Print("Not your turn"); return;}
        self.SendMessageToPlayers("Action_allin");
        chips = self._playerChips.Get(pID, 0);

        self._currentBet = chips;
        self._playerAllIn.Add(pID);
        self.SendMessageToPlayers("MyBet|" + pID + self._currentBet);
        self._pot += self._currentBet;
        self._actionCount += 1;
        self.NextTurn();
    }

    function DealCard(hand)
    {
        if (self._deck.Count == 0)
        {
            self.BuildDeck();
            #Game.Print("New Deck");
        }
        
        randomDeck = self._deck.Randomize();
        card = randomDeck.Get(0);

        randomDeck.RemoveAt(0);
        hand.Add(card);
    }

    #@param hand List
    function EvaluateHand(hand)
    {
        flush = false;
        freak = Dict();
        suitsFreak = Dict();
        dict = Dict();
        mySuits = List();
        myValues = List();

        if (hand == null) {return;}
        for (i in Range(0, hand.Count, 1))
        {
            split = String.Split(hand.Get(i), "of", true);
            if (dict.Keys.Contains(split.Get(0))) {dict.Set(split.Get(0) + split.Get(0), split.Get(1));}
            else
            {
                dict.Set(split.Get(0), split.Get(1));
            }
            split.RemoveAt(0);
        } 
        for (key in dict.Keys)
        {
            for (value in self._values)
            {
                if (String.Contains(key, value))
                {
                    mySuits.Add(dict.Get(key));
                    myValues.Add(Utils.StringTONum(value));
                }
            }
        }
        #Game.Print("MYSuit|" + mySuits);
        #Game.Print("MYvalues|"+ myValues);
        ##this counts and sorts the values
        for (value in myValues)
        {         
            if (freak.Contains(value))
            {
                freak.Set(value, freak.Get(value) + 1);
            }
            else
            {
                freak.Set(value, 1);
            }
        }

        counts = List();

        for (key in freak.Keys)
        {
            counts.Add(freak.Get(key));
        }
        counts.SortCustom(Utils.SortAscending);
        #Game.Print("Counts|" + counts);
        ####

        ##counts and sorts the amount of suits
        for (suit in mySuits)
        {
            if (suitsFreak.Contains(suit))
            {
                suitsFreak.Set(suit, suitsFreak.Get(suit) + 1);
            }
            else
            {
                suitsFreak.Set(suit, 1);
            }
        }

        suitsCounts = List();

        for (key in suitsFreak.Keys){
            suitsCounts.Add(suitsFreak.Get(key));

            if (suitsFreak.Get(key) >= 5)
            {
                flush = true;
                #Game.Print("flush");
            }
        }
        suitsCounts.SortCustom(Utils.SortAscending);
        myValues.SortCustom(Utils.SortAscending);
        high = myValues.Get(0);
        ####

        #royal flush best ranking
        if (myValues.Get(0) == 14)
        {
            if (myValues.Get(1) == 13)
            {
                if (myValues.Get(2) == 12)
                {
                    if (myValues.Get(3) == 11)
                    {
                        if (myValues.Get(4) == 10 && flush)
                        {
                            return RankingEnum.royalFlush;
                        }  
                    }
                }
            }
        }
        #check straight first
        #@type bool
        straight = self.HasStraight(myValues);

        if (straight && flush){
            return RankingEnum.straightFlush;
        }
        elif (counts.Contains(4)){
            return RankingEnum.fourKind;
        }
        elif (counts.Contains(3) && counts.Contains(2)){
            return RankingEnum.fullHouse;
        }
        elif (flush && !straight)
        {
            return RankingEnum.flush;
        }
        elif (straight && !flush) {
            return RankingEnum.straight;
        }
        elif (counts.Contains(3)) {
            return RankingEnum.threeKind;
        }
        elif (counts.Get(0) == 2 && counts.Get(1) == 2) {
            return RankingEnum.twoPair;
        }
        elif (counts.Contains(2)) {
            return RankingEnum.pair;
        }
        else
        {
            return RankingEnum.highCard + ", " + Utils.NumToString(high);
        }
    }

    function HasStraight(hand)
    {
        raanks = List();

        for (thing in hand) {
            if (!raanks.Contains(thing))
            {
                raanks.Add(thing);
            }
        }

        if (raanks.Count < 5) {return false;}
        raanks.Sort();

        for (i in Range(0,raanks.Count - 4,1))
        {
            if (raanks.Get(i) - raanks.Get(i + 4) == 4)
            {
                return true;
            }
        }

        if (raanks.Contains(14) && raanks.Contains(2) && raanks.Contains(3) && raanks.Contains(4) && raanks.Contains(5))
        {
            return true;
        }
        return false;
    }

    function AddSuits()
    {
        self._suits.Add("hearts");
        self._suits.Add("diamonds");
        self._suits.Add("clubs");
        self._suits.Add("spades");
    }

    function AddValues()
    {
        self._values.Add("A");
        self._values.Add("2");
        self._values.Add("3");
        self._values.Add("4");
        self._values.Add("5");
        self._values.Add("6");
        self._values.Add("7");
        self._values.Add("8");
        self._values.Add("9");
        self._values.Add("10");
        self._values.Add("J");
        self._values.Add("Q");
        self._values.Add("K");
    }

    function BuildDeck()
    {
        for (suit in self._suits)
        {
            for (value in self._values)
            {
                self._deck.Add(value + String.Newline + "of" + String.Newline + suit);
            }
        } 

        randomDeck = self._deck.Randomize();
        return randomDeck;
    }

    function UpdateUI()
    {
        self.Hide();
        self.BuildUI();
        self.Show();
    }

    function ResetGameState()
    {
        self._gameActive = false;
        self._communityCards.Clear();
        self._playerHands.Clear();
        self._playerBets.Clear();
        self._playerFolded.Clear();
        self._playerAllIn.Clear();
        self._readyPlayers.Clear();
        self._pot = 0;
        self._currentBet = 0;
        self._actionCount = 0;
        self._maxActions = 0;
        self._currentTurn = null;
        self._lastRaiser = null;
        self._triggered = false;
        self.ClearHands();
    }

    function ResetUI()
    {
        self._communityCardsContainter.Clear();
        self._myCardsContainer.Clear();
        self._p2CardsContainer.Clear();
        self._p3CardsContainer.Clear();
        self._p4CardsContainer.Clear();   
    }

    function ClearHands()
    {
        self._myHand.Clear();
        self._p2Hand.Clear();
        self._p3Hand.Clear();
        self._p4Hand.Clear();
        self._communityCards.Clear();
    }

    function ResetProperties()
    {
        player = Network.MyPlayer;

        player.SetCustomProperty("SB", false);
        player.SetCustomProperty("BB", false);
    }

    function RevealCards(hand)
    {
        if (hand.Count <= 0) {return;}
            if (hand == self._myHand)
            {
                for (card in hand)
                {
                    createdCard = self.CreateCardUI(card);
                    self._myCardsContainer.Add(createdCard);
                }
            }
            elif (hand == self._p2Hand)
            {
                for (card in hand)
                {
                    createdCard = self.CreateCardUI(card);
                    self._p2CardsContainer.Add(createdCard);
                }
            }
            elif (hand == self._p3Hand)
            {
                for (card in hand)
                {
                    createdCard = self.CreateCardUI(card);
                    self._p3CardsContainer.Add(createdCard);
                }
            }
            elif (hand == self._p4Hand)
            {
                for (card in hand)
                {
                    createdCard = self.CreateCardUI(card);
                    self._p4CardsContainer.Add(createdCard);
                }
            }
            elif(hand == self._communityCards)
            {
                for (card in hand)
                {
                    cCard = self.CreateCardUI(card);
                    self._communityCardsContainter.Add(cCard);
                }
            }
        self.SendMessageToPlayers("ActivateUI");
    }

    function BuildUI()
    {
        self._root = UI.GetRootVisualElement();
        self._root.Clear();
        self._built = true;

        BG = UI.VisualElement()
            .Width(100,true)
            .Height(100,true)
            .BackgroundColor(Color("#000000a6"));
        self._root.Add(BG);

        self._container = UI.VisualElement()
            .Absolute(true)
            .Width(0)
            .Height(60,true)
            .BackgroundColor(self._bgColor)
            .BorderWidth(10)
            .BorderColor(Color("#ff0000"))
            .BorderRadius(30)
            .AlignSelf(AlignEnum.Center)
            .Bottom(20,true)
            .FlexDirection(FlexDirectionEnum.Column);
        self._root.Add(self._container);

        TITLE = UI.Label("POKER!!!")
            .FontSize(25)
            .TextAlign(TextAlignEnum.UpperCenter)
            .FontStyle(FontStyleEnum.Bold);
        self._container.Add(TITLE);

        self._p4CardsContainer = UI.VisualElement()
            .Width(100,true)
            .Height(20)
            .MarginTop(50)
            .MarginLeft(10)
            .MarginRight(10)
            .AlignItems(AlignEnum.Center)
            .JustifyContent(JustifyEnum.Center)
            .FlexDirection(FlexDirectionEnum.Row);
        self._container.Add(self._p4CardsContainer);

        potLabel = UI.Label("Pot: " + self._pot + String.Newline + "Current Bet: " + self._currentBet)
            .FontSize(25)
            .TextAlign(TextAlignEnum.LowerCenter)
            .FontStyle(FontStyleEnum.Bold);
        self._container.Add(potLabel);

        combined = self.CombineHands(self._myHand, self._communityCards);
        if (combined.Count > 0) {rank = self.EvaluateHand(combined);}
        else {rank = null;}
        phaseLabel = UI.Label("Current Rank: " + rank)
            .FontSize(25)
            .TextAlign(TextAlignEnum.LowerCenter)
            .FontStyle(FontStyleEnum.Bold);
        self._container.Add(phaseLabel);

        vert = UI.VisualElement()
            .Width(100,true)
            .Height(100,true)
            .Margin(15)
            .AlignItems(AlignEnum.Stretch)
            .JustifyContent(JustifyEnum.SpaceBetween)
            .FlexDirection(FlexDirectionEnum.Row);
        self._container.Add(vert);

        self._p3CardsContainer = UI.VisualElement()
            .Width(20)
            .Height(100,true)
            .MarginLeft(90)
            .MarginRight(10)
            .AlignSelf(AlignEnum.FlexStart)
            .AlignItems(AlignEnum.Center)
            .JustifyContent(JustifyEnum.Center)
            .FlexDirection(FlexDirectionEnum.Column);
        vert.Add(self._p3CardsContainer);

        self._communityCardsContainter = UI.VisualElement()
            .Width(50,true)
            .Height(50,true)
            .AlignSelf(AlignEnum.Center)
            .AlignItems(AlignEnum.Center)
            .JustifyContent(JustifyEnum.Center)
            .FlexDirection(FlexDirectionEnum.Row);
        vert.Add(self._communityCardsContainter);

        self._p2CardsContainer = UI.VisualElement()
            .Width(20)
            .Height(100,true)
            .MarginLeft(10)
            .MarginRight(150)
            .AlignSelf(AlignEnum.FlexEnd)
            .JustifyContent(JustifyEnum.Center)
            .FlexDirection(FlexDirectionEnum.Column);
        vert.Add(self._p2CardsContainer);

        self._myCardsContainer = UI.VisualElement()
            .Width(100,true)
            .Height(20)
            .MarginLeft(20)
            .MarginRight(20)
            .MarginBottom(100)
            .AlignSelf(AlignEnum.Center)
            .AlignItems(AlignEnum.Center)
            .JustifyContent(JustifyEnum.Center)
            .FlexDirection(FlexDirectionEnum.Row);
        self._container.Add(self._myCardsContainer);

        buttonRow = UI.VisualElement()
            .Width(100,true)
            .Height(20)
            .Bottom(30)
            .FlexDirection(FlexDirectionEnum.Row)
            .JustifyContent(JustifyEnum.Center)
            .AlignSelf(AlignEnum.Center);
        self._container.Add(buttonRow);

        self._checkBTN = UI.Button("Check", self.OnCheckClicked)
            .Width(100)
            .Height(40)
            .BorderRadius(5)
            .BackgroundColor(Color("#3df791"));
        buttonRow.Add(self._checkBTN);

        self._callBTN = UI.Button("Call", self.OnCallClicked)
            .Width(100)
            .Height(40)
            .BorderRadius(5)
            .BackgroundColor(Color("#3db9f3"));
        buttonRow.Add(self._callBTN);

        self._raiseBTN= UI.Button("Raise", self.OnRaiseClicked)
            .Width(100)
            .Height(40)
            .BorderRadius(5)
            .BackgroundColor(Color("#ff0000"));
        buttonRow.Add(self._raiseBTN);

        self._foldBTN = UI.Button("Fold", self.OnFoldClicked)
            .Width(100)
            .Height(40)
            .BorderRadius(5)
            .BackgroundColor(Color("#fbff00"));
        buttonRow.Add(self._foldBTN);

        self._readyBTN = UI.Button("Ready!", self.OnReadyClicked)
            .Width(100)
            .Height(40)
            .BorderRadius(5)
            .BackgroundColor(Color("#00ff00"));
        buttonRow.Add(self._readyBTN);
    }

    function OnButtonClick(buttonName)
    {
        if(buttonName == "Raise_20")
        {
            self.Raise(20, Network.MyPlayer.ID);
        }
        elif (buttonName == "Raise_40")
        {
            self.Raise(40, Network.MyPlayer.ID);
        }
        elif (buttonName == "Raise_60")
        {
            self.Raise(60, Network.MyPlayer.ID);
        }
        
    }
    function OnReadyClicked()
    {
        self.SendMessageToPlayers("AddReady");
        Game.Print("Readied up!");
    }

    function OnFoldClicked()
    {
        self.Fold(Network.MyPlayer.ID);
    }

    function OnRaiseClicked()
    {
        UI.CreatePopup("Raise", "Raise", 400, 400);
        UI.AddPopupButton("Raise", "Raise_20", "Raise 20");
        UI.AddPopupButton("Raise", "Raise_40", "Raise 40");
        UI.AddPopupButton("Raise", "Raise_60", "Raise 60");
        UI.ShowPopup("Raise");
    }

    function OnCallClicked()
    {
        self.Call(Network.MyPlayer.ID);
    }

    function OnCheckClicked()
    {
        self.Check(Network.MyPlayer.ID);
    }

    function Show()
    {
        self.DisableInputs();
        if (!self._built) {self.BuildUI();}
        UI.SetLabelActive("MiddleCenter", false);
        self._container
            .Width(self._defaultWidth)
            .MarginLeft(0.5,true)
            .MarginRight(0.5,true);
    }

    function Hide()
    {
        self.EnableInputs();
        UI.SetLabelActive("MiddleCenter", true);
        #self._root.Clear();
        self._built = false;
    }

    function CreateCardUI(card)
    {
        cardContainer = UI.VisualElement()
            .Width(self._cardWidth)
            .Height(self._cardHeight)
            .BackgroundColor(Color(255, 255, 255, 255))
            .BorderRadius(8)
            .BorderWidth(2)
            .BorderColor(Color(0, 0, 0, 255)) 
            .FlexDirection(FlexDirectionEnum.Column)
            .JustifyContent(JustifyEnum.Center)
            .AlignItems(AlignEnum.Center)
            .MarginLeft(self._cardSpacing / 2)
            .MarginRight(self._cardSpacing / 2);
        label = UI.Label(card);
        cardContainer.Add(label);

        return cardContainer;
    }

    function HiddenCard()
    {
        HcardContainer = UI.VisualElement()
            .Width(self._cardWidth)
            .Height(self._cardHeight)
            .BackgroundColor(Color("#293fff"))
            .BorderRadius(8)
            .BorderWidth(2)
            .BorderColor(Color(0, 0, 0, 255))
            .FlexDirection(FlexDirectionEnum.Column)
            .JustifyContent(JustifyEnum.Center)
            .AlignItems(AlignEnum.Center)
            .MarginLeft(self._cardSpacing / 2)
            .MarginRight(self._cardSpacing / 2);
        return HcardContainer;
    }

    function HorizontalCard(card)
    {
        cardContainer = UI.VisualElement()
            .Width(self._cardWidth)
            .Height(self._cardHeight)
            .BackgroundColor(Color(255, 255, 255, 255))
            .BorderRadius(8)
            .BorderWidth(2)
            .BorderColor(Color(0, 0, 0, 255))
            .FlexDirection(FlexDirectionEnum.Column)
            .JustifyContent(JustifyEnum.Center)
            .AlignItems(AlignEnum.Center)
            .MarginLeft(self._cardSpacing / 2)
            .MarginRight(self._cardSpacing / 2);
        label = UI.Label(card);
        cardContainer.Add(label);

        return cardContainer;
    }

    function HiddenHoriCard()
    {
        HcardContainer = UI.VisualElement()
            .Width(self._cardHeight)
            .Height(self._cardWidth)
            .BackgroundColor(Color("#293fff"))
            .BorderRadius(8)
            .BorderWidth(2)
            .BorderColor(Color(0, 0, 0, 255))
            .FlexDirection(FlexDirectionEnum.Column)
            .JustifyContent(JustifyEnum.Center)
            .AlignItems(AlignEnum.Center)
            .MarginLeft(self._cardSpacing / 2)
            .MarginRight(self._cardSpacing / 2);
        return HcardContainer;
    }

    function DisableInputs()
    {
        Camera.SetCameraLocked(true);
        Camera.SetCursorVisible(true);
        UI.SetBottomHUDActive(false);
        Input.SetHumanKeysEnabled(false);
        if (Network.MyPlayer.Character != null) {Network.MyPlayer.Character.Name = " "; Network.MyPlayer.Character.Guild = " ";} 
    }

    function EnableInputs()
    {
        Camera.SetCameraLocked(false);
        Camera.SetCursorVisible(false);
        UI.SetBottomHUDActive(true);
        Input.SetHumanKeysEnabled(true);
        if (Network.MyPlayer.Character != null) {Network.MyPlayer.Character.Name = Network.MyPlayer.Name; Network.MyPlayer.Character.Guild = Network.MyPlayer.Guild;} 
    }
}
component PokerSeat
{
    function OnCollisionEnter(obj)
    {
        if (obj.Type == "Human" && obj.IsMainCharacter)
        {
            comp = Map.FindMapObjectByComponent("TexasHoldEmPoker").GetComponent("TexasHoldEmPoker");
            if (self.MapObject.Name == "Player1")
            {
                comp.NetworkView.SendMessage(Network.MasterClient, "Player1|" + Network.MyPlayer.ID);
            }
            elif (self.MapObject.Name == "Player2")
            {
                comp.NetworkView.SendMessage(Network.MasterClient, "Player2|" + Network.MyPlayer.ID);
            }
            elif (self.MapObject.Name == "Player3")
            {
                comp.NetworkView.SendMessage(Network.MasterClient, "Player3|" + Network.MyPlayer.ID);
            }
            elif (self.MapObject.Name == "Player4")
            {
                comp.NetworkView.SendMessage(Network.MasterClient, "Player4|" + Network.MyPlayer.ID);
            }
        }
    }
}
component DamageOverTime
{
    Damage = 9999;
    CountdownTime = 10;
    CountdownText = "YOU ARE BURNING TO DEATH IN";
    CloseToDeathEffectEnabled = true;
    CloseToDeathEffectTriggerTime = 5;
    CloseToDeathEffect = "TitanDie1";
    CloseToDeathMapObjectsIDs = "742 743";
    DeathEffect = "TitanDie2";
    DeathSoundEffect = "ThunderspearLaunch";
    DamagedText = "Burning";

    _activeTimers = Dict();
    _activePlayerEffects = Dict();

    function OnCollisionEnter(other)
    {
        if (other.IsCharacter && other.IsMine && other.Type != "Titan")
        {
            self._activeTimers.Set(other, Time.GameTime + self.CountdownTime);
        }
    }

    function OnCollisionStay(other)
    {
        if (other.IsCharacter && other.IsMine && other.Type != "Titan")
        {
            UI.SetLabel("MiddleCenter", self.CountdownText + " " + Convert.ToString(Math.Round(self._activeTimers.Get(other) - Time.GameTime)));
            
            if (self.CloseToDeathEffectEnabled && self._activeTimers.Get(other) - Time.GameTime <= self.CloseToDeathEffectTriggerTime) 
            {
                if (!self._activePlayerEffects.Contains(other)){
                    effects = List();
                    for (ID in String.Split(self.CloseToDeathMapObjectsIDs, " "))
                    {
                        effects.Add(Map.CopyMapObject(Map.FindMapObjectByID(Convert.ToInt(ID)), false));
                    }
                    self._activePlayerEffects.Set(other, effects);
                } else {
                    effects = self._activePlayerEffects.Get(other);
                    for (effect in effects)
                    {
                        effect.Position = other.Position + Vector3(0, 0.1, 0);
                    }
                }
                
                Game.SpawnEffect(self.CloseToDeathEffect, other.Position, other.Rotation, 2.0);
            }

            if (self._activeTimers.Get(other) < Time.GameTime) {
                other.PlaySound(self.DeathSoundEffect);
                other.GetDamaged(self.DamagedText, self.Damage);
                Game.SpawnEffect(self.DeathEffect, other.Position, other.Rotation, 2.0);
                if (self._activePlayerEffects.Contains(other)) {
                    for (obj in self._activePlayerEffects.Get(other))
                    {
                        Map.DestroyMapObject(obj, false);
                    }
                    self._activePlayerEffects.Remove(other);
                }  
            }
        }
    }

    function OnCollisionExit(other)
    {
        if (other.IsCharacter && other.IsMine && other.Type != "Titan")
        {
            UI.SetLabel("MiddleCenter", "");
            if (self._activeTimers.Contains(other)) {
                self._activeTimers.Remove(other);
            }
            if (self._activePlayerEffects.Contains(other)) {
                for (obj in self._activePlayerEffects.Get(other))
                {
                    Map.DestroyMapObject(obj, false);
                }
                self._activePlayerEffects.Remove(other);
            }  
        }
    }
}
component DamageOverTimeEffect
{
	  function SendNetworkStream()
    {
        self.NetworkView.SendStream(self.MapObject.LocalPosition);
    }

    function OnNetworkStream()
    {
			self.MapObject.Position = self.NetworkView.ReceiveStream();
    }
}
component FastTravel
{
    Description = "Makes the object act like a waypoint for fast travel. An object that shares any of the channels will be on the travel list.";
    Name = "";
    NameTooltip = "Name of this waypoint.";
    GlobalWaypoint = false;
    GlobalWaypointTooltip = "Makes this waypoint show up on others regardless of channel.";
    Channel = "";
    ChannelTooltip = "It will only find other Fast Travel objects of the same channel.";
    SubChannel = "";
    SubChannelTooltip = "Extra channel, can connect to both channels and subchannels.";

    HitboxSize = Vector3(4,4,4);

    _OtherFastTravel = Dict();

    _character = null;
    _isInteracting = false;

    _isTeleporting = false;
    _TpDestination = Vector3(0);
    _TPname = "";

    function Init()
    {
    self._TPname = self.Name;
    if(self.Channel != null){
    self._TPname = self._TPname + "_";
    }
    else{
    self._TPname = self._TPname + self.Channel;
    }
    if(self.SubChannel != null){
    self._TPname = self._TPname + "_";
    }
    else{
    self._TPname = self._TPname + self.SubChannel;
    }

    # preventing the parent scale from affecting the collider size
    x = self.HitboxSize.X/self.MapObject.Scale.X;
    y = self.HitboxSize.Y/self.MapObject.Scale.Y;
    z = self.HitboxSize.Z/self.MapObject.Scale.Z;
    self.HitboxSize = Vector3(x,y,z);

    self.MapObject.AddBoxCollider("Region", "Characters", Vector3(0,0,0), self.HitboxSize);
    FTlist = Map.FindMapObjectsByComponent("FastTravel");
    for(FT in FTlist){
    if(FT != self.MapObject){
    comp = FT.GetComponent("FastTravel");

    if( (   comp.GlobalWaypoint
    || ((comp.Channel == self.Channel) && comp.Channel != "")
    || ((comp.Channel == self.SubChannel) && comp.Channel != "")
    || ((comp.SubChannel == self.SubChannel) && comp.SubChannel != "")
    ) && self._TPname != comp._TPname)
    {
    self._OtherFastTravel.Set(comp.Name, FT.Position);
    }
    }
    UI.CreatePopup(self._TPname, "Fast Travel to", 400, 400);
    UI.AddPopupButtons(self._TPname, self._OtherFastTravel.Keys, self._OtherFastTravel.Keys);
    }
    }
    function OnButtonClick(buttonName)
    {
    if(self._OtherFastTravel.Contains(buttonName)){
    self._TpDestination = self._OtherFastTravel.Get(buttonName, self.MapObject.Position);
    UI.HidePopup(self._TPname);
    self._isTeleporting = true;
    }
    }
    function OnTick()
    {
    if(Network.MyPlayer.Character == null){
    self._character = null;
    }
    if(self._isTeleporting){
    self._isTeleporting = false;
    if(self._character != null){
    self._character.Position = self._TpDestination;
    }
    }
    self._isInteracting = false;
    }
    function OnFrame()
    {
    if(Input.GetKeyDown("Interaction/Interact") && self._isInteracting){
    UI.ShowPopup(self._TPname);
    }
    }
    function OnCollisionStay(other)
    {
    if (other.IsCharacter && other.Type == "Human" && other.IsMine){
    self._character = other;
    self._isInteracting = true;
    str ="<color=orange>(" + Input.GetKeyName("Interaction/Interact") + ")</color> Fast Travel Menu" + String.Newline;
    UI.SetLabelForTime("MiddleCenter", str, 0.1);
    }
    }
}
component StatChanger
{
	_acl = 0;
	_speed = 0;
	_gas = 0;

	_CompList = List();

	_isInteracting = false;

	_selectedStat = "ACL";

	function Init()
	{
		list = Map.FindMapObjectsByComponent("StatChanger");
		for(obj in list){
			self._CompList.Add(obj.GetComponent("StatChanger"));
		}
	}

	function OnCharacterReloaded(character)
	{
		if(character.IsMainCharacter && character.Type == "Human" && self._acl != 0){
			self.updatePlayer();
		}
	}

	function OnCollisionStay(obj)
	{
		if(obj == Network.MyPlayer.Character){
			if(Network.MyPlayer.Character.Type == "Human"){
				self._isInteracting = true;
				me = Network.MyPlayer.Character;
				if(self._acl == 0){
					acl = Math.Clamp(me.Acceleration, 50, 100);
					spd = Math.Clamp(me.Speed, 50, 100);
					gas = Math.Clamp((me.MaxGas + 35) / 2, 50, 100);
					for(changer in self._CompList){
						Math.Clamp(me.Acceleration, 50, 100);
						changer._acl = acl;
						changer._speed = spd;
						changer._gas = gas;
					}
				}
			}
		}
	}

	function OnFrame()
	{
		if(self._isInteracting){
			if(Input.GetKeyDown("Interaction/Interact")){
				self.UpdateStat(self._selectedStat, self.GetStat() + 5);
				self.updatePlayer();
			}
			if(Input.GetKeyDown("Interaction/Interact2")){

				self.UpdateStat(self._selectedStat, self.GetStat() - 5);
				self.updatePlayer();
			}
			if(Input.GetKeyDown("Interaction/Interact3")){
					if(self._selectedStat == "ACL"){ self._selectedStat = "SPEED"; }
					elif(self._selectedStat == "SPEED"){ self._selectedStat = "GAS"; }
					elif(self._selectedStat == "GAS"){ self._selectedStat = "ACL"; }
			}
		}
	}

	function GetStat(){
			if(self._selectedStat == "ACL"){ return self._acl; }
			elif(self._selectedStat == "SPEED"){ return self._speed; }
			elif(self._selectedStat == "GAS"){ return self._gas; }
	}

	function UpdateStat(stat, amount) {
			if(amount < 50){ amount = 50; }
			elif(amount > 100){ amount = 100; }

		for(changer in self._CompList){
				if(stat == "ACL"){ changer._acl = amount;}
				elif(stat == "SPEED"){ changer._speed = amount;}
				elif(stat == "GAS"){ changer._gas = amount;}
		}
	}

	function updatePlayer(){
		me = Network.MyPlayer.Character;
		if(me != null){
			me.Acceleration = self._acl;
			me.Speed =  self._speed;
			me.MaxGas = Convert.ToFloat((self._gas * 2.0) - 35.0);
			me.CurrentGas = me.MaxGas;
		}
	}

	function OnTick()
	{
		if(self._isInteracting){
			str = self._selectedStat + ": " + self.GetStat() + String.Newline
			+ "<color=orange>(" + Input.GetKeyName("Interaction/Interact") + ")</color> +5" + String.Newline
			+ "<color=orange>(" + Input.GetKeyName("Interaction/Interact2") + ")</color> -5"+ String.Newline
			+ "<color=orange>(" + Input.GetKeyName("Interaction/Interact3") + ")</color> change stat"+ String.Newline;
			UI.SetLabelForTime("MiddleCenter", str, 0.1);
		}

		self._isInteracting = false;
	}
}
component zzz_SpectateSpeed_Active
{
    Description = "Internal only - DO NOT USE IN MAP EDITOR";

    _spectateId = -1;
    _player = null;
    _character = null;
    _previousPosition = Vector3();
    _previousProjectedPosition = Vector3();
    _previousSpeed = 0.0;
    _previousSpeed2 = 0.0;
    _previousFrameTime = Math.Infinity;
    _previousFrameTime2 = Math.Infinity;
    _frameCount = 0;

    function OnDisable()
    {
        # don't hold references to stale objects while disabled
        self._spectateId = -1;
        self._player = null;
        self._character = null;
    }

    function OnFrame()
    {
        spectateId = Network.MyPlayer.SpectateID;
        if (spectateId != self._spectateId)
        {
            self._spectateId = spectateId;
            if (spectateId != -1)
            {
                for (plr in Network.Players)
                {
                    if (plr.ID == spectateId)
                    {
                        player = plr;
                        self._player = plr;
                    }
                }
            }
            else
            {
                player = null;
                self._player = null;
            }
        }
        else
        {
            player = self._player;
        }

        if (player != null)
        {
            character = player.Character;
        }
        else
        {
            character = null;
        }

        if (character != self._character)
        {
            self._character = character;
            frameCount = 0;
        }
        else
        {
            frameCount = self._frameCount;
        }

        if (character != null)
        {
            position = character.Position;

            # Exception for cases where the player may be moving but has 0 speed
            #   (the CurrentAnimation test is only needed because Human.State seems to be bugged and returns "Idle" when grabbed)
            if (character.Type == "Human" && (character.State == "Grab" || character.CurrentAnimation == "Armature|grabbed"))
            {
                frameCount = 0;
                UI.SetLabelForTime("BottomCenter", "Speedometer: 0.0u/s", 0.25);
            }

            # Ignoring these frameCount conditions will cause the first few frames to do extra work producing garbage,
            #   but it's better for throughput. Might be helpful to re-enable them for debugging, however.
            #elif (frameCount > 0)
            #{
            previousPosition = self._previousPosition;

            # reverse lerp to obtain the value of _correctPosition
            projectedPosition = previousPosition + (position - previousPosition) / Math.Clamp((self._previousFrameTime * 10.0), 0.0, 1.0);
            # btw we use the previous frame time instead of the current frame time since the position hasn't been updated yet this frame
            #   (CL runs before the movement sync code does, unfortunately)

            #if (frameCount > 1)
            #{
            previousProjectedPosition = self._previousProjectedPosition;

            # During frames that are being interpolated between network syncs, this actually should pull
            #   the exact velocity value that was synced (give or take rounding error)
            speed = ((projectedPosition - previousProjectedPosition) / self._previousFrameTime2).Magnitude;
            # During frames where a position sync does occur, this can be very far off from the real velocity, but we can filter for that below
            # Fortunately, the amount of error is reduced by having less interpolation frames between syncs (which happens when you have very low FPS),
            #   so this also works about as well as anything else in that scenario.

            previousSpeed = self._previousSpeed;
            previousSpeed2 = self._previousSpeed2;

            # Take the median of the last 3 speeds as the current speed
            #   this is a performant (not perfect, but not too noticeable) way
            #   to avoid the velocity spikes that occur when a position sync occurs
            if (speed >= previousSpeed)
            {
                if (speed <= previousSpeed2)
                {
                    medianSpeed = speed;
                }
                elif (previousSpeed >= previousSpeed2)
                {
                    medianSpeed = previousSpeed;
                }
                else
                {
                    medianSpeed = previousSpeed2;
                }
            }
            elif (speed >= previousSpeed2)
            {
                medianSpeed = speed;
            }
            elif (previousSpeed <= previousSpeed2)
            {
                medianSpeed = previousSpeed;
            }
            else
            {
                medianSpeed = previousSpeed2;
            }

            # We need at least 5 frames of data to have a set of 3 valid speeds, so don't print until then
            if (frameCount >= 4)
            {
                UI.SetLabelForTime("BottomCenter", "Speedometer: " + String.FormatFloat(medianSpeed, 1) + "u/s", 0.25);
            }

            self._previousSpeed2 = previousSpeed;
            self._previousSpeed = speed;
            #}

            self._previousProjectedPosition = projectedPosition;
            self._previousFrameTime2 = self._previousFrameTime;
            #}

            self._previousPosition = position;
            self._previousFrameTime = Time.FrameTime;
            self._frameCount = frameCount + 1;
        }
    }
}
component zzz_SpectateSpeed_Manager
{
    Description = "Internal only - DO NOT USE IN MAP EDITOR";

    function OnPlayerSpawn(player, character)
    {
        if (character.IsMainCharacter)
        {
            SpectateSpeedSingleton.MapObject.SetComponentEnabled(SpectateSpeedSingleton.ActiveComponentName, false);
            SpectateSpeedSingleton.ActiveComponent.OnDisable();
        }
    }
    function OnCharacterDie(victim, killer, killerName)
    {
        if (victim.IsMainCharacter)
        {
            SpectateSpeedSingleton.MapObject.SetComponentEnabled(SpectateSpeedSingleton.ActiveComponentName, true);
        }
    }
}
component InfiniteResourceSettings
{
    Description = "Attach this to a static object on the map to save settings for which infinite resources should be enabled.";
    # To override these settings in a game mode, use code like this in Main.Init():
    #   InfiniteResourceSingleton.SettingsComponent.InfiniteGas = false;
    InfiniteGas = true;
    InfiniteBladesAndAmmo = true;
    InfiniteDurabilityAndRounds = false;
}
component __InfiniteResource_Active
{
    Description = "Internal only - DO NOT USE IN MAP EDITOR";
    function OnCharacterDie(victim, killer, killerName)
    {
        if (victim == InfiniteResourceSingleton.ActiveHuman)
        {
            InfiniteResourceSingleton.Deactivate();
        }
    }
    function OnTick()
    {
        settings = InfiniteResourceSingleton.SettingsComponent;
        human = InfiniteResourceSingleton.ActiveHuman;
        if (settings.InfiniteGas)
        {
            human.CurrentGas = human.MaxGas;
        }
        if (settings.InfiniteBladesAndAmmo)
        {
            human.CurrentBlade = human.MaxBlade;
            human.CurrentAmmoLeft = human.MaxAmmoTotal;
        }
        if (settings.InfiniteDurabilityAndRounds)
        {
            human.CurrentBladeDurability = human.MaxBladeDurability;
            human.CurrentAmmoRound = human.MaxAmmoRound;
        }
    }
}
component __InfiniteResource_Inactive
{
    Description = "Internal only - DO NOT USE IN MAP EDITOR";
    function OnPlayerSpawn(player, character)
    {
        if (player == Network.MyPlayer && character.Type == "Human")
        {
            InfiniteResourceSingleton.Activate(character);
        }
    }
}
component Gacha
{
    #Gacha
    PullCost = 15;
    #@type Dict<string,GachaItem>
    _items = Dict();
    _playerInv = Dict();
    _characters = List();
    _inv = null;
    _pullsCount = 0;

    _CommonRarity = 1;
    _UncommonRarity = 2;
    _RareRarity = 3;
    _srRarity = 4;
    _ssrRarity = 5;
    _urRarity = 6;
    _grapeRarity = 7;

    #Chances by factor of 10000
    _commonChance = 10000;
    _uncommonChance = 4000;
    _rareChance = 1800;
    _srChance = 600;
    _ssrChance = 55;
    _urChance = 40;
    _grapeChance = 25;
    
    #Colors
    BgColor = "#929191";
    BorderColor = "#020000";
    _common = "#b4b4b4";
    _unCommon = "#00a4f0";
    _rare = "#ffff";
    _sr = "#c100fc";
    _ssr = "#ff5101";
    _ur = "#ff1504";
    _grapeRare = "#e100ff";

    _hasInsert = false;

    _screenHeight = 0;
    _screenWidth = 0;
    _uiScale = 0;

    #@type Human
    _collidingHuman = null;
    _active = false;
    /*@type VisualElement*/ _root = null;
    /*@type VisualElement*/ _mainContainer = null;
    _enabled = false;
    _built = false;

    function OnGameStart()
    {
        self.InitItems();
    }

    function OnCollisionStay(obj)
    {
        self._collidingHuman = obj;   
        if (!self._enabled && obj.IsMainCharacter)
        {
            UI.SetLabelForTime("MiddleCenter", "Press F1 to open gacha.", 0.1);
        }
    }

    function OnCharacterDie(victim,killer,killerName)
    {
        if (victim.Type == "Human" && self._enabled && victim.IsMainCharacter)
        {
            self.Hide();
            self._enabled = false;
        }
    }

    function OnCollisionExit(obj)
    {
        if (self._enabled && obj.IsMainCharacter)
        {
            self.Hide();
            self._enabled = false;
        }
    }

    function OnFrame()
    {
        if (self._collidingHuman != null && self._collidingHuman.IsMainCharacter)
        {
            if (Input.GetKeyDown(InputInteractionEnum.Function1))
            {
                if (!self._enabled)
                {
                    self.Show();
                    self._enabled = true;
                }
                elif (self._enabled)
                {
                    self.Hide();
                    self._enabled = false;
                }
                
            }
        }
    }

    function OnTick()
    {
        self._collidingHuman = null;
    }

    function CalculateLayout()
    {
        dims = Input.GetScreenDimensions();
        self._screenWidth = dims.X;
        self._screenHeight = dims.Y;
        
        scaleX = self._screenWidth / 1920.0;
        scaleY = self._screenHeight / 1080.0;
        
        self._uiScale = scaleX;
        if (scaleY < self._uiScale) { self._uiScale = scaleY; }
        
        if (self._uiScale < 0.75) { self._uiScale = 0.75; }
        if (self._uiScale > 2.50) { self._uiScale = 2.50; }
    }

    function BuildUI()
    {
        self._root = UI.GetRootVisualElement();
        self._built = true;
        s = self._uiScale;

        self._mainContainer = UI.VisualElement()
            .Absolute(true)
            .Width(20,true)
            .Height(75,true)
            .BackgroundColor(Color(self.BgColor))
            .BorderWidth(15)
            .BorderRadius(15)
            .BorderColor(Color(self.BorderColor))
            .Margin(50)
            .AlignSelf(AlignEnum.Center);
        self._root.Add(self._mainContainer);

        box1 = UI.VisualElement()
            .Width(90, true)
            .Height(30,true)
            .Margin(20)
            .AlignSelf(AlignEnum.Center)
            .BackgroundColor(Color("#d1cdcdd0"));
        self._mainContainer.Add(box1);

        title = UI.Label("Gacha Machine")
            .TextAlign(TextAlignEnum.UpperCenter)
            .FontSize(20);
        box1.Add(title);

        coinLabel = UI.Label("Coins " + Main.Coins)
            .TextAlign(TextAlignEnum.UpperCenter)
            .FontSize(20);
        box1.Add(coinLabel);

        pullLabel = UI.Label("Pulls " + self._pullsCount)
            .TextAlign(TextAlignEnum.UpperCenter)
            .FontSize(20);
        box1.Add(pullLabel);

        dial = UI.Button("",self.Insert)
            .Width(150 * s)
            .Height(150 * s)
            .BorderRadius(150 * s)
            .AlignSelf(AlignEnum.Center)
            .Margin(100)
            .BackgroundColor(Color("#0051ff"));
        self._mainContainer.Add(dial);

        turner = UI.VisualElement()
            .Width(100,true)
            .Height(25 * s)
            .AlignSelf(AlignEnum.Center)
            .MarginTop(45 * s)
            .BackgroundColor(Color("#070000"))
            .BorderRadius(10);
        dial.Add(turner);

        collection = UI.Button("Collect Here", self.Pull)
            .Width(150 * s)
            .Height(150 * s)
            .AlignSelf(AlignEnum.FlexStart)
            .Margin(20)
            .BackgroundColor(Color("#ffc400"))
            .BorderRadius(20);
        self._mainContainer.Add(collection);
    }

    function PullCmd()
    {
        self.Pull();
    }

    function Insert()
    {
        if (!self._hasInsert){
            Main.Coins -= self.PullCost;
            Game.Print("Inserted Coins");
            self.UpdateUI();
            self._hasInsert = true;
        }
        else
        {
            Game.Print("You have already inserted coins");
        }
    }

    function Show()
    {
        if (!self._built)
        {
            self.CalculateLayout();
            self.BuildUI();
        }
        self.DisableInputs();
    }

    function Hide()
    {
        self._mainContainer.Clear();
        self._mainContainer.Active(false);
        self._built = false;
        self.EnableInputs();
    }

    function UpdateUI()
    {
        self.Hide();
        self.Show();
    }

    function DisableInputs()
    {
        Camera.SetCameraLocked(true);
        Camera.SetCursorVisible(true);
        UI.SetBottomHUDActive(false);
        UI.ForceHideNames = true;
        Input.SetHumanKeysEnabled(false);
    }

    function EnableInputs()
    {
        Camera.SetCameraLocked(false);
        Camera.SetCursorVisible(false);
        UI.SetBottomHUDActive(true);
        UI.ForceHideNames = false;
        Input.SetHumanKeysEnabled(true);
    }

    function InitItems()
    {
        #Commons
        self._items.Set("Decim", GachaItem("Decim", self._CommonRarity, DescriptionsEnum.Decim,1));
        self._items.Set("Victorique de Blois", GachaItem("Victorique de Blois", self._CommonRarity, DescriptionsEnum.VictoriquedeBlois,1));
        self._items.Set("Morgiana", GachaItem("Morgiana", self._CommonRarity, DescriptionsEnum.Morgiana,1));
        self._items.Set("Umaru Doma", GachaItem("Umaru Doma", self._CommonRarity, DescriptionsEnum.UmaruDoma,1));
        self._items.Set("Happy", GachaItem("Happy", self._CommonRarity,DescriptionsEnum.Happy,1));
        self._items.Set("Koutarou Tatsumi", GachaItem("Koutarou Tatsumi", self._CommonRarity, DescriptionsEnum.KoutarouTatsumi,1));
        self._items.Set("Sakaki", GachaItem("Sakaki", self._CommonRarity, DescriptionsEnum.Sakaki,1));
        self._items.Set("Chihiro Ogino", GachaItem("Chihiro Ogino", self._CommonRarity, DescriptionsEnum.ChihiroOgino,1));
        self._items.Set("Uryuu Ishida", GachaItem("Uryuu Ishida", self._CommonRarity, DescriptionsEnum.UryuuIshida,1));
        self._items.Set("Satori Tendou", GachaItem("Satori Tendou", self._CommonRarity, DescriptionsEnum.SatoriTendou,1));
        self._items.Set("YangWen-li", GachaItem("YangWen-li", self._CommonRarity, DescriptionsEnum.YangWenli,1));
        self._items.Set("Ippo Makunouchi", GachaItem("Ippo Makunouchi", self._CommonRarity, DescriptionsEnum.IppoMakunouchi,1));

        #Uncommonss
        self._items.Set("Erina Nakiri", GachaItem("Erina Nakiri", self._UncommonRarity, DescriptionsEnum.ErinaNakiri,1));
        self._items.Set("Winry Rockbell", GachaItem("Winry Rockbell", self._UncommonRarity, DescriptionsEnum.WinryRockbell,1));
        self._items.Set("Nate River", GachaItem("Nate River", self._UncommonRarity, DescriptionsEnum.NateRiver,1));
        self._items.Set("Nausicaa", GachaItem("Nausicaa", self._UncommonRarity, DescriptionsEnum.Nausicaa,1));
        self._items.Set("Sakamoto", GachaItem("Sakamoto", self._UncommonRarity, DescriptionsEnum.Sakamoto,1));
        self._items.Set("Akaza", GachaItem("Akaza", self._UncommonRarity, DescriptionsEnum.Akaza,1));
        self._items.Set("Haku", GachaItem("Haku", self._UncommonRarity, DescriptionsEnum.Haku,1));
        self._items.Set("Ymir", GachaItem("Ymir", self._UncommonRarity, DescriptionsEnum.Ymir,1));
        self._items.Set("Pieck Finger", GachaItem("Pieck Finger", self._UncommonRarity, DescriptionsEnum.PieckFinger,1));
        self._items.Set("Chinatsu Kano", GachaItem("Chinatsu Kano", self._UncommonRarity, DescriptionsEnum.ChinatsuKano,1));

        #Rares
        self._items.Set("Jean Pierre Polnareff", GachaItem("Jean Pierre Polnareff", self._RareRarity, DescriptionsEnum.JeanPierrePolnareff,1));
        self._items.Set("Migi", GachaItem("Migi", self._RareRarity, DescriptionsEnum.Migi,1));
        self._items.Set("Neferpitou", GachaItem("Neferpitou", self._RareRarity, DescriptionsEnum.Neferpitou,1));
        self._items.Set("Hancock Boa", GachaItem("Hancock Boa", self._RareRarity, DescriptionsEnum.HancockBoa,1));
        self._items.Set("Jean Kirstein", GachaItem("Jean Kirstein", self._RareRarity, DescriptionsEnum.JeanKirstein,1));
        self._items.Set("Franky", GachaItem("Franky", self._RareRarity, DescriptionsEnum.Franky,1));
        self._items.Set("Hatsune Miku", GachaItem("Hatsune Miku", self._RareRarity, DescriptionsEnum.HatsuneMiku,1));
        self._items.Set("Jonathan Joestar", GachaItem("Jonathan Joestar", self._RareRarity, DescriptionsEnum.JonathanJoestar,1));
        self._items.Set("Totoro", GachaItem("Totoro", self._RareRarity, DescriptionsEnum.Totoro,1));

        #SR
        self._items.Set("Pochita", GachaItem("Pochita", self._srRarity, DescriptionsEnum.Pochita,1));
        self._items.Set("Chii", GachaItem("Chii", self._srRarity, DescriptionsEnum.Chii,1));
        self._items.Set("Kyoujurou Rengoku", GachaItem("Kyoujurou Rengoku", self._srRarity, DescriptionsEnum.KyoujurouRengoku,1));
        self._items.Set("Nezuko Kamado", GachaItem("Nezuko Kamado", self._srRarity, DescriptionsEnum.NezukoKamado,1));
        self._items.Set("Lucy", GachaItem("Lucy", self._srRarity, DescriptionsEnum.Lucy,1));
        self._items.Set("Howl", GachaItem("Howl", self._srRarity, DescriptionsEnum.Howl,1));
        self._items.Set("Ryuk", GachaItem("Ryuk", self._srRarity, DescriptionsEnum.Ryuk,1));
        self._items.Set("Reze", GachaItem("Reze", self._srRarity, DescriptionsEnum.Reze,1));
        self._items.Set("lucy", GachaItem("lucy", self._srRarity, DescriptionsEnum.lucy,1));
        self._items.Set("Mei Misaki", GachaItem("Mei Misaki", self._srRarity, DescriptionsEnum.MeiMisaki,1));

        #SSR
        self._items.Set("Future Trunks", GachaItem("Future Trunks", self._ssrRarity, DescriptionsEnum.FutureTrunks,1));
        self._items.Set("Sanji", GachaItem("Sanji", self._ssrRarity, DescriptionsEnum.Sanji,1));
        self._items.Set("Saitama", GachaItem("Saitama", self._ssrRarity, DescriptionsEnum.Saitama,1));
        self._items.Set("L Lawliet", GachaItem("L Lawliet", self._ssrRarity, DescriptionsEnum.LLawliet,1));
        self._items.Set("Frieren", GachaItem("Frieren", self._ssrRarity, DescriptionsEnum.Frieren,1));
        self._items.Set("Erwin Smith", GachaItem("Erwin Smith", self._ssrRarity, DescriptionsEnum.ErwinSmith,1));
        self._items.Set("Tanjirou Kamado", GachaItem("Tanjirou Kamado", self._ssrRarity, DescriptionsEnum.TanjirouKamado,1));
        self._items.Set("Kusuo Saiki", GachaItem("Kusuo Saiki", self._ssrRarity, DescriptionsEnum.KusuoSaiki,1));
        self._items.Set("Armin Arlert", GachaItem("Armin Arlert", self._ssrRarity, DescriptionsEnum.ArminArlert,1));
        self._items.Set("Chopper Tony Tony", GachaItem("Chopper Tony Tony", self._ssrRarity, DescriptionsEnum.ChopperTonyTony,1));

        #UR
        self._items.Set("David Martinez", GachaItem("David Martinez", self._urRarity, DescriptionsEnum.DavidMartinez,1));
        self._items.Set("Levi Ackermann", GachaItem("Levi Ackermann", self._urRarity, DescriptionsEnum.Levi,1));
        self._items.Set("Light Yagami", GachaItem("Light Yagami", self._urRarity, DescriptionsEnum.LightYagami,1));
        self._items.Set("Zoro Roronoa", GachaItem("Zoro Roronoa", self._urRarity, DescriptionsEnum.ZoroRoronoa,1));
        self._items.Set("Naruto Uzumaki", GachaItem("Naruto Uzumaki", self._urRarity, DescriptionsEnum.NarutoUzumaki,1));
        self._items.Set("Eren Yeager", GachaItem("Eren Yeager", self._urRarity, DescriptionsEnum.ErenYeager,1));
        self._items.Set("Satoru Gojou", GachaItem("Satoru Gojou", self._urRarity, DescriptionsEnum.SatoruGojou,1));
        self._items.Set("Mikasa Ackermann", GachaItem("Mikasa Ackermann", self._urRarity, DescriptionsEnum.MikasaAckerman,1));
        self._items.Set("Gokuu Son", GachaItem("Gokuu Son", self._urRarity, DescriptionsEnum.GokuuSon,1));

        #Grape
        self._items.Set("QUEEN GRAPE", GachaItem("QUEEN GRAPE", self._grapeRarity, DescriptionsEnum.Grape,1));
    }

    _cooldown = 0;
    function OnSecond()
    {
        if (self._cooldown > 0) {self._cooldown -= 1;}
    }

    function Pull()
    {
        if (Main.Coins < self.PullCost)
        {
            Game.Print("Not enough coins!");
            return;
        }
        #if (!self._hasInsert) {Game.Print("Insert Coins to collect"); return;}
        if (self._cooldown > 0) {Game.Print("On Cooldown " + self._cooldown); return;}
        self._pullsCount += 1;
        Main.Coins -= self.PullCost;
        self.UpdateUI();
        Network.MyPlayer.Character.PlaySound(HumanSoundEnum.HookImpactLoud);

        #@type GachaItem
        item = self.Roll();
        if (item == null) {Game.Print("Item null"); return;}
        Interface.MainInventory.AddItem(item);
        self.AddToInv(item);
        rarity = self.GetStringRarity(item.GetRarity());
        itemColor = self.GetItemColor(item.GetRarity());

        if (item.GetRarity() == self._ssrRarity || item.GetRarity() == self._urRarity || item.GetRarity() == self._grapeRarity)
        {
            Game.PrintAll(Network.MyPlayer.Name + " has pulled " + "<color=" + itemColor + ">" + item.GetName() + "</color>!!! " + "(" + rarity + ")");
            Network.MyPlayer.Character.PlaySound(HumanSoundEnum.ThunderspearLaunch);
            Game.SpawnEffect(EffectNameEnum.ThunderspearExplode, Network.MyPlayer.Character.Position, Vector3.Zero, 10, Color("#eeff00"), TSKillSoundEnum.MaxRangeShot);
            return;
        }

        Game.Print("You have pulled " + "<color=" + itemColor + ">" + item.GetName() + "</color>! " + "(" + rarity + ")");
        self.NetworkView.SendMessage(Network.MasterClient, "SaveItem|" + item.GetName());
        self._cooldown = 3;
    }

    function OnNetworkMessage(sender, message)
    {
        args = String.Split(message,"|",true);
        rpc = args.Get(0);

        if (!Network.IsMasterClient) {return;}
        if (rpc == "SaveItem")
        {
            senderServerID = ServerID._playerServerIDs.Get(sender.ID);
            itemName = args.Get(1);

            GachaData.SaveItem(itemName, senderServerID);
        }
    }

    function Roll()
    {
        roll = Random.RandomInt(1, 10000);

        if (roll <= self._grapeChance)
        {   
            return self.GetItem(self._grapeRarity);
        }
        elif (roll <= self._urChance)
        {
            return self.GetItem(self._urRarity);
        }
        elif (roll <= self._ssrChance + self._urChance)
        {
            return self.GetItem(self._ssrRarity);
        }
        elif (roll <= self._srChance + self._ssrChance + self._urChance)
        {
            return self.GetItem(self._srRarity);
        }
        elif (roll <= self._srChance + self._ssrChance + self._urChance + self._rareChance)
        {
            return self.GetItem(self._RareRarity);
        }
        elif (roll <= self._rareChance + self._srChance + self._ssrChance + self._urChance + self._uncommonChance)
        {
            return self.GetItem(self._UncommonRarity);
        }
        else
        {
            return self.GetItem(self._CommonRarity);
        }
    }

    #@param item GachaItem
    function AddToInv(item)
    {
        itemName = item.GetName();

        if (self._playerInv.Contains(itemName))
        {
            self._playerInv.Set(itemName, self._playerInv.Get(itemName) + 1);
        }
        else
        {
            self._playerInv.Set(itemName, 1);
        }
    }

    function GetItem(byRarity)
    {
        filter = List();

        for (item in self._items.Values)
        {
            if (item.GetRarity() == byRarity)
            {
                filter.Add(item);
            }
        }

        if (filter.Count <= 0)
        {
            for (item in self._items.Values)
            {
                if (item.GetRarity() == self._CommonRarity)
                {
                    return item;
                }
                
            }
        }
        randomIndex = Random.RandomInt(0, filter.Count);
        return filter.Get(randomIndex);
    }

    function GetItemColor(rarity)
    {
        if (rarity == self._CommonRarity) {return self._common;}
        elif (rarity == self._UncommonRarity) {return self._unCommon;}
        elif (rarity == self._RareRarity) {return self._rare;}
        elif (rarity == self._srRarity) {return self._sr;}
        elif (rarity == self._ssrRarity) {return self._ssr;}
        elif (rarity == self._urRarity) {return self._ur;}
        elif (rarity == self._grapeRarity) {return self._grapeRare;}
    }

    function GetStringRarity(rarity)
    {
        if (rarity == self._CommonRarity) {return "Common";}
        elif (rarity == self._UncommonRarity) {return "Uncommon";}
        elif (rarity == self._RareRarity) {return "Rare";}
        elif (rarity == self._srRarity) {return "SR";}
        elif (rarity == self._ssrRarity) {return "SSR";}
        elif (rarity == self._urRarity) {return "UR";}
        elif (rarity == self._grapeRarity) {return "GRAPE";}
    }

    function GetStringEdition(edition)
    {
        if (edition == 1) {
            return "First Edition";
        }
    }
}
component Inventory
{
    _enabled      = false;
    _lastRowCount = 0;
    _defaultWidth = 900;
    _moneyLabel = null;

    # @type Dict<string,GachaItem>
    _items = Dict();

    /* @type VisualElement  */ _lastRow       = null;
    /* @type VisualElement  */ _rootContainer = null;
    /* @type VisualElement  */ _itemContainer = null;

    _default_button = "Interaction/Interact2";

    function OnGameStart()
    {
        self.CreateInventoryUI();
        self.Hide();
    }

    function OnFrame()
    {
        if (Input.GetKeyDown(self._default_button))
        {
            self.ToggleEnabled();
        }
        elif (Input.GetKeyDown("General/Pause"))
        {
            self.SetEnabled(false);
        }
    }

    function ToggleEnabled()
    {
        if (self._enabled)
        {
            Interface.CloseWindow();
        }
        else
        {
            Interface.OpenWindow(self);
        }
    }

    function SetEnabled(enabled)
    {
        if (self._enabled == enabled)
        {
            return;
        }

        if (enabled)
        {
            self.Show();
        }
        else
        {
            self.Hide();
        }
        Input.SetKeyDefaultEnabled("Human/AttackDefault", !self._enabled);
        Camera.SetCursorVisible(self._enabled);
        Camera.SetCameraLocked(self._enabled);
    }

    function Show()
    {
        if (!self._enabled)
        {
            self._enabled = true;
            self._rootContainer
                .Width(self._defaultWidth, false)
                .PaddingLeft(0.5, true)
                .PaddingRight(0.5, true);
        }
    }

    function Hide()
    {
        if (self._enabled)
        {
            self._enabled = false;
            self._rootContainer
                .Width(0, true)
                .PaddingLeft(0, true)
                .PaddingRight(0, true);
        }
    }

    function CreateInventoryUI()
    {
        root = UI.GetRootVisualElement();

        self._rootContainer = UI.VisualElement()
            .Absolute(true)
            .BorderColor(Color(100,100,100))
            .BackgroundColor(Color(255,255,255,100))
            .Width(0, false)
            .Height(50, true)
            .Padding(15, false)
            .PaddingLeft(0,false)
            .PaddingRight(0,false)
            .BorderRadius(10)
            .Bottom(30, true)
            .AlignSelf(AlignEnum.Center)
            .OverflowX(OverflowEnum.Hidden)
            .TransitionDuration(300);
        root.Add(self._rootContainer);

        vertical = UI.VisualElement()
            .Width(100, true)
            .Height(100, true)
            .Padding(10)
            .FlexDirection(FlexDirectionEnum.Column)
            .JustifyContent(JustifyEnum.FlexStart);
        self._rootContainer.Add(vertical);

        title = UI.Label()
            .TextAlign(TextAlignEnum.MiddleCenter)
            .FontStyle(FontStyleEnum.Bold)
            .TextOverflow(TextOverflowEnum.Clip)
            .FlexShrink(1)
            .Height(30, false)
            .FontSize(30);
        vertical.Add(title);

        title.Text = "Inventory";

        scrollView = UI.ScrollView()
            .JustifyContent(JustifyEnum.Center)
            .AlignSelf(AlignEnum.Center)
            .Margin(5)
            .FlexGrow(1)
            .Width(100,true);
        vertical.Add(scrollView);

        #scrollView.MouseWheelScrollSize = 800;
        #scrollView.HorizontalScrollEnabled = true;

        self._itemContainer = UI.VisualElement()
            # .BackgroundColor(Color(0,0,0,40))
            .Width(100, true)
            .JustifyContent(JustifyEnum.Center)
            .AlignSelf(AlignEnum.Center)
            .FlexDirection(FlexDirectionEnum.Column)
            .AlignItems(AlignEnum.FlexStart);
        scrollView.Add(self._itemContainer);
    }

    # @param GachaItem GachaItem
    function AddItem(GachaItem)
    {
        if (GachaItem == null) {return;}
        if (self._items.Contains(GachaItem.GetName()))
        {
            return;
        }

        row = self.GetRow();
        itemUI = UI.Button()
            .Margin(5, false)
            .Top(10, false)
            .Width(100, false)
            .Height(150, false);
        row.Add(itemUI);

        itemUI.OnClick(GachaItem.OnButtonClick);

        vertical = UI.VisualElement()
            .Width(100, true)
            .Height(100, true)
            .FlexDirection(FlexDirectionEnum.Column);
        itemUI.Add(vertical);

        /*icon = UI.Icon(shopItem.Icon)
            .AspectRatio(1.0, AspectRatioEnum.Height)
            .Width(100, true);
        vertical.Add(icon);*/

        title = UI.Label()
            .Height(45, false)
            .FontSize(12)
            .TextAlign(TextAlignEnum.MiddleCenter)
            .TextWrap(true)
            .FontStyle(FontStyleEnum.Bold);
        vertical.Add(title);

        comp = Map.FindMapObjectByComponent("Gacha").GetComponent("Gacha");
        rarity = comp.GetStringRarity(GachaItem.GetRarity());
        color = comp.GetItemColor(GachaItem.GetRarity());
        ed = comp.GetStringEdition(GachaItem.GetEdition());
        
        title.Text = GachaItem.GetName() + String.Newline + "<color=" + color + ">"+ rarity+ "</color>"+ String.Newline + "<color=#fffb00>" + ed+ "</color>";

        countLabel = UI.Label()
            .Absolute(true)
            .Height(10, false)
            .Left(0)
            .Top(0)
            .TextAlign(TextAlignEnum.MiddleCenter)
            .FontStyle(FontStyleEnum.Bold)
            .FontSize(13);
        itemUI.Add(countLabel);

        GachaItem.SetElement(itemUI, row);
        #shopItem.UpdateElements();
        self._items.Set(GachaItem.GetName(), GachaItem);
    }

    # @param item GachaItem
    function RemoveItem(item)
    {
        if (self._items.Contains(item.GetName()))
        {
            item.RemoveSelf();
            self._items.Remove(item.GetName());
            return;
            #item.UpdateElements();
        }
    }

    # @return VisualElement
    function GetRow()
    {
        self._lastRowCount += 1;

        if (self._lastRowCount >= 7 || self._lastRow == null)
        {
            self._lastRowCount = 0;

            self._lastRow = UI.VisualElement()
                .FlexGrow(1)
                .FlexDirection(FlexDirectionEnum.Row)
                .JustifyContent(JustifyEnum.FlexStart);
            self._itemContainer.Add(self._lastRow);
        }

        return self._lastRow;
    }
}
component UITooltip
{
    Active = false;

    # @Type Label
    Element = null;

    function Init()
    {
        self.WaitAndCreateTooltip();
    }

    coroutine WaitAndCreateTooltip()
    {
        wait 0.0;
        self.CreateTooltip();
    }

    function CreateTooltip()
    {
        root = UI.GetRootVisualElement();
        self.Element = UI.Label("")
            .Absolute(true)
            .BorderColor(Color(100,100,100))
            .BackgroundColor(Color(255,255,255,255))
            .Width(200, false)
            .Height(400, false)
            .Padding(15, false)
            .BorderRadius(5)
            .BorderColor(Color(100,100,100,100))
            .TextWrap(true)
            .OverflowX(OverflowEnum.Hidden)
            .Active(false);

        self.Element.EnableRichText = true;
        root.Add(self.Element);
    }

    function OnFrame()
    {
        if (self.Active)
        {
            mousePos = Input.GetMousePosition();
            mousePos.Y = Input.GetScreenDimensions().Y - mousePos.Y;

            self.Element.Left(mousePos.X + 15, false);
            self.Element.Top(mousePos.Y + 5, false);
        }
    }
}
##Component classes
class GachaItem
{
    Name = "";
    Rarity = 0;
    Description = "";
    Element = null;
    Row = null;
    Edition = 0;
    function Init(name,rarity,description, edition)
    {
        self.Name = name;
        self.Rarity = rarity;
        self.Description = description;
        self.Edition = edition;
    }    

    function GetName()
    {
        return self.Name;
    }

    function GetRarity()
    {
        return self.Rarity;
    }

    function GetDescription()
    {
        return self.Description;
    }

    function GetEdition()
    {
        return self.Edition;
    }


    function SetElement(element, row)
    {
        element.RegisterMouseEnterEventCallback(self.SetInterfaceTooltipText);
        element.RegisterMouseEnterEventCallback(Interface.TooltipOnMouseHover);
        element.RegisterMouseLeaveEventCallback(Interface.TooltipOnMouseExit);
  
        self.Element = element;
        self.Row = row;
    }
    function SetInterfaceTooltipText()
    {
        Interface.SetTooltip(self.Description);
    }

    function OnButtonClick()
    {
        #@type GachaItem
        item = self.Clone();

        name = item.GetName();

        for (sprite in Sprites._list)
        {
            split = String.Split(sprite, "|", true);
            if (split.Get(0) == name)
            {
                text = split.Get(1);
                break;
            }
        }
        UI.CreatePopup("Gacha", "Gacha", 700, 800);
        UI.AddPopupLabel("Gacha", UI.WrapStyleTag(text + String.Newline + UI.WrapStyleTag(item.GetDescription(), "size", "20"), "size", "4"));
        UI.ShowPopup("Gacha");
    }

    function Clone()
    {
        comp = Map.FindMapObjectByComponent("Gacha").GetComponent("Gacha");
        item = comp._items.Get(self.Name);
        return GachaItem(item.GetName(), item.GetRarity(), item.GetDescription(), item.GetEdition());
    }

    function RemoveSelf()
    {
        self.Row.Remove(self.Element);
        Interface.TooltipOnMouseExit();
    }
}

##COmponent Extensions
##poker
extension GamePhaseEnum
{
    preflop = 0;
    flop = 1;
    turn = 2;
    river = 3;
}
extension RankingEnum
{
    #lowest to highest
    highCard = "High Card";
    pair = "Pair"; 
    twoPair = "Two Pair";
    threeKind = "Three of a Kind";
    straight = "Straight";
    flush = "Flush";
    fullHouse = "Full House";
    fourKind = "Four of a Kind";
    straightFlush = "Straight Flush";
    royalFlush = "Royal Flush";
}
extension Utils 
{
    function RankingToNum(rank)
    {
        if (rank == RankingEnum.pair) {
            return 1;
        }
        elif (rank == RankingEnum.twoPair) {
            return 2;
        }
        elif (rank == RankingEnum.threeKind) {
            return 3;
        }
        elif (rank == RankingEnum.straight) {
            return 4;
        }
        elif (rank == RankingEnum.flush) {
            return 5;
        }
        elif (rank == RankingEnum.fullHouse) {
            return 6;
        }
        elif (rank == RankingEnum.fourKind) {
            return 7;
        }
        elif (rank == RankingEnum.straightFlush) {
            return 8;
        }
        elif (rank == RankingEnum.royalFlush) {
            return 9;
        }
        else
        {
            return 0;
        }
    }

    function StringTONum(string)
    {
        if (string == "A") { return 14; }
        if (string == "K") { return 13; }
        if (string == "Q") { return 12; }
        if (string == "J") { return 11; }
        return Convert.ToInt(string);
    }

    function NumToString(num)
    {
        if (num == 14) { return "A"; }
        if (num == 13) { return "K"; }
        if (num == 12) { return "Q"; }
        if (num == 11) { return "J"; }
        return num;
    }

    function SortAscending(a, b)
    {
        if (a < b) {return 1;}
        if (a > b) {return -1;}
        return 0;
    }
}

##chez ones
extension SpectateSpeedSingleton
{
    ManagerComponentName = "zzz_SpectateSpeed_Manager";
    ManagerComponent = null;
    ActiveComponentName = "zzz_SpectateSpeed_Active";
    ActiveComponent = null;
    MapObject = null;

    function Init()
    {
        managerCompName = self.ManagerComponentName;
        activeCompName = self.ActiveComponentName;
        mapObject = Map.CreateMapObjectRaw("Scene,None,0,0,1,0,0,0,SpectateSpeedSingletonMapObject,0,0,0,0,0,0,1,1,1,None,Entities,Default,DefaultNoTint|255/255/255/255," + managerCompName + "|," + activeCompName + "|");
        self.MapObject = mapObject;
        self.ManagerComponent = mapObject.GetComponent(managerCompName);
        self.ActiveComponent = mapObject.GetComponent(activeCompName);
    }
}
extension InfiniteResourceSingleton
{
    SettingsComponentName = "InfiniteResourceSettings";
    SettingsComponent = null;

    ActiveComponentName = "__InfiniteResource_Active";
    ActiveComponent = null;
    ActiveHuman = null;

    InactiveComponentName = "__InfiniteResource_Inactive";
    InactiveComponent = null;

    MapObject = null;

    function Init()
    {
        mapObject = Map.CreateMapObjectRaw("Scene,None,0,0,1,0,0,0,__InfiniteResourceSingleton_MapObject,0,0,0,0,0,0,1,1,1,None,Entities,Default,DefaultNoTint|255/255/255/255," + self.ActiveComponentName + "|," + self.InactiveComponentName + "|");
        mapObject.SetComponentEnabled(InfiniteResourceSingleton.ActiveComponentName, false);

        self.MapObject = mapObject;
        self.ActiveComponent = mapObject.GetComponent(self.ActiveComponentName);
        self.InactiveComponent = mapObject.GetComponent(self.InactiveComponentName);

        settingsMapObjects = Map.FindMapObjectsByComponent(self.SettingsComponentName);
        if (settingsMapObjects.Count > 0)
        {
            self.SettingsComponent = settingsMapObjects.Get(0).GetComponent(self.SettingsComponentName);
        }
        else
        {
            self.SettingsComponent = mapObject.AddComponent(self.SettingsComponentName);
        }
    }

    function Activate(human)
    {
        InfiniteResourceSingleton.ActiveHuman = human;
        self.MapObject.SetComponentEnabled(InfiniteResourceSingleton.ActiveComponentName, true);
        self.MapObject.SetComponentEnabled(InfiniteResourceSingleton.InactiveComponentName, false);
    }
    function Deactivate()
    {
        InfiniteResourceSingleton.ActiveHuman = null;
        self.MapObject.SetComponentEnabled(InfiniteResourceSingleton.ActiveComponentName, false);
        self.MapObject.SetComponentEnabled(InfiniteResourceSingleton.InactiveComponentName, true);
    }

    function Enable()
    {
        player = Network.MyPlayer;
        if (player.Status == "Alive" && player.CharacterType == "Human")
        {
            self.Activate(player.Character);
        }
        else
        { 
            self.Deactivate();
        }
    }
    function Disable()
    {
        self.Deactivate();
        self.MapObject.SetComponentEnabled(InfiniteResourceSingleton.InactiveComponentName, false);
    }
}

##inventory
extension Interface
{
   CurrentWindow = null;

   # @type UITooltip
   Tooltip = null;

   # @type Inventory
   MainInventory = null;

   #@type Gacha
   Gacha = null;

   # this auto creates an empty object containing the component on game start without needing to pass it to Main
   function Init()
   {
       self.MainInventory = Map.CreateMapObjectRaw("Scene,None,13,0,1,0,0,0,Inventory,0,0,0,0,0,0,1,1,1,None,Entities,Default,DefaultNoTint|255/255/255/255").AddComponent("Inventory");
       self.Tooltip = Map.CreateMapObjectRaw("Scene,None,13,0,1,0,0,0,UITooltip,0,0,0,0,0,0,1,1,1,None,Entities,Default,DefaultNoTint|255/255/255/255").AddComponent("UITooltip");
       #self.Gacha = Map.FindMapObjectByComponent("Gacha").GetComponent("Gacha");
   }

   function OpenWindow(window)
   {
       self.CloseWindow();
       self.CurrentWindow = window;
       self.CurrentWindow.SetEnabled(true);
   }

   function CloseWindow()
   {
       if (self.CurrentWindow != null)
       {
           self.CurrentWindow.SetEnabled(false);
           self.CurrentWindow = null;
       }
   }

   function IsCurrentWindow(window)
   {
       return self.CurrentWindow == window;
   }

   function SetTooltip(text)
   {
       self.Tooltip.Element.Text = text;
   }

   function TooltipOnMouseHover()
   {
       self.Tooltip.Active = true;
       self.Tooltip.Element.Active(true);
   }

   function TooltipOnMouseExit()
   {
       self.Tooltip.Active = false;
       self.Tooltip.Element.Active(false);
   }
}

#Gacha
extension Sprites
{
    _list = List();
    function Init()
    {
        #this is for gacha only
        self._list.Add("Levi Ackermann|" + self.Levi);        
        self._list.Add("Decim|" + self.Decim);   
        self._list.Add("Victorique de Blois|" + self.VictoriaDeBlois);   
        self._list.Add("Morgiana|" + self.Morgiana);  
        self._list.Add("Umaru Doma|" + self.UmaruDoma);
        self._list.Add("Happy|" + self.Happy);
        self._list.Add("Koutarou Tatsumi|" + self.KoutarouTatsumi);
        self._list.Add("Sakaki|" + self.Sakaki);
        self._list.Add("Chihiro Ogino|" + self.ChihiroOgino);
        self._list.Add("Uryuu Ishida|" + self.UryuuIshida);
        self._list.Add("Satori Tendou|" + self.SatoriTendou);
        self._list.Add("Erina Nakiri|" + self.ErinaNakiri);
        self._list.Add("Winry Rockbell|" + self.WinryRockbell);
        self._list.Add("Nate River|" + self.NateRiver);
        self._list.Add("Nausicaa|" + self.Nausicaa);
        self._list.Add("Sakamoto|" + self.Sakamoto);
        self._list.Add("Akaza|" + self.Akaza);
        self._list.Add("Haku|" + self.Haku);
        self._list.Add("Ymir|" + self.Ymir);
        self._list.Add("Pieck Finger|" + self.PieckFinger);
        self._list.Add("Chinatsu Kano|" + self.ChinatsuKano);
        self._list.Add("Jean Pierre Polnareff|" + self.JeanPierrePolnareff);
        self._list.Add("Migi|" + self.Migi);
        self._list.Add("Neferpitou|" + self.Neferpitou);
        self._list.Add("Hancock Boa|" + self.HancockBoa);
        self._list.Add("Jean Kirstein|" + self.JeanKirstein);
        self._list.Add("Franky|" + self.Franky);
        self._list.Add("Hatsune Miku|" + self.HatsuneMiku);
        self._list.Add("Jonathan Joestar|" + self.JonathanJoestar);
        self._list.Add("Totoro|" + self.Totoro);
        self._list.Add("Pochita|" + self.Pochita);
        self._list.Add("Chii|" + self.Chii);
        self._list.Add("Kyoujurou Rengoku|" + self.KyoujurouRengoku);
        self._list.Add("Tanjirou Kamado|" + self.TanjirouKamado);
        self._list.Add("Nezuko Kamado|" + self.NezukoKamado);
        self._list.Add("Lucy|" + self.Lucy);
        self._list.Add("Howl|" + self.Howl);
        self._list.Add("Ryuk|" + self.Ryuk);
        self._list.Add("Reze|" + self.Reze);
        self._list.Add("lucy|" + self.lucy);
        self._list.Add("Mei Misaki|" + self.MeiMisaki);
        self._list.Add("Future Trunks|" + self.FutureTrunks);
        self._list.Add("Sanji|" + self.Sanji);
        self._list.Add("Saitama|" + self.Saitama);
        self._list.Add("L Lawliet|" + self.LLawliet);
        self._list.Add("Frieren|" + self.Frieren);
        self._list.Add("Erwin Smith|" + self.ErwinSmith);
        self._list.Add("Kusuo Saiki|" + self.KusuoSaiki);
        self._list.Add("Armin Arlert|" + self.ArminArlert);
        self._list.Add("Chopper Tony Tony|" + self.ChopperTonyTony);
        self._list.Add("David Martinez|" + self.DavidMartinez);
        self._list.Add("Light Yagami|" + self.LightYagami);
        self._list.Add("Zoro Roronoa|" + self.ZoroRoronoa);
        self._list.Add("Naruto Uzumaki|" + self.NarutoUzumaki);
        self._list.Add("Eren Yeager|" + self.ErenYeager);
        self._list.Add("Satoru Gojou|" + self.SatoruGojou);
        self._list.Add("Mikasa Ackermann|" + self.MikasaAckerman);
        self._list.Add("Gokuu Son|" + self.GokuuSon);
        self._list.Add("YangWen-li|" + self.YangWenli);
        self._list.Add("Ippo Makunouchi|" + self.IppoMakunouchi);
        self._list.Add("QUEEN GRAPE|" + self.Grape);
    }
    NPC2 = "
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓░▓▓▓▓▓▓▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▓▓▓▒░▓▓▓▓▓▓▓▓▒▒▓▓▓▓▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓░▓░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▒▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▒▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▒▒▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▒▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓░▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓░▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▒▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒░▒▒▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▓▓▓▓▓▓▓▓░▒▓▓▓▓▓▓▒▒▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▓▓▓▓▓▓▓░▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒░▒▓▓▓▓▓▓▓▒░▒▒▒▒▒▒▒▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ";
    NPC1 = "
        ███▓▓██▓▓███▓███▓▓██▓▓███▓███▓▓██▓▓███▓▓██▓▓██▓▓███▓▓██▓▓██▓▓███▓▓██▓▓██▓▓███▓▓██▓▓██▓▓███▓▓██▓▓██▓▓
        ███▓▓██▓▓██▓▓▓██▓▓██▓▓███▓▓██▓▓██▓▓███▓▓██▓▓██▓▓███▓▓██▓▓██▓▓███▓▓██▓▓██▓▓███▓▓██▓▓██▓▓███▓▓██▓▓██▓▓
        █▓▓██▓▓██▓▓███▓▓██▓▓██▓▓███▓▓██▓▓██▓▓███▓▓██▓▓▓█████▓▓▓██▓▓██▓▓▓██▓▓██▓▓███▓▓██▓▓██▓▓███▓▓██▓▓██▓▓██
        ███▓▓██▓▓██▓▓▓██▓▓██▓▓██▓▓▓██▓▓██▓▓███▓▓██▓▓▓▓▓█████████▓██▓▓███▓▓██▓▓██▓▓███▓▓██▓▓██▓▓███▓▓██▓▓██▓▓
        █▓▓██▓▓██▓▓███▓▓██▓▓██▓▓███▓▓██▓▓██▓▓███▓▒▒▓▓▓▓▓█████████▓▓██▓▓▓██▓▓██▓▓██▓▓▓██▓▓██▓▓███▓▓██▓▓██▓▓██
        ███▓▓██▓▓██▓▓▓██▓▓██▓▓██▓▓▓██▓▓██▓▓███▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓███▓▓▓▓███▓▓██▓▓██▓▓███▓▓██▓▓██▓▓███▓▓██▓▓██▓▓
        █▓▓██▓▓██▓▓███▓▓██▓▓██▓▓███▓▓██▓▓██▓▓███▒▒░▓▓▓▒▓▓██▓▓▓██▒▓▓██▓▓▓██▓▓██▓▓███▓▓██▓▓██▓▓███▓▓██▓▓██▓▓██
        ███▓▓██▓▓██▓▓▓██▓▓██▓▓██▓▓▓██▓▓██▓▓███▓▓▒▒▒░   ░░▒▒▒░ ░▒█▓▓▓▓███▓▓██▓▓██▓▓███▓▓██▓▓██▓▓███▓▓██▓▓██▓▓
        █▓▓██▓▓██▓▓███▓▓██▓▓██▓▓███▓▓██▓▓██▓▓███▒▒▒     ░█▓▒   ░░▓▓██▓▓▓██▓▓██▓▓███▓▓██▓▓██▓▓███▓▓██▓▓██▓▓██
        ███▓▓██▓▓██▓▓▓██▓▓██▓▓██▓▓▓██▓▓██▓▓███▓▓█▒▒▓ ▒▓▒░░░██ ░░█▓█▓▓███▓▓██▓▓██▓▓███▓▓██▓▓██▓▓███▓▓██▓▓██▓▓
        █▓▓██▓▓██▓▓███▓▓██▓▓██▓▓███▓▓██▓▓██▓▓███▓▒▒░▒▒░▒ ░ ▓▒▒▒▒▒▒▓██▓▓▓██▓▓██▓▓██▓▓▓██▓▓██▓▓███▓▓██▓▓██▓▓██
        ███▓▓██▓▓██▓▓▓██▓▓██▓▓██▓▓▓██▓▓██▓▓███▓▓█▒░░░▒▒▒█▓█▓▓▒░░▒██▓▓███▓▓██▓▓██▓▓███▓▓██▓▓██▓▓███▓▓██▓▓██▓▓
        █▓▓██▓▓██▓▓███▓▓██▓▓██▓▓███▓▓██▓▓██▓▓███▓▓█▒░▒▒▓▒▓▓▒▓▓░▓█▓▓██▓▓▓██▓▓██▓▓██▓▓▓██▓▓██▓▓███▓▓██▓▓██▓▓██
        ███▓▓██▓▓██▓▓▓██▓▓██▓▓██▓▓▓██▓▓██▓▓███▓▓██▓░▒▒░░░░▒▓▓▓█▒▓██▓▓███▓▓██▓▓██▓▓███▓▓██▓▓██▓▓███▓▓██▓▓██▓▓
        █▓▓██▓▓██▓▓███▓▓██▓▓██▓▓███▓▓██▓▓██▓▓███▓▓██▒▒▒▒▒▓▓▓▓▓▓██▓▓██▓▓▓██▓▓██▓▓██▓▓▓██▓▓██▓▓███▓▓██▓▓██▓▓██
        ▓██▓▓██▓▓██▓▓▓██▓▓██▓▓██▓▓▓██▓▓██▓▓███▓▓██▓▓██▒▒▒▒▒▓▓██▓▓██▓▓███▓▓██▓▓██▓▓███▓▓██▓▓██▓▓███▓▓██▓▓██▓▓
        █▓▓██▓▓██▓▓███▓▓██▓▓██▓▓███▓▓██▓▓██▓▓███▓▓██▓▓░▒▒▒▒ ▓▓▓██▓▓██▓▓▓██▓▓██▓▓███▓▓██▓▓██▓▓███▓▓██▓▓██▓▓██
        ██▓██████▓▓███▓▓██████▓█████▓███▓██▓▓███▓████░░▒░▒▒░▒▓████▓████████▓██▓▓███████▓███▓█████▓██████▓███
        ███▓▓██▓▓██▓▓▓██▓▓██▓▓██▓▓▓██▓▓██▓▓███▓▓██▓▓█░ ▒░░▒░▒▓█▓▓██▓▓███▓▓██▓▓██▓▓███▓▓██▓▓██▓▓███▓▓██▓▓██▓▓
        █▓▓██▓▓██▓▓███▓▓██▓▓██▓▓███▓▓██▓▓██▓▓███▓▓▒▒░▒ ▒░░▒▒ ▓▒▒█▓▓██▓▓▓██▓▓██▓▓██▓▓▓██▓▓██▓▓███▓▓██▓▓██▓▓██
        ███▓▓██▓▓██▓▓▓██▓▓██▓▓██▓▓████▓▓▓▓▓██▓▒▒▓▒▒▒░░▒▒▒▓▓█▓▓▒▒▒▒█▓▓▓██▓▓▓▓▓███▓▓███▓▓██▓▓██▓▓███▓▓██▓▓██▓▓
        █▓▓██▓▓██▓▓███▓▓██▓▓██▓▓▒█▒▓░█▒▓▓█░▒▒▒▒▓░░░░░▓██▓█▓▓█▓▓▓▓▓▓▓▓▒░▒▒▒▓▓█▓▒▓██▓▓▓██▓▓██▓▓███▓▓██▓▓██▓▓██
        ███▓▓██▓▓██▓▓▓██▓▓██▓▓█▓▓▓██▓▓▒▒░▒░░░▒▓▒▒▒▒░░░░▒▓██▓▒░ ░░░▓██▒▒▒▒▒░░▒▓▒▓▓████▓▓██▓▓██▓▓███▓▓██▓▓██▓▓
        █▓▓██▓▓██▓▓███▓▓██▓▓██▒▒▒▒▒▒░▒░░░░░░█░░░▒▓██████▓▓███████▓▓▓▒▓█▒▒▒▒▒▒▒▒▒░▒▒▒▓██▓▓██▓▓███▓▓██▓▓██▓▓██
        ███▓▓██▓▓██▓▓▓██▓▓██▓▓█▒▒▒▒██▓▒░░▒▒▓█▒ ░▒▓▓▓░   ▓▓█▓▓▒░▒▒▒░▒▒▓██▒▒▒▒▒▓██▒▒▒▒█▓▓██▓▓██▓▓███▓▓██▓▓██▓▓
        █▓▓██▓▓██▓▓███▓▓██▓▓██▓▒▒▓▒▓▓██▓▒▒█░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓███████▓█░▒░█▒▒▓██▓▓▒▒▒▓▓██▓▓██▓▓███▓▓██▓▓██▓▓██
        ███▓▓██▓▓██▓▓▓██▓▓██▓▓█▒▓▓▓██▓▓██▓█▒█▒░░▒▓▓▒▒▓█▓▓▓▓█████▓▒▓▓▓░▒▓█▒▓█▓▓██▓▒▒▓█▓▓██▓▓██▓▓███▓▓██▓▓██▓▓
        █▓▓██▓▓██▓▓███▓▓██▓▓██▓▒▓▓█▓▓██▓▓░▓▓▓▓▓▓▓▓▓▓▒▓██▒▓▓██▓▓▓▓▓█████▓▒▓▓▓██▓▓█▒▓▓▓██▓▓██▓▓███▓▓██▓▓██▓▓██
        ███▓▓██▓▓██▓▓▓██▓▓██▓▓█▒▓▓▓██▓▓█▓░▒█▒░▒▒▒▒▒▓▓▓ █▒▓▓█░░▓▓▓█░░ ▒▓█▒███▓▓██▓▒▒▓█▓▓██▓▓██▓▓███▓▓██▓▓██▓▓
        █▓▓██▓▓██▓▓███▓▓██▓▓██▓▒▓▒█▓▓██▓░▓▓▓▓▓▒▓▓▓▒█▓▓▓▒░▓▓▒▒███▒▓▓▒▒███▓▓▓▓██▓▓█▒▒▓▓██▓▓██▓▓███▓▓██▓▓██▓▓██
        ███▓▓██▓▓██▓▓▓██▓▓██▓▓█▒▓▒▓██▓▓▒▓░░▒█▒ ░▓▓▓▓░▓▓░░░░▒░▒▓▓▓▓▓▓▓▒██▒▒██▓▓██▓▓▒▓▓▓▓██▓▓██▓▓███▓▓██▓▓██▓▓
        █▓▓██▓▓██▓▓███▓▓██▓▓██▓▓▒▒█▓▓██▓▒▓▓▓▒▒▒▒▓▓▓▒▓▒░░░░░▒░▒▓▓▓▓▓██▓▓▒█▓▓▓██▓▓██▒▓▓██▓▓██▓▓███▓▓██▓▓██▓▓██
        ███▓▓██▓▓██▓▓▓██▓▓██▓▓▒▓▒▓▓██▓▓▓▓░▒▒▒▓▓▓▓▓▒▓▒░░▓▒▒▒▓░█▒▓▒▓▓▓▓▓▓▓▒░▓█▓▓██▓▓▒▓▓▓▓██▓▓██▓▓███▓▓██▓▓██▓▓
        ██████████████████████▒▒▒▓██▓██▓▒▒▓▒▒████▒▓▓█░░░░░░░░░▓█▓▒▓███▒█▓▓████████▒▓▓███████████████████████
        █▓▓██▓▓██▓▓███▓▓██▓▓██▒▒▒██▓▓██▓▓█▒▒▒▒▒▒▒▒█▒░▓▓░▒▒▒░█▓▓▒▓▓▒▓▓▓▒▒█▓▓▓██▓▓██▒▓▓██▓▓██▓▓███▓▓██▓▓██▓▓██
        ▓██▓▓██▓▓██▓▓▓██▓▓██▓▓▓▒▒▓▓██▓▓█▒▒▓███▓▒▒▒░▓▒░▓░▒▒▒▒▓░▓▓▓▒█▓▓██▒▓▓██▓▓██▓▓▒▓▓▓▓██▓▓██▓▓███▓▓██▓▓██▓▓
        █▓▓██▓▓██▓▓███▓▓██▓▓█▒▒▒▒██▓▓██▓▓▓█▒▒▒▓▒▒▓█▒▓▒ ░  ░░░▒▓▒▓▓▒▒▓▓▒▓░█▓▓██▓▓██▒▓▓▓█▓▓██▓▓███▓▓██▓▓██▓▓██
        ███▓▓██▓▓██▓▓▓██▓▓██▓▒▒▒▒▓▓██▓▓██▓▒▓██▓░█▒░▓██▓▒▒▓▒▒▓██▓▓▒█░▒██▓▓▓██▓▓██▓▓▓▓▓▓▓██▓▓██▓▓███▓▓██▓▓██▓▓
        █▓▓██▓▓██▓▓███▓▓██▓▓▓▓▓▒▒▒█▓▓██▓▓█▒▓▓▒▒▓▒▓██▓▒▓░░░░░▓▒▒██▓▒▓▒▓▒▓██▓▓██▓▓█▓█▓███▓▓██▓▓███▓▓██▓▓██▓▓██
        ▓██▓▓██▓▓██▓▓▓██▓▓█▓▓▒▒▒▒▓▒██▓▓██▓▓█▒▓▒▓██▓▓██▓▒▓▓▒▓▓██▓▓██▓▒▓██▓▓██▓▓██▒▒▓▓▒▒▓██▓▓██▓▓███▓▓██▓▓██▓▓
        █▓▓██▓▓██▓▓███▓▓██▓▓▒▓░░░▒█▓▓██▓▓██▓▓███▓▓██▒▒▒▓▓▓▓▓▓▓▓██▓▓██▓▓▓██▓▓██▓▓██▒ ▓▓▓▓▓██▓▓███▓▓██▓▓██▓▓██
        ███▓▓██▓▓██▓▓▓██▓▓█▒▒▓▒░▒▒▓██▓▓██▓▓███▓▓██▓▓██▓▒▒▒▓▓▓██▓▓██▓▓███▓▓██▓▓██▓▒▒▓░▓▓▓█▓▓██▓▓███▓▓██▓▓██▓▓
        █▓▓██▓▓██▓▓███▓▓██▓▒▓▓░▓▓██▓▓██▓▓███▓▓▓▓▓▓██▓▒▒▓▓▓▓▓▓▓░██▓▓▓▒▒▒▓▓█▓▓██▓▓██▓█░▒▓▓▓██▓▓███▓▓██▓▓██▓▓██
        ███▓▓██▓▓██▓▓▓██▓▓█▒▓▓▓▓▓▓▓██▓▓██▓▒▓▓▓▓▓▒▒▓▒▒▓▒░▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒██▓▓██▓▓▓█▒▒▓▓█▓▓██▓▓███▓▓██▓▓██▓▓
        █▓▓██▓▓██▓▓███▓▓██▓▒█▓▓█▓██▓▓██▒█▓▓▓▓▓▓▓▓▒▒▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒████▓▓███▓▓█▒▓▓██▓▓███▓▓██▓▓██▓▓██
        ███▓▓██▓▓██▓▓▓██▓▓█▒█▓▓█▓▓▓██▓▓█▒▓█▓██▓▓▓▓▓▒░ ▒░░░▒▒▓▒▒▓▓▓▓▓▓▒▒▒▓▓██▓▓██▓▓█▓█▓▒▓█▓▓██▓▓███▓▓██▓▓██▓▓
        █▓▓██▓▓██▓▓███▓▓██▓▒██▓▓███▓▓██▓▓█▓▓███▓▓▓▓░▓ ░▒░▒▒▓▒░▓░▓▓▓▓▓▓▒▒██▓▓██▓▓██▓▒██▓▓▓██▓▓███▓▓██▓▓██▓▓██
        ▓██▓▓██▓▓██▓▓▓██▓▓█▒█▓▓▓▓▓▓██▓▓██▓▓█▒█▓▓▓▓▒▒▓ ▒▒▒░▒▒▓ ▒▓▒▓▓▓▒▒▓█▓▓██▓▓██▓▓██▓▓▓▒▓▓▓██▓▓███▓▓██▓▓██▓▓
        █▓▓██▓▓██▓▓███▓▓██▓▒██▓▓███▓▓██▓▓▓▓▓▒▒▓▓▓▓▓█▓  ░░▒▒▒ ░▓██▓▓▓▓▓▒▒▓▓▓▓██▓▓███▓▒██▒▓██▓▓███▓▓██▓▓██▓▓██
        ";
    Grape = "
        ▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▓▓▓░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▓▓▒▒▓░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓░░░▓▓▓▓▓░░░▒░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▓▓▓▓▓▒▒▒▒▓░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▓▓▓▓▓▒▒▒▒▓▓░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▓▒░▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒░▒▒▒░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒▒▒░░░░▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒░░░░░░░▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒▓░▒░░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒▒▒▒░░░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░▒▒▒▒░░░░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒▒░░░▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒▒▒▒░▒▒▒░░▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░░░░░░░░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░▒░░░░▒▒░▒░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░░░░░░░░░░░░░░▒▒▒▒░░░░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░▒▒▒▒▒▒░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░▒░░░░░░░░░░▒▒▒▒▒▒░▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒░▒░░░░░░░░░░░░▒▒▒▒▒▒░░▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒░▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒░▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒░░▒░░░░░░░░░░░░░▒░▒▒░▒▒░▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒░▒░░░▒░░░░░░▒▒░░░░░░░░▒░▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒░▒░▒▒▒░░░░░░░░▒░░░░░░░░░▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░░░░░░░░░░░░░▒░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒░░░░░░░░░░▒▒░░░░░░▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒▒▒░░░░░░░░░▒▒░░░░░░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒░▒░░░░░░▒▒▒▒▒▒▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒░░░░░▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒░▒▒░░░░▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒▒▒░░▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒░░▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒░▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒▒▒▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
    ";
    Levi = "
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒░▒░░░▒▒░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▒▒▓▓▓▒▒▒▒▒▒▒▒░░▒░░░░░░░▒░▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓░▓▓▓▓▒▒▒▒▒▒▒░▒░░░░░░▒▒░░░░░▒░▒░▒▒▒░░░▒▒▒▒▒░▒░▒▒░▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒
        ░░░░░░░░░░░░░░░░░░░▒░░░░░░░▒▓▓▓▓▓▓▓▓▒▒▒▒░▒░░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░░░░░░░░░░░░░░░░░░▓▓░▒▓▓▓▓▓▓▒▒░▒░░▒▒░░▒▒░▒▒▒▒▒░▒▒▒░▒▒▒░░▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░░░░░░░░░░░░░░░▓▓▒▓▓▓▒▓▓▓▒░░▒▒░▒░░▒▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░▒▒▒░░░░░░░░░░▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒░▒░▒▒▒▒▒▒▒░▒▒▒
        ░░░▒▒░▒░░░░░░░░▓▒▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░▒▒▒░░░░░░░░▓░▒▓▓▒▓▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒░▒▒▒▒▒▒▒▒▓▓▓▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒
        ▒▒▒░▒▒▒▒▒▒▒▓▒▒░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░▒▒░░░░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒
        ░▓▓░▒░░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░▒░▒░░░▒▒░░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒░▒░░
        ▒▓▒░░░▒░░░░░░░░░░░░░░░░░░░░░░▒░▒░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒
        ▓▓▓▒░░░░░░░░░░░░░▒▒░░▒░░░░░▒░░▒░░░░░░░░░░░░░░░▒▒▒▒▒░▒░░▒▒▒░▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░░
        ▓▓▓▓▒▒░░░░░░░▒▒░░░░░▒░░▒░░░░░░░░░░░░░░░▒░░▒▒░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░
        ░░░▒▒▒░░░▒▒▒▒▒▒▒░▒▒▒░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒░░░░▒▒░░▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░▒▒▒▒▒▒░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒▒▒▒░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒▒▒░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒░░░▒▒░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒▒░░░░░▒▒▒░░░░░░░▒░░░░▒▒░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▒░░░░░░▒░░░▒▒░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒░░░░░░░░░░░░░░░░▒░▒░░░░░░░░░░░░░░░░░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░▒▒▒▒▒░▒▒▒▒▒▒▒░░░░▒▒▒░░░░░░░░░░░░░░░░░▒▒░░░░░░░░░░▒░▒▒▓▓▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░▒▒▒░░░▒▒▒▒▒▒▒▒░░░░▒▒▒▒░░░░░░░░░░░░░░░░░░░░▒░░░░▒▓▓▓▓▓▓▓▓▓▒▒░▒░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▒░░░░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░▒░░▒▓▓▓▓▓▓▓▓▓▓▒▒░▒░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒░▒▒░░░░░░▒▒▒▒▒▒▒░░░░░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░▒░░▒▒▓▓▓▓▓▓▓▒▓▒▓░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒▒░░░░░░▒▒▒▒░░░░░░░░░░░░▒▒▒▒░░▒▒▒▒▒▓▓▒▓▓▓▒░▒▒▓░▒▓▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░
        ▒░▒▒▒▒░░░░░░░▒▒▒▒▒▒▒░░░░░░▒▒▒▒░░░░░░░░░░░▒▒▒▒▒▒░▒▒▓▓▒▒▒░░░░▒▓▓▓▒▒▓▒▒▒▒▒▒░▒▒▒▒░▒▒░▒░▒▒▒░▒▒▒▒░░░░░░░░░
        ▒▒▒▒▒▒▒░░░░░░░░▒▒▒▒▒▒▒▒░░░░░░▒▒░░░░░░░░░░░▒▒▒▒▒▓▒▒▓▓▓▒▒▒▒▓▓▓▓▓▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒▒▒░▒░▒▒░░░░░░░░░░
        ▓░▒▒▒▒▒▒▒░░░░░░░░▒▒▒▒▒▒▒▒▒▒░░░░░░░▒░░░░░░░░░▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓░░▒▒▒▒░▒▒░▒░▒░░▒▒░░░▒░░▒░▒░░▒▒░░░░
        ▒▒░▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒░░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓░░░▒▒▒▒▒░░▒░░▒▒▒▒░▒░░▒▒░▒░░░░▒░░░░░
        ▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▓░▒░░▒▒▒░░▒░░▒░▒░░▒░▒░░░░▒░░▒▒░░░░▒░░
        ▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▓▓▓▓▓▓▓▓▓▒▓░░░░░░░░░▒▒░▒▒░░▒▒▒░░░░░░▒░▒░░░░▒░░░░
        ░▒▒▒░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒▒░░░░▒▒░░▒▓▓▓▓▓▓▓░░░▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░
        ▒▒▒▒░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░░░░░░░░░▒▒░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░
        ▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░▒▒░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒▒▒▒▒░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░▒░▒▒▒░░░▒░░░░░░▒▒▒▒▒▒▒░░░░▒▒▒▒░░░
        ░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒░░░░░░░▒▒▒▒░░░░░░░░░░▒▒▒▒▒▒▒▒░░░▒▒▒░░░░
        ░░░░░░░░░░░░░░░▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒░░░░░░░░░░▒░░░░░░▒▒░░░░░░░░░░░░░░░▒▒▒░░░░░░░░░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░▒░░░░░░░▒▒░░░░░░░░░░░░░░▒▒▒░░░░░░░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░▒░░░░░░░░▒░░░░░░░░░░░░░░░▒▒▒░░░░░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░▒▒▓▒▒▒▒▒░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░░
        ▒▒▒▒░▒▒▒▒▒▒▒░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░▒▒▒▒▒▒░░░░░░▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░
        ░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░▒▒▒▒░░░░░░░░░▒░░░░░░░▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░
        ▒░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░▒▒▒░░░░░░░░░░░░░▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒░░░░░░░░░▒▒░░░░░░░░░░░░░░░▒░░░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░
        ░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░▒▒░▒░░░░░░░░░░░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒░░░░░░▒░░░░░▒░░░░░░░░░░░░░░░░░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░
        ░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░▒▒░▒▒░░░░░▒▒▒▒░░░░░░░░░░░▒▓▓▒▒░░▒▒░░░░░░░░░░░░░░░▒▒░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒░░░░▒░░░░▒▒▒░░░░░▒▒░░░░░▒░░▒▒░░░░░▒░░░░░░░░▒░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░▒░░░▒▒░░░░░░░░░░░░░▒▒▒▒░░░▒░░░░▒░░░░░░░▒░▒░░▒░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░▒▒░▒▒░░▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░
        ░░░░░░░░░░░░░░░░░░░░░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░▒▒▒░▒▓▓▓▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░
        ░░░░░░░░░░░░░░░░░░░░▒░▒▒░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░
        ▒░░░░░░░░░░░░░░░░░░▒░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░▒▒▒▒░░░░▒▒▓▓▓▓▓░░░░░░░░▒▒▒░░░░░░░░░░░░░▒░░░░░░
        ▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░▒░░░▒▒▒▒░░░░░░░░░░▒░▒▒░░▒░░░░░░░░░░▒░░░░░▒
        ▓▓▓▓▓▓▓▓▒░░░░░░░░░▒▒▒░░░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░░░░▒░░░░░░░░░░░░░▒░░░▒▒░░▒░░░░░░░▒▒▒░░░░
        ▓▓▓▓▓▓▓▓▓▓▒░▒▒░░░░▒▒░░░░▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░▒░░▒░░░▒░▒▒░░░░░░░░░░░░░░░░░▒░░░▒▒▒▒▒▒▒░░▒▒▒▒░░░░░
        ▓▓▓▓▓▓▒▒▒▒░▒▓▓▓▓▓▒▒▒░░░░▒░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░▒▒░░░░░░░░░░░░░░░▒░▓▒░░░░░░▒▓▓▒░░░░░░░
        ▓▓▓▓▒▒▒▒▒░▒▒▒▓▓▓▓▓▓▓▓▒░▒▒░░░░░░░░░░░░░▒░░░▒░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░▒▒▒▒▒░░░▒░░░░░░
        ▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░▒░░░▒░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░▒░░░░░▒▓▒▒░░░░░░░░░▒▒░▒
        ▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░▒░░░░▓▒░░░░░░░░░░░░░░▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░▒░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒
        ▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▒▒▒▒▒▒▒▒▒░░░▒
        ▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▓▓▓▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▒▒░░░░░░░░░░░░░░░░
        ▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▓░▒░▒▒▒░░░░░░░░░░░░░
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░▒▒░░▒▒▒░░░░░░░░░░░░░░░░
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░▒░░░▒▒▒▒▒▒░░░░░░░░░░░░░
        ░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░▒▒▓▓▓▒▒░░░░░░░░░░░░
        ░░▒▒▒▒▒░▒░░▒▒░▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒░░░░░▓▓▓▓▓▓▒░░░░░░░░░░░
        ░▒▒▒░▒▒▒▒▒▒░▒▒░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒░▒░░░░░▒▒▒▒░▓▓▓▓░░░░░░░░░
        ▒▒▒▒▒░▒▒▒▒▒▒░░▒░░░░░▒▒░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒▒▒▒▓▓▓▒▒▒░░░░░▒
        ▒▒▒▒▒▒░▒▒▒▒░░░░░▒░▒░░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒░░░▒░░▒▓▒░░░░░░░░
        ▒▒░░▒▒░▒░▒░░░░░░░▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒░░▒▒░▒▒▒▒░▒▒░░▒▒░░░
        ▒▒▒░▒▒▒▒░░░░░░░░░░▒▒░▒░░░░░░░░░▒░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▒▒▒░░▒▒░░▒░▒░░░▒▓▓▒░
        ▒▒▒▒░░▒░░░░░░░░░░░▒▒░▒░░░░░░░░░░░░░░▒░▒░░░▒░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░▒▒▓▒▒▒▒░▒▒▒░
        ▒▒▒▒▒░░░░░░░░░░░░░░▓▒░░░░░▒▒▒▒▒▒▒░░░░░░░▒░▒░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░▒░▒░░░▒▒▒░░▒▒░
        ▒▒▒▒░░░░░░░░░░░░░░░▒▒░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░░░░░░░░▒▒░░
    ";
    Decim = "░░░░░░░░░░░░░░░░░░░▓▓▓▓▒░▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒▓▓▓▓▒▒▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▒▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░▓▓▓▒▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▓▓▓▓▓▓▓▓▒▓▒▓▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▓▓▒▓▓▓▓▓▒▒▓▒▓▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒▒▒▒▓▒▓▒▒▓▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░▓▒▓▓▓▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▓▓▓▓▓▓▓▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░▓▓▓▓▓▓▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒▒▒▓▒▓▒▓▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░▒▒▓▓▓▓▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░▒▒▓▓▓▓▓▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒▓▓░░▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░▒▒▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▒▓▓▒▒▒▓▒▒░▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░▒▓▓▓▓▓▓▓▓▓▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▓▒░▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░▒▒▒▒▓▓▓▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▓▒▓▒▓▓▓▓▓▓▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░▒░▒░▒▒▓▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▒▓▓▓▓▓▓▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░▒▓▒▒▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒▒▓▓▒▓▓▓▓▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░▒▒▒▒▒▒▒▒▓▓▓▓▒▓▒▓▒▒▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░▒░▒▒▒▒▒▓▓▓▓▒▓▒▓▒▓▓▓▓▓▒▓▓▓▓▓▓▓▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░▒▒▒▒▒▒▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▓▓▒▒▒▓▓▓▓▒▒▒▒▒▓▓▓▓▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░▒▒▒▓▒▒▓▒▓▓▓▓▓▒▒▒▓▓▓▒▒▒░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░▒▒▒▓▒▓▓▓▓▓▓▓▓▓▒▓▒▒░▒░▒▒░▒▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░▓▒░▒▒▒▓▓▓▓▒▒▓▓▓▒▒▒▒░▒▒▒▒▒▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒░▒▓▓▒░░░░░░░░░░░░▒▓▓▓▓▓▓▓▒▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░▒▓▒▒▓▒▒▒▒▒▒▒▓▓▓▓▒░▒▒▒▒▒▒▒▒▓▓▓▒░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░▒▒▓▓▓▓▓░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒░▒▒▒░▒▒▓▓▓▓▓▓░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░▒▒░░▓▓▓▓▓▓▓▓▓▒▒░▒▒▒▒▒░▒▒▒▒▒▒▓▓▓▓▓▓░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▒▓░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░▒▒▒░░░▒▓▓▓▓▓▓▓▓▓▓▒░▒░▒▒░▒▒▒▒▒▒░░░░▓▓░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░▒▒░░░▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒░▒▒▒▒░░░░░░░▓▓▓░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░▒░░░░░░░░░░░░░▓▓▓▓▓▓▓░▒▒▒▒▒░░░░░░░░░░░░▓▓▓▓░░░░░░░░▒░░░░░░░░▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░▓▓▒░░░░░░░░░░░░░▓▓▓▓▓▒▒▒░░░░░░░░░░░░░░░░▒▒▒▒▒░░░▒▒▒░▒▓▒░░░░░░░▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░▒▓▓▓▓▓▒░░░▒▒▒░░░░░░░▓▓▓▓▒░░░░░░░▒░▒▓▓▓▒▒▓▓▓▒▒▒▒▒░▒▓▓▓▒▓▓▒░░░░░░░░▒▒▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░░
        ░░░░░▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░▒▓▒▓▓░░░░▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▒▓▓▓▓▓▒▓▓░░░░▒▒▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░░
        ░░░▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░▓▓▓▓▒▓▓▓▓▒▒░▒▒▓▒▓▓▓▓▓▓▓▓▒▓▓▒▓▓▓▒▒▓▓▓▓░░░░▒▒▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▓▒▓▒░░░▒▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒░░░░░▓▓▓▒▓▓▓▓▒░░░░░░░░░░░░░░░░░░
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒▒▒░░░░▓▓▒▓▓▓▓▒░░░░░░░░░░░░░░░░░░
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒▒▒░░░░░░▒▒▓▓▓▓▒░░░░░░░░░░░░░░░░░░
        ░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░░░░░░▓▓▓▓▒▒░░░░░░░░░░░░░░░░░
        ░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░░░░░░░░▓▓▓▒▒▒░░░░░░░░░░░░░░░░
        ░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░▒▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░░░░░░░░░▓▓▓▒▒▒▒░░░░░░░░░░░░░░░
        ░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░▒▒▒▒▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░░░░░░░░░░▓▓▓▒▒▒▓░░░░░░░░░░░░░░░
        ░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░▓▓▓░▓▓▓▓▓▓▒▓▓▓▓▓▒▒▒░░░░░░░░░░░░░▓▓▓▒▒▒▒▓░░░░░░░░░░░░░░
        ░░░▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░░░░░░░▓▓▓▒▒▒▒▓░░░░░░░░░░░░░░
        ░░░░▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░░░░░░░░▒▓▒▒▒▒▒▒▓░░░░░░░░░░░░░
        ░░░░░▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░▓▒▒▒▒▒▒▒▓░░░░░░░░░░░░
        ░░░░░░▒▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░░░░░░░░░░▓▒▒▒▒▒▒▒▒░░░░░░░░░░░░
        ░░░░░░░░▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒▒░░░░░░░░░░░░░░░░░░░░▒▒▒▓▒▒▒▒▒▒░░░░░░░░░░░
        ░░░░░░░░░▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░▒▒▒▓▒▒▒▒▒▒░░░░░░░░░░░
        ░░░░░░░░░▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░▒▒▓▓▒▒▒▒▒▒░░░░░░░░░░░
        ░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░▒▓▓▓▓░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▒▒▒▒▒▒░░░░░░░░░░░
        ░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░▓▓▒▒▒▒▒▒▒▒░░░░░░░░░░
        ░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒░░░░░░░░░░
        ░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░
        ░░░░░░░░░░░░▒▓▓▓▓▓▓▒▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░
        ░░░░░░░░░░░░░▓▓▓▓▓▒▒▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒░▒▒▒░░░░░░
        ░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░
        ░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒░▒▒▒░░░░░
        ░░░░░░░░░░░░░░░░░░▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒░░░░░░░░░░░░░░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒░░░░
        ░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒░░░░
        ░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒░░░░
        ░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░▒░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒
    ";
    VictoriaDeBlois = "
        ████████████████████████████████████████████████████████████████████████████████████████████████████
        ████▓▓▓▓▓▓▓▓ ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█████
        ███▓▓▓▓▓▓▓▓▓▒▒░░░░░▒▓▓▓░░░░░▓░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓░░░░░░░░░░░░░░░░███
        ██▓▓▓░▒▒▓▓░▓▓▓▓▓▓▓▓░▒▓▓▒▒█▒▒▒▓█▒▒▓████████▒░ ░▓▓░░▒▒░▓░░▒▒▒▒▒░▒▒▒░░████▓▓▓▓░▒█▓▓▓▒▓▓▓██▓██▓▓▓░▓▓████
        ██▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓░▓░▒░▓▒▒█▒▒█▒░░▒██████░▒▒▒▒▒▒░▒░▓░▓▓▓▓▒░░▒▒▒▒▒▒▒▒▒░░░░░▓▓▓▓▒▓░▓▓▓▓▓▓▓█▓▓▓▓▓▓▓███▓██
        ██▓▒▓▓▓▓░▓▒▓▓▓▓▓▓▓▓▓▓░███▓▓░▓▓▓▓▓█░▒▒▒▒░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒██████▓████████▒▓████████
        ██▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓░░▒▒░░▓▓▓▓▓▓▓▒▒▒▒▒▒░▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒░░░▒▒▒▒░█▓▓█████████▒▓▓███████
        ██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒░▒░░░▒▒░▒███▓██████▒░▓▓███████
        ██▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒░▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░░▒▒░▒░█▓███████▓▓▓▓█████
        ██▓▓▒▓▓▓▒▓▒▓░▓▓░▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░░▒▒▒████████▓▒▓▓░▓████
        ██▓░░▓░▓▒░▓▓░▒░▓▓▓▓▓▓▓▓▓▓▓▓░░░▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▒░░░░▒▒░███████▓▓▒▓▓░▓████
        █████░▓▓▒▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░▒░████████▓▒▓▒▓▒████
        █████▓█▓░▓▓░▓░▓▒▒░▓░▒▓▓▓▒░░▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓███▓█▓▓█▒█▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░▒▒░▓░░░▓▓▒░▒█▒█████
        ██████░▓▒▓█▓▓▓▓▓▒▓░▓▒░▓░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓██▓███▓███████▓█████████████▓▓▓▓▓▓▓▒░░░░░▒▒▒░▓▓▓▓▓▒▒▒▒▒░▒░██
        ███████▒███▒░▓▓▓▓▓░█░░██▒▓▒▒▓▓▓▓▓▓▓▓▓███▓█████▓███████▓█▓█████████▓███████▓▒░░░░░░▒▓▓▓▓▓▓▓▓░▒░█▓▓▒██
        ███▒█████████░▓░████▒▒█▓▓▒▓▓▓▓▓▓███▓████░▓████▓███████▓█▒█████████▓███████▒▒░░░░░░▒░▓░▓▒▓▓▓▓▓░██▒▒██
        ████████▓▓██▒▒▒░░██░░█▓▓▒▓▒▓▓▓▒▓██▓▒████▒▒████▒█████████▒████▓███▓▓███████▒▒░░░░░░▒▒▓░▓▓▓▓▓▓▓▒░█▓░██
        ██▓███▓▓████░░░▒░▒▒░██░▓░▓▓▓█░█████▓▓███▓░████▓██████████████▓▓██▓▓█████████▒░░░░░░▓▓▓▓▓▓▓▒█░█░▒░███
        ███▓████░███▒░░▒░░█▓█░▓▒░▒▓▓▓▓██████▒███░▓██████▓█████████████▓██▓▓██░██▓███▒░░░░▒████▒▓▓████░██▓░██
        ███▓████░████▒████▓█▓▓░█▓▒▓▓▓▓▓▓█▓██▓███▒███▓██▓▓▓▓▓▓▓▓▓▒▓▓▓▒█▒█▓▒▓█████▓█▒▒░░░░░▒▒███▒░░████░█░▓▓██
        ██░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓█▓▓▓▓▒▒▓▓▓▓▓▒▓▓▓▓▒▓▓▓▒▓▓░▓▒▓▓▓▓▓▒▓▓▓▒▓████▒▓▒▒░░░░░▒░███░░░░░░░░░░▓▓██
        ██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▓▒▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▒▓▓▓▓▓▓░▓▓▓▓▓▒▓▓▓▓▓█▓▓▓▓▒▓▓▓▓██▓█░░░░░▒█████▒▓▓▓▓▓▓▓▒▓▓▓██
        ██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓█▓░░▒▓▓▓▓▒▓▓▓▒▓▒▒▓▓▓▓▒▓▓▓▓▓█▓▓▓▓▒▓█▓▓█▓█▓███▓▓▓▓▓▓███▓▒░░░▒▒▒████▒▓▓▓▓▓▓▓░▓▓▓██
        ██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█░▓░▓▒▒▒▓▓▓▒▒▓▓▓▓▓▒░▓▓▓▓▒█▓▓▓▓███▒░░▒█▓█░░░░▓░░▓▓▓▓▓▒▓█▒▒░░▒▒█████▓▓▓▓▓▓▓▓▓▓▒▓▓██
        ██▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒░░▓▓▒░▒▓▓▓▓▓░░░████░░░█████████▒████░░░░░░░▒▓▒▓▓▓▓▓▓▓▓░░░░░░▓███▓░▓▓▓▓▓▓▓▓▒░▒▓██
        ██▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒░▓▒▓▓▒▒▓▓▓▓▓▓▓████░░░░██████████████░░░░░░▓▓▒▓▓▓▓▓▒▓▓░░░▓▓░░░█▓▓▓░▓▓▓▓▓▓░▒▒░▒░██
        ██▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒░▓▓▓▓░░▓▓▓▓▓▓▓▓████░▒▒▒███████████████░▒▒▒█▓█▓▓▓▓▓▓▒░░░░░▓▓░░░▒▓░▒█▓▓▓▓░▓▒▒▒░▒▒██
        ██▒▒▒▒▒▒▒▒▒░░░░▒▒▒░▓▓▓░░░░▓░▓▓▓▓▓▓▓██████████████████████████▓█▒▓▓▓▓▒▒░░░░░░▓▓ ░░▒▓▓░▓▓▓█░▒▒▒▒▒▒▒▒██
        ██▒▒▓▒▓▒▒▒▒▒░░░▒▒▒▓▓▓░░░░░░░░▓▓▓▓▓▓████████████████████████▒██▒▓▓▓▓▓▒▓▓▓▒░░▓▓▓ ░░▓▓░▓▓▓▓░░░░░░░░░░██
        ██▒▒▓▓▓▓▓▒▒▒░░░░▓▓░▒▓▓▓░░▓░▒▓░▒▓▓▓▓░█████████████████████████▓▓▓▓▓▓▓▓▓▓▒░░░▓▓▓░▓▓▓▓▒▓▓▓▒▓▓▓▓░▓▓▓▓▓██
        ██▒▓▓▓▓▓▓▒▒▒░░▓░▒▓░▓▓▓░░▓▒░▓▒▓▓▒▓▓▓▓████████████████████████▒█▓▓▓▓▓▓▓▓▓░░░░▓▒░▓▓▓▓░▓▓▓▒▓▓▓▓▓░▓▓▓▓▓██
        ██▒▓▓▓▓▓▓▓▒░▓░▓▓▓░▓▓▓░░▓▓░▒▓▓▓▓▓▒▓▓▓▒▒█████████▓▓████████████▓█░▓▓▓▓▓▓░░░▓▓░░▓▒▓▓░▓▓▓▓░▓▓▓▓▓░▓▓▓▓▓██
        ██▒▓▓▓▓▓░▓░▒▓▓█░▒▓▓▓░░▓▓░░▓▓▓▓▒▓▓▓▓▒▓▓▓▓▓███████████████████▒██░▓▓▓▓▓░░░▒░░░▓▓▓▓▓░▓▓▓▓▓░▓▓▓▓░▓▓▓▓▓██
        ██▒▓▓░▓▓░▒█▓▒░▓▒▓▓▒░░▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒████████████░██████▓▒▓▓▓▓▓▓▓░▒▓▓▓▒▓▓▒░▓▓▓▓▓▓░▓▓▓░▓▓▓▓▓██
        ██▒░▓░░▓▓█░▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓░████▒██████████▓▓▒▓▒▒▓▓▓▓▓▓▓▒▓▓░▓▒░▓▓▓▓▓▓▓░▓░▓▓▓▓▓██
        ██▓░▓▓▓▒░▓▓▓░▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓░░░░░░▓░░██████████▓▒██▒█▒█▒▓▓▓▓▓▓▓░░▓▒▒░▓▓▓▓▓▓▓▓▓▓░▒▓▓██
        ██▓▓▓░▓▓▓░█░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓░▓▓▓░░░░░░░░▓█░░░█▒██████▒█▓██████▓░▒▒▒▓▓▓░▒░▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓██
        ███░▓▓░▒▓░░▓▓▓▓▓▓▓▒▒▒▒░░▓▓▓▓▓▓▓▓▓░▓▓▓▓░░░▒▒░░███░░░░▒███▒█████████▓████▒░░▓▓░▒▒░▓▒▒▒▒░▒▒░▒▓▓▓▓▓▓▓▓██
        ██▓███▒█▒▓███▓▓███▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓░░░░░░░░░███░░░░░████▓███▓█████░██▓▒▒▓▓░░░░░░▒░▒▒▒░▒▒▒▒▒▒▒░░░░▒██
        ██████▒██▒▒█████▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░▓░░▓███▓░▒▒▒█████▒░▒▒░▒▓▒░░░░░░░░▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒██
        ██░░██▒████████▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒░░░░░▒▒░░░░░░░░░██▒░░░███▓░░▓▓▓░▒▒░▒▓▓░░░░░░░░░░░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒██
        ██▒████▓██████▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓░░░░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▓░▓░░░░░░░░░░░░░░▒░▒▒▒▒▒▒▒▒▒▒▒▒██
        ██████▓█▓███▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓░░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▒▓▒░░░░░░░░░░░░░░▒░░░▒▒▒▒▒▒▒▒▒▒▒▒██
        ███████████▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▒░░░░░░░░░░░░░░░░░█▓▒░▒▒▒▒▒▒▒▒▒▒▒▒██
        ██▓▓██████████▓▓▓▓▓▓▓▓▒▓▓▓░▓░░░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░▒▓▒▓▒▒░░░░░░░░░░░░░░░░▒░▓▓▒░░▒▒▒▒▒▒▒▒▒▒██
        ██▓▓▓▒████████▒▓▓▓▒▓▓▓▓▓▓▓░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░▓▒▓▓▒░░░░░░░░░░░░░░░░░░░░▓▓▓▓░░▓░░░░░░░░░██
        ██▓█▓▓▓▒██████▒▓▓▓▓░▓▓▓▓░░░░░▒▒▒░▒░░░░░░░░░░░░░░░░░░░░▓░▓▓▓▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░▓▓░▒█▓░░░░░░░██
        ██▓▓▓▓▓▒██████▓▓▓▓▒▓▓▓░░░░░░░░▒░░░▒▒▒▒░░░░░░░░░░░░░▒▓▓▓▓▓░▒░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░▓░▓▒▓▓░░░░▓██
        ██████▓▓███████▓▓▓▓▓▓░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░░░░░░▓▒▓▓▓▒░░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░▓▒▒░░▓▓▓░▓▓░░░▓██
        █████▓█▓████████▓▓▓▓░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░▓░▒▒▒▒░▓░▓▓▓█░▓██
        ███▓███████████░█▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓░▒▒▒▒░▓▒▓░▓▓▓██
        ██▓██████████████▒▓█░░░░░░░░░░░░░░░░░░░░░░░▓▒▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓░▒▒▒▒░█▓░▓░░██
        ████████████████▒▒░░░░░░░░░░░░░░░░░░░░░░░▓▒▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░▓▓░▒░▒▒░█▓▓▒░██
        ███████▒▓█████▓▓██▒░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░▓░░░▒▒▒░▓▓▓░██
        ██████▓█▓███▒████▒░░░░░░░░░░░░░░░░░░░▓▓▒▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░▒▓▒▒▒▒▒▒░▓▓░██
        █████▓▓█▒█████▒███░░░░░░░░░░░░░░░░░░▓▓▒▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░▒░░▒▒▒▒▓░▓▓▓██
        ██▓▓█▒██████▓███▓█▒░░░░░░░░░░░░░░░▓▓▓▒▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▓▒▒░▓░░░░░▓▒░▒▓▒░░▓▒▒▒▓░░▓██
        ██▓▓▓▓▒▒████▓█████▓░░░░░░░░░░░░░░▓▓▓▒▓▓▓▓░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▓▓▒▒▓░░░░█░██▓▓▓▓▓▓█▒▓▒▒▓▓▓██
        ██▓▓▓▓░▒▓▓█▓▓███████░░░░░░░░░░░░▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▒▒ ▓▓▓███▓█▓▓▓▒▒▓█▓▓▒▓▓▓██
        ██▓▓▓▓░▒▒▒▓▒▓███████░░░░░░░░░░░▓▓▓▓░▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ░░░▓█▒██████▓▓▓▒▓▓▓▓▒▓▓▓██
        ██▓▓▓▓▒░▒▒▒▒▒▒▓▓▓▓▓▓░░░░░░░░░░▓▓▓▓▓░░▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░▓▒▓█████▓▓█▓███▓▒▓▓▓██
        ██▓▓▓▓▓▓░▒▒▒▓▓▒▒▓▓▓▓░░░░░░░░░░▓▓▓▓▓░░▓▓▓▓▓▓▓░░░▒▓▓▓▓▒░░░░░░░░░░░░░░░░░░░▒▒▒░░░░▓▓█▓████████▓▓▓▓▓▓▓██
        ██▒▓▓▓▓▓▓▓▒▒▒▒▓▒▓▒▒▓░░░░░░░░░▒▓▓▓▓▓▒▒▒▓▓▒▓▓█▓▒▒▓▒▒▒▓▒▓░▓░░▒▒▒▒▒░░░░░░░░▒▒▒▒░░░░▒▒▒▓▓▓▓█████▓░▓▓▓▓▓██
        ██▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓░░░░░░░░░▒▓▓▓▓▓▒▒▒░▓▓▓▓██▓██▓▓▒█▓█▒▓▓▓▒▒▒▒▒▒▒░░░░░▒▒▒▒░░▒░░░▓▒▒▒▓▓▓▓▓▒░▓▓▓▓▓▓▓██
        ██▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░░░▓▓▓▓▓▒▒▒▒░▓░▓▓▓▓▓▓▒░▒▒▒▓▓▒▒░░▒▒▒▒▒▒▒▒░░░▒▒▒░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██
        ██▒▒▒▒▒▒▓▓▓▓▒▓▒▒▓▓▓▓▓▓▓▓░░░░░░▒▓▓▓▓░▒▒▒▒▒▓▒▓▒▒▒▓▓██▓▒░░░░░░░░░▒▒▒▒▒▒▒▒░▒░░░░░▒▓▓▓▒▓▓▓▓▒▓▒▓▓▓▓▓▓▓▓▓██
        ███▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░▒▒▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓░░░░░░░░░░░▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓███
        ████▓▒▒▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▒░▓▓▓░▒▒▒▒▒▒▒░▓▓▓▓▓▒▒▓▓▓▓▒░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓█████
        ████████████████████████████████████████████████████████████████████████████████████████████████████
    ";
    Morgiana = "▓▓▓▓▓▓▓▓▓█▓▓▓▓▓▓▓▓▓█▓▓▓▓▓█▓▓▓▓▓▓▓▓▓░▓▓░░▓▓▓▓▓▓▓▓▓▒▒▓█▒▓▓▓▓▓▓░░▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓░▓▓▓▓▓▓▓▓▓█▓▓▓▓█▓▓▓▓▓▒░▓▓▓▓░▒▓░▓▓██▒░░░▓▓▓▓▓▓█▒▒█▓▓▓▓▓▓░░░▓▓▓▓▓░▓▒░▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓
        ▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░█▓▓▓▒▓▓▓▓▒▓▓▓░▓▒░░▓░░▓▓▓█░░▓░░▒▓░▓▓▓▒▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓
        ░▓▓▓▓░▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓░▓▓▓▓░
        ░▓▓▓░▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓░▓▓▓░
        ░▓▓▓░▓▓▒░▓▓▓▓▓▓▓▓▓▓▓▓██▓▓▓▓▓█▓▓▓▓▓▓█▓▓█▓▓▓▓▓▓▓▓░▓▓▓▓░▓▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓░▒▓▓░▓▓▓░
        ▓░▓▓▓▓▓░██░▓▓█▓▓▓▓██▓█▓█▓▓▓▓██▓█▓██████▓███████▓▓▓██▓████▓█▓▓▓█▓▓▓▓▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓░▓▓▓▓▓░▓
        ▓▓▓▓░░░░▒▓▓▓▓▓▓█▓▓█▓██▓█▓▓▓██▓▓█▓██████▓███▓▓██▓░▒▒░███▓███▓█▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░▓▓▓▓
        ▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒░░░░▒░▓▓▓▓▓▓▓▓▓▓▒▓▓▒▓▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓█▓▓███▓█▓▓▓▒▒▒▓▓█▓▒▒▒▒▓▒▒▒▒▒░░░░░░░░░░░░░░▒▒▓▒▓▒▒░▓▓▓▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓
        ▓▓▓▓██░▒▓▓▓▓▓██▓██████████▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░░░░░░░░░░░░░▒░░░░░▓▓▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▓▓▓▓▓▓
        ▓▓▓▓▓▓▓░▓▓█▓▓▓▓██▓███████▓▒▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▓▒▒▒▒░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▓▓▓▓▒▓░░░░ ░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓░▓█▓▓▓▓▓▓█▓█▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓
        ▓▓▓▓███░█████▓███████████████▓▒▓▓▓░░░░░░░░░░░░░░░░░░░░░░ ░░░░░░░░░░░░▒░▓▓▓▓▒▓▓▓▓▓▓▓▓█▓▓▓▓▓▓▓░▓▓▓▓▓▓▓
        ▓██▓█▓▓▓███████████████████▒▓▓▓▓▒▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓█▓██▓▒▓░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓█▓▓▓█▓▓▓▓▓█▓██▓███████████▓▒░▒░░░░▓▓░░░░░░░░░░░░░░░░░░░░▓▓░░░░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓███▓██▓███████████████████████▓░░░░░░▓▓▓▓▓░░░░▓░░░ ░░░░░░░░▓▓▓░░░░░░░░▒▓█▓██▓█▓▓▓▓▓▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓██▓▓█▓████████████████████▓░░░░░█▓▓▓▓▓▓░▒▓░░░█░ ▓░░░░░░▓▒░░▓░░░░░░▒▓█▓█▓█▓▓▓▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██▓▓▓█▓▓▓███▒░░░░ ░▒▓▓▒▓▓░▓▓▓█████▓▓▓▓▓▓▓ ░█▓ ▓░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓▓█▓█▓▓▓▓████▒░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██ ▓▓░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓█▓▓▓█▓▓▓█▓█▓██▓████▓██░▒▒░░░░░░░ ░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓░▓▓█░████████████████████████░▒▒░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓░░░░░▒░░░░▓▓▓▓▓▓█▓▓█▓█▓▓▓▓▓▓▓▓▓▓░▓▓▓░▓
        ▓▒▓▓▓█▓▓███████████████████████▒▓░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░▒█░░░░█░▓▓▒▓▒█▓█▓▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓███▓█████▒▒░▒░░░░░░░░░░░▒▓▒▒▓▓▓▓▓▓▓▓░░ ░░░░▒▓▓░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓███▓█▓███▒░▒▒░░░░▓▒░░░░░░░▓░░░░░░░ ░░░░░░░░▒▓█░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓░▓▓▓██▓▓▓▓█▓██████████████▒█░█▓███▓▓▓▓█▒░░░░░█░░░ ░░░░░░░░░░███░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓
        ▓▓▓█▓░██████████████████████████▒████▓▓▓▓▓▓▓▓▓░░░░░██░░░░░░░░░░░▒███░░▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓
        ▓▓▓█▓░██▓████████████████████████▓██▓▓▓▓▓▓▓▓▓▓▓░░░░░██░▓░░░░░░░▒████░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓▓▓▓▓░▓▓▓▓▓
        ▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓█████████████████▓▓▓▓▓▓▓▓▓▓▓▓░░░░▒███▓░░░░░░▒██▓█ ░█░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓█▓▓█▓██▓██████▒██▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░████▓░░░░░▒██▓▓█░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓██▓▓▓█▓████████████████▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░▒███▓█░░░▒███████▓▓▓▓▓▓▓▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▒█████████████████████████████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░▒▒▒▒▒███░░▒██████▓▓▓▓▓▓▓████████▓▓█▓▓▓▓▓▓▓▓▓▓▓▓
        █▓███░█████████████████████████████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒░▒▒▒▒█░█░▒█████▓▓▓▓▓▓▓█████▓██▓█▓▓▓▓▓▓▓▓░▓▓▓▓▓
        ▓▓▓▓░░▓▓▓█▓▓▓▓▓▓███▓█████████████▒█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▒▒▒██▒████▓▓▓▓▓▓▓▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░▓▓▓▓
        ▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓██▓█▓█▓██████▒▒█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▒▒█▓█▓▓▓▓▓▓▓░█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓
        ▓█▓▓▓▓▓▓▓██▓▓▓▓█████▓███████████▓▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓███▓▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        █▓▓▓██▓███▓█████████████████████▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▒▒▒▒▓▓▓▓▓▓▓▓█▓████▓█████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓█▒░▓█▓█████████████████████████▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓█████████▓██▓▓▓▓▓▓▓▓▓▓▓▓░▒▓▓
        ▓▓▓▓▓░▓▓▓▓▓█▓▓▓███████████▓█████▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▒██▓███▓▓▓▓▓▓█▓▓▓▓▓▓▓▓▓░▓▓▓▒▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██▓█████▓███▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█████▓█▓████▓██▓▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓▓▓▓▓▓▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        █▓▓█▓█████▓█▓███████████████████████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓███████████▓▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓█▓███▓▓▓▓▓█████████████████████████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓░██████▓█▓██████▓▓▓█▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓█▓▓▓████▓██▓████████████████████▓▓▒▒▒▒▒█▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓█▓█▓████▓▓░▓▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓▓█▓▓▓██▓████████████▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░ ▓▓▓▓▓█▓▓▓█▓▓▒▓▓▓░▓▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓█▓▓▓▓█▓▓▓▓██▓▓█▓██▓███▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░  ▒▓▓██▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓█▓▓▓████████████████████████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▓██████▒▓▓▓▓▓▓▓▓▓▓▓▓█▓▓█▓▓▓▓▓▓▓▓▓▓▓▓▓
        ██▓▓▓░▒▓████▓████▓█████████████▓█░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒░▒▒▒░░░░░░░▒▓████░▓▓▓▓▓▓░▓▓▓█▓▓▓▓▓▓▓▓▓▓▓▓░░▓▓▓▓▓
        ▓▓▓▓▓▓▓░▓▓▓▓▓▓▓█▓▓▓▓▓▓██▓█▓▓██▓▓▒▒▒▒░▒░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒░░░░░░▓▓▓▓▓▓▓▓▓▓▒▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ ░░ ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██▓▓████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓
        ▓█▓██▓▓░▓█▓▓█▓█▓██▓██████████████▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒███▓▓▓▓▓█▓▓▓▓▓▓█▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓
        ▓▓▓▓▓█▓░▓▓▓▓▓█████████████████████░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒█▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓
        ▓▓▓▓▓▓░▓▓▓▓██▓▓▓▓▓█▓██████████▓██▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓
        ▓▓▓▓▓▓▓░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓███▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▒░▓▓▓▓▓▓█▓▓▓▓▓▓▓▓▓▓░█▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▓▓▓▓▓▓
        ▓█▓█▓▓▒▓█▓▓▓████▓███████████████████████████▓███████▓█▒██████▒███▓▓▓███▓▓▓▓█▓▓▓▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓░░░█▓▓▓▓░▓▓░░███▓█░░░█▓███▓█▓░░▒█▒▒▒▓███▓█████░█████▓█▓████▓▓▓▓█▓█▓▓▓▓▓▓▓▓█▓▓▓▓▓▓▓▓▓▓▓▓░░░▓▓▓▓▓
        ▓▒▓▓▓▓▓░▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓███▓▓▓▓▓▓█▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓░▓▓▓▓▓▓▓
        ░▓▓▓▒▓▓░░▓▓▓▓▓▓▓▓▓▓▓▒▓▓░▒▓▓█▓▓▓█▓█▓▓▓█▓▓█▓▓▓██▓▓▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓██▓█▓▓▓▓▓▓▓▓▓▓▓░░▓▓▓▓▓▓░
        ░▓█▓░▓▒▓░▓▓█▓▓▓████▓▓▒░░░▒ ██ █ █ █░░▓▒▓█▒█ █ █░▓▒▓▒▒  █████▓██▓▓▓██████▓▓▒████████▓▒███▓▓▓░▓▓▓░▓▓▓░
        ░▓▓▓▓░▓▓▓░▓▓▓▓█▓▓▓▓▓░░▓ ░▓ ▒█░█▒█ ▒░▒▓▒░█░█ █ █ █▒▓░▒░░▓▓▓▓▓█▓███▓▓█████▓█▓██████▓███▓▓▓▓▓░▓▓▓░▓▓▓▓░
        ▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ ░▒▓▓▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒░▓░░▒▓▓░▓▓▓▒▒▓░▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓░▓
        ▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓
        ▓▓▓▓▓▓▓▓█▓▓▓▓▓▓▓▓▓█▓▓▓███▓▓▓██▓██▓██████████████▓█▓▓▓▓▓█▓█▓▓▓████▓▓▓█▓█▓▓▓▓▓██▓▓▓██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
    ";
    UmaruDoma = "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░▒▒▒▒▒▒▒▒▒▓▒▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▒▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░▒▒▒▒▒▒▒▓▓▓▒▓▓▒▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▒▒▒▒▒▓▓▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░▒▒▒▒▒▒▓▓▓▓▒▒▓▒▒▓▓▓▓▓▒▓▓▓▓▓▒▓▓▓▓▓▓▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░▒▒▒▒▒▒▒▓▓▓▒▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒▒▒▒▒▓▒▒▒▒▒▒▒▒▓▓▓▓▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▓▓▒▓▓▓▓▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░
        ░░░░▒▒▒▒▒▒▒▓▓▒▓▓▓▒▒▒▒▒▒▒▒▒▒▓▒▒▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░
        ░░░▒▒▒▒▒▒▒▓▒▓▒▓▓▓▒▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▓▒▓▓▓▓▓▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░
        ░░░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░
        ░░░▒▒▒▒▒▓▓▓▓▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░
        ░░░▒▒▒▒▓▓▓▓▓▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░
        ░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░
        ░░░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░
        ░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒▒▒▒▒▒░░░░░░░░░░░░░░░░░
        ░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒░░░░░░░░░░░░░░░░
        ░░░░▒▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░
        ░░░░▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░
        ░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░
        ░░░░░▒▒▓▓▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░
        ░░░░░▒▓▓▓▓▓▒▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▒▒▓▓▒▒▒▓▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░
        ░░░░░░▓▓▓▒▓▓▓▒▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░
        ░░░░░░▒▓▓▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░
        ░░░░░░░▓▒▒▒▓▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░░░░░
        ░░░░░░░▒▒▒▒▒▓▓▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░░░░
        ░░░░░░░▒▒▒▒▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒░░░░
        ░░░░░░░▒▒▒▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒░░░
        ░░░░░░░▒▒▒▒▒▒▒▒▓▒▓▓▓▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒░░░
        ░░░░░░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒░░
        ░░░░░░░▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▓▓▓▓▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒░░
        ░░░░░░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▓▓▓▓▒▓▓▓▓▒▒▒▒▒▒▒▒▒░░
        ░░░░░░░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▓▓▒▒▒▒▒▒▒▒░░░
        ░░░░░░░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▓▒▒▒▒▒▒▒░░░
        ░░░░░░░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒░░░░
        ░░░░░░░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒░░░░
        ░░░░░░░▒▒▒▒▒▒▓▓▒▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒░░░░░
        ░░░░░░░▒▒▒▒▒▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░
        ░░░░░░░▒▒▒▒▒▒▒▓▒▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░
        ░░░░░░░░▒▒▒▒▒▒▓▒▒▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░
        ░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░
        ░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░
        ░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
    ";
    Happy = "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░▒░▒▒▒▒▒░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░▒▒▒▒▒▒▒▒░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░▓▓▒▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░▒▒▓▓▓▓▓░░░░░▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░▒▒░░░░▒▓▓▓▓▓▓░░░░░░▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒░░░░░░░░▒▒▒░░▒▒▓▓▓▓▓▓▓▒░░▓▓▓▓▒▒▒▒▒▒▓▓░░░░░░▓▓▓▓▓▓▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░▓▓▓▒▓▒▓▓▓▓░▓▓▓▓▓▓▓▓░░░▒▒▒▒░░▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓░░░░░░▓▓▓▓▓▓▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░▓▓▓▓▓░▓▓▓▓▓▓▓▒▓▓▓▓▒▒▒░▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▓▓░▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░▓▓▒▓▓▓▓▓▓▓▒▓░▓▓▓░▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒░░░░░▓▓▓▓▓░░░░░░░░░░░░░░░░░░░▓▓▓
        ░░░░░░░░░░░░░░▒▓▓▓▓░▓▓▓░▓░▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒░░
        ░░░░░░░░░░░░░░░▓▓▒▓░▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓░▓▒░░░░░▓▓▓▓▓▓▓░░░░
        ░░░░░░░░░░░░░░░░░▓▓▓▓▓▒▓▓▓▓▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▓▓▓▓▓▒░▒▒▓▓▓▓▓▓▓▓▓░▓▓▓▓░░▒░░░░░░
        ░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▒▓▓▓▓▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒░▒▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓░▓░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▒▓▓▓▓▓▓▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓░▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▒▒▒▒▒▒▓▓▓▒▓▒▓▓▓▓▒▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒░▒▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒░░░▒▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒░▒░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░▒▒░░░▒▒░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒░░▒▒▓▓▓▓░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░░▒▒▒▒░░░░░░░░░░░░░▒▒▒▒▒▒░░░░░░░░░░▓▓▓▓▓░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒░░░░░░░░░░░░░░░▒▒▒▒▒▒░░░░░░░░░░░░░▓▓▓▓▓░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒░░░░░░░░░▒▒▒▒▒▒░░░░░░░░░░░░░░░░▒▓▓▓▓░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░▒▓▓▓░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓░░░░░░░░░░░░░░░░░
    ";
    KoutarouTatsumi = "▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░░▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒░▒▒░░░▒▒▒▒▒▒░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░▒▒▒▒▒▒░░░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒░▒▒░▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒▒▒▒▒▒░░░▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░▒░░▒▒▒▒▒░░░▒▒▒▒░▒░▒▒▒▒▒▒▒▒▒░▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░▒▒░▒▒▒▒░░░░▒▒▒▒░▒░▒▒▒▒▒▒▒▒▒▒░▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░▒░▒▒▒▒░░░░▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒░▒▒▒▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░░▒░░░░▒▒▒░░░░▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░░▒░░░▒▒▒▒░░░▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒▒▒░░░▒▒▒▒▒▒▒░▒▒▒▒▒▒░░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒░▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░▒▒▒▒▒▒▒░░▒▒▒▒░▒▒░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▒░░▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒░░▒░▒░░▒▒▒▒▒▒▒░░▒▒░░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒░░░▒▒▓▓▓▓▒▒▒░▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒░░░░░░░░░░░░░░░░░▒▒▒▒▒░▒▓▓▓▓▓▓▓▓▒▒░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒░░░░░▒░▒▒░░░░░░░░░░▒▓▓▓▓▓▓▒▒░░░░░░░░░░░░░░░▒▒▓▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░▒▒░░░░░░░░░░░░░▒▓▓▓▓▒░░░░▒▒▒▒░░░░░░░░░░░▒▒▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒░░░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░▒▒▒▒▒▒▒░░░░░░░░░░░░▒▒▓▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░▒▒▒▒▒▒▒░░░░░░░░░░▒▒▓▓▒░░▒▒▒▒▒▒░░░░░░░░░░░▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▓▒░▒░░▒▒▒▒░░░░░░░░░░░▒▒▒▓▓▓▒░░▒▒▒░▒░░░░░░░░░░▒▒▒▒▒▓░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▓▒▒▒▒▒░░░░░░░░░░░░░░░░▒▒▒▓▓▓▒░░░░░░░░░░░░░░░▒▓▓▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▒▒▒▒▓▓▒▒░░░░░░░░▒▒▒▓▓▓▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▓▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒░░░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒░░░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒░▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░▒▓▒▓▓▓▓▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▓▓▓▓▓▓▓▓▒▓▓▒░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒
        ▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░▓▒▒░▒░░▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒░▒▒▒░░░░▒▒▓▓▒▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░▒▒▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░▒░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░░▒▒▒▓▒░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░░░░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▒▓▒░░░░░░░░░░░░░░░▒▒▒▒░░░░░░░░░░░░░░░░▒▒▓▒▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▒▓▓▒░░░░░░░░▒▒░░▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░▒▓▒▒▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▒▓▓▓▒░▒▒▒░░░░░▒▒▒▒▓▓▓▓▒▓▓▓▒░░░░░░░░░▒▒▓▓▒▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▒▒▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▒▓▓▓▓▒▓▓▓▓▒░░░░░░░▒▒▓▓▓▒▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▒▓▓▓▓▓▒░▒▒▓▓▓▓▓▓▒▓▓▓▓▒▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▒▒▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▓▓▓▓▓▓▓▒░░▒▒▓▓▓▓▒▓▓▓▓░░░░░░░░░░▒░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▒░░░░░░░░░░▒▒░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒░░░░░░░░░░▒▒▒▒░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░▒▒▒▒▒▒░░░░░░░░░░
        ░░░░░░░░░░░░░░░░▒▒▒░░░░░░░░░░░▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░▒▒▒▒▒▒▒░░░░░░░░░
        ░░░░░░░░░░░░░░░▒▒▒▒▒░░░░░░░░░░░▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒░░░░░░░
        ░░░░░░░░░░░░░░▒▒▒▒▒▒░░░░░░░░░░░▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░
        ░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒░░░░░░░░░░▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░
    ";
    Sakaki = "▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▒▒▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▒▒▒▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒▒▒▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▒▒▒
        ▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▒▒▒▒▒▓
        ▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓
        ▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒░▒▒▒▒▒░░░░▒▒▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▓▓▒▓▒▒▒▒▒▒░▒▒▒▓▓▒░░░░░░▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒░░▒▒▒▓▓▓▓▓▒▒▒░░▒▒▒▒▓▒░░░░░░░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▓▒▓▒▒▒▒▓▓▒▒▒▒▓▒▒▒▒▒░▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒░▒▒▒▓▒░░░░░░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▓▓▒▒░░▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓░░░░░░░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒░░▒▒▓▒▒▒▒░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▒░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▒▒▒▒▒▓▒▓▒▒▒▓▒▒▒▒▒▓▓▓▓▓▓▒░▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▒░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▒▒▒▒▓▓▓▒▒▒▒▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▒▒▒▒▓▓▓▒▒▒▒▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒
        ▓▓▓▓▓▒▒▒▒▓▓▓▒▒▒▓▓▒▒▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▒▒
        ▓▓▓▓▓▒▒▒▓▓▓▓▓▒▒▓▓▓▒▓▒▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▒▓
        ▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▒▒▓
        ▓▓▒▒▒▓▒▓▓▓▓▓▓▒▒▒▓▓▓▒▓▒▒░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▒▓▓
        ▓▒▓▓▓▓▒▓▓▓▓▓▓▓▒▒▒▓▒▒▓▒▒░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▒▒▒▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▒▒▒░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▒▒▒▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▒▒▒░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░▒▓▒▒▒▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▒▒▒░░░░░░░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒░░░░░░░░░░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░▒▒▒▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒░░░░░░░░░░░░░░░░░░░▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░▒▒▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░▒░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░▒▒▓▓▓▓▓
        ▒▒▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒░░▒▒░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░▒▓▓▓▓▓
        ▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒░░░░░░░░░░░░▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░▒▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒░░░░░░░▒▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒▓▓▓
        ▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░▒▓▓
        ▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░░▓▓
        ▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▒▒▓
        ▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▒▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▒▒▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▓▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▓▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▓▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▓▓▓▓▒▒▒▒▓▓▓▓▓▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▓▓▒▒▒▓▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        "; 
    ChihiroOgino = "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒░░▒▒▒▒▒░▒▒░▒▒▒░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░▒░▒▒▒▒░▒▒▒▒▒░▒░░▒░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░▒▒▒▒▒▒▒▒░▒▒▒░▒▒▒▒▒▒▒▒░▒▒░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒░▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░▒▒▒▒▒▒▒▒▒▒░▒▒░▒▓▒▒▒▒▒▒▒▒░▓▒▒░░░░░░░░░░░░░░░░░░░░░▒▒░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░▒▒░▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░▒▒░▒░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒░░▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░▒░░░░░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▒▓▓▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▒▓▓▒▒▒▒▒▒▓▓▒▒▒░▓▓▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░▒▓▓▓▓░░▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▓▓▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░▒▒
        ░░░░░░░░░░░░▒░░░░░░░░░░░░░░▓▓▓▓░░░░▒▒▒░▒▒▒▒░▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░▒▒▒▒░░░░
        ░░░░░░░░░░░░▒░░░░░░░░░░░░░░▓▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░▒▒▒░░░▒▒▒░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░▓░░░▒▒░░▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒░░░▒▒▒▒░░▒▒▒░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒░░░▒░░▒▒░░░▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒░▒▒▒░░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░▒░░░▒░▒▒░▒▒░░░░▓▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒░░▒▒░░░▒░░░░▒
        ░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒░░░░░░░▒▒░▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░▒░░░░░▒▒▒▒░░░░░░░░░░░░░
        ░░░░░░░░░░░▒░▒▒▒▒▒░▒░░▒▒▒▒░░░▒▒▒▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░▒░░▒▒░░▒▒░░▒▒▒░░░▒▒▒▒▒
        ░░░░░░░░░░░░░░░░▒▒░░▒░░░░░░░░▒▒▒▓▓▓░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒░░▒▒▒░░░▒▒░▒▒
        ░░░░░░░░░░░▒▒░░░░░░░░▒▒░░▒▒▒░░░▒▓▓▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒░░░░░░░░░░░░░░░░░░░░▒▒▒▒░░░▒▒▒▒░
        ░░░░░░░░░░░░░░░░░░░░░▒▒░░▒▒▒░░░░▓▓░▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░▒░▒▒░░▒▒░▒▒░
        ░░░░░░░░░░░░░░░░░░░░░▒▒░░▒░░░░░░░░░░░░░░▒▒▒▒▒▒░░░░░▒▒▒▒▒▒░▒▒▒▒░░░░░░░░░░░░░▒░░▒▒▓▒░░░░░░░▒▒▒░░▒▒▒░▒▒
        ░░░░░░░░░░░░░░░░░░░░░▒▒░░░▒░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░░░░░░░░░░░░░░░░░░░░░░▒░░▒▓▓▒░░░░░░▒▒░▒░░▒▒▒▒▒▒
        ░░░░░░░░░░░░░░░░░░░░░▒▒░░▒░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░▒▒░░░▓▓▒░░░░░░░▒▒▒░░▒▒▒▒▒▒
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒░░░░░░░▒▒░░░░░▒░▒▒░░░░▒▒▒▒░░░▒░░░▒
        ░░░░░░░░░░░░░░░░░░░░▒▒░░░░░░░░░░░░░░▒▒▒▒▒▓▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒░░░░░░▒▒░░▒▒░░░░▒▒░░░▒▒▒▒░░░░▒░▒▒
        ░░░░░░░░░░░░░▒░░░░░░░░░▒░░░░░░░░░░░░▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒░▒▒░░░░░░▒░▒▒▒░░▒░▒▒▒░░░▒▒▒░░░░▒░▒▒
        ░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒░░░▒░░░░░░░░░░▒▒▒░▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒░░░░░░░░▒░▒▒▒░░▒▒▒▒▒░░░░░░░░▒░░░▒▒
        ░░░░░░░░░░░░░▒▒▒░░░▒░░░░░▒▒░░░░░░░░▒▒▒▒▒▒▒▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒░░░░░░░░░░▒▒▒░▒▒░▒▒▒░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░▒░░░░░░▒▒░░▒▒░░░░░░░░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░░░░░░░░░▒▒░░░▒░▒▒▒░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░▒▒░░▒░▒▒▒░▒▒▒▒▒░▒▒▒▒░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒░░░░░░░░░░░▒▒▒▒▒▒▒░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒░░░░░░░░░░░░░░▒▒▒░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░░░░░▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒░░░░░░░░░░░░░░░░░
    ";
    UryuuIshida = "▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▓▓▓▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░░░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▓▒▒▓▓▓▓▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░░▒░▒░░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▓▒▓▒▒▓▒▒▒▒▓▓▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒░░░▒▓░▒▒▒▒▒▒▒░░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▓▒░▒▒░▒▒▒░░▒▒▒▒▒▓▓▓▒▒▓▓▓▓▓▓▓▓▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒░▒▒░▒▒▒░░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▒▒▒▓▓▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒░▒▒░▒▒░░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒░░▒░░▒░░░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒▒░▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒░░░░░▒░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▓░░░░▒░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▒▒░░░░░▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒░▓░░░░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒░░░░░░░░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒░░░░░░░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▓▓▓▓▓▒▒░░░░░░░░▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▓▓▒▒▒▒▒▒▒░░░░░░░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▓▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒░░░▒░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░░░░░░▒░░▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░▒░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░░░░░░░░▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓
        ▓▒▒▓▒▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░▒░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒░░░░░░░▒░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▓▓▓▒▒░▒░▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒░░▒░░░░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒░▒▒▒▒░▒▒▒▒▓▓▒▓▓▓▓▒▒▒▒▒▒▒▒░░▒░░░░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒░░▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒░░▒░░░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▒▓▓▒▓▓▒▒▒▒▓▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▓▓▒▓▓▓▓▓▓▓▒▒▒▓▓▓▒▓▓▓▓▓▓▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒▓▓▓▓▒▓▓▓▓▓▒▓▓▓▓▓▒▒▒▓▓▓▒▓▓▓▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▓▓▒▓▓▓▓▓▓▒▒▓▓▒▓▓▒▓▓▒▒▒▓▓▓▒▓▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒▓▓▓▓▒▒▓▒▓▓▓▒▓▒▓▓▒▒▒▓▒▓▒▓▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▒▓▓▓▒▒▒▓▒▓▒▓▓▓▒▓▓▓▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▒▒▒▓▓▓▒▓▓▓▓▒▓▓▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▒▒▓▓▓▓▓▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▒▒▒▒▓▓▓▓▒▒▒▓▓▒▓▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▒▒▓▓▓▒▒▒▒▓▓▓▒▒▒▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▓▒▒▓▓▒▒▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▒▒▓▒▒▒▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒
        ▒▒▒▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒░▒▒▒▒░
        ▒▒▒▒▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒
        ▒▒▒▒▒▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒░▒▒▒▒▒▒
        ▒▒▒▒▒▒▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒░
    ";
    SatoriTendou = "░░░░░▒░░░░░░░░░░░░▒░░▒░░░▒▒▒▒▒░░░░░░░░░░░░░░▒▒▒▒░░░░░░░░▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒░▒▒▒▒▒▒░░░░░░░░░░░░░░▒░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░░░░░░░░░░░░░░░░▒▒▒▒▒▒░░░▒▒▒▒▒░▒▒▒▒▒▒░░▒▒▒▒▒▒░▒▒▒▒▒▒░░░░░░░░░░░░░▒▒░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░░▒▒▒▒▒░░▒▒▒▒▒░░▒▒▒▒▒▒░▒▒▒▒▒▒░░░░░░░▒░░░▒▒▒▒░░░░
        ░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░░▒▒▒▒▒░░▒▒▒▒▒░░▒▒▒▒▒▒░▒▒▒▒▒▒░░░░░▒▒▒▒░░▒▒▒▒░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░▒▒▒▒▒░░▒▒▒▒▒░░▒▒▒▒▒▒░▒▒▒▒▒▒░░░░░▒▒▒▒░░▒▒▒▒░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░▒▒▒▒▒░░▒▒▒▒░░░░▒▒░▒░░▒▒▒▒▒▒░░░░░▒▒▒▒░░▒▒▒▒░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░▒▒▒▒░░░░▒▒▒▒░▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░▒░▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒
        ░░░░▒░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░▒▒▒▒▒░░░░░░▒▒▒▒▒▒
        ░░░░░░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░░░░▒░░░░░░░░░░░░░░░░░░░
        ░░░▒░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░▒░░░░░░░░░░░░░░▒▒▒░░░░▒░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░▒░▒░░░░░░░░░▒▒▒░░▒░▒░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░▒▒░▒▒░░░▒▒▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░▒▒▒░░░░░░░░░░░░░░░░░░░░░▒░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░▒░▒░▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░░▒
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░▒░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓░░▒▒▒▒▒▒▒░▒░░░░░░░░░░░░░░░░░░░░░░▒░▒▒▒░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▓▒▓▒░▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓░▒░▒░░▒░▒▒▒▒▒▒░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▒▒▒▒▒▓▓▓▓▓▒▒░▒▒▒░░▓▓▒▒░░░░░░░▒▒▒░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░▓▒▓▓▒▒▒▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓░▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▓▓▒░▒▒▒▓▒▒▒▓▓▓▓▓▓▓▓▒▓▓▓▒▒▒▒▒▒▒░░▒▒░░░░░░░░░░░░░░░░░░░░░░▒░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▓▓▓▓▓▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓░▓▓▓▓░▒▒▒▒▓▓▓▓▓▓▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▒░▒▒▓▓▓▓▓▓▓▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░
        ░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░▒▒▒▒▒▒
        ░▓░░░░░░░░▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓░░░░░░░░░░░░░░░░░░░░▒░░░░░░▒▒▒▒▒▒▒▒▒▒
        ░▓▓░░░░░░░▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒░░░░░░
        ░▒▒▓░░░░░░▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒
        ░░▒▒▓░░░░░▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░▒▒▒▓░░░░░▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░▒░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░▒▒▒░░░░▒▒▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▓▓▓▓▓▓▒▓▓▓▓▒▓▓▓▒▒░░░░░▓▓░░░░░░░░░░░░░░▒▒▒▒▒▒░░░░░
        ░░░░▒▒▒▒▒░░░▒▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▓▓▓▓▒▓▓▓▓▓▒▒▓░░░░░░▒▒▓▓░░░░░▓▓░░░░░░░░▒▒▒░▒░░░░░
        ▒▒▒░░░▒░▒▓░▒▒▒▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▓▓▒▒▒▒▓▒▒▒▒▒▒▒░░░░░░░░░▒▒▒▓▓▒░░░▒▓▓░░░░░░░░░░░░░░░░░░
        ░▒▒▒▒▒▓▒▒▓▓▒▒▒▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▒▓▓▓▓▓▒▓▓▓▓░░░░░░▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▓▒▒▒▒░░░░░░░░░░░░░░
        ░░░▒▒▒▓▒▒▒▒▒▒▒▒▒▓░░░░░░░░░░░░░░▒▒▒▒░░░░░░░░░░░▓▓▓▓▓▓▓▓░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░
        ░░░░▓▒▒▒▒▒▒▒▒▒▓▒▓▓░░▒▓▓▓▓░░░░▒▒▒▒▒▒▒▒░░▓▓▓▓▒░░░▓░░░░░░░▒▓▓▓░░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▓▒▒▒▒▒▒▓░▒░░░░░░░░░░
        ▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒░░▓▓▓▓▓▓▓▓▒░░░░░░▒▒▒▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▓▓▓▒░▒▒░░░░░░░░
        ▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░
        ░░░░░▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒░▓░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓░░▒▒▒▒▒▒▒▒▒▒▒▓░▒▓▒▒▒▒▒▒▓▒▒▒▒▒▒░░░░░░░
        ░░░░░░▒▓▓▓▒▒▓▒▒▒▒▒▓▓░░░░░░░░▒▓▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒░▓▒▒▒▓▒▒▒▒▒▒▒▒░▒▒░▒▒░▒░░░░░░░
        ░░░░░░░▓▓▓▓▓▒▒▒▒▒▒▒▒░▒▒▒▒▒░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒▒▓▓▓▓▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒░▒▒▒▒▒▒▒░▒░░░░░░
        ░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▒░░░▓▒▒▒▒▒▒▒▓▒▒▒░▒▒░▒▒▒▒▒▒░░░░░░
        ░░░░░░░░▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▒▓▒▒▒▒▒▒▒▒▒▒▓▒▓▒▒▒▒▒▒▓▒░░░░░░
        ░░░░░░░░░▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒▓▓▓▓▓▓▓▓▓▒▓▓░▒▒▒▒▒▒▒▒▓▒▓▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▓▒▓▒▒▒▒▒▓░▒▒▒▒░░░░
        ░░░░░░░░░░▒▒▒▒▒▒▒▓▒▒▒░░░░▒░▓▓▓▓▓▓▓▓▒▒▓▓▒░▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒░░▒▒▒▒▒▒▒░░
        ░░░░░░░░░▓▓▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▓▓▒▒▒▒▒▒▒▓▓▒▒▓▓▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▓▓▒▒▒▓▒▒▒░░░▒▒▒▒▒▒▒▒░
        ░░░░░░░░▒▓▒▒▒▒▓▓▒▒▒▒▒▒▒░░░▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▒▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▓▓░▒▒▒▓▓▒░▓▒▓▒▒▓▒░░░▒▒▒▒▒▒▒▒░
        ░░░░░░░▒▓▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒░▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓░░░▒▒▓▒▒▒▒▒▒▒▓░░░░▒▒▒▒░░░░░
        ░░░░░░▒▓▒▒▒▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▓▒▓▓▓▓▓▓▒▓▓▒▒▒▒▓▓▓▓░▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒░░░░░▒▒▓▒▒▒▒▒▒▓▓░░░▒▒▒░░░░░░
        ░░░░░▒▓▒▒▒▒▓▓▓▓▓░▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒░▒▓▓▓▓▓░▒▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒░░░░░▒▒░▒▒▒▒▒▒▓▓░▒▒▒▒▒▒░░░░░
        ░░░░▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▓▒▒▒▓▓▓▒▓▒▒▒▒▒▒▓▓▓▓▓▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒░▒░░░░░▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒░░░░░
        ░░░▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▓░▒▒▒▒▓▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░▒░░░░░░▒░▒▒▒▒▓▓▓▓▓▒▒▓▓▓▒░░░░
        ░░░▒▒▒▒▒▒▓▓▓▓▓▓▓░▒▒▓░░░░▒▒▒▒▒▓▒▒▒▒▒▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░░░░░░░░░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒░░░
        ░░░▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒░░░░░▒▒▒▒▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░░░░░░░░░▓▒▒▒▒▓▓▓▓▓▓▒▓▓▓▓▒░░
        ▒░░▒▒▒▒▓▓▓▓▓▓▓▓▓░░░░░░▒▒▒▒▓▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒░▒▒▒░░░░░░░░▓▒▒▒▒▒▓▓▓▓▓▓▓▒▓▓▒░░
        ░░░▓▒▒▓▓▓▓▓▓▓▓▓▒░░░░░░░░▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒░░░░░░░░░▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒░░
        ░▒▒▒▒▓▓▓▓▒▒▓▓▓▒░░░░░░░░░▒▒▓▓░▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░▒▒▒▒▒░░░░░░░░░░▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒░░
        ░▒░▓▓▓▓▓▒▒▒▒▒░░░░░▒░░░░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░▒▒▒▒▒▒▒░░░░░░░░░░░▓▒▓▒▒▒▒▓▓▓▓▓▓▓▓▓▒░░
        ░░▓▓▓▓▒▒▒▒▒░░░░░▒░▒▒░░▒▒▒▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓░▒▒▒▒▒▒▒░░░░░░░░░░░░▒▓▒▓▓▒▒▓▓▓▓▓▓▓▓▓▒░░
        ░░░░▓▓▒▒▒░░░░░▒░░░░░▒▓▓▓▓▒▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▒░▒▒▒▒▒▒▒░░░░░░░░░░░░░░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒░░
        ░░░░░░░▒░░░▒▒░░░▒░▒▒▒▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒░▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒░
        ░░░░░░░░░░░▒▒▒▒▒░▒▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒░▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▓▓▓▓▓▓▓▒▒░
        ░░░░░░░░░░░░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▓▓▓▒▒▓▒░░
        ░░░░░░░░░░░░░░░░▒▓▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▓▒▒▒░░░
        ░░░░░░░░░░░░░░░▒▒▒▒▒▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒░░░░
        ░░░░░░░░░░░░░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▒▒░░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒░░░░░░░░░░░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒░░░░░░░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▒░▒▒▒▒▒░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒░░░░░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░
    ";
    ErinaNakiri = "▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▓▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▓▓▓▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▓▓▓▓▓▓▓▒▒▓▒▒▒▒▓▓▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▓▓▓▒▒▒▒▒▒▒▓▓▒▒▒▒▓▒▒▒▒▓▒▓▓▓▓▒▒▓▒▒▒▒▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▓▓▓▓▓▓▓▒▓▓▒▓▒▒▓▓▓▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▓▓▒▓▓▓▓▒▒▓▒▒▒▒▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▓▓▓▓▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▓▓▒▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▓▓▓▒▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▓▓▒▓▓▓▓▒▒▒▒▒▒▓▓▓▒▓▒▓▒▒▒▒▓▓▓▒▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▓▓▓▓▓▒▒▒▒▓▒▓▓▓▒▓▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▒▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒▒▒▓▒▓▓▓▒▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▒▒▓▓▓▓▓▓▒▓▒▓▒▓▒▒▒▓▓▓▒▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒▓▓▓▓▓▒▒▒▓▓▒▓▓▓▓▓▒▓▒▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒▒▓▓▓▓▓▓▓▒▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▒▓▓▓▒▓▓▒▓▓▓▒▒▒▓▓▓▒▓▓▒▓▓▓▓▓▓▓▒▒▓▓▓▒▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▒▒▓▓▓▒▓▓▓▓▓▒▒▒▒▓▓▓▒▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒▒▒▓▒▒▒▒▓▓▓▒▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓
        ▒▒▒░░░▒▓▓▒▒▓▓▓▒▒▒▒▓▓▓▒▒▒▓▓▒▓▒▓▓▒▒▓▓▒▓▓▓▒▒▒▓▒▓▓▓▓▓▓▒▓▓▓▓▒▒▒▒▒▒▒▓▒▓▓▒▓▒▓▓▓▒▒▒▒▓▓▓▓▓▒▓▓▒▒▒▒▓░▒▒▒▒▒▒▒▒▒▒
        ▒▒░░░░░▓▓░▒▓▓▓▓▒▒▒▒▓▓▒▒▒▓▓▒▓▒▓▓▒▒▓▓▒▓▓▓▒▒▒▒▓▒▓▓▓▓▒▒▓▓▓▓▒▒▒▓▓▓▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▒▓▓▒▒▒▒▓░▒▒▒▒▒▒▒▒▒▒
        ▒░░░░░░▓▓░▒▓▓▓▓▒▒▒▒▒▓▓▒▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▒▒▒▓▓▓▒▒▒▒▒▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▓▒▒▒▒▒▓░▒▒▒▒▒▒▒▒▒▒
        ▒░░░░░░▓▒░▒▒▓▓▓▒▒▒▒▒▓▓▒▒▒▓▓▒▒▓▓▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▒▒▒▓▓▓▓▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▓▒▒▒▒▒▓░▒▒▒▒▒▒▒▒▒▒
        ▒░░░░░░▓░░░▒▓▓▓▒▒▒▒▒▒▓▒▒▒▓▓▒▒▒▒▒▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▓▒▒▒▓▓▒▓▓▓▒▒▒▒▓▓▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▒▓▒▒▒▒▒▒▓░▒▒▒▒▒▒▒▒▒▒
        ▒░░░░░░▒░░░▒▒▒▓▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▓▒▓▒▓▓▓▓▓▓▓▓▓▒▒▓▓▒▒▒▒▒▒▒▒▒▓▓▒▒▓▒▒▒▒▒▒▓░▒▒▒▒▒▒▒▒▒▒
        ▒░░░░░░░░░░▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▓░▒▒▒▒▒▒▒▒▒▒
        ▒░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▒▒▓▓▓▓▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▓▓▓▒░▒▒▒▒░░▒▒▒▒▓▒▒▓▒▒▒▒▒▒▒▓░░▒▒▒▒▒▒▒▒▒
        ▒░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒░▒▒▒▒▓▒▒▒▒░▒▒▒▒▒▒▓▒▒▓▓▓▓▓▒▓▓▒▒▒░░░░░░░░░▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▓░░▒▒▒▒▒▒▒▒▒
        ▒░░░░░░░░░░░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░▒▒▒▒▒▒▒▒▒▓▓▓▒▒▓▓▓▓▒░░▒░░░░▒░▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒░░▒▒▒▒▒▒▒▒▒
        ▒░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒░░░░░▒▒░░░░▒▒▒▒▒▒░▓▓▓▓▓▒▓▒▓░▒▒░░░▒▒▒▒░░░▓▓▒▒▒▒▒▒░▒▒▒▒▒▒▒▓▒▒░░▒▒▒▒▒▒▒▒▒
        ▒▒░░░░░░░▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓░░░▒░▒░░░░▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▒▓░▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▓▒▒░▒▒▒▒▒
        ▒▒░░░░░░░░░▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒░▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒░░░░░░░▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓
        ▒▒▒░░░░▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▒
        ▒▒▒░▒▓▓▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▒▒▒▒▒▒▒▒▓▒▒▒▒▒░░░░░▒▒▒▒▒▒▒
        ░▒▒░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒░▒▒▒▒▒▒▒▓▓▓▒▒▒▒░░░░░▒▒▒▒▒▒▒
        ▒▒▒▒░░░░░░░░░▒▓▒▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒
        ▒▒▒▒░░░░░░░░░░▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▓▒▒▒▒▒▒▒▒▒▒▒▓░░░░░░▒▒▒▒▒▒
        ▒▒▒▒▒░░░░░░░░░▓▓▒▒▒▒▒▒▓▓▓▓▓▓▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▒▒▓░░░░░░▒▒▒▒▒▒
        ▒▒▒▒▒░░░░░░░░░▓▓▓▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▓▒▒▓▓░░░░░░▒▒▒▒▒
        ▒▒▒▒▒░░░░░░░░░▓▓▓▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▓▓▓▓▒▒▓░░░░░░▒▒▒▒▒
        ▒▒▒▒▒░░░░░░░░░▓▓▒▓▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▓▓▓▓▒▒▓▒░░░░░▒▒▒▒▒
        ▒▒▒▒░░░░░░░░░░▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▓▓▓▓▒▓▓░░░░░░▒▒▒▒
        ▒▒▒▒░░░░░░░░░▒▓▒▓▓▒▓▒▒▓▓▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▓▓▓▓▒▓▒░░░░░▒▒▒▒
        ▒▒▒░░░░░░░░░░▒▓▒▓▒▒▒▒▓▓▓▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▓▒▒▒▒▒▓▓▓▓▒▓░░░░░░▒▒▒
        ▒▒░░░░░░░░░░░▓▒▓▒▒▒▒▓▓▓▓▒▒▒▓▓▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▓▓▒▒▒▓▓▒▒▒▒▒▓▓▓▓▒▒░░░░░▒▒▒
        ▒▒░░░░░░░░░░░▓▒▒▒▒▒▒▓▓▓▓▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▓▓▒▒▒▒▒▒▓▓▓▓▒░░░░░░▒▒
        ▒░░░░░░░░░░░▒▒▓▒▒▒▒▓▓▓▓▒▒▒▒▒▓▓▒▒▒▒▒▒░▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒░▓▓▒▒▒▒▒▓▓▒▒▒▒▒▒▓▓▓▓▒░░░░░▒▒
        ▒░░░░░░░░░░░▒▓▒▒▒▒▓▓▓▓▓▒▒▒▒▒▓▓▒▒▒▒▒░▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▓▓▒▒▒▒▒▒▓▓▓▒▒▒▒▒▓▓▓▓▒░░░░░░
        ░░░░░░░░░░░▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒░▒▓▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▓▓▓▓▒░░░░░
        ░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░
        ░░░░░▒▒░▒▒▒▒▒▒▒▒▓▓▓▓░▒░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░▒▒▒░░▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒░▒▒▒▒▒▒░░▒▒▒░░▒▒░░▒▒▒▒▒░▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒
        ░░▒▒▒▒▒░░░░░▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒░▒▒▒░▒░░▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▓▓▓▒▒▒▒▒▒▒▒
        ░▒▒▒▒▒░░░░░░░░▓▓▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒░▒▒▒▒▒▒░▒▒▒░░▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▓▓▓▓▒░▒▒▒▒▒▒▒▒▒
        ▒▒▒▒░░░░░░░░░░▒░▓▓▒▒▒▒▒▒░░░▒▒▒░▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒░░▒▒░▒▓▓▓▒░▒▒▒▒░▒▒▒▒▒▒▒
        ▒▒▒░░░░░░░░░░▒▒▒▒▒▓▓▒▒▒░░░░░░▒▒░░▒▒░░▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒░░░▒░░▒▒▒▒▒▒▒░▒▒▒░░░░▒▓▓▓▒░▒▒▒▒▒▒░▒▒▒▒▒▒▒▒
        ▒░░░░░░░░░░░░░▒▒░▒▒▓▓▓░▒▒░░░░▒▒▒░░▒▒▒▒▒▒▒▒░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░░▒▒░░▒░░░▒▒▒▒▒░▒▒▒▒▒▒▒▒░▒▒▒▒▒░▒▒▒
        ░░░░░░░░▒▒▒▒▒▒░▒▒▒▒▒▒▓▓▓▒▒▒▒▒░▒▒░░▒▒▒░░░▒▒▒░▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒░░▒░░░░▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░▒░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒░▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒░▒▒▒▒▒▒▒▒▒▒░░▒▓▓▓▓▓▓▓▓▓▓░▒▒▒
        ░░░░░▒▒▒▒▒▓▓▓▒▒▒▒▒░▒▒░▒▒▒▒░▒░░░▒▒░░░░░░░░▒▒▒▒▓▓▓▒▓▓▓▒▓▓▓▓▓▓▓▒▒▒▒░░░▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒░░░░░░░░░▒▒▒▒▒▓▓▒▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓░░░▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▓▓▓▓▓▓▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▓▓▓░░░▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▓▒▒▒▒▒▒▓▓▓▓▒▒░▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒░▒▒▒▒░░░▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▓▓▓▓▓▓▒▓▓▓▓▓▓▒░▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓░▒▒▒▒░▒▒▒▒▒
        ▒▒▒▒▒░▒▒▒▒▒░░░░▒▓▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▒▓▓▒▒░▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒░░░░░
        ▒▒▒░░░▒▒▒▒▒▒░░░░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░
        ▒▒▒░░░▒▒▒▒▒▒▒░░░░▒▒▒▒░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒░░░░
        ▒▒▒░░░▒▒▒▒▒▒▒▒░░░░▒░▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒░░░░░░▒░░░▒▒▒▒▒▒▒▒░░░
        ▒▒▒░░░▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒░▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒░░░
        ▒▒▒▒░░░▒░▒▒▒▒▒▒▒░░░░░░░░░░▒▒▒░▒▒░▒░░▒▒▒▒░░░░░░▒░░░░▒▒▒▒▒▒▒▒▒░▒▓▓▓▓▓▓▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▒░░░
        ▒▒▒▒░░░▒▒░░░░░░░░░░░░░▒▒▒▒▒▒▒░░▒▒▓▓░▒░░░░░░░░░▒▒░░░░░▒▒▒▒▒▓▓▓▓▓▒░░░░░░░░░░▒▒▒░░░░░░▒▒▒░░░░░▒▒▒▒▒░░░░
        ▒▒░░░░░░▒▒░░░░░░░░░░░░░▒▒░░░░░░░░░▒▓▓▓▒▒▒░░░░░░░░░░░░░▓▓▓▓▓░░░░░░░░░░░▒▒░░░░░▒▒▒▒░▒▒▒▒▒░░░░░░▒▒▒░░░░
        ░░░░░░░░▒▒▒▒░░░░░░░░░░░░░▒▒░░░░░░░░░░▒▓▓▓▓░▒▒░░░░░░▓▓▓▒░░░░░░░░░░▒▒▒▒▒▒▒▒░▒▒▒▒▒░░▒▒▒▒▒▒░░░░░░░▒▒░░░░
        ░░░░░░▒▒▒▒░▒▒▒░░░░░░░░░░░▒▒░░░░░░░░░░░░░▓▓▓▓▓░░░░░░░░░░░░░░░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▒░░
        ░░░░░▒▒▒▒▒▒░░▒▒▒▒▒▒░░░░░░░░░░░░░░░▒▒▒░░░░░░▓▓▓▓▒░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒░▒▒▒▒▒▒
        ░░░░▒▒▒▒▒▒▒▒░░░░░░░░░░░▒▒▒▒▒▒▒▒░░░░▒░░░░░░░░░▒▓▓▓░░░░░░░░░░▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒
        ░░░░▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░▒░▒▒▓▓▓▓▓▓▓▓▓░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒░▒▒░▒▒▒▒▒▒▒▒▒▒
        ░░░▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒░░░░░░░░░░░░░░▓▓▓▓▒▒▒▓▓▓▓▓▒▒▓▓▓▓▒▒▓▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒
        ░░░▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░▒▒▒▒▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▒▓▓▓▒░░░░░░▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒░▒▒▒▒
        ░░░▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒░░░░░░░░▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▒▒▓▓▓▒░░░░░░▒▒▒▒▒▒░░▒░░░░░░░░▒▒▒▒▒▒▒░░░▒▒▒
        ░░░▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒░░░░░░▒▓▓▓▓▓▓▓▒▓▒▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓░░░░░░░░▒▒▒▒▒░░░░░░░░▒▒▒▒▒▒▒░░░▒▒▒
        ░░░▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░▒▒▒▒▒░▒▒▒▒▒▒░░░░▒▒▒
        ░░░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒
        ░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░
        ▓░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒░▓▓▓
        ░▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▒▒▒▒▒░▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░▒▒▒▒▒░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▒░▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒▒░░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒░▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒
    ";
    WinryRockbell = "▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓░▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▓▓▓▓▓▓▓▓▒░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▓▓▓▓▓░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓░▒▒▒▒▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▒▒▓▓▓░▒▒▒▒▓▒▓▓░▒▒▒▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▓▓▒▓▒▒▓▒▓▒▒▒▓░▒▒▒▒░▒▒▒▒▓▓▓▓▓▒▒▓░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓░▒▒▒▓▓▒░▒▓▒▓▓▓▓▒▒▒▓▓░▒▒▒░▓▒▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▓▓▓▒░▒▓▓▓▓▓▓▓▒░░░░▓░▒▒▓▓▓▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▒▓▓▒░░▒▓▓▓▓▓▓▓▓▓░░▓▓▓▓▓▓▓▓░▒▒▒▒▒▓░▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▒▒▒░▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▓▓▓▓▒▒▒▒░▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▒▒▒░▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓░▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▒▓▓▒▒▒░▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▒▒▒▒▒▒▒▒░▒▒▓▒▒▒▒▒▒▓▒▒▒▒▓▒▓▓▒░▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒░▒▒▒▒▒▓▒▒▓▓▓▓░▒▒▒▒▒▒▓░▓▒▒░▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒░▓▓▓▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▒▓▓▒░░▓▓░▒▒▒▒░▓▒▒▒▒▒░▒▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▒▒░▓▓▓▓▓▓▓▓▒▒▒▒▒▒░▒░▒▒▒▒▒▒▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▓░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▒▒░░░░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░▒▒▓▓▓▒░░░░░▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▓▓▒▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░▒▓▓▓▓▒░░░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▓▓▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░▒▓▒▒▓▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓░▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░▒▓▒▓▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░▒▓▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░░▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒░░▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░░▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▓░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒░░▒▒▒▓▓▒▓▓▓░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░▓▓▒▒▒▓▓░▓▓▓▓░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒░░░▓▓▒▒▒▒▓▓▓▓▓▓░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▓▓▓▓▓▓▓▓░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▓▒▓▓▓▒▓▓▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▓▒▒▒▒▒▒▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▓▓▓░▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▓▓▓▓▓▓▓░▓▓▓▓▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░▒▒▒▒▒▒░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░▒▒▒░░░░░░▒▒▓▓▓▓▓▓▓▓░▓▓▓▓▓░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░▒░░░░░░▒▒▒▓▓▓▓▓▓▓▓░▓▓▓▓▓░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░▒▒░▒▓▓▒▒░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒░▒░▒▒▒░▒▒▒░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒░▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░▒▒░░░░░░░▒░░░▒▒▒░▒▒▒▒▒▒░▒▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒░░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒░░░░░▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▒▒▒▒▒▒▒▒░░▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░▒▓▓░▒▒▒░▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒░▒▒░▓▓▓▓▓▓▓▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▓▓░░░░░░░░░░░░░░░░░░░▒▒▒▒░▒▒▒▒▒▒░▓▓▓▒▓▓▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░▒▒▒▒░░░░░░░░▓▓▓▒▓▓▓▓▓▒▒░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░░░░░░░░░░░░░░░░░░░░░▓░░░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒░▒▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒░░░░▓▓░░▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒░▒▒░░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▒▒▒▒▒▒▒▒▓░░░▓▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒
    ";
    NateRiver = "░░░ ░░░░░░░░░░  ░░░ ░ ▒▒ ▒ ▒████▓▒███▒▒░▒▒▒░▒▒▓████▓▒▒███████████████████████▒████░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░  ▒▒▒▒▒░▒███ ▒▒█▒▒▒▒▒▒▒▒▒▒▒███▒▒▒▒███████▒█████████████████ █████ ░░ ░░░░░░░░░░░░░
        ░░░░░░ ░░░ ░░░░ ▒▒▒▒▒ ▒▒▒▒▒█░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒█ ▒▒▒▒▓████▒███████████████████████▒▒███░░░ ░░░░░░░░░░░░
        ░░░░░░░░░ ░░░░░▒░░  ▒▒▒▒▒▒▒▒▒ ▒ ▒ ▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▓███████████ ▒██████ █████████▒██░░ ░░░░░░░▒░░░░░
        ░  ░░░░░░░░░░░░░░▒▒▒▒ ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒███████ ████████▓██▒██░░░ ░░░░░░░░░░░░
        ░░░░ ░░░░░░░▒ ▒▒▒▒ ░▒▒▒ ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒ ▒▒▒▒▒▒█████▒██▒▒▒████████████▒██░░░░░░░░░░░  ░░░
        ░░░░░░░░░░░░░░░░░▒▒ ▒ ▒▒ ▒▒▒▒▒▒▒▒▒▒▒ ▒▒▒▒▒▒▒▒▒░▒ ▒▒▒▒▒▒▒▒▒▒ █▒▒▒███████▒██████▒▒██░░░░▒░░░░░░ ░░░ 
        ░░░░░░░░░ ░░░░░░░░▒▒▒▒▒ ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ ▒▒▒▒▒▒▒▒▒▒▒ ▒▒▒▒████████▒  █████▒▒███ ░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░ ▒░ ▒ ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▓██▓▒▒▒ ▒▒██████░▒▒▒█ █ ░░░▒░░ ░░░░░░░░
        ░░░░░░░░░░░▒░░░░░ ▒▒▒ ▒▒▒▒▒▒▒▒▒▒▒▒░ ▒▒▒▒▒▒▒░▒▒▒▒░      ░▒▒▒▒▒▒ ▒▒▒███████▒▒▒▒▒▒▒█░██ ░░░░░░░░░░░░░░░
        ░░▒░░░░░░░░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ ▒▒▒▒▒▒▒▒▒▓░▒░     ▒ ▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒ ▒▒▒▒▒▒█ ▒██░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ ▒▒▒▒ ▒▒▒███ ▒██████▒ ▒▒▒ ▒▒▒▒▒▒▒▒▒▒░▒▒░▒▒▓▒▒░▒██░░░░░░░░░░░░▒░░░
        ░░░░░░░░░░▒░░░  ░▒▒▒▒▒░░▒▒░▒ ▒▒▒▒▒▒▒▒▒▒▒ ▒▒███████▒ ▒▒▒▒▒ ▒▒ ▒▒▒▒▒▒▒▒ ▒▒ ▒▒▒▒▒▒▒▒██░▒░ ░░░░░░░░░░▒░░
        ░░░░░░░░░░▒░░░▒▒▒▒▒▒▒▒▒ ▒  ▒ ▒▒▒▒▒▒▒▒▒▒▒▒▒▒████████▓▒▒▒▒░░▒▒▒▒▒▒▒▒ ▒ ▒▒▒▒ ▒▒▒▒▒▒██ ░░░░░░░░░░░░░░▒░░
        ░░░░░░░░░░  ░░▒▒ ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ ████████████████▒▒▒▒▒       ▒▒ ▒▒ ▒▒▒█ ░ ░░▒░░░░░░░░░░░░░░
        ░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▓▓▒▒▒▒▒▒▒ ▒▒▒ ▒███████████████████▒▒ ░░██▒ ▒▒▒▒▒▒ █ ░▒░░░░░░░░░░░░▒░░░░░░
        ░▒▒▒▒▒▒▒▒▒▒▒▒░  ░▒▒▒▒▒▒▒▒▒▓▓ ▓▓▓▓▒▒▒▒▒▒▒▒██████████████████████▒ ░▒▒▒▒▒ ▒▒  ▒█░░░░░░▒░░░░░░ ░░░░░░░░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓ ▒▒▒▒▓█████████████████ ██▒░ ░▒ ▒▒▒▒▒█ █ ░░▒░░░░░░░░▒░░░░░░░░▒░ 
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒███████████▒▒▒▒██▓██████▒▒▒░▒▒█▒█░░  ░░░░░▒░░░░▒░░░░░ ░░░░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓ ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒█████████████▒████████░▒▒░▒▒  ▒▒░░░ ░░░░░░░░░░░░░░░▒░░░░░ 
        ▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓ ████████▒██████████ ▒░░░░░░░░▒ ░░░░░░░░ ░░░░░░░ ░░▒░░░░░ 
        ▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒██████▒▒████████ ▒▒▒░░░░░░░░░░░░░░ ░░ ░░░░  ░░░░░░░░░░▒░ 
        ▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓ ▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒███████████ ▓▒░░░▒▒░░▒░░░░░░ ░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▓▓▓▓ ▓▓▓▓▓▓▓ ▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓░▒▒▓▒▒▒▒█████ ▓▓▓▓▓▓▓ ░░░ ░▒░░░░░░ ░░░░ ░▒░  ░░░░░░░░░░░░ ░░░░ 
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ ▒▒▓▓▓▓▓▓▓▓ ▒▒▒▓▓▒▒▒▒▒▒▓▓▓▓ ▒▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░  ░░░░░░░░░░░░ 
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓ ▓▓▓▒▒▒▒▓▓▓▓░▒▒▒▒▓▓▓▓ ▒▒▒▓▓▓▓▓▓ ░░░░░░░░░ ░░░░ ░░░░ ░░░░░ ░░ ░░░░░░░░░
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒▒▓▓▓▓▒░▒▒▒▒▓▓▓▓ ▒▒▒▒▓▓▒▒▓▒▒▒▓▓▓▓▓▓▓ ░░░░░░░░░░░░░░░░░ ░░░░░░░░  ░░░ ░░░░░
        ▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▒▒▒▒▒▒▓▓▓░▒▒▒▒▓▒▒▒▒▓▒▒▒▒▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░▒░ ░░░░░░░░ ░░░░░
        ▒▒▓▓▓▓▓▓▒▒ ▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▒▓▓▒▒▒▒▓▓▓ ▒▒▒▒▒▓ ▒▒▒▓▒▒▒▒▓▓▓▓▓▓▓ ░░░░░▒▒ ░░░░░░░░░░▒░░░░░░░░░░░ ░░░ ░
        ▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓ ▒▒▒▓▒▓▓▓▒▒▒▓▓▓ ▒▒▒▒▒▓▓▒▒▒ ▓░▓▓▓     ▒░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░ ░░░░ ░
        ▒▒▒▓▓▓▓▓▓▓▓▓ ▒▒▒▒▒▒▒▒▓▓▓▓▒▒ ▒░▒▒▓▓▒▒▒▓▓▓▒▒▒▒▒▓▓▓ ▒▒▓  ▒▒▒▒▒▓▓▓▓▓▓▓▓░░░░░░▒░░░░░░░░▒░ ░░░░░░░░░░░░░  
        ▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒ ▒▒▒▓▓░▓▓▓▓▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ ▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▒▒▒▒▒ ▒▒▒▒▓▓▓▓▓▓▒▒░▓▓ ▒  ░  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░ ░░░░░░░░░░░░ ░░░ ░░▒░░░
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ ▒▒░▒▒▒▒▒░▒▒░▒▒▒▒▓▓▓▓▓▓▒▒▓ █▒███▒████ ▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓ ▓░ ░░░░░░░░░ ░░░░░░░░░░░░░░░
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒██▓██▒▒▒██████████▓▓ ▓▓▓▓▓▒▒▒▓▓▓▓▓ ░▒░░░░▒░░░░░░░░░░░░░░░ ░
    "; 
    Nausicaa = "░░▒▒▒▒▒▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒
        ▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓█▓▓▓▓▓▓▓████████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒
        ▒▒▒▓▓▓▓▓▓█▓▓▒▒▒████▓▒▒▒▒░███████▒▒░▒▒██▒░░░▓▓▓▒▒▒█▒▓▓▒▒░░▒▒▓▓▓▓▒▒▒▓█▓████▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▒
        ▓▓▓▓▓▓▓████████░░█████░████▓░░███▒░██████▒███▒▓▓█▓▒▓▓▓█░░██▓▓░▓████▒██████░░▓▓▓▓████░░█▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓████████████░  ███░████░█░███░░██████░███░░ ███████  ███░░███████████ █░░██████ █ ░███▓▓▓▓▓▓▓▓▒▒
        ▓▓████████████████  ██▒███ ██ ░██░░██████▒██████  ░████ ▓███░░██████████ ███░█████░███ ██████▓▓▓▓▓▒▒
        ▓▓██████████████████░░░██░████░▒█▓░███████████████░▓███░████░░█████░███░░███░░███░░███░░█████████▓▓▒
        ▓▓███████████▓▒▒▒█████░▒▒▒████▒▒██▒░░░▓░█████▒▒▒▒▒████▒▒▓█████▒▒▒▒░██▓▒▒████▒▒░▓▒▒████░▒▒████████▓▓▒
        ▓████████████████████████████████████████████████████████████████████████████████████████████████▓▓▒
        ▓███████████▒███░█████████░███████████████░█░████████░█████████████░███████░█████████████░████████▓▒
        ▓███████████░█████████████░█░▒█████░███░ █░█░████ ▒██░█████████████▓█▓░█████░█░████████░█░████████▓▓
        ▓████████████████████████████████████████████████▒████████████████████████████████████████████████▓▓
        ██████████████████████████████████████████████████░███████████████████████████████████████████████▓▓
        █████████████████████████████████████████████████░█░██████████████████████████████████████████████▓▓
        █████████████████████████████████████████████████████████████████████████████████████████████████▓▓▓
        ██████████████ ░           ░░        ░░░░░▒▒░░░░░░░░░░▒░░░░░░      ░░░░ ░░░░░░ ░░░░░░░░██████████▓▓▓
        ██████████████    ░          ░░░░    ░░░░░▒▒▒▒▒▒▒░▓▒▒▒▒▒░░░░░ ░   ░░  ░░░░░░░░░░░░░░░░░█████████▓▓▓▓
        ▓█████████████ ░░░   ░  ░      ░░     ░▒▒▒▓▓▓█▒██▓██▒▓█▓▒▒░░░ ░░░░░ ░░░░░░░░▒░░░░░░░░░░█████████▓▓▓▓
        ▓█████████████ ░ ░░░░░░░░       ░░░░░░▒▒▓█▓▓▓▓▓▒░▒█▓▓▓███▓▒▒░▒░░░░░░░░░░░░░░░░░░░░░░░░░█████████▓▓▓▓
        ▓█████████████░░    ░░ ░░░░░   ░░░░░░▒░▒▓▒▒▒▒░▒░░▒░▓▓▒▓▓█▓▒░░░░░▒░▒░▒░░░░░░▒░░░░░░░░░░░████████████▓
        ▓█████████████  ░          ░▒ ░ ▒░░░░▒▓▓▓▓▒▓▒▒░░░░░░▒▓░▓▓▓▒▒░░▒░▒▒▒░░░░░░░░░░░░░░░░░▒░░█████████████
        ▓█████████████░░░░             ░░░▒▒▓▓▓▓▒░▒░░░  ░░░░▓▓▒▒▓▓▓▒▒░▒░░░░▒░░░░░░░░░░░░░░░░░░░█████████████
        ▓█████████████░░░░░░ ░          ░░▒▒▒▓▓   ▓  ▒   ░░▒▓████▒▓▒▒░░░▒▒░░░░░░░░░░░░░░░░░░░░░█████████████
        ▓█████████████░░░░░░▒░░         ░░░░▓░▒▒░█▓▓█▒▓████▒▒▒█▓█▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒▒▒░░░░░░░░░ ░ ████████████▓
        ▓█████████████░░░░░░░░ ░░░░░░░░░░▒░░▒▒▒▓▒██░███▓ ███▓██▒▓▒▒░▒▒▒▒▒▒▒▒▒▓▒▒░▒▒▒▒░░░░  ░░░░███████████▓▓
        ▓█████████████▒▒░░░░░▒░░    ░ ░░░░▒▒▒▒▒▒░█▓▓▓████████▒▓█▒▒▒▒▒▒▓▓█▒▒▒▒▒▒▒▒▒░░░░░░░▒░░░░▒███████████▓▓
        ▓█████████████▒░▒▒░▒▓▓▒▒▒░░ ░░░░▒▒░▒▒▒▒█▓▒▒█▓██████ ▒▒░ █▓▒▒▓▒▓▓▒▒▒▒▓▓▒▒▒▒░░░░░░░▒░▒░░░███████████▓▓
        ▓█████████████▒▒▒▒░▒▓▒▒▒░▒░░▒▒▒▒▒▒▒░▒▒▓███▒█ ███▓█░██░ █▓█░█████▒▒▓▓▓▓▓▒▓▒▒░░░░▒▒▒▒▒▒▒░██████████▓▓▓
        ▓█████████████▓▒▒▒▓▓▓▓▓▒▒░▒▒▒▒▒▒▒▒▒▒░  ▒▓██▒▒░▓▓ ░░░▓▓▒███▒█████▓▓▓▓▓▓▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒░███████████▓▓
        ▓█████████████▓█████▓▓▒▒░░▒▒▒▒▓▓▓▒░▒▓▒▒▓█░██▒▓▓▓█░▒░░░░▓██░▒███▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒███████████▓▓
        ▓▓██████████████▓▓▓▓█▓▒▒▒▒▓▓▓▓▓▒▒▒▒▓░▒░░▓▓▒▒░█▓█▒█████▒▒▒▒█████▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒███████████▓▓
        ▓▓████████████▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓█▓▒░▒  ▒█▒███▒▓▓▒▓▓▒▒▒▓▓██▓▓▒▒▒▒▒▓▓▒▒▓▓▓▓▓▒▒▒▒░▒▒░▒███████████▓▓
        ▓▓████████████▒░░▒▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▒▓█▓▓▓▒░▒▒░▒▓█▒▒▓█▓▒░▒░▒▒▓██▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▒▒▒▓███████████▓▒
        ▓▓████████████░▒▒▒▒▒▒▒▒█▒▒██▓█▓▓▓▒▓▓█▓▒░░░░░░  ░▒░ ▒▒░▓░░█▓███▒▓▓▓▓▓██▓███▓█▒▒▒▒▒▒▓▓▓▒▓███████████▓▒
        ▓▓████████████▒▒▒▒▒▒▒▒▓▓░▓▒▓▓▓▒▓▓▓▓ ▓▓▒▒▒░░░░░░░ ░░░  ▓░░▒▓▓██████▓██▓▓▒▓▒▒▒▒▒▓▓▓▓▓▓▓█▒███████████▓▒
        ▓▓████████████▒▒▒▒▒▒▒▓▒▓▓▓█▓▓▓████▓██▓░░ ░▒░░▒░ ░░    ▒░▒▒▓██▓████████▓▒▒▒▒▓▓▓█▓▓█▓▒▒▒▒███████████▓▒
        ▓▓████████████▒▒▒▒▒▒▓▓▓▓▒▓███████▓▓██▓ █░░▓▒▓▒░░░░░▓ ░▓▒▒▒▓█▓▓███████▓▓▓▓▓███▓▓▒▒▒▒▒░▒▒███████████▓▒
        ▓▓████████████▒▒▓▓▓▒▓▒▒██████▒▓▓ ▓▓██▓▓▒░░▓░▒▒▒░░░░▓ ░▒▒██▓██▓██▓█▓▓█▓███▓▒▒▓▓▓██▒▓▒▒▒▒███████████▓▒
        ▓▓████████████▓▓▓█▓▓▒▓▓▓█▓▒███████ ▓█▓▓▓▓░▒█░▒██▓░░█░░▒▓▓█▓█░██▓█▓█████▓▓▓█████▓▓▓▒▒▒▒▒███████████▓▒
        ▓▓██████████████▓▓▒░▒▒▒▒▒▒▒▒▓████▓▒▓█▓▓▓▒▒▓░  ░▒▓▒▓ ▒░▒▓████▒██████████████████▓▓▒▒▒▓▒▒███████████▓▒
        ▓▓███████████████▒▒▒▒▒▒▒▒▒▒▓▓███▓▓█▓░▓▓▓▓▓▒  ░░░░ ░█▒▒░▓██▓█▒▓▒░█▓█████████▓██▓▓▓▓████████████████▓▒
        ▓▓█████████████▓▒▒░▒▓▓▓▒▓▒▒█████▒▓▒▓▓█▓▓▓▒▒█▒░░░ ░▒ ▒░░▒████▓▒█▒▒▓░░░▒░███████▓██ ▒██████████████▓▓▒
        ▓▓████████████▒▒▒▓█▓▒▒▒▒▓▓▓███▓▓▓▒ ░▒ ▒ ▓▓███░░░░░░▒▒▓▓▓▓██▓██████████████▓▓██████████▒██████████▓▓▒
        ▓▓████████████▒▒▒░▒█▒▒▓██▓█████▓▓▒▒▒▒▒▓░█░███▒▒░░░ ░██▓░▒██▒█░█▓██████▓▓▒▓▓██████████▓░██████████▓▓▒
        ▓▓████████████▒▓▓▓▓▓███████████▓▒██▓█ ▓░▓▒▒▒███░▒░░▒▒███▓▓▒▒▓░▓██████▓▓▓███████████▒▒░░██████████▓▓▓
        ▓▓███████████████▓▓████████████▓██▓▒▒▓▒█▒▓▓██▓▒░░▒▒▓███▒░▒░░▒▒█████▓▓▓▒▒░▒▒██▒░░░░░░░░▒███████████▓▓
        ▓██████████████▓████████████████████▓▒▒▒▒█ ██▒▓░█▓▓▓██░▒▒░░▒░░░▓███▓▓▓▓▒▒▒▒▒▒▒░▒░░░░░▒░███████████▓▓
        ▓█████████████▓▓█████████████████████▓▒▒▒░▒░▒▓░▒███ ███░▓▒▒░▒░████▓▓▓▓▓▓▒▒▒▒░▒▒▒▒▒▒▒░░░███████████▓▓
        ▓█████████████████████████▓▓▓▓▓▓████▓█▒█▓█▓▒▒▓▒▒▒ ███ ▓▓▒██████▓▓▓▓▓▓▒▓▓▓▓▓▒▓▒▒▒▒▓▓▒▓▓▒███████████▓▓
        ▓████████████████████████████████████████ ▓▓▓███████▓█▒█▒░▒▓████▓▓▓▓▓▒▒▓█▓▓█▓█▒▓▓▒▒▓▒▓▓███████████▓▓
        ▓█████████████████▓▒▒▒█ ░█████▓▓▒▒▒▓███▒█▓██████ ▓▓█▓▓░░▒▓▓▒▓▒▓▓▓████▓▓▓▓█▓▓▓▓▒▒▓▓░▒░█████████████▓▒
        ▓████████████████▒▓████▓▓▓▒▒▓▒▒▒▒▓▒▒▒▒███▒██████ █░▒▓▓██▒▓▓██▓███▓████░███████████████████████████▓▒
        ▓██████████████████████████▓▓▓██▓██▓█▓███▓▒▓█████████▒██ ▒█▓██▒███████████░█████████▓▓▓███████████▓▒
        ▓██████████████████▓█▓██▒▓▓█████████████▓░▓▓▓█ ██▓▒▓██▒███▓██▓▒▓█ ████████████▓▒▓▓█▓█▓▓███████████▓▒
        ▓█████████████▒████▓███▓▒▓▒▒▓▒██████████▒▒▓▒▓█▓███▓██▓▒████▓▓░▒▓▒██████████████▓█▒██▓█████████████▓▒
        ▓█████████████▓▓█▓░ ░▒▓▓░░▓▓▒█████▓███▒▒▒▒▒▒▒▓▓█▓██████████▓▒▓▓▒▒█████████████▓▓█████▓████████████▓▒
        ▓█████████████████▓▓▒██████▒████▓░███▒ ░▒▒▓▒▒█████ ▒▓████▒░░░▒░▒▒███▓███████░█▓▓▓█▓▓██████████████▓▒
        ▓███████████████████████░██▒░█████████░░▒▒▒▒▒▒▓██████████ ▓▒▓▒░▒▒▓███████▓▓▓▓█████▓▓▓▓████████████▓▒
        ▓█████████████▒█▒█████████████▒██████░░▒▒▒▓▓▒██▓▓████████▓░▓▒▒▒▒░▓▓███▒█▓███████████▓█▓███████████▓▒
        ▓█████████████▓▓▒▓▓██████▓▓▓▓▓██▓▒█░▓░▒▒▒▒▓▓▓████▒ ▓▓ ████▓▒▒▒▒▓▓▓▓█▒▓██▓███████▓▓█▓█████████████▓▓▒
        ▓█████████████▓█▓███▒▓▒▓▓██▒▓██████▓▓░▒▒▒▒▓▓▒█▓▓██▓ ████████▓▒▒▓▒▓▓████▒███████▓▓▓▓██▓▓██████████▓▓▒
        ▓██████████████▒▓▒▓▒▓▒▒▒█▓█▓████████▒▒▒▒▒▓▓▓█▓█▓▓███████████▒▒▒▒▓▓▓██▓██▓▓██▓██▓██▒▓▓▓▓██████████▓▓▒
        ▓▓████████████▒▒▒ ██▓█▓██████▓██████▒▒▓▒▒▓▓▓█░█▓▓▓▓▓████████▒▒▓▓▒▓▓▓███▓▒▓█▓▒█▓▓░▒▒▒▓▒▓███████████▓▒
        ▓▓▓████████████▒▒▒█▓▒▒▓▒▓▓██▓▒▒▓▒░ ▓▒▒▒▒▒▓▓▓██▒███▒▓▓▓▓█▓▓▓▓█▓▒▒▒▒░██ ▓▓▓█▓▓█▓▒▓▓▒▒▒▓▒▒███████████▓▒
        ▓▓▓▓▓█████████▒▒▒▒▒▒▓▓▓▓▓▒▒▓▓▒▓█▒▓██▓▒▒▒▓▓▓▓▓▒▓▓▒▓▓▓▒▓▓▒█▓▒▓█▓▓▒▒▒▓▓▓███▒▓▒▒▓▒▒▒▓▒▒░▓▒░██████████▓▓▒
        ▓▓▓▓▓▓▓███████▒▓▓▓▒▒▒▒▒▓▓▒▓▓▒▒▓▓▓▓▒▓▓▒▒▓▓▓▓▓█▒▒▓░▒▓▒░▒▓▒▒▒▓▓▓█▓▓▓▓▓█████▒▒▒▒▒░▒▒▒░░░░░▒██████████▓▒▒
        ▓▓▓▓▓▓▓▓██████▓▒▒▒▒▒▓▓▓▓▒▒▓▓▓▒ █▓▓█▓▓▒▒▒▓▓██▓▒▒▒▒▒▒▓▓░▒ ░▒░▒░ █▓▓▓▓▓▓█▓██▒▒▒▒▒▒ ▒▒▒▓▒▒▒█▓▓██████▓▓▒▒
        ▓▓▓▓▒▒▒▓▓▓▓▓████▓█▓█▓▓████████████████████████████████████████████████▓███████████████▓▓▓▓▓▓█▓▓▓▓▒▒▒
        ▒▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓████▒█░██░███░██░█░█░██▒██░▓█▓▓▓░██░█████▒▓▓░░▓▓▓▓█████████▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓█▒█░█░█▒█░▓▓▓█▓░█▓▓▓▒▓▒▒▓▓▓▓░▓▓▓██▓▓▓▓▓░▓░░▒▒▓▓▓▓▓▓▓▒▒▓▓▒▒▒▓▓▒▒▒▒▒▒▒▒▒░░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒▒▓▓▓▓▓▓▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░
    ";
    Sakamoto = "███████████████████████████░▒▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ████████████████▓████▒░▓▓▓▓▓▓▒  ░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ███████████████▓░▒▓▓▓▒▓▓▓▓▓▓  ░  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ██████████░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓█      ░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓  ▒▓▓▓▓▓▓▓▓▓█▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ████▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒   ░▓▓▓▓▓▒░▒▒▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓         ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓      ▓▓░▒▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓           ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓        ▒▒▓▒▒▒▓▒▓ ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▒▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓            ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒         ▒▓▒▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓             ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓           ▒▒▓▒▓▒▒▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓              ░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓            ░▓▒▒▓▒▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓                           ░▓▓▓▓▓░             ░▓░▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓                                                 ░▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒                                                  ▒▓▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░▒▒▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░                                                   ▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▒░░▒▓▓▓▓▓▓▒▓▓▒▓▓▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓                                   ░                 ▓▓▒░▓▓▓▓▒░▒▒▓▒▒▒▓▒▒▒▓▒▒▒▒▒▓▒▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓   ░                                                 ░▓▓░▓░░▒▓▒▒▒▒▓▒▒▓▒▓▒▓▒▒▒▒▓▒▒▓▒▒▓▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓   ████░                                              ░▒░▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓░
        ▓▓▓▓▓▓▓▓▓▓▓    ████████▒                                           ░▓▒▒▒▒▒▒▒▒▒▓▒▒▓▒▒▒▒▓▒▒▓▒▒▒▒▒▓▒▓░▓
        ▓▓▓▓▓▓▓░       ███████████                                         ▒▒▓▒▓▒▒▒▓▒▒▓▒▒▓▓▒▓▒▓▒▓▒▒▒▓▒▒▓▒▒▓▓
        ▓▓▓▒           ▒█████████    ▓                                     ▒▒▒▒▓▒▓▓▓▒░  ░▒▒▒▒▒▓░▒▒▒▓▒▓▓░▓▓▓▓
        ▓▓              █████████   ▒██▓               ░   ░     ░         ▒▓▒▒▒░ ░░▒▒░ ▓▒▒▒▓░▒▒▓▓▓▓▒▒░▓▓▓▓▓
        ▓█               ▓████████████▓        ███████    ███▓▒░           ▒▓ ▒▒▒▒▓▒▓▒▒▓▓▓▒░▓▓▒▓▓▓▒▓▒▓▓▓▓▓▓▓
        ▓▓▓                ░█████████          ███████    ████████▓        ░▒▒▓▓▒▓▒▒ ▓▒▓░▒▒▓▒▓▒▒▒▓▓░▓▓▓▓▓▓▓▓
        ▓▒▓▓                         ░         ▓██████   █████████         ▒▒▓▒▒▒▓▒▒▓▒░▓▓▓▒▓▓▒▒▒▓░▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▒                           ░      █████████████████          ▓▒▓▓▓▒▒▒░▒▓▓▒▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▒                                 ▓█████████████            ▒▓▓▒ ▒▓▒▒▒▒▓▒▓▓▒▓▒▓░▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓░                                  ▒████▓░              ░▒░▓▒▒▓▒▒▒▒▒▒▒▓▒▒▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▒                                                     ▒▒▒▓▒▒▒▒▒▒▒▒▓▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓                                                 ▒▒▒▒▓▒▒▒▓▒▓▓▓▓▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒    ░                                       ▓▒▓▒▓▒▓▓▒▓▓▓░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓                                   ░▒▓░▒▒▒▒░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▒▒▓▒░░░░░                     ░▒▓▒▒▓▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ ▓▒▒▒▒▓░▒▓▒▒░░░░░░░░▒▓▓▓▓▒▒░░▒▒▒▒▓▓▒▒▓▒▒▒▒ ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▒▓▒▒▓▓▒▒▓▒▒▓▒░▒▓▓▒▒▒▒▒▒░░▓▓▒▒▒▒▒▒▒▒▓▒▒▓▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▒▓▓▒▒▒░░▒▒▒▓▒▓▓▒▓▓▒░▒▒▒▓▒▒▒▒▒▓▒▒▒▒░     ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓░▒▒▒▒▒▓▓▓▓▒▒▒▓▒▒▒▒▒░▓▓▓▒▒▓▓▓▒▓▒▒      ░    ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒▒▓ ▓▒▓▒▓▓▒▒▒▒▓▒▓▓░▒▓▒▒▓▒▓▒░                  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒▓▒▓░▒▓▒▒▒▒▒▒▓▓░▒▓▓▒▒▓▓▒                       ▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓ 
        ▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓░▓▒▒▓░▒▓▒▒▒▓▒▒▓▒▓▓▒▒▓                           ▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓  
        ▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▓▓░▓▓▒▒▓▒▓▓▓▒▒░                              ░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓   
        ▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓░▒▓▓▒▓▒▓▓▒                                   ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒▒▒▒▒▒▓░                                       ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒     
        ▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▒▓      ░                                     ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░      
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ ▒▒▒▒                                               ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓        
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓                                                    ░▓▓▓▓▓▓▓▓▓▓▓▓▓         
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░                                                    ▒▓▓▓▓▓▓▓▓▓▓░         ▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓         ░                                           ▓▓▓▓▓▓▓▓▓       ░ ░▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒                                                     ▓▓▓▓▓▓▒         ▒▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓                                                     ▓▓▓▓▓          ▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒                                                    ▓▓▓▒         ▒▓▓▓▓▓▓
    ";
    Akaza = "▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▒▒▒▒▒▓▒▒▒▒▓▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▒▓▒▒▒▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▒▓▓▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░███▓█▓▓█▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒▒▓▓▓▒▒▒▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░▒▒▒▒▒▒▒▒▒░▒▒▒░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▒▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒░▒▒▒▒▒░▒▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▒▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▒▓▓▓▓▓▓▓▒██░▒▒▒░░░░▒▒░░░░░▒▒▒░░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▒▓▓▓▓▓▓▓▓█▓▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░▒▒░░▒▒▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▒░▒▒▒▒▒▒░░░░░░░░▒▓▓▓░░░░▓▓▓▓▓▓▒░░░░░▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒░░░░░░░░▓▓▓▓▓░░░░▓▓▓▓▓▓░░▓▒▒░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▒▒▒▒▒░▒░░░░░▓▓░░░▓▓▓▓░░░░▓▓▓▓▓░▒▓▓░░░░▒▒▒▒▒█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒░░░░▓░░░▓▓░░▓▓▓▓░░░░▓▓▓▓░░▓▒░░▓▓▒▒░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒░░░░░▓▓▒░░▓▓░▒▓▓▓░░░░▓▓▓▒░▓▓▒░▓▓░░░▒▒▒░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█░░░░░▒▒░░░▓▓░░▒░░▒▓▓▒░░░▓▓▓░░▒░░▓▓░░▓▓░▒░▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓███▓░░░░░▓▓▓░░▓▓░░█▒░▒▒▓▓░░░▓▓▒░░▒░░▓▓░░▓▓░░░░▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██░░▓▒▒▒▒░▒▒▒▒▒░▒░▓▓░░░▓▒▒░░▓▒▒▒▒▒▒▓▓░░▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██░▓░▓▓▓░▒▒▒░▓░▓▒▒▒▒█░░░▓▓█▒░▒░▒▒▒▒░▓▓░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓███▓▓▓░▓▓░░▒▒░▒▓░░▒▒▒▒░░░▓▓▓▓░▒▓░▒▒▒▒▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓░░░░░▓▓▒░▒▓░░▒▒▒▒▒▓▓▓▓▓▓▓░░▓▓░▓▓░░▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓█▓▓▒░░▓▒░░▓▓░░▓▓▒▒▒▒▓▓▓▓▓▓▓▓░░▓▓░░▓▓░▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ░░░░░░░░░░░░░░░░░░░█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓▓░░░░▓▓▓░░▓▓▓▓▓▒▒▒█▓▓▓▓▓▓▓░░▓▓░░▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ░░░░░░░░░░░░░░░░░░░▒██▓████▓█▓▓▓▓▓▓▓▓▓▓▓▓▓███▓▓▒▓▓░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ░░░░░░░░░░░░░░░░░████▓▓▓▓▓▓██▓▓▓▓▓▓▓▓▓█▓▓▓▓▓██▒▓░░▒▓▓▓▓░░▓█████████▓▓▓░▓▓▒░▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ░░░░░░░░░░░░░░░░████▓▓██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██▓▓▓▓▓██░▓▓▓▓▓▓▓░░░░░░░░░░░░▓▓▓▓▓▒█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ░░░▓█░░░░░░█▓█▒░░░░█████▓▓▓▓▓▓▓▓██████████▓█▓▓▓███▒▓▓▓▓▓▓▓▓▓▓█████▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ░░░▓░░░░░░▓█░░░░░░░░░░██████▓▓███████▓▓█▓▓██▓▓█████░░▓▓▓▓▓▓▓▓▒░▒▓▓▓▓▓▓▓░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ░░░░░░░░░░▓░░░░░░░▓░▒███▓██████████████████████████░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓░░░░░░░▓██████████████████████████████████░░░░░░░░▒▓▓▓▓▓▓░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▒▓▓▓▒▓▓▓▓▓▓▒░████▓██████▒░░░░░░░░░░░░░░░░░░░░░░▓█▒░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▓▓▓▓▒▓▓▓▓▒▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓░░░░░░░░░░░░░░▒░░░░░▒▒▒▒▒▒▒▒▒▒░░░▒▒▒░░░▒░░░░░░░░░▒▓▓░░░░▒▓▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▒░░▓▒▒▓▓▓░░░░▓▓▓▒▓░░░▓▓▓▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒░░▓▓░░░▓▓▒▒▓▓░░░░▓▓▒▒▓▒░░░▓▓▓▒▒▒▒▒▒▒▒▒▒░▓▓▒░░░░▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓░░░░▓▒▓▓▒▓░░░░▓▒▒▓▓▓░░░░░░░▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒░▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░▓▓▓▓▓▓▓▓░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓░░░▓▓▓▓▓░▓░░░░▓▒▓▓▒▒▒░░░▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░▓▓▓▓▓▓▓▓░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓░░░░▒▒░▒░▓▓░░░░▓▓▒▒▒▒▓░░░░▓▒░▒▒▒▒▒▒▒▒▒▒░░░░░░▓▓▓▓▒
        ▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░▓▓▓▓▓▓▓▓░░░░▓░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▓▓▓▓▓▓▓▓░░░░▓▓▓▓▓▓▓░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▓▓▒░░▒▓▓▓▒
        ▓▓▓▓▓▓▓▓▓▒░░░░░░░░▓▓▓▓▓▓▓░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▓▓▓▓▓▓▓▒░░░░▓▓▓▓▓▓▓▓░░▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓░░░▓▓▓▒
        ▓▓▓▓▓▓▓▓▓▓░░░░░░░░▓▓▓▒░▒▒░░░░░░░▒▒▒▒░░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▓▓▓▒
        ▓▓▓▓▓▓▓▓▓▓░░░░░░░▒░▒▒▒▒▒▒░░░░░░▒▒▒▒░░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░▓▓▓▓▓▓░░░░░░░░▒▒▒▒▒▒▒▒▒░░░▒▒░░░▓▓▒
        ▓▓▓▓▓▓▓▓▓▓▒░░░░▒▓▓▓▓▓▒▒▒▒░░░░░░▒▒▒░░░▒▒▒▒▒▒▒▒░░░░░░░▓▓▓▓▓▓▓▓▒░░░░░▓▓▓▓▓▓▒░░░░░░░▒▒▒▒▒▒▒▒▒▒░░░▒▒░░▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓░░ ▓▓▓▓▓▓▓▓▓▒░░░░░░▒▒▒░░░▒▒▒▒▒▒▒▒░░░░░░░░▓▓▓▓▓▓▓▓▒░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░▓▓▒░░░░░░▒▒▒░░░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░▒▒▒▒▒░░░░░░░░▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▒░▓▓▓▓▓▓▒░░░░░░░░░░▒▒░░░▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░▓▓▓▓▓▓▓▓░░░░░░░▒▒▒▒░▒▒▒▒░░░░░░░░░░
        ▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░▓▓▓▓▓░░░░▒░░░▒░░▒▒▒▒▒▒▒▒▒▒░░░░░░▓▓▓▓▓▓▓▓▓▓░░░░░░░░▓▓▓▓▓▓░░░░░░▒▒▒▒▒░▒▒▒▒░░░░░░░░░░
        ▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░▓▓▓▓░░░░░░▒░░▒▒▒▒▒▒▒▒▒▒▓▒░░░▒▓▓▓▓▓▓▒░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▒▒▒▒▒▒░▒▒▒░░░░░░░░▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░▓░░░░░▓▓░░░░░░░░░▒▒▒▒▒▒▒▒▒░░░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒░░░▒░░░░░▒░░▒▒
        ▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓░░░░▒░░░░ ░░░░░░░░░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒░░░░░░░▒▒▒▒▒▒▒░░░░░░░░▒░░░░
        ▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░▒░░▒▒░░░░░▒▒▒▒▒▒▓▓▒░▒▒░░▒▒▒▒▒▒▒░░░░░░░░░░░░░
        ▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░▒░░░░░▒▒▒▒▒▒▒▒▒░░░░░░░░░▓▓░▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▓▓▓▓▓▒░░░▒▒▒▒▒▒▒░░░░░░░░░▒▒▒
        ▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░▓░░░░░░░░▒▒▒▒▒▒▒▒▒░░░░░▒▓▓▓▒▒▒▒▒▒▒▒▓▓░░░░░▓▓▒▒▒▒▒▓▓▓▓▓▒▒░▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒
        ▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░▓▓░░░░▓░░▒▒▒▒▒▒▒▒▒░░░▒▓▓▓▓▒▒░░▒▒▓▓▓▓▓░░░░░▒▓▓▓▒▒▒▒▓▓▓▒▒▒▒▒▒▒░▒▒▒░░░░░░▒▒▒▒▒░
        ▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒░░░░▒▒░░▒▒▒▒▒▒▒▒▒░░▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓░░░░░▒▓▓▓▓▓▓▒▒░▒▒▒▒▒░░░░▒▒▒░░░░░░▒▒░░░░
        ▓▓▓▒░█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░█░░░▒▒▒▒▒▒▒▒▒░▒▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓░░░░░░▓▓▓▓▓▓▓▓▓▒▒▒▒▒░░░░░░░░░░░░░░░░░░░
        ▓▓▓▓▒▒▓▓▓▓▓▓█▓▓▓▓▓▓▓▓▓▓░░░░▒█░░░░▒▒▒▒▒▒▒▒▒░▒▒▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓░░░░░░▓▓▓▓▓▓▓▒▓▒▒▒▒▒░░░░░░░░░░░░░░░░▒▒░
        ▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒░░░▓██░░░░▒▒▒▒▒▒▒▒░░▒▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒░░░░░░░░▓▓▓▓▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░▒▒▒░
        █▒▓▓▓▒▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒░░░▓█▓░░░░░░▒▒▒▒░░░░░░░░░░░░░▓▓▓▓░▒▒░░░░░░░░░░░▒░░░░░▒░░░░░░░░░░░░░░░░░░░░░▒▒░
        ▓█░▒▓▓▒▓▓▓▓▓▓▓▒▒▓▓▓▓▒░░░▓▓▓▓░░░░░░░░▒░░░░░░ ░░░░░░░▓▓▓▓▓▓▓▓▓▒░░░░░░▒▓▓▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░
        ▓▓██░▒▓▓▓▓▓▓▓▒▒▒▒▓▓▒░░█▓▓▓▓▓▓ ░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░
        ▓▓████░░▓▓▓▓▓▒▒░▓▒░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓░░░▓▒▒▒▒▒▒▒▒▒░▒▒▒▒░░░░░░░░▒▒▒▒░░░░░░░
        ▓▓▓▓▓▓█░▓▓▓▓▓▓▒▓▓░░█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░▒░▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░▒▒▒▒▒▒▒▒ ░░░░░
        ▓▓▓▓▓▓▓▓█▓▓▓▓▓▓▓░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░▓░░░▓▓▓▓▓▓▓▒▒▒▒▒▒▒░░▒▒▒▒▒░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░░░░░
        ▓▓▓▓▓▓▓▓▓▓░░▒▒░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▓▓▓▓▓▓▓▓▓▒░░░░░░░▒▒▒▒▒▒░░░░░░░░░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒░░░░
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓░░░▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒░░░
        █▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░▒▓▓▓▓▓▓▓▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒▒▒▒▒▒▒▒░░▒▒░░
        █▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░▒▓▒▓▓▓▓▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒░▒▒▒▒░░░░▒▒░░
        █▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▓▒▓▒▒▒░░░▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒░▒▒▒▒░░░░░░░
        ▓▓▓▓▓▓▓▓▓▓▓▓██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▒▓▓▓▓▓▓▓▒░░░░░░░░░░░▒▒▒▒▒▒░░░░░▒▒▒▒▒▒░░▒▒▒▒▒▒░▒▒▒▒░░░░░░
        ▓▓▓▓▓▓▓▓▓███▓▓▓▓███▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▒▒▓▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒░░░░░░░
        ██████████▓█████▓▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▓▓▓▓░░▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒░░░░░░░
        ████████████████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▒░░▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒░░░░░░░░░░░
        ░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒░░░░░░░░░░░░▒░░░░▒░
        ░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒░▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░
        █▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒░░░░░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░▒▒▒▒░░░░░░
        █▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░░░░░░▒▒░░▒▒▒▒▒░░░░░
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒▒▓▓▓▓▓▒▒▒▒▒░▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒ ▒▒▒▒▒▒▒▒▒ ░░░░▒▒▒░▒▒▒▒▒░░░░░
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▒▓▓▓▓▓▓▓░░░ ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒ ▒▒▒▒▒▒▒▒▒░░░░░░░▒▒░▒▒▒▒░░░░░
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒ ░░░░░░▒▒▒▒▒▒▒▒░░░░
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒░      ░▒▒▒▒▒▒▒░▒░░
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒░░░░░░░░░▒▒▒▒▒▒▒▒░░
    ";
    Haku = "▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░▒▒▒░░░░░░░░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒░░░░░░░░░░░░▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒▒▒░▒░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░▒░▒▒▓▒▒▓▓▓▓▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░░░▒▒▓▒▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▒░░░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓░░░▓▒▒░▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▒▒▒▒▒▓▒▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓░░▓▓▓▓▒▒▒▒▒▒▒▓▓▒▒▒▒░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▓▓▒▓▓▓▓▓▓░▒▓░▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▓▓▓▓▓▓▓▓▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▒▓▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▓▓▓░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▓▒▓▓▓▒▓▓▒░▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▓▓▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▓▒
        ▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒░▓▓░▓▒▒▒▒▒▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▓▓▓▓▓▓▓▓▓▓▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▓▒▒░▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▓▓▓▓▓▓▓▒▓▒░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒░░░▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓░▒▒▓░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▓▓▓▓▒▓▒▓▓▓▓▓▒▒░░░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▓▓▓▓▓▒▓▒▓▓▒▓▓▒▒░░░░▒░▓▓▒▓▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒▓▓▓▓▓▓▒▒▓▓▓▓▓▓▒▒░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▓▓▒▒▓▓▒▓▒▒▒▒░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▓▓▓▒▒▒▒▒░░░░░▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ░▒▒░▓▒▓▓▒▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▓▓▓▓▒▒▒▒░░░░░░▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒░░░░░▒▒░░▒▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▒▓▓▓▓▓▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ░░░░▒▒░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒░░░░░▒▒░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒░░░░▒▒░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▒▒▒▒▒░░░░░░░░░░▒▓▓▓▒▓▓▓▒▓▒▒░░░░░▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▓▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▒▒▒▒▒░░░░▒░░░░▓▓▓▒▓▓▓▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▒▒▒▒░░░▒▒░░░▓▓▒▓▓▓▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▒▓▓▒▒▒▒░░░░▒░░░▒▓▒▓▓▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▓▓▓▓▓▒▓▓▓▓▒▒▒░░░░▒░░▓▓▓▒▒▒▒░░░░░▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▓▓▓▓▓░░▒▓▓▓▓▓▓▓▓▓▓▒▒
        ▒▒▒▒▓▓▓▒▓▓▓▓▒▒▒▒░░░▒░░░▓▓▓▒▒▒░░░░░▒▒▒▒▒▓▓▓▒▓▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▓▓░▒░░░░░░░░░░░░▓░░░░░░░░░▒▓▓▓▓▓▓▒▒▒
        ▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒░░▒░░░░▒▓▒▒▒▒▒░░░░░░▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░▒░░░░░▓▓░▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▓▓▓▒▒▒
        ▒▒▒▒▒▓▓▓▒▓▓▓▓▓▒▒▒▒░░▒░░░░░▓▒▒▒▒▒░░░░░░▒▒░░▓▒▒▒▒▓▒▒░░░░░░░░░▒▓▓▓▓▓▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▒▒▒░░░░▒▓▒▒▒
        ▒▒▒▒▒▓▓▓▓▒▓▓▓▓▓▒▒▒▒░░▒░░░░▒▒▓▒▒▒▒▒░░░░░░░▓░░░░░░░░░░░░▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░▒▒▒▒
        ▒▒▒▒▓▓▓▓▒▓▓▓▓▓▓▓▒▒▒░░░░░░░░░░▓▓▓▓▓▒▒▒░░░▒░░░░░░░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▓▓▒▓▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒░░░▒▒▒
        ▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒░░░▒▓▓
        ▒▒▒▒▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒░░▒░▒░░░░░▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒░░▒▓▓
        ▒▒▒▒▒▓▓▓▓▓▒▓▓▓▓▓▓▓▒▒▒░░░▒░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▓▓▓▒▓▓▒░░░▒▓▓
        ▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▓▓▓▓▒▒▒░░▒▒▒░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▓▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▒▓▓▒░░░▒▓▒▓
        ▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░▒▒▒▒░░░░░░░░░░▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▓▓▒░▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓░░░▒▒▒▓▓
        ▒▒▒▒▒▒▒▒▒▓▓▓▓▒▓▓▒▓▓▓▓▒▒░░░▒▒▒▒░▒▒░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▓▒░▓▓▓▓▓▒▒▒▒▓▓▒▓▓░▓▒▒░░░░▒▒▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒░░▒▒▒▒▒▓░▒▒░░░░░░░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▓▓▓▓▓▒▓▒▒▒▒▓▒▓▓▓░░░░░░░▒▒▒▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▓▓▓▓▒▒░░▒▒▒▒▒▒▓▓▓▒░░░░░░░░░░░░▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓░░▒▓▓▓▒▓▓▓▓▒▒▒▒▒▓▓▒░░░░░░▒▒▒▒▒▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▓▒▒░░░▒▒▒▒▒▓▓▓▓▓▒░▒░░░░░░░░░▒▒░▓▓▓▓▒▒▓▓▓▓▓▒░░▒▓▒▒▓▓▓▒▒▒░░░░▒░░░░░▒▒▓▒▒▓▓▓▓▓▓▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒░░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░▓▒░░▓▓▓▒▒▒▓▓▓▓▓▓▓
        ▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▒▒▒▒▒░▒▒▒▒▒▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░▒▒▓▒▒▒░░░▓▓▒▒▒▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓░▒░░░▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓░░░░░▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▓▒▒▒▓▒▒▓▓▓▓▓▓░▒▒▓▓▓▓▒▒▒▓▒▒▒▒▒░░░░▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▒▓▓▓▓▓▒▓▓▒▒▓▓▓▓▓▒▓▓▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒░░░░▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▓▓
        ▓▓▓▒▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▓▒▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░░▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓
        ▓▓▓▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓
        ▓▓▓▓▓▓▒▒▒▒▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓
        ▓▓▓▓▓▓▓▒▒▓▓▒▒▒▒▒▒▒▒▓▓▓▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
    ";
    Ymir = "▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▓▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░▒▒▒░▒▒░░░░░░░░░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░▒░░▒▒░░░░░░░░░
        ░░░░░▒▒▒▓▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░▒▒▓▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░▒▒▒▒░░░░░░░░░░
        ░░░░░░▒░░▒▓▓▓▓▓▓▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░░░░░░░▒░░░░░░░░░
        ░░░░░░░░░░▒░▓▓▓▓▒▒▒▒▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░▒▒▓▓▓▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░░░░░░░░░░░░░░░
        ░░░░▒░▒▓▒▒▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░░░░░░▒░░▒▒▒▒▒
        ░░░░▓░░░░▓▓▓▓▓▒▒▓▓▒▒░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░▒░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░░░░░░░░░░░░░
        ▒▓▒▒░▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░░░░░░░░░░░░░░░░▒░▒░░▒░░░░▒░░░░░░░░▒░░░░░░░░░░░░░░░░░░░▒░▒░░░░░░░░░░░░░░░
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░▒░▒▒░░░░░░░░░▒░░░░░▒░▒▒▒▒▒░░░░░░░░░░░░░░
        ▓▓▓▓▓▓▓▓▒▒▒▒▒▓▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░▒▒▒░░░░░░░░░▒░░▒░▒░░▒▒▒▒░░░░░░░░░░░░░░
        ░▒░░░░▒▒▒░▓▒░░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░▒▒░▒▒▒░░░░░░░░░░░░░▒░░▒▒▒▒▒░░░░░░░░░░░░░
        ░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░░▒░░▒▒░▒▒▒▒░░░░░░░░░░░░░░░░░▒▒▒░░░░░░░░░░░░░
        ░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░░▒▒░▒▒▒░▒▒▒▒░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░▒░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░░░▒▒▒▒▒░░▒▒▒▒▒░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░░░▒▒▒▒▒▒░▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░░░░░░░░░░░░░░░░░▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒░░░░░░░░░░░░░░▓░░░░░░░░░░░░
        ▒▒░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░▒░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒░░░░░░░░░░░░░▒░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▒░░░░▒▒▒░▒▒░░░░░░░░░░░░░▒░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░░░▒░░░░░░▒▒▒▒▒▒▒░░░░░░░░░▒▒▒░░░░░░░░░░░░▒░░░░░░░░░░░░
        ░░░▒▒░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░▒▒▒░░▒▓▒▒░▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒░░░▒▒▒▒▓░░░░░░░░░░░▒░░░░░░░░░░░░
        ░░▒░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓░▒▒▒▒▒▒▒▒▒▒▒▒▓░░░░░░░░░░░▒░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓░▒▒▒▒▒▒▒▒▒▒▒▓▓░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓░▒▒▒▒▒▒▒▒▒▒▒▓▓░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▓▓░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░ ░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▓▓░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░ ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░ ░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▓▓▒░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░▒▒░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒░▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓░▒░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▓▓▓▓░▒░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░
        ░░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░▒▒░░░░░▒▒░░░░▒▒░▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░▒▒▒▒░▒▒▒▒▒▒▒▒▒▒░▒▒▒░░░▒░░░░░░░░░░░░░░░▒▒░░░░▒░░░░▒▒▒░▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒░░░░░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒░░░░░░░░░░░▒▒░░░░░░░░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒
        ▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░▒▒▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒
    ";
    PieckFinger = "▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░▒░░░░░▒░▒▒▒▒▒▒▒░▒▒░░▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░▒░░░░▒▒▒▒▒▒▒░░▒▒░░░░▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░▒░░░░░░░░░░░▒▒▒▒▒▒▒░░▒▒░░░░░░▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒░░░▒▒░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░▒▒▒▒▒░░▒▒░░░░░░░▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒░░░░░░░░▒░░░░░░░░░░░░░░▒░░░░░░░░░░░▒░░░░▒░░░░░░░░░░░░▒▒▒▒▒░░▒▒░░░░░░░░▒
        ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒░░░░░░░▒▒░░░░░░▒▓▒░░░░░▒░░░░▒▒░░░░░░░░░░░░░░░▒▒▒▒▒░░▒▒░░░░░░░░░
        ▒░░▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░▒░░░░░░░▒▓▓▓▒░░░░░▒░░░▒░▒░░░░░░░░░░░░░░░▒▒▒▒░░▒▒░░░░░░░░░
        ▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓░░░░▒░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░░▒▒░░░░░░░░░
        ▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▒░░░▒░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░░▒▒▒░░░░░▒░▒
        ▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░▒▒░▓▓▓▓▓▓▓▓▓▓░░░░▒░░░░░░░░░░░░░░░░░▒░▒▒▒▒░░▒▒▒░░░▒░▒▒▒
        ░░░░░▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓░░░▒▒░░░░░░░░░░░░░░░▒░▒▒▒▒░░░▒▒░░░▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░░░░░░░░░░░░░░░▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░░░░░░░░▒▒░▒▒▒▒░░░░░░░░▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░▒▒▒░░░░░░▒▓▓▓▓▓▓▒▒▒░░▒▒▒▒░░▒▒▒░░░░░░░░▓░▒▒░▒▒▒▒░░░░░░░░░░░░░
        ▒▒▒░▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░▒░▒░░░░░░░░░▒▓▓▓▓▓▓▒▒▒░░░░░░░░░▒▒░░░░░░░▒▒▒░▒▒▒▒▒░░░░░░░░░░░░░
        ▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒▒▒▓▓█▒▒▒▒▓▓▒▒▓▓▓▓▓▓▓▓▓█▒▓▒░▓▓▒▒▒░░░░░░░░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░
        ▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▓▓▓▓▒▓▒▓▓▓▒▓▒▒▒▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▓▓▓░░░░░░░░░░▒▒▒▒▒▒▒░░░░░░░░░░░░░
        ░░░░░▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░▒▒▒▒▒▒▒▒░░░░░░▒░▒░▒▒▒
        ░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒░▒░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░▒▒▒▒▒▒▒▒░░░░▒░▒▒▒▒▒▒▒
        ░░░░░▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒
        ░░░░░▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░░░░░░░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓░▒░░░░░░▒░░▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒
        ░░░░░▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒░░░░░░░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒░░░░░░▒░░▒▒▒▒▒▒░░░░░░▒▒▒░▒▒▒▒▒
        ▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒░░░░░░▒░░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░▒▒░░▒▒▒▒▒▒▒▒░░░░▒▒▒░░░▒▒▒
        ▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒░░░░░░▒░░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▓▓▒▓▓▒▓▓▓▓▓▓▒▓▓▓▓▒░░░░▒▒▒░▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░
        ░░░░░▒▒▒▒░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒░░░░▒▒░░▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░▒▒▒░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░
        ░░░░░▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒▒▒▒░
        ░░░░░░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░▒▒▒░
        ░░░░░░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░░░▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒░░░░░
        ░░░░░░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░▒░░
        ░░░░░░▒▒▒░▒▒▒▒▒▒▓▓▓▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▓▓▓▓▒▒▒▒▓▒▓▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░
        ░░░░░▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░
        ░░░░▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▓▓███▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░
        ░░░░░▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▓▓█████▓▓▓▓▓▓▓▓▓██████▓▒▒▒▒░░░░░░░▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░
        ░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒░░▒▒░░░░░░░▓██████▓▓▓▒▓▓▒▓▓██████▓▒▒▒▒░░░░░░░░░░░▒▒▒▒▒▒░░░░░░░░░░░░░
        ░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░▒▓█████▓▒▒▒▓▒▒▒▒▓▓████▓▓▒▒▒▒░░░░░░░░░░░░░░▒▒▒░░░░░░░░░░░░░
        ░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓██▓▓▒▒▒▒▒▒▒▒▒▒▓▓███▓▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░▒▒▓▓▓▓▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓█▓▓▒░░▒▒▒▒▒▒░░▒▓▓█▓▓▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▓▓▓▒▒▒▒░░▒░░▒▒▒▒▒▓▓▓▒▒▒░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▓▓▒▓▓▒▒░░░░░░░▒▒▒▒▓▓▒▒░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▓▓▓▒░░░░░░░▒░▒▓▓▒▒░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▓▓▓▓▒░░░░░▒▓▓▓▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▓▓▒▓▓▓▓░▒░▒▓▓▓▓▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▓▓▓▒▓░░▓░░▓▓▓▓▒▒▒▓▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒▒░▓▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▓▓▓░░▓▓▒░▓▓▓▓▒▒▓▓▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░▓▓▓░░▓▓▓▒▒▓▓▓▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒▒▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░▓▓▓▒░░▒▒▒▓▓▓▓▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░▒▒░▓▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▒▓▓░▓▓▓▓▓▓▓▓▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░▒▒▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▒░▓▓▓▓▓▓▓▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░▒▒▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓░░▓▓▓▓▓▓▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒░▓▒▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓░▒░▓▓▓▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒▓▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓░▓▓▒▒▒▒▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░▓▓▒▓▓▓▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▒▓▓▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ░░░░░░░░░
        ▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▓▒░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒░░░░░░░░░ ░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▓▒▓▒░░░░░░░░░ ░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░▒▒▒▒▒▒▓▒░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░ ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ░░░░░░░
        ░░░░░░░░░░░░░ ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ░▒▒░░░░░░
        ░░░░░░░░░░░░░░░░░ ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ░░▒▓░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▒░░░░░
        ░░░░░░░░░░░░░░░░░▒▒░░░░░░░░░░░░░░░░░░░░░░░ ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░ ░░░▓▓▓░░░░░
    ";
    ChinatsuKano = "▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒▓▒▒▒▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▓▒▒▓▒▒▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▓▓▒▓▒▒▒▓▒▒▓▓▒▓▓▓▓▓▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▓▓▓▒▓▓▓▓▓▓▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▓▓▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▓▓▓▓▓░▓▒▓▓▒▓▓▒▓▓▓▓▓▒▓▓▓▓▒▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▓▓▓░▒▓▓▓▓▒▓▓▒▓▓▓▓▓▓▓▓▒▓▓▓▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓░▓▓▓▒▓▓▒▓▓▓▓▒▒▓▓▒▓▓▓▓▓▒▓▓▓▒▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▒▒▓▓▒▓░▓▓▒▓▓▓▒▒▓▓▒▓▓▓▓▓▓▓▓▒▓▒▒▒▓▓▓▓░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▒▒▓▓▓░▓▒▓▓▒▒▓▓▒▓▒▓▓░▓▓▓▓▓▒▒▓▓▓▒▒▓▒▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▒▒▓▒▓▒▓▒▓▓▒▒▒▓▓▓▓▒▓▒░▓▓▓▓▓▓▓▒▓▒▓▓▒▓▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▒▓▒▒▒▓▒▓▓▒▒░▓▓▒░▓▒▒▒░▒▓▓▓▒░░▓▓▒▒▓▒▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▓▒▓▒▒▓▓▒▓▓▓▒░░▓▓▒░▓░▓▓▒▒▓▓▒▒▒▓▓▒▒▓▒▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒░▒▓▒▓▒░░▓░▒▓▒▓▒▒▒▓▒▓░▓▒▒▓▒░▒▒▒▒▒▓▓▒▒░▓▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒░░▓░▒▓▒▒░▒▒░▒░▓▒▓▓▓▓▒▓▒▒▒░▒▒▒░▓▓▒░▓▒░░▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▒▓▒▒▓▓░▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▒░▒▓▓▒▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▓▓▓▒▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▓▓▓▓▓░▓▒▒▒▓▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▓░▓▒▓▒▓▓▓▓▓▓▓▓▓▓▒▓▓▒▓▓▓▓▓▓▓▓▓▓▒▒▒░░▒░▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓░░▒▒▒▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒░▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░▒▒▒▒▓▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒░░░▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓░░▒▓▒▒▒▓▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▒▒░▒▓▓▓▓▓▓▒░▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▒░▒▓▓▒▒▒▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▒▒░▓░▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓░░░▒▒▓▒▓▒▓▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒░▒░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░▒▓▒▒▒▒▓▒░▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▓▒▓▒▒▒░░░░░▓▓▓▓▓▓▓▓▓▓▓░░░░▒░▒▒▒░▒▓▒▒▓▓▓▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▓▒▒▒▓▒▒░▓▒░░░░░▓▓▓▓▒░░░▒▓░░▒▒░▒▒▒▓▓▒▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▒▓▒▓▒▓▓▒▒▓▓▓▒░░░░░░░▒▒▓▓▓▓░▒▒▓▒▒▒▓▓▒▒▒▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▒▓▓▒▒▓▓▓▓▓▒░▒▒▒▓▓▓▓▓▓▒▒▒▓▓▒▓▓▓▒▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▓▒▓▓▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒▓▒▒▓▒░▒▓▓▓▓▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▓▒▒▓▒░▒▓▒░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▓▓▓▓▓▓▒▒░░░░░░▒▒▒▓▒▓░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▒▒▒░░░░░▒▓▓▓▓▒░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▓▓▓▒▒▒▒░░░░░░░▒▓░▒▒▒▓▓▒▓▓▒▒▒▓▒▒▒▒▒▒▒▒▒▓▓▒▒▓▓▓▒▒▒░░░▒░░░░▒▓▓▓▓▓▓░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓░▒▒░▒▒░░░░░░░▓▓▒▓▓▒▓▓▓▒▒▒▓▓▓▓▓▒▓▓▓▓▒▓▓▒▒▒▒▓▒▒░▓▒▒▒░░░░░░▒▒░░░░▒▓▓▓░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▒░▒▓▓▒░░▒▒░▒▒░░░░░░▓▓▓▒▓▓▓▒▒▓▓▒▓░▒▒▓▓▓▒▒▒▒▒▒▒▓▓▒▒▒▓▒░▓▓▓▒▓▓▒░░░░░▒░░░░░▒░▒▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▒▒▒▓▓▓▒░░░▒▒░▒░░░░▒▓▓▓▓▒▓▓▓▓▓░▓▒▒▓▓▒▓▒▒▓▓▒▓▓▓▒▓▒▓▒▓▒▓▒▒▓▓▓▓▒▓▓▓▓░░░░▒░░░░▒▒░░░▓▓▒░▒▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓░░▒▓▓▓▒▒░░░░▒▒░▒░░▓▓▓▓▓▓▒▓▓▓▓▓▒▒▓▒▒▓▓▓▓▓▒▓▒▒▓▓▓▓▒▒▒▓▓▒▒▒▒▓▓▓▓▓▒▓▓▓▓▓▓▒░░░░░░▒░░░▒▒▒▓▒░▒▓▓▓▓▓▓▓▓
        ▓▓▒░░░▓▓▒░▒▒░░░░░▒░░▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▒▓▒▒▒▓▓▓▓▒▒▓▒▓▓▓▒▒▒▓▓▓▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓░░░░▒░░░▒▒░▒▓▓▒░▒▓▓▓▓▓▓
        ░░░▒▓▓▒▒░░▒▒░░░░▒▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▓▓▓▓▓▒▓▓▓▓▒▓▒▓▓▓▓▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▒▒░▒░░░▒░░░░▓▓▓░░▓▓▓▓▓
        ░▓▓▓░▒▒░░▒▒▒░░░░▒░▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▓▓▓▓▓▓▓▒▓▓▒▓▓▓▓▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▒▓▓▓░░░▒░░░░░▒▓▓▒░░▓▓▓
        ▓▒░░▒▒░░░▒▒░░░░░▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▒▒▒▒▓▒▒▒▒▒▓▓▓▒▒▓▓▓░░░▒░░░▒░▒▒▒▓▒░░▓▓
        ░▒░░▒▒▒░░▒▒░░░░▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▓▒▒▓▒▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒▓▓▓▓▓▒▒▓▒▓▒▓▒▓▓▓▓▓▒▒▓▓░░░▒░░▒░░▒▒░▒▒▒▒░░
        ░▒░░▒▒░░░▒▒░░▒▒▓▓▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▒▓▓▓▒▒▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓░░▒░░░▒░░▒▒▒░░▒▓▓░
        ░▒░▒░▒░░░░▒░░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▒▒▓▓▒▒▒▓▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓░░▒░░░▒░░▒▒▒░░░░▓▒
        ░░▒░▒░░░░░░░░▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▓▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓░░▒░░▒░░░░░▒░░░▒░▓
        ░░░▒▒░░░░░░░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▒▓▓▓▓▒▓▒▒▓▒▓▒▓▓▒▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓░░░░░▒░░░░░▒░░░▒░░
        ░░░░▒░░░░░░░░░▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▒▓▓▒▓▓▓▓▓▒▒▓▓▓▒▓▓▓▓▓▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒░░░░▒░░░░░░░░░▒▒▒░
        ░░░░░░▒░░▒░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▒▓▓▒▓▒▓▓▓▓▓▓▓▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓░░░░░▒░░░░░░░▒░▒▒▒▒
        ▒░░░░░░░░░▒░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▒▓▒▓▒▒▓▒▓▓▓▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░▒░░░░░░░▒▒▒▒▒▒▒
        ░░▒░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▒▓▓▓▓▒▓▓▓▒▒▓▓▓▓▓▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░▒░░░░░░░░▒▒▒▒▒▒▒
        ░░░░░░▒░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▒▓▒▓▓▓▓▓▓▓▓▓▓▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░░░░░░░░░░
        ▒▒░░░░░░░░░▓▓▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▓▒▓▓▓▓▓▓▓▓▒▓▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒▓▒▒▓▒▓▓▓▓▓▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░░░░░░░░░░
        ░░░░▒▒░░░░▒░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▒▓▒▓▓▒▓▓▓▓▓▓▓▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░▒▒
        ░░░░░░░▒▒▒░░▒▒░▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▓▒▒▓▓▓▓▒▓▒▓▓▓▓▓▓▓▓▓▓▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓░░░░░░░░░░░▒░░░░░
        ░░░░░▒▒░░░░░▒▒░▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▓▓▓▓▓▓▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒░▓▓▓▓▓▓▓▓▓▒▓▓▒▓▓▓▓▒▒░░░░░░▒░░▒░░░░▒▒▒▒
        ░░░░░░░░░░░▒▒░░▒▓▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▓▓▓░▒▒▓▓▓▓▓▓▒▓▒▒▓▓▓▒▓▓▓▓▒▓▓▒▒▒▓▓▓▓▓▓▓▓▒▓▓▓▒▓▓▓▒▒░░░░░░░▒░░▒▒░░░▒▒▒
        ░░▒░░░░░░░░▒░░░▒▓▒▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓░▒▒▓▒▓▓▒▓▒▒▒▓▓▓▓▓▓▓▓▓▒▓▓▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░░░░▒░▒▒░░░░▒
        ░░▒░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓░▒▒▓▒▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▓▓▓▓▓▓▓▓▒▓▓▓▒▓▓▓▒░░░░░▒░░▒░▒░░▒▒░░░
        ░░░░░▒░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▒▒▓▒▓▒▓▓▒▒▒▓▓▓▓▒▓▓▓▓▒▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒░▒░░░░░░▒░▒░░░▒▒▒
        ░░░░░░░░░▒░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▒▒▒▓▓▒▓▓▒▒▒▓▓▓▒▓▓▓▒▓▒▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▒▓▓▓▓▒▓▒▒░░░░░▒░░░▒░▒░░░░░
        ░░░░░░░░░░░░▒░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▒▓▓▓▒▒▒▓▓▓▓▓▒▓▓▓▒▓▓▓░▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░░░░░░░░░░░░░░░░
        ▓▓▒▓▓▓▓▒▒▓▓░░░▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▒▓▓▓▒▓▓▓▒▓▒▓▒▓▒░░▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░▒▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓░▒▒▒▒▒▓▓▓▓▓▓▒▓▓▓▓▓▓░▓▓▓▒░░░▒░▓▓▓▒░▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓░▒▓▓▒▒▓▓▓▒▒▓▓▒▒▓▒▓▒▓▒▓▓▓▒░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓░▒▓▒▓▒▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓░▒▓▒▓▓▓▓▓▒▒▓▓▓▒▓▓▓▒▓▓▓▒▓▒▓▓▒▒░▒▒▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒▒▒▓▒▒▓▒▓▓▓▒▓▓▓▒▓▓▓▒▓▓▓▓▓▒▓▓▒▒░▒▓▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▒▓▒▓▓▓▒▒▓▓▓▓▒▓▓▓▒▓▓▒▒░▒▒▒▒▓▓▓▓▒▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓
    ";
    JeanPierrePolnareff = "▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▓▓▓▒▒▒▓▓▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▒▒▓▓▓▓▓▒▒▒▓▓▓▒▒▒░░░░░░░░░░░░░░░░░
        ▓▓▓▒▒░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▒▒▒▒▒▒▓▓▒▒▒▓▓▒▓▒▓▓▓▓▓▓▓▓▓▓▒▒▒▓▒▒▒▓▓▓▓▒▒▒▓▓▓▒▒▒▒▒░░░░░░░░░░░░░░░░░
        ▓▓▓▒▒░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▒▒▒▒▒░▓▓░▒▓▓▓▒░▓▓▓▓▓▓▓▒▒▒▓▓▒░▒▓▓▓▒▒▒▒▓▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░
        ▓▓▓▒▒░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▒▒▒░▒▓▓▓▓▒▒░▓▓▒▒▓▓▒▓▓▓▓▓▓▒▒▒▓░▒▒░▓░▒▒▒▒▒▒░▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒▓▓▓▒▒▒▒░░░░░░░░░░░░░░░░▓▒▓▓▓▓▒▒▓▓▓▓▓▓▒░▒▒▓▒▒▓▒▓▓▓▓▒▒▓░▒░▒▒▒▒▒▒▒▒▒▒░▒▓▓▓▒▒▒░░░░░░░░░░░░░░░░░░░
        ▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░░░░░▓▓▓▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▒▒░▒▒▒░▒▒░▒░▒▒▒▒░▒▒▒▒▒▓▓▓░░░░░░░░░░░░░░░░░░░
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░░░▓▒▓▓▓▓▓▓▓▓▒▓▓▓▓▒▓▓▓▓▓▓▓▒▒░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓░░░░░░░░░░░░░░░░░░░░
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒░░░░░░░░▒▓░▓▓▒▒▓▓▓▓▓▓▒▓▓▒▓▒▓▓▓▒▓░▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓░░░░░░░░░░░░░░░░░░░░
        ▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▒▓▓▒▓▒▓▒▒▓▓▓▓▓▓▓▓▒▒▓▒░░░░░▒░░▒▒▒▒▒▒▒░░░░▒
        ▓▓▓▓▒▒▒░░░░░░░░░░░░░░░░░░░░░░▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▓▓▓▓▓▓▓▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒
        ▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░▓░▓▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▒▓▓▒▓▓▓▓▓▓▓▒▓▓▓▓▓▒▓▓▓▓▓▓▓░▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▒▒▓▒▒░▒▒▒▒▒▒▒▒░▒▒▒░▒▓▒▓▓▒▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▒▒▒░▒░▓░▒▒▓░░▓▓▓▓░▓▒▒▓▓▓▓▓░▒░▒▓▓░░░▒▓▓▓▓▓▓▓▒▓▓▓░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▓▓▒░▒▒░░░░░░▒▓▓▓▓▒▓▓▒▓▓▓▒▓▓▓▓▒░░▓▒░▒▓▓▓▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░░░░░░░░░░▒▓▓░░░░░░░░░░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▒▒▒▓▓▓▓▓░░▒░░▓▓▒░▓▒▒▒▒▒▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░░░░░░░▓░▒▒░░▓░░░░░░░░░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▓▒▓▓▓▓▒▓▒░▓▓▓▓▒▓▒▓▒▓▓▓▒░░▓▓▓▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒
        ░░░░░░░░░▒▒▒▓▓▓▒░░░░▓░░░░░░░▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓░▒▒░▒▒▒░▓▓▒▓▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░░░░░▒░▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░▒▓▒▓▓▓▒▓▓▓▒▒▒▒▓▓░░░░░▓▒▓▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▒░▒░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒
        ░░░▓░░▒▓▓▒▓▓▓▓▒▒▓▓▒▓▓▓▓▓░░▓▓▓▓░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓░░░░░░░░░░░░░░░░░░░▒▒▒▓▓▓
        ▒░░░░▓▒░▓▓▒▒▓▓▓▒▓▓▓▒▒▓▓▓░░▓▓▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░▒▒▒▓▓▓▓
        ░▓▒░▒░▒▓▒▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▒▓▓▒░▓▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓░▒░░░░▒░░░▒░░░░░░░░▒▒░▓▓▓▓▓
        ▓▓░▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▓▓▒▓░▓▒▓▓▓▓▒▓▒▒▒▒▒▒░░▒▒▒▒▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▒░▓░░░░░░░░░░░░░░░░▒▒░▓▓▓▓▓▓
        ░▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▓░▒▒▓▓▓▓▓▓▒▓░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▓▓▓▓▓▓▓▓▒▓▓▒▒▒▓▒▒▒░░░░░░░░░░░░▒▒▒▓▓▓▓▓▓▓
        ▓▓▓▒▒░▒▒▒▒▒▒░▒▒▒▒▒░░▒▒▓▓▓▓▓▓▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▓▒░▓▓▒▓▓▓▒▓▒▓░░▓░▒▒▒▒░░▒▒░░░░▒▒▒▒▓▓▓▓▒▓▓▓▓
        ░░░░░░░▒▒░▒▒▒░▒▒░░░▓▒▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▒▓▓▓▒░▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▓▒▒▒▒▒▒
        ░░░░░░░░░░▓░▒░▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒░▒▒
        ░░░░░░░░░░░░▒░▒▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▓▓▓
        ░░░░░░░░░░░░░░▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓░░▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓░▓▓▓▓▓▓
        ▒░░░▒░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓░▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓
        ░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒░░░▓▓▓▓▓▓▓▓▒▒▒▒░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒░▒▓░▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓░░░░░▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▓▒░▒░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓
        ░░░░░░░░░░░░░▓▒▒▒▒▒▒▒▒▒▒▓▓▒░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▓▓▒▓▒▒▓▒▒▒▒░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓
        ░░░░░░░░░░░░▓░▒▒▒▒▒▒▓▓▓░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒░▒░░▓▒░▓░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▓▓
        ░░░░░░░░░░▓▒░▒▒▓▓▓▓▒░░░░░░░░░░░░░▒▒▒▒▒░░▓▒░░░▒▒▒░▒░▓▓▓▓▓▓▒▒░▒▒▒▓░░░░▒▒░▒░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▒▒
        ░░░░░░░▒▓▒▒░▓▓▓▓░░░░░░░░░░░░░░▒▒▒░▒▒░▒▒▒▒░▒▒▒░▒▒▒▒▒░░▓░░▒▒▒░▒▒▓▓░░░░▒▒▒░░▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒░░░▓▓░░░░░░░░░░░░░░░░░░░▒▒░▒▒░░▒▒▒▒░▒▒░▒▒▒░░▒▒▒▒▒▒▒▒▒▓▓░░░░░▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒░░░░░░▒▒░░░░░░░░░░░▓▓▒▒▒░▒▒▒▒▒░▒▒▒▒▒░▒▒░▒░░▒░▒▒▒▒▒░░▒░░▒▒▒▓▓▓░░░░░▒░▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒░▒▒▒▒▒▒▒
        ▓▓▓▓▓▒░░░░░░░░░░░░░▓▓▓▓▒▓▒▒▒░▒░▒▒░▒▒░░▒▒▒▒░▒▒▒▒▒▒▒▒░▒▒▒░▒▒▒▓▓▓░░░░▓▓░▒░▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▒▒▒▒░░▒▒▒▒▒▓▓▓
        ▒▒▒░░░░░░░░░░░▓▓▓▓▓▓▓▓░▓▓░▒▒▒▒▒░▒▒▒▒▒░▒▒▒▒▒░▒▒▒░▒░░▒░▒▒▒▒▒▓▓▓▓▓▒▒▓▓▓░▓▓▓▓▓▓▒░▓▓▓▓▓▓▓▓▒▒▒░░▒▒▒▓▓▓▓▓▓▓
        ░░░░░░░░░░░▓▓▓▓▓▓▒░▓▓▓▓▓▓▓▒▒▒░▒▒░▒▒▒▒░▒░▒░░▒░▒░▒░░▒░▓▓▒▒▒▓▓▓▓▓▒▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▒░░░░▒▓▓▓▓▓▓▓▒▒
        ░░░░░░░▒▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░▒▒▒░▒░░▒▒░▒▒░▒▒▒░░▒▓▓▓▒▒▒▓▓▓▓▓▓▒▒▒▒▓▓▒░▒▓▓▓▓▓▓▓▓▒▒▓▓▓▒░░░░░▒▓▓▓▒▒▒▒▒▒
        ░░░░░▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░▒▒▒░░░░▒░░▒▒▒▒▒░░▓▓▓░▒▒▒▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓░▒▒▓▓▓▓▓▓░░░░░░░░░▒▒▒▒▒▒▒▒▒▒
        ░░░░▒▒▓▓▒░▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒░░░░░░░░░░░░░░░░░▒░▒░░▓▓▓▒▒▒▒▓▓▓▓▓░▒░░░░▒▒▓▓▓▓▓▓▓▓▒▒▒▒░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒
        ░░░▒░▒▒▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░▒▒░▓▓▓▓▒▒▒▓▓▓▓▓░░░░░░░░░▒▒▒▓▓▒▓▒▒▒▒▒░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒
        ▒▒▒░▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓░▒▒▒▓▒▒▒▒░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░▒▒▒▒▒░░░░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓░░░░░░░▒▓▒▓▓▓▒░░▒░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░▒░░░░░░░
        ▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒░▒▒▒▒▒▒▒▒░▒▒▓▓▓▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░
        ▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░
    ";
    Migi = "░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒░▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒░▒░░▒░▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░▒▒░▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒░▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▓▓▓▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒
        ░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒
        ░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒
        ░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒▓▒▒▒▒▒▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒
        ░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒░▒▒▓▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░
        ░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░
        ░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░
        ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░
        ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░
        ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░
        ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░░░░░░░░░░░░░
        ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒░░░░░░░░░░░░░
        ░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░
        ";
    Neferpitou = "
        ▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▒▓▓▓▓▒▓▒▒▓▒▒▒▓▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▓▓▒▒▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒
        ░░░░░░░░░░░▒▒░▒▒▒▓▒▓▓▓▒▓▓▓▒▓▒▒▒▓▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▓▓▒▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ░░░░░░░░░░░░░░░▒▓▒▓▓▓▓▒▓▓▓▓▓▒▓▓▒▒▒▒▓▓▒▒▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▓▓▒▓▓▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒
        ░░░░░░░░░░░░░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▒▒▒▓▓▒▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▒
        ░░░░░░░░░░▒▒▒▒▒▒▒▓▓▓▓▓▒▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▒▒▓▒▒▒▒▓▒▒▒▒▒▒▒▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▒▒
        ░░░░░░░▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▒▒▒▒▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒
        ░░░▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▓▒▒▒▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒▓▓▒▓▒▒▓▓▓▓▓▓▓▒▒▓▓▓▓▓▒▒▒
        ░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒
        ░▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▒
        ▒▒▒▒▒▒▒▒▒▓▒▒▓▒▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒▓▓▓▓▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▒
        ▒▒▒▓▒▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▓▓▒
        ▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▒▒▓▓▒▓▒▒▓▓▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▒▓▒▒▒▓▓▒▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▒▓▓▓▓▓▓▒▓▓▒▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▒
        ▒▒▒▒▒▒▒▒▒▓▓▒▓▓▒▓▓▓▓▓▒▓▒▓▓▓▒▓▓▒▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▒
        ▒▒▒▒▒▒▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▓▓▒▓▓▓▓▓▓▓▓▓▓▒
        ▒▒▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▓▓▓▒▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▓▓▓▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒
        ▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▒▒▒▓▓▓▓▓▒
        ░░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ░░░▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ░░▓▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▒▒▒▒▒▒▓▓▓▓▓▒▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▓▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒
        ▒▓▓▒▒▒▒▒▒▒▒▒░▒▒▒▒▒░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒▓▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒░
        ▒▒▓▒▒▒▒▓▒▒▒▓░▓▓▓▒░░░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒
        ▒▒▓▒▒▒▓▒▒▒▒▓▒▓▓▓░▒▒░░▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▓▓▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▒▓▓▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒░░░▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▒▒▒▒▒▒▒▒▓▒▓▓▒▒▒▒░░░▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▓▓▓▒▓▓▓▓▓▓▓▒▒
        ▒▒▒▒▒▓▓▓▓▓▒▓▒▓▓▓▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▓▓▓▒▒▒▒▓▓▓▒
        ▒▒▒▓▒▒▒▓▓▒▒▓▓▒▓▓▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒░░▒░░░░░▒░▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▒▒▒▒▒▒▒▒
        ▒▓▓▒▒▒▒▓▒▓▒▓▓▓▒▓▓▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▒▒░▒▒▒▓▓▒░▒▒░░▒▒░▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▓▓▓▓▒▒▒▒▓▓▓▓▓▒▒▒▒▓▓▒▒▒▒▒▒▒
        ▒▓▒▒▒▒▒▓▓▒▓▓▓▓▓▓▒▒▒▒▓▓▓▒▒▓▓▒▒▒▒▒▒▓▓▒▓▓▓▓▓▓▓▒▒▒▒░░▒▒░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▓▓▒▒▒▒▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒
        ▒▓▒▒▒▒▓▒▓▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░▒▒▒▒▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▒▓▓▒░░░░░
        ▒▓▓▒▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▓▒▒▒▒▒▓▓▓▓▓▓▓▒▒▓▓▓▓▒░
        ▒▓▒▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒▓▓▓▓▓▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒░░░▒▒▒▓▓▓▓▓▒▒▓▓░░░░
        ▒▓▒▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▒▒▓▓▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒░░░░░░▒▒▒▒░░░░░░░░
        ▒▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▒▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒░░░░░░░░░░░░░░░░░
        ▒▓▓▒▒▒▒▒▒▒▒▒▒▓▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒░▒▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓░░░░░░░░░░░░░░░░░
        ░▓▓▓▒░▒▒▒▒▒▒▒▒▒▒░▒▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓░░░░░▒▒░░░░░░░░░░░░░░▓▒▒░░░░░░░░░░░░░░░░░
        ░▒▓▓▒▒░▒▒▒▒▒▒▒▒▒▒░░▒▓▓▓▒▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▒░░░░░░░░░▒░░░░░░░░░░░▒░░▒░░░░░░░░░░░░░░░░░
        ░░▓▓▓▒░▒▒▒▒▒▒▒▒▒▒▒░░░▒▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░
        ░░░▓▓▒▒░▒▒▒▒▒▒▒▒▒▒░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░▒▓▓▒░░▒▒▒▒▒▒▒▒░░░░░░░▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░▒▓▒▒░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░▒▓▒▒▒▒▒░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░▒▓▒░░░░▒▒░░░░░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▒░░░░░░░
        ░░░░░░░▒▓░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒░░
        ░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▓▓▓▓░
        ░░░░░░░░░░░░░░░▒░░░░▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒
        ░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒░░░░░░░░░░░░░░░▒▒▒░░░░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒
        ░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▓▓▓▓▓▒░░░▒▒░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▒
        ░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░▒▓▓▓▓▓▓▓▒▒▒▒▒░░░░▒▒▒▓▓▓▒
        ░░░░░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒
        ░░░░░▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒
        ░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒
        ░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▓▓▓▓▒
        ░░▒▓▓▒▒▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▓▓▓▓▓▓▓▒
        ░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒░░░░░░░▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒
        ░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒░░░░░░░░▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒░░░░░░░░░░░▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒░░░░░░▒▒▒░░░░▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒░▒▒░░▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒
        ▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒▒▒▒▒▒░░░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒░▒░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒
        ░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒░░░░░░░▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒░░░░░░░░░░░░▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒
        ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒░░░░░░░▒░░░▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒░
        ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░▒░▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
    ";  
    HancockBoa = "
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▓▓▓▓▒░░░▒░▒░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒░░░░▒░░░▒░░░▒▒░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒░░░▒▒▒▒▒▒▒░░▒▒▒▒░▒░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░▒░▒░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░▒░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▓▒▒▒▒▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▓▒▒▓▒▒▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▒▒▒▒▒▒▓▓▓▒▒▒▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▓░▒▒▒▒░░░▒▒▓▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▒▒▒▒▓▓▒▓▓▓▒▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▒░▒▒▒▒▒▒▓▒▒▒▒▒▒▒░░░░▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▒▒▒▓▒▓▒▒▒▓░▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▒░░▒▒▒▒▓▒▒▒▓▒▒░▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▒▓▒▒▒▒▒▓▒▓▓▓▓▓
        ▓▓▓▓▓▓▓░░░▒▒▒▒▒▒▒▒▓▒░░░░░░░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓
        ▓▓▓▓▓▓▓░░▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░▒▒▒▒▒▒░▒▒▒▓▓▓▓
        ▓▓▓▓▓▓▒░░▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░▒▒░▒▒░▓▓▓▓
        ▓▓▓▓▓▓░░░▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░▒▒░░░░░░░░░▒░▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░▒░░░░░▒▓▓▓
        ▓▓▓▓▓▓░░░▒▒▒▒░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▒▒▒▒▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░▒▓▓▓
        ▓▓▓▓▓▓░░░▒▒▒▒░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░▒░▒▒▓▓░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░▒░░░░░░░░░░░░░▓▓▓
        ▓▓▓▓▓▒░░░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░░░░░▒░░░▒▒▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓░░▒▓▓▒▓▓▓▒▓▓░░░░░░░░░░░░░▓▓▓
        ▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▒░░░░▒░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒░░▒▒▒▒░▓▓▓░░░░░░░░░░░░░▓▓▓
        ▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░▓▓▓▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒░░░░░░░▒░░░░░░░░░░░░░░░▓▓▓
        ▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░▒▒░░▒▒▒░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░▒▒░▓▓▒░░░░░░░░░░░░░░░░░░▓▓▓
        ▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▒░░░░░░░░░▒░░░░░░░░░░░░░▓▓▓
        ▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓░░░░░▓▒░░░░░░░░░░░░░▓▓▓
        ▓▓▓▓▓░░░░░░░░░░░░░░░░░▓▓▒▓░░░░░░░░░░░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░▓▓▓
        ▓▓▓▓▓░░░░░░░░░░░░░░░░▒▓▒▒▒░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░▒▓▓▓
        ▓▓▓▓▓░░░░░░░░░░░░░░░░▒▓▒▓▓▒░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░▒▓▓▓
        ▓▓▓▓▓░░░░░░░░░░░░░░░░░▓▒▒▒░░░░░░░░░░░░░░░░▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓░▒▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░▓▓▓▓
        ▓▓▓▓▓░░░░░░░░░░░░░░░░░▒▓▓▓▒░░░░░░░░░░░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░▒▓▓▓▓
        ▓▓▓▓▓░░░░░░░░░░░░░░░░░░▒▓▒▒▒▒░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░▓▓▓▓▓
        ▓▓▓▓▒░░░░░░░░░░░░░░░░░░░▓▓░▒▒▒░░░░░░░░░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░▓▓▓▓▓
        ▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░▒▓▒░░▒░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░░░▒▓▓▓▓▓
        ▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░▒░▒▓▓░░░░░░░░░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▒░▓▓▓▓▓▓▓░░░░░░░░░░░░░░▓▓▓▓▓▓
        ▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░▓░░░▒▓▓░▒▒▒▓▓▓░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒░░░░░░░░░░░░▒▓▓▓▓▓▓
        ▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░▒░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░▒▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░▒▒▒▒▓▓▓▓▓▓
        ▓▓▓▓░░░░░░░░░░░░░░░░░░░░░▒▒░░░░░░░░░░░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░▒▒▒▒▓▒▓▓▓▓▓
        ▓▓▓▒░░░░░░░░░░░░░░░░░░░░░▒▒▒░░░░░░░░░░░░▒▒░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░▒▓▒░░░░░░▒▒▒▒▓▓▓▓
        ▓▓▓▒░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░▒▒▒▒▒▒▒░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░▓▓▓▓▒░░░░▒▒▒▓▓▓▓▓
        ▓▓▓░░░░░░░░░░░░░░░░░░░░░░▒▒░░░░░░░░░░░░▒▒▒▒▒▒▒▒░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░▒▒▓▓▓▓▒░░▒▒▒▓▓▓▓▓▓▓
        ▓▓▓░░░░░░░░░░░░░░░░░░░░░▒▒▒░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒░░░░▒▓▓▓▓▓▒░░▒▓▓▓▓▓▓▓▓▓
        ▓▓▓░░░░░░░░░░░░░░░░░░░░░▒▒▒░░░░░░░░▒▒▒░▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░▒░░░▒░▓▓▓▓▓▒░▒▒▓▓▓▓▓▓▓▓▓
        ▓▓▒░░░░░░░░░░░░░░░░░░░░░▒▒▒░░░░░░░░▒░▒░░▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▓▓▓▓▓░▒░░░░▒░░▒▒▒▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓
        ▓▓░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░░░░░░░▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▓░░░░▒░░▒▒▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓
        ▓▓░░░░░░░░░░░░░░░░░░░░░░▒▒▓░░░░░░░░▒▒▒▒▒▓▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓░░░░▒░░░░░░░▒▒▓▓▓▓▓▓▓▒▒▓▒▓▓▓▓▓▓▓▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░░░░░░░▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓░░░░░░░░░░░░▒▒▒▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░░░░░░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▒░░░░░░░░░░░▒▓▒▓▓▓▓▓▓▒▒░▒▓▓▓▓▓▓▓▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░░░░░░▒▒▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▒░░░░░░░░░░░▓▒▒▓▓▓▓▓▓▒▒░▓▒▓▓▓▓▓▓▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▓░░░░░░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░▒▓▓▒▓▓▓▓▓▒▓▒▓▒▓▓▓▓▓▓▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▒░░░░▒▒▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░▓▓▓▒▓▓▓░▒▒▒▒▒▓▓▓▓▓▓▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▒▒▒▒▒▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░▒▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░▒▒▒▒░░░▓▓▓▓▓▓▓▓▓▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒░▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒░▒▒▓▓▒░░▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓░░░░░░░░░░▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓
        ▓░░░░░░░▓▓▓▓▓▓▓▓▓▒░▒▒▒▒▒░▒▒▒░▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▓▓▓▓▓▒▒▓▓
        ▓░░░░░░▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▒▒░▒▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓░▒▓▓▓▓▓▒▓▓
        ▓▒▒░░░░▒▒▒▒▒▒▒░░▒▓▓▓▓▓▓▓▒▒▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▒▒▒▒▒▒▒▓▓▓░▒▒▒▓▓▓▓░▓
        ▓▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒░░░▒▒▒▒▓▓▓░░▒▒▒▒▓▓▓
        ▓░▒▒▒▒▒▒░░░▒▒▒▒▒░▒▒▓▓▓▓▓▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▒▒▒▒▒▓▓▓░▒░▒▒▒▓
        ▓▒▒▒░░░░░░▒▒▒▒▒▒░░▒▓▓▓▓▓▓░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓░░░░▓
        ▓▒▒░░░░░▒▒▒▒▒▒▒░░░░▓▓▓▓▓▓░▒▒▓▓▓▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒░▒▒▒▓▓▓▓▒▒▓
        ▓░░░░░▒▒▒▒▒▒▒▒░░░░▒▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒░▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░▒▓▒▒▒▒▒▓▓▓▓▓
        ▓▒░▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▒▓▓▓▓▓▒▒▒▒░▒▒▓▓▓
        ▓▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒░░░▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒░░░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓
        ▓▒▒▒▒░░░░░░▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓
        ▓▒▒░░░░░░░░▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓░░░░░░░░░░░░░░░▒▒▒▒░░░▒▒▓▒▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓░░░░░░░░░░░░▒▒▒▒░░▒▒▒▒▒▒▒▓▓▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▓▒▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓░░░░░░░░░░░░░░░▒▒▒▒▒░░▒▒▒▒▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
    ";  
    JeanKirstein = 
        "▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓░░░░░░░░░░░░░░░░░░▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░▒▓▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░▒▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░▒▓▒░▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░▒░░░▓▒▒▒▒▒▒▒▒▒▓▒▒▓▒▓▒▒▒▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░▒▓▒▒▒▒▒▓▒▓▓▒▒▒▒▓▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒░▒▒▒▒▒▒▒▒▓
        ▓░░░░▒▓▒▓▓▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▓
        ▓▒░░▒▓▓▓▓▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▓
        ▓▓▓▒▓▓▓▓▒▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒░▒░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▓
        ▓▓▒▓▓▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒░▒▒░▒░▒░▒▒▒▒░░░░░░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▓
        ▓▓▒▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░░▒▒░▒▒░░▒▒▒▒▒▒░░▒░▒▒░▒▒░░░▒▒▒░░░░░░░▒▒▒░▒░▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▓
        ▓▒▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒░▒░▒░▒░▒▒▒░▒░░▒▒▒▒░░░░░▒░▒▒▓▒░░▒▒░▒░▒░▒▒░▒▒░░▒░▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒▓
        ▓▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒░▒▒░░▒░▒░▒▒▒▒▒░▒░░░▒▒▒░░░░▒▒░▒▒▓▓░▒░▒▒▒░▒▒░▒▓░▒░▒░░░▒▒░▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▓
        ▓▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒░▒░▒░░▒▓▒░▒▒▒░▒▒▒░░░▒▒▒░░░▒▒▒▒▓▓▓▒▒▒░▒▒▒▒▓▒▓▒▒▒▒▒▒▒▒░▒░▒▒▒▒▒▒▒░░░░▒░▒▒▒▒▒▓
        ▓▒▒▒▓▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒░▒░▒░░▒▒▒░░▓▓▒░▓▒▒░▒▓▒░▒░▒▒░░▒░▓░▒▒▓▓▓▓▒▓▒▒▒▒▒▓▓▓▒▓▒▒▒▒▓░▒░▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▓
        ▓▓▒▓▓▓▒▒▒▒▒▒▒▒░░▒▒░▒▒░▒░░▒░░▒▓░▒▓▓▒▒▓▒▒▒▒▓▓░▓▒░▒░▒▒░▓░▒▓▓▓▓▓▒▓▓▒▒▒▒▓▓▓▓▓▓▒▒▒▓▒▓▒░▒░▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▓
        ▓▓▒▓▓▓▒▒▒▒▒▒▒▒▒░▒▒░▒▒▒▓░░▓░▒▓▓░▒▓▓▓▒▓▒▒▒▒▓▓▒▒▒▓░░▒▓▒▓▒▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▒▒▒░▒▒▒▒▒░░▒▒▒▒▒▒▒▒▓
        ▓▓▒▓▒▓▒▒▒▒▒▒▒▒░▒▒▒░▒░▒▓▒▒▓░▓▓▓▒▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▒░▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒░░▒▒░░░░░▒▒▒▒▒▒░▓
        ▓▒▒▒▒▓▒▒▒▒▒▒▒▒░▒▒░░▒░▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒░░▒▒░░▒░░▒▒▒▒▒░▒▓
        ▓▒▒▒░▓▒▒▒▒▒░▒▒░▒▓▒░▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒░░░░░░▒▒░▒▒▒▒░▒▓▓
        ▓▒▒▒░▓▒▒▒▒▒▒░▒░▒▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░▒▒▒▓▓▓░░░░░░░░▒▒▒▒▒▒░▓▓▓
        ▓▒▒▒▒▓▒▒▒▒▒▒░▒░░▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░▒▓▓▓▓▓▓▓▓▓▓▒░░░░░▒░▒▒▒▒▒░░▓▓▓
        ▓▒▒▒▒▒░▒▒▒▒▒░▒░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒▓▓▓▓▓▒░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░▒▒▒▒▒▒▒▒░▒▓▓▓
        ▓▒▒▒▒░░░▒░░▒▒░▒▒▒▓▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▓▓▓▓▓▓▒░░░░░░░░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒░░░▒▒▒▒▒▒▒▒░▒▓▓▓
        ▓░▒▒▒▒░▒░░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░░░░░░░░░░░░░▒▒▒▓▓▓▓▓▓▒░░░░░▒▓▒▒░░░░░░░░░▒▒░▒▓▓▓▓▒▒▒░░▒░░▒▒▒▒▒▒░▒▓▓▓
        ▓░░░░░░░░░▒░▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▓▒░▒▓▓▓▓▓▓▓▒▒▒▓░▒▓▓▓▓▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▓▓▓
        ▓░░░░░░░░░░░▒▒▒▓▓▓▓▓▓▓▓▓▒▒░░░░▒▒▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒▓▓▓░▒▒▒▒▒▓▓▒▒▒▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▒▒▒▒░░▒▒▒▒░▒▒▒▒▒▒▓▓▓
        ▓░░░░░░░░░░░▒▒▒▓▓▓▓▓▓▓▓▒░▒▓▓▓▓▓▓▓▓▓▒▒▒▒▓▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒░▒▒░▒▒░▒▒▒▒▒░▓▓▓
        ▓░░░░░░░░░▓▒░▒▒▓▓▓▓▓▓▓▓▓▓▒▒░▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▓▓
        ▓░░░░░░░░▒▓▓▓▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░▒░░▒▒▒▒▒▒▒▒▒▒░▓▓
        ▓░░░░░░░░▒░▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒░░░░▒▒▒▒░▒▒▒▒▒▒▒▓
        ▓░░░░░░░░▒▒▒▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▓▒▓
        ▓░░░░░░░░▒▒▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▓░▓
        ▓░░░░░░░░▒▒▒▓░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒░▓
        ▓░░░░░░░░▒▓▓▓░░▒▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓
        ▓░░░░░░░░░▒▓▓▒░░▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▓
        ▓░░░░░░░░░░░▓▓▒░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▓
        ▓░░░░░░░░░░░░░▓▓▒░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░▒▓▓▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▓
        ▓░░░░░░░░░░░░░░░░▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒░▒░░▒▒▒▒░▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒░▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░▒░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░░░░░░░░░░░░░░░▒░░░░░░░▒░░░▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░▓▒▒▒▒░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░░░░░░░░░░░░░░░▒░░░░░░░▒▒░░▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░▒▓▒▒▒▒░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░░░▒░░░░░░░░░░░░▒░░░░░░░▒▒░░▓
        ▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▒▒▒▒▓▓▒▒▒▒▒░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░░░░▒▒░▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▒▒░░░░░▓▓▓▒▒▒▒▒░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░░░▒▒▒▒░░░░▒▒▒▒▒░░░▒▒▒▒▒░░▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒░▒▒▒▒░░░░▒▒▒▒▒░▓▓▓▓▓▒▒▒▒▒▒░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░░░▒▒▒▒▒░▒▒▒░░░▒░▒▒▒▒▒▒▒░░░░░▒░░░▓
        ▓▒▒▒▒▒▒▒▒░▓▒▒▒░░░░▒▒▒░▒▒▒░▓▓▓▓▓▓▒▒▒▒▒▒░░░░░░░░░▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒░░▒▒░▒▓
        ▓▒▒▒▒▒▒▒▒▒▓▒░░░░░░▒▒▒▒▒▒░░▒▓▓▓▓▒▓▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒░░▒░░▒▒▒▒▒░░▒▓
        ▓▒▒▒▒▒▒▒▒░▓▒▒▒░░░░▒▒▒▒▒▒▒▒▒░▒▓▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒░░▒░░░▒░░░░░░░░▒▓
        ▓▒▒▒▒▒▒▒▒░▓▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒░░░▒░░░░░░░░░░░░▒▓
        ▓▒▒▒▒▒▒▒▒░▓▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒░░░░░░░░▒▓
        ▓▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒░▓▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓░▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░▓
        ▓▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒░▒░▒▓▓▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓░▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░▓
        ▓▒▒▒▒▒▒░▓▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒░▒▒▒▒▒▒▒▒▓▓▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓░▒▒░▒▒▒░░░░░░░░░░░░░░░░░░░▓
        ▓▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒░▒▒▒▒▒▒▒▒▓▓▓▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒░▒▒▒▒░░░░░░░░░░░░░░░░░░░░▓
        ▓▒▒▒▒▒░▓▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒░▒▒▒▒▒▒▒▒▒▓▓▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░▓
        ▓▒▒▒▒░▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒░▒▒▒▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒░▒▒░░░░░░░░░░░░░░░░░░░░░▓
        ▓░░▒▓░▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▓▓▓▓▓▒▒▒▒▒░░░░░░░▒░░░░░░░░░░░░░▓
        ▓▒▒▒▒░▓▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▓▓▓▓▓▓▓░▒▒▒▒░░░░░░░░░░░░░░░░░░░░▓
        ▓▒▒░░░▓▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▒▒▓▓▒▓▓▓▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░▓
        ▓▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▒▓▓▓▒▓▓▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░▓
        ▓░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▓▓▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░▓
        ▓░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
    "; 
    Franky = "
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░▒▒▒▓▓▓▓▓▓▓▓▒▒▒░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▓▒▒▒▒▒▒▒▒▒░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒░▒▒▒░░░░░░░░▒▒▒▒░░░░░▒▒░░▒░▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▓▒▓░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒░░░░░░░▒▒▒▒▒▒▒▒▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▓░▓░▓▒▓░▒▒▒▒▒▒▒▒▒▒░▒▒▒▒░▒▒▒▒▒░▒▒▒░░░░░░░░░░░░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒▓▓▓░▒▓░▒▒▒▒▒▒▒▒░▒▒▒▒░▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░▒▒▒░▓▒▒░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒░░░░▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▓▓▓▓▓░▓▒▒▓▒▒▒▒▒░▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒░▒▒▒▒░░░▒░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▓▓▓▓▓▓▓▓▓░▓▒▓▒▒▒▒▒░▓▓▓▓▓▒▓▓▓▒░░▒▒▒▒░▒▒▒▒▒▒▒▒▒▒░▒▒░▒▒▒▒▒▒▒▒░░▒▓▒░░▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒░▒▒░▓▓▓▓▓▓▓▒▒▒░▓▓▓▓▓▓▓▒▒░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓░░▒▒░▓▓▓▓▓▓▓▓▒▒░▒▓▓▓▓▒▒▓▓▓▒░░▒▒▒▒▒░▒░▒▒▒▒▒▒▒▒▒▒▒░▒▒░▒░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓░░▒▒░▓▓▓▓▓▓▓▓▓▓░░░▓▓▓▓▓▓▓▓▓▓▒░░▒▒▒░░▒░▒▒▒▒▒▒▒░▒▒▒▒▒░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░▒▒▒░▒▓▒▓▒▓▓▓▓▓▓▓▓▒░▒▓▓▓▓▓▓▓▒░▒░▒▒▒▒▒▒▒▒▒░▒▒▒░▒▒▒▒▒▒▒▒░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▓▒░▒▒▒░▒▓▓▒░▒▒▒▓▓▓▓▓▓▒▓▒░░░░░░░▒▒░▒▒▒▒▒▒░▒▒▒▒░░░▒▒▒▒▒▒▒░░▒▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒░▒▒▒▒▒▓▓▓░▒░▒░▒▓▓▓▓▓▒▒▒▒▒▒▒░▒▒▒▒░▒▒▒▒░░▒▒░▒░▒▒▒░▒▒▒▒▒▒░░▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓░░▒░▒▒░▓▓▓▒▒▒░▒▓▓▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒░░▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓░░▒▒▒▒▒▒▓▓▓░▒▓▓▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒░▒▓▓▓░░░░░░░░░░░░▒▒▒░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▓▓▓▓░▒░▒▒▒▒▒▓▓▓▓░▒▓▓▓▓░▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▓▓▓▓▒░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓░▒▒▒▒▒▒░▓▓▓▓▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▓▓▓▒▒░▒░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▒▒▓▓░▓▓▓▓▓▒▓░▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░░░░▓▓▒▒▒▒░░▒▒▒▒▒░░░░░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▒░▒▒▓▓▓▒▒▒▒░▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒░▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▓▒▒▒▒░░░▒▒▒▒░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▒▓▓▓▒▒▓▒▒▓▒▒▒▒▒░▒▒▒▒░▒▒▓▓▓▓▓▓▓░░░░░░▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒░░▒░▓▒░░░░░░▒▒▒░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▒▓▒▒▒▓▒▒▒▒▒▒▒▒░░▒▒░▒▒▒▒▓▓▓▓▓▒▓▒░░░░░░░░░▒▒▓▓▓▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▒░▒▒▒▓▒▒▒▒▒▒░░░░░▒▒▒▒▒▓▓▓▓▒▓▒▒▒░▒░▒▒▒▒▒▒▒░░░▒▓▓▒░▒▒▒▒▒▒░░░░░░░░░░░░░░░░░▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▒▒▒▒▒▒▒▒▒▒▒░▒░░░░▒▒▒▒░▓▓▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒░░░▒▓▓▒░▒▒▒▒▒░░░░░░░░░░░░░░░▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓
        ▓▒▒▒▒▒▒▒▒▒▒░▒▒▒░░░▒▒▒▒▒▓▓▒▒▒▒▒░▒▒▒░▒▒▒░▒▒▒▒▒▒▒▒▒░░░▒▓▓▒▒░▒░░░░░░░░░░░░░░▒▒▒░▓▓▓▓▓▓▓▓▓▓░▓▓▓▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░░░▒░▓▓▒▒▒▒▒▒▒░▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒░░░░░░░░░▒░▒▒░▒░▓▓▓▓▓▓▓▓░▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒░░▒▒░▓▓▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒░░░░▒░░░▒▒░▒▒▒▓▓▓▓▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒░▓▓▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒░░░░░░░▒░░░░░▒░░░▒▒▒▒▒▒▒▓▓▓▓░▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒░▒▒▒░▒▒▒▒▒▒▒░░▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒░▒▓▓▓▓▒░▒▒░░░░░░░░░░░▒▒░░▒▒▒▒▒▒▒░▓▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒░░░▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░▒▒▒▒░▒▒▒▒▒░▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░▒░░░░▒▒▒▒▒▒▒▒▒░▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░▒░░░░░░░░░░░▒░░░░░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▓
        ▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░▒▒▒▒▒▒░▒░▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒░░░░░░░░░░░░░░░▒▒▒▒▒▒▒░▒░▒▒▒▒▒▒▒▒▒▒░▒▒▒▒░░░░░▒▒▒▒▒▓
        ▓▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░░░░░░▒▒▒▒▒▒▒░░░▒▒▒▒▒▒░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒░░░░░▒▒▓
        ▓▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░▒▒▒▒░░░░░▒▒▒▒▒▒░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░░░░░▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░▒▒▒▒▒░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▓
        ▓▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░▒▒▒░░░░░░░░░░░░░░░▒░░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒░░░░░▒▒▒▒░░░░░░░░░▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░▒░▒▒▒▒░░░░░░░░░░░░▒▒▒▒▒▒▒▒░░░░░░░░░░░░▓
        ▓▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░▒▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▒▒░░░░░░▒░░░░░░░░░▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▓▓▒▒▒░░░░░░░░▓
        ▓▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░▒░░░░░░░░░░░▒░▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒░░░▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▒░░▒░░▒▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒░▒▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓
        ▓▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░░▒░░░▒▒▒▓▓▓▓▓▓▓▓▒▒░░░░░▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▓▓▓▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▓▓▒▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░▒░░░▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▓▓▓▓▓▓▓▒░▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒░░░░░░░▒▒▒▒▒▒▓
        ▓▓▓▓▓▓▒▒▓▓▓▓▓▓▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒░░░░░▒▒▓
        ▓▓▓▓▓▓▓▒▓▒▒▒▒▓▓▓▓▓▓▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓░▒▒▒░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒░░░▓
        ▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓░▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒░▒▒▒▒▒▒▒▒▒▒▒░▒░▒▒▒░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒░▒▒▒░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▓
        ▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒░▒░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒░░░▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▓▒▒▓▒▓▓▓▓▓▒▓▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒░▒▓▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓░▓▒▒░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
    ";
    HatsuneMiku = "
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▒▒▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▓▒▒▒▒▒▓▓▓▒▒▓▓▒▒▓▓▓▓▒▒▒▒▒▓▒▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒▓▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▒▓▓▓▒▓▓▓▓▓▓▒▓▓▓▒▒▓▓▓▓▓▓▒▒▓▓▓▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒▓▓▓▒▒▒▓▒▒▒▒▓▒▓▓▒▓▒▓▒▓▓▒▒▒▒▒▓▓▓▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▒▓▒▒▓▓▒▓▒▒▒▒▒▓▒▒▓▒▒▓▒▒▒▒▒▒▒▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▓▒▒▒▒▓▒░▒▒▒▓▒▒▒▒▒▒▒▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▓▓▓▓▓▓▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▒▒▒▒▒▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▓▓▓▒▒▒▓▓▓▓▓▒▓▓▓▓▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▓▓▒▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒░░▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▓▒▒▓▒▒░░▒▒▓▒▒▒▓▓▒▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▓▓▓▒▒▒▒▓▓▓▒▒▒▓▓▒▓▓▓▒▒▒▒▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▓▓▓▒▒▒▒▓▓▓▒▒▓▓▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▓▒▒▓▒▒▒▒▒▓▒▒▒▒▓▓▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒░▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒░▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▓▒░▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▓▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒░▒▒░▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒░░▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒░░▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒░▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▓▓▓▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒░░░▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▓▓▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▓▒▒▓▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▓▓▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒▓▓▓▓▓▓▒▒▓▓▓▒▒▒▒▒▒▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▓▓▓▒▒▓▓▓▓▓▓▓▓▒▒▓▓▓▒▒▓▓▓▓▓▓▒▒▓▓▓▓▒▒▒▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▓▒▒▒▒▓▓▓▓▓▓▓▓▒▒▓▓▓▒▒▓▓▓▓▓▓▓▓▒▒▓▓▓▒▒▒▓▓▓▓▓▒▓▓▓▓▓▒▒▒▒▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▓▓▒▒▒▓▓▓▓▓▓▒▒▒▓▓▓▒▒▓▓▓▓▓▓▓▓▒▒▒▓▓▒▒▒▓▓▓▓▒▓▓▓▓▓▓▒▒▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
    ";
    JonathanJoestar = "
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░▒▒▒▒░░░░░░░░░░░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒░░░░▒▒▒▒▒░░░░░░░▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▒▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒░░░░▒▒░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░▒▒░░▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░▒▒▒░░▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒░▓
        ▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▓
        ▓▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▓
        ▓▒▒░░░▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░▒▒▒▒▒▓▓▓▓▓▒▒▒▒░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒░▒▒▓
        ▓░▒▒▒▒░▓▓▓▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░▒░░░▓▓▓▓▓▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒░▒▓
        ▓░░▓▓▓▓▓▓▓▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒░▒░▒▓
        ▓▒▒░░░▒▓▓▓▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒░▒▒▓
        ▓░░░▒▒▒▒▓▓▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░▒▒▒▒▓
        ▓░░░░░▓▓▒▓▒▒▒░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░▒▒▒▒▒░▒▒▒▓
        ▓░░░▒▒░▓▓▓▒▒░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░▒▒▒▒▒▒▒░▒▒▒▒▓
        ▓░░░▒▒▒▒▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒░▒▒░▒▒▒▓
        ▓▒▒░▒▒▒▒▓▓▒░░░░░░░░░░░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒░▒░░░░░░░░░░░░░░░░░░░░░▒░▒▒▒▒▒░░░▒░░░░▓
        ▓░░░░░░▓▓▓▒░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒░░░░░░░░░▒░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒░░░░░░░░░░░░░░░▒▒▒▒▒░░░░░░░░▓
        ▓▒▒░▒▒▒▓▓▓▒░░░▒▓▓▓▓▒▒░░░░░░░░░░░░░░░░░░▒▒▒░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░▒▒░░▒▒▒▒▒░░░░░░░░░▓
        ▓▒▒▒▒░░░▓▒▒▒░░▓▓▒▒▒▓▒▒░░░░░░░░░░░▒▒▒▒▒░░░░░░▒░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒░░░░░░▒▒▒▒▒▒▒▒▒░░░░░░░░░░▓
        ▓▒▒▒▒▒▒▒░▒▒▒▒░▒▒▓▓▒▒▒▒░░░░░▒░░░▒▓▓░░░▒▒░░▒░░▒░░░░░░░░░░░░▒▒▒▒▒▒▓▒▒▒▒▒░░░░░░░░░░░░░▒▒░░░░░░░░░░░░░░░▓
        ▓▒▒▒▒▒▒▒▒░▒▒▒░░▓▓▒▓▒▒▒░▒░░░░░▒▓▓▓░░░▒░▒▓▒▒▓▓▓▓▓▓▒░░░░░░░░░░▒▒▒▓▓▓▒▒▒░░░░░░▒▒▒░░░░▒░▒▒░░░░░░░░░░░░░░▓
        ▓▓▓░░▒▒▒▒▒░▒░░░▓▓▒▒▒▒▒▒░░░░░▒▓▓▓▓▒░▒▓▓▓▓▒▒▒▓▓▓▓▓▒▒▒░░░░░░░░░░▒▓▓▒▒▒░░░░░░░▒▒▒▒░░▒▒░░░░░░░░░░░░░░░░░▓
        ▓▒░▒▒░░░▒▒░░░░░▓▓▒▒▒▒▒▒▒░░░▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░░░░░░░░░░▒░░░░░░░▓▒▒▒▒░░░░░░░░░░▒▒░░▒▒░░░░░░░░░░░░░░░░░▓
        ▓░▒▒▒▒▒░▒▒▒░░░░░▓▒▒▒▒▒▒▒▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░▒░▒░░░▒▒░░▒░▒░▒▒▒▒▒▓▒▒▒▒░░▒░░░▒▒░▒▓░▒▒░░░░░░░░░░░░░░░░░░▓
        ▓░░▒▒▒▒▒░▒▒▒░░░░░░▓▓▓▒▒▒▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▒▒▒▒▓▓▒▒░▒▒▒▒▒▒▒▓▓▒▒▒▒▒░░▒▒▒▓▒▒▒▓▒▒░░░░░░░░░░░░░░░░░░░▓
        ▓▒▒▒▒░░░▒▒▒░░░░░░░▒▒▒▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░▒▒▒░░░▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒░░▒░░░░▒▓▒▒░░░░░░░░░░░░░░░░░░░░▓
        ▓▒▒▒▒░▒▒▒▒▒░░░░░░░▒▒▒░▓▓▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░▓
        ▓▒░░░▒░▒▒░▒▒░▒░░░░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▒▒▒▒░▒▒░░▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░▓
        ▓░░▒▒▒▒░▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▒▒░░▒░░▒░░░▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▒▒░░░░░░░░░░░▒▒░▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▒▒░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒░▒░░▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▒▒░░░░░░░░░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▒░░░░░░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒░▒░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒▒▒▒▒▒▒▒▒░░░▒▒░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒░░▒▒▒▒▒▒▒░░░░░░▒▒░░░░░░░░░░░░░░░░░░░░░▓
        ▓▒▒▒▒▒▒▒░▒░▒▒▒░▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒▒▒▒░░░░░░░░░░░░░░░░░░▓
        ▓▒▒▒▒▒▒░▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒░░░░░░░░░░░▒▒▒▒░░░░░░░░░░░░░░░░▓
        ▓▒▒▒▒▒▒░▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▒▒▒▒░░▒▒▒▒░▒▒░░░░░░░░░░▒▒▒▒▒▒░░░░░░░░░░░░░▓
        ▓▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░▒▒▒▒░▒▒▒▒░▒▒░░░░░░░░░░░░░▒▒▒▒▒░░░░░░░░░░░░▓
        ▓▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░▓
        ▓▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░▓
        ▓▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▒▒░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▓▓▓▒▒▒▒▒▒░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓░▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░░░▓
        ▓▒░▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▓
        ▓▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▓
        ▓▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▓
        ▓▒▒▒░░░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▓
        ▓▒▒▒▒░░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓
        ▓▒░░▒▒░▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒░░░░░░▒░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒░░▒▒▒▒▒░░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░░▒▒▒▒▒▒▒▒▒▒▒░▒▒░▒▒▒▒▒▒▒▒░▒▒░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░▒░▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▒▒▒▒▒▒▒░▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒░▒▒▒░░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒░▒░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░▒▒▒▒▒▒▒░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▒▒░░▒░▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒░▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░░▒▒▒▒▒░░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
    ";
    Totoro = "
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒▒▒▒▒▒░▒▒▒▒▒▒░░░░░░░░░░░░░░░░░▒▒▒▒▒░░░░░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒░▒▒▒▒▒▒░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒░▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒▒▓▓▓▓▒░░▒▓▓▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▓▓░░░▒▓▓▓▓▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒
        ░▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░▒▓▓▓▓▓░░░░▓▓▓░▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒▒▒▒▒▒▒▒▒▒▓▓▓░░░░▓▓▓▓▒▒▒▒▒▒░▓▓▓▓▓▓░░░▓▓▓▓▓▓▒
        ▒▒▒▒▒▒▒░░░░░░░░░░░░░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒░░░░▒▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░▒▒▒▒░▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒░░░▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▒▒
        ▒▒░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▒▒▒▒▒▒▒▒░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▒▒░░░░▒▒▒
        ▒▒▒▒▒▒░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒
        ▒▒▒▒▒▒▒░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▒
        ▒▒▒▒▒▒░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▒
        ▒▒▒░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒
        ▒▒░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒
        ░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▒
        ░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒
        ░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░░░░░░░░░░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░░░░░░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░░░░▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░░░▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░░▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒
        ░░░░░░▒▒▒▒▒▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▓▓▓▓▓▓▓▓▓▓▓▒▒░░▒▒▒
        ░░░░░░▒▒▒▒▒▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒░▒▒
        ░░░░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░▒▒
        ░░░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒
        ░░░▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒░▒
        ░░▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓░
        ░▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▒
        ▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░
        ▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒
        ▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒░▒▒░▓▒
        ▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒░▓▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▒░░░░░░▒
        ▒▒▒▒▒▒▒▒▒░░░░░░░░░▒░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒░▒▒▒▒▒
        ▒▒▒▒▒▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▓▓▒
        ▒▒▒▒▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░░▒▓▓▒
        ▒▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▓▒
        ▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▓▓▒
        ▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒
        ▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒░▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒░▒░▒▒▒▒░▒░▒▒▒▒▒░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒
        ▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░░░▒░░░▒▒░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒░░
        ▒▒▒▒░░░░░░▒▒▒░▒▒▒▒▒░▒░▒▒▒▒▒░░▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒░░░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒
        ░░▒▒▒░░░░░░▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒░▒▒▒░▒▒░▒▒▒░▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒░░░
        ░░░░▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒░
        ░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒░░░░░░▒▒░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒
        ░░░░░░░░░░░░░░░▒▒▒▒▒▒▒░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░░░░░░░░░▒▒▒▒▒░░░░░░░░░░░░░░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░░░░░░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒░▒░
    ";
    Pochita = "
        ▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ░▒▓▓▓▓▒░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ░░▒▓▓▓▓▒░░▒▓▓▓▓▓▓▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒░░░░░░░░░░░▒▒▒░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒░░░░░░░░░▒▒▒░▒▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ░░░▒░▒▒░▒▒▒▒░░░░░▒▒░░▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒░░░░░░░░░
        ▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▓▓▓▒▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒░▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░▒▒▒▒▒▒
        ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░▒▒░▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒░░▒▒▒▒▒▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒░░▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▓▒▒▒▓▒▓▒▒░░░▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▓▓▓▓░▒▒▒▒▒▒▒░
        ▓▒▓▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒
        ▒▓▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒
        ▒▒▓▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒
        ▒▒▒▒▓▒▓▓▓▒▓▒▒▒▒▒▓▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒░▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒░▒▒▒
        ▒▒▒▒▓▒▓▒▓▓▒▒▓▓▒▒▒▒▒▒▓▒▒▒▒▒▓▒▓▒▒▒▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒░▒▒▒
        ▒▒▒▒▒▒▓▒▒▓▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒░▒▒▒▒
        ▒▒▒▒▒▒░▒▒▓▒▓▒▓▓▓▓▒▒▓▓▓▒▒▒▒▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒
        ▒▒▒░░░░▒▒░░▒▒▒▓▓▓▓▓▒▓▒▒▓▓▒▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒░▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░▒▒▒▒░▒▒▒▒░░░░░▒▒▓▓▓▒▒▓▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒░▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒░░░▒▒░▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒░░▒▒▒░░▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▒▒░░░▒▒░░░▒▒▒░░░░░▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▒▓▓▓▓▓▒░▒▒▒▒▒░░▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▒░░▒▒▒▒░░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒░░▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▒▒▒▒▒▒░▒▓▒░▒▒░▒▒▒▒▒▒▒▒▒▒░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒░░░░░░░▒▒▒▓▒░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒░▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒░░░▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒░▒▒▒▒▒░▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒░▒▒▒▒░▒▒▒░▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒░▒▒▒▒░░▒░░▒▒░░▒▒▒▒▒▒░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▒░▒▒▒░░▒▒░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒░▒▒▒░▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▒▒░▒▒░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒░▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▓▓▓▓▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▓▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▓▓▓▓▓▓▓▒▒▒▒▓▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
    ";
    Chii = "
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒
        ▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▒▒▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▒▓▓▓▓▓▓▒▓▓▓▒▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▒▒▒▓▓▓▓▓▓▒▓▓▓▒▓▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▒▓▓▓▓▓▒▒▓▓▓▒▓▒▒▓▓▒▒░▓▒▒▓▓▓▓▒▒▓▒▓▓▓▓▒▓▒▒▒▒▓▒▓▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▒▒▒▒▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▒▒▓▓▓▓▒▒▓▓▓▒▓▒▒▓▓▒▒▒▒▒▒▓▓▓▒▒░▓▒▓▓▓▓▒▒▒▒▒▒▒▒▓▓▒▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▓▓▒▒▒▓▒▓▒▓▒▒▒▓▒▒▒▒▒▒▓▓▓▒▒▒▓▓▓▓▓▒▓▒▒▓▒▒▒▒▒▓▒▒▓▓▓▓▒▒▒▓▒▓▓▓▓▓▓▓▓▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▓▒▓▓▒▒▒▓▒▓▒▒▓░░▓▒░▒▒░▒▒▓▓░▒▒▓▓▓▓▒▓▒▒▒▒▒▒▓▒▓▒▒▒▒▓▓▒▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▓▒▒▒▒▓▒▒▒▒▒░▒▒▒▓▒▒▒▓▒▓▒▒▓▒▒▓▓▒▒▒▓▒▒▒▒▒▒▒▒▒▓▒▓▓▒▒▒▒▒▓▒▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒▒▓▒▒░▓▒▒▒▒▒▒▓▒▒▓▓▒▒▓▒▒▒▓▓▓▒▓▒▒▒▒▒▓▒▓▒▒▓▒▓▒░▒▒▒▒▓▒▓▒▓▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▒▒▒▓▒▒▒▓▒▓▒▓▒▒▓▒▒▓▓▓▓▓▓▒▓▓▒▓▒▒▓▒▒▓▓▓▓▒▓▓▒▒▒▓▒▓▒▒▒▒▓▒▒▓▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒░▒░▓▒▒▒▓▒▓▓▓▒░░░▒▓▒▒▓▓▓▓▓▒▓▓▓▓▒▓▓▓▓▓▓▒▒▓▓▒▓▓▒▒▓▒▒▓▒▒▒▒▓▓▓▓▓▓▒▓▒▓▓▓▓▓▓▓▒▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▓▓░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▒▒▒▒▓▓▓▓▒▒▒▒▓▓▓▓▓▒▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▒▓▓▒▓▓▓▓▓▓▒▓▒▒▓▒▒▒▒▓▒░▓░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░▒░░░░░░▒▓▒▒▒▒▓▓▓▓▓▓▒▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▒▒▓▓▓▒▓▓▓▓▒▓░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░▒▒▓▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒▓▓▒▓▓▓▓▒▓▒▓▒▒▓▓░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░▒▒▓▓▓▓▓▓▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▒▒▓▓▓▓▒▓▓▓▓▓▒▒▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░▒░▓▓▓▓▓▓▓▒▓▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▒▓▓▒▓▓▓▒▒▓▒▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒░░░░░▒▒▓▒▓▓▓▓▓▓▓▓▒▓▒▓▓▓▓▓▓▓▓▓▓▒▒▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▒▓▓▓▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▒▓▒▓▓▓▓▒▓▒▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▓▒▓▓▓▒▓▓▒▒▒▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▓▓▓▒▒▓▒▓▓▓▒▒▓▒▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▓▓▓▓▒▓▓▓▒▓▓▒▓▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▒▓▒▒▓▓▒▓▓▓▒▒▓▒▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▒▓▒▒▓▒▓▒▒▓▓▒▓▓▒▒▒▒▓▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▓▓▓▓▓▒▓▓▒▓▒▓▒▒▓▓▓▒▓▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▓▒
        ▒▓▓▓▓▓▓▒▒▓▓▒▓▒▒▒▓▒▒▓▓▒▓▓▒▒▓▒▓▒▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▒▒▓▓▒▒▓▓▒▓▒▓▓▓▒▒▓▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▓▓▓▒▓▒▓▒▒▒▓▒▓▒▓▓▒▓▓▓▒▓▒▓▒▒▒▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▒▒▓▓▒▒▒▒▓▓▒▓▒▒▓▓▒▒▓▒▒▒▒▓▒░░░░▒▓▓▒▒▒▒▒▒
        ▒▒▓▓▓▒▒▓▓▓▓▒▓▒▓▓▒▒▒▒▓▓▒▓▒▒▓▒▓▒▒▓▓▒▓▒▒▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▒▓▓▒▒▒▒▓▓▒▒▒▒▒▓▓▒▒▓▒▒▒▒░░▓▓▓▒▒▓▒▓▒░▒▒▒▒
        ▒▓▒▒▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▓▓▒▒▒▒▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▒▒▓▒▒▒▓▓▒▒▒▒▒▒▓▒▒▒▓▒▒▒░▒▒▓▓▓▓▓░░▒▓▒▒▒▒▒▒
        ▒▓▓▓▓▓▓▓▓▓▒▒▒▓▒▓▓▒▒▒▒▒▓▒▒▓▒▒▒▒▒▒▒▒▒▓▓▒▒▒▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▓▓▓▒░░▒▓▒▒▒▒▒▒
        ▒▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▓▒▒▒▓▓▒▒▒▓▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▓▒▒░▒▓▒▓▓▒░▒░▒▒▒▒▒▒░
        ▒▒▓▓▓▓▓▓▓▓▓▒▒▓▓▓▒▓▓▒▒▓▓▓▒▓▒▒▒▒▓▓▒▓▓▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▓▓▒░▒▒▓▒▒▒▒▒▒▓▒▓▓▒▒▓▒▒▒▓▓▓░▒▒▒▒▒▒▒▒▒
        ▒▓▓▓▓▒▒▓▓▓▓▓▒▓▓▓▓▓▒▓▓▓▓▓▒▓▓▒▓▓▒▓▓▓▒▒▒▒▓▓▒▒▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▓░▒▒▒▒▒▒▓▒▒▓▓▒▓▓▓▓▓▒▒▒▒▒▒░░░▒▒▓▒
        ▒▒▓▓▓▓▓▒▓▓▓▓▒▒▒▒▒▒▒▒▓▓▒▒▒▓▓▓▓▒▓▓▒▒▒▒▒▓▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▒▒▓▓▒▓▒▓▒▓▒▒▓▒▓▓▒▓▓▓▓▓▒▓▓▓▓▒▓▓▓▓▒▓▒▒
        ▒▓▓▒▓▓▓▒▒▒▒▒▒▓▓▒▒▓▓▓▓▒▒▒▒▓▒▓▓▓▒▒▒▒▒▒▓▒▒▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▒▒▒▒▒▓▓▓▓▒▒▒▓▒▒▓▓▒▓▓▓▓▒▒▒▒░▒▓▓▓▓▓▓▓▓▒
        ▒▓▓▒▒▒▓▒▓▓▓▓▒▓▒▓▓▓▓▓▒▒▒▒▓▓▓▓▒▓▒▒▒▒▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▒▒▒▓▒▒▓▓▓▓▒▒▒▒▒▒▓▒▒▒▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▒▒▒▓▓▓▒▓▒▓▓▓▓▓▒▒▓▓▒▒▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▓▓▒▒▓▒▒▒▒▓▓▓▓▓▓▒▒▒▒▓▓▒▒▒▒▒▒▒▒░▒▓▓▓▓▓▓▒▒▒
        ▒▓▒▓▒▓▓▓▒▓▓▓▓▓▓▓▓▒▓▓▒▒░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▓▓▓▓▓▓▓▓▒▓▒▓▓▓▒▒▓▒▓▒▓▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒
        ░▓▒▓▓▓▒▓▓▓▓▓▓▓▒▓▓▓▓▒▒░▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▓▓▓▒▓▓▓▒▓▓▒▓▓▓▓▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒▒▒▒▓▓▒▒▒▒▒
        ▒▓▓▓▒▓▓▓▓▓▓▒▒▓▓▓▓▒▒▒▒▓░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▒▓▒▓▓▓▓▒▓▓▒▒▓▓▒▒▓▓▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒▒▒▒▒
        ▒▓▒▓▓▓▓▓▒▒▓▓▓▓▓▓▒▒░▒▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▓▒▓▓▓▓▒▓▓▒▒▒▓▓▒▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▓▓▓▒▒▒▒
        ▒▓▓▒▓▒▒▓▓▓▓▓▓▓▒▓░░▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▓▓▓▓▒▓▓▒▒▒▓▓▒▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒▒▒▒
        ▒▓▓▒▓▓▓▓▓▓▓▒▒▓▒░░▒▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▒▒▓▓▓▓▓▓▒▒▒▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▓▒▒▒▒
        ▒▓▓▓▓▓▓▓▓▒▒▓▒░░░▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒▓▓▓▓▓▓▒▒▒▓▓▓▒▒▓▓▓▓▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒░▓▓▓▒▒░
        ▒▓▓▓▓▓▒▒▒▒░░░░▒░▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▓▓▓▒▒▓▓▓▓▓▓▒▓▓▒▒▓▒▓▓▓▓▓▓▓▓▓▓▒░░▒▒▓▓▓▓▒▒▒
        ▒▓▓▓▒▓▒▒▓▒░░▒▒▒▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▓▓▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▓▓▓▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒▓▒▒▒▒
        ▒▒▒▓▒▓▓▒▓░░▒▒▒▒▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▓▓▓▓▒▒▓▓▓▓▓▒▒▒▓▓▓▓▒▒▓▓▓▓▓▓▓▓▒▓▓▒▒▓▓▒▓▓▓▓▓▓▓▓▒▒▓▒▒▒▒▒▒▒▒▒▒
        ▒▒▓▓▒▓▓▒░░▒▒▒▒▒▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▒▓▓▓▓▒▒▓▓▓▓▒▒▓▒▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▒░▓▓▒░▒▒▒▒░░░░░▒▒
        ▒▒▓▓▓▒▒▒░▒▒▒▒▒▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒▓▓▒░▓▒▓▓▓▒▒▓▒▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒░▒▒░
        ▒▓▓▒▒▒▒░░▒▒▒▒▒▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▒▒▓▓▓▒▓▒▓▓▒▒▓▒▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░▒░▒▒▒░▒▒▒▒▒▒░░▒▒
        ▒▒▒▒▒▓░░▒▒▒▒▒▒▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▒▓▓▒▓▒▒▓▓▒▓▓▒▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▒░░░░░▒▒▒▒▒▒▒▒░░▒▒
        ▒▒▓▓▓▒░▒▒▒▒▒▒▒▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒▓▓▓▓▒▒▒▒▓▓▓▒▓▓▓▓▓▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▒▒▒░░▒▒▒▒▒▒▒▒░░░░
        ▒▒▒▒▒░░▒░▒▒▒▒▒▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▓▒▓▓▓▓▓▒▒▒▓▓▒▓▓▓▓▓▓▒▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░
        ▒▒▓▓▒░░░▒▒▒▒▒▒▓▓▒▒▒▓▓▓▓▓▓▓▓▒▒▒▓▓▒▓▓▓▓▒▒▓▓▓▒▓▓▓▓▓▒▓▓▒▓▓░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░
        ▒▓▓▒░░░▒▒▒▒▒▒░▓▓▒▒▒▓▓▓▓▓▓▓▒▒▓▓▒▓▓▓▓▒▓▓▓▒▓▓▓▓▓▒▒▓▒▒▓▓▒▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░
        ▒▒▓▒░░▒▒▒▒▒▒░░▓▓▒▒▒▓▓▓▓▓▒▒▓▓▒▓▓▓▒▓▓▓▒▓▓▓▓▓▓▒▓▓▒▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░
        ▒▒▒░░▒▒▒▒▒▒░░░▓▓▒▒▓▓▓▓▒▒▒▓▒▓▓▓▒▓▒▒▓▓▓▓▓▒▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░
        ▒▒▒▒▒░▒▒▓▒░░░░▓▓▒▒▓▓▒▒▒▓▒▓▓▒▓▒▓▓▓▓▓▓▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░
        ▒░▒▒▒▒▒▓▓▓░░░▒▓▓▒▒▒▒▒▓▓▒▒▒▓▓▓▓▓▓▒▒▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░░░░░
        ░▒░▒▓▓▓▓▓▓░░░▓▓▓▒▒▒▓▒▒▓▓▓▓▓▓▒▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▒▒▓▓▓░▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒░▒░░░░░
        ░░▒▓▓▓▓▓▓▓░▒▒▓▓▒▒▒▓▓▓▓▓▒▒▒▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▒▒▒▓▓░▒░▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒░▒░░░░░
        ░▒▒▓▓▓▓▓▒░▒▒▒▒▓▓▓▓▓▒▒▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▓▓▓▓▒▒▒▓▓░░▒░▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒░░░░░░░
        ░▒▒▒▒▒░░▒▒▒▓▓▓▓▒▒▒▓▓▒▒▒▒▒░░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▓▓▒▒▒▓▓░░▒░░▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒░░░░░░░
        ▒▒▒▒▒░▒▓▓▓▓▒▒▓▓▓▒▒░▒▒▒▒░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▓▓▒░▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒░░░░░░
        ░▒▒▓▓▓▒▒▒▓▓▓▒▒░░░▒▒▒▒▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▓▓▒▒▒▒▓▒░▒▒░▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒░░░░░░
        ▒▓▒▒▒▓▓▓▓▒▒▒░░▒▒░░░▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▓▓▒▓▓░░▒░▒▒▒▒▒▒░░░░▒▒▒▓▓▓▓▒▒▒░░░░░▒
        ▒▓▓▓▓▒▒▒▒▒░▒▒░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▓▓▓▒░░▒░▒▒▒▒▒▒░░░░▒▓▓▓▓▓▓▒▒▒▒░░░░▒
        ▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒░░░▓▓░░░░▒▒░▒▒▒▒░░░▒▓▓▓▓▓▓▓▒▒▒▒░░░▓▒
        ▒░▒▒▒▒▒▒▒▒▒░▒░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒░░░▒░░░░▒▒░▒▒▒░░░▒▓▓▓▓▓▓▓▓▒▒▒▒▒░▒▓▒
        ▒▒▒▒▒▒▒▒▒▒░▒░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒░░░▒░░░▒▒░▒▒▒░░░░▓▓▓▓▓▓▓░░▒▒▒▒▒▓▒▒
        ░▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒░░▒▒░░░▒░░▒▒░░░░░▒▓▒▒▒░░░▒▒▒▒▓▒░▒
        ░▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒░░░░░░▒░░▒▒░░░░░░░░▒░░░░▒▒▒▓▒░▒▒
        ▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒░▒▒░░░░░░░▒▒░░░░░░░░▒░░░░▒▒▓▒▒░▓▒
        ░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒░░▒░░░░░░▒░░░░░░░░░▒▒▒▒▒▒▓▒▒░▒▒▒
        ░▒▒▒▒▒▒▒░░░░░░░░░░░▒▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒░░▒▒░░░░░░░░░░░░░░▒▒▒▒▒▓▒▒░░▒▓▒
        ░▒▒▒▒▒▒░░░░░░░░░░▒▒▒░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒░░░▒▒▒░░░░░░░░░░░░▒▒▒▒▓▒░░▒▒▒▓▒
        ░▒▒▒▒░░░░░░░░░░▒▒▓▒▒▒░▒░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒▒▒░░░░░░░░░░░░░░░░░▒▒▒▓▒░▒▒▒▒▓▓▒
    ";
    KyoujurouRengoku = "
        ▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▓▓▒░▓▓▓▓▓▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒░▓▓▓▓░▓▓▓▓▒▒▓▓▓▓▒▒▓▓▓▓▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒░▒▒▒▒░▒▒▒▒▒░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▓▒▒▓▓▓▒▒▓▓▓▓▒▒▓▓▒▒▒▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓░▒▒▒▒▒▒
        ▒▒▒▒▒▒░▒▒▒▒▒▒░░▒▒░▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▓▓▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░
        ▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▓▓▒▒▒░▒▓▒▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒
        ▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▓▓▓▓▓▓▒░▒▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓
        ▒░░▒▒▒▒░▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓░▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓░▒▒▓▓▓▓▓▓▓
        ▒▒▒▒▒░░░░▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒░▒▒▓▒▓▓▓▓▓▓▓▓▒▒▒▓▒▓▓▓▓▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▒▒
        ░▒▒▒▒▒▒▒▒▓▓▒▒▒▓▒▓▓▒▓▓▓▓▒▒▓▓▓▒▓▓▓▓▒▒▒▓▓▓▓▓░▒▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒
        ▒░░▒▒▒▓▓▓▒▒▒▓▓▓▒▓▒▓▒▒▓▓▒▓▒▒▒▒▓▒▒▓▒▒▒▒▒▒▒▒▒░▒▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▒▒▒▒▒▓▒▒▒▒▒▓
        ▒▒▒▒░▒▒▒▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓░▓▒▓▒▓▓▓▒▒▒▒▒▒▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░▒▒▒▒▒▒▒▓▓▒▒▓▒▒▒▒▒▒▒▒▒░░▒▓░▒▒░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓
        ▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒░▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒░▓▒▒▒▒▒▒░▒▒▒▒▒▒▒▓▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▓▓▓▓▒▒▒▒▒▒░░░░░░░░▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▓▓▒▒▒▒▒▒▒░▒▒▒▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒░▒▒▒░▒▒▒▒▓▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒░
        ▒▒▒▒▒▒░▒▒░▒▒░▒▒▒▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒░▒▒
        ▒▒▒▒▒▒▒▒░▒▒▒░▒▒░░▓▓▒░▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒░░░░░▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▒▒▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒
        ▓▒▒▒▒▒▓▓▒▒▒░▒▒▓▓░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒
        ▒▒▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▒░▒▒▒▒▒▒▒▒▒░▓▓▓▒▒░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▒▒▓▓▓▓▓▒░░░░░░▒▒
        ▓▓▓▓▓▓▓▓▒▒▒▒▒▓░▓▒▓▒▒▒░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▒▒▒▒▒▒▓▓▒▒▒▓▓▓▓▓▒░▒▒▒▒▒
        ▒▒▓▓▓▓▓▓▒▒▒▒▒▓▓░░▒▒▒▒▒░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░▓▓▓▓▓▓▓▓▒░▓▓▓▓▓▓▒▒▒▒▒▓▒▓▓▒▒▒▒▒▓▓▓▓▓▒▒▒▒
        ▓▒▒▒▓▓▒▒▒▒▒▒▒▓▓░▒░░░░░▒▒░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▒▒▒▓▓▒▒▒▒▓▓▓▓▓
        ▓▒▒▒▒▓▒▒▒▒▒▒▒▓▓░▒▒▒▒▒▒░░▒▒░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▒▒▒▒▓▒▓▓▓▒▒░░
        ▓▓▓▓▓▒▒▒▒▒▒▒░▓▓░▓▓▓▓░░▒▒░░▒░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▒▒▒▒▒░▒▒▒▒▒▒
        ▓▓▒▒▒▒▒▒▒▒▒▒░▓▒░▓▓▓▒▓░▒▒░▒░▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒░▒▒▒▒▒
        ▓▓▓▓▓░░░▒▒▒▒░▓▒▒▒▓▒▓▒▒░▓▒░▒░▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▓▓▓▓▓░▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓░▒▒▓▓░▒░▒▒▒
        ▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▒▒▓▓░▓░▒▒▒▒▒░▒▒▓▓▓▓▓▓▒▓▓▓▓░░▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▒▒▓▒▓▓▓▒▓▓▓▒▒▒▓░▒▒▒▒▒
        ▓▓▓▓▒▒▓▓▒▒▒▒▒▒▓▓▓▒▒▓▒▒▓▓▒░▓▒░▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒░░░░▒▒▒░▒▒░░▒▒▒▒▒▒▒▒░░▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▒▒▓▓▓▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▓▓▒▓▓▒▒▒▒░▓▓▓▓▓▒▒▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓░▒▒▒▒▓▒▓░▒▒▒▒░▒▒▓▓▒░▒▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▓▓▓▓▒▒▓▓▓▓▒░▒▒▒▒▒▒
        ▒▒▒▒▒▒▓▓▓▒▓▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓░▓▓▓▓▓▓░▓░▒▒▒▒▒▓░▓▓░▒▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒▒▒▓▓▓▓▒▓▓▓▓▒▒
        ▒▒▒░▒▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▓▒▒▒▒▓▒▓▓░▒▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▒▒▓▓▓
        ▓░▒▒▓▒▓▓▓▓▓▒▒▒░▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▓▓▓▓▓▓▓▒▒▒▓▓░▒▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▒▓
        ▒▒▒▓▒▒▓▓▓▓▒▒▒▒░▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▓▓▓▓▒▒▒▒░▒▓▓▓▓▓▓▓▓▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▒▒▒▓▒▒▓▓▓▓▓▓
        ▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒░▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▒▒▓▓▓▓▒▓▓▓▓
        ▒▒▒▒▒▒▓▒▒▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒▒▓
        ▒▒▒▒▒▒▒▒▓▒▓▒▒▒░▒░▓▓▓▓▓▓▓▓▓▒▒░▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▓▓▓▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▓▓▒
        ░▒░▒▒▓░▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▓▓▓▓▓▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▒▓▓▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒░▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▒▒▒░▓▓▓▓▓▓▓▓▓▒▒▓▓▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▓░▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▓░▒▓▒▒▒░▒▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒░░░▒▓▓▓▓▓▒▒▒░▓▓
        ▒▒▒▒▒▒░▒▒▒▓▒▓▓▓▓▒▓▓▓▒▒▒▒▒░▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▓▓▓▒▓▓▓▒▒▓▒░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░▒▒▒▒▒▒▒░▒▒▒▒▒▒░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒░▒▒▓▓▓▒▓▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒░░▒▒▓▓▓▒▒▓▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░▒▒▒░▒▒▒▒▒▒▒▒▒░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒░▒░░▒▒▒▓▓▓▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▓▓▓▓▓▓▓▓▒▒░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ░▒░░░▒▒▒▓▓▒▒▒▒▒▒▒▓▒▒▒░▒▒▒░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓░░░░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▒░░░▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒░░░░░░░░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▓▒░▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▒░▓▓░░▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▒░░░▒▒▒▒░░░░░░▒▒▒▒▒▒▒░░░░░░░░░░░░░░░▒▒▒▒▒▒▒░░░░░░░▒░░░░░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓░░░░░▒▒▒░░░░░░░░░░▒▒▒▒░░░░░░░░░░░░░░░▒▒▒▒▒░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▒░░░░░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░▒▒░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▒▒░░░░▒▒▒▒▒░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▓▓▓▓▓▒▒░░▒▒▒▒▒▒▒▒▒▒░░░░░░▒▓▓▓▓▓▒░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▓▓▓▓▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒░░▒▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▓▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▒▓▒▒▒▒░▒▒░▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▒▒▓▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓
        ▒▓▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▓▓▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒
        ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
    ";
    NezukoKamado = "
        ▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒
        ▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▓▓▓▓▒▒░░░░░░░░░░░░░░░░▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░▒▒▓
        ▒▒▒▒▒▒▒▒▒▒░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▒▒▒▒▒
        ▒▒▒▒▒▒▒▒░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░░▒
        ▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒▒░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒░░▒▒░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░░░░░░░░░░░
        ▒▒░░▒▒░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░░░░░░░
        ▒░░░▒░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░░░░░░░░░░░░
        ▒░░▒▒░░░░░░░░░░░░░░░░░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░░░░░░░░░░
        ░░░▒░░░░░░░░░░░░░░░░░░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░░░░░░░░░
        ░░▒░░░░░░░░░░░░░░░░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░░░░░░░░
        ░░▒░░░░░░░░░░░░░░░░░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░░░░░░
        ░▒░░░░░░░░░░░░░░░░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░░░░░
        ▒░░░░░░░░░░░░░░░░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░░░░░
        ░░░░░░░░░░░░░░░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░░░░
        ░░░░░░░░░░░░░░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░░░░
        ░░░░░░░░░░░░░░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░
        ░░░░░░░░░░░░░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░
        ░░░░░░░░░░░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░
        ░░░░░░░░░░░░░░░▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░
        ░░░░░░░░░░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░
        ░░░░░░░░░░░░░░▒▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▒▒▒▒▒▒▒░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░▒▒▒▒▒▒▒▒▓▓▒▒▒▓▓▓▓▓▓▓▓▓▒░░░░░░
        ░░░░░░░░░░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒░░░░░░
        ░░░░░░░░░░░░░░▒▓▓▒▒▒▓▓▓▒▒░░░░░▒▒▒░░░░░░▒▒▒▒▒▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▒░░▒▒▓▒▒▒▒▓▓▓▒░░░░░░
        ░░░░░░░░░░░░░░▒▓▓▓▓▓▓▒░░▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░░▒▓▒▒▒▒▓▒▒▒▒▒▒▒▒░░▒▒▓▓▓▓▓▒░░░░░░
        ░░░░░░░░░░░░░░▒▓▓▓▒▒▒▒▒▒▓▒▓▒▓▓▓▓▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░▒▒▓▓▓▓▓▒▓▒▒▒▒▒▒▒▓▒▒▒▓▒▒▓▓▓▒░░░░░░
        ░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▒▒▒▒▒▒▒▒▓▒▒▓▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒░░░░░░░
        ░░░░░░░░░░░░░▒░▒▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓░░░░░░░░
        ░░░░░░░░░░░░░▒▒░▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░
        ░░░░░░░░░░░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓░▒░░░░░░░
        ░░░░░░░░░░░░▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▓▓▓▒▓▓▓▓▓▓▓▒▒▒░░░░░░░
        ░░░░░░░░░░░░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒░░░░░░░
        ░░░░░░░░░░░░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░░░░░░
        ░░░░░░░░░░░░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒░░░░░░░
        ░░░░░░░░░░░░░░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒░░░░░░░
        ░░░░░░░░░░░░░░░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒░░▒░░░░░
        ░░░░░░░░░░░░░░░░▒░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒░░░░░▒░░░░░░
        ░░░░░░░░░░░░░░░░▒▒▒▒░░▒▒▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▒░▒▒▒▒▒░░▒░░░░░░
        ░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░
        ░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░
        ░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░
        ░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░
        ░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒░░░░░░░░░░▒▒░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▒▒▒░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░▒▒▒▒▒▒▒▒▒▒░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▓▓▓▓▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░
        ░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░
        ░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░
        ░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░
        ░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░
        ░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░
        ░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░
        ░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░
        ░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░
        ░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░
        ░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░
        ░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░
        ░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░
        ░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░
        ░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░
        ░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
    ";
    Lucy = "
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒░▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒░░▒░▒░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒░▒▒░▒░░░░░░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒░░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░▒
        ▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▒▒▒▒▒▒▒▒▓▒░▒▒░▒░░▒▒▒░▒░▒▒░░░▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒░▒▒▒░░▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▓▓▒▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒░▒░▒▓▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒░▒░▒░░░▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▓▓▒▓▓▓▓▓▒▓▓▒▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒░▒░▒▒▒▒▒▒▒
        ▒▒░▒▒░▒▒░▒▒░░░▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▓▓▓▒▒▓▓▓▓▒▓▓▒▓▓▓▒▓▒▒▒▒▒▒▓▓▒░▒▒▒▒▒▒░▒▒░░▒▒▓▓▓▓▒
        ▒░░▒▒░▒▒░▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▓▓▒▓▓▓▓▓▒▓▓▒▓▒▓▓▒▒▓▓▒▒▓▒▒▒▒▒▒░░░░▒▒░▒▒▒▒▒▒▒▒▓▓▓▓▒
        ▒░░▒▒▒░▒░▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒▒▒▒▒▓▒▒▓▓▓▒▒▒▒▓▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒░▒▒▒░░▒▒▒▒▒▓▓▒
        ▒░░░░░▒▒░▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒▒▒▓▒▒▒▒▓▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒░░░░░▒▒▒▒▒▒▒
        ▒░░░░░▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒░░░░░░▒▒▒▒▒▒▒
        ▒░░░░░░░░░░░░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░░░░░░▒▒▒▒▒▒
        ▒░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒
        ▒░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒▒
        ▒░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒▒░░░░░▒▒▒▒▒▓▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒░▒
        ▒░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒░░░░░░▒▒▒▒▒▓▓▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▓▒▒▒░░▒▒▒▒░▒
        ▒░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒
        ▒░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒▒▒▓▓▓▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒▒▓▓▒▓▓▓▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒░░░░░░░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▒▒▓▓▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒░░▒▒▓▓▒▒▓▒▒▓▒▒▒▒▒▒▒▓▒▓▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒
        ░░░░▒░░░░░░░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒▒▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▓▒▓▒▒▒▒▒▒▒▒▓▒▓▒▒▒▒▒▒
        ░░░░░░░░░░░░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒░░░░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒
        ▒░░░░░░░░░░░░▒▒▒░░▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒░░░░░░░░░░░░░▒▒▒░░▒▒▒▒░▒░░▒░▒▒▒▒▒▒▒▒░░░░░░▒▒▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░░░░░░░░░▒▒▒░░▒▒▒▒▒▒▒░▒▒▒▒░░░▒▒▒░░░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░░░░░░░░░░▒▒░░▒▒▒▒░▒▒░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░░░░░░░░░░░░░▒▒░▒▒▒▒▒▒░▒░▒░░▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░░░░░░░░░░░░░▒▒▒░▒▒▒▒▒▒▒░░░▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒
        ░░░░░░░░░░░░░░░░░░░░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒
        ░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒░▒▒▒▒▒▓▓▓▒▓▓▓▓▒▒▓▓▓▓▓▓▒▒░░░▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░░░░░░░░░░░░░░░░▒▒░▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▓▒▓▓▒▒▒▓▓▓▓▓▓▓▓▒▒▒░░░▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░░░░░░░░░░░░░░░░░▒▒░▒▒▒▒▒▒░▒░▒▒░░░░░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒░░▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▓▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▒▒░░▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▒▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░▒▒▒▒▓▒▒▓▓▓▓▓▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░▒▒▒▓▓▓▓▓▓▓▒▓▓▓▓▓▒▓▓▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░▒▒▓▓▓▓▓▓▓▓▒▒▓▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▓▓▓▓▓▓▓▒▓▓▓▓▓▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▓▓▓▓▒▓▓▓▓▓▓▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▓▓▓▓▓▓▒▓▓▓▓▓▓▒▓▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▒▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▓▓▓▓▒▓▓▓▓▓▓▒▓▓▓▓▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▓▓▓▒▓▓▓▓▓▒▒▓▓▓▓▓▓▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▓▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒
        ▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒
        ▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒
        ▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒
        ▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒
        ▒▒▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▓▓▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒░▒▒▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▒▓▓▓▓▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒
        ▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒
        ▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▓▓▓▓▓▒▓▒▒▒▒▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒
        ▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒
        ▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░▒▒▒▒▒▒
        ▒▒▒▒▒▓▒▒▓▓▓▓▓▓▓▓▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░▒▒▒▒▒
        ▒▓▒▒▒▒▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒░▒▒▒▒
        ▒▓▓▓▒▒▓▓▒▓▒▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒░▒▒▒
        ▒▓▓▓▓▒▒▓▒▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▒▒▒▒▒▒▒▒░▒
        ▒▓▓▓▓▓▓▒▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▒▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░▒▒▒▒▒▒▒▒▒
        ▒▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒
        ▒▓▓▓▓▓▓▓▓▒▒▒▓▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▒▒▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▓▓▓▓▓▓▓▓▒▒▒▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒▒▒▒▒▓▒▒▓▓▓▓▒▒▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒
    ";
    Howl = "
        ░░░▒░░░░░░░░░▒▒▒▒▒▒░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░▒▒▒▒▒░░░░░▒▒
        ░░░░▒▒▒▒░░░░░░▒░▒░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░░▒░░░░░░░
        ░░░░▒▒▒░░░░░░░░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░▒░░░░░░░░░▒░░
        ░░░░░▒▒▒░░░▒░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░
        ░░░▒░▒▒▒▒░░░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░
        ▒░░░░▒░░░░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░
        ░░░░░░░░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░
        ░░░░░░░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░
        ░░░░░░▒▒▒▒▒▒▒▒▓▓▓▒▒▒▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░
        ░░░░▒▒▒▒▒▒▒▒▒▓▓▒▒▒▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░
        ░░░▒▒▒▒▒▒▒▒▒▓▓▒▒▒▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░
        ░░▒▒▒▒▒▒▒▒▒▓▒▒▒▒▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▒▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓░▒▓▓▒▒▓▓▒▓▓▒▒▒▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▒▒▓▓▒▒▓▒▒▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▒▒▓▓░▒▓▒▒▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▒▒▒▓▓░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▒▒▒▓▓░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▒▒▒▒▓▓▒▒▒▒▒▒▓▓▓▒▒▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▒▒▒▒▒▓▓▒▒▒▒▒▒▓▓▒▒▒▓▓▓▓▒▒▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▒▒▒▒▒▓▓▒▒▒▒▒▒▓▓▒▒▒▓▓▓▓▓▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓
        ▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓░▒▒░▒▒▒▓▒▒▒▒▒▒▓▓▒▒▒▓▓▓▓▓▒▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▓▓▒▒▒▓▓▓▓▓▒▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▒▒▓▓▓▓▓▒▒░░░░▒▒▒▒▒▒▒▒▓▒▒░▒▒▒▓▒▒▒▒▓▓▓▓▒▒▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒░▒▒▒▓▒▒▒▒▓▓▓▓▒▒▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▒▒▒▓▓▓▓▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▓▓▓▓▒▒▒▒▓▒▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▒▒▒▓▓▓▓▒▓▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▓░▒▒▒▓▓▓▓▒▒▒▒▓▒▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▒▒▒▓▓░░░▒░░░▒▒▒▒▒▒▒▒▒▓▒▒▒▒▓▓▓▓▒▒▒▒▓▒▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▒▓▓▓▓▓▒░░░░▒▒▒░▒▓▒▒▒▒▒▒▓▒▒▒▒▒▓▓▓▒▒▒▒▒▓▒▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▒▒▓▓▓▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▓▓▒▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▓▓▒▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▓▓▒▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒▒▒▒▒▓▓▓▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▓▒▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▓▓▓▓▒▒▒▓▒▒░░░▒▒░▒▒▒▒▓▓▒▓▒▒▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▓▒▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒▒▓▓▓▓▓▒▒▒▓░▒▒░░░░▒▒▒▒▒▒▓▒▓▒▒▓▓▓▓▒▓▓▓
        ▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▒▓▒▓▒▓▓▓▒▒▒▒░▒▒▒▒▒▓▒▒▒▓▓▓▓▒▒▓▓▓
        ▒▒▒▒▒▒▒▒▒▒░▒▒░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▓▓▓▓▒▒▒▒▒▒▒▒▒▓▒▒▒▓▓▓▓▓▒▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒░▒▒▒▓▓▓▓▓▓▒▒▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▓▓▓▓▓▒▒▒░▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒░▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▓▓▓▓▒▒▒▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▓▓▓▓▓▓▒▒▒░▒▒░▒▒▒▒▒▒▓▓▓▓▓▒▓▓▓▓▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▓▓▓▓▓▒▒▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▓▓▓▒░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▓▓▓▒▒▓▓▓░░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▓▓▓▓▓▓▒▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▓▓▓▒▒▓▓▓░░░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▓▓▒░░░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▓▓▒░░░░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▓▓▓▓▓▓▒▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▓▒░░░░░
        ▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒░░░░░░
        ▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▓▓▓▓▒▒▒░░░░░▒▒
        ▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▓▓▓▒▒▓▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▒▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▓▓▓▒▒▓▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▒▒▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▓▓▓▒▒▓▓▓▒░▒▒▒▒▒▒▒▒▒
        ▓▒▒▒▒▓▓▓▓▓░▓▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▒▒▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▓▓▓▓▓▒▒▓▒▒▒▒░▒▒▒▒▓▒▓▓▓▒▒▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▓▓▓▓▒▒▓▓▒░▒▒▒▒░▒▒▒▒▒
        ▒▒▒▒▒▓▓▓▓▓▒▒▒▒▓▒▒▒░▒▒▒▒▒▒▓▓▒▒▒▓▓▒▒▒▒▒▒▒░▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▓▓▒▒▒▒▒░▒▒▒▒▒▒
        ▓▓▒▒▒▓▒▓▓▓▒▒▒▓▒▓▒▒▒▒▒▒▒▒▒▓▓▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▓▓▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▓▒▒▒▓▒▓▓▓▓▒▒▒▓▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▓▓▒▒▓▓▓▒▒░▒▒▒▒▒▒▒▒▒
        ▓▒▒▒▒▓▓▒▓▓▓▒▓▓▓░▓▒▓▒▒▒▒▒▒▒▓▒▒▒▒▓▓▒▒▒▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▓▓▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▒▒▒▒▓▓▒▓▓▓▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▓▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░▒▒▒▒▓▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▓▓▒▒▒▓▓▒▓▓▓▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▓▓▓▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▓▒▒▒▒▓▓▓▒▓▓▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▒▓▓▓▓░▓▓▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒░▒▓▒░░▒▒▒▒▒░▒▒▒░▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▓▒▓▒▒▒▓▓▒▓▓▓▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▓▒▒▒▒▒▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▓▒▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▓▓▒▒▒░▒▒▒▒▓▓▓▓▓▓▓░▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▓▒▒▒▓▒▓▓▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒░▓▓▓▓▓▒▓▓▓▒▒▓▓▓▒▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▒░▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▓▓▒▒▒▒▒▒▓▒▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▓▓▓▓▒▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▒░▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒░▒░░▒▒▒▒
        ▒▒▒▓▒▒▒▓▒▒▒▒▒▓▒▓▒▓▓▓▓▓▓░▒▒▒▓▒▒▒▓▓▓▓▓▒▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▒░▒▒▒▒░▒▒▒▒▒▒▒▓▒▒▒▒▒▒░▒▒▒▒▒░
        ▒▒▒▒▓▓▒▒▓▒▒▒▒▓▓▓▒▒▓▓▓▓▓▓▒▒▒▒▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒░▒▒▓▒▒▒▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▓▒▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓░▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▓▒▒▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▓▒▒▒▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▒▓▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
            ";
    Ryuk = "
        ▓▓▓▒░░░░░░░▒▒░▒▒░░░░░░░░▒▒▒▒▒░▒▒░░░░░▒░▒░░░░▒░▒▒░▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒
        ▓▓▓▒░░░░▒░▒░▒░░▒░░░░░▒░▒░░▒▒▒░▒▒▒░░░▒░▒░░░░▒░░▒▒░░▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒
        ▓▓▓▒▒░░░░▒░▒░░░░▒░░░░░▒░░░░▒▒▒░▒▒░░░░▒▒░░░░▒░░▒▒▒░▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒
        ▓▓▓▒▒░░░░░▒▒░░▒░░░░░░░░▒░░░░▒▒▒░▒▒░░░░▒░░░░▒░▒▒▒▒░▒▒▒▒▒░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒
        ▓▓▒▒▒░░░░░░▒▒░░▒░░░░░░░░▒░░░░▒▒▒▒▒▒░░░░▒░░░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒
        ▒▒▒▒░▒░░░░░▒▒▒░░▒▒░░░░░░▒▒░▒░░▒▒░▒▒░░░▒▒▒░░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▓▓▓▓▒▒░░░░░░▒▒▒░░▒▒▒░░░░░▒░░▒░░▒▒░▒░░░░░▒░░░▒░▒▒▒▒▒░▒▒░▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒
        ▒▓▓▓▒░▒░░░░░▒▒▒▒░░▒▒▒▒░░░▒▒░▒▒░░▒░▒░░▒░▒▒▒░░▒░▒▒▒▒▒▒▒▒░▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░▒▒▒░▒░
        ░▒▒▓▓▒▒░░░░░▒▒▒▒▒░▒▒▒▒▒░░░▒░░▒░░░▒▒░░░░░░▒░░▒▒▒▒▒▒▒▒▒▒░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░▒▒░
        ▒░░▒░▒░░░░░░▒▒▒▒░▒▒▒░▒▒▒░░░▒░░▒░░░▒░░░░░▒▒░░░▒░░▒▒▒▒░▒░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▓░░░▒▒▒░░░░░░░▒▒▒░▒▒▒░▒▒▒░░▒░░▒▒░░▒░░░▒░░▒░░░░░▒▒▒▒▒▒░░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░
        ▒▓░░░▒▒░░░░░░▒▒▒▒▒░░▒░░▒▒▒░░░░░▒░░░░░░▒░░▒░░░░░░░▒▒▒▒░░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒░░░▒░░░░░░░▒░▒▒▒░░▒░░▒▒░░░░░░░░░░░░░░░▒░░░▒░░░▒▒▒▒░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▓▒▒▒░░░░░▒▒░░▒░▒░▒▒▒░░▒░▒░░░░░░░░░░░░▒░░░░░░░▒░░░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░▒
        ▓▓▒▒▒░░░░░░░░▒▒▒▒▒▒▒▒░░░░░░░░░░░▒▒▒▒▒▒▒▒░░░░░░▒░░░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒
        ▓▓▒▒▒░░░░░░░▒░▒▒▒▒▒▒░░░░░░░░░▒░▒▒▒▒▒▒▒▒▒▒▒░▒░░░░░░░▒▒░░░░░░░░░░░▒░░▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░▒▒
        ▓▓▓▒▒▒░░░░░░░▒░▒▒▒▒▒▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒░░░░░░░░░░░░▒░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░▒▒▒
        ▓▓▒▒▒▒░░░░░░░▒▒░░▒▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░░░▒░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░▒░░
        ▓▒▓▓░▒▒░░░░░░▒▒▒░░▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░░░░░░▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░▒▒
        ▓▓▒▒▓░▒▒▒░░▒░░▒▒▒░░░░▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░▒▒▒▒
        ▓▓▓▒▒▒▒▒▒▒░░▒░░▒▒▒░░▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░▒▒▒▓
        ░░▒▒▒▒▒▒▒▒▒░░░░░░▒▒░░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░▒▒▒▓▓
        ▒▒▒░░░░░▒▒▒▒▒░▒░░░░░░░▒░░▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░▒▒▒▒▓▓
        ▒▒▓░▒░░░░░▒▒▒▒░▒░░░░░░▒▒░▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░▒▒▒▒▓▓▓
        ▒▒▓▓▒░▒▒▒░░▒▒▒▒▒▒░░░░░░▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒░░░░░░░░░░░░░▒░▒▒▓▓▓▓
        ▒▒▒▓▓▒▒▒░▒▒░░▒▒░▒▒▒░░░░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░░░░░░░░░░░░░▒▒▒▓▓▓▓▒
        ▒▒▒▒▒▒▒▒▒░░▒░░░▒░░▒▒░░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░░░░░░░░░░░░░▒▒▒▓▓▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒░░░░▒▒░░░▒░▒▒▒▒▒▒░░░▒░░░░░░▒░░▒▓▓▒▓▒▓▒▒▒▒▒▒▒▓▓▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▓▓
        ▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒░░░▒▒▒▒░░░▒░▒▓▓▒▒▒▒▒▒░▒░▒░░▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒░░▒▒▒▒░░░▒▒▒░░░░░░░░░░░░░▒▒▒▒▒▒▓▒▒▒
        ▒▒▒▒▒▒▒░▒▒░░░▒▒▒░▒▒░░▒▒▒▒▒▒▒░▓▓▓▓▒▒▓▓▓▒▒▒░▒░░▒░▒▒▒▒▒▒▒▒▒▓▒░▒▒▒░░▒▓▒▒▒▒▒▒▒▒░░░░░░░░░░░▒░░░▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒░░▒▒▒░▒▒▒▒▒░░▓▓▒░░▒░░▒▒▒▒░▒▒░▒░▒▒▒▒▒▒▒▒▒░░░▒▒░░▓▒▓▓▒▒░░░▒▒░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▓▒░
        ░▒▒░░▒▒░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▓▓░░░░░▒▒▒▒░░░░░░▒▒▒░░░░░░░░░░▒░▒▒▒▒▒▒░░░░▒▒▒░▒░░░░▒░░░▒▒░░▒▒▒▒▒▒▒▒▒░░
        ░░░░░░▒░░░░░░▒▒▒▒▒░▒▒░▒▒▒▒▓▓▒▒▒▓▓▒▒▒▒▒▒▒▒░░░▒▒▒░░░░▒▒▒▒░░░░░░░▒▒▒▒▒▒░░░░▒▒░▒▒░▒▒░░░░▒▒▒░░░░░░░░░░░░░
        ░░░░░░▒░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒░░▒▓▒▓▒▒▓▓▓▓▓▒▒▒▒▒░▒▒░▒▒▒░▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒░▒░▒░░░░░░░░░░░░░░░
        ░░▒▒▒░▒▒▒▒░░░░░░░▒▒▒▒░▒▒▒▒▓▓▓▓▒▒░░░░░░▒▒▓▒▒▒▓▓▒▓▓▓▓▒▒▒▒▓▓▒▒▒▓▒▒▒▒▒░░░░░▒▒░▒▒▒▒▒▒▒░▒░▒░░▒▒▒▒▒▒▒▒▒░░▒░
        ░▒░▒▓░░▒▒▒▒▒▒░░░░░░▒▒░▒▒▒▒▓▓▓▓▒▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▓▒▒▒░░░░▒▒░▒▒▒▒▒▒▒▒▒░░░░░
        ░░▒░░▒░░▒▒▒▒▒▒▒░░▒░░░░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▒▒▒░▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒░░░░░▒▒░░░░░▒▒▒░░░░░▒░
        ░▒░░░░░░░▒▒░▒▒░▒▒░░░▒░▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▓▓▓▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒░░░░░▒▒░░░░░░░░░░░░░░░
        ░░░▒░░░░░░░░░░░░░░░░▒▒▒▒▒▒░▒▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒░▒▒░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒░▒▒▒░▒░░▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒▒░░░░░░░░░░░░░░░
        ░░░░░░▒░░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░▒▒░░░░░░░░░░░░░░░
        ░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▒▒▒▓▒▒▒▓▓▒▒▒▒▒░░░░░░░░░░░▒▒░░░░░░░░▒▒▒░░░░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▓▓▒░░░░░▒▒▒▒▒▒▓▓▓▒▒▒░░▒▓▓▒▒▓▓▒▒▒░░░░░░░░░░░░▒▒░░▒▒▒░░░░░░░░░░░
        ▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░▒▓▒▒▒▒░▒▒░░░░▒▒▒░░░
        ▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▓▒▒▒▒▒░▒▒░░░░▒▒▒░▒
        ▒▒▓▓▓▓▓▓▓▒▒▒▒▒▓▓▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒░▒░▒▓▒░▒░▒▓▒▒▒▒░░▒▒▒░░░░░░░▒▒▒▒▒░░░░░░░▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░
        ▒▒▓▓▓▓▓▓▒▒▒▒▒▒▓▓▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒░░░▒▒▒▒░▒▒▒▒▒▒░▒░▒▒░▒▒▒▒░░░░░▒▒▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒
        ▒▓▓▓▒▒▒▒▒▒▒▒▓▓▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒░░▒░░░░▒░░▒░░▒▒░▒░░░▒░░░░▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░
        ▓▓▓▒▒▒▒▒▒▓▓▓▓▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒░▒▒▒▒░░▒▒▒▒▒░░▒▒▒▒▒▒░░░░░░░░░░░░░▒▒▒░▒▒▒▒▒░░░░░░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▒▒▒▒▒▓▓▓▓▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▒▒▓▓▓▓▒▒▒▓▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒░░▒▒▒▒▒░░░░░░▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒░░░░░░░▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒░░▒▒▒▒▓▓▓▓▓▓▒▒░░▒░░░░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░
        ▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░
        ▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▓▓▓▓▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░
        ▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▓▓▓▓▓▓▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░
        ▓▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▓▓▓▓▓▓▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░
        ▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▓▓▓▓▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒░░░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▒▓▓▓▒░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▓░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒░░░░░░░░
        ▒▒▒░▒▒▒░▒▓░▒▒▒▒▒▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▓░░░░░░░░░
        ▒▒░░░▓▒░▒░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░░▒▒▒░░░░░░░
        ░▒▒▒▓▒░░░░▒▒▒▒▒▒▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▒▓▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░
        ▒▒░▒░░░░░░▒▒▒▒▓▒▒▒▒░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒░░░░░░░░░░░
        ▒▒▒░░░▒░▒▒▒▒▒▒░▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒░░░░░░░░░░░
        ▒▒▒▒▒▒▒▒▒▒▒░░░▒▓▓░░░░░▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▒░░░░▒▒░░░░░░░░░░░
        ░░▒▒▒▒▒░▒░░░░▒▓▓▒░░▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▓▒▒░░▒▓░▒▒░░░░░░░░░░░░░░
        ░░▒▒▒▒░▒▒░▒░░░▒░░▒▒▓▒░░▒▒▒▒▒▓▒▒▒░▒▓▓▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▒▒░░░░▒▒▒▒░░░░░░░░░░░░
        ░░░░░▒▒▒░░▒▒▒▒▒▒▒▒▒▒░░░░▒▒▓▓▓▒▓▒▒▒▓▓▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒░▒░░▒▒▒▒▒░▒▓▒▒░▒▒▒▒▒▒░░░░░░░░░░░░
        ░░░▒▒▒░▒░▒░▒▒▒▒▒▒░▒▒▒░░░▒▒▓▓▒▓▒▒▓▓▓▒▒▒░▒░▒░▒▒▒▒▒▒▒▒▒▒▒▓▒░▒░▒▒▒▒▒▒▒▒▓▒▓░▒▒░▒▒░░▒▒▒░▒░░▒░░░░░░░░░░░░░░
        ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▓▒░░▓▓▒▒▒░▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒░▓▒░░▒▒▒▒▒▒░▒▒▒▒▒░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░
        ▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒░░░░▒░▒▓░░▒▓░░▒▒▒▒▒▒▒▓▓▓▓▒▒░▓▓░▒░▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒░░░▒▒▓░▒▒▒▒░░▒▒▒▓▓▓▒▒▒▒▒▒▒▓░▒▒░░░▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒░▒▒░░░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒░▒▒▒▒░▒▒▒▒▒▓▒▒▒▒▒▒▒▒░░▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒▒▒▒▒▒░▒░▒▒▒░▒▒▒░▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░░░░░░░░░░░░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒▒▒▒░░▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░
    ";
    Reze = "
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░▒▒▒▒▒▒░░░▒▒▒░▒▒▒▒░░░▒░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒░░░░▒▒▒░░░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░▒▒░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░▒░░░░░░░░░░░
        ░░▒░░░░░░░░░░░░░░░░░░░░░▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒░░▒▒▒▒▒▒▒░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒░░░▒▒░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░░░░░░░░░░░░░░░░░░
        ▒░░▒░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░░░▒▒░░░░░░░░░░░
        ░░░▒░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░░░░░░░░░░░░░░
        ░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░▒
        ░░░░░░░░░░░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒░
        ░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░░░░░▒░
        ░▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒░░░░░░░░░
        ░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░
        ░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░░░░░░░░
        ░░░░░▒▒▒▒▒▒▒▒▒▒░▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░
        ░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░
        ▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░
        ▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▒░▒░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░
        ▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░
        ▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▓░▒░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒░▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒░░░░░░
        ▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▓▓░▒▓▓▓▒▒░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▓▓▒░▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒░░░░░▒
        ▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒░▒▒▒▒▒▒▒▒▒▒░▒▓▓▓▓▓▓▓▓▓░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▓▓▒▓▓▓░▒▒▓▒▒▒▒▒▒▒▒▒░░░░░░░
        ░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▓▓▒▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▓▓▒▒░░▒▓▓▓▓░▒▒▒▒▒▒▒▒░░░░░░░
        ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░░▒░▒▒▒▒▒▒▒▒▒░▓▓▓▒▒▓▓▓▓▓▓▓░░░░▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓░▒▒▒▒▒▓▓▓░▒▒▒▒▒▒▒▒░░░░░░░
        ░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒░▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▓▓▓▒▓▓▓▓▓░░▒▒▒▒▒░▒▒▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒░▒░░░░░░
        ░▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▓▒▒░░▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▒░░▓▓▒▒▒▒▒▒▒░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓░▒▒▒▒▓▓▓▒▒▒▒▒▒▒░░▒░░░▒▒░
        ░░░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▓▓▓▓▒░▒▒▒▒▒▒▒▒▒▓▓▓▓▓░▓▓▓▓▓▓░▒▒▓▓▓▓▓░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▓▓▓▒░▒▒▒▒▒░▒▒▒░░░░▒▒
        ░▒░▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▓▓▓▓▓▓░▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▓▓▓▓▒▒░░░▒░▒▒▒▒▒▒▒░░░
        ░░░▒▒▒▒░▒▒▒▒▒▒░░░▒▓▒▓▓▓▓▓▒░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▓▓▓▓▓▓▓▓░░░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒
        ░░░▒▒▒▒░▒▒▒▒▒░▒░▒▓▓░░░░░░░░▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▓▓▓▓▓▓▓░░░░░░░▒▒▒░▒▒▒▒▒▒▒▒
        ▒░░░▒▒▒░▒▒▒▒░▒░░░▓░▒▓▓░▒▒░░▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▓▓▓▒░░░░░░░░▒▒▒▒▒░▒▒▒▒▒░
        ░░░░▒▒▒░▒▒▒▒▒░░░░░▓▓▓▓▓▒░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▓▓▒▒░░░░░░░▒▒▒░░▒▒▒▒▒▒▒▒▒▒░
        ░░░░▒▒▒░▒▒▒▒░░░░░░░▓▒▒▒▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▓▓░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░
        ░░░░▒▒▒░▒▒▒░░░░░░░░░▓▓▓▓▓▓▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▓▒▓▓▒▓▓▒░░▒░▒░▒▒▒▒▒▒▒░░▒▒▒▒░░░
        ░▒▒▒▒▒▒░▒▒▒░░░░░░░░░░▓▓▓▓▓░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░▒▒▒▒▒▒▒▒▒░▒▓▓▓▓▓▓░░▒▒░░▒▒▒░▒▒▒▒▒▒▒▒▒░▒▒▒
        ░▒▒▒▒▒▒░▒▒░░░░░░░░░░░░▓▒▒▓░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▓▓▓▓▓▓▓░▒▒▒░░░▒▒▒▒▒▒▒░░░░▒░▒▒▒
        ░░░▒▒▒▒░░▒░░░░░░░░░░░░░▓▓▓░▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▓▓▓▓▓▓▓▓░▒▒▒░▒▒░▒░░░░▒░▒▒░▒░▒░▒
        ░░▒▒▒░▒░░▒░░░░░░░░░░░░░░▓▓▒▒▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░▒▒▒▒▒▒░▓░▒▓▓▓▓▓▓▓▓░░▒▒▒░▒▒░▒▒▒▒▒▒▒▒░░░░░░
        ▒░▒▒▒▒▒░░░░░░░░░░░░░░░░░░▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▒▒▒░▒▒▒▒▒▒▒░▒▓░░▓▓▓▓▓▓▓▓▒░░▒▒▒▒▒▒▒░▒▒▒▒▒░░▒░░░░
        ▒▒░▒▒▒░▒░░░░░░░░░░░░░░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒░▒▒░▒▒▒▒▒░▓▓▓░░▓▓▓▓▓▓▓▓▓░░░▒▒▒▒▒▒▒▒░▒▒▒▒░░░░░░
        ░▒▒░▒▒░░░░░░░░░░░░░░░░░░░░▒░▓▓▓▓▓▓▓▓▓▒▓▒▒░▓▓▓▓▓▓▓▓▓▓░░▓░▒▒▒▒▒▒▒▓▓▓▓▓░▓▓▓▓▓▓▓▓▓░░░░▒▒▒▒▒▒▒▒▒▒░░▒░░░░░
        ▒▒▒▒▒░▒░▒░░░░░░░░░░░░░░░░░▒▒░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░▓▓░▒▒▒▒▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓░░░░▒▒▒▒▒▒▒▒░░░░░░░░░░
        ░▒▒▒▒▒░░▒░░░░░░░░░▒░░░░░░▒░▒░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▒▒▒░░▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░▒░▒▒▒▒▒▒▒░░░░▒▒░░░
        ▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒░░░░░▒▒▒░░▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▓░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░▒▒▒▒▒▒░░░░░░░░░
        ▒░░▒▒▒▒░▒▒░░░░░░░▒▒░░░░░▒░░░▒░▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░▒░░▒▒▒▒▒░░░░░░░░░
        ▒▒▒▒▒▒▒▒▒░▒░░░░░▒▒░░░░░▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▒▒▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░▒░░▒▒▒▒░░░░▒░░░░
        ▒▒▒▒░░░░░░▒░░░░░▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▒▒▒▒▒░▒▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░▒░░░░░░░░
        ▒▒▒▒▒░░▒░░▒▒░░░▒▒▒▒▒░░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░▒▒▒▒▒▒▒▒▓▓░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▒▒▒▒░░░▒░░░░░░░
        ▒░▒▒▒░░░░░░░░░░░▒░░░░░▒░░░░░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░▒░░░░░░░░░░▒
        ░░░░░▒░░░░░░░░░░░░░░░░░░░░▒▒▒░▒▒▒▒▒▒░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░▒
        ▒░░▒▒░▒░░░░░░░░░░▒▒▒▒▒▒▒▒▒░░░░░░░░▒▒░░░░░▒░░░░░░░▒░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░
        ▒▒▒░░░▒▒░░▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░▒▒░
        ▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒░░░▒▒▒░░░░▓▓▓▒▒▒░░▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░▒░░
        ▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░▒░░▒▓▓▓▒▒▒░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▓▓▒░░░░▒▒▒░▒▒░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░▒▒▒░░░░░░░░░░▒▓▓▓▓▒▒░▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▓▓▓▓▓▓▓▓▓▓░░░░░░░░▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒░▒▒▒▒▒░░▒░░░░░░░░░▒▓▒░▓▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▒▒░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░
        ▒▒▒▒▒▒▒░░░░░░▒▒▒▒░░▒░░░░░░░▒▒▒▓▓▒░▓▓▓▓▓▓▓▒▒░▒░▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒░░░
        ░▒▒▒▒▒▒░░▒░░░░▒▒▒▒▒░░░▓▓▓▓▓▓▓▓░▒▓▓▓▓▓▓▒▒░▒▒▒░░▒░▒▒░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒░▒▒▒▓▓▓▓▓▓▓
        ░░░░░░░░░░░░░░░▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓░░▒▒▒▒░░▒▒▒░▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▓░▒▓▒▒▓▓▓▓▓▓▓▓▓▓
        ░░░░░░▒░░░░░░░░▒░▒▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▒░░░▒▒▒▒▒▒▒▒▒▒▓▓▓▒░▒▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓░▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓
        ░░░░░░░░▒▒▒▒░░░░▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒░░░▒▒▒▒░▓░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ░░░░░░░░▒▒░░░░░▓▓▓▓▓▓▓▓▓▒▒▓▓▓▒░░░▒▒▒▒░▒░░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▒▓▓▓▓▓▓▓▓▓▓▓▒▓░▓▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓░▒▓▓▓░░░▒▒▒▒░░▓▒░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓░▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ░░░░░░░▒░░░░░▓▓▓▓▓▓▓▓▒▓▓▓▓░░░▒▒▒▒░▒▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓░▓░▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ░░░░▒▒▒▒▒▒░░░▓▓▓▓▓▓▓▒▓▒▒▒▒░▒▒▒▒░▒▒▓░▒░▒░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓░▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ░░▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓░▓▒▒░▒▒▒▒░▒░▓▓▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▓▓▒▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ░░░░▒▒░▒░▒▒▒▓▓▓▓▓▒▒▓▓░░▒▒▒▒░▒▒▓▓▒▒▒░░░░░▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒░░░░░░░░▒▒▓▓▓▓▒▓▓▓░░▒▒▒▒░▒░▒▓▓▒▒▒▒░░░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ░░░░▒▒░░░▒▒▓▓▒▓▓▓▒░▒▒▒▒░▒▒▒▓▓▒░▒▒░░░░░▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒░▒░▒▒▒▒░▒▓░▓▓▓░▒▒▒▒▒░░▒▓▓▓▓▒░▒▒▒▒░░░▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓░▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ░░░░░▒▒░░▒▓▓▓▓▓░▒▒░░░░▓▓▓▓▒▓▒▒▒▒▓░░░▒▓░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ░░░░░░░▓▓▓▓▓▓▓▒░▒▒▒░▓▓▓▓▒▓▓▒▒▒▒▓░░░▒▓░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ░▒▒░░▓▓▓▓▓▓▓▒▒▒▒▒░▓▓▓▓▒▓▓▒▒▒▒▒▓▓▒░░▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▒▓▓▓▓▓▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ░░░▓▓▓▓▓▓▓▒▒░▒▒░▓▓▓▓░▓▓▓▒▒▒▒▓▓▓▓░▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▓▓▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ░▒▓▒▓▓▓▒▒▒▒▒▒▒▓▓▓▓▒▓▓▓▓░▒▒▒▓▓▓▓▓▓░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
    ";
    lucy = "
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▓▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▓▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▓▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▓▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▓▒▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▓▓▒▓▓▒▒▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒▒▓▓▒▒░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒░░░░▒░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒░░░░░░░░▓▓▒░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▓▓▓▓▓▒▒▒▒▓▒▒▓▓▓▓▒▒▒▒▒░░░░░░▒▒▒░░▒▒▓▒▓▓▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▓▒▓▒░▒▒▒▓░░▒▒▒▒▒▒▒▓▒▒▓░▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▒░▓▓▓▓▓▓▓░░▒▓▓▓░▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░▒▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒░░░░░░░░░░▒▒▒▒▒░▒▒▓░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▓▒▓▓▓▓▓░▒▒▒▒▒▒▒▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▓▒▓▓▓▓▓░░▓▓▓▓▒▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▒▓▒▓▓▓▓▓▓▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓
        ▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓
        ▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓
        ▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓
        ▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓
        ▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░
        ▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░
        ▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░
        ▒▒░░░░░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░
        ▒▒▒░░░░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░
        ▒▒▒▒▒▒░░░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒░░░░▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▒▓▓▒▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░
        ▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒░░▒▒▒▒▒░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒░░░▒░░░░░░░░▒░░░░░░▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░░
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒░░░
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒░░
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░▒▒▒░▒▒░░░▒▒▒▒▒░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒░
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░▒▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░▒▒░░░░░░░░░░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒░
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒▒▒░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒░▒░░▒▒▒░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒░
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▓▓▓▓▒▒░▒▒░░░░░░░░░░░░░░░▒▒▒▒▒░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒▒▒▒░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓░▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒░▒▒▒▒▒▒▒▒░░░▒▒▒▒▒░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░▒▒▒▒▒▒▒░░░░░▒▒▒▒▒░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒░░░▒▒▒░▒▒▒▒▒▒▒▒░░░░▒▒▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓░░░░▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒░░░▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓░░▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
    ";
    MeiMisaki = "
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░▒▒▒▒▒▒▒▓
        ▓░░░░▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░▒▒▒▒▒▓
        ▓▒▒▒▒▒▒░░░░░░▒▒▒░▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░▒▒▒▓
        ▓▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓
        ▓▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▓
        ▓▒▒▒▒▒▒░▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓
        ▓▒▒▒▒▒░▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▒▒▒░▒▒▒▒▒▒░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▒░▒▒▒▒▒▒▒░▒▒░░░░░▒░░░░░░░░░░░░░░░░░░▒▒░░░░▒░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▒▒▒▒▒░▒░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░░░▒░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓░▒▒▒░░░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▓░░░░░░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▒░░░░░░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░▒░░▒▒░░░░░▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▒░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░░░░▒▒░░░░░░░▒▒▒░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░▒▒░░░░░░░▒▒▒░▒▒▒▒░░░░░░░░░░░▒░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░░░░░░░▒▓░░▒▓▒▒▒░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░▓░░░░░░░░▒▓▒▓▓▒▓▒▒▒▒░▒░░░░░░░▒▒░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░▒░▒░░░▒▒▒▓▓▓▓▓▓▓▓▒▒▒░░░▒░░░▒▒░░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░░▒▒▒░░▓▓▓▓▓▓▓▓▓▒▓▓░░▒▒▒░░▒▒▒░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒░▒▓▒▒░▒▒░░░░▒░░░░░░░░░░░░░░░░░░░░░▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒▓▒▒░▓▓▒▒▒▓▒░░▒▒░░░░░░░░░░░░░░░░░░░░░▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▒▒▒▒░▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▒▒▓▒▓▓▒▒▒▒░░▒▒░░░░░░░░░░░░░░░░░░░░░▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▓▒▒▒▓▓▓▓▓▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▓▒▓▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░▓
        ▓░░░░░░▒░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░▒▒░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░▓
        ▓░▒▒░░░░▒░░░░░░░▒░▒░░░░░░░░░░░░░░░░░░░▒▓▓▒░░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓░░▒▒░░░▒░░░░░░░▒░▒░░░░░░░░░░░░░░░░░░░░▒▓▒▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓░░▒▒▒░░░▒░░░░░░▒░▒░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓░░░▒▒░░░░░░░░░░▒░▒░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▒░░▒░░▒▒░░░░░░░▒▒▒░░░░░░░░░░░░░░░░▒░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▒▒▒░▒░▒▒▒▒░░░░░▒▒▒░░░░░░░░░░░░░░░▒▒▒▒▒░░░░░░░░▒▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░▓
        ▓░░░░░░▒▒▒▒░░░░░▒▒▒░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▓▒▒░░░░░░░░░▒▒▓▓▓▓▓▓▓▓▒▒▒▒░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░▓
        ▓▒▒▒▒▒░▒░░░░░░░░░▒▒░░░░░░░░░░░░▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▓▒▒░░▒▓▓▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░▓
        ▓░░░░▒░▒░▒▒▒▒░░░░▒▒▒░░░░░░░░░░░▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▓▒▒▓▓░░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▓
        ▓▒▒▒▒▒░▒▒░░░░░░░▒▒░▒░░░░░▒░░░░░░▒▒▓▒░░░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒░▒▒▒░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░▒░░░░░░░▒▓
        ▓▒▒▒▒▒░▒▒▒░░░▒▒▒░░░▒░░░░░▒▒░▒▒▓▓▒▒▓▒▒▒▒░░▒▒▒▒▒▒▒░░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░▒▒▒░░░░░░░░░░░▒▒░░░░░░░▒▓
        ▓▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒▒▓▓▓▓▓▓▓▓▒▒▒░░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒░░░░░░░░░░▒▒░░░░░░▒▒▓
        ▓▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒░░░░░░░░░▒░▒░░░░░▒▒▓
        ▓▒▒▒▒░░▒▒▒░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒░▒░░▒░░░▒░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒▒░░░░░▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▒░░░▒░░░░░░░░▒▒░▒▒░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒░░░░▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▓▓▓▓▓▓▓▒▒▒▒░░▒▒░▒▒▒░░░░░░░░▒▒░░░░▒░░▒▒▒░░░░▒▓▓▒░▒▒░▒░░░▒░░░░▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▒▒▓▓▓▓░░░▒▒░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒░░░░░░░░░▒▓▓▓▓▓▒▒▒░░░░░░░░░▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▓░░▒▒░░░░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▓▒▒▒░░░░▒▒▒▒▒▒▒▒▒░▒▒▒▒░░░▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒░░░░░▒▒░░░░▒░░░░░░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▓▓▓▒▓▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒░░▒▒▒▒▒░▒░░░░▒░░░▒▒▒▒░░░░░▒▒▒▒▒▓▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░░░▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒░░▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒░░░▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░▒▒▒░░░░░░▒░▒▒▒▒▒░░░▒▓▓░▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒░░░░░▒░░░▒▒░░▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░▒░░░░░░▒░░▒▒▒░▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░▒░▒▒▒▒▒▒░░▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒░▒░░▒▒▒▒░░░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒░▒▒▒▒░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▒▒▒▒▒▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▒▒▒▒▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▒▒░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
    ";
    FutureTrunks = "
        ▒▒▒▒▒▒▒▒▒▓▒▓▒▓░▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▓▓▓▓▓▓▓░▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▓▓▒▒▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▒▒▒▓▓▓▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒░▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒░▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▒▓▓▒▒▒▒▒▒▒▒▒░░▒
        ▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▒▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▒▒▒▒▒▒▓▓▓▓▒▓▒▒▒▒▒▒▓▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▓▓▓▓▒▒▒▓▒▓▒▓▓▒▓▓▓▓▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒░▓▓▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒░▒▒▒▓▓▓▓▒▓▒▓▒▓▒▓▒▒▒▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▒▒▒▒▒▒▒▒▓▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▓▓▓▓▒▒▓▓▒▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒▒▒▒▒▒▒▓▒▒▓▓▓▓▓▓▓▓▒▒░▒▒▒▒░▒▒
        ▒▒▒▒▒▒▒▓▓▓▓▒▓▓▓▒▒▒▒▒▒▒▓▓▒▓▓▓▓▒▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒░▓▓▓▓▒▒▓▓▒▒▒▒▒▒▒▓▒▓▓▒▓▒▓▓▓▓▓▓▓▓▒▓▓▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▓░▒▓▓▓▓▒▓▓▓▒▒▒▒▒▒▓▓▓▒▓▒▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▒▒▒▒▒▓▒▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▓▒░▓▓▓▒▒▒▓▓▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▓▓▓▒▓▓▓▒▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▓▒▒▓▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▓▒▒▒░▒▒▒▓▓▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▓░▒▒▒▒▒▒▓▓▓▒▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▓▒▒▒▒▒▓▓▓▒▒▓▓▒▒▒▒▒▒▒▒
        ▒▒▒▒▓▓▒▒▒▓▓▓▓▒▓▓▓▒▓▓▒▓▓▒▓▒▒▒▒▒▒▒▓▒▓▓▒▒▓▓▓▓▓▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▓░▓▓▒▒░▒▓▓▒▓▒▒▒▓▒▒▒▒▒▒▒
        ▓▓▒▓▓▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▓▒▒▒▒▒▒
        ▓▓▒▓▓▓▓▓▓▓▓▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓░▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▓░▒▒▒▓▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▒▒▓▓▓▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▓▓▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒
        ▓▒▓▓▓▒▒▒▒▒▓▓▓▓▓▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▒░▒▓▓▓▒▒▒▒▒▒▒▓▒▒▒▒▓▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒
        ▓▓▒▒▓▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▓▒▒▓▒▒▒▓▒▒▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▓▓▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒
        ▒▓▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▓▒▓▒▓▓▒▒▒▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▓▓▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒
        ▒▒▒▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▓▒▓▓▓▓▒▒▓▓▒▓▒▓▒▒▒▒▓▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▒▒▒▒▓▓▓▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒
        ▒▒▓▒▓▓▓▒▓▓▓▒▒▓▒▒▒▒▒▒▒▓▒▓▓▓▓▒▒▓▓▓▓▒▒▒▒▒▒▒▒▓▓▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▓▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒
        ▒▓▒▓▓▓▓▒▓▓▒▓▒▓▒▒▒▒▒▒▒▓▒▓▓▓▓▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▓▓▓▓▓▓▒▓▒▓▓▓▒▒▓▒▒▒▒▓▓▒▓▓▓▓▓▒▓▒▓▓▒▒▒▒▓▒▒▒▒▒▒▒▒░▒▓▓▓▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▒▓▓▓▓▓▒▒▓▓▓▓▒▓▒▒▒▒▒▓▓▒▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▒▓▓▓▓▓▒▓▓▓▓▓▓▒░▓▒▒░▓▓▓▒▓▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒░▓▒▓▓▓▒▓▓▒▒▒▓▒▒▒▒▒▒▓▓▓▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▓▒▓▓▓▒▒▓▒▓▒▒▒▒▒▒▒▒▒▓▓▒▒▒▓▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒
        ░▒▒▒▒▓▒▒▒░▓▒▓▒▒▒▒▒▒▒▒▓▓▓▓▒▓▓▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░▒░▓▒▓▒▓▓░░▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░▒▓▒▒▒▒▓░░▒▓▒▒▒▒▒▒▒▓▒▒▒▓▓▓▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▓▓▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒
        ░░░░▒▓▒▒▒▓▓░░░▒▒▒▒▒░▒▒▒▒▒▓▒▓▓▒▒▓▒▓▓▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▓▓▓▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░▓▒▓▒▒▓▒░░░░▒▒▒▒▒▒▒▒▒▒▓▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒
        ░░░░░░░░▒▒▓▒▒▓▒░░░▒▒▒▒▒▒▒▒▓▒▒▒▓▒▓▓▓▒▒▒▒▒▒▒▒▒▒▓▒░░░▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒▒▒░▒▒
        ░░░░░░░░░▒░▒▓▒▒▓▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒░░░░░░░▒▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒
        ▒▒▒▒░░░░░░░▒░░░░░░░░░░░░▒▒▒▒▒░▓▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒░░░░░░▒░░░░░░░░░░░░░▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░
        ▒▒▒▒▒▒▒▒░░░░░▒░░░░░░░░░░░░░░▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░
        ▒▒▒▒▒▒▒▒▒▒░░░░░▒░░░░░░░░░░░░░░▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒
        ▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒░░░░░░░░░░░▒▓▓▒▒▓▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒░░▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░▒▓▓▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒░░▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░▒▓▓▓▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒░░░▒░▒▒▒▒▒▒▒▒░░░░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▓▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒░░▒▒▒▒▒░▒▒▒░░▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒░▒░░▒▒░▒▒▒░░░▒▒░░░▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▓▓▓▓▓▒▒▒░▒░▒▒▒▒▒▒▒░▒▒▒░▒▓▓▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒░▒▒▒▒░▒▒░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▓▓▓▓▓▒▒░▒░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒░▒▒▒░░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░▒░░▒▒▒▒▒▒░▒░░░░▒░░░░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▓▓▓▒░▒▒▒░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒░▒▒▒▒░▒▒▒▒▒▒░░░▒▒▒▒░░▒▒▒▒▒▒▒░▒░▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒░▒▒▒░▒░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░▒▒▒▒▒░▒░▒▒▒▒▒▒▒░░░▒▒▒░░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░▒▒▒▒▒▒░▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒░░▓▒▓░▒▒▒▒░▒▒▒▒▒▒▒▒▒░░░▒░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒▒▒▒▒░░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░░▒▒▒░▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒░░▒░░▒▒▒▒▒▒░░░░▒▒▒▒▒░▒▒▒▓▒▒▒▒▒▒▒░▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▓▓▓▒▒▒▒▒▒▒░▒▒▒░░░░▒▒▒▒▒▒▒▒▒░▒░░▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▓▓▓▓░▓░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒░▒░▒▒▒▒▒▒▒▒▒▒░▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▓▒▒▓▓▓▓▒▓▒▓▒▒▒▒▒░▒▒▒░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒░▒░▒▒▒▓▓▒▒▒▓▓▒▒░░░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▓▓▒▒▓▓▓▓▓▒░▒▒░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒░▒▒▒░▒▒▒▒▒▒▒░░▒▒▒▒▒░▓▓▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▓▓▒▒▒▒▒▓▒░▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░░▒▒░░░░░▒▒░▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▓▓░▒▒▒▒▒▒░▒▒▒▒▒░▒▒▒░▒▒▒▒▒░▒▒▒░▒▒▒▒▒▒░▒░░▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒░▒░▒▒▓▓▓▒▒▓▓▓▒▒░▒▒▒▒▒▒
        ▒▒▒▓▒▒▒▒▒▒▒░▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒░░░▒▒▒▒▒▒▒
        ▒▓▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒░▒▒░▒▒▒▒░░▒▒▒▒▒░▒▒▒▒▒░▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▓▓░░▒▓▓▒▒▓▓▓▓▒▒▒▒▒░░░▒▓░
        ▓▓▓▓▒▒▒░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░░▒▒▒░░▒▒▒▒▒░▒▒▒▒▒░▒▒▒░░░░░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒░▓▓░░▒▒▒▒░░░░░░░░░▒▒▒▒▒▒░░▒
        ▓▒▒▓▓░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒░▒▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒░▓▒░▒▓▒▒░░░▒▓▓▓▒▓▒▒░░░▓▒▒▒░░
        ▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒░▒░▒▒▒▒▒▒░▒▒▒░░░░▒▒▒▒▒▒▒░▒▒▒▒▒▓▒░▒▓▒▒░░▒▒▓▒▒▒▒▒▓▒▒▒░░▒▒▒▒░
        ▓▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒░▒░▒▒░▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▓▓▓▓░░▓▓▒░░▒▒▓▒▓░░░░░▒▒▒▒░░▓▒▒░
        ░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒░▒░▒▒▒▒░░▒▒▒▒▒▒▒▒░▒▒▒▒░▒▒░▒▒▓▒▒▒▒░░▓▓▒░░▓▒▓▒░░░░░░░▓▒▒░░▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒░░░░░░▒▒▒▒▒▒▒▒░▒▒▓░▒░▒▒▒░▒▒▒░▒▒▒▓▒▓▓▒░░▓▒▒░░▒▒▓▒░░░░░░░▓▒▒░░▒▓▒▒
        ▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒░░░▒▒▒▒▒▒▒▒░░▒░▒▓▒▒░▒▒▒░▒▒▒░▒▒▒▒▒▒▒▒░░▒▒▓▒░░▓▒▒▒▒░░▒▒░░░░░▒▒▒▒░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒░▒░░▒░▒▒░▒▒▒▒▒▒▒▒░░▒░░░░▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▓░▒▒▒░░▓▒▒▒░░▒▒▒▒▒▒▒▒▓░░░░░▒▒░░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒░▒▒▒▒▒▒▒░░▒▒░░░░▒░▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▓░░▒▒▒▓▒░░░░░░░░░░░░▒▒░░░▒
        ▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒░▒░░▒▒▒▒▒░░▒░▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▒▒▒▒▒▒▒▒░░▒▒▒▒▒▓▓▓▒▓▒▒▒▒▒▒▒▒░▒▒
        ▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░░▒▒▒░▒░░░▒░▒▒░░▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒░░▒▒▒▓▒▒▓▒▒▒░░▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒░▒░░░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▓▓▒▒▓▓▒▒▒▒▒▒░▒▒▒▒▒▒▒▒░▒▒
        ░▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░▒▒▒▒░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▒▒░▒▓▓▒▓▒▒▓▒▒▒▒░░▒▒▒▒░▒░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░▒▒▒▒▒▒░▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓░▓▒░░░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░▒▒▒▒░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒░░▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒░▒▒▒▒▒▒
        ▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒░
    ";
    Sanji = "
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▓▓▓▓░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒░░░▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▓▓▓▓▓▓▒▓▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▓▓▓▒▒▓▓▓▓▓▓▒▓▒▓▓░▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▓▓▓▒▒▓▓▓▓▓▓▒▓▒▓▓░▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▒▒▓▓▓▓▓▓▒▒▓▓▓▒▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▓▓▓▒▓▓▓▓▓▓▒▒▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▓▒▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓░▒▓▓▓▓▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▓▓▓▒▓▓▓▓▓▓▒▒▒▓▓▒▒▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▒▒▓▒▒▓▒▒▓▒▒▓▓▓▒▒▓▓▓▒▓▓▓▓▓▒▒▓▓▓▓▒▓▓▓▓▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▓▓▒▒▓▓▓▓▓▒▒▒▓▒▒░▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▒▒▓▒▒▒▓▓▒▓▓▒▓▓▓▓▒▒▓▓▓▒▓▓▓▓▓▒▒▓▓▓▒▒▓▓▓▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▓▓▓░▒▓▓▓▒▒░▒▒▒▒▒░▓▓▓▓▓▓▓▓
        ▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▒▓▓▒▓▓▓▒▒▓▓▓▒▒▓▓▓▓▒▒▓▓▓▓▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓
        ▓▒░░░░░▒▓▓▓▒▓▓▒▒▓▓▒▓▓▓▒▒▓▓▓▒▓▓▓▓▒▒░▓▓▓▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒░░▒▓▓▓▓▒▒▒▓▒░▒▒▒▒▒▓░▒▒▒░▒▒▒▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▓▓▒▓▓▒▒▒▓▓▒▒▓▓▓▒▒▒░▓▓▓▒▒▓▓▓▒░▒▒▒▒▒▒░▒▒▒░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▓▓▒▓▓▒▒▒▓▓▒▓▓▓▒▒▒▓▒▓▓▒░▓▓▓▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▓▓▒▓▓▒▒▒▓▓▒▓▓▒░▒▓▓▒▓▓▒▒▓▓▓▒░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒░▒▒▒▒▓▓▒▒▒▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▓▓▒▒▓▒▒▓▓▒▓▓▒▒░▓▓▓▒▒▓▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒░▒▒▒▒░▒▒░▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒▒▓▓▒▓▒▒▒▒▒▓▒▒▒▒▓▓▓▒▒▒░▒▒▒▒░▒▒▒▒░▒▒▒▒▒░▒░▒▒░░▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒░▒▒░▒▒▒▒░▒░▒▒░░░▒▒▒▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▓▒▒▓▒▒▒▓░▒▓▒▒▒▒▓▒▒▒░▒▒▒▒░▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▓▓▓▒░▒▓▓▓▓░▒▒▒▒▒▒▒▒▒▒░▒▒▒▒░▒▒▒▒░▓▓▓▓░░▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒▒▓▓▒▓▒▒▒▒▓▓▓▓▒▒▒▓▒▒▒░▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓░░░░▒▒▒▒▒▒▒░▒▒▒▒▒▒░▒▒░▒▒░▒▒▓░▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▒▓▒▓▓░▒▒▒▓▒▒▓▓▓▒▒▓▒▒▒░▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒░░▒▒░▒▒▒▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒░▒▒▒▒▓▓▒▓▓▓▓▒▒▒▒▒▒▒▒▒░▒▒▓▒▒▒▒▒▒▒▓▓▓▓▓▒▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒▒▒▒▒░▒▒▒▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▓▓▒▒▒▒▓▒▒▓▓▒▓▒▒▒▓▒▒▒▒░▒░▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░░▒▒▒░░░▒▒▒▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░▒▒▓▓▒░▒▒▒▒▓▓▒▒▓░▒▒▒░▒▒░▒░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒░░▒▒▒▒▒▒▓▓▒▒▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▒▓▒▓▓▒▒░▒▒▒▓▒▒▓▒░▒▓▒▒▒░▒▒░▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░▒▒░▒░▒▒▒▒▒▒▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▓▓▒▓▒▒▒▓▒▒░▒░▓▒▒▒░▒░▒▒░▒░▒▒▒▒▒▒▒▒▓▓▓▓▓▒▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░▒▒░░░▒▒░▒▒▒░▒░▒▒▒▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▒▓▒▒▓░▒░▒░▒▒▓▒▒░▒░░▒░░▒▒▒░▒▒▒▓▒▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒░░░░▒░▒▒░▒▒▒░▓▓▓▒▒▒▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▓▓▓▒▒▒▒░▒▒▒▒░▒░▒▒▒▒▒▒░▒▒░▒▒▒▒▒▒▒░▒▓▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒░▒░▒▒░▒░▒░▒▒░▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓░▒▓▓▓▓▓░▒░▓▓▒▒▒▓▒░▒▒▒▒▒▒░░▒▒▒▒▒░▒▒▒▒▒▒▓▒▓▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒░░▒▒▒░░▒░░▒▒░▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▓▓▓▒▒░░▒▒░░▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒░░▒▒▓▒▒▒░▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒░▒▒░░░▒░▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▓▓▓▓▓░▒▒▒▒▒░▒▒░▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▓▒▒░▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒░░▓░▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒░▓▓▒▒░▒░▒▒▒▒▒░▒░░▒▒▒░░▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▓▒░▓▓▓▓░▒░░░▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒░▒▒▒▒▒▒▒░▒▓▓▒▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▓▒▒▒░▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░▓░▒▓▓▒▒▒▒▒▒▓▓▓▓▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▓▒▒▒▒▒▒░░░▒▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓░▓▓▓▓▓▒▒▒▓▒▒▓▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▒▒▒▒▒▒▒▒▒░░░░▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒░░░░▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░▒▒▒▒▒▒▒░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒░░░░░▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░▒▒▒░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒░░░░░▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▓▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▓▒▒▒▒░▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▓▓▓▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒░▒░░░░░░░▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒░▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒░▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░░░░░░░░░▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒░░░░░░░░░░▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒░▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒░▒▒▒▒▒▒░▒░░░░░░░░░░▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░▒▓▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒░▒░░░░░░░░░░░▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒░░░░░░▒▒▒░▒░░░░░░░░░░░▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒░░▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒░░░░░░░▒▒▒▒░░░░░░░░░░░░▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░▓▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒░░░░░░▒▒▒▒░░░░░░░░░░░░░░▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░▓▒▒▒▒░▒▒▒▒▒▒▒▒▒▒░▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒▒░░░░░░░░░░░░▓
        ▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▓▒▒▒▒▒░░░░░░▒▒▒▒▒▒▒▒░░░░░░░░░░▒▓▓▓
        ▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▓▒▒▒▒░░░░░░░▒▒▒▒▒░▒▒░░░░░▒▒▒▒▒▒▓▒▓▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▓▒▒▒▒░▒▒▒▒░▒▒▒▒▒▒▒▒▒░░░░░░░▒▒▒▒▒▒▒▓▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▒▒▒▒▓▓▒▒▒▒░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░▒▒░░▒▒▓▒▒▓▓▓▓▒▓▒▒▒▓▓▒▒▒▒▒▒▒▒░▒▒▒▒▒▒░▒▒▒▒▒░░░░▒▓▓▓▓▒▒░▒░░▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░▒▒░░▒░▒▒▒▓▓▒▒▒▒▒▓▓▒▒▒░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▓▓▓▓▒▒▒▒▓▓▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▓▓▒▒░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▓▓▓▒▒▒▒▓▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒░░░░▒▒░▒▒▒▒▒▓▓▒░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▓▓▒▒▓▒▒▓▓▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒░▒▒▒▒▓▒░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▓▓▒▒▓▒▓▓▓▓▒▒▓▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▓▓░▒░▒░▒▒▒▒▓▒░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▓▒▓▓▒▓▓▓▓▓▓▓▓▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▓▓▒░░░░▒▒▓░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▓▓▒░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▓▓▓▓▓▓▓▓▒▒▒▓▓▓▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒░▒▒▒▒░░░▒▒▓▓▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▓▓▓▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▓▓▓▓▓▒▒░▒▒▒▒░░░▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒▒▓▓▓▓▓▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▓▓▓▓▓▓▒░░▒▒░░▒▒▒▓▓▓▒▒▒▒░▒▒▒▒▒▒▒▒▒▒░░░░░░░░░▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▓
    ";
    Saitama = "
        ▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒
        ▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒░▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒░▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓░▒░░░░░░░░░▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒░░░░░░░░░░▒
        ▒▒▒▒▒▒░░▒▒▒▒▒▓░░▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓░▒░░░░░░░░▒
        ▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒░░░░░░▒
        ▒░░▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓░▒░▒▒▒░░░▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓░▒▒░░▒▒▒░▒
        ▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒░░░░░░▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒░░░░░░░░▒
        ▒░▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒░▒░░░░░░▒
        ▒░░▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▒░░▒░░░░░▒
        ▒░▒░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒░░▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▒░▒░░░░░░▒
        ▒░░░░▒▒▒▒▒░▒▒▒▒▒▒▒▒▒░░▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▓░▒░░░░░░░▒
        ▒▒░▒░░▒▒▒▒░▒▒▒▒▒▒▒▒░░▓░▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▓░▒░░░░░░░▒
        ▒░▒░▒░░▒▒▒▒░▒▒▒▒▒▒▒░▒▓▒▒▒▓▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓░░░░░░░░░▒
        ▒▒░▒░▒▒░▒▒▒░░▒▒▒▒▒▒▒▓░▓▒▒▓▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓░░░░░░░░░░▒
        ▒▒▒▒▒░▒░░▒▒▒░░▒▒▒▒░▓░▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒░░░░░░░░░░▒
        ▒▒▒▒▒░▒░░░▒▒░░░▒▒▒░▒░▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓░░░░░░░░░░░▒
        ▒▒▒▒▒▒░▒░▒░▒▒░░▒▒▒░▓▒▓▓▓▒▒▒▓▓▓▓▓▓░░▒▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒░▒░▒░▒▒░░▒▒▒▒▓▒▓▓░░▓▓▓▓▓▓▓▓░▒▒▒░▒▓▓▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒░▒▒▒▓▓░▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒░▒▒▒░▒▒▒░░▒▒▒░▒▓▒▓▓░▓▓▓▓▓▓▓▓▓▒▒▓▓▒▒▒░▒▒▒░▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒░░▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒░▒▒▒▒░▒▒░▒▒░░░▓▒▒▓▓▒▓▓▓▓▓▓▓▓▓▒░▓▓▓▓▓▒░░░▒░▓▓▓▒▒▒▒▒▓▓▓▓▒▓▓▓▓▓▒▒▒▒▒░░▒▒▒▒▒░░▒▒▓▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒░░▒▒▒░▒░▒▒░░▒░▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▒▒░░▒▒▒▒▒░▒▓▓▓░▓▓▒▒▒▒▒░░░▒▒▒▒▒▒▒░▒▓▓▒░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒░▒▒▒░▒░▒░░░░░▓▓░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▒▒▒░░░▒░░▓▓▓▓▒▒▒▒░░▒░▒▒▒▒▒▒▒▒░▓▓▓▓▒▒░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░░▒▒░░░░░▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░▒▒▒▒▒▒░░░░▒▓▓▓▓▓▓▓▒▒░▒▒▒▒▓▓▒▒░▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒░░░▒▒░▒▒░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▒▒▒░▒▒▒▒▒░▒▒▒░▒▒▒▒░░░▓▓▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒
        ▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒░▒░░░░░░░▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒░░░▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒░░░░░░▒░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▓░▒░▒▒▒▒▒▒▒▒▒▓▓░░░░░▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒░░░░▒▒░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓░▒░▒▒▒▒▒▒
        ▒░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░░▒▒░░░▒░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░▒▒▒▒▒▒▒▒▒▒▒░░▓▓▒░▒▒▒▒▒▓▓▓▓▒░▒▒░▒▒▒▒▒▓▒
        ▒▒▒░▒▒▒▒▒▒▒▒▒▒▒░▒▒░░▒▒░▒▒░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░▒▒▒▒▒▒▒▒▒▒░░▓▓▓░▒▒▓▓▓▓▓▓▒░▒▒▒▒▒▒▒▒▓▓▓▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░░▒░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░▒▒▒▒▒▒▒▒▒▒▒░▓▓▓░▓▓▓▓▓▓▓▒░▒▒▒▒▒▒▒▓▓▓▓▓▓▒
        ▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒░▒▒▒░░▒░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒░▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓░▓▓▓▓▓▓▒░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒░▒░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▒▓▓▓▓▓▒░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒
        ▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒░▒▒▒▒░▒░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓░▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▓▓▒▒░▒░▒░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒░░░░░▒▒░░▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓░▒▒░░▒░░░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒
        ▒▒▓▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒░▒░░░░▒▒▒▒░▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒░░░░░░░░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒
        ▒▒▒▓▒▒▒▒▒░▒▒▒▒▒░▒▒▒▒▒▒░▒▒▒▒▒▒▒▒░░░▒▒▒▓░░▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓░░░░░░░░░░░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒
        ▒▓▓▒▒▓▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒░▒░░▒▒▒▒▒░░▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░▒▒▒▒▒▓▓▓▓▒░▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒
        ▒▓▓▓▓▒▓▒▒▒░░░▒▒▒▒▒░▒▒▒▒▒░▒▒▒▒▒▒░▒░░▒▒▒▒▒░░░▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░▒▒▒▒▒▓▓▓▓▒▒▒▓▓▓▓▓▓▓▒░▒▒▒▒▒▒
        ▒▓▓▓▓▓▓▒▒▒▒▒░░░▒▒▒▒░▒▒▒▒▒░░░▒▒▒▒░▒▒▒▒▒▒▒▒░░░░▓▓▓▓▓▓▓▓▒▒▒▒▒▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓░▒▒▓▓▓▓▓▓▓░▒▒▒▒▒▓▒
        ▒▒▒▓▓▓▓▓▓▓▒▒▒░▒░▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒░░▒░▒▒▒▒░░░░░░▓▓▓▓▒▒▒▒▒░▓░▒░░░░░░░░▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓░▒▒▒▒▒▓▓▒
        ▒░░▒▒▓▓▓▓▓▓▓▒▒▒▒▒░▒▒▒▒▒▒▒▒▒░░░░░▒▒░░▒░▒▒▒▒░░░░░░░░░░░░░░▒░▒▒▒░░░░░░░▒▒▒▒▒▒▒▓▓▓▓▓▓░▒▒▒▓▓▓▓▓▒▒▒▒▒▒▓▓░▒
        ▒░░░▒░▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒░░▒▒▒▒░░░░░▒▒▒░▒▒▒▒▒▒░░░░░░░░░░░░▒▓░▒▓▒░░░░░░░▒▒▒▒▒▒▒▒▓▓▓▓▓░▒▒▓▓▓▓▓▓▒▒▒▒▒▓▓░▓▒
        ▒▓▒▒▒▒▒░▒▒▓▓▓▓▓▓▒▒▒▒░▓▒▒░▒▒▒▒░░░░░░▒░░▒▒▒▒▒▒░░▒▒▒░░░░░▒▒▒░▒▓▒▒░░░░░▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▓▓▓▓▓░▒▒▒▒▓▓▒▓▓▒
        ▒▒▒▒▒▒▒▒░░▒░▓▓▓▓▓▓▒▒▒▒▒▒▒░▒▒▒░░░░░░░░░░▒▒▒▒▒▒░░▒▒░░░▒▒▒▒░░▒▒▓▒▒░░░░▒▒▒▒▒░░░▒▒▓▓▓▓▒▒▓▓▓▓▓▒▒▒▒▒▓▓▒▒▓▒▒
        ▒▒▒▒▒▒▒▒▒░░░░▒▓▓▓▓▓▓▒▒▒░▓▒░▒▒▒░░░░░░░░░░▒▒░▒▒░░░▒░░▒▒▒▒▒░░░▒▒▓▒░░░░▒▒▒▒▒░░░░▒▒▓▓▒▒▒▓▓▓▓▒▒▒▒▒▓▓▓▒▓▒▒▒
        ▒░░▒▒▒▒▒░░░░░░░▒▓▓▓▓▓▓▓▒▒░▓▒▒▒▒░░░░░░░░░░▒▒░▒▒░░▒▒░▒▒▒▒▒░░░░▒▓▒▒░░░░▒▒▒▒░░░░▒▒▓▓▒▒▓▓▓▓▓▒▒▒▒▒▓▓░▒▓▒▒▒
        ▒▓▒▒░░░░░░░░░░░░░▒▒▓▓▓▓▓▓▒▒▒▒░▒▒░░░░░░░░░░▒▒▒▒▒░░░▒▒▒▒░▒░▒░░░▒▓▒░░░░▒▒▒▒▒░░░░▒▓▓▒▓▓▓▓▓░▒▒▒▒▓▓░▒▒▒▒▒▒
        ▒▓▓▓▓▓▓▓▒▒▒▓▒▒▒▒▒▒▒░▒▓▓▓▓▓▓▒▒▓▒▒▒░░░▒▒░░░░░▒▒▒▒▒░░▒▒▒▒▒▒░░░░░░▒▒▒░░░▒▒▒▒▒▒░░░▒▓▓▒▓▓▓▓▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▓▓▓▓▒▒▒▒▒▒▒░░▒▒░░░░░▒░▒▒░░░░▒░▒░▒▒░░▒░░▒▒░░░░▒▒▒▒▒▒░░▒▒▓▒▓▓▓▓▒▒▒▒▓▓▒▒▒▒▒▒▒▓▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▓▓▓▒▒▒▒▒▒░░▒░░░░░▒▒░▒▒░░░▒░▒░░▒▒░░▒░▒▓▒░░░░▒▒▒▒▒▒░▒▒▒▒▓▓▓▒▒▒▒▒▓░▒▒▒▒▒▓▓▓▒
        ▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▓▓▒▒▒▒▒▒▒░░░░░░▒▒░▒▒▒░░░░▒▒░░▒▒▒░▒░▒▓▒░░░░░░▒▒▒░▒▒▒▒▓▓▒▒▒▒▒▓░▒▒▒▒▒▓▓▓▓▒
        ▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▓▓▒▒▒░░▒▒░▒▓░░▒▒░░░░░▒▒▒░░░▒░▒░░▒▒▒░░░░░░░▒▒▒▒▒▒▓▓░▒▒▒▓▒▒▒▒▒▓▓▓▓▓░▒
        ▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▓▒▒▒▒░░▒░░▒▒▒▒░▒░░░▒▒░▒▒░▒▒▒░░░░░░░░░▒▒▒▒▓▒▒▒▒▓░▒▒▒▓▓▓▓▓▒░░▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░▒▒▒▒▒▒▒░▒▒▒▒░▒▒░▒▒▒░░▒▒▒░░░░░░░░░▒▒▒▒░▒▒▒░▒▒▓▓▓▓▓▒░░░░▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░░░▒░▒▒▒░░░▒▒▒░░░░░░░░▒▒▒░▒▒▒░▒▓▓▓▓▓▒░░░░░░▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒░░░▒░░░░░░▒▓▒░░░░░░░▒░░▒▒▒▒▓▓▓▓▒░░░░░░░░▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░░░░░░░░░░░░░░░░░░░░░░░▒░▓░░░░░░░░░░░▒▓▓░░░▒▒░░░▒▒▒▒▓▓▓▒░░░░░░░░░░▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▒░░░▒▒▒▒▓▓▓░░░░░░░░░░░░░▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒░░░░░░░░░░░░░░░░░░░▒▒░░░░░░░░░░░░░▒▓▓▒▒▓▓▓▓▓░░░░░░░░░░░░░░░▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓░░░░░░░░░░░░░░▒▓▒░░░░░░░░░░░░░░░░░░░▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒░░░░▒░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░▒▒▒▒▒▒▒░░░░▒▒▒▒░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░▒▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒▒░░▒░░░░░░░░░░░░░░░░░░░░░▒░░░▒░░░▒▒▒▒▒▒▒▒▒▒▒▒░▒░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░▒
        ▒▒▒░░░░░░░░░░░░░░░░░░░░░░▒░░░▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░▒▒░░░░░░░░░░░░░░░░░░░▒░▒░░░░░░░░░░░▒
        ▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒░░░░░░░░▒▒░▒░▒░░░░░░░░░░░░░▒▒▒▒▒░░░░░░░░░░░▒
        ▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒░▒▒░░▒▒░░░▒░░░░░▒▒▒▒▒▒▒▒▒░░░░░░░░░░▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
            ";
    LLawliet = "
        ▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒░░▒░░▒▒░▒▒▒░▒░░▒░░▒▒▒▒░░▒▒▒▒▒▒▒░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒░░░░▒▒▒░░░░░░░░░░░░░░░░▒░░░░░░▒▒▒▒░▒▒░▒▒▒▒▒▒▒
        ▒░▒░░▒░░▒▒▒░▒░░▒░░▒▒▒░░░▒▒▒▒░░░░░░░▒▒▒▒░░░░▒▒▒▒░░░░░▒▒▒░▒░▒░░░░▒▒░░░░░░░░░░░░░░░░░░▒░░░░▒▒░░▒░▒▒▒▒▒▒
        ▒▒░░▒░░▒▒░░▒░░▒░░░░▒░░▒▒▒▒░░▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒░░░░▒▒▒░░░▒▒░░░░░░░░░░▒▒░▒░░░▒░░░░░░░░░░░░▒░░░▒▒▒░▒▒▒▒▒
        ▒░░▒░░▒▒░░▒░░░░░░░▒░▒░░░▒▒░░░░░░░░░░░░▒▒░░░░▒▒▒▒▒░░░░░▒▒▒▒▒░░░░▒░░░░░░▒▒▒▒▒░░░░░░░░░░░░░▒▒░░░▒▒▒▒▒▒▒
        ▒▒░░▒▒░░░▒░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒░░░░░░▒▒░░░░░▒▒▒▒░░░░░░▒▒▒▒░░░░░░░░░░░▒▒▒░▒▒▒▒░░░░░░░░░▒▒▒▒░▒▒▒▒▒▒
        ▒░░▒▒░░░▒░░░░░▒▒░░░░▒░░░░░░░░░░░░░░░▒▒▒▒░░▒▒░░░░░▒▒▒▒▒░░░░░░▒▒▒▒▒░░░░░░░░░░▒▒░░▒▒▒░░░░░░░░▒▒▒▒▒▒▒▒▒▒
        ▒░▒▒░░░▒░░░░░▒░░░░░░░░░░░░░░░░▒░░░░▒▒▒▒░░░░▒▒░▒▒░░░░▒▒▒▒░▒░░░░░▒▒▒▒░░░░░░░░░░▒▒░▒▒▒░░░░░░░░▒▒▒▒░▒▒▒▒
        ▒▒▒░░░▒░░░░░░▒░░▒▒░░░░░░░░░░░░░░░▒▒░░▒░░░░▒▒▒▒▒▒▒▒░░░░▒▒▒▒░░▒░░░░▒▒▒░▒▒░░░░░░░▒▒░░▒▒░░░░▒░░░▒▒▒▒▒▒▒▒
        ▒▒░░░▒░░░░░░▒░░▒▒░░░░░░░░░░░▒▒░░░░░░▒▒░░▒▒░░░░▒▒▒▒░░░░░░▒▒▒░▒░░▒░░░▒▒▒░▒▒░░░░░▒▒▒░░░▒▒░░░▒░░░▒▒▒▒▒▒▒
        ▒░░░░░░░░░▒░░░▒▒░░░░░░░░░░░░░░░▒░░░░░░░▒░░░░░░░▒▒░░░░░░░░░▒▒▒░░░░▒░░░▒▒▒░░░░░░░░▒▒░░░░▒░░░▒░░░▒▒▒▒▒▒
        ▒░░▒░░░░░░░░░▒▒░░░░░░░░░░░░░░░░░▒▒▒░░░░▒▒░▒░░░░░▒▒░░░░░░░░▒░░▒░░░░░░░░░▒▒▒░░░░▒░░░▒░░░░▒░░░▒░░░▒▒▒▒▒
        ▒░░░░░░░▒░░░░▒░░░▒░░░░░▒░░░░░░░░░░░░▒░░░░▒░░░▒░░░▒▒░░░░░░░░░░░░▒░░░░░░░░░▒▒▒░░░░▒░░░░░░░░░░░▒░░▒▒▒▒▒
        ▒░░░░░░▒░░░░░▒░░▒▒░░░░░░▒░░░░░░░░░▒░░░░░░░░░▒░░▒░░▒▒░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░░░░░░▒░░░░▒░░▒▒░▒▒▒▒
        ▒░░░░░░░░░░░░▒░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░▒▒░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░▒░░░▒▒▒▒▒
        ▒░░░░░░░░░░░░▒░▒░░░▒░░░░░▒░░░░░░░░░░░░░▒░░░░░░░░▒░░░▒▒░░░░░░░░▒░░░░░▒░░▒░░░░░░░░░░░░░░░░░░░░░░░▒░▒▒▒
        ▒░░░░▒▒░░░░░░▒░░░░▒░░░▒░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░▒░░▒▒░░░▒░░░░░░░░░░░░░░░▒░░▒░▒▒
        ▒░░░░▒░░░░░░░▒░░░░▒░░░▒░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░▒░▒▒▒░░░░░░░░▒▒░░░░░▒░░░░░░░░░░░░░░░░░░░▒░▒░▒▒
        ▒░░░░░░░░░░░▒░░░░░▒░░░▒░░░░░▒░░▒░░░░░░░░░░░░░░▒░░░░░░░░░▒░░▒▒░░▒░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░▒▒▒░▒
        ▒░░░░░░░░▒░░▒░░▒░░▒░░░▒░░░░░░▒░░░░░░░░░░░░░░░░░░░▒▒▒░░░░▒▒▒░░░▒░▒░░░░░░░▒▒░░▒░░░░░░░░░░░░░▒░░░░▒▒▒▒▒
        ▒░░░░░░░▒░░░▒░░░░▒░░░░▒░░░░░░░░░▒░░░░░░░░░░░░░░░░░░▒▒▒▒░▒░▒▒▒░░░░░▒░░░░░░░▒░░▒░░░░░░░░░░░░░▒░░▒░░▒▒▒
        ▒░░░░░░░▒░░░░░░░░▒░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░░▒▒▒░░░░░░░░▒░░░░░░▒░░░▒░░░░░░░░░▒░░░▒▒░▒
        ▒░░░░░░░░░░░░░▒░░▒░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░▒░░▒▒▒░░░░░░░░░░░░░░▒░░▒▒░░░░░░░░▒░░░░▒░▒
        ▒░░░░░░░░░▒░░▒░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░▒░░▒▒░░░░░░░░░░░░░▒░░▒░░░▒░░░░░▒░░░░░▒
        ▒░░░▒░░░░░░░░▒░░░░░░░░▒░░░░▒▒▒░░▒░░░░░░░░░░░░░░░▒▒▒░░░░░░░░░░░░░░░░▒▒░░░░░░░░░░░░░░▒░░░░░░░░░░▒░░░▒▒
        ▒░░▒░▒░░░░░░░░░░░░░░░░░░░▒░▒░░░░░░▒░░░░░░░░░░░░░░▒▒▒▒░▒▒▒░░░░░░░░▒░░░░░░░░░░░░░░░░░▒░░░░░░░░░░▒░▒░░▒
        ▒░▒░░▒▒░░▒░▒░░░░░░░░░░░░░░░░░▒▒░░░░░░░░░░░▒▒░░░▒░░▒▒▒▒░▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░▒░░▒
        ▒░░░▒▒░░░░░▒░░░░░░░░░░░░░░▒░░▒▓▒░░▒░░░▒░░░░▒▒▒░░▒▒░▒▒▒▒░▒░░▒▒░░░░░░▒▒░░░░░░░░░░░░░▒▒░░░░░░▒░░░░▒░▒▒▒
        ▒░░░▒░▒░░▒░░░░░░░░░░░░░░░░░▒░░▒▓▓▓▓▒▒▒▓▒░░░▒▒▒▒▒░░▒▒▒▒▒▒░░▓▓▓▒▒▒▒▓▒▒░░░▒░░░░░░░░░░▒░░▒░░░░░░░░░░░░▒▒
        ▒░░░░▒░░░▒▒░░░░░░░░░░░░░░░░▒▒░░░░░▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒░░░░░░░░░▒░░░░░░░░░░░░░░░░▒
        ▒░░░░▒░░░░▒░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒░▒▓▓▓▓▒▒░▒▒▓▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒░░▒░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒░░░▒▒░░░▒░░░░░░░░░░░░░░░▒▒▒▒▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒░░▒░░░░░░░░░▒░░░░▒░░░░░░░░▒
        ▒░░░░░▒░▒░░░▒░░░░░░░░░░░░░▒▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒░▒▒░░░░░░░░░▒░░░░░░░░░░░░░▒
        ▒░░░░░░▒░░░▒▒▒░░░░░░░░░░░░░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒░░░░░░░░░▒░░░░░▒░░░░░░▒▒
        ▒░░░░░░▒▒▒▒▒▒▒░░░░░░░░░░░░░▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒░░░░░░░░░▒░░░░░▒░░▒░░▒░▒
        ▒░░░▒▒▒▒▓▒▒▒▓▒░░░░░░▒░░░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒░░░░░░░░░░▒░░░▒░▒▒░▒▓░▒▒▒
        ▒▒▒▒▓▓▓▓▓▒▓▓▒░░▒░░░░▒░░░░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒░░░░░░░░░░░▒░▒▒▒▒▒▒░▓▓▒▒▒
        ▒▓▓▓▓▓▓▓▒▓▓▒░░▒▒▒░░░▒▒░░░▒░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒░░░░░░░░░▒▒░▒░▒▒▒▒▒▒▒▒▓▓▒▒
        ▒▓▓▓▓▓▓▓▓▓▓░░▒▒▒▒▒░░▒▒▒░░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒░░▒░░▒░░░▒▒▒░▒▒▒▒▒▒▒░▓▒▓▓▒
        ▒▓▓▓▓▓▓▓▓▓░░▒▒▒▒▒▒▒░▒▒▒▒░░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒░░░▒▒░▒▒░░░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▓▒
        ▒▓▓▓▓▓▓▓▓▒░▒▒▒▒▒▒▒▒▒░▒▒▒▒░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒
        ▒▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓░▒▒▒▒▒▒▒▒▓▓▒▓▓▓▓▓▒▒▒▒▓▓▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒░▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒
        ▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒
        ▒▓▓▓▒▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▒▓▒▒▒▓▓▓▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒
        ▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▒▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▓▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▓▓▓▓▓▓▒▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▒▓▓▓▒▓▓▒▒▒▓▒▒▓▒▒▒▒▒░▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▒▓▓▓▓▒▒▒▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▒▓▓▓▓▒▒▒▒▒▓▓▓▒▓▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▓▓▓▓▓▓▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒░░▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▒▒▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒▒▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▒
        ▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▓▓▓▓▓▒
        ▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▒▒
        ▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▒▒▒
        ▒▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒
        ▒▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒
        ▒▓▓▓▓▒▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒
        ▒▒▓▓▓▒▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒
        ▒▓▓▓▓▓▒▓▓▒▓▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▒
        ▒▓▓▓▓▒▓▓▓▓▒▓▓▓▒▒▒▒▓▓▓▓▒▒▒▓▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▒▒
        ▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▒▒▒
        ▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒
    ";
    Frieren = "
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▒▒▓▓▓▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▒▒▓▓▒▒▓▒▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▒▒▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▒▓▓▓▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▒▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓
        ▒▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▒▓▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▒▓▓▒▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▒▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▒▓▓▒▓▓▓▓▓▓▓▓
        ▓▓▓▓▒▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▒▓▒▓▓▓▓▓▓▓▓
        ▓▓▓▒▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▒▓▓▒▓▓▓▓▓▓▓
        ▓▓▓▒▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓
        ▓▓▒▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒▒▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▓▒▓▓▓▓▓▓
        ▓▓▒▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▒▓▓▓▒▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓
        ▓▒▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▒▒▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▒▒▓▓▓▓▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▓▒▓▓▓▓▓
        ▓▒▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▒▓▓▓▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▒▒▒▒▓▓▓▓▓▓▓▓▓▒▓▒▓▓▓▓▓
        ▒▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▒▓▒▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▒
        ▒▓▓▓▓▒▒▒▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▒▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▓▓▓
        ▒▓▓▓▒▒▒▒▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▒▓▓▓▓░▒▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▓▓▓▒▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒
        ▒▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒░░░░░▒░░▒▒▓▒░▒▓▓▓▓▓▓▓▒▓▒▓▒▒▒▓▒
        ▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░▒▒▒▒▒▒░▓▓▓░░▓▓▒▓▓▓▓▓▓▓▒▓▒▓▓▓▒▓▒
        ▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒░░▒▒░▓▓▓▒▓▓▓▒▓▓▒▓▓▓▓▒▓▒▒▓▓▒▓▓
        ▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▒▒░░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒▒▓▓▓▓▓▓▓▒▓▓▒▓▓▓▒▒▒▒▓▓▒▓▓▓
        ▓▓▓▓▒▒▒▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▒░░░▒▒▒▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓░▓▒▓▓▒▓▓▓▒
        ▓▓▓▓▒▒▒▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░▒▓▒░▒▒░░░▒▒░▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▓▓▒▒▓▒▓▒▓▓▓▒▓
        ▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒░▓▓▓▓▓▓▓▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▓▓░▓▒▓▒▓▓▓▒▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒▒▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▒▒▒▒▒▓▓▓░▓▓▓
        ▓▓▒▓▓▓▒▒▒▒▒▓▒▒▒▓▓▒▓▓▓▓▓▓▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▓▓▒▒▒░▓▓▓▓▒▒▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒▓▒▒▓▓▓▓▓▓▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒░▓▓▓▒▓▓▒▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▒▒▓▓▓▓▓▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒░▒▓▓▓▒▓▒▓▓▒▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▒▒▒▒▓▓▓▓▓▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▓▓▒▓▓▒▓▓▓
        ▒▒▒▓▓▓▓▓▓▓▓▒▓▒▒▒▒▓▒▒▒▒▓▓▓▓▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▒▓▓▒▓▓▓
        ▓▓▓▓▓▓▒▒▓▓▓▒▓▒▒▒▓▓▒▒▒▒▒▓▓▓▓▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▒▓▒▓▓▒▓▓▓
        ▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▓▓▓▒▓▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▒▓▒▓▓▒▓▓▓
        ▓▓▓▒▓▓▓▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▒▓▒▓▓▓▓▓▓
        ▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▓▒▒▓▒▓▒▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▒▓▒▓▓▓▒▓▓
        ▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▒▓▓▓▓▓▒▓▓
        ▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▓▓▓▓▓▒▓▓
        ▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▓▓▓▓▓▓▓░▒▒▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▓▓▓▓▒▓▓
        ▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▓▓▓░▒▒▒▒▒▒▒▒▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▓▓▒▓▒▓▓
        ▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▓▓▓▓▓▒▓
        ▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▓▓▓▓▓▒▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▓▓▒▒▓▒▒▒▒▒▒▒▓▒▓▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▓▓▓▒▓░▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▓▒▓▓▒▓▓▓▓▓▒░░░▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▓▓▓▓▒▓▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▓▓▓▓▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▓▓▓▓▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▓▓▓▓▒▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒░▒▒▒░░▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓
        ▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓
        ▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒░░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓
        ▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓
        ▒▒▒▒▒▒▓▓▓▓▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓
        ▒▒▒▒▒▓▓▓▓▓▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▒▓▓▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▒▓▓▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒░▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▓▓▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▓▓▒▒▒▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▓▓▓▒▒▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▓▓▒▒▓▓▓▓▓▓▓▓▓
    ";
    ErwinSmith = "
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▓▓
        ▒▒▒▒▓▓▓▓▓▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▒▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓
        ▓▓▓▓▓▓▓▓▓▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▒▒▒▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒
        ▒▒▒▒▓▓▒▒▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▒▒▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓
        ▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▒▒▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▓▓▓▓▒▒▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░░░▒▒▒▒▒▒▓▓▒▒░░░▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▒▒▒▒▒▒░▒▒░░░▒▒▒▒▒▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒░▒▒▓▓░▓▓▒▓░▓░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▓▓▓▒▒▒▒▒▒░░░░▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒░▒░░░░░░░░░░▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▒▒▓▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒░▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓
        ▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▓▒▒▒▓▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒░▒▒▓▓▒▒▓▒▒▒▒▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▓▓▒▓▒▒▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓░▓▓▓░▒▒▒▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▒▓▓▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▒▒░░▒▒▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▒▒▒░▒▒▓▒▓▒▓▓▓▓▓▓▓▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▒▒▒▓▓▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▓▓▓▒▒▒░░▒▒▒▒░▒▒░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▒▒▒▓▓▓▒▒▒▒▒▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░▓▓▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░▒▓▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▒▒▓▓▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▒░▒▓▓▓▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░▒▓▓▓▒▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░▒▒▒▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒▒
        ▓▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒░░░▒▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░░▒▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒
        ▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒░▒▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▒░▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒▒░▒▒▓▓▓▓▓▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒▒▓▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▓▓▓▓▒▓▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▒▒▒▒▒░░▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒░░▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒░▒▒░▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒░▓▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒░▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒░▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒░▒▒▒▓▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒░▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒▒▒░░░░▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░░░░░░░░░░░▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░░░▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒▒▒▒▒▒▒▒░░░░░▒░▒▒▒░░▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒░▒▒▒▒░░░░░░▒▒▒▒▒░▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
    ";
    TanjirouKamado = "
        ▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒░░░░░░░░░░░░░░░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░
        ▒▒▒▒░░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒░░░░░░░░░░░░░░░░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░▒▒▒░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░▒░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░▒▒▒░░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░▒▒░░░░░░░░░░▒░
        ░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░▒▒▒░░░░░░░░░░░░░░▒▒▒▒▒▒▒░░░░░▒▒░
        ░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░▒▒░░░░░░░░░░░░░░▒▒▒▒▒░░░░▒▒▒▒▒
        ░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░░░░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░▒▒▒▒░░░░░░░░░░░░░▒▒░░░░░░░░░░░░░░░░░▒▒▒░▒▒▒▒▒░
        ░░░░░░░░░░░░░░░░░░░░░░▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░▒▒▒░░░░░░░░░░░░░▒▒▒░░░░░░░░░░▒░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░▒▒░░░░░░░░░░░░▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░▒▒▒░░░▒▒▒▒░░░░░░░░░░░░░░░░▒▒▒▒▒░░░░░░░░░░░░░▒▒░░░░░░░░░░░░░▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░▒▒▒▒▒░░░░░░░░░▒▒░░░░░░░░░░░░▒▒░░▒▒▒▒▒░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░░░░░░░░▒░░░░░░░░░░░░▒▒▒░░░▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░░░░░▒░░░░░░░░░░░▒▒░░░░░▒▒░░░▒▒▒░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░▒░░░░░▒▒░░░░░▒▒▒▒░░░░░░▒▒░░░░░░░░░░░░░░░░░▒░░░░░░░░░░▒▒░░░░░▒▒░░░░░▒▒░░░░░░░░░░░░░░░
        ░░░░▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒░░░░░▒▒▒░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒░░░░░░░░▒░░░░░▒▒▒░░░░░░░░░░░░░░░
        ░░░░░▒▒▒░░░░░░░░░░▒░░░░░░▒▒▒░░░░░░░░░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░░░░░░░░░░░░░▒▒▒░░░░░░░░░░░░░░░░
        ▒▒░░░░░▒▒▒▒▒░░░░▒░░░░░░▒▒▒░░░░░░░░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░░░░░░░░░░▒▒▒▒░░░░░░░░░░░░░░░
        ▒▒░░░░░░░▒▒▒░░░▒░░░░░░▒▒░░░░░░░░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░▒▒▒░░░░░░░░░░░▒▒
        ▒░░░░░░░░▒░░░░▒░░░░░▒▒░░░░░░░░░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░░░░░░░░░░░░░░▒▒░░░░░░░░░░░░
        ░░░░░░▒▒░░░░░▒░░░░▒▒░░░░░░░░░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░▒▒▒░░░▒░░░░░▒░░░░░░░░░░░░░
        ░░░░░░▒░░░░░░░░░░▒▒░░░░▒░░░░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒░░░▒░░░▒░░░░░░░░░░░░░░
        ░░░░░▒░░░░▒▒░░░░▒▒▒░░░▒░░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒░░░▒▒░░░░░░░░░░░░
        ░░░░▒░░░░░▒░░░▒▒▒▒▒░░░▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒░░░▒░░░░░░░░░░░░
        ░░░▒░░░░░▒▒░░░▒▒▒░░▒░▒▒░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▒▒░░░░░░▒░░▒░░░░░░░░░░░░
        ░░░░░░░░░▒▒░░░░▒▒░░▒░▒▒░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▒▒▒▒░░░░░▒░▒▒░░░░░░░░░░░
        ░░░░░░░░▒▒▒░░░░▒▒▒░░▒▒▒░░▒▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒▒▒▒▒░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▒▒░░▒▒▒▒▒░░░▒▒░▒▒▒░░░░▒▒░░░
        ░░░░░░░░▒▒▒░░░░░▒░░░▒▒▒░░░▒▓▓▓▓▓▓▓▓▒▒░░░░░░░░░▒▒▒▒▒░░▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒░░▒▒▒▓▓▓▓▓▒▒░░░▒▒░░░▒▒▒▒▒▒░░░░
        ░░░░░░░▒▒▒░░░░░░▒░░░░▒▒░░░▒▓▓▓▓▓▒▒▒░▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒░░▒▒▒░░▒▒▒▓▓▓▒▒░░░▒░░░░░░░▒░░░░░░
        ░░░░░▒▒▒▒░░░▒░░░░▒░░░░▒░░░░▓▓▓▓▓▒▒▒▓▒░░░░░░▒▓▓▓▒░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░▒▒▒░░░▒▒▒▒▒░▒░▒░░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒░░░░░▒░░░░▒░░░░░░░░░▒▓▓▓▒▓▓▓░░░░▒▒░░░░▓▓▓▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▒░▒▒░░░▒▒▒▒▒░▒▓▓▒░▒▒▒░░░░░░░░░░░░░░
        ░▒▒▒░░░░░░░░▒░░░░░▒░░░░░░░░░▒▓▓▓▓▓▒░░░░▓▓░░░░▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░░░░░░▓▓▒▒▒▒▓░░▒▒░░░░░░░░░░░░░░░
        ░░░░░░▒▒▒▒▒▒▒░░░░░░▒░░░░░░░░░▒▓▓▓▓▓▒▒░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░▒▓▓░░░▒▓▓▓▒▓▒░░░▒░░░░░░░░░░░░░░░
        ░░░░░░░░░░░▒▒░░░░░░▒░░░░░░░░░░░▒▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░▒▓▓▓▓▓▒░░▒▒░░░░░░░░░░░░░░░
        ░░░░░░░░░░▒▒░░░░▒▒▒▒▒░░░░░░░░░░░▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓░░░▒▒░░░░░░░░░░░░░░░
        ░░░░░░░░░▒▒░░░░░▒▒▒▒▒▒░░░▒░░░░░░░░▒▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▒░░░░▒▒░░░░░░░░░░░░░░
        ░░░░░░░░░░░▒░░░░▒▒▒▒▒▒▒░░░▒▒▒░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒▒▓▓▓▓▓▒▓▓▓▓░░░░░░░▒▒▒░░░░░░░░░░░
        ░░░░░░░░░░░▒░░░░▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░▒▒░░░░░░░░░░
        ░░░░░░░░░░▒░░░░░░▒▒▒▒▒▒▒▒░░░▒▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░▒▓▓▒▒▒▒▒▒▒░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░▒▓▓▓▒▒▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░▒▒▓▓▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░▒▒░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░▒▒▒▒▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░▒▒▒▒▒▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓░░░░▒▒░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒░░░░░░░░░░░░▒░░░▒▒▓▒▓▓▒░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒▒░░░░░░░░░░░░▒▒░▒▓▓▒▓▓▒░░▒▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░
        ░░▒▒▒▒▒▒▒░░░░░░░░░░░▒▒▒▒▓▓▒▓▒▒░░░░▒▒▒▒▒▒▒░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░
        ░░░░▒▒▒▒▒░░░░░░░░░░░░▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░
        ░░░░▒▒▒▒▒▒░░░░░░░░░░░░▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░
        ░░░░░▒▒▒▒▒▒▒░░░░░░░░░░▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░
        ░░░░░░▒▒▒▒▒▒▒▒░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒▒▒▒▒▒▒▒▒▒░░░▒▒▒░░░░░░░░░░░░░░░░░▒▒▒░░░░░░░░░░░░░░░░░░░
        ░░░░░░░▒▒▒▒▒▒▒▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒░░░░░░░▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒░░░░░░░▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░░░░░░░░░░░░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░░░░░░░░░░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒░░▒▒░░░░░░░░░░░░░░▒▒▒░░░░░░░▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒▒░░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒░░░░░░░░▒▒▒▒▒▒▒░░░░▒▒░░░░░░░░░░░▒▓▒░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒░░░░░░░░░░░▒▒▒▒░░░░░░▒▒░░░░░░░░░▒▒▒▒▒░░░░░░░▒░░░▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒░░░░░░░░░░░░░░▒▒░░░░░░░▒▒░░░░░░░░░▒▒▒▒░░░░▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒░░░░░░░░░░░░░░░░▒░░░░░░▒▒▒░░░░░░░░▒▒▒▒░░░▒▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒░░░░░░░░░░░░░░░░░▒▒░░░░░░▒▒▒░░░░░░░░▒░░▒▒▒░░░░░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒░░░░░░░░░░░░░░░░░▒▒▒▒░░░░░▒▒▒▒░░░░░░░░▒▒▒░░░░▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒░░░░░▒▒▒▒░░░░▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒░░░░░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒░░░░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░▒▒░░
        ▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░░░░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒░░░░░░▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒░░░░░░░░▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░▒▒▒▒▒▒░░▒░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░░░▒▒▒▒▒▒░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒
    ";
    KusuoSaiki = "
        ▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓
        ▒▒▒▒░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓
        ▒▒░▒▒▓▓▓▒░▒░▒▓▓▓▓▓▓▓▓▒▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓
        ▒▒▒░░░▒░▒▓▓▒░░▒▒▓▓▓▓▓▒░▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▓▒▒▒▒▒▒▒▒▒▓▓▒▒▓
        ▓▓▓▓▓▓▓▒░▒░▓▓░░▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▓▓▓▒▒▒▒▒░▒▓▒▒▒▒▒▒▒▒▒▓
        ▓▓▓▓▓▓▓▓▓▓░░▒▓░░░▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓░░▒▒░▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▒░░▓░▒▒▒▒▒▒▒▓▓▓▒▒▒░▓▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▒▒▒▒░▒▒▒▒▒▒▒▒▓░▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▒▒▒░▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒▒▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓
        ▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒░▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓
        ▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▓▓
        ▓▓▓░▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▓▒▓░░▒▓▓
        ▓▓▓▓▓▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒░
        ▓▓▓▓▓▓▓▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▓░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▒▒▒░▒
        ▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒░▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▒▓▓▓▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░▓▒▒▒▒▒▓▓░▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒░▒░▓▓▓░▒▒▒▓▓▒▒▓▓▓▒▒▒▒▒▒░▓▒▒▒▒▒▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒░▓▒▓▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒░▓▒▒▒▓▓▓▓░▒▒▓▓▓▓▓▓▓▓▓░▒▒▒░▓▓░▓▓▒▓▓░▒▒▒▒▒░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▓▓▓▓▓▓▒▒▒▓▒▒▒▒░▒▒▒░▓▒▒▒▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒░▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒░▒▒
        ▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▒▓░▒▒▒▒▒▒░▒▒▒▒▓▓▒░▒▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒░▓▒▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░▒▒░▒▒
        ▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒░▒▒▒░▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒░▒
        ▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓░▒▒▒░▒░▓▓░▒▒▓▓▒▒░▒▒▒▓▓▓▓▓▓▒░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▒▓▓▓▓▓▓░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒░▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒░▒▒▓▓▓▒▓░▒▓▓░▒░▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▒▒▒░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▒░▒▒▒▓▓▓▓░▒▒░▒▒▒░▒░▒░▒▒░░▒▒▒▒▒▓▓▓░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▓▓▓▓▓▓▒░▒▒▒▒▒░▒▒░▓▓▓▓▓░▒░▒▓░▒▒░▒▒▒▒▒▒▒░▒▒▒░░▒▒▒▓▓▒▒▓▓▓▓▓▓▓▓▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▓▓▓░▒▒▒▒░▒▒▒▒▒▒▒▒▒▓▒▒▒
        ▓▓▓▓▒░▒▒▒▒▒▒░▒▒▒▒▓▓▓▓▓░░░▓▓▓▒▒▒░░▒▒▒▒░▒▓▒░▒░░▒▒▒▒░▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒░▒▒▒▒▒▒░▒▒▒▒▒▓▒
        ▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓░▓▓░░▒▒░▓▒▓░▒▒▓▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▓▒░▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒░░▒▒▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▓▓▓▓░░▓░░░▓▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓░▓▒▒░▒▓▓▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒▒▒▒▒░▓▓▒▒▒▒▒▒░▒▒▒░▓▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▓▓▓▓░▒▒▒▒░▒▒▒░▒▓▓▓▓▓▓▒▒░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▓░▓░▒░▓▒░▒▓▓▓░▓▒▒▒▒
        ▒▒░▒▓░▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓░░▒░▒▒▓░▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▒▒░▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▓▓░▒░░▓▓░▒▓▓▓▒▒▒▒▒▒▒
        ▒▓▓░▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓░░▓░░▒▓▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▓▒▓▓▒▒▒▒▓▓▓▒▒▒▒▒▒
        ▒░▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓░▓▓▒░░▓░░▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▒▒▒▒▒▒░▒▓▓▓▒▒▓░▓▒▓▓▒▒▒▓▓▓▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░▓░░░▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓░▒▓░▓▓▓▒▒▒▓▓▓▓▒▒▒▒
        ▒▒▒▒▒░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░▓░░▒▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▒▒▒▒▓▓▓▓▒▒▒▒▒▒▓▓▓▒
        ▒▒░▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▓▓▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒░▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░▒▒▒▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░▓░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓░▒▒▒▒░▒▒░░▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒░▓▒░▓▓░░▓░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░▒░▒▒▒▒▒▓▓▓▒░░▓▒▒▒▒▓▒▒▒▒▓▒▒▒▒▒▒▒▓▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░▒░▓▓▓▓▓▓▒░░▒░▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒░░▒▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▒▓▓▓▓▒▓▒▓▒▓▒▒▒▒▓▓▓▓▓▓▓▒▒▓▓▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▒▒▓▓▒▒▒░░░▓▒▓▒▒▓░░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▒▓▓▒▓▓▓▓▒▒▒▓▒▓▒▓▓▒▓▓▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░▓░░░▒▓▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒░▓▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░▒▒░░░▒▓▓▓▒░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░▒▓▒▓▒▒▓▒▓▓░▒▒▒▒░▒▒▒▒░▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓░░░▒▓▓▓▓▒▓▓▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒▓▓▒▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▒▓▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓░▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▓▓▓▓▓▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒▓▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▒▒▓▓▓▓▓▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▓▒▓▓▓░▓▓▓▓▒▓▓▓▓▓▓▒▒▓▓░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▓▒▒▓░▓▓▓▓▓▓▓▓▒▓▓▓░▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓░▓▓▓▓▓▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▒▓▓▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▒▒▒▒▓▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▓▓▓▓▓▓▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▒▒▓▓▓░▒▓▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▒▒▒▒▒▓▒▒▓▒▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▒▒▒▒▓▒▒▒▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▓▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒░▓▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
    ";
    ArminArlert = "
        ▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▓▒▒▒▒▒░▒▓▒▒▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▒▒▒▒▒▒▓▒▒▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▒▒▒▒▓▓▓▒▒▓▓▓▒▒▒▒▓▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▒▒▒▒▓▓▓▒▓▓▓▓▒▒▒▓▒▒▓▓▒▒▒▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▒▒▒▓▓▓▒▒▓▓▓▓▒▒▒▓▒▒▓▒▓▓▒▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▒▒▓▓▓▒▒▓▒▓▓▒▒▓▓▒▒▒▒▓▒▒▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▒▓▓▓▒▓▒▒▒▓▓▓▓▓▒▒▒▓▓▒▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▓▒▓▒▒▒▒▓▓▒▓▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▓▒▓▒▒▒▒▓▒▒▓▒▒▒▒▒▒▒▓▒▒▓▓▒▒▒▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▓▓▓▓▓▓▓▓▒▒▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▓▓▓▒▒▒▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▓▓▒▒▒▒▒▓▒▒▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▒▒▓▒▓▒▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▓▒▒▒▒▒▒▒▒▓▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▓▓▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▓▒▒▒▓▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▓▓▒▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▓▓▒▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░░░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒░▒▒▒▒▒▓▓▓▒▒▒▒▓▓▓▓▓▒▒▒▓▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▓▓▓▓▓▓▒▒▓▓▒▓▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒░▒▒▓▒▒▒▓▓▓▓▓▓▓▒▒▒▓▓▓▒▒▓▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▓▓▓▓▓▓▒▒▓▓▒▒▓▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒░░░▒░░░▒▒▓▓▓▓▓▒▓▓▓▓▒▒▓▓▓▓▒░▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▓▓▓▒▒▒▓▒▒▓▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▒▒░▒▒▒░▒▒▒░▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒░░░▒▓▓▓▓▓▒▓▒▒▒▒▒▒▒░░░▒▒▒▒░░░░▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▒▒▓▓▒▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒░░▒▒▒▒▒░▒▒▒░░░▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▒▒▒░░░▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒▒▒░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒▒▒▒▒▒▒░▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒░▒▒░▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒░▒░░▒░▒▒▒▒▒▒░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▓▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓
        ▓▓▒░▓▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▓
        ▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒░▒▒▓▒▒▓▒▒▓▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▓
        ▓▓▓▒▓░░▒▓▓▒▒▒▓▒░▒▓▒▒▒▒░▒▒▓▒▒▒▒▒▒▓▓▒▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒▒▓▓▓▒▒▒░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒░▒▒▒▒▒▒░▒▒▒▒▒░▒▒▒▓
        ▓▓▓▓▒░▒▓▓▓▓▒▒▓▒▒▓▓▒▒▒▒░▒▒▓▓▒▒▓▓▒▒▓▒▒▒▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▒▒░▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒░▒▒▒▒▒▓
        ▓▓▓▓▒▒▒▓▓▓▓▓▒▓▒▒▓▓▒▒▒▒▒▒▓▓▓▒▒▒▓▒▒▒▒▒░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒░▒▒▒▒▒░▒▒▒▒▒░░▒▒▒▒▒▒░░░░░░░░▓
        ▓▓▓▓▒▓▒▓▓▓▓▓▓▒▓▒▓▓▒▒▒▓▒▒▓▓▓▓▓▓▒▒▒░▒▒▒░▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒▒░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒░░░░░░░░░░░░░▓
        ▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒▓▓▓▓▒▓▒▒▓▓▓▒▒▒░░▒▒▒░░▒▒▒░▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒░░░░░░░░░░░░░░░░░░░▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▒▒▒░▒▒▒▒░░░░▒▒▒▒▒░░░▒▒▒▒▒▒░░▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░▒▒▒▒░░░░▒░▒▒▒▒▒▒▒░░░░░▒▒▒░░░▒░░▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▓▓▒░▒▒▒░▒▒▒▒▒░░░▒░░░▒▒░░░▒▒░░░░░▒░░▒░▒▒▒░▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▒░░▒▒▒▒░░░░░░░░░▒▒░░░▒░░░░░░░░▒▒▒▒░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒▒▒▒▒▒▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▒▒░░▒▒░▒▒░░░▒░░░░░░▒▒▒░░▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▒▒▒░░▒░░▒▒▒░░░▒░░░░▒░▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒░▒▒▒▒▒░░░▒░░░▒▒░░░▒░░░░░▒░░░░░▒▒▒▒▒▒░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░▒░░▒░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░░░░░░░░░░░░░▓
        ▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒░░░░▒▒░░▒▒░░░░░░░░░▒░▒░░░░░░░░░▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒░░░░░▒░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒░░░░░░▒░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░▒▒▒▒▒▒▒▒▒░░░░░░░░░▒▒░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▓
        ▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒░░░░░▒▒▒▓
        ▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▓
        ▓▓▓▓▓▓▒░▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒░▒░░░▒░░░▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓
        ▓▓▓▓▓▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░▒▒░░░▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▓
        ▓▓▓░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▓▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░▒▒░░▒▒▒▒░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░▓
        ▓▒░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░▒▒░░░▒▒▒▒▒▒░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓
        ▓░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒░░▒▒░░░░░▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░▒░░░░░░░░░░▒▒▒▒░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒░░▒▒▒░░░░░▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░░░▒▒▒▒▒▒▒▒▒░░░░░▒▒▒░░░▒░░░▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▓
        ▓▒░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░▒▒▒▒▒▒▒▒░░░░░░░░▒▒▒▒░░▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░▒▒▒▒▒▒░▒░░░░░░░░▒░▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒░▒▒░░░░░░░░░░▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▒▒░░░░░░░░░░░░░▒▒▒▒░▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒░░░░░░░░░░░░░▒▒░░░░░▒▒▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░▓
        ▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▒▒▒░░░░░░░▒▒▒▒▒░▒░▒░░░▒▒░▒▒▒▒░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░▒▒░░░▒▒▒▓▓▒▓▒▓▒▒▒▒▒▒░▒▒▒▒░▒▒▒▒▒░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▓
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▓▒▒▓▒▒▒▒▓▒▒▓▒▒▒░░▒▒▒░▒▒▒▒▒░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▓▓▒▒▒▒▒▓▓▓▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▒▒▓▒▒▒▒▓▓▒▓▓▒▒▒▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
    ";
    ChopperTonyTony = "
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒░░░▒▒▒▒░░▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒
        ▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒░▒▒
        ▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒
        ▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▓▓▒░▒▒░░░░░░▒░▒░░░░░▒▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░▒▒▒▒▒░░░░▒▒▓▓▓▓▓▒░▓▓▓▓▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒░░▒▒░░░░░▒▒░▒▓▒▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▒
        ▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒░▒▒▒▓▓▒
        ▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░▒▒▓▓▓▓▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▓▓▓▒
        ▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒
        ▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒
        ▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒░▒▒▒▒▒▒▒▒░░▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒░▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒░░░▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░▒▒▒▒▒░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓░▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▓▓▓▓▒▒░▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░▒▒▒
        ▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▓▓▓░▒░░░░░░░▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒░░░░░░░░░░▓▓▓▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░▒▒▒
        ▒▒▒▒▒░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓░▒░░░░░░░░░░▒▒▓▓▓▒▒▒▒▒▒▒▒▒░░░░░░░░░▒▒▒▒
        ▒▒░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓░▒▒░░░░░░░░▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓░▒▒▓▓▒░▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒░▒
        ▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▒▒▒▒▒▒░▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒░░░▒▒░░▒▒▒▒▒▒
        ▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒░▓▓▓▒░▒▒▒▒░▒░▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▓▒
        ▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▓▓▓░▒▒░░░░░░░▒░▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒░▒▓▓▓▒▒▒
        ▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒░░░░░░░░░▒▒▓▓▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒░░▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒▒▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒░░░░░░░░▒▒▒▓▓▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒░▒▓▓▓▓▓▓▓▓▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░░░▒▒▒▒▒▒▒▒▒▒
        ▒▒▒░░░░░▒▓▓▒▒▒▒▒▒▒▓▓▓░▒▒▓▓▒░▒▒▒▒░▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▒░▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒░░░░░░░▓▓▓▒▒▒▒▒░▓▓▓▒░▒▒▒▒▒▒▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒░░░░░░░░▒▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒
        ▒▒▒░░░░░░░░░▒▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▓▒▒▒▓▒░▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒▒▒▒▒▒▒░░▓▓▒▒▒▒▒▒▒▒▒▒
        ▒▒▒░░░░░░░░▒▒░▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒░▒▒░░▓▓░░░░░░░░▒
        ▒▒▒▒▒░░░░▒▒▒▒▒▒░▓▓▓▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▒░░░░░░░▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▓▒░░░░░░▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▓▓░░░░░░▒
        ▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒░▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▒░░░░░▒
        ▒░▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▓▓▓▒▒▒▒▒
        ▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒░░░▒▒▓▓▒▓▓▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▓▒▒▒▒░▒
        ▒░░░░░▒▓▓▒▒▒▒▒▒▒▓▓▓▓▒▒░▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▓▒▒▒▒▒▒
        ▒░░░░░░░▒▓▒▒▓▓▓▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▓▒▒▒▒░▒
        ▒░░░░░░▒▒▒▓▒░▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▓▓▒▒▒▒▒
        ▒░░░░░░▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▓▒▒▒▒░▒
        ▒░░░░▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒░▒▓▓▓▒░▒▓▒▒▒▒▒▒▒▒▓▒▒▓▒▒▒▒▒▒▓▒▓▓▓▓▒▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▓▒▒▒▒▒▒
        ▒░░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▓▓▒░▒░░▒▒▒▓░▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▓▓▓▓▒▓▒▓▓▓▓▓▒▓▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▓▒░▒░▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▒▒▒▒▒▒▒░▒▓▒▓▓░▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▓▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒░░▒░▒▓▓▒░░▒░░▒▒▓▒░▒░▒▓▓▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▓▓▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒░░▒▓▓▒░▒░▒▒▒░▓▓▒░▒▒░▒▓▓▓▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▓▓▒░░▒░▒
        ▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▒░░░░░░▒▓▓▒░░░░░▒▓▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░▒▓▒▒░░░▒▒
        ▒▒▒▒░▒▒▒▒▒▒▒▒▓▓▒░░░░░░▒▓▓▒░░░░░▒▓▓▓▒░▒▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░▓▓▒░░░░▒▒
        ▒▓▒▒▒░▒▒▒▒▒░▓▓▓▒░░░░░▒▓▓▒░░░░░░▒▓▓▓░░░░▒▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░░░░░░░░░░░▓▓░░░░░▓▒
        ▒▒▒▒░░▒▒▒▒░▒▓▓▒▒▒▒▒▒▒▓▓▓▒▒▒▒░▒▒▓▓▓▒▒▒▒▒▒▓▓▓▓▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒░░░░▒▒▒▒░░░░░░▓▓▒░▒▒▒▒▓▒
        ▒░░░░▒▒▒▒░▒▓▓▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▓▓▓▒▒▓▓▓▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒░░░░▒░▒▒▒▒▒░░░░░░▓▒▒▒▒▒▒▒▒▓
        ▒▒▒▒▒▒▒▒░▒▓▓▒▓▒▒▒▒▒▒▓▓▓▒▒▓▒▒▒▒▓▓▓▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒░░▒▒▒▒▒▒░░▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▓▓▒▒▒▒▒▒▒▒▓
        ▒▒▒▒▒▒░▒▓▓▒▓▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▓▒▒▒▒▒▒▒▒▒▓
        ▒▒▒▒▒░▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓░▒▒▒▒▒▒▒▒▒▒▒░░░▓▓▒▒▒▒▒▒▒▒▒▒
        ▒▒░▒▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▓▒▒▒▒▓▓▒▓▒▒▒▒▒▓▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒░░▓▓▒▒▒▒▒▒▒▒▒▒▒
        ▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒░░▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒░▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒░▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒
    ";
    DavidMartinez = "
        ░░░░░░░░░░▒░▒▒▒░▒▒▒▒▒▒▒░▒░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▒▓▓▓▓▓▒▓▓▓▓▒▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ░░░░░░░░░░▒░▒▒░▒▒▒░░░░▒░▒░▒░▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▒▓▒▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ░░░░░░░░▒▒▒▒░░░░░░▒░░░░░▒░░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓░▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ░░░░░░░░░▒▒░░░░░▒▒░░░░░░▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓░▒▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ░░░░░░░░░░░▒▒▒▒░░░▒▒▒▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒░░░░░▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓
        ░░░░░░░░░░░░▒▒▒▒▒▒░░▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒░░░░░░░░░▓▓▓▓▒▓▓▓▓▓▓▓▒▓▓▓▓▒▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓
        ░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓
        ░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▒▒▓▓▓
        ░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░▒▓▓▓▒▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒░░░░░▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒
        ░░░░░░░░░░░░░░░░░░▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒░░░▒▒▒▒▒▒▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒
        ░░░░░░░░▒░░░░░░░░░░░▒░░░░▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒░░▒▒▒▒▒▒▒▓▓▒▒▒▒░▒▒▒▒▓▓▓▓▓▓
        ░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░░░░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▓▓▓▓
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▓▒▒▒░▒▒▓▓▓▓▓▓▓
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒░▒▒▓▓▓▓▓▓▓▓
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▓▒▒▒▒▒▓▓▓▓▓▓▓
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▓▓▓▓▓▓
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░░░▒▒▒▒▒▒▒▓▓▓▓▓
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒░▒▒▓▓▓
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒░▒▒
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░▒▒▒▒
        ▒░░░░░░▒░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒░
        ▓▓░░░░░░░▒▒▒▒▒░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▒░░░░░░░░░░░░░░░░░
        ▓▓▓░░░░░░░░░▒▒▒▒░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▓▒▒▒▒▒▒▒░░▒▒▒░░░░░░░░░░
        ▒▒▒▓▒░░░░░░░░▒▒▒▒▒▒░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒░░░▓▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░▒▒
        ▓▓▒░▒▓▓▓▒░░░░▒▒▒▒▒░▒▒░░░░░░░░░░░░░░▒▒░░░░░░░░░░░░░░░░▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░
        ▓▓▓▓▓▓▒▓▓▓▓░░▒▒▒▒▒▒▒▒░▒░░░░▒░░░░▒░░▒▒▒░░░░░░░░░░░░░▒▒▒░░░░▒▒▒▒▒▒░░▒░░░▒▓▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▒░▒▒░░░░░▒▒▒░▒░░▒▒▒░░░░░░░░░░░▒▒░░░░▒▒░░░░░░░░▒▒▓▓▓▓▒▒▒▒▓▒▓▓▓▓▒▒▓▒▒░▒▒▒▒▒▒▒▒▒▒░░
        ▒▒▒▓▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒░▒▒░░▒▒░░░░░░░░░▒▒░░░░░░░░░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▓▓▒▓▒▒▓▓▒▒▒▒▓▓░▒▒▒▒▒▒▒▒▒
        ▓░░▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒░░░▒▒▒░░░░░░░▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▓▒▒▓▒▒▒▓▓▓▓▒▓▓▓▓▓▒▒▒
        ▒░░░░▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▒▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒
        ▒▒▒▒▒▓▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒▓▒▒▒▓▓▒▒▓▒▒▓▓▓▓▓▓
        ▒▒▒▒▓▓▓░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▓▓
        ▒▒▒▓▓▓▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▓▓▓▒▓░▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▒▓▒▒░░░░▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒▒▒▓▒░░░░░░░▒▒▒
        ▒▒▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▓░░░░░░░░░░
        ▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▒▒▒▒░░░░░░░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▒▒▒▒▒▒▒▒░░░░
        ▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒░░
        ▒▒▒░░░░░░░░░░▒▒▒▒▒▓▒▒▒▒░▒▒▒░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░░░░░▒▒▒▓▒▒▒▓▒▒▒▒▒▒▒▒▒▓▓░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒░░░▒▒▓▓▓▒▒▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒░▒▒▒▒░▒▒░▒▓░▒▒▒▒▒▒▒▒▒░░▒▒▒░▒▒▒▒░▒▒▒▒▒▓▓▓▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▓▓
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒░▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▓▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
    ";
    LightYagami = "
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒░░▒▒▒▒░░░░░▒▒▒▒░░░░░░░▒▒░░░░░░░░░░░░▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒░░▒▒▒▒▒░░░░░▒▒▒▒░░░░░░░▒▒░░░░░░░░░░░░░▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒░▒▒▒▓▒▒▒░░░░░▒▒▒▒░░░░░░░▒▒▒░░░░░░░░░░░░░░▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒▒▒▒▒▓▓▒▒▒░░░░░░▒▒▒▒░░░░░░▒▒▒░░░░░░░░░░░░░░░▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒▒▒▒▒▒▓▓▒▒▒░░░░░░▒▒▒▒░░░░░░▒▒▒▒░░░░░░░░░░░░░░░░▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒▒▒▓▒▒▓▓▓▒▒▒▒░░░░░░▒▒▒░░░░░░░▒▒▒░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒▒▒▓▓▒▒▓▓▓▒▒▒▒▒░░░░░░▒▒▒░░░░░░▒▒▒▒░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒▓▓▒▓▓▒▒▓▓▓▓▒▒▒▒▒░░░░░░░▒░░░░░░░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒▓▓▒▓▓▓▒▒▒▓▓▓▒▒▒▒▒▒░░░░░░░░░░░░░░░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒▓▓▓▒▓▓▓▒▒▒▒▒▒▓▒▒▒▒▒▒░░░░░░░░░░░░░░░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒▓▓▓▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒▒▓▓▒▒▒▓▓▓▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒▒▒▓▒░░▒▒▓▓▒▒▒░▒▒▒▒▒▒░░▒▒▒▒▒▒▒░░░░░░░░░░░░▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒▒▒▒▓▒░░░▒▒▓▓▒▒▒░▒▒▒▒▒▒░░░░░▒▒▒▒▒▒░░░░░░░░░░░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒▒▒▒▓▒░░░░░░▒▓▒▒▒▒░▒▒▒▒▒▒░░░░░░░░▒▒▒▒▒░░░░░░░░░░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒▒▒▒▒▓▒░░░░░░░░▒▒▒▒▒▒░▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒▒▒▒▒▓▒▒░░░░░░░░░░▒▒▒▒▒░░░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒▒▒▒▒▒▓▒▒░░░░░░░░░░░░░▒▒▒▒▒░░░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░▒▒▒▒░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒▒▒▒▒░▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒░▒░▒▒░░▒▒▒▒░░░░░░░░░░░░░░░░░▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒░░▒░▒▒▒░▒▒▒▒░░░░░░░░░░░░░░░░░▒▒░░░▒░░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒░░░▒░░▒▒░░▒▒▒▒░░░░░░░░▒▒▒░░░░░░░░░▒▒░░▒▓▓▓░░░░▒▒▒░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒░░░░░░░▒▒░░░░▒▒░░░░░░░░▒▒░░░▒░░░░░░▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒░░░░░▒░░░▒▒░░░░▒▒░░░░░░░░▒▒▒▒░▒░▒░▒▒░▒▓▓▓▒▒▒▓▒▒▒░▒▒▒▒▒▒▒░░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒░░░░░░▒░░░░░▒░░░░░▒░░░░░░░▒▒▒▒▒▒▒░▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒▒░░░░░░░░░░░░░▒░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒▒▒░░░░░▒▒░▓▓▓▓▒░▒░░░▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒░▒▒▒▒▒░░░░░░░░░░░░░░░░░░▒▒▒░░░░░░░░░░░░░░▒
        ▒░░░░░░░░▒▓▓▓▒▒▒▒▒░░░░░▒▒▒▒▒░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░▒▒▒▒▒░░░░░░░░░░░░░░░▒
        ▒░░░░░░░░░▒▒▓▓▓▓▓▓▒▒▓▒▒░▒▒▒▒▒▒▒▒▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒░░░░░░░▒░▒▒▒▒▒▒░░░░░░░░░░░░░░░░▒
        ▒░░░░░░░░▒▒▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░░░░░░░▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░▒
        ▒░░░░░░░░░▒▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░░░░░░░▒▒▒▒░░░░░░░░░░░░░░░░░░░▒
        ▒░░░░░░░░░▒▒▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒░░░░░░░░░░▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒▒░░░░░░░░░▒▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒░░▒▒▒░░░░░░░░░░░░░░░░░░░░▒
        ▒░▒░░░░░░░░░▒▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒░░▒▒▒▒░░░░░░░░░░░░░░░░░░░▒
        ▒░░░░░▒░░░▒▒░▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒░░▒▒▒▒▒░░░░░░░░░░░░░░░░░░░▒
        ▒▒▒░░░▒▒▒▒▒░▒░▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░▒
        ▒▒░░░░░░░▒▒▒▒▒░▒▓▓▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░▒
        ▒░░░░░░░░░░▒░▒▒▒░▓▓▓▓▓▓▓▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░▒
        ▒░░░░░░░░░░░░░▒▒▒░▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░▒
        ▒░░░░░░░░░░░░░░▒░▒▒░▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░▒
        ▒░░░░░░░░░░░░░░░░░▒▒░░▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒░░░░░░░░░░░░░▒
        ▒░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░░░░░░░░░░░░░▒
        ▒░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░▒
        ▒░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░▒
        ▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░▒
        ▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░▒
        ▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░▒
        ▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░▒
        ▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒░░░░░░░░░░░░░░░░░░▒
        ▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▒▒▒▒▒░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒░░░░▒▒▒▒░░░░░░░░░░░░░░░░░░░░▒
        ▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░▒
        ▒░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░▒
        ▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░▒
        ▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░▒
        ▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░▒░▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒░▒▒▒░▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒░░▒▒▒▒▒░▒▒▒▒▒▒▒▒░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒░░░░░░░░▒▒░░░▒░░░░░░░░░░░░░░░░░░░▒▒░▒▒▒▒░▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒░░░░░░░░▒▒░░░▒░░░░░░░░░░░░░░░░▒▒░░▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒░░░░░░░▒▒▒░░░▒▒░░░░░░░░░░░░░░░░░▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
    ";
    ZoroRoronoa = "
        ▒▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒▓▓▓▓▒▓▓▓▒▓▓▓▒▓▓▒▒▓▒▒▒▓▓▒▓▓▓▓▓▒▓▒▓▒▒▒▒▓▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒
        ▒▒▒▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▓▒▒▒▒▓▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▒░░▒▒
        ▒▒▒▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒
        ▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒░▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▓▓▒
        ▒▒▒▒▓▓▓▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒
        ▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒
        ▒▒▒▒▒▓▓▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒
        ▒▒▒▒▒▓▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▓▓▒▒▒▒
        ▒▒▒▒▒▓▓▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒
        ▒▒▒▒▓▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒
        ▒▒▒▒▒▓▓░▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░▒▒▒▒▒▓▒▒▓▓▒▒
        ▒▒▒▒▒▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒
        ▒▒▒▒▓▓▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒
        ▒▒▒▓▒▒▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒
        ▒▒▒▒▒▒▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒░▒
        ▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓░▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒
        ▒▓▒▒▒▓▓▒▒░▒▒▒▒▓▒▒▒░░▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▓▒▒▓▓▒▒▒▒
        ▒▓▓▒▒▓▒▓▒▒▒▒▒░▒░▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒░▒▓▒▓▓▓▓▓▓▓▒░▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒░▒
        ▒▓▓▓▒▒▓▓▒▒░▒▒▒▒▒▒▒▒▒░▒▒▒▒▓▓▓▒▒▒▒▒▒░▒▒░░▒▒▒▒▒▒▒▒░░░▒▓▓▓▓▓▓▒▒▒▒▒▓▓▒░░▒▒▒▒▒▒░░░▒▒▒▒▒▒▒░▒▒▒▒▒▒▓▓▓▓▓▓▒░▒▒
        ▒▓▓▓▒▒▓▒▒▒▒▒▒▒▒░▒▒▒▒░▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓░░░▒▒▒▒░░░░▒▓▓▓▒░▒▒░▒▓▓▒░▒░░░░░░▒▒▒▒▒▒▒▒▒░░░▒▒▒▓▓▒▓▒▒▒▒▒░▒▒
        ▒▒▒▓▓▒▒▓▓▒▓▒▒░▒▒░▒▒░▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒░░░░░░▒▒▒▒▓▓▒░░░░░░░░▒▒▒▒▒▒░▒▒▒░▒▒░▒▒▒▓▒▒▒▒▒▒░▒▒▒
        ▒▒▒▓▓▓▒▒▒▒▓▒░▒▒▒░▒▒░▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒░▒▒▒▒▓▓▓▒░░░░▒▓▓▓▓▓▓▓▒░▒▒▒▒░░░▒▒▒▓▓▓▒▒▒▒▒░▒▒▒▒
        ▒▓▓▓▓▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒░▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▓▓▒▒░░▒░▒▒▒▒▒▒▒
        ▒▓░▓▓▓▓▓▓▓▓▓▒░▒▒░▒░▒░▒░▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▓▓▒░▒░▒▒░▒▒▒▒▒▒▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓░▒░░▒▒░░░▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒░▓▓░░░▒▒░▒░▒▒▒▒▒▒▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒░▒▒░▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░▓▓▒░░░░░▒▒░▒▒▒▒▒▒▒
        ▒▓▓▓▓▓▓▓▓▒▒▒▓▓▒░▒░░░░░░░▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▓▓▓▓▓▓▓▓▓▓▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▓▓▒░▒▒▓▓▓▓▓▒▒▓▓▒▒▒▒
        ▒▓▓▒▒▒▒▒▒▒▒▒▒▓▒░░▒▒▒▒▒▒░▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▓▓▓▒▒░▒▓▓▓▒▒▒▓▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▓▓░▒▒▒▓▓▓▓▒▒▓▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▓▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▓▓▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▓▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒░░░▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▒░░▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▓░▒▓▓▓▒▒▒▒▒▒▒▓▓▒░░░▒▒▒▒▒▒░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▓▓▓▓▒▒▒▒▒░▒▒▒▓▓▓▒░░░▒
        ▒▒▒▒▒▒▒▒▒▒▒▓▒░▓▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▓▒▒▒░▒░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒░▒▒▒▒▒▒▒░▒▒▒▒▒▒▓▓▓▓▓░▒▒▓▓▓▓▓▒▒▒▒░▒▒▒░▒░▒░▒
        ▒▓▓▓▓▓▓▓▓▓▓▓░░▓░▒▒▒░░░░░░░░░░░░▒░▓▓▒▒▒▒░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒░▒▒▒▒░▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▒▒▒▒░░░▒▒▒░▒
        ▒▓▓▒░▒▓▒░░▒░░▒▓▓▓▒▓▒▒▓▒▒▒░░░░░░▒░▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▓▓▓▓▒░▒▒▒▒░▒▒▒
        ▒░░▒▓▓▒▒░▒░▒▒▓▒▒▓▓▓▓▓▒▓▓░░░░░░░▒▒▒▒░▒▓▓▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▓▓▓▓▒▒▒▒░░▒▒
        ▒▓▓▓░░░▒▒░▓▓▒▒▒▒▒▒▒▓▓▓▓▒░░░░░░░▒▒▒▒▒▒░░▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒
        ▒▓▒▒▒▓▒░░▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒
        ▒▒▒▒▒▒▒▒░▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░▒▒▒▒▒▒▒░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▒▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▒▒▒▒▒▒▒░▓░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▒▒▒▒▒▒▒░▒░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░▒▒░▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▒▓▒░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒░▓▓▓▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒
        ▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒░▓▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░▒▒▒▒▒▒▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒
        ▒▒▒▒▒░▓▓▓▓▓▓▓▒▒▒▒▒▒░░░░░░░░░░░▒▒▒▒▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒
        ▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒░░░░░░░░░░░▒▒▒▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒░░▒▒▒▒▒░░▒▒▒░░░▒▒░░░▒
        ▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░▒▒▓▓▓▓▓▓▓▒░░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒░▒▒▒░▒░░░░░▒░░░▒
        ▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░▒░░░░▒▒▒▒▒░░░░▒▒░░░░▒▒░░░░▒▒▒░░░░▒▒░░░▒▒▒▒▒▒▒▒▒░░░░░▒░░░░▒░░░░░░░░░░░▒
        ▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░▒▒░░░▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░▒░░░░░▒░░░░░░░░░░░░░▒▒▒▒▒░▒▒░░░░░░░░░░▒▒░░░░░░░░▒
        ▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░▒▒░░░▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒░░░░░░░░░░░▒▒░░░░░░▒
        ▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░░░░░▒░░░▒▒▒▒▒▒▒▒▒░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░▒
        ▒▒▒▒░▓▓▓▓▒▒▒▒▒▒░░░░░░░░░░░▒░░░▒▒▒▒▒▒▒▒▒░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▓▓▓▓▓▓▒
        ▒▒▒▒░▒▓▓▒▒▒▒▒▒░░░░░░░░░░▒▒░░▒░▒▒▒▒▒▒▒▒▒░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░▒░▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒░▒▒▒▒▒▒▒▒░░░░░░░░░▒▒▒▒▒░▒▒░▒▒▒▒▒▒▒▒░▒░░░░░░░░░░▒▒▒▒░░▓▓▓▓░▒▒▒▒▒▒▒░░░▒▒▒▒▒▒░▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒░▒▓▒▒░░░░░░░░░▒▒░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒░░▒▓▓▓▓▒▓▓▒▒▒▒▓▒░▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒░░▒▒░░░░░░░░▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▓▓▒▒░▓▓▓▒▒▒▓▒▓▓▒▒▒▒▒░░▒▒▒▒▓▓▓▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒░░░▒▒░░░░▒▒▒▒▒▒▒▒░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▓▓▓▒▒▒▓▓▓▒▒▓▓▓▒▒▒▒░░░▒▒▒▒▒▓▓▒▒▒▒▒▓▓░▒▓▓▓▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒░░░░░░░░░░░░░░░░░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▒▒▓▓▓▓▒▒░░░░▒▓▒▒▒▓▒▒▓▒▒▓▓▓▓▒░▒▓▓▓▒▒▒▒▒▒▒
        ▒▒▒▒▒▒░░░░░▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒▓▒░░▒▓░░░░▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▒▒▒▒▒
        ▒░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒▒▓▒▒░░░▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒▒▒
        ▒░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒▓▓▓▒░░▓▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒
        ▒▒▒▒▒▒▒▒░░░▒▒▓▓▓▓▓▓▓▓▓▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▓▒▒▒▒▒░▒▒▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒
        ▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒
        ▒▒▒▒▒▒▒▒▒▒░░▓░░░░░░░░░░░▒░▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░▒▒▒▒▒▒▒▓░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▒
        ▒▒▒▒▒▒▒▒▒▒▒░░▒░░░░░░░░░▒▒▒░▒▒▒▒▒▒▒▓▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░▒▒▒▒▒▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▓▓▒
        ▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▒
        ▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒
        ▒▒▒▒▒▒▒▒▒▒░▒░▒░▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒
        ▒░░░▒▒▒▒▒▒░░░▒▒▒▒░▒▒▒▒▒▒▒▓▓▓▓▓▓▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒
        ▒▒░▒░▒░▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒░▒░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒
        ▒░░░▒▒▒░░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒░░▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒░▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒░░▒▒▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▒▒▒▓▓░▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▓▒░░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▒▓▓▓▒▒▒▒▒▒▒▓▓▓▒▒▒▒▓▒▓▒▓▓░░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▒▒▒▒▒▒▒▓▓▓▒▒▒▓▓▒▓▓▓▒▓▒▒░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▒▒▒▒▒▒▓▓▓▒▒▒▓▓▒▓▓▓▓▓▒▒▒▒░▒▒▒▒▒▒▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▒▓▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
    ";
    NarutoUzumaki = "
        ▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▓▓▒▒▓▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▓▒░▒▒▒▒▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▒▒▒▒▒░░▒▒▓
        ▓▒▒▓▓▓▓▓▒▒▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▒▓▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒░░▒▒▓
        ▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▒░▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▓▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓
        ▓▒▒▒▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▓▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓
        ▓▓▒▓▒▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓
        ▓▒▒▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓
        ▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓
        ▓▒▒▒▒▒▒▒▒▒▓▓▓▓▒▓▓▓▓▓▓▓▓▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▓▓▓▓▓▒▓▓▓▓▓▒▒▒▒▓▓▓▓▒░▒▒▒▒▒▒▒▒▒░▒▒▓
        ▓░░▒▒▒▒▒▒▒▓▓▓▒▒▓▓▓▓▓▓▓▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▓▓▓▒░▒▓▓▓▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒░░▒▒▒▒▒░▓
        ▓▒▒▓▒▒▒▒▒▓▓▓▒▒▒▓▓▓▓▓▓▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▓▓▓░░░▒▓▓▓▒▒░▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▓▓▓▒▒▒▒▓▓▓▓▓▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓░░░░░▒▓▓▒▒░░░▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▓▓▓▒▒▒▒▓▓▓▓▓▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▒░░░▒░░▒▓▒▒░░░░▒▒▒▒▓▒░▒▒▒▒▒▒▒░▒▓
        ▓▒▒▒▒▒▓▓▓▒▒▒▓▒▓▓▓▓▓▒░░░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▒▒▒░▒▒▒░░▒▓▒░░░░░░▒▒▒▒▒░▒▒▒▒▒▒▒░▓
        ▓▒▒▒▒▒▓▓▒▒▒▓▓▒▓▓▓▓▒░░░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▒▒▒░▒▒▒░░░▓▒░▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▓▒▒▒▓▒▓▓▒▓▓▓▒░░░▒▒▒░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▒▓▓░▒▒▒▒▒▒▒▒░░░▓▒▒▒▒░░▒▒▒▒▒▒░▒▒▒▒▒▒▒▓
        ▓▒▒▒▓▒▒▒▒▒▓▓▓▒▓▓▒░░░░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░▒▒▒▒▒▒▓▒▓▒▒▓▓▒░░░░▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▓▓▒▒▒▒▒▒░▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓░░░░░▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒░░░▒▒▒▒▒░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▒▒▓▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒░▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒░▒▒▒▒▒▒▒▒░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒░▒▒▒▒▓▓▓▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒░▒▒▒▒▒▒▒▒▒▒░▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▓▓▓▓▒▓▓▓▓▒▒▒▓▒▒░▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒░▒▒▒▒▓▒▒▓▒▓▓▓▒▒▒░▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▓▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▓▓▓▒▒░░░░▒▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▒░▒▒▒▒▒▓▒░░▓▓▓▓▓▒▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓░▒▓▓▒░▒▒▒▒▒░▒▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒▒▓░▒▒▒▒▒▒▒▒▒▓▓▒▒▓▓▓▓▓▒▒▓▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▒░▓▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓░▓▓▒▒▒░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▒▒▓▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▒▓▓▓▓▓▓▒▓▓▓▒▒▒▒▒▓▓▓▓▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▓▓▓▓▓▓▓▓▓▓▓▒░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▓▓▓▓░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▒░░░░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▓
        ▓▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▓
        ▓▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▒▓▓▓▓▓▓▓▓▒░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▒░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓
        ▓░░░▒░░▒▒░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▒▓▓▓▓▓▒░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒░░░▒░░░░▒░░░░░░░░░░▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▒░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▓
        ▓▒░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒░▒▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▓
        ▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▒░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░▒▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒░░░░▒▒░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░▒░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░▒▒░░░░░░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░▒▒▒▒▒▒░▒▒▒▒▒░▒░▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░▒▒▒▒░▒▒▒░▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░▒▒▒▓▒▒▒▓▒▒▒▒▒▒▒░░░▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒░░░░░▒░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▓▒▒▒▒▒▒▓░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒░▒▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▓░▒▒▒▒░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒░░░░░░░░░▒▒▒▒▒▒░░░░░░░░░░░░░░▓
        ▓▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒░░░░░░░░░░░░░░░░▒▒▒▒░░░░░░░░▒░░░░░░░░▒░░░░░░░░░░░░░░▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▓▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒░▒▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒░▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒░░░░░░░▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
    ";
    ErenYeager = "
        ▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▓▒▒░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░▒░░░░░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒░░▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒░▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▒▒▒▒▒▒░▓▓▓▓▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▒▒▒▒▒▒▒▒▒░▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▓▓▓▓▓▓▓▓▓▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓
        ▓▒░▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓
        ▓▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓
        ▓▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓
        ▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▓▓▓
        ▓▒▒░▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒░▒░▒▓▓▓
        ▓▒░░░░░▒░░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░▒▒░░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░▒▒▓░▒▓▓
        ▓░▒░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░▒▓▒░▓
        ▓▒░░░░░░░░▒▒▒░▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░▒▓▒▓
        ▓░░░░░░░░░▒░░░▒▒▒░░▒▒▒░░▒▒░░░░░░░░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░▒░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▓
        ▓░░░░░░░░░░░░▒░░░░░▒░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░▒▒░░░░░░░░░░░░░░░░░░░░░░░▒░▒░▒░▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░▒▒▒░░░░░░░░░░░░░░░░░░░░░░▒░▒░▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░▒▓▒▒▒░░░░░░░░░░░░░░░░░░░░░▒░▒▒░░▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▓▒▒░▒▓▓▒▒░░░░░░░░░░░░░░░░░░░░░░▒░▒░░▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░▒▒▓▓▒▒░▓▓▓▓▒▒░░░░▒░░░░░░░░░░░░░░░░▒░▒░▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░░░▒▒▒▓▓▓▒▒░▓▓▓▓▒▒░░░░▒▒░░░░░░░░░░░░░░░▒░▒░▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░░░░▒▒▓▓▓▓▒▒░▒▓▓▓▓▒▒░░░░▒▒░░░░░░░░░░░░░░░▒░▒░▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒░░░▒▒▒▓▓▓▓▓▒▒░▓▓▓▓▓▒▒░░░▒▒▒░░░░░░░░░░░░░░░▒░▒░▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▓▒▒░░░▒▒▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▒▒░░░▒▒▒▒░░░░░░░░░░░░░▒▒░▒░▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▓▒▒▒░░▒▒▓▓▓▓▓▓▓▓▒▒░▓▓▓▓▓▓▒▒░░░▒▓▒▒░░░░░░░░░░░░░▒░▒▒░▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▓▓▒▒░░▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▒▒░░▒▓▓▒▒░░░░░░░░░▒░░░▒░▒▒░▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▓▒▒░░▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▒▒░░▓▓▓▒▒░░▒▒░░░░░░░░░▒░▒░▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▓▓▒▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▒▒▒░▓▓▒░░░░░▒▒░░░░▒▒░░▒░▓▒░▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▒▒░▓▒░░░░░░▓▒▒▒░░░░▓░░▒▒▓▒▒▓▒▓
        ▓░░░░░░░░░░░░░░░░░▒▒▒░░░░░░░░░░░░▒░░▒▓▓▒▒▒░░░░░░░░▒▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░▒▓▓▒░░▒▒▓░▒░▓▓▒▓▓▓▓
        ▓░░░░░░░░░░░░░░░░▒░▒▒▒░░░░░░░░░░▒▒░▒▓▒░░░▒░░░░░░░░░░░░░▒▓▒▓▒▓▓▒▒▓▓▓▓░░░░░░░░▒▒▒▒░▓▓▓░░▒▒▓▓░▒▒▓▓▒▓▓▓▓
        ▓▒▒▒▒▒░░░░░░░░░░░░▒▒▒▒▒░░░░░░░░▒▒░▒░░░▒▒▒░▒░░▒░░░▒░░░░░░░░░░░▓▒▒▓▓▓▒░░░░░░░░▒▓▓▓▒▓▓░▒░░▓▓▓▒▒▓▓▒▓▓▓▓▓
        ▓░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒░░░░░░░▒▒░▓▓▒▒▒▒░░▒▒░░░▒░▒▒░▒▒░░░░░▓▒▒▒▓▓▓▓░▒░░▒░░▒░▓▓▓▒▒▓▒▒▒░▓▓▓▒▒▓▓▓▓▓▓▓▓▓
        ▓░░░░░░▒░░░░░░░░▒▒▒▒▒░░▒▒░░░▒░▒▒▒▒▓▓▒▒▒▒▒░▓▓▒▒▒▒░▓▓▓▒▓▒▒▒▒▓▓▓▓▓▓▓▓░▒▒▒░▒▒▒░▓▓▓▒▒▓▓░▓░▓▓▓▓░▓▓▓▓▓▓▓▓▓▓
        ▓░░░░░▒▒░░░░░░░░░▒▒▒▒░▒░▒▒░░▒░▒▒▒▒▒▓▓▒▒░▒▒▓▒░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▒▒▓▓▓▓▒▒▓▓▓▒▓░▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓
        ▓░░▒▒▒▒░░░░░░░░░░░░▒▒░▒░▒▒▒░▒▒▒▒▒▒▒▓▓▓▓▒▒░▒▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▒▒░░░░░░░░▒░▒░░░░░░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▒░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▒▒▒▒░░░░░░▒░░░░░░░░░░░░░▒▒░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓▒▒▒▒▒▒▒▒░░░▒▒░░░░░░▒░░░░▒▒░░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒░▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓░░░░▒▒▒▒▒▒▒▒░░▒▒░░░▒▒░░░▒▒▒░░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓░░░░░░░░░░░▒▒▒▒▒▒░░░▒▒░░▒▒▒▒▒░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓░░░░░░░░░░░░░░░░░░▒▒▒░░░▒▒▒▒▒▒░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░░▒░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▓▓▓▓▒▓▓▒░░▒▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▓▓▓▓▓░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░▒▒▒▒▒▓▓▓▓▓▓▓▓▒░░░░▒▒▒▒▒▒▓▓▒▓▓▓▓▓▒░▒▒░░▒▒▒▒▒▒▒▒▒▒▒░▒▓▓▓▓▓▓▓▓▓▓▓
        ▓░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▓▓▓▓▓▓▓▓▒░▒▒▒▒▒▒▒▓▓▓▓▓▒▒░▒░░▒▒▒▒▒▒░░░░░░▒▒▒▒▒░▓▓▓▓▓▓▓▓▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░▒▒░░░░░░░░░░▒▒▒▓▒▒░░░░░░░░░▒░▒▒▒▒░░░░░░░░░░▒▒▒▒▒░░▓
        ▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒░░░░░░░░▒▓▓▓▒▒▒▒▒▓▓▓▒░░░░░▒▓
        ▓░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒░▒▓
        ▓░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒░░░░░░░▒░▒▒▒▒▓
        ▓░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░░▒░▒▒▒▒▒▒▒▒░░░░░░░░░░▒▒▒▒▒▒▒▓
        ▓░░░░░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒░░▓
        ▓▒▒░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░░░░░░▓
        ▓░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░▒▒▒▒░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░░░░░░░░░▓
        ▓░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░▒▒▒▒░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒░░░░░░░░░░░▒▒▓
        ▓░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒░░░░░░░░░░▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░░▓
        ▓░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒░░░░░░▓
        ▓░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒░░░░░░░░░░░░░░▒▒▒▒▒▒▒░░░░░░░▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░▓
        ▓░░░░░░░▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░▒▒▒▒▒▒▒░▒▒▒▒▒▒░░░░░░░░░░░░░░░░░▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░▓
        ▓░░░░░▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░▒▒▒▒▒▒░▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓░░▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░▒▒▒▒▒▒░▒▒▒▒▒▒░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░▒▒▒▒▒▒░▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░▒▒▒▒▒▒░▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▒▒▒▒▒▒▒▒░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▒▒▒▒▒▒░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▒▒▒▒░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▒▒▒░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓
        ▓▒░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░▒▓▓▓▓▓▓▓▓▓▓▓▒░░░░▒▒▒▓
        ▓░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒░▒▒▓▓▓▓▒▒░▒░░░░░░░░░░▓
        ▓░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒░▒▒▒░▒▒░░▒░░░░░░░░░░░▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
    ";
    SatoruGojou = "
        ░░░░░░░░░░▓▒░░░░▒░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▒░░▓▓▒▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░▒▓░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░▒▓▓░░░░▓░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓░░▒▒▓▓▒░░░▒▓▓░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░▒▓▓▓░░░▓▒░░░░░░░░▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▓▓▓▒░░░░▓▓▓▓░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░▒▓▓▓▓▒░▒▓▒░░░░░░▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒░░░░▒▓▓▓▓▓░░░░░░░░░░░░░░░░░░
        ░░░░▒▒▒░░▒▓▓▓▓▓▒▒▓▓▒░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▒░▒▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░
        ░░░░░░▒▒▒▒▓▓▓▓▓▓▓▒▓▓▒░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░
        ░▒▒░░▒░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒░░▒░░░░░░░░░░░░░
        ░░▓▓▒░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒░░▒▒░░░░░░░░▒░░▒▒
        ░░░▓▓▓▓▒░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒░░▒▓▓▒░░░░▒▒▒▒▒▒░░░
        ░░░▒▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▒░░░░▒▒▒▒▒▒▒░░
        ▒░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒░▒▒▒▒▒▒▒▒▒
        ▒▒▒░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▓▒░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░▒▒▒▒▒▒▒▒▒░
        ▒▓▓▒░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓░░▒▒▒▒▒▒▒▒░░░
        ░▒▓▓▓▓▒▒░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▒▓▓▓▓▒▓▒░░▒▒▒▒▒▒▒▒░░░
        ░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░▒▒▒▒░░░░
        ▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▒░░░░▒▒
        ▒▒▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░▒▒
        ▒▒▒▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░▒
        ▒▒░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░
        ▒▒▒▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░
        ▒░░░░░░░▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░
        ▒░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▓▓▓▓▓▓▒▒▓▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▒▒░░░░░░░░░░░░
        ▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▓▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒▓▓▓▓▒▓▓▓▒▒▓▒▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▒▒░░░▒▒░▒░░░░░░░
        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▓▒▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▓▒▒▓▓▓▓▓▓▓▒▓▓▒▓▒░░░░░░░░░░░░░░░░░░░░
        ▒▒▒░░░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▒▓▒▒▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░░░░░░░░░░░░░░░░░░░░
        ▒▒▒░░░░░░░░░▒▒▒▒▒▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒░░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒░░▓▓▓▓▓▓▓▓▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒░▒▒░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░▒▒░░░░░▒░▒▒▓▒░░░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒▒▒▒░▒░▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░▒▒░░░░░░▒░▓▒▒▒▒▓░░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░▒▒▒▒▒░░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░▒▒▒▓▒▒▓▒░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░░░░░░░░░░░░░░░░░░░░▒▒░░░░░░░░░░░▒▒░░▒▒▒▒▒▓▒▒▒░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒░░░░░░░░░░░░░░░░░░▒▒░░░░░░░░░░▒▒▒░░░░░░░░░░░░░░░░▒░░▒▓░▒▒▒▒▒▒▓▒░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒░░░▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░░░░▒▓▓▒▒▒▒▒▒▓▒░░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░░░░░░░▒▒▓▓▒▒▒▒▒▒▓▒░░░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░░░▒▓▓▓▓▓▒▒▒▒▒▓░░░░░░░░░░░░░░░░░
        ░░▒▒▒▒▒▒▒▒▒░░▒▒▒░▓▓▒▒▒▒▒▒▒░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▒░▒▓▒░░░░░░░░░░░░░░░░░░
        ░░░░░▒▒░░░░░░░░░░░▒▒▒▒▒▒▒▒▓▓▒▒░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▒▓▓▓▒▒▒▓▓▒▓▒▒▓▓▓▓▓▒▓░▒▒▒░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░▒▓▒▒▒▒▒▒▓▓▓▓▓▓▒▒░░░░░░░░░░▒▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░▓▓▒▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▒░▒░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░▒▒░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░▒▒▒▒░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒░▒▒▒░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░▒░░░░░░░░░░▒▒▒▒▒▒▒░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░▒░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░░░
        ▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒░░░░
        ░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ░░░░░░░░░░░░░░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒░░░░░░░░░░▒▒▒▒▒▒▒
        ░░░░░░░░░░░░░▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░░░░░░░░░░░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒
    ";
    MikasaAckerman = "
        ▓▒▒▓▓▓▓▓▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░▒▒▒░░▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒░▒▒▒░░▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▓░░▒▒▒▒▓
        ▓░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▓▒▓▒░▒▒▒▒▓
        ▓░░░▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▓▓▓▓▓▒░▒▒▒▓
        ▓░░░▒░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░▒▒▒▒▒▒▒▒▒▒▒░░░░░▒░▒▒▒▒▒▒▒░░░░░░▒░░▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▓▓▓▓▓▒░▒▒▒▓
        ▓░░▒░░▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒░░▒▒▒▒▒▒▒▒▒▒░░░░░▒░▒▒▒▒▒▒▒░░░░░▒▒▒░░▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▓▓▓░░▒▒▓
        ▓░░░░▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒░░░▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒▒▒▒▒░░░░░▒▒▒▒▒░░▒▒░▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▓
        ▓░░░▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒░░░▒▒▒▒▒▒░▒▒░░░░░░░░▒▒▒░░░░░░▒▒▓▓▒▒░░░▒░▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▓
        ▓░░▒▒▒▒▒░░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░░░░░░░▒▒▒▒▒▒░▒▒░░░░░░░░▒▒░░░░▒░▒▓▓▓▓▓▒▒░░▒░▒▒▒▒▒░░░▒▒▒░▒▒▒▒▒▒▒▒▒▒░▒▒▓
        ▓░▒▒▒▒░░░▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░░░░░░░▒▒▒▒▒░░▒▒░░░░░░░░▒░░░░▒░▒▓▓▓▓▓▓▓▒░░░░░▒▒▒▒░░░░▒▒░░▒▒▒▒▒▒▒▒▒▒░▒▒▓
        ▓▒▒▒▒░░░▒▒░░▒▒▒▒░▒▒▒▒▒▒░░▒▒░░░░░░░░▒▒▒▒▒░░▒▒░░░░░░░░░░░░▒░▒▓▓▓▓▓▓▓▓▒▒░░░░▒▒▒▒░░▒▒░░▒░░▒▒▒▒▒▒▒▒▒▒░▒▒▓
        ▓▒▒▒░░░▒▒░░▒▒░░░░▒▒▒▒▒░░▒▒░░░░▒░░░░▒▒▒▒░░▒░░░░░░░░░░░░▒▒▒▒░░▒▒▓▓▓▓▓▒░░░░▒▒▒▒░░▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒░▒▒▓
        ▓▒░░░▒▒░░░▒▒▒░░░░░▒▒▒░░▒▒░░░░░░░░░░▒▒░░░▒░░░░░▒░░░░░░▒▓▓▒▒▒▒░▒▒▒░░▒▒░░░░▒▒▒░▒▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒░▒▒▓
        ▓░░░▒▒░░░▒▒▒▒░░░░░░▒░░▒▒░░░░░░░░░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▓▓▒░░░░▒▒▒░▒▒▓▓▒▒░░░░░▒▒▒▒▒░▒▒▒▒░▒▒▓
        ▓░░▒░░░░▒▒▒▒░░░░░▒▒░░░▒░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▒▒░░░▒▒▒░▓▓▓▓▓▒▒░░░░░▒▒▒▒░░▒▒▒▒░▒▒▓
        ▓░░░░░░░▒▒░░░░░░░▒░░░▒░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░▒░▒▓▓▒▒▒░░▒▓▓▓▒░░░▒▒░▒▓▓░░░░░░░░░░░▒▒▒▒░░▒▒▒▒░▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒░░░▒▒░▒▓▒░░▒▒▒▒▒░░░░░▒▒▒░░░░▒▒▒░▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░▒▒▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▒░░░▒▒░▓▓░░░░░░░▓▒░░░░░▒▒░░░░░▒▒▒░▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░▒░▒▓▓▒░░░░░░░░▒░░░░░▒▒░░░░░▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░▒▓▓▓▓▒░░░░▒▒▒▒░░░░░░▒▒░░░░░░▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░▒▓▓▓▓▓▓▒▒▒▒▓▓▓▓░░░░░░░▒░░░░░░░▒░▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░▒▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▒░░░░░░░░░░░░░░░░░▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒░░░░░░░░░░░░░░░░░▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓░░░░░░░░░░░░░░░░░░▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▒░░░░░░░░░░░░▒░░░░▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░▒░░░░░░░▒▒▒░░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓░░░░░░░░░░░░░▒░░░░▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░▒░░░░░░░░▒▒▒░░▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒░░░░░░░░░░░░▒▒░░░▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░▒▒░░░░░░░░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░▒▒░░░░▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░▒▒▒░░░░░░▒▒░▒░░▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░▒▒▒░░░▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░▒▒▒▒░░░░▒░▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░▒▒▒▒░░▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░▒▒▒▒░░░░▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒▒▓▓▓▓▓▓░░░░░░░░░░░░▒▒▒▒░░░▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░▒░░░░░░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▒░░░░░░░░░░░░░▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░▒▒▒░▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒░░▒▒▓▓▒░░░░░░▒▓▓▓▓░░░░▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓░░░▒▒░░░▒▓▓▓▓▓▓▓▒░░▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒░░░░▒▒▒▒▓▒▓▓▓▓▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓░░░░░▒▒░▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒░▓░░░░▒▒▓▓▓▓▓░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓░░░░▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▓▓░░░▒▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓░░▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░░░░░▒▒▒░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▓▓▒▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▓▓▓▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▓▓▒▒░░░░▒▒▒▒▒▓▓▓▒▒▒▓▓▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒▒▒▒▓▓▓▓▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░░░▒▒▒▒▒▒░▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▓▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓
        ▓░░▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▓▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓
        ▓▓░▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▓
        ▓▒░░▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▓▓▓▒▒▒▒▒▓▒▒▓▓▓▓▒▒▒▒▒▒▒▓
        ▓▒░▒▒▒▒▒▒▒▒▓▓░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▓▓▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒▒▒▓▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▓
        ▓▒░░░▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▓▓▓▒▒▒▒▒▓▓▓▓▓░▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░▒▓▒▒▒▓▓▓▒▓▓▓▒▒▒▒▒▒▓
        ▓▒▒░░░░▒▒▒▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓░░░░░░░░░▒▓▓▓▒▒▓▓▓▓▒▓▓▒▒▒▒▒▒▓
        ▓▒░░░░░░░░▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒░░░░░░░░░▒▓▓▓▒▓▓▒▓▓▓▒▓▒▒▒▒▒▒▓
        ▓▒░░░░░░░░░░░▒░▓▓▓▓▓▓▓▓▒▒▒▒▒▓▒▒▒▓▓▒▓▓▒▒▒▒░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒░░░░░░░░░▒▒▒▓▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓
        ▓▒░░▒▒░░░▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▓▓▓▓▒▒▓▓▓▒▒▒▒▒▒▓▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓░▒░░░░░░▒▒▒▓▒▓▓▓▓▒▓▒░▒▒▓▒░▒▓
        ▓▓░░░░▒▒▒▓▓▓▒▒▓▓▓▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒░▒▓▓▓▓▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▓▓▓▒▓▓▒▒▒▒▓▓▒▓
        ▓▒▒░▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒░▓▓▓▒▓▓▓▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒░░▒▓▒▒▒▒░▒▒▒▒▓▓▓▓░▒▒▒▓▓▓
        ▓▒░▓▓▓▓▓▓▓▓▒▒▒░▒▓▓▓▓▓▓▓▓▒▒▒▒▒▓▒▒▓▓▓▓▓▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒░░▒▓▓▓▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▓
        ▓▓░▓▓▓▓▒▒▒▒▒▓▓▒▒▓▓▓▓▓▒▒▒▒▒▓▓▓▓▒▒▓▓▓▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▓▒▓▒▒░░▒▒▒▒▒░▒▒▒▓▓▓
        ▓▒░░▒▒▒▒▒▓▓▓▓▒▒▒▓▓▒▒▒▒▒▓▓▓▓▓▓▒▒▓▒▒▒▒▒▒▒▒▓▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▓▒▒▒▒▒▓▒▓▓▒▓▒▒░▒▒▒░▒▒▒▓▓▓
        ▓▒░░░▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▒░▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒░░░░░░░░░░▒▒▒▒▓▓▓
        ▓░▒▓░░▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▓▓▒▒░▓▒▓▓▓▓▓▓▒░▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▓▒▒▒▓▒▒░░░▒▓░▒▒▒▓▓▓
        ▓░░▒▒░░▒▓▓▒▒▓▒▓▒▓▓▓▓▒▒▒▒▒▒▓▓▓▓▒▒▓▓▓▓▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▓▒▒▒▓▒░▒▒▒░▒▓▓▓
        ▓▒▒▒▓▒▒▒▓▓▓▓▓▒▒▒▒▒▓▒▒▒▓▓▓▓▓▓▓▒▓▒▓▒▒▒▓▒▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓
    ";
    GokuuSon = "
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒▒▒▒▒▒░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒▒▒▒▒░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒▒▒▒░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒▒▒▒░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒▒▒▒░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒▒▒░░▒░░░░░░░░░▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░▒▒░░░░░▒░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒░▒▒▒░░░░░░░░░░░░░░░░░░░░▒
        ▒▒▒░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░▒▒▒▒░░░░▒▒░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒░░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░▒
        ▒▒░░▒░▒▒░▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░▒▒▒▒░░░▒▒▒▒░░░░░░░░░░░░░░░░░▒▒▒▒▒░░▒▒▒░░░░░░░▒▒░░░░░░░░░░░░░░░░▒
        ▒░░░░▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░▒▒▒░▒▒▒▒░▒▒▒▒▒▒░░░░░░░░░░░░░░░░▒▒▒▒▒░▒▒▒▒▒░░░░░░▒▒▒░░░░░░░░░░░░░░░░░▒
        ▒░░▒▒░▒▒▒▒░▒▒▒░░░░░░░░░░░░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒░▒▒░░░░░░░░░░░░░░░░▒▒▒▒░▒▒▒▒▒░░░░░░░░▒▒▒░░░░░░░░░░░░░░░░░░▒
        ▒░▒▒▒▒▒▒▒░▒▒░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░▒▒▒▒░▒▒▒▒▒░░░░░░░░░▒▒▒▒░░░▒░░░░░░░░░░░░░░▒
        ▒▒▒▒▒▒░▒▒▒░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒░▒▒▒░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░▒▒▒▒░░▒░░░░░░░░░▒░░░░░░▒
        ▒▒▒▒▒▒▒▒░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒░▒▒▒▒░▒▒░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░▒▒▒▒▒▒▒░░░░░░░▒▒▒░░░░░░▒▒
        ▒▒▒░▒▒░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒░░░░░░░░░░▒░░░░▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░▒▒▒▒▒▒░░░░░░▒░░▒▒░░░░░░▒▒▒
        ▒▒▒▒░░░░▒▓▓▒░░░░░░▒▒▒▒▓▓▓▓▓▓▒░▒▒▒░▒▒░░░░░░░░▒▒▒░░░▒▒▒▒▒▒▒▒▒░░░░░░░░░░▒▒▒░░▒▒▒▒░░░░░▒▒▒▒▒▒▒░░░░░░▒▒▒▒
        ▒▒░░░▒▒▒░▒▓▓▒░░░▒▒▒▓▒▓▒▒▒▓▓░▒▒▒▒▒▒░░░░░░░▒▒▒▒▒░░░▒▒▒▒▒▒▒▒░░░░░░░░░▒▒▒▒▒░▒▒▒▒░░░░▒▒▒▒▒▒░▒▒░░░░░▒▒▒▒░▒
        ▒░░░░▓▒▒▒▒░▓▓▒░▒▒▓▓▒▒▒░░░░░▒▒▒▒░░░░░░░▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒░░░░░░░▒▒▒▒▒▒▒▒░▒▒▒░░▒▒▒▒▒▒▒░▒░▒░░░░░░▒▒▒▒▒░▒
        ▒░░░░▓▓▓▒▒▒▒▓▓▒▒▓▓▒▒▒░░░░▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒░░▒▒▒░▒▒▒░░░░░░▒▒▒▒▒▒▒▓▒▒▒▒░░▒▒▒░░░░░░░▒░░░░░░░▒▒▒▒▒▒░░▒
        ▒░░░░░▓▓▓▒▒▒▒▒▓▓▓▒▒▒░░░░▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▓▒░░░▒▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒░░░░░░░░░░░░░░░░░▒▒▒▒▒▒░▒▒▒
        ▒░░░░░▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓░▒▒░░░░░░░░░░▒▒▒▒▓▓▒▒░░▒▒░▒▒░░░░▒▒▒▓▓▓▒▒▒▒▓▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒░▒▒▒▒
        ▒░░░░░░▓▓▓▓▒▒▒▒▒▒▓▓▒░░░▒▒▒▓▓▓▒░░░░░░▓▓▓▓▓░░▒▒▒▒▒░░░▒▒▒▓▓▓▓▒▒▒▓▓▒▒▒▒▒░░░░░░▒▓▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒░▒▒▒░▒
        ▒░░░░░░░▒▓▓▓▒▒▒▒▒▒░░▒▓▓▓▓▒▓▓▓▓▓▓▒░░░░░▓▓░░▒▒▒░░░▒▒▒▒▓▓▓▓▒░▒▒▓▒▒▒▒░░░░░░▒▓▓▓▓▒▒▒▒░░▒▒░░▒▒▒▒▒▒▒░▒▒▒▒▒▒
        ▒░░░░░░░░▒▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓░░░░░░░▒▒▒░░▒▒▒▓▓▓▓▓▓▒▒▓▓▓▒▒▒░░░░░▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
        ▒▒░░░░░░░░░▒▓▓▓▒▒▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓░░░░░▒▒▒░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒░░░░░░░▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒
        ▒▓▓▒▒▒▒░░░░░░▓▓▓▓▒▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒░▒▒░░░▒▓▓▓▒▓▓▓▓▓▓▓▓▒░░░▒░░░░▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒░░░░░▓▓▓▓▒▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓░░▒▓▓▒▒░░▒▓▓▓▓▓▓▓░░░▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░▒▒▒▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒░▒░░░░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒░▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒
        ▒░░░░░░░░░░░░░░░░░░▓▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒
        ▒░░░░░░░░░░░░░░░░░▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒░▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒▒▒▒▒▒▒▒░░▒▒▒
        ▒░░░░░░░░░░░░░░░░░▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓░▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒░░▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒░░░░░░░▒▒▒▒▒▒▒▒▒
        ▒▓▓▓▓▓▓▓▓▒▒▒▓▓▒▒▓▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒░░░░░░░▒▒▒▒▒▒▒
        ▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▓▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒▒▒▒
        ▒▓▓▓▓▒▒▓▓▓▒▒▒▓▓▓▒▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒▒▒
        ▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▒▒
        ▒▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒
        ▒▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒
        ▒▒▒▓▓▒░▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒
        ▒▓▒░░▒▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒
        ▒░░░▒▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒░▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒░░░░░░░▒
        ▒░░▒▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒░░░░░░▒
        ▒░▒▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒░░░░░░▒
        ▒░▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒░░░░░░▒
        ▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒░░░░░░░▒
        ▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒░░░░░░░░▒
        ▒░▒▒▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒░░░░░░░░░▒
        ▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒░░░░░░░░░░▒
        ▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░░░░░░░░░░▒
        ▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░░░░░░░░░░░▒
        ▒░░░░░░▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒░░░░░░░░░░░░░▒
        ▒▒▒░░░░░░░░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▒▓▒▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░▒
        ▒▒▒▒▒▒▒▒░░░░░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓░░░░░░░░░░░░░░░░░░▒
        ▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒
        ▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒
        ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒
    ";
    YangWenli = "
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░▒▒░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░▒░░░░░░░▒▒▒░░▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░▒▒░░░░░░░░░░░░░░░░░▒▒▒░░░░░░░▒▒▓▓▒░▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░▒░░░░░░░░░░░░░▒░░░░░▒▒▒▓▓▓▒▒░░░▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░▒▒░░▒░░░░░░░░▒░░▒░░░░░▒▒░░▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░▒░▒░▒░░░░░░░░▒▒░░▒▒▒░░░░▒▒▒▒▒▒░▒░░░▓▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░▒░░░░░▒░▒░░░░░░░░▒▒▒▒▒░▒▒▓▒▒▒▒▒▒▒▒░▓░░░░▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░▒▒░▒▒░▒░░░▒░░▒▒▒▒▒▒▓▒▒▓▓▓▓▓▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░▒▒▒▒▒░░▒▒░░░░▒▒▒▒▒░░░▒▒▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░▒▒░░░░░▒▓▓░▒░░▒▒▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▒▒░▒▒▒▒░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░▒░░░░░░░░▓▒▓▒▒▒▒▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░▒░░░░░░░░░▒▓▒▒▒▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░▒▓▒▒▓▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░▒▓▓░▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░▒▓▒▓▓▒░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░▒▓▒▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░▒░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒░░▒░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░▒▒░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▒░░▒▒▒▒▒▒▒▒▒▒░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▓▓▓▓▓░░░░░░░░░░░░░░░░░░▒▒░░▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▓▓▒▒▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▒▒▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▒▒▒▒▓▓▓▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓░░░▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░▒▒▒▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▓▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▓▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
        ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
    ";
    IppoMakunouchi = "
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░▒▒▓░░░░░░░░░░▓▒▒▒▒▒▒▓▓▒▒▒▓▒▓▒▒▒▒▓▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓░░░░░░▒░░░░░░░░░▒░░░░░░▓░░░░░▒▒░░▓▒▒░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▒▒▒▒▒▓▓▒▓▒░░▒▒▒░░░░░░░░░░░░▒▒▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▒░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓░▒▒▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▒▓▓▓▓▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▒▒░░░░░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▒▒░░▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓░▒▒▓▓▒░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▓▒▒░▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▒▓▓▒▒░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░▒▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ░▒▒▒▒░░░░░▒░░░░░░░░░░░░░░░░░░▒▒▒░░░░▒▒░░▒▒░░░░▒░░░░░░▒░░░░░░░░░▒░░░▒▒░░▒▒▒░▒▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ░▒▒▒░░░▒▒░░░░░░░░░░░░░░░░░░░▒▒▒▒░░░░▒░░▒▓░░░░▒░░▒░░░░▒░░░░░░▒░░▓▒░░▒▒░░░▒▒▒░▓▓▒░▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ░▒▒░░▒▒░░▒░░░░░░░░░░░░░░░░░▒▒▒░░░░░░░░░░░░░░▓░░▓▒░░░▒▒░▒░░░▒▒░░▓▒░░░░░░░░░░░▓▓░░▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▒▒░▒▒░▒░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░▒░░░▓▒░▒▒░░░▒▒░░░░░░░░░░░░░░░▓▓▓░▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ░▒░▒▒░▒░░░░░░░░░░░░░░░░░░▒▒▒░░░░░░▒▓▒░░░░░░░░░░░░░░▒░▒▓▒░░░▓░░░░░░░░░▒▒▓▒▒░▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▒▒░▓░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▓▓▒░░▒▒▒░░░░░░░░░░░░░▒▓▓▒░░▓▓▒░░▒░▓░░░▓▒░▓▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▒▒▓▒░░░░▒░░░░░░░░░▒▓░░░░▒▒▒▒▓▓▓▒░▓▓▓▓▒▓░░░░▓▓░▒▒▒▒▓▓▓▓░░▓▓▓░░▒▒▒▓░░░▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ░▒▓▒▒░░░▒░░░░░░░░░▒░░▒▓░░▒▒▒▒▓▓▓░▓▓▓▓▒░░░░░░▒▓▒▓▒▓▓▓▒▒▒▓▓▓▓▒▒░▓▒░░░░░▒▓▓▓▒▓▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ░▒▒▒▒░░▒▒░░░░░░░░░▒░░░▒▒▒▒▒▒▒▓▓▓▒▓▓▓▓▓░░░░░░▓▓▓▓▓▒░▓▓▓▓▓▓▓▓░▓▒▓▓░░▒▒░▓▓▓▓▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ░▒▒▒▒░░▒░░░░░░░░░▒░░░░░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒░▒▓▓▓▒▒░░▓▓▓▓▓▓▓▓▓░▒▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ░░▒▒▒░▒▒░░░░░░░░▒▒░▒░░░░▒▒▒▒▓▓▓▓▓▓░▒▓▓▓▓▓▓▓░▒▓░░░▒▓▓▓▓▓▓▓▓▓░░░▓▒░░▒▓▓▓▒░▓▓▓▓▓▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ░░░▒▒░▒▒░░░░░░░░▒░▒░▒░░░▒▒▒▒▒▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▒░░░▓▓▓▓▓▓▓▓▓▓▓▒░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ░░░▒▒▒▒▒░░░░░░░▒▒░▒░░░░░▒▒▒▒▓▓▓▓▓▓▒▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ░░░░▒▒▒▒░░░░░░░░▒▒░░▒░░░▒▒▒▒▒▓▓▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ░░░░░░▒▒▒░░░░░░░░▒▒▒▒▒░░░▒▒▒▒▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒░░░░░▒▒▒▒░░░░░░░░░▒▒▒▓░░▒▒▒▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ░▒▒░░░▒░░░░░░░░░░░░░░▒▒▓░▒▒▒▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░▒▒░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ░░░░▒░░░░░░░░░░░░░░░░░░░░▒▒▒▒▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░▒░▒░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ░░░░░░▒░░░░░░░░░░░░░░░░░░▒▒▒▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ░░░░░▒▒▒▒▒░░░░░░░▒░░░░░░░▒▒▒▒▒▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ░░░░░▒▒▒░░░░░░░░▒▒░░░░░░░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ░▒░░▒▒▒▓░▒░░▒▓░░▒▒░░░░░░░░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ░▒░░▒▓▒▒▒▒░▒▒▒▒▒▒▒▒░░░░░░░░▒▒▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓░▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▒
        ░▒▒▒▒▓▓▒▓▓▒▒▒▒▒▒▓▓▒░░░░░░▒░░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▒░░▒▒▒▒▒▓▓▓▓▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░░░░░░▒░░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▒▒▒▒▓▓▓▓▓▓▒
        ▒▒▒▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▒░░░░▒░░▒▒░░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░▒░▒▒▓▓▓▓▓▓▒
        ▒▒▓▓▒▒▓▓▒▒▒▒▒▒▒▒▒▒▓▒▒▒░░░▒▒░▒▒▒░░░▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░▒▓▒▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▒░▒░▒░▒░▒▒░░░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░▒▒░▒▒░▒▒▒░▒▒░░░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░▓▓▒▓▓▓▓▓▓▓▓▓▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▒
        ▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▒▒▒▒░▒░▒░▒▒▒▒▒░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▒▓▓▓▓▓▒▓▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒
        ░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒░▒░▒░▒░▒▒▒▒▒▒▒░░▒▒▒░░░░▒▓▓▓▓▓▓▓▓▓▓▒░▓▒░▓▓▓▒▓▓▓▒▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ░▒▒▒▓▒▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒░▒░▒░░░▒▒▒▒▒▒▒░▒░▒▒░▒▒▒▒▒▒▒▒░░░░░░░▒▓▓▓▒▒▓▓▓▒▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▒▒▒
        ░▒▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒░░░▒░░▒▒▒░▒▒░▒░▒▒▒░▒▒▒▒░▒░▒▒░▒▒▒▒▒▓▓▓▓▒░▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▒▒▒▒
        ░▒▒▒░▓▒▒▒░▒▒▒▒▒▒░▒▒▒▒▒▒▒░░▒▒░░░▒▒░▒░░▒░▒▒▒░▒░▒░▒░░▒▒▒▒▒▒▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒░▒░
        ░▒▒▒▒░▓▓▒▒▒▓▓▒▒▒▒░▒▒▒▒░░░░▒░▒░░░▒░▒▒▒▒▒▒▒▒░▒░▒▒░▒▒▒▒▒▒▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▒▒▒▒░░░░░░░
        ░▒▒▒▒▒▒▓▓▒▒░░░▒▒▒▒▒▒░░░░░░▒▒▒░░░░▒▒▒▒▒▒▒▒░▒░▒░▒▒░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▒░░░░░░▒▒░▒
        ░▒▒▓▒▒▒▒▓▓▒░▒░▒▒▒▒▒▒▒▒▓▓▓▒▒░░░░░░░░░░░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░▒▒▒░
        ░▒▒░░▒▒▒▒▒▓▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░
        ░▓▒▒░░▒▒▒▒▒░▓▒▓▓▒░▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒░
        ░▒▒▓▒▒░▒▒▒▒▒▒░▓▓▓▓▓▓░▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ░▒▒▒▒▒▒░▒▒▒▒▒░░▒▒░▒▓▓▓░▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▒░▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓▒▒▒▒▒░░▒▒▒▒░░▒▒▒▒▒▒▒▓░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▒▓▓▓▓▓▒▒░▓▓▓▓▓▒▓▓▓▓▓▓▓░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ▒▓░▒▒▒▒░░░░░░░░▒▒▒░░░▒▒▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▒░▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ░▒░░▒▒▒░▒▒▒▒▒▒░░░░░▒▒▒░▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓░▓▓▓▓▓▓░▒░▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ░▒▒▒░░░░▒▒▓▓▓▓▓▒▒░░▒▒▒▒▒▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▓▒▒▓▒▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ░▒▒░░▒▒▒▓▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓░▓▓▓▓▓▓▓░▓▓▒▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ░▒░▒▒▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░▓▓▓▓▓▓▓▒▓▒▒▒▒▓▒░▒░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ░░▒▒▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▒░░▒▒▒▒░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▒░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▒░▓▒░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ░░▒▒▒▒▒▒▒▒▒▒░░░░░░░░▒▒▒▒▒▒▓▓▒▓▓▓▓▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒
        ░░░░░▒▒▒▒▒▒▒░░░░░░░░░▒▒▒▒▒▓▓▒▒▒▒▒▒▒▒▒▓▓▒▒▒░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒
        ░░░░░░░░░▒░░░░░░░░░░░░▒▒▒▒▓▓▒▒▒▒▒░▓▓▓▓░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▒▒
        ░░░░░░░░░░░░░░░░░░░░░░▒▒▒░▓▒▓▓▓▓▓▓▓▒▒▒░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▓▓▓▒
        ░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒▓▓▓▒
        ░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▓▒▓▓▓▓▓▓▓▒▒░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░▓▓▓▓▓▓▓▓▓▒
        ░░░░░░░░░░░░░░░░░░░░░░▒▒▓▒▓▓▓▓▓▓▓▓▒░░░░░░░░▒▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▓▓▓▓▓▓▓▓▓▓▒
        ░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▓▓▓▓▓▓▓░▒▒░░░░▒▓▓▓▓▓▒▓▓▓▒▒▓▓▓░░░▒▓▓▓▓▒▒▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒
        ░░░░░░░░░░░░░░░░░░░░▒░▒▒▒▒░▓▓▓▓▓▓▓░░░░░░▓▓▓▓▓░▓▓▒▓▒▒▒▒░▒░▒░░▒▓▓▓▓▓▓▓▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▒
        ░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▓▓▓▓▓▓▓░░░░▓▓▓▓▓▓▒▓▓▓▓▓▓▒▒▒▒░░░░▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▓▓▓▒▓▓▓▓▓▒
        ░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒░▓▓▓▓▓▓▓▓░░▒▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓░░░░░░░▓▓▓▓▓▒▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒▓▓▓▓▓▓▒▒▓▓▓▓▒▒▓▓▓▓▓▒
        ░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓░░▓▓▓▓▓▒▓▓▓▓▓▒▓▓▓▒░░░░░░░░░░░░░▒▒▓▓▓▓▓▓▓▓▒▓▓▓▓▒▓▓▓▓▓▒▒▓▓▓▓▒▒▓▓▓▓▓▓▒
        ░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▒░▓▓▓▓▓▓▒▓▓▓▒▓▓▓▓▓▓▒░░░░░░░░░░░░▓▓▓▓▓▒▓▓░▓▒▓▓▓▓▒▓▓▓▓▓▒░▓▓▓▒▒▓▓▓▓▓▓▓▒
    ";
}
extension DescriptionsEnum
{
    Decim = "(Death Parade) Decim is the bartender of Quindecim and an acting arbiter for the dead. He always puts up a serious face and is very cool and professional. His hobby is putting dummies together and dressing them up. He has a lot of respect for people who lived fulfilled lives.";
    VictoriquedeBlois = "(Gosick: Utsukushiki Kaibutsu wa Konton no Sen wo Shimiru)  She spends her days at the conservatory at the top of the library, reading several difficult books, often in different languages, simultaneously. She points at one wall of the library and has told Kazuya that she has read almost all the books over there. Along with her sharp tongue, abusive bluntness and eccentric attitude, she possesses amazing detective skills.";
    Morgiana = "(Magi: The Labyrinth of Magic) Belonging to the fierce tribe of the Fanalis, descendants of the red lions originating from ''Alma torran''. She is inspired by Morgiana from the Thousand and One Nights, the intelligent slave who served Alibaba in ''Alibaba and the Forty Thieves''.";
    UmaruDoma = "(Himouto! Umaru-chanS) Umaru is the perfect high school girl who is regarded for her looks, personality, grades, and just about everything; however, when she is at home with her older brother, she dons a hood and acts as a lazy shut-in who loves playing video games, eating junk food, looking at manga/anime, and buying stuff online.";
    Happy = "(Fairy Tail) Happy has a very cheerful nature. Even when facing danger, he maintains a smile. Along with Lucy, he is one of the saner members of Fairy Tail and often acts as the mediator between Natsu and Gray.";
    KoutarouTatsumi = "(Zombieland Saga) Always seen wearing a black jacket on his back, a red vest with a tentacle from the Kojima food industry sticking out, and black sunglasses that never fall off. An arrogant man who won't let common sense get in his way, he was the one that resurrected the seven \"legendary\" zombies. He plans to enlist the zombie idols to save the Saga prefecture, the so-called \"Zombie Land Saga Project\", although no one knows the true details of his plans. ";
    Sakaki = "(Azumanga Web Daiou) Sakaki is a quiet, stylish girl. Looking cool and distant, she's often seen staring out of the window. Being tall and well-endowed in both athletics and appearance, she's often admired by many girls in her school. She loves cats and always attempts to be friendly with them, but often gets scratched and bitten in response";
    ChihiroOgino = "(Spirited Away) Chihiro is a shy, pessimistic, 10-year-old girl. At the beginning of the movie, she and her parents are in the process of moving to a new town. When her father takes the wrong turn, they end up near what her father thinks is \"an abandoned amusement park.\" In reality, it is a bath house for spirits which operates at night time. Her parents are turned into pigs after they eat the food of the spirits. She attempts to run away, but Haku advises her to work for Yubaba until she can find a way to turn her parents back to normal.";
    UryuuIshida = "(Bleach) Uryuu is a friend of Ichigo's and one of the last surviving Quincy. Uryuu Ishida is a dark blue-haired, bespectacled teenager of average height. At school, Uryuu wears the school uniform along with a tie, while outside he dons white Quincy clothes with blue stripes representing the Quincy cross, and a mantle.";
    SatoriTendou = "(Haikyuu!!)";
    ErinaNakiri = "(Food Wars!) Due to her background as one of the prestige family of high-class Japanese food chain industry, the Tootsuki Corporation, Erina often looks down upon whoever is considered as \"common\" and unjust to her taste due to her family's high pedigree. Having a fearsome reputation for her \"God's Tongue\" to taste the food flavor accurate, Erina is able to disqualify anyone whose the dish taste \"bad\" and her foul critic could break the chef (and student alike) soul of tenacity. She is also one of the Elite 10 in Tootsuki Culinary Academy and uses her position to judge a student dish based on their family background and status.";
    WinryRockbell = "(Fullmetal Alchemist) A childhood friend of the central characters, the Elric brothers, Winry is often seen in their company throughout the series. She is evidently Edward's love interest. Specializing in mechanical repair, specifically with automail, Winry services Edward's arm and leg whenever it is in need of repair or replacement.";
    NateRiver = "(Death Note) In Death Note, Near is the youngest of L's two successors raised in Wammy's House, Watari's orphanage for gifted children, in Winchester, England, United Kingdom. Of the successors, Near is the more level-headed, calmly assessing the situation, while the other, Mello, is more emotional and quick to act. Much like L, Near shows various odd behaviors during his normal life. He is usually seen hunched over rather than sitting. He also constantly plays with various toys, which he uses in his theories, as well as idly twiddling strands of his hair. He shows a great respect for L, basing much of how he solves crime on L's methods, even to the point where he only takes cases that he is interested with rather than trying to pursue justice. Near uses the Wedding Text font \"N\" and \"L\" to represent himself and the fake L, respectively. But later in the aftermath, he used Old English font \"L\" like the original L did.";
    Nausicaa = "(Nausicaa) The Princess of the Valley of Wind. She is clever, resourceful, and a skilled swordswoman. She is a windrider, who can read and utilize the wind well, and flies a \"Mehve,\" a glider with an engine. She has an empathetic ability and can even communicate with insects from the Sea of Corruption. As a next chieftain of the Valley, she joins Kushana's army, but the gruesome reality of the war devastates her. She desperately tries to stop mass killing and suffering, and her quest for the truth leads her to the most unimaginable places, and to the biggest secret of the world.";
    Sakamoto = "(Helvetica Standard) A black cat who wears a scarf created by the Professor, which allows him to speak. Being theoretically older than both Nano and the Professor when converting cat years to human years, he speaks in a condescending tone towards them and wants to be called \"Sakamoto-san\", though he often succumbs to his catlike habits.";
    Akaza = "(Demon Slayer) Akaza is a member of the Twelve Demon Moons, holding the position of Upper Moon Three. He is often depicted as having a disagreement with his fellow Upper Moon members, especially Douma. The main reason is their ideological differences: Akaza refuses to eat women, while women are Douma's favorite food. Akaza particularly enjoys fighting passionate individuals like Kyojuro, as his Compass Needle technique allows him to detect a person's presence by detecting their opponent's \"Fighting Spirit.\"";
    Haku = "(Spirited Away) Haku is Chihiro's first friend in the strange world. He studies with the sorceress Yubaba and has magical powers. It's said he lost his way home as well as his name in the world of spirits.";
    Ymir = "(Attack on Titan) Member of the Scouting Legion. She seems selfish, cynical, bossy, sly, uncooperative, exploitative and confrontational, but she can apparently be kind, especially to Krista.";
    PieckFinger = "(Attack on Titan) Pieck is an Eldian warrior serving the Marley government.";
    ChinatsuKano = "(Ao no Hako) A second-year attending Eimei Senior High School as well as a member of the girls' basketball team. Her likable personality and prowess in sports make her one of the most popular among her schoolmates. While she's mostly known as a laid-back student, Chinatsu is secretly quite competitive, as she frequently arrives to practice at the gym in the morning even earlier than Taiki Inomata.";
    JeanPierrePolnareff = "(JoJo's Bizarre Adventure) Polnareff is the stereotypical \"good-natured klutz.\" He is heroic and protective of those he loves but is not very bright (although he has shown lots of cunning and strategy throughout the series). He is very impulsive, loud, and quick to jump into action without considering the risk, character traits that have landed him in lots of trouble. However, he is sincerely dedicated to doing good and is a good man who can watch his friends' backs. He also fancies himself as a ladies man, but his personality implies that he overestimates his actual prowess.";
    Migi = "(Kiseijuu) Migi is the Parasite which lives in Shinichi's hand. Unlike \"successful\" Parasites, Migi has no desire to kill humans for sustenance, and is nourished by the food Shinichi eats. Migi is, like other Parasites, completely without emotion. His primary consideration is survival, and he has threatened (and in some cases attempted) to kill other humans who pose a threat to his and Shinichi's secrecy. When he and Shinichi were first coming to terms, he even threatened to remove Shinichi's other limbs in order to render him unable to place the two of them in danger. Migi can be reasoned with, however, and has just as much reason to be mistrustful of other Parasites as does Shinichi. On the other hand, unlike Shinichi, Migi has no inclination to place himself at risk in order to protect other humans from Parasites.";
    Neferpitou = "(Hunter x Hunter) Neferpitou is very loyal to the King and will sacrifice themself for him. Of the three Royal Guards, Pitou is the most curious and would get distracted easily, and loves to play.";
    HancockBoa = "(One Piece) She is one of the Shichibukai and captain of the Kuja Pirates. She is the Empress of the Amazon Tribe on the Isle of Woman. She detests the World Government, but wants to keep her Shichibukai title. Her immense beauty belies her cruel personality, as shown when she kicks a kitten in her way.";
    JeanKirstein = "(Attack on Titan) Ranked 6th of the trainee class. Extremely pessimistic about the War with the Titans. He ends up leading the people on the supply mission for gas. From the Trost District. Seems like he's amazed by Mikasa's beauty, and thus hating Eren for always being with her.";
    Franky = "(One Piece) Franky is a 34 year old cyborg who is the shipwright of the Straw Hat Pirates and their third most recently recruited member. He first appeared in the Water 7 arc. Franky is one of \"Tom's Workers\", with the original name \"Cutty Flam.\"";
    HatsuneMiku = "She is a tsundere type character. Her design is inspired by the VOCALOID Hatsune Miku and her voice actor is Saki Fujita, but most of the time we can hear the VOCALOID's voice, Hatsune Miku herself.";
    JonathanJoestar = "(JoJo's Bizarre Adventure) Jonathan Joestar is the protagonist of Part 1: Phantom Blood, and the first JoJo of the JoJo's Bizarre Adventure series. The son of George Joestar I, Jonathan is an honest, kind, and positive man whose life is fraught with tragedy after meeting his adopted older brother, Dio Brando.";
    Totoro = "(My Neigbor Totoro) One of three forest spirits.";
    Pochita = "(Chainsaw Man) Pochita is the chainsaw devil.";
    Chii = "(Chobits) Chii is a Persocom who is found by Hideki Motosuwa in a garbage dump. At first, she is only able to say \"Chii\", thus earning her that name. Later on, she is taught various things, and is eventually able to communicate with other people.";
    KyoujurouRengoku = "(Demon Slayer) Kyoujurou was a young adult of tall stature and athletic build. He is known have an air of great optimism about him, having an enthusiastic smile plastered on his face nearly all the time. He had long bright yellow hair with red streaks akin to flames along with two shoulder-length bangs and two chin-length bangs on the side of his head, black forked eyebrows, and golden eyes that fade to red with white pupils.";
    NezukoKamado = "(Demon Slayer) Nezuko is Tanjirou's sister turned demon.";
    Lucy = "(Elfen Lied) Lucy is a Diclonius girl around eighteen years old. She has developed strong emotions of hatred and vengeance towards regular humans mainly because of how she was treated by the majority of them as a child, making fun of her horns and giving her insulting nicknames such as freak. ";
    Howl = "(Howl's Moving Castle) Howl is a mysterious, reclusive wizard who is known for being very flamboyant and wicked. His notorious moving castle has recently been spotted near Market Chipping and rumors have begun to spread that he is searching for beautiful young women whose hearts he may steal. He comes from Wales, a country unknown to most in the book, where his family still remain unaware of his activities in Sophie's world or of its existence.";
    Ryuk = "(Death Note) The original Shinigami who dropped the Death Note in the human world, and also love apples, which Light would pick up. Acting out of pure boredom, Ryuk begins the story of Death Note on a whim. Perhaps neutral by nature, Ryuk often refuses to aid Light and instead enjoys watching him struggle for his goal. The most important facet of Ryuk's character is that he is not Light's friend. He acts for his own interests and entertainment, and often fails to tell Light key details about the Death Note. Ryuk is selfish, however, and will aid Light if it serves his own goals, such as providing amusement or obtaining apples.";
    Reze = "(Chainsaw Man) Reze, also known as Bomb Girl, is the Bomb Devil Hybrid from the Soviet Union, who was sent to Japan with the mission of stealing the Chainsaw Man's heart. ";
    lucy = "(Cyberpunk Edgerunners) Lucyna Kushinada, more commonly known as just Lucy, is a netrunner and the deuteragonist of the series. She is a mysterious netrunner from Night City. Lucy is quite introverted and doesn't like to talk much about her past. Although she looks innocent, she won't hesitate to kill a person in a heartbeat if they tick her off. Lucy also considers Night City a prison and dreams of one day leaving it for the Moon.";
    MeiMisaki = "(Another) A mysterious and isolated girl in Yomiyama North Middle School's third year's third class. Her left eye is covered by an eye patch. The girl with a mysterious presence and who is always sketching alone. She is labelled as the one that \"does not exist.\"";
    FutureTrunks = "(Dragon Ball) Well-mannered, serious and very cautious, Trunks hails from an alternate timeline in which Future Androids 17 and 18 murdered the Dragon Team and proceeded to create an apocalyptic anarchy on Earth. Trunks is trained by Future Gohan as a teenager and becomes a gifted fighter, swordsman and a Super Saiyajin.";
    Sanji = "(One Piece) Sanji is the chain-smoking chef of the Straw Hat Pirate Crew. He has superb fighting skills that only make use of his legs, in an effort to minimize damage to his hands which would impair his cooking skills.";
    Saitama = "(One Frame Man) Saitama is the most powerful hero alive. Having apparently trained himself to superhuman condition, Saitama faces an existential crisis as he is now too powerful to gain any thrill from his heroic deeds.";
    LLawliet = "(Death Note) L, who also uses the aliases Hideki Ryuga, Ryuzaki, Eraldo Coil and Deneuve, the latter two for which he has developed reputations as the second—and third—best detectives in the world, is quite secretive and only communicates with the world through his assistant Watari. He never shows his face to the world, instead of representing himself with a capital L in Cloister Black font. After meeting the Kira investigation team, he requests that the task force refers to him as Ryuzaki for discretion. The Kira investigation team never learns his true name.";
    Frieren = "(Frieren) Frieren was a mage in Hero Himmel's party. They travelled along with Priest Heiter and Warrior Eisen in a ten-year journey to defeat the Demon King. She was the last member to be recruited to the party and, despite Heiter's initial impression of her mana being average, Himmel had a hunch she was the most powerful mage he had ever met.";
    ErwinSmith = "(Attack on Titan) Erwin Smith is the Commander of the Scouting Legion, known for his foresight, intelligence, and drive. His ultimate goal is for humanity to return to its former glory and would sacrifice any number of his men for the sake of mankind as a whole.";
    TanjirouKamado = "(Demon Slayer) Tanjirou Kamado is the main protagonist of Kimetsu no Yaiba, who becomes a Demon Hunter and joins the Demon Killing Corps to hunt down the demon who murdered his family and turned his sister Nezuko into a demon.";
    KusuoSaiki = "(Saiki K) Saiki has an extremely uncaring personality. As a gifted psychic that can do anything he wants, he has long stopped caring about the world; however, he has shown to be extremely cautious, as he often runs from Nendou, the only person he fears, and is prone to immediately teleporting to far away places upon spotting an insect. Saiki has a sweet tooth, especially for Coffee Jelly.";
    ArminArlert = "(Attack on Titan) Armin is a genius in theoretical courses and can make plans even under extreme pressure"; 
    ChopperTonyTony = "(One Piece) He is the Straw Hat crew's general physician despite being a reindeer. After a set of unusual circumstances, he ate the Hito Hito no Mi (Human Human Fruit), which permitted him the ability to speak, think, and, to a limited extent, change into a human.";
    DavidMartinez = "(Cyberpunk Edgerunners) David Martinez is the protagonist of the series. He became a mercenary and a member of Maine's edgerunner crew in 2076 when he was involved in a series of harrowing events that resulted in him attaining the status of a Night City legend.";
    Levi = "(Attack on Titan) Levi is known as humanity's most powerful soldier. He's ranked as Captain of the Scouting Legion division. Levi is also the leader of the Special Operations Squad, an elite team that he hand-picked in order to protect Eren Yeager. While it is said that he is blunt and unapproachable, it is noted that he has a strong respect for structure and discipline. There are rumors that he was originally part of underground crime before he became a soldier. Although he often appears to be unfriendly, he cares deeply for his team and has never undervalued human life. He is also a notorious clean-freak.";
    LightYagami = "(Death Note) Light, born on February 28, 1986, is a third-year high school student (12th grade) at Daikoku Private Academy (大国学園, Daikoku Gakuen) who also attends supplemental classes at Gamou Prep Academy at the beginning of the story. Light has a father, Soichiro Yagami, who is the head of the Police Force. Light also has a mother, Sachiko Yagami, and a younger sister, Sayu Yagami."; 
    ZoroRoronoa = "(One Piece) Zoro was the first crew member to be recruited by Luffy. Zoro is a skilled swordsman who fights with his own unique sword style known as santoryu (three katana fighting style). This is achieved by using one katana in each hand and another in his mouth. He is also seen fighting with only one or two swords. When in a serious fight he ties his bandana, normally tied on the arm, on his head.";
    NarutoUzumaki = "(Nauruto) Born in Konohagakure, a ninja village hidden in the leaves, Naruto Uzumaki was destined for greatness. When born, a powerful nine-tailed demon fox attacked his village. With a wave of its tail, the demon fox could raise tsunamis and shatter mountains. In a valiant attempt to save the village from destruction, the Fourth Hokage, the leader of the Hidden Leaf Village, sealed the demon fox within Naruto's newborn body. This was his final act, for the battle with the fox cost him his life.";
    ErenYeager = "(Attack on Titan) Eren is Shingeki no Kyojin's protagonist. His childhood friend, Mikasa, notes on numerous occasions that he acts on impulse without thinking things through, and she often pulls/carries/throws him when he starts fighting with others to protect him from himself. Along with Mikasa, he tends to spend his free time with their mutual friend, Armin.";
    SatoruGojou = "(JJK) When interacting with his students and friends, he is known to be quite playful and carefree. However, toward his enemies, he has shown to be quite cruel and rebellious. He is also very confident in his abilities and reputation as a powerful sorcerer.";
    MikasaAckerman = "As a teen, Mikasa is considered a genius among all the army trainees and is incredibly skilled at combat and agility.";
    GokuuSon = "(Dragon Ball Z) Originally named Kakarot, Gokuu is born a member of a race of extraterrestrials called the Saiyans. Shortly following his birth, Gokuu is sent from his native planet Vegeta to Earth, for potential selling on the intergalactic market by destroying all its life; Goku was also sent away to escape Freeza's genocide of the Saiyans. Once he lands on Earth, he is adopted by an old man named Gohan (who is later just called Grandpa Gohan). At first, Goku is very violent as a kid due to his Saiyan blood, but due to an injury to his head that caused him severe amnesia, Gokuu changes to a more tempered, innocent boy. At the start of the series, Gokuu meets Bulma, Yamucha, Oolong, and Pu'ar, whose characters mirror those found in Wu Cheng'en's Journey to the West. He also encounters Kuririn, who eventually becomes his best friend, and others during his journey for more strength. Participating in several World Martial Arts Tournaments, Gokuu also battles foes-turned-allies such as Tenshinhan and Chaozu, as well as the offspring of Demon King Piccolo named Majunior (later, he's named just Piccolo).";
    YangWenli = "(Legend of Galatic Heroes) Yang Wen-li was an officer in the Free Planets Alliance space fleet. Known as one of the greatest admirals in human history, and at the very least equal to the brilliance of his Imperial counterpart Reinhard von Lohengramm. Despite his genius, Yang Wen-li was a relatively simple man harboring no great ambitions. A firm believer in democracy, Yang Wen-li followed his ideals without wavering throughout his entire life. ";
    IppoMakunouchi = "(Hajime no Ippo) Ippo Makunouchi is the eponymous protagonist of Hajime no Ippo. He is a trainer, and also a retired featherweight professional boxer from the Kamogawa Boxing Gym and a former reigning featherweight JBC champion.";
    Grape = "The great QUEEN Grape!!!";
}
##Culling
component Activatable
{
    Active = false;

    _active = false;

    function Initialize()
    {
        self._active = self.Active;
    }

    function Reset()
    {
        self.Initialize();
    }

    function OnGameStart()
    {
        self.Initialize();
    }

    function Activate()
    {
        self._active = true;
    }

    function Deactivate()
    {
        self._active = false;
    }

    function Toggle()
    {
        self._active = !self._active;
    }

    # @return bool
    function IsActive()
    {
        return self._active;
    }
}

component DistanceButton
{
    ActivatableID = 0;
    ActivatableIDTooltip = "Leave 0 to use the Activatable component from the same object.";
    DeactivateDelay = 0.0;
    DeactivateDelayTooltip = "Time after which Activatable will be deactivated on deactivation trigger.";
    Distance = 100.0;
    DistanceTooltip = "Maximum distance from the player to trigger the component's activation/deactivation.";
    Reverse = false;
    ReverseTooltip = "If true, the activation behavior is reversed, activating the component when it would normally deactivate.";

    # @type Activatable
    _activatable = null;
    # @type Timer
    _timer = null;

    function Initialize()
    {
        self._timer = Timer(0.0);
        if (self.ActivatableID <= 0)
        {
            self._activatable = self.MapObject.GetComponent("Activatable");
        }
        else 
        {
            obj = Map.FindMapObjectByID(self.ActivatableID);
            self._activatable = obj.GetComponent("Activatable");
        }
    }
    
    function OnGameStart()
    {
        self.Initialize();
    }

    function OnTick()
    {
        c = Network.MyPlayer.Character;
        if (c != null)
        {
            d = Vector3.Distance(c.Position, self.MapObject.Position);
            if (d <= self.Distance)
            {
                self._timer.Reset(self.DeactivateDelay + 0.25);
            }
        }

        self._timer.UpdateOnTick();
        if (self._timer.IsDone())
        {
            if (self.Reverse)
            {
                self._activatable.Activate();
            }
            else
            {
                self._activatable.Deactivate();
            }
        }
        else
        {
            if (self.Reverse)
            {
                self._activatable.Deactivate();
            }
            else
            {
                self._activatable.Activate();
            }
        }
    }

    function IsActive()
    {
        return self._activatable.IsActive();
    }
}

component RegionButton
{
    DeactivateDelay = 0.0;
    DeactivateDelayTooltip = "Time after which Activatable will be deactivated on deactivation trigger.";
    Reverse = false;
    ReverseTooltip = "If true, the activation behavior is reversed, activating the component when it would normally deactivate.";

    # @type Activatable
    _activatable = null;
    _timer = Timer(0.0);

    function Initialize()
    {
        self._activatable = self.MapObject.GetComponent("Activatable");
    }

    function OnGameStart()
    {
        self.Initialize();
    }

    function OnCollisionStay(obj)
    {
        if ((obj.Type != "Human" && obj.Type != "Titan" && obj.Type != "Shifter") || !obj.IsMine)
        {
            return;
        }

        self._timer.Reset(self.DeactivateDelay + 0.25);
    }

    function OnCollisionExit(obj)
    {
        if ((obj.Type != "Human" && obj.Type != "Titan" && obj.Type != "Shifter") || !obj.IsMine)
        {
            return;
        }

        self._timer.Reset(self.DeactivateDelay);
    }

    function OnTick()
    {
        self._timer.UpdateOnTick();
        if (self._timer.IsDone())
        {
            if (self.Reverse)
            {
                self._activatable.Activate();
            }
            else
            {
                self._activatable.Deactivate();
            }
        }
        else
        {
            if (self.Reverse)
            {
                self._activatable.Deactivate();
            }
            else
            {
                self._activatable.Activate();
            }
        }
    }

    function IsActive()
    {
        return self._activatable.IsActive();
    }
}

component ActiveControl
{
    ActivatableID = 0;
    ActivatableIDTooltip = "Leave 0 to use the Activatable component from the same object.";
    Reverse = false;
    ReverseTooltip = "If true, the activation behavior is reversed, activating the component when it would normally deactivate.";

    # @type Activatable
    _activatable = null;
    _activated = false;
    _deactivatableList = List();

    function Initialize()
    {
        obj = Map.FindMapObjectByID(self.ActivatableID);
        self._activatable = obj.GetComponent("Activatable");
        isActive = self._activatable.IsActive() != self.Reverse;

        self._RegisterDeactivatableComponents();

        if (!isActive)
        {
            self._Deactivate();
        }

        self._activated = isActive;
    }

    # Registers components with OnDeactivate() callback to call when ActiveControl will deactivate all MapObjects components.
    function _RegisterDeactivatableComponents()
    {
        # Example
        # self._deactivatableList.Add("ComponentName1");
        # self._deactivatableList.Add("ComponentName2");
        # self._deactivatableList.Add("ComponentName3");
    }

    function OnGameStart()
    {
        self.Initialize();
    }

    function OnTick()
    {
        isActive = self._activatable == null || (self._activatable.IsActive() != self.Reverse);
        if (self._activated == isActive)
        {
            return;
        }

        self._activated = isActive;

        self.MapObject.Active = self._activated;
        if (!self._activated)
        {
            self._Deactivate();
        }
        else
        {
            self._Activate();
        }
    }

    function _Activate()
    {
        self.MapObject.SetComponentsEnabled(true);
    }

    function _Deactivate()
    {
        self.MapObject.SetComponentsEnabled(false);
        self.MapObject.SetComponentEnabled("ActiveControl", true);

        for (k in self._deactivatableList)
        {
            comp = self.MapObject.GetComponent(k);
            if (comp != null)
            {
                comp.OnDeactivate();
            }
        }
    }
}

class Timer
{
    _time = 0.0;
    _lastInitialTime = 0.0;

    # @param time float
    function Init(time)
    {
        self.Reset(time);
    }

    # @param decimals int
    # @return string
    function String(decimals)
    {
        return String.FormatFloat(self._time, decimals);
    }

    # @return float
    function GetTime()
    {
        return self._time;
    }
    
    # @return float
    function GetInitialTime()
    {
        return self._lastInitialTime;
    }

    # @return bool
    function IsDone()
    {
        return self._time <= 0.0;
    }

    # @param time float
    function Reset(time)
    {
        self._time = time;
        self._lastInitialTime = time;
    }

    function UpdateOnFrame()
    {
        self.update(Time.FrameTime);
    }

    function UpdateOnTick()
    {
        self.update(Time.TickTime);
    }

    # @param val float
    function update(val)
    {
        self._time -= val;
    }
}
#addons
addon Decapitation
{
	DecapitationMinimumDamage = 2500;
	_decapitatedTitans = List();
	
	function OnCharacterDamaged(victim, killer, killerName, damage)
	{
		if(victim == null || killer == null) { return; }
		if(victim.Type != CharacterTypeEnum.Titan || killer.Type != CharacterTypeEnum.Human || damage < self.DecapitationMinimumDamage) { return; }
		if(self._decapitatedTitans.Contains(victim)) { return; }

		if(killer.IsMine && killer.IsMainCharacter) {
			effectSize = 7 + victim.Size * 1.5;
			Game.SpawnEffect(EffectNameEnum.Blood2, victim.NapePosition, Vector3(), effectSize);
		}
		killer.PlaySound(HumanSoundEnum.Death3);
		
		self._decapitatedTitans.Add(victim);
		self.DelayRemoval(victim);
	}

	# All it really needed was conditional statements on the titan var and it's property
	# Pretty sure the game destroys the titan/titanNeckMount on death before we could read/destroy the stored reference
	# Also has a more efficient loop rather than for loop with range
	function OnLateFrame()
	{
		i = self._decapitatedTitans.Count - 1;
		while(i >= 0) {
			titan = self._decapitatedTitans.Get(i);
			if(titan == null)
			{
				self._decapitatedTitans.RemoveAt(i);
			} elif(titan.NeckMount == null) {
				self._decapitatedTitans.RemoveAt(i);
			} else {
				titan.NeckMount.Scale = Vector3(0);
			}
			i = i - 1;
		}
	}

	coroutine DelayRemoval(titan)
	{	
		deathAnimLength = titan.GetAnimationLength(TitanAnimationEnum.DieBack) + 4.1; 
		wait deathAnimLength;
		self._decapitatedTitans.Remove(titan);
	}
}
