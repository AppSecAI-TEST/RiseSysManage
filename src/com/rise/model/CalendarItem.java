package com.rise.model;

public class CalendarItem {
	
	private String classInstId;
	
	private String schooltimeInstId;

	private String classAttendId;
	
	private String dateValue;
	
	private CalendarShow calendarShow;
	
	private CalendarHidden calendarHidden;
	
	public String getClassInstId() {
		return classInstId;
	}

	public void setClassInstId(String classInstId) {
		this.classInstId = classInstId;
	}

	public String getSchooltimeInstId() {
		return schooltimeInstId;
	}

	public void setSchooltimeInstId(String schooltimeInstId) {
		this.schooltimeInstId = schooltimeInstId;
	}

	public String getClassAttendId() {
		return classAttendId;
	}

	public void setClassAttendId(String classAttendId) {
		this.classAttendId = classAttendId;
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
