package com.rise.model;

import java.util.Date;

public class StudentLeaveT {
	private Integer leaveId;
	
	private Integer studentId;
	
	private Integer studentCourseId;
	
	private String leaveState;
	
	private String stageLevel;
	
	private String orignClassName;
	
	private String orignCourseState;
	
	private String teacherNames;
	
	private String hours;
	
	private String leaveTime;
	
	private Date leaveDate;
	
	private String leaveReason;
	
	private String imgUrl;
	
	private Date createDate;
	
	private Integer handlerId;
	
	private String resumeType;
	
	private Date resumeDate;
	
	private Integer orignClassId;

    public Integer getLeaveId() {
        return leaveId;
    }

    public void setLeaveId(Integer leaveId) {
        this.leaveId = leaveId;
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

    public String getLeaveState() {
        return leaveState;
    }

    public void setLeaveState(String leaveState) {
        this.leaveState = leaveState == null ? null : leaveState.trim();
    }

    public String getOrignCourseState() {
        return orignCourseState;
    }

    public void setOrignCourseState(String orignCourseState) {
        this.orignCourseState = orignCourseState == null ? null : orignCourseState.trim();
    }

    public String getHours() {
        return hours;
    }

    public void setHours(String hours) {
        this.hours = hours == null ? null : hours.trim();
    }

    public String getLeaveTime() {
        return leaveTime;
    }

    public void setLeaveTime(String leaveTime) {
        this.leaveTime = leaveTime == null ? null : leaveTime.trim();
    }

    public Date getLeaveDate() {
        return leaveDate;
    }

    public void setLeaveDate(Date leaveDate) {
        this.leaveDate = leaveDate;
    }

    public String getLeaveReason() {
        return leaveReason;
    }

    public void setLeaveReason(String leaveReason) {
        this.leaveReason = leaveReason == null ? null : leaveReason.trim();
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl == null ? null : imgUrl.trim();
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Integer getHandlerId() {
        return handlerId;
    }

    public void setHandlerId(Integer handlerId) {
        this.handlerId = handlerId;
    }

    public String getResumeType() {
        return resumeType;
    }

    public void setResumeType(String resumeType) {
        this.resumeType = resumeType == null ? null : resumeType.trim();
    }

    public Date getResumeDate() {
        return resumeDate;
    }

    public void setResumeDate(Date resumeDate) {
        this.resumeDate = resumeDate;
    }

	public String getStageLevel() {
		return stageLevel;
	}

	public void setStageLevel(String stageLevel) {
		this.stageLevel = stageLevel;
	}

	public String getOrignClassName() {
		return orignClassName;
	}

	public void setOrignClassName(String orignClassName) {
		this.orignClassName = orignClassName;
	}

	public String getTeacherNames() {
		return teacherNames;
	}

	public void setTeacherNames(String teacherNames) {
		this.teacherNames = teacherNames;
	}

	public Integer getOrignClassId() {
		return orignClassId;
	}

	public void setOrignClassId(Integer orignClassId) {
		this.orignClassId = orignClassId;
	}
    
}