package com.rise.model;

import java.util.Date;

public class ChangeT {
    private Integer applyId;

    private Integer schoolId;

    private Integer studentId;

    private Integer studentCourseId;
    
	private String courseState;

    private String applyType;

    private String changeSource;

    private String tacheState;

    private Integer outSchoolId;

    private Integer inSchoolId;

    private Integer outClassId;

    private Integer inClassId;

    private String imgUrl;

    private Date applyDate;

    private Date outDate;

    private Date inDate;

    private Date finishDate;

    private String remark;

    private Date approveDate;

    private Integer planInClassId;

    private String approveState;
    
    private StudentT studentT;

    public Integer getApplyId() {
        return applyId;
    }

    public void setApplyId(Integer applyId) {
        this.applyId = applyId;
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

    public String getCourseState() {
		return courseState;
	}

	public void setCourseState(String courseState) {
		this.courseState = courseState;
	}

	public String getApplyType() {
        return applyType;
    }

    public void setApplyType(String applyType) {
        this.applyType = applyType == null ? null : applyType.trim();
    }

    public String getChangeSource() {
        return changeSource;
    }

    public void setChangeSource(String changeSource) {
        this.changeSource = changeSource == null ? null : changeSource.trim();
    }

    public String getTacheState() {
        return tacheState;
    }

    public void setTacheState(String tacheState) {
        this.tacheState = tacheState == null ? null : tacheState.trim();
    }

    public Integer getOutSchoolId() {
        return outSchoolId;
    }

    public void setOutSchoolId(Integer outSchoolId) {
        this.outSchoolId = outSchoolId;
    }

    public Integer getInSchoolId() {
        return inSchoolId;
    }

    public void setInSchoolId(Integer inSchoolId) {
        this.inSchoolId = inSchoolId;
    }

    public Integer getOutClassId() {
        return outClassId;
    }

    public void setOutClassId(Integer outClassId) {
        this.outClassId = outClassId;
    }

    public Integer getInClassId() {
        return inClassId;
    }

    public void setInClassId(Integer inClassId) {
        this.inClassId = inClassId;
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl == null ? null : imgUrl.trim();
    }

    public Date getApplyDate() {
        return applyDate;
    }

    public void setApplyDate(Date applyDate) {
        this.applyDate = applyDate;
    }

    public Date getOutDate() {
        return outDate;
    }

    public void setOutDate(Date outDate) {
        this.outDate = outDate;
    }

    public Date getInDate() {
        return inDate;
    }

    public void setInDate(Date inDate) {
        this.inDate = inDate;
    }

    public Date getFinishDate() {
        return finishDate;
    }

    public void setFinishDate(Date finishDate) {
        this.finishDate = finishDate;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    public Date getApproveDate() {
        return approveDate;
    }

    public void setApproveDate(Date approveDate) {
        this.approveDate = approveDate;
    }

    public Integer getPlanInClassId() {
        return planInClassId;
    }

    public void setPlanInClassId(Integer planInClassId) {
        this.planInClassId = planInClassId;
    }

    public String getApproveState() {
        return approveState;
    }

    public void setApproveState(String approveState) {
        this.approveState = approveState == null ? null : approveState.trim();
    }

	public StudentT getStudentT() {
		return studentT;
	}

	public void setStudentT(StudentT studentT) {
		this.studentT = studentT;
	}
    
}