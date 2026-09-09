extension CmdsNetworking
{
    Lightning = Prefab("Scene,FX/Lightning1a,105,0,1,0,1,0,Lightning1a,179.4736,263.2018,-236.1912,0,0,0,1,1,1,None,Entities,Default,DefaultNoTint|255/255/255/255,", false);

    function OnNetworkMessage(sender, message, args)
    {
        rpc = args.Get(0);

        if (Network.IsMasterClient && rpc == "Admin.Request")
        {
            if (sender != Network.MasterClient && !ServerID._authorizedUsers.Contains(sender)) {return;}
            if (args.Count < 3) {return;}
            action = args.Get(1);
            targetID = Convert.ToInt(args.Get(2));
            target = Network.FindPlayer(targetID);

            if (action == "tpall")
            {
                if (sender.Character == null) {return;}
                for (player in Network.Players) {Game.SpawnPlayerAt(player, true, sender.Character.Position);}
                return;
            }
            if (action == "heli")
            {
                helicopter = Map.FindMapObjectByName("helicopter");
                if (helicopter == null) {Network.SendMessage(sender, "Economy.Notice|Helicopter not found."); return;}
                helicopter.Position += Vector3(0, 10, 0);
                return;
            }
            if (target == null) {Network.SendMessage(sender, "Economy.Notice|Player not found."); return;}

            if (action == "tp")
            {
                if (sender.Character != null) {Game.SpawnPlayerAt(target, true, sender.Character.Position);}
            }
            elif (action == "tpto")
            {
                if (target.Character != null) {Game.SpawnPlayerAt(sender, true, target.Character.Position);}
            }
            elif (action == "smite") {Network.SendMessage(target, "Admin.Smite");}
            elif (action == "fire") {Network.SendMessage(target, "Admin.Fire|1");}
            elif (action == "fireoff") {Network.SendMessage(target, "Admin.Fire|0");}
            elif (action == "nuke") {Network.SendMessage(target, "NukeME");}
            elif (action == "execute") {Network.SendMessage(target, "SendToTheGallows");}
            elif (action == "suck") {Network.SendMessageAll("SuckPlayer|" + targetID);}
            elif (action == "op" && sender == Network.MasterClient)
            {
                target.SetCustomProperty("IsOp", true);
                ServerID._authorizedUsers.Add(target);
                Network.SendMessage(target, "Admin.Commands");
                Game.PrintAll(target.Name + " is now an operator.");
            }
            elif (action == "deop" && sender == Network.MasterClient)
            {
                target.SetCustomProperty("IsOp", false);
                if (ServerID._authorizedUsers.Contains(target)) {ServerID._authorizedUsers.Remove(target);}
                Game.PrintAll(target.Name + " is no longer an operator.");
            }
            return;
        }

        if (sender != Network.MasterClient) {return;}
        if (rpc == "Admin.Commands")
        {
            Main.SetCommands();
        }
        elif (rpc == "Admin.Smite")
        {
            self.CreateThenDestroy();
        }
        elif (rpc == "Admin.Fire")
        {
            if (args.Count >= 2) {Main._fireDamage = Convert.ToInt(args.Get(1)) == 1;}
        }

        elif (rpc == "TP" || rpc == "Tpall")
        {
            if (sender.Character != null) {Game.SpawnPlayerAt(Network.MyPlayer, true, sender.Character.Position);}
        }
        elif (rpc == "Cmd") {Main.SetCommands();}
        elif (rpc == "Smited") {self.CreateThenDestroy();}
        elif (rpc == "fire") {Main._fireDamage = true;}
        elif (rpc == "fireoff") {Main._fireDamage = false;}
    }

    function CreateThenDestroy()
    {
        character = Network.MyPlayer.Character;
        if (character == null) {return;}
        position = character.Position;
        Game.SpawnEffect(EffectNameEnum.ThunderspearExplode, position, Vector3.Zero, 10, Color("#ffee00"));
        Game.SpawnEffect(EffectNameEnum.ShifterThunder, position, Vector3.Zero, 2);
        character.GetKilled("Pim Zap");
    }
}
