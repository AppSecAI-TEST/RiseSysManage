package com.rise.model;

import java.util.Date;
import java.util.List;

public class TeacherT {
    private Integer teacherId;

    private String teacherName;

    private String byName;

    private String sex;

    private Integer schoolId;

    private String pState;

    private String state;

    private Date createDate;
    
    private SchoolT schoolT;
    
	private List<TeacherLicenseT> teacherLicenseList;

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

    public String getByName() {
		return byName;
	}

	public void setByName(String byName) {
		this.byName = byName;
	}

	public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex == null ? null : sex.trim();
    }

    public Integer getSchoolId() {
        return schoolId;
    }

    public void setSchoolId(Integer schoolId) {
        this.schoolId = schoolId;
    }

	public String getpState() {
		return pState;
	}

	public void setpState(String pState) {
		this.pState = pState;
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

	public SchoolT getSchoolT() {
		return schoolT;
	}

	public void setSchoolT(SchoolT schoolT) {
		this.schoolT = schoolT;
	}

	public List<TeacherLicenseT> getTeacherLicenseList() {
		return teacherLicenseList;
	}

	public void setTeacherLicenseList(List<TeacherLicenseT> teacherLicenseList) {
		this.teacherLicenseList = teacherLicenseList;
	}
    
}