package com.rise.model;

import java.util.Date;

public class ShortTeacherAttendT {
    private Integer shortTeacherAttendId;

    private Integer shortClassAttendId;

    private Integer shortClassInstId;

    private Integer schoolId;

    private Integer teacherId;

    private String teacherType;

    private Integer lessionHours;

    private Date attendDate;

    private Integer handerId;

    private String state;
    
    private Date createDate;
    
    private TeacherT teacherT;

    public Integer getShortTeacherAttendId() {
        return shortTeacherAttendId;
    }

    public void setShortTeacherAttendId(Integer shortTeacherAttendId) {
        this.shortTeacherAttendId = shortTeacherAttendId;
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

    public Integer getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(Integer teacherId) {
        this.teacherId = teacherId;
    }

    public String getTeacherType() {
        return teacherType;
    }

    public void setTeacherType(String teacherType) {
        this.teacherType = teacherType == null ? null : teacherType.trim();
    }

    public Integer getLessionHours() {
        return lessionHours;
    }

    public void setLessionHours(Integer lessionHours) {
        this.lessionHours = lessionHours;
    }

    public Date getAttendDate() {
        return attendDate;
    }

    public void setAttendDate(Date attendDate) {
        this.attendDate = attendDate;
    }
    
    public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public Integer getHanderId() {
        return handerId;
    }

    public void setHanderId(Integer handerId) {
        this.handerId = handerId;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

	public TeacherT getTeacherT() {
		return teacherT;
	}

	public void setTeacherT(TeacherT teacherT) {
		this.teacherT = teacherT;
	}
    
}