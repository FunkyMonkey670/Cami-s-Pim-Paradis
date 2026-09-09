extension TVController
{
    _capybaras = null;
    _capyPlayer = null;
    _spongebob = null;
    _spongePlayer = null;
    _nearUntil = 0.0;
    _initialized = false;

    function Init()
    {
        if (self._initialized) {return;}
        self._initialized = true;
        self._capybaras = Map.FindMapObjectByName("capybaras");
        self._spongebob = Map.FindMapObjectByName("spongebob");
        if (self._capybaras != null) {self._capyPlayer = self._capybaras.GetUnityComponent("VideoPlayer");}
        if (self._spongebob != null) {self._spongePlayer = self._spongebob.GetUnityComponent("VideoPlayer");}
        Commands.RegisterCommand("play1", self.Play1, "/play1");
        Commands.RegisterCommand("play2", self.Play2, "/play2");
        Commands.RegisterCommand("nextep", self.NextSPEp, "/nextep");
    }

    function SetNearby(near)
    {
        if (near) {self._nearUntil = Time.GameTime + 0.3;}
        else {self._nearUntil = 0.0;}
    }

    function IsNearby() {return Time.GameTime <= self._nearUntil;}

    function Play1()
    {
        if (!self.IsNearby() || self._capybaras == null || self._spongebob == null) {return;}
        self._spongebob.Active = false;
        self._capybaras.Active = true;
        if (self._capyPlayer != null) {self._capyPlayer.Play();}
    }

    function Play2()
    {
        if (!self.IsNearby() || self._capybaras == null || self._spongebob == null) {return;}
        self._capybaras.Active = false;
        self._spongebob.Active = true;
        if (self._spongePlayer != null) {self._spongePlayer.Play();}
    }

    function NextSPEp()
    {
        if (!self.IsNearby() || self._spongebob == null || self._spongePlayer == null || !self._spongebob.Active) {return;}
        self._spongePlayer.Time = Convert.ToFloat(Math.Min(self._spongePlayer.Length, self._spongePlayer.Time + 1200.0));
    }

    function OnNetworkMessage(sender, message, args)
    {
        # Compatibility for old maps. Proximity is now tracked locally by TVZone.
    }
}
