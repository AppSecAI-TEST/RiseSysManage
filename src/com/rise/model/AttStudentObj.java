package com.rise.model;

import java.util.List;

public class AttStudentObj 
{
	private String studentId;
	private String name;
	private String byName;
	private String attendCount;
	private List<AttStuItem> attendDates;
	public String getStudentId() {
		return studentId;
	}
	public void setStudentId(String studentId) {
		this.studentId = studentId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getByName() {
		return byName;
	}
	public void setByName(String byName) {
		this.byName = byName;
	}
	public String getAttendCount() {
		return attendCount;
	}
	public void setAttendCount(String attendCount) {
		this.attendCount = attendCount;
	}
	public List<AttStuItem> getAttendDates() {
		return attendDates;
	}
	public void setAttendDates(List<AttStuItem> attendDates) {
		this.attendDates = attendDates;
	}
}

