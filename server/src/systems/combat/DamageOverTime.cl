component DamageOverTime
{
    Damage = 9999;
    CountdownTime = 10.0;
    CountdownText = "YOU ARE BURNING TO DEATH IN";
    CloseToDeathEffectEnabled = true;
    CloseToDeathEffectTriggerTime = 5.0;
    CloseToDeathEffect = "TitanDie1";
    CloseToDeathMapObjectsIDs = "742 743";
    DeathEffect = "TitanDie2";
    DeathSoundEffect = "ThunderspearLaunch";
    DamagedText = "Burning";

    _activeTimers = Dict();
    _activePlayerEffects = Dict();
    _nextEffectTimes = Dict();
    _consumedCharacters = Set();

    function IsEligible(other)
    {
        return other != null && other.IsCharacter && other.IsMine && other.Type != "Titan";
    }

    function BeginCountdown(other)
    {
        if (!self.IsEligible(other) || self._consumedCharacters.Contains(other)) {return;}
        if (!self._activeTimers.Contains(other))
        {
            self._activeTimers.Set(other, Time.GameTime + Math.Max(0.0, self.CountdownTime));
        }
    }

    function OnCollisionEnter(other)
    {
        self.BeginCountdown(other);
    }

    function OnCollisionStay(other)
    {
        if (!self.IsEligible(other) || self._consumedCharacters.Contains(other)) {return;}
        self.BeginCountdown(other);
        if (!self._activeTimers.Contains(other)) {return;}

        remaining = self._activeTimers.Get(other) - Time.GameTime;
        UI.SetLabel("MiddleCenter", self.CountdownText + " " + Convert.ToString(Math.Max(0, Math.Round(remaining))));

        if (self.CloseToDeathEffectEnabled && remaining <= self.CloseToDeathEffectTriggerTime)
        {
            self.EnsureAttachedEffects(other);
            self.UpdateAttachedEffects(other);
            nextEffectTime = self._nextEffectTimes.Get(other, 0.0);
            if (Time.GameTime >= nextEffectTime)
            {
                Game.SpawnEffect(self.CloseToDeathEffect, other.Position, other.Rotation, 2.0);
                self._nextEffectTimes.Set(other, Time.GameTime + 1.0);
            }
        }

        if (remaining <= 0.0)
        {
            self._consumedCharacters.Add(other);
            self._activeTimers.Remove(other);
            other.PlaySound(self.DeathSoundEffect);
            other.GetDamaged(self.DamagedText, self.Damage);
            Game.SpawnEffect(self.DeathEffect, other.Position, other.Rotation, 2.0);
            self.CleanupCharacter(other);
            UI.SetLabel("MiddleCenter", "");
        }
    }

    function EnsureAttachedEffects(other)
    {
        if (self._activePlayerEffects.Contains(other)) {return;}
        effects = List();
        for (value in String.Split(self.CloseToDeathMapObjectsIDs, " ", true))
        {
            source = Map.FindMapObjectByID(Convert.ToInt(value));
            if (source == null) {continue;}
            effect = Map.CopyMapObject(source, false);
            if (effect != null) {effects.Add(effect);}
        }
        self._activePlayerEffects.Set(other, effects);
    }

    function UpdateAttachedEffects(other)
    {
        if (!self._activePlayerEffects.Contains(other)) {return;}
        for (effect in self._activePlayerEffects.Get(other))
        {
            if (effect != null) {effect.Position = other.Position + Vector3(0, 0.1, 0);}
        }
    }

    function CleanupCharacter(other)
    {
        if (self._activePlayerEffects.Contains(other))
        {
            for (effect in self._activePlayerEffects.Get(other))
            {
                if (effect != null) {Map.DestroyMapObject(effect, false);}
            }
            self._activePlayerEffects.Remove(other);
        }
        if (self._nextEffectTimes.Contains(other)) {self._nextEffectTimes.Remove(other);}
    }

    function OnCollisionExit(other)
    {
        if (!self.IsEligible(other)) {return;}
        UI.SetLabel("MiddleCenter", "");
        if (self._activeTimers.Contains(other)) {self._activeTimers.Remove(other);}
        if (self._consumedCharacters.Contains(other)) {self._consumedCharacters.Remove(other);}
        self.CleanupCharacter(other);
    }
}
