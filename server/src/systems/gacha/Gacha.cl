component Gacha
{
    PullCost = 15;
    RequestCooldown = 0.75;

    _items = Dict();
    _rarityPools = Dict();
    _sprites = Dict();
    _pullsCount = 0;
    _commonRarity = 1;
    _uncommonRarity = 2;
    _rareRarity = 3;
    _srRarity = 4;
    _ssrRarity = 5;
    _urRarity = 6;
    _grapeRarity = 7;

    _commonChance = 10000;
    _uncommonChance = 4000;
    _rareChance = 1800;
    _srChance = 600;
    _ssrChance = 55;
    _urChance = 40;
    _grapeChance = 25;

    BgColor = "#929191f2";
    BorderColor = "#020000";
    _common = "#b4b4b4";
    _unCommon = "#00a4f0";
    _rare = "#ffffff";
    _sr = "#c100fc";
    _ssr = "#ff5101";
    _ur = "#ff1504";
    _grapeRare = "#e100ff";

    _hasInsert = false;
    _enabled = false;
    _nearUntil = 0.0;
    _requestPending = false;
    _root = null;
    _mainContainer = null;
    _coinsLabel = null;
    _pullsLabel = null;
    _statusLabel = null;
    _dialStateLabel = null;
    _lastRequests = Dict();

    function OnGameStart()
    {
        self.InitItems();
        self.BuildRarityPools();
        self.BuildSpriteIndex();
        self.BuildUI();
        self.Hide();
        Interface.Gacha = self;
    }

    function IsLocalHuman(obj)
    {
        return obj != null && obj.IsCharacter && obj.IsMine && obj.Type == "Human";
    }

    function OnCollisionStay(obj)
    {
        if (!self.IsLocalHuman(obj)) {return;}
        self._nearUntil = Time.GameTime + 0.25;
        if (!self._enabled) {UI.SetLabelForTime(UILabelEnum.MiddleCenter, "Press " + Input.GetKeyName(InputInteractionEnum.Function1) + " to open gacha.", 0.2);}
    }

    function OnCollisionExit(obj)
    {
        if (self.IsLocalHuman(obj) && self._enabled) {Interface.CloseWindow();}
    }

    function OnCharacterDie(victim, killer, killerName)
    {
        if (victim != null && victim.IsMine && self._enabled) {Interface.CloseWindow();}
    }

    function OnPlayerLeave(player)
    {
        if (Network.IsMasterClient && player != null) {self._lastRequests.Remove(player.ID);}
    }

    function OnFrame()
    {
        if (Time.GameTime <= self._nearUntil && Input.GetKeyDown(InputInteractionEnum.Function1))
        {
            if (self._enabled) {Interface.CloseWindow();}
            else {Interface.OpenWindow(self);}
        }
        if (self._enabled && Input.GetKeyDown(InputGeneralEnum.Pause)) {Interface.CloseWindow();}
    }

    function BuildUI()
    {
        if (self._mainContainer != null) {return;}
        self._root = UI.GetRootVisualElement();
        self._mainContainer = UI.VisualElement()
            .Absolute(true).Width(520, false).Height(660, false)
            .AlignSelf(AlignEnum.Center).Padding(26, false)
            .BackgroundColor(Color(self.BgColor)).BorderColor(Color(self.BorderColor))
            .BorderWidth(6).BorderRadius(18).FlexDirection(FlexDirectionEnum.Column);
        self._root.Add(self._mainContainer);

        header = UI.VisualElement().Height(165, false).Padding(12, false)
            .BackgroundColor(Color("#d1cdcde8")).BorderColor(Color("#161616"))
            .BorderWidth(3).BorderRadius(12).FlexDirection(FlexDirectionEnum.Column);
        self._mainContainer.Add(header);
        header.Add(UI.Label("GACHA MACHINE").Height(62, false).FontSize(32).FontStyle(FontStyleEnum.Bold).TextAlign(TextAlignEnum.MiddleCenter).Color(Color("#151515")));
        self._coinsLabel = UI.Label("Wallet: 0 CC").Height(36, false).FontSize(20).FontStyle(FontStyleEnum.Bold).TextAlign(TextAlignEnum.MiddleCenter).Color(Color("#202020"));
        self._pullsLabel = UI.Label("Pulls this session: 0").Height(32, false).FontSize(17).TextAlign(TextAlignEnum.MiddleCenter).Color(Color("#303030"));
        header.Add(self._coinsLabel);
        header.Add(self._pullsLabel);

        self._statusLabel = UI.Label("Insert, then collect.").Height(82, false).FontSize(18).TextWrap(true).TextAlign(TextAlignEnum.MiddleCenter);
        self._statusLabel.EnableRichText = true;
        self._mainContainer.Add(self._statusLabel);

        controls = UI.VisualElement().Height(315, false).FlexDirection(FlexDirectionEnum.Row)
            .JustifyContent(JustifyEnum.Center).AlignItems(AlignEnum.Center);
        self._mainContainer.Add(controls);

        insertColumn = UI.VisualElement().Width(220, false).Height(290, false)
            .FlexDirection(FlexDirectionEnum.Column).AlignItems(AlignEnum.Center);
        insertColumn.Add(UI.Label("INSERT " + self.PullCost + " CC").Height(48, false).FontSize(20).FontStyle(FontStyleEnum.Bold).TextAlign(TextAlignEnum.MiddleCenter));
        insertDial = UI.Button("", self.Insert).Width(170, false).Height(170, false)
            .BorderRadius(85).BorderWidth(5).BorderColor(Color("#001f66"))
            .BackgroundColor(Color("#0051ff"));
        turner = UI.VisualElement().Width(105, false).Height(28, false)
            .AlignSelf(AlignEnum.Center).MarginTop(63, false)
            .BackgroundColor(Color("#101010")).BorderColor(Color("#cecece"))
            .BorderWidth(3).BorderRadius(8);
        insertDial.Add(turner);
        insertColumn.Add(insertDial);
        self._dialStateLabel = UI.Label("EMPTY").Height(42, false).FontSize(17)
            .FontStyle(FontStyleEnum.Bold).TextAlign(TextAlignEnum.MiddleCenter).Color(Color("#252525"));
        insertColumn.Add(self._dialStateLabel);

        collectColumn = UI.VisualElement().Width(220, false).Height(290, false)
            .FlexDirection(FlexDirectionEnum.Column).AlignItems(AlignEnum.Center);
        collectColumn.Add(UI.Label("PRIZE CHUTE").Height(48, false).FontSize(20).FontStyle(FontStyleEnum.Bold).TextAlign(TextAlignEnum.MiddleCenter));
        collect = UI.Button("COLLECT", self.Pull).Width(170, false).Height(170, false)
            .FontSize(23).FontStyle(FontStyleEnum.Bold).BorderRadius(22)
            .BorderWidth(5).BorderColor(Color("#6d5200")).BackgroundColor(Color("#ffc400"));
        collectColumn.Add(collect);
        collectColumn.Add(UI.Label("CLAIM CARD").Height(42, false).FontSize(17).FontStyle(FontStyleEnum.Bold).TextAlign(TextAlignEnum.MiddleCenter).Color(Color("#252525")));

        controls.Add(insertColumn);
        controls.Add(collectColumn);
    }

    function SetEnabled(enabled)
    {
        if (enabled) {self.Show();}
        else {self.Hide();}
    }

    function Show()
    {
        self.BuildUI();
        self._enabled = true;
        self._mainContainer.Active(true);
        self.UpdateUI("Insert, then collect.");
        self.DisableInputs();
    }

    function Hide()
    {
        self._enabled = false;
        if (self._mainContainer != null) {self._mainContainer.Active(false);}
        self.EnableInputs();
    }

    function DisableInputs()
    {
        Camera.SetCameraLocked(true);
        Camera.SetCursorVisible(true);
        UI.SetBottomHUDActive(false);
        UI.ForceHideNames = true;
        Input.SetHumanKeysEnabled(false);
    }

    function EnableInputs()
    {
        Camera.SetCameraLocked(false);
        Camera.SetCursorVisible(false);
        UI.SetBottomHUDActive(true);
        UI.ForceHideNames = false;
        Input.SetHumanKeysEnabled(true);
    }

    function UpdateUI(status)
    {
        if (self._coinsLabel != null) {self._coinsLabel.Text = "Wallet: " + Main.Coins + " CC";}
        if (self._pullsLabel != null) {self._pullsLabel.Text = "Pulls this session: " + self._pullsCount;}
        if (self._statusLabel != null && status != null) {self._statusLabel.Text = status;}
        if (self._dialStateLabel != null)
        {
            if (self._requestPending) {self._dialStateLabel.Text = "ROLLING";}
            elif (self._hasInsert) {self._dialStateLabel.Text = "READY";}
            else {self._dialStateLabel.Text = "EMPTY";}
        }
    }

    function Insert()
    {
        if (self._requestPending) {return;}
        if (self._hasInsert) {self.UpdateUI("Coins are already inserted. Collect your pull."); return;}
        if (Main.Coins < self.PullCost) {self.UpdateUI("Not enough coins."); return;}
        self._hasInsert = true;
        self.UpdateUI("Ready to pull for " + self.PullCost + " CC.");
    }

    function PullCmd() {self.Pull();}

    function Pull()
    {
        if (self._requestPending) {return;}
        if (!self._hasInsert) {self.UpdateUI("Insert coins before collecting."); return;}
        self._requestPending = true;
        self.UpdateUI("Rolling...");
        self.NetworkView.SendMessage(Network.MasterClient, "Gacha.Pull");
    }

    function OnNetworkMessage(sender, message)
    {
        args = String.Split(message, "|", false);
        if (args.Count == 0) {return;}
        rpc = args.Get(0);
        if (sender == Network.MasterClient && rpc == "Gacha.Result" && args.Count >= 2)
        {
            self._requestPending = false;
            self._hasInsert = false;
            item = self._items.Get(args.Get(1));
            if (item == null) {self.UpdateUI("The server returned an unknown card."); return;}
            self._pullsCount += 1;
            if (Interface.MainInventory != null) {Interface.MainInventory.AddItem(item);}
            rarity = self.GetStringRarity(item.GetRarity());
            color = self.GetItemColor(item.GetRarity());
            self.UpdateUI("Pulled <color=" + color + ">" + item.GetName() + "</color> (" + rarity + ").");
            character = Network.MyPlayer.Character;
            if (character != null)
            {
                character.PlaySound(HumanSoundEnum.HookImpactLoud);
                if (item.GetRarity() >= self._ssrRarity)
                {
                    character.PlaySound(HumanSoundEnum.ThunderspearLaunch);
                    Game.SpawnEffect(EffectNameEnum.ThunderspearExplode, character.Position, Vector3.Zero, 10.0, Color("#eeff00"), TSKillSoundEnum.MaxRangeShot);
                }
            }
            return;
        }
        if (sender == Network.MasterClient && rpc == "Gacha.Error" && args.Count >= 2)
        {
            self._requestPending = false;
            self._hasInsert = false;
            self.UpdateUI(args.Get(1));
            return;
        }

        if (!Network.IsMasterClient || sender == null || rpc != "Gacha.Pull") {return;}
        last = Convert.ToFloat(self._lastRequests.Get(sender.ID, -100.0));
        if (Time.GameTime - last < self.RequestCooldown) {self.SendError(sender, "Please wait before pulling again."); return;}
        self._lastRequests.Set(sender.ID, Time.GameTime);
        senderServerID = ServerID._playerServerIDs.Get(sender.ID);
        if (senderServerID == null) {self.SendError(sender, "Player data is not ready yet."); return;}
        if (!MoneyData.TrySpend(sender, senderServerID, self.PullCost)) {self.SendError(sender, "Not enough coins."); return;}
        item = self.Roll();
        if (item == null)
        {
            MoneyData.Credit(sender, senderServerID, self.PullCost);
            self.SendError(sender, "No gacha item was available; your coins were refunded.");
            return;
        }
        if (!GachaData.SaveItem(item.GetName(), senderServerID))
        {
            MoneyData.Credit(sender, senderServerID, self.PullCost);
            MoneyData.Flush();
            self.SendError(sender, "Duplicate card; your coins were refunded.");
            return;
        }
        MoneyData.Flush();
        GachaData.Flush();
        self.NetworkView.SendMessage(sender, "Gacha.Result|" + item.GetName());
        if (item.GetRarity() >= self._ssrRarity)
        {
            Game.PrintAll(String.Replace(sender.Name, "|", "/") + " pulled <color=" + self.GetItemColor(item.GetRarity()) + ">" + item.GetName() + "</color> (" + self.GetStringRarity(item.GetRarity()) + ")!");
        }
    }

    function SendError(player, message)
    {
        if (player != null) {self.NetworkView.SendMessage(player, "Gacha.Error|" + message);}
    }

    function Roll()
    {
        total = self._commonChance + self._uncommonChance + self._rareChance + self._srChance + self._ssrChance + self._urChance + self._grapeChance;
        roll = Random.RandomInt(1, total + 1);
        threshold = self._grapeChance;
        if (roll <= threshold) {return self.GetItem(self._grapeRarity);}
        threshold += self._urChance;
        if (roll <= threshold) {return self.GetItem(self._urRarity);}
        threshold += self._ssrChance;
        if (roll <= threshold) {return self.GetItem(self._ssrRarity);}
        threshold += self._srChance;
        if (roll <= threshold) {return self.GetItem(self._srRarity);}
        threshold += self._rareChance;
        if (roll <= threshold) {return self.GetItem(self._rareRarity);}
        threshold += self._uncommonChance;
        if (roll <= threshold) {return self.GetItem(self._uncommonRarity);}
        return self.GetItem(self._commonRarity);
    }

    function RegisterItem(name, rarity, description, edition)
    {
        self._items.Set(name, GachaItem(name, rarity, description, edition));
    }

    function InitItems()
    {
        if (self._items.Count > 0) {return;}
        self.RegisterItem("Decim", self._commonRarity, DescriptionsEnum.Decim, 1);
        self.RegisterItem("Victorique de Blois", self._commonRarity, DescriptionsEnum.VictoriquedeBlois, 1);
        self.RegisterItem("Morgiana", self._commonRarity, DescriptionsEnum.Morgiana, 1);
        self.RegisterItem("Umaru Doma", self._commonRarity, DescriptionsEnum.UmaruDoma, 1);
        self.RegisterItem("Happy", self._commonRarity, DescriptionsEnum.Happy, 1);
        self.RegisterItem("Koutarou Tatsumi", self._commonRarity, DescriptionsEnum.KoutarouTatsumi, 1);
        self.RegisterItem("Sakaki", self._commonRarity, DescriptionsEnum.Sakaki, 1);
        self.RegisterItem("Chihiro Ogino", self._commonRarity, DescriptionsEnum.ChihiroOgino, 1);
        self.RegisterItem("Uryuu Ishida", self._commonRarity, DescriptionsEnum.UryuuIshida, 1);
        self.RegisterItem("Satori Tendou", self._commonRarity, DescriptionsEnum.SatoriTendou, 1);
        self.RegisterItem("YangWen-li", self._commonRarity, DescriptionsEnum.YangWenli, 1);
        self.RegisterItem("Ippo Makunouchi", self._commonRarity, DescriptionsEnum.IppoMakunouchi, 1);
        self.RegisterItem("Erina Nakiri", self._uncommonRarity, DescriptionsEnum.ErinaNakiri, 1);
        self.RegisterItem("Winry Rockbell", self._uncommonRarity, DescriptionsEnum.WinryRockbell, 1);
        self.RegisterItem("Nate River", self._uncommonRarity, DescriptionsEnum.NateRiver, 1);
        self.RegisterItem("Nausicaa", self._uncommonRarity, DescriptionsEnum.Nausicaa, 1);
        self.RegisterItem("Sakamoto", self._uncommonRarity, DescriptionsEnum.Sakamoto, 1);
        self.RegisterItem("Akaza", self._uncommonRarity, DescriptionsEnum.Akaza, 1);
        self.RegisterItem("Haku", self._uncommonRarity, DescriptionsEnum.Haku, 1);
        self.RegisterItem("Ymir", self._uncommonRarity, DescriptionsEnum.Ymir, 1);
        self.RegisterItem("Pieck Finger", self._uncommonRarity, DescriptionsEnum.PieckFinger, 1);
        self.RegisterItem("Chinatsu Kano", self._uncommonRarity, DescriptionsEnum.ChinatsuKano, 1);
        self.RegisterItem("Jean Pierre Polnareff", self._rareRarity, DescriptionsEnum.JeanPierrePolnareff, 1);
        self.RegisterItem("Migi", self._rareRarity, DescriptionsEnum.Migi, 1);
        self.RegisterItem("Neferpitou", self._rareRarity, DescriptionsEnum.Neferpitou, 1);
        self.RegisterItem("Hancock Boa", self._rareRarity, DescriptionsEnum.HancockBoa, 1);
        self.RegisterItem("Jean Kirstein", self._rareRarity, DescriptionsEnum.JeanKirstein, 1);
        self.RegisterItem("Franky", self._rareRarity, DescriptionsEnum.Franky, 1);
        self.RegisterItem("Hatsune Miku", self._rareRarity, DescriptionsEnum.HatsuneMiku, 1);
        self.RegisterItem("Jonathan Joestar", self._rareRarity, DescriptionsEnum.JonathanJoestar, 1);
        self.RegisterItem("Totoro", self._rareRarity, DescriptionsEnum.Totoro, 1);
        self.RegisterItem("Pochita", self._srRarity, DescriptionsEnum.Pochita, 1);
        self.RegisterItem("Chii", self._srRarity, DescriptionsEnum.Chii, 1);
        self.RegisterItem("Kyoujurou Rengoku", self._srRarity, DescriptionsEnum.KyoujurouRengoku, 1);
        self.RegisterItem("Nezuko Kamado", self._srRarity, DescriptionsEnum.NezukoKamado, 1);
        self.RegisterItem("Lucy", self._srRarity, DescriptionsEnum.Lucy, 1);
        self.RegisterItem("Howl", self._srRarity, DescriptionsEnum.Howl, 1);
        self.RegisterItem("Ryuk", self._srRarity, DescriptionsEnum.Ryuk, 1);
        self.RegisterItem("Reze", self._srRarity, DescriptionsEnum.Reze, 1);
        self.RegisterItem("lucy", self._srRarity, DescriptionsEnum.lucy, 1);
        self.RegisterItem("Mei Misaki", self._srRarity, DescriptionsEnum.MeiMisaki, 1);
        self.RegisterItem("Future Trunks", self._ssrRarity, DescriptionsEnum.FutureTrunks, 1);
        self.RegisterItem("Sanji", self._ssrRarity, DescriptionsEnum.Sanji, 1);
        self.RegisterItem("Saitama", self._ssrRarity, DescriptionsEnum.Saitama, 1);
        self.RegisterItem("L Lawliet", self._ssrRarity, DescriptionsEnum.LLawliet, 1);
        self.RegisterItem("Frieren", self._ssrRarity, DescriptionsEnum.Frieren, 1);
        self.RegisterItem("Erwin Smith", self._ssrRarity, DescriptionsEnum.ErwinSmith, 1);
        self.RegisterItem("Tanjirou Kamado", self._ssrRarity, DescriptionsEnum.TanjirouKamado, 1);
        self.RegisterItem("Kusuo Saiki", self._ssrRarity, DescriptionsEnum.KusuoSaiki, 1);
        self.RegisterItem("Armin Arlert", self._ssrRarity, DescriptionsEnum.ArminArlert, 1);
        self.RegisterItem("Chopper Tony Tony", self._ssrRarity, DescriptionsEnum.ChopperTonyTony, 1);
        self.RegisterItem("David Martinez", self._urRarity, DescriptionsEnum.DavidMartinez, 1);
        self.RegisterItem("Levi Ackermann", self._urRarity, DescriptionsEnum.Levi, 1);
        self.RegisterItem("Light Yagami", self._urRarity, DescriptionsEnum.LightYagami, 1);
        self.RegisterItem("Zoro Roronoa", self._urRarity, DescriptionsEnum.ZoroRoronoa, 1);
        self.RegisterItem("Naruto Uzumaki", self._urRarity, DescriptionsEnum.NarutoUzumaki, 1);
        self.RegisterItem("Eren Yeager", self._urRarity, DescriptionsEnum.ErenYeager, 1);
        self.RegisterItem("Satoru Gojou", self._urRarity, DescriptionsEnum.SatoruGojou, 1);
        self.RegisterItem("Mikasa Ackermann", self._urRarity, DescriptionsEnum.MikasaAckerman, 1);
        self.RegisterItem("Gokuu Son", self._urRarity, DescriptionsEnum.GokuuSon, 1);
        self.RegisterItem("QUEEN GRAPE", self._grapeRarity, DescriptionsEnum.Grape, 1);
    }

    function BuildRarityPools()
    {
        self._rarityPools.Clear();
        for (rarity in Range(1, 8, 1)) {self._rarityPools.Set(rarity, List());}
        for (item in self._items.Values) {self._rarityPools.Get(item.GetRarity()).Add(item);}
    }

    function GetItem(rarity)
    {
        pool = self._rarityPools.Get(rarity, List());
        if (pool.Count == 0) {pool = self._rarityPools.Get(self._commonRarity, List());}
        if (pool.Count == 0) {return null;}
        return pool.Get(Random.RandomInt(0, pool.Count));
    }

    function BuildSpriteIndex()
    {
        self._sprites.Clear();
        if (Sprites._list.Count == 0) {Sprites.Init();}
        for (entry in Sprites._list)
        {
            split = String.Split(entry, "|", false);
            if (split.Count >= 2) {self._sprites.Set(split.Get(0), split.Get(1));}
        }
    }

    function GetSprite(name) {return self._sprites.Get(name, "");}

    function GetItemColor(rarity)
    {
        if (rarity == self._commonRarity) {return self._common;}
        if (rarity == self._uncommonRarity) {return self._unCommon;}
        if (rarity == self._rareRarity) {return self._rare;}
        if (rarity == self._srRarity) {return self._sr;}
        if (rarity == self._ssrRarity) {return self._ssr;}
        if (rarity == self._urRarity) {return self._ur;}
        if (rarity == self._grapeRarity) {return self._grapeRare;}
        return "#ffffff";
    }

    function GetStringRarity(rarity)
    {
        if (rarity == self._commonRarity) {return "Common";}
        if (rarity == self._uncommonRarity) {return "Uncommon";}
        if (rarity == self._rareRarity) {return "Rare";}
        if (rarity == self._srRarity) {return "SR";}
        if (rarity == self._ssrRarity) {return "SSR";}
        if (rarity == self._urRarity) {return "UR";}
        if (rarity == self._grapeRarity) {return "GRAPE";}
        return "Unknown";
    }

    function GetStringEdition(edition)
    {
        if (edition == 1) {return "First Edition";}
        return "Edition " + edition;
    }
}
