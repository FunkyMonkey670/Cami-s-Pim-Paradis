component Activatable
{
    Active = false;
    _active = false;

    function Init() {self.Initialize();}
    function OnGameStart() {self.Initialize();}
    function Initialize() {self._active = self.Active;}
    function Reset() {self.Initialize();}
    function Activate() {self._active = true;}
    function Deactivate() {self._active = false;}
    function Toggle() {self._active = !self._active;}
    function IsActive() {return self._active;}
}
