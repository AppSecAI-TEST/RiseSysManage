package com.rise.model;

import java.util.Date;
import java.util.List;

public class ClassTeacherT {
    private Integer classTeacherId;

    private Integer classInstId;

    private Integer schoolId;

    private Integer teacherId;

    private String teacherType;

    private Date startDate;

    private Date endDate;

    private String state;

    private Date createDate;

    private Integer schooltimeId;

    private Integer handlerId;

    private Integer hours;

    private String remark;
    
    private String teacherName;
    
    private String hasLicense;
    
    private String schoolName;
    
    private SchoolT schoolT;
    
	private List<TeacherLicenseT> classLicenseList;

    public Integer getClassTeacherId() {
        return classTeacherId;
    }

    public void setClassTeacherId(Integer classTeacherId) {
        this.classTeacherId = classTeacherId;
    }

    public Integer getClassInstId() {
        return classInstId;
    }

    public void setClassInstId(Integer classInstId) {
        this.classInstId = classInstId;
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

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
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

    public Integer getSchooltimeId() {
        return schooltimeId;
    }

    public void setSchooltimeId(Integer schooltimeId) {
        this.schooltimeId = schooltimeId;
    }

    public Integer getHandlerId() {
        return handlerId;
    }

    public void setHandlerId(Integer handlerId) {
        this.handlerId = handlerId;
    }

    public Integer getHours() {
        return hours;
    }

    public void setHours(Integer hours) {
        this.hours = hours;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }
    
	public String getTeacherName() {
		return teacherName;
	}

	public void setTeacherName(String teacherName) {
		this.teacherName = teacherName;
	}

	public String getHasLicense() {
		return hasLicense;
	}

	public void setHasLicense(String hasLicense) {
		this.hasLicense = hasLicense;
	}
	
	public String getSchoolName() {
		return schoolName;
	}

	public void setSchoolName(String schoolName) {
		this.schoolName = schoolName;
	}

	public SchoolT getSchoolT() {
		return schoolT;
	}

	public void setSchoolT(SchoolT schoolT) {
		this.schoolT = schoolT;
	}

	public List<TeacherLicenseT> getClassLicenseList() {
		return classLicenseList;
	}

	public void setClassLicenseList(List<TeacherLicenseT> classLicenseList) {
		this.classLicenseList = classLicenseList;
	}
    
}