package com.rise.model;

import java.util.Date;

public class AttStuItem {
	private Date attendDate;
	private String attendHour;
	private String attendTotalHour;
	private String attendType;
	public Date getAttendDate() {
		return attendDate;
	}
	public void setAttendDate(Date attendDate) {
		this.attendDate = attendDate;
	}
	public String getAttendHour() {
		return attendHour;
	}
	public void setAttendHour(String attendHour) {
		this.attendHour = attendHour;
	}
	public String getAttendTotalHour() {
		return attendTotalHour;
	}
	public void setAttendTotalHour(String attendTotalHour) {
		this.attendTotalHour = attendTotalHour;
	}
	public String getAttendType() {
		return attendType;
	}
	public void setAttendType(String attendType) {
		this.attendType = attendType;
	}
}
