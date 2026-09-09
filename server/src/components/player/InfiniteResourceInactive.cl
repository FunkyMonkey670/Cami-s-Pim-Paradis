component __InfiniteResource_Inactive
{
    Description = "Internal only - DO NOT USE IN MAP EDITOR";

    function OnPlayerSpawn(player, character)
    {
        if (player == Network.MyPlayer && character != null && character.Type == "Human") {InfiniteResourceSingleton.Activate(character);}
    }
}
