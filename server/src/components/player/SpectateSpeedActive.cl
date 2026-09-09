component zzz_SpectateSpeed_Active
{
    Description = "Internal only - DO NOT USE IN MAP EDITOR";
    _spectateID = -1;
    _character = null;
    _previousPosition = Vector3.Zero;
    _smoothedSpeed = 0.0;
    _samples = 0;

    function OnGameStart() {}

    function OnDisable()
    {
        self._spectateID = -1;
        self._character = null;
        self._samples = 0;
        self._smoothedSpeed = 0.0;
    }

    function OnFrame()
    {
        spectateID = Network.MyPlayer.SpectateID;
        player = Network.FindPlayer(spectateID);
        character = null;
        if (player != null) {character = player.Character;}
        if (spectateID != self._spectateID || character != self._character)
        {
            self._spectateID = spectateID;
            self._character = character;
            self._samples = 0;
            self._smoothedSpeed = 0.0;
            if (character != null) {self._previousPosition = character.Position;}
        }
        if (character == null) {return;}
        frameTime = Math.Max(0.0001, Time.FrameTime);
        speed = ((character.Position - self._previousPosition) / frameTime).Magnitude;
        self._previousPosition = character.Position;
        self._smoothedSpeed = self._smoothedSpeed * 0.75 + speed * 0.25;
        self._samples += 1;
        if (character.Type == "Human" && (character.State == "Grab" || character.CurrentAnimation == "Armature|grabbed")) {self._smoothedSpeed = 0.0;}
        if (self._samples >= 3)
        {
            UI.SetLabelForTime(UILabelEnum.BottomCenter, "<color=#ffffff>Speedometer: " + String.FormatFloat(self._smoothedSpeed, 1) + " u/s</color>", 0.25);
        }
    }
}
