component FistFight
{
    LeftRange = 2.2;
    RightRange = 3.4;
    AttackAngle = 100.0;
    AttackDuration = 0.55;
    AttackSampleInterval = 0.05;
    AttackCooldown = 0.45;
    ArenaSpeed = 70.0;

    _localHuman = null;
    _insideUntil = 0.0;
    _cooldownUntil = 0.0;
    _originalSpeed = 70.0;
    _directionalAttackEnabled = false;

    function IsLocalHuman(obj)
    {
        return obj != null && obj.IsCharacter && obj.IsMine && obj.Type == "Human";
    }

    function OnCollisionStay(obj)
    {
        if (!self.IsLocalHuman(obj)) {return;}
        newlyEntered = self._localHuman != obj;
        self._localHuman = obj;
        self._insideUntil = Time.GameTime + 0.25;
        Input.SetKeyDefaultEnabled(InputHumanEnum.AttackDefault, false);
        if (!newlyEntered) {return;}
        self._originalSpeed = obj.Speed;
        obj.CurrentBladeDurability = 0;
        obj.CurrentBlade = 0;
        obj.Speed = self.ArenaSpeed;
        obj.MaxGas = 0;
        obj.CurrentGas = 0;
        obj.SetSpecial("None");
        StaminaBar.OnPlayerSpawn(obj.Player, obj);
    }

    function OnCollisionExit(obj)
    {
        if (!self.IsLocalHuman(obj) || obj != self._localHuman) {return;}
        self.ExitArena();
    }

    function ExitArena()
    {
        Input.SetKeyDefaultEnabled(InputHumanEnum.AttackDefault, true);
        if (self._localHuman != null) {self._localHuman.Speed = self._originalSpeed;}
        self._localHuman = null;
    }

    function OnCharacterDamaged(victim, killer, killerName, damage)
    {
        if (victim == null || victim.Type != "Human") {return;}
        victim.PlaySound(HumanSoundEnum.CrashLand);
        Game.SpawnEffect(EffectNameEnum.Blood1, victim.Position, Vector3.Zero, 1.0);
    }

    function OnFrame()
    {
        character = Network.MyPlayer.Character;
        if (self._localHuman == null || character == null || character != self._localHuman) {return;}
        if (Time.GameTime > self._insideUntil) {self.ExitArena(); return;}

        StaminaBar.OnFrame();
        if (Input.GetKeyDown(InputInteractionEnum.Function4))
        {
            self._directionalAttackEnabled = !self._directionalAttackEnabled;
        }
        if (Input.GetKeyDown(InputInteractionEnum.Interact)) {self.Dodge();}
        if (Time.GameTime < self._cooldownUntil || StaminaBar._stamina < StaminaBar.AttackCost) {return;}
        if (Input.GetKeyDown(InputHumanEnum.AttackDefault)) {self.BeginAttack(false);}
        elif (Input.GetKeyDown(InputHumanEnum.AttackSpecial)) {self.BeginAttack(true);}
    }

    function OnTick()
    {
        if (self._localHuman == null) {return;}
        StaminaBar.OnTick();
        if (self._directionalAttackEnabled) {DirectionalAttack.OnTick();}
    }

    function BeginAttack(right)
    {
        character = Network.MyPlayer.Character;
        if (character == null || character != self._localHuman) {return;}
        self._cooldownUntil = Time.GameTime + self.AttackCooldown;
        animation = "Armature|TS_shoot_L";
        if (right) {animation = "Armature|TS_shoot_R";}
        character.ForceAnimation(animation, 0.3);
        if (right && character.Grounded) {character.AddForce(character.Forward * 20.0, ForceModeEnum.Impulse);}
        self.ResolveAttack(right, character);
    }

    coroutine ResolveAttack(right, attacker)
    {
        hitPlayers = Set();
        elapsed = 0.0;
        while (elapsed < self.AttackDuration && attacker != null && attacker == Network.MyPlayer.Character)
        {
            attackRange = self.LeftRange;
            minDamage = 2;
            maxDamage = 20;
            if (right) {attackRange = self.RightRange; minDamage = 7; maxDamage = 30;}
            for (target in Game.Humans)
            {
                if (target == null || target == attacker || target.IsAI || target.Player == null || hitPlayers.Contains(target.Player.ID)) {continue;}
                direction = (target.Position - attacker.Position).Normalized;
                if (Vector3.Distance(target.Position, attacker.Position) <= attackRange && Vector3.Angle(attacker.TargetDirection, direction) <= self.AttackAngle)
                {
                    target.GetDamaged(Network.MyPlayer.Name, Random.RandomInt(minDamage, maxDamage + 1));
                    hitPlayers.Add(target.Player.ID);
                }
            }
            wait self.AttackSampleInterval;
            elapsed += self.AttackSampleInterval;
        }
    }

    function Dodge()
    {
        character = Network.MyPlayer.Character;
        if (character != null) {character.ForceAnimation(HumanAnimationEnum.Air2Backward);}
    }
}
