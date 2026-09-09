component Guillotine
{
    Description = "Needs Static OFF and Networked ON!";
    KillerName = "Guillotine";
    Damage = 1000;
    RelativePositions = true;
    StartPosition = Vector3.Zero;
    EndPosition = Vector3.Zero;
    Speed = 25.0;
    ReturningSpeed = 5.0;
    RequestDistance = 35.0;

    _progress = 0.0;
    _backwards = false;
    _forwardStep = 1.0;
    _returnStep = 1.0;
    _state = "ready";

    function Init()
    {
        if (self.RelativePositions)
        {
            self.StartPosition = self.MapObject.Position + self.StartPosition;
            self.EndPosition = self.MapObject.Position + self.EndPosition;
        }
        distance = Vector3.Distance(self.StartPosition, self.EndPosition);
        if (distance > 0.0)
        {
            self._forwardStep = Math.Max(0.01, self.Speed) / distance;
            self._returnStep = Math.Max(0.01, self.ReturningSpeed) / distance;
        }
    }

    function OnNetworkMessage(sender, message)
    {
        if (message == "Guillotine.Request" && Network.IsMasterClient)
        {
            if (self._state != "ready" || sender == null || sender.Character == null) {return;}
            if (Vector3.Distance(sender.Character.Position, self.MapObject.Position) > self.RequestDistance) {return;}
            self.NetworkView.SendMessageAll("Guillotine.Drop");
            return;
        }
        if (message == "Guillotine.Drop" && sender == Network.MasterClient)
        {
            self._state = "in-use";
            self._backwards = false;
        }
    }

    function OnFrame()
    {
        if (self._state == "ready") {return;}
        if (self._backwards)
        {
            self._progress = Math.Max(0.0, self._progress - Time.FrameTime * self._returnStep);
            if (self._progress <= 0.0) {self._backwards = false; self._state = "ready";}
        }
        else
        {
            self._progress = Math.Min(1.0, self._progress + Time.FrameTime * self._forwardStep);
            if (self._progress >= 1.0) {self._backwards = true;}
        }
        self.MapObject.Position = Vector3.Lerp(self.StartPosition, self.EndPosition, self._progress);
    }

    function OnCollisionEnter(obj)
    {
        if (obj != null && obj.IsCharacter && obj.IsMine) {obj.GetDamaged(self.KillerName, self.Damage);}
    }

    function Activate() {self.NetworkView.SendMessage(Network.MasterClient, "Guillotine.Request");}
}
