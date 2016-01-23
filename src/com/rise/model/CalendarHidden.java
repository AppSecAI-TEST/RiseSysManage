package com.rise.model;

import java.util.List;

public class CalendarHidden {
	
	private String classAttendId;
	
	private String schooltimeInstId;
	
	private String hourRange;
	
	private String roomName;
	
	private List<TeacherInfo> teacherList;
	
	public String getClassAttendId() {
		return classAttendId;
	}

	public void setClassAttendId(String classAttendId) {
		this.classAttendId = classAttendId;
	}

	public String getSchooltimeInstId() {
		return schooltimeInstId;
	}

	public void setSchooltimeInstId(String schooltimeInstId) {
		this.schooltimeInstId = schooltimeInstId;
	}

	public String getHourRange() {
		return hourRange;
	}

	public void setHourRange(String hourRange) {
		this.hourRange = hourRange;
	}

	public String getRoomName() {
		return roomName;
	}

	public void setRoomName(String roomName) {
		this.roomName = roomName;
	}

	public List<TeacherInfo> getTeacherList() {
		return teacherList;
	}

	public void setTeacherList(List<TeacherInfo> teacherList) {
		this.teacherList = teacherList;
	}
	
}
