package com.rise.model;

public class CalendarItem {
	
	private String schooltimeInstId;
	
	private String dateValue;
	
	private CalendarShow calendarShow;
	
	private CalendarHidden calendarHidden;
	
	public String getSchooltimeInstId() {
		return schooltimeInstId;
	}

	public void setSchooltimeInstId(String schooltimeInstId) {
		this.schooltimeInstId = schooltimeInstId;
	}

	public String getDateValue() {
		return dateValue;
	}

	public void setDateValue(String dateValue) {
		this.dateValue = dateValue;
	}

	public CalendarShow getCalendarShow() {
		return calendarShow;
	}

	public void setCalendarShow(CalendarShow calendarShow) {
		this.calendarShow = calendarShow;
	}

	public CalendarHidden getCalendarHidden() {
		return calendarHidden;
	}

	public void setCalendarHidden(CalendarHidden calendarHidden) {
		this.calendarHidden = calendarHidden;
	}
	
}
