package com.rise.model;

import java.util.List;

public class CalendarItem {
	
	private String classInstId;
	
	private String dateValue;
	
	private CalendarShow calendarShow;
	
	private List<CalendarHidden> calendarHiddenPlanList;
	
	private List<CalendarHidden> calendarHiddenRealList;
	
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

	public List<CalendarHidden> getCalendarHiddenPlanList() {
		return calendarHiddenPlanList;
	}

	public void setCalendarHiddenPlanList(
			List<CalendarHidden> calendarHiddenPlanList) {
		this.calendarHiddenPlanList = calendarHiddenPlanList;
	}

	public List<CalendarHidden> getCalendarHiddenRealList() {
		return calendarHiddenRealList;
	}

	public void setCalendarHiddenRealList(
			List<CalendarHidden> calendarHiddenRealList) {
		this.calendarHiddenRealList = calendarHiddenRealList;
	}

}
