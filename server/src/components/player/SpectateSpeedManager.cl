component zzz_SpectateSpeed_Manager
{
    Description = "Internal only - DO NOT USE IN MAP EDITOR";

    function OnPlayerSpawn(player, character)
    {
        if (character == null || !character.IsMainCharacter || SpectateSpeedSingleton.MapObject == null) {return;}
        SpectateSpeedSingleton.MapObject.SetComponentEnabled(SpectateSpeedSingleton.ActiveComponentName, false);
        if (SpectateSpeedSingleton.ActiveComponent != null) {SpectateSpeedSingleton.ActiveComponent.OnDisable();}
    }

    function OnCharacterDie(victim, killer, killerName)
    {
        if (victim != null && victim.IsMainCharacter && SpectateSpeedSingleton.MapObject != null)
        {
            SpectateSpeedSingleton.MapObject.SetComponentEnabled(SpectateSpeedSingleton.ActiveComponentName, true);
        }
    }
}
