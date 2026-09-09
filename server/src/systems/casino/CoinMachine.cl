component CoinMachine
{
    Reward = 100;
    ExtractionDelay = 6.0;
    InteractionDistance = 12.0;

    _isActive = false;
    _isColliding = false;
    _inserted = false;
    _pending = false;
    _root = null;
    _container = null;
    _statusLabel = null;
    _collectButton = null;

    _serverTokens = Dict();
    _lastRequests = Dict();

    function OnGameStart()
    {
        self.BuildUI();
        self.Hide();
    }

    function OnCollisionEnter(obj)
    {
        if (self.IsLocalHuman(obj)) {self._isColliding = true; self.Show();}
    }

    function OnCollisionStay(obj)
    {
        if (self.IsLocalHuman(obj)) {self._isColliding = true;}
    }

    function OnCollisionExit(obj)
    {
        if (self.IsLocalHuman(obj)) {self._isColliding = false; if (!self._pending) {self.Hide();}}
    }

    function IsLocalHuman(obj)
    {
        return obj != null && obj.IsCharacter && obj.IsMine && obj.Type == "Human";
    }

    function OnCharacterDie(victim, killer, killerName)
    {
        if (victim != null && victim.Type == "Human" && victim.IsMainCharacter) {self._pending = false; self.Hide();}
    }

    function OnPlayerLeave(player)
    {
        if (!Network.IsMasterClient || player == null) {return;}
        self._serverTokens.Remove(player.ID);
        self._lastRequests.Remove(player.ID);
    }

    function BuildUI()
    {
        self._root = UI.GetRootVisualElement();
        self._container = UI.VisualElement()
            .Absolute(true)
            .Width(500, false)
            .Height(360, false)
            .AlignSelf(AlignEnum.Center)
            .Padding(24, false)
            .BackgroundColor(Color("#151515f2"))
            .BorderColor(Color("#dedede"))
            .BorderWidth(4)
            .BorderRadius(16)
            .FlexDirection(FlexDirectionEnum.Column)
            .JustifyContent(JustifyEnum.SpaceBetween);
        self._root.Add(self._container);

        title = UI.Label("SOUL EXCHANGE")
            .Height(55, false).FontSize(30).FontStyle(FontStyleEnum.Bold)
            .TextAlign(TextAlignEnum.MiddleCenter).Color(Color("#ff5f5f"));
        self._container.Add(title);
        description = UI.Label("Exchange one life for " + self.Reward + " CC." + String.Newline + "Extraction completes after " + self.ExtractionDelay + " seconds.")
            .Height(90, false).FontSize(18).TextWrap(true).TextAlign(TextAlignEnum.MiddleCenter);
        self._container.Add(description);
        self._statusLabel = UI.Label("Insert your soul, then collect.")
            .Height(55, false).FontSize(18).TextAlign(TextAlignEnum.MiddleCenter);
        self._container.Add(self._statusLabel);
        actions = UI.VisualElement().Height(65, false).FlexDirection(FlexDirectionEnum.Row).JustifyContent(JustifyEnum.Center);
        self._container.Add(actions);
        actions.Add(UI.Button("Insert soul", self.InsertCoin).Width(180, false).BackgroundColor(Color("#9b2c2c")));
        self._collectButton = UI.Button("Collect", self.Collectcoins).Width(180, false).BackgroundColor(Color("#3a3a3a"));
        actions.Add(self._collectButton);
    }

    function InsertCoin()
    {
        if (self._pending) {return;}
        if (self._inserted)
        {
            Game.Print("<color=#ffcf70>A soul is already inserted. Press Collect to begin extraction.</color>");
            return;
        }
        self._inserted = true;
        self._statusLabel.Text = "Soul inserted. Collection is irreversible.";
        Game.Print("<color=#ff7777>Soul inserted.</color> Press <color=#7ee8ff>Collect</color> to exchange your life.");
    }

    function Collectcoins()
    {
        if (self._pending) {return;}
        if (!self._inserted) {Game.Print("Insert a soul first."); return;}
        self._pending = true;
        self._collectButton.Active(false);
        self._statusLabel.Text = "Requesting extraction...";
        self.NetworkView.SendMessage(Network.MasterClient, "CoinMachine.Extract");
    }

    function OnNetworkMessage(sender, message)
    {
        args = String.Split(message, "|", false);
        if (args.Count == 0) {return;}
        rpc = args.Get(0);
        if (sender == Network.MasterClient)
        {
            if (rpc == "CoinMachine.Start" && args.Count >= 2)
            {
                self._statusLabel.Text = "Extraction in progress: " + args.Get(1) + " seconds.";
                Game.Print("<color=#ffb45f>Soul extraction started.</color> Remain beside the machine for " + args.Get(1) + " seconds.");
                return;
            }
            if (rpc == "CoinMachine.Result" && args.Count >= 2)
            {
                self._pending = false;
                self._inserted = false;
                self._collectButton.Active(true);
                self._statusLabel.Text = args.Get(1);
                Game.Print(args.Get(1));
                return;
            }
        }

        if (!Network.IsMasterClient || rpc != "CoinMachine.Extract") {return;}
        self.BeginExtraction(sender);
    }

    function BeginExtraction(player)
    {
        if (!self.IsEligible(player)) {self.SendResult(player, "Move closer to the machine while alive."); return;}
        last = Convert.ToFloat(self._lastRequests.Get(player.ID, -100.0));
        if (Time.GameTime - last < 1.0) {self.SendResult(player, "Extraction request is cooling down."); return;}
        self._lastRequests.Set(player.ID, Time.GameTime);
        token = Convert.ToInt(self._serverTokens.Get(player.ID, 0)) + 1;
        self._serverTokens.Set(player.ID, token);
        self.NetworkView.SendMessage(player, "CoinMachine.Start|" + self.ExtractionDelay);
        self.CompleteExtraction(player.ID, token);
    }

    coroutine CompleteExtraction(playerID, token)
    {
        wait self.ExtractionDelay;
        if (self._serverTokens.Get(playerID, -1) != token) {return;}
        player = Network.FindPlayer(playerID);
        if (!self.IsEligible(player)) {self.SendResult(player, "Extraction cancelled because you left the machine."); return;}
        serverID = ServerID._playerServerIDs.Get(playerID);
        if (serverID == null) {self.SendResult(player, "Your economy data is not ready yet."); return;}
        player.Character.GetKilled("<b><color=#ff4b4b>SOUL EXTRACTED</color></b>");
        MoneyData.CreditWallet(player, serverID, self.Reward);
        MoneyData.Flush();
        self.SendResult(player, "Soul extracted — <color=#66e38f>+" + self.Reward + " CC</color>.");
    }

    function IsEligible(player)
    {
        return player != null && player.Connected && player.Character != null && player.Character.Type == "Human" &&
            Vector3.Distance(player.Character.Position, self.MapObject.Position) <= self.InteractionDistance;
    }

    function SendResult(player, text)
    {
        if (player != null) {self.NetworkView.SendMessage(player, "CoinMachine.Result|" + text);}
    }

    function Show()
    {
        if (self._container == null) {return;}
        self._isActive = true;
        self._container.Active(true);
        self.DisableInputs();
    }

    function Hide()
    {
        self._isActive = false;
        if (self._container != null) {self._container.Active(false);}
        self.EnableInputs();
    }

    function DisableInputs()
    {
        Camera.SetCameraLocked(true);
        Camera.SetCursorVisible(true);
        Input.SetHumanKeysEnabled(false);
    }

    function EnableInputs()
    {
        Camera.SetCameraLocked(false);
        Camera.SetCursorVisible(false);
        Input.SetHumanKeysEnabled(true);
    }

    function CalculateLayout() {}
}
