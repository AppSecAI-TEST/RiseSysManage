package com.rise.model;

import java.util.Date;

public class StudentAttendT {
    private Integer studentAttendId;

    private Integer classAttendId;

    private Integer classInstId;

    private String classType;

    private Integer studentId;

    private String studentName;

    private Integer schoolId;

    private String dress;

    private String attendType;

    private Integer handlerId;

    private Date createDate;
    
    private String isFirst;

	private StudentT studentT;
	
	private StudentCourseT studentCourseT;

    public Integer getStudentAttendId() {
        return studentAttendId;
    }

    public void setStudentAttendId(Integer studentAttendId) {
        this.studentAttendId = studentAttendId;
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

    public Integer getStudentId() {
        return studentId;
    }

    public void setStudentId(Integer studentId) {
        this.studentId = studentId;
    }

    public String getStudentName() {
        return studentName;
    }

    public void setStudentName(String studentName) {
        this.studentName = studentName == null ? null : studentName.trim();
    }

    public Integer getSchoolId() {
        return schoolId;
    }

    public void setSchoolId(Integer schoolId) {
        this.schoolId = schoolId;
    }

    public String getDress() {
        return dress;
    }

    public void setDress(String dress) {
        this.dress = dress;
    }

    public String getAttendType() {
        return attendType;
    }

    public void setAttendType(String attendType) {
        this.attendType = attendType;
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
    
	public String getIsFirst() {
		return isFirst;
	}

	public void setIsFirst(String isFirst) {
		this.isFirst = isFirst;
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