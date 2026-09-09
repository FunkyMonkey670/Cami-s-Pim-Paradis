component PokerSeat
{
    _inside = false;

    function GetSlot()
    {
        if (self.MapObject.Name == "Player1") {return 1;}
        if (self.MapObject.Name == "Player2") {return 2;}
        if (self.MapObject.Name == "Player3") {return 3;}
        if (self.MapObject.Name == "Player4") {return 4;}
        return 0;
    }

    function OnCollisionEnter(obj)
    {
        if (!self.IsLocalHuman(obj)) {return;}
        self._inside = true;
        slot = self.GetSlot();
        pokerObject = Map.FindMapObjectByComponent("TexasHoldEmPoker");
        if (slot <= 0 || pokerObject == null) {return;}
        poker = pokerObject.GetComponent("TexasHoldEmPoker");
        if (poker != null) {poker.NetworkView.SendMessage(Network.MasterClient, "Poker.Seat|" + slot);}
    }

    function OnCollisionStay(obj)
    {
        if (self.IsLocalHuman(obj))
        {
            self._inside = true;
            UI.SetLabelForTime(UILabelEnum.MiddleCenter, "Poker seat " + self.GetSlot(), 0.2);
        }
    }

    function OnCollisionExit(obj) {if (self.IsLocalHuman(obj)) {self._inside = false;}}

    function IsLocalHuman(obj)
    {
        return obj != null && obj.IsCharacter && obj.IsMine && obj.Type == "Human";
    }
}
