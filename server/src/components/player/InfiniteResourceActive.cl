component __InfiniteResource_Active
{
    Description = "Internal only - DO NOT USE IN MAP EDITOR";

    function OnCharacterDie(victim, killer, killerName)
    {
        if (victim != null && victim == InfiniteResourceSingleton.ActiveHuman) {InfiniteResourceSingleton.Deactivate();}
    }

    function OnTick()
    {
        settings = InfiniteResourceSingleton.SettingsComponent;
        human = InfiniteResourceSingleton.ActiveHuman;
        if (settings == null || human == null || human.Type != "Human") {return;}
        if (settings.InfiniteGas) {human.CurrentGas = human.MaxGas;}
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
