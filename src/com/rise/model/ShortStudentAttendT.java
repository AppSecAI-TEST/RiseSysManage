package com.rise.model;

import java.util.Date;

public class ShortStudentAttendT {
    private Integer shortStudentAttendId;

    private Integer shortClassAttendId;

    private Integer shortClassInstId;

    private Integer schoolId;

    private Integer studentId;
    
    private Integer studentCourseId;
    
    private Integer studentGiftId;
    
	private Integer hours;

    private String attendType;

    private String dress;

    private Date attendDate;

    private Integer handlerId;

    private Date createDate;
    
    private StudentT studentT;

    public Integer getShortStudentAttendId() {
        return shortStudentAttendId;
    }

    public void setShortStudentAttendId(Integer shortStudentAttendId) {
        this.shortStudentAttendId = shortStudentAttendId;
    }

    public Integer getShortClassAttendId() {
        return shortClassAttendId;
    }

    public void setShortClassAttendId(Integer shortClassAttendId) {
        this.shortClassAttendId = shortClassAttendId;
    }

    public Integer getShortClassInstId() {
        return shortClassInstId;
    }

    public void setShortClassInstId(Integer shortClassInstId) {
        this.shortClassInstId = shortClassInstId;
    }

    public Integer getSchoolId() {
        return schoolId;
    }

    public void setSchoolId(Integer schoolId) {
        this.schoolId = schoolId;
    }

    public Integer getStudentId() {
        return studentId;
    }

    public void setStudentId(Integer studentId) {
        this.studentId = studentId;
    }
    
    public Integer getStudentCourseId() {
		return studentCourseId;
	}

	public void setStudentCourseId(Integer studentCourseId) {
		this.studentCourseId = studentCourseId;
	}
	
	public Integer getStudentGiftId() {
		return studentGiftId;
	}

	public void setStudentGiftId(Integer studentGiftId) {
		this.studentGiftId = studentGiftId;
	}

	public Integer getHours() {
		return hours;
	}

	public void setHours(Integer hours) {
		this.hours = hours;
	}

	public String getAttendType() {
        return attendType;
    }

    public void setAttendType(String attendType) {
        this.attendType = attendType == null ? null : attendType.trim();
    }

    public String getDress() {
        return dress;
    }

    public void setDress(String dress) {
        this.dress = dress == null ? null : dress.trim();
    }

    public Date getAttendDate() {
        return attendDate;
    }

    public void setAttendDate(Date attendDate) {
        this.attendDate = attendDate;
    }

    public Integer getHandlerId() {
        return handlerId;
    }

    public void setHandlerId(Integer handlerId) {
        this.handlerId = handlerId;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

	public StudentT getStudentT() {
		return studentT;
	}

	public void setStudentT(StudentT studentT) {
		this.studentT = studentT;
	}
    
}