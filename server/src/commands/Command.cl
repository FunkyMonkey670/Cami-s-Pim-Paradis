extension Command
{
    function Request(action, args, usage)
    {
        if (args.Count < 1) {Game.Print(usage); return;}
        Network.SendMessage(Network.MasterClient, "Admin.Request|" + action + "|" + Convert.ToInt(args.Get(0)));
    }

    function FireOffCMD(cmd, args) {self.Request("fireoff", args, "Usage: /fireoff [playerID]");}
    function FireCMD(cmd, args) {self.Request("fire", args, "Usage: /fire [playerID]");}
    function SmiteCMD(cmd, args) {self.Request("smite", args, "Usage: /smite [playerID]");}
    function TptoCMD(cmd, args) {self.Request("tpto", args, "Usage: /tpto [playerID]");}
    function tpCMD(cmd, args) {self.Request("tp", args, "Usage: /tp [playerID]");}

    function tpallCMD(cmd, args)
    {
        Network.SendMessage(Network.MasterClient, "Admin.Request|tpall|-1");
    }

    function deopCMD(cmd, args)
    {
        self.Request("deop", args, "Usage: /deop [playerID]");
    }

    function opCMD(cmd, args)
    {
        self.Request("op", args, "Usage: /op [playerID]");
    }
}
