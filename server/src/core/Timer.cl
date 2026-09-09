class Timer
{
    _time = 0.0;
    _initialTime = 0.0;

    function Init(time) {self.Reset(time);}
    function String(decimals) {return String.FormatFloat(self._time, decimals);}
    function GetTime() {return self._time;}
    function GetInitialTime() {return self._initialTime;}
    function IsDone() {return self._time <= 0.0;}

    function Reset(time)
    {
        self._initialTime = Math.Max(0.0, Convert.ToFloat(time));
        self._time = self._initialTime;
    }

    function UpdateOnFrame() {self.Update(Time.FrameTime);}
    function UpdateOnTick() {self.Update(Time.TickTime);}
    function update(value) {self.Update(value);}

    function Update(value)
    {
        self._time = Math.Max(0.0, self._time - Math.Max(0.0, Convert.ToFloat(value)));
    }
}
