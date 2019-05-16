package com.plat.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtils {

    //获取当前时间  yyyy-MM-dd HH:mm:ss
    public Date getNowTime(){
        Date date = new Date();
        SimpleDateFormat sdt = new SimpleDateFormat(" yyyy-MM-dd HH:mm:ss ");
        String nowTime = sdt.format(date);
        try {
            Date time = sdt.parse(nowTime);
            return time;
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return null;
    }
}
