package com.rise.model;

import java.util.Date;

public class TeacherAttendT {
    private Integer teacherAttendId;

    private Integer classAttendId;

    private Integer classInstId;

    private String classType;

    private Integer teacherId;

    private String teacherName;

    private String teacherType;
    
    private String hours;
    
    private String attendType;

    private Date attendDate;

    private Integer handerId;

    private Date createDate;
    
    private TeacherT teacherT;

    public Integer getTeacherAttendId() {
        return teacherAttendId;
    }

    public void setTeacherAttendId(Integer teacherAttendId) {
        this.teacherAttendId = teacherAttendId;
    }

    public Integer getClassAttendId() {
        return classAttendId;
    }

    public void setClassAttendId(Integer classAttendId) {
        this.classAttendId = classAttendId;
    }

    public Integer getClassInstId() {
        return classInstId;
    }

    public void setClassInstId(Integer classInstId) {
        this.classInstId = classInstId;
    }

    public String getClassType() {
        return classType;
    }

    public void setClassType(String classType) {
        this.classType = classType == null ? null : classType.trim();
    }

    public Integer getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(Integer teacherId) {
        this.teacherId = teacherId;
    }

    public String getTeacherName() {
        return teacherName;
    }

    public void setTeacherName(String teacherName) {
        this.teacherName = teacherName == null ? null : teacherName.trim();
    }
    
    public String getTeacherType() {
		return teacherType;
	}

	public void setTeacherType(String teacherType) {
		this.teacherType = teacherType;
	}

	public String getHours() {
		return hours;
	}

	public void setHours(String hours) {
		this.hours = hours;
	}

	public String getAttendType() {
        return attendType;
    }

    public void setAttendType(String attendType) {
        this.attendType = attendType == null ? null : attendType.trim();
    }

    public Date getAttendDate() {
        return attendDate;
    }

    public void setAttendDate(Date attendDate) {
        this.attendDate = attendDate;
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