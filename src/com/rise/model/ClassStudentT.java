package com.rise.model;

import java.util.Date;

public class ClassStudentT {
    private Integer classStudentId;

    private Integer classInstId;

    private String className;

    private Integer studentId;

    private Integer studentCourseId;

    private Date createDate;

    private String state;

    private Integer handlerId;

    private String studentChannelType;

    private Integer schoolId;
    
    private StudentT studentT;
    
	private StudentCourseT studentCourseT;

    public Integer getClassStudentId() {
        return classStudentId;
    }

    public void setClassStudentId(Integer classStudentId) {
        this.classStudentId = classStudentId;
    }

    public Integer getClassInstId() {
        return classInstId;
    }

    public void setClassInstId(Integer classInstId) {
        this.classInstId = classInstId;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className == null ? null : className.trim();
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

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state == null ? null : state.trim();
    }

    public Integer getHandlerId() {
        return handlerId;
    }

    public void setHandlerId(Integer handlerId) {
        this.handlerId = handlerId;
    }

    public String getStudentChannelType() {
        return studentChannelType;
    }

    public void setStudentChannelType(String studentChannelType) {
        this.studentChannelType = studentChannelType == null ? null : studentChannelType.trim();
    }

    public Integer getSchoolId() {
        return schoolId;
    }

    public void setSchoolId(Integer schoolId) {
        this.schoolId = schoolId;
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
	
}