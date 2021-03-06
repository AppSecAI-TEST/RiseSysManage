package com.rise.model;

import java.util.Date;

public class StudentAttendT {
    private Integer studentAttendId;

    private Integer classAttendId;

    private Integer classInstId;
    
	private String stageId;

    private String classType;
    
	private Integer studentCourseId;

    private Integer studentId;

    private String studentName;

    private Integer schoolId;
    
    private Integer hours;
    
    private Integer baseHours;

    private String dress;

    private String attendType;
    
    private Date attendDate;

    private Integer handlerId;

    private Date createDate;
    
    private String isFirst;
    
    private String state;

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
    
    public String getStageId() {
		return stageId;
	}

	public void setStageId(String stageId) {
		this.stageId = stageId;
	}

	public String getClassType() {
        return classType;
    }

    public void setClassType(String classType) {
        this.classType = classType == null ? null : classType.trim();
    }
    
    public Integer getStudentCourseId() {
		return studentCourseId;
	}

	public void setStudentCourseId(Integer studentCourseId) {
		this.studentCourseId = studentCourseId;
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
    
    public Integer getHours() {
		return hours;
	}

	public void setHours(Integer hours) {
		this.hours = hours;
	}
	
	public Integer getBaseHours() {
		return baseHours;
	}

	public void setBaseHours(Integer baseHours) {
		this.baseHours = baseHours;
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
    
	public String getIsFirst() {
		return isFirst;
	}

	public void setIsFirst(String isFirst) {
		this.isFirst = isFirst;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
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