
-- 太阳升起，落下时间,春夏秋冬，四季不同
   	calendar = {
        year = 0;
        season = 0;
-- //        month = 0;
        day = 0;
        hour = 0;
        minute = 0;
        second = 0;
    }
    function initCalendar(int year, int season, int day, int hour, int minute, int second)
        this.year = year;
        this.season = season;
        this.day = day;
        this.hour = hour;
        this.minute = minute;
        this.second = second;
    end

    function getTurn() {
        int ret = second / 6;
        ret += minute * 10;
        ret += hour * 600;
        ret += day * 14400;
//        ret += month * 14400 * 30;
        ret += season * 14400 * 30;
        ret += year * 14400 * 4 * 30;
        return ret;
    }
    public void updata(int turn)
    {
        int minute_param = turn / 10;
        int hour_param = minute_param / 60;
        int day_param = hour_param / 24;
        int season_param = day_param / 30;
        second = 6 * (turn % 10);
        minute = minute_param % 60;
        hour = hour_param % 24;
        day = day_param % 30;
        season = season_param % 4;
        year = season_param / 4;
    }

    public void opratorAdd(int turn){
        int newTurn = getTurn()+turn;
        updata(newTurn);
    }

    public void  opratorSub(int turn){
        int newTurn = getTurn()-turn;
        updata(newTurn);
    }

    public String  printCalenar(){
        String snew = String.format(Vocab.CALENDAR,year(),Vocab.SEASONS[season],day,Vocab.HOURS[hour/2],weekday());
//        Gdx.app.debug("",snew);
        return snew;
    }

    function moon()
       	local moon="";
        local moon = Vocab.MOONS[day/6];
        return moon;
    end
    public String sun(){
        String sun;
        sun = Vocab.SUNS[1];
        return sun;
    }

    public String weekday(){
        String weekday;
        weekday = Vocab.WEEKDAYS[day%7];
        return weekday;
    }

    public String year(){
        String yearStr;
        yearStr = Vocab.YEARS[year%12];
        return yearStr;
    }

}
