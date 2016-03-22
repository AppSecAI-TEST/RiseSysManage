package com.rise.model;

import java.util.Date;

public class ShortClassStudentT {
    private Integer shortClassStudentId;

    private Integer shortClassInstId;

    private Integer schoolId;

    private Integer studentId;

    private Integer studentCourseId;

    private String state;

    private Date createDate;

    private Date stateDate;

    private Integer handlerId;
    
    private StudentT studentT;
    
	private StudentCourseT studentCourseT;
	
	private String normalClassName;

    public Integer getShortClassStudentId() {
        return shortClassStudentId;
    }

    public void setShortClassStudentId(Integer shortClassStudentId) {
        this.shortClassStudentId = shortClassStudentId;
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

	public StudentT getStudentT() {
		return studentT;
	}

	public void setStudentT(StudentT studentT) {
		this.studentT = studentT;
	}

	public StudentCourseT getStudentCourseT() {
		return studentCourseT;
	}

	public void setStudentCourseT(StudentCourseT studentCourseT) {
		this.studentCourseT = studentCourseT;
	}

	public String getNormalClassName() {
		return normalClassName;
	}

	public void setNormalClassName(String normalClassName) {
		this.normalClassName = normalClassName;
	}
	
}