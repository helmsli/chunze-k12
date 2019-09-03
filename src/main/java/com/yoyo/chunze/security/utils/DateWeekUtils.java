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
	    return getWeekStartTime(Calendar.getInstance().getTime());
	}
	public static Date getWeekStartTime(Date dateTime) {
	    SimpleDateFormat simpleDateFormat = new SimpleDateFormat( "yyyyMMdd", Locale.getDefault());
	    Calendar cal = Calendar.getInstance();
	    cal.setTime(dateTime);
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
	 * 获取本周的指定周几的时间
	 * @param period ,1-7
	 * @return
	 */
	public static Date getWeekTime(Date dateTime,String period) throws Exception
	{
			int iPeriod = Integer.parseInt(period);
			if(iPeriod<1||iPeriod>7)
			{
				throw new Exception("period error"); 
			}
			iPeriod = iPeriod -1;
			Date beginTime = getWeekStartTime(dateTime);
			Calendar beginCal = Calendar.getInstance();
			beginCal.setTime(beginTime);
			beginCal.add(Calendar.DAY_OF_YEAR, iPeriod);
			return beginCal.getTime();
	}
	 
	/**
	* end
	* 本周结束时间戳 - 以星期一为本周的第一天
	*/
	public static Date getWeekEndTime(Date dateTime) {
	    SimpleDateFormat simpleDateFormat = new SimpleDateFormat( "yyyyMMdd", Locale. getDefault());
	    Calendar cal = Calendar.getInstance();
	    cal.setTime(dateTime);
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
	public static Date getWeekEndTime() {
	    return getWeekEndTime(Calendar.getInstance().getTime());
	}
	/**
	 * 获取本年度一月一号以来的周数
	 * @return
	 */
	public static int getWeekAmount() {
	    Calendar now = Calendar.getInstance();
	    return getWeekAmount(now.getTime());
	}
	
	public static int getWeekAmount(Date dateTime) {
	    Calendar now = Calendar.getInstance();
	    now.setTime(dateTime);
	    Calendar yearBegin = Calendar.getInstance();
	    yearBegin.setTime(now.getTime());
	    yearBegin.set(Calendar.DAY_OF_MONTH, 1);
	    yearBegin.set(Calendar.MONTH, 1);
	    int days = (int) ((now.getTimeInMillis() - yearBegin.getTimeInMillis()) / (1000*3600*24*7));
	    return (days+1);
	}
}
