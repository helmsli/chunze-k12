package com.yoyo.chunze.domain;

import java.util.Date;

public class WeekTaskDetail extends TaskDetail {
	private Date startWeekDate;
	private Date endWeekDate;
	public Date getStartWeekDate() {
		return startWeekDate;
	}
	public void setStartWeekDate(Date startWeekDate) {
		this.startWeekDate = startWeekDate;
	}
	public Date getEndWeekDate() {
		return endWeekDate;
	}
	public void setEndWeekDate(Date endWeekDate) {
		this.endWeekDate = endWeekDate;
	}
	
}
