package com.rise.model;

import java.util.Date;

public class ShortClassTeacherT {
    private Integer shortClassTeacherId;

    private Integer shortClassInstId;

	private Integer shortSchooltimeId;

    private Integer schoolId;

    private Integer teacherId;

    private String teacherType;

    private String state;

    private Date createDate;

    private Date stateDate;

    private Integer handlerId;
    
    private SchoolT schoolT;
    
	private TeacherT teacherT;

    public Integer getShortClassTeacherId() {
        return shortClassTeacherId;
    }

    public void setShortClassTeacherId(Integer shortClassTeacherId) {
        this.shortClassTeacherId = shortClassTeacherId;
    }

    public Integer getShortClassInstId() {
        return shortClassInstId;
    }

    public void setShortClassInstId(Integer shortClassInstId) {
        this.shortClassInstId = shortClassInstId;
    }
    
    public Integer getShortSchooltimeId() {
		return shortSchooltimeId;
	}

	public void setShortSchooltimeId(Integer shortSchooltimeId) {
		this.shortSchooltimeId = shortSchooltimeId;
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

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state == null ? null : state.trim();
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Date getStateDate() {
        return stateDate;
    }

    public void setStateDate(Date stateDate) {
        this.stateDate = stateDate;
    }

    public Integer getHandlerId() {
        return handlerId;
    }

    public void setHandlerId(Integer handlerId) {
        this.handlerId = handlerId;
    }

	public SchoolT getSchoolT() {
		return schoolT;
	}

	public void setSchoolT(SchoolT schoolT) {
		this.schoolT = schoolT;
	}

	public TeacherT getTeacherT() {
		return teacherT;
	}

	public void setTeacherT(TeacherT teacherT) {
		this.teacherT = teacherT;
	}
    
}