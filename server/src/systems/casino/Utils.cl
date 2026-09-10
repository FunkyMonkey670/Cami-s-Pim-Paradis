extension Utils 
{
    function RankingToNum(rank)
    {
        if (rank == RankingEnum.pair) {
            return 1;
        }
        elif (rank == RankingEnum.twoPair) {
            return 2;
        }
        elif (rank == RankingEnum.threeKind) {
            return 3;
        }
        elif (rank == RankingEnum.straight) {
            return 4;
        }
        elif (rank == RankingEnum.flush) {
            return 5;
        }
        elif (rank == RankingEnum.fullHouse) {
            return 6;
        }
        elif (rank == RankingEnum.fourKind) {
            return 7;
        }
        elif (rank == RankingEnum.straightFlush) {
            return 8;
        }
        elif (rank == RankingEnum.royalFlush) {
            return 9;
        }
        else
        {
            return 0;
        }
    }

    function StringTONum(string)
    {
        if (string == "A") { return 14; }
        if (string == "K") { return 13; }
        if (string == "Q") { return 12; }
        if (string == "J") { return 11; }
        return Convert.ToInt(string);
    }

    function NumToString(num)
    {
        if (num == 14) { return "A"; }
        if (num == 13) { return "K"; }
        if (num == 12) { return "Q"; }
        if (num == 11) { return "J"; }
        return num;
    }

    function SortAscending(a, b)
    {
        if (a < b) {return 1;}
        if (a > b) {return -1;}
        return 0;
    }
}

##chez ones
