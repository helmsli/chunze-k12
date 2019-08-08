package com.yoyo.chunze.security.utils;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Locale;

public class DateWeekUtils {
	/**
	* start
	* 本周开始时间戳 - 以星期一为本周的第一天
	*/
	public static Date getWeekStartTime() {
	    SimpleDateFormat simpleDateFormat = new SimpleDateFormat( "yyyyMMdd", Locale.getDefault());
	    Calendar cal = Calendar.getInstance();
	    int day_of_week = cal.get(Calendar. DAY_OF_WEEK) - 1;
	    if (day_of_week == 0 ) {
	        day_of_week = 7 ;
	    }
	    cal.add(Calendar.DATE , -day_of_week + 1 );
	    cal.set(Calendar.HOUR_OF_DAY, 0);
	    cal.set(Calendar.MINUTE, 0);
	    cal.set(Calendar.SECOND, 0);
	    cal.set(Calendar.MILLISECOND, 0);
	    return cal.getTime();
	}
	 
	/**
	* end
	* 本周结束时间戳 - 以星期一为本周的第一天
	*/
	public static Date getWeekEndTime() {
	    SimpleDateFormat simpleDateFormat = new SimpleDateFormat( "yyyyMMdd", Locale. getDefault());
	    Calendar cal = Calendar.getInstance();
	    int day_of_week = cal.get(Calendar. DAY_OF_WEEK) - 1;
	    if (day_of_week == 0 ) {
	        day_of_week = 7 ;
	    }
	    cal.add(Calendar.DATE , -day_of_week + 7 );
	    cal.add(Calendar.DATE , -day_of_week + 1 );
	    cal.set(Calendar.HOUR_OF_DAY, 0);
	    cal.set(Calendar.MINUTE, 0);
	    cal.set(Calendar.SECOND, 0);
	    cal.set(Calendar.MILLISECOND, 0);
	    return cal.getTime();

	}
}
