package com.rise.model;

import java.util.Date;

public class AttStuItem {
	private Date attendDate;
	private String attendType;
	public Date getAttendDate() {
		return attendDate;
	}
	public void setAttendDate(Date attendDate) {
		this.attendDate = attendDate;
	}
	public String getAttendType() {
		return attendType;
	}
	public void setAttendType(String attendType) {
		this.attendType = attendType;
	}
}
