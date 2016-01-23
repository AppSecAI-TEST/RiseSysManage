package com.rise.model;

import java.util.List;

public class CalendarItem {
	
	private String classInstId;
	
	private String dateValue;
	
	private CalendarShow calendarShow;
	
	private List<CalendarHidden> calendarHiddenList;
	
	public String getClassInstId() {
		return classInstId;
	}

	public void setClassInstId(String classInstId) {
		this.classInstId = classInstId;
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

	public List<CalendarHidden> getCalendarHiddenList() {
		return calendarHiddenList;
	}

	public void setCalendarHiddenList(List<CalendarHidden> calendarHiddenList) {
		this.calendarHiddenList = calendarHiddenList;
	}

}
