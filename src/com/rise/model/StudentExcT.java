package com.rise.model;

import java.util.Date;

public class StudentExcT {
	private Long excId;
	
	private Long studentId;
	
	private Long studentCourseId;
	
	private String orignCourseState;
	
	private String hours;
	
	private String excState;
	
	private String remark;
	
	private Date createDate;
	
	private Long handlerId;
	
	private String orignClassName;
	
	private String stageLevel;
	
	private String resumeType;
	
	private String teacherName;
	
	private Date finishDate;
	
	private Long orignClassId;
	
	private Date resumeDate;

    public Long getExcId() {
        return excId;
    }

    public void setExcId(Long excId) {
        this.excId = excId;
    }

    public Long getStudentId() {
        return studentId;
    }

    public void setStudentId(Long studentId) {
        this.studentId = studentId;
    }

    public Long getStudentCourseId() {
        return studentCourseId;
    }

    public void setStudentCourseId(Long studentCourseId) {
        this.studentCourseId = studentCourseId;
    }

    public String getOrignCourseState() {
        return orignCourseState;
    }

    public void setOrignCourseState(String orignCourseState) {
        this.orignCourseState = orignCourseState == null ? null : orignCourseState.trim();
    }

    public String getExcState() {
        return excState;
    }

    public void setExcState(String excState) {
        this.excState = excState == null ? null : excState.trim();
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Long getHandlerId() {
        return handlerId;
    }

    public void setHandlerId(Long handlerId) {
        this.handlerId = handlerId;
    }

	public String getHours() {
		return hours;
	}

	public void setHours(String hours) {
		this.hours = hours;
	}

	public String getOrignClassName() {
		return orignClassName;
	}

	public void setOrignClassName(String orignClassName) {
		this.orignClassName = orignClassName;
	}

	public String getStageLevel() {
		return stageLevel;
	}

	public void setStageLevel(String stageLevel) {
		this.stageLevel = stageLevel;
	}

	public String getResumeType() {
		return resumeType;
	}

	public void setResumeType(String resumeType) {
		this.resumeType = resumeType;
	}

	public String getTeacherName() {
		return teacherName;
	}

	public void setTeacherName(String teacherName) {
		this.teacherName = teacherName;
	}

	public Date getFinishDate() {
		return finishDate;
	}

	public void setFinishDate(Date finishDate) {
		this.finishDate = finishDate;
	}

	public Long getOrignClassId() {
		return orignClassId;
	}

	public void setOrignClassId(Long orignClassId) {
		this.orignClassId = orignClassId;
	}

	public Date getResumeDate() {
		return resumeDate;
	}

	public void setResumeDate(Date resumeDate) {
		this.resumeDate = resumeDate;
	}
	
}