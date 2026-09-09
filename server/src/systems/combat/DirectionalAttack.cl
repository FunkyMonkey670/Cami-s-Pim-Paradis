extension DirectionalAttack
{
    function OnTick()
    {
        character = Network.MyPlayer.Character;
        if (character == null || character.Type != "Human") {return;}
        if (!character.Grounded || character.State == "Attack") {character.Forward = Camera.Forward;}
    }
}
