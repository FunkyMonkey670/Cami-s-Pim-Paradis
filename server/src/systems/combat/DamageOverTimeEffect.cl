component DamageOverTimeEffect
{
    function SendNetworkStream()
    {
        if (self.MapObject != null) {self.NetworkView.SendStream(self.MapObject.LocalPosition);}
    }

    function OnNetworkStream()
    {
        if (self.MapObject == null) {return;}
        position = self.NetworkView.ReceiveStream();
        if (position != null) {self.MapObject.Position = position;}
    }
}
