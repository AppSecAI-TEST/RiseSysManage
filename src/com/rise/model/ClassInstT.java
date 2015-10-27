package com.rise.model;

import java.util.Date;
import java.util.List;

public class ClassInstT {
    private Integer classInstId;

    private String className;

    private Integer schoolId;

    private String courseType;

    private String classType;

    private String stageId;

    private Integer maxNum;

    private Integer minNum;

    private Integer hours;

    private String classState;

    private Date createDate;

    private Date openDate;

    private String openClassType;

    private String higherSchoolId;

    private Date approveCreateDate;

    private Date approveOpenDate;

    private Date startDate;

    private Date finishDate;

    private String studentChannelType;

    private String higherSchoolName;

    private Integer classOrder;

    private String state;

    private Date applyCancelDate;

    private Date approveCancelDate;

    private String handType;

    private Date applyOpenDate;

    private String updateStartRemark;

    private String cancelOpenRemark;

    private Integer openClassNum;

    private Integer gradHours;

    private Integer expNum;
    
    private String studentChannelTypeName;
    
    private String handTypeName;
    
    private String openClassTypeName;
    
    private double licenseRate;
    
    private List<SchooltimeT> schooltimeList;

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

    public Integer getSchoolId() {
        return schoolId;
    }

    public void setSchoolId(Integer schoolId) {
        this.schoolId = schoolId;
    }

    public String getCourseType() {
        return courseType;
    }

    public void setCourseType(String courseType) {
        this.courseType = courseType == null ? null : courseType.trim();
    }

    public String getClassType() {
        return classType;
    }

    public void setClassType(String classType) {
        this.classType = classType == null ? null : classType.trim();
    }

    public String getStageId() {
        return stageId;
    }

    public void setStageId(String stageId) {
        this.stageId = stageId == null ? null : stageId.trim();
    }

    public Integer getMaxNum() {
        return maxNum;
    }

    public void setMaxNum(Integer maxNum) {
        this.maxNum = maxNum;
    }

    public Integer getMinNum() {
        return minNum;
    }

    public void setMinNum(Integer minNum) {
        this.minNum = minNum;
    }

    public Integer getHours() {
        return hours;
    }

    public void setHours(Integer hours) {
        this.hours = hours;
    }

    public String getClassState() {
        return classState;
    }

    public void setClassState(String classState) {
        this.classState = classState == null ? null : classState.trim();
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public Date getOpenDate() {
        return openDate;
    }

    public void setOpenDate(Date openDate) {
        this.openDate = openDate;
    }

    public String getOpenClassType() {
        return openClassType;
    }

    public void setOpenClassType(String openClassType) {
        this.openClassType = openClassType == null ? null : openClassType.trim();
    }

    public String getHigherSchoolId() {
        return higherSchoolId;
    }

    public void setHigherSchoolId(String higherSchoolId) {
        this.higherSchoolId = higherSchoolId == null ? null : higherSchoolId.trim();
    }

    public Date getApproveCreateDate() {
        return approveCreateDate;
    }

    public void setApproveCreateDate(Date approveCreateDate) {
        this.approveCreateDate = approveCreateDate;
    }

    public Date getApproveOpenDate() {
        return approveOpenDate;
    }

    public void setApproveOpenDate(Date approveOpenDate) {
        this.approveOpenDate = approveOpenDate;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getFinishDate() {
        return finishDate;
    }

    public void setFinishDate(Date finishDate) {
        this.finishDate = finishDate;
    }

    public String getStudentChannelType() {
        return studentChannelType;
    }

    public void setStudentChannelType(String studentChannelType) {
        this.studentChannelType = studentChannelType == null ? null : studentChannelType.trim();
    }

    public String getHigherSchoolName() {
        return higherSchoolName;
    }

    public void setHigherSchoolName(String higherSchoolName) {
        this.higherSchoolName = higherSchoolName == null ? null : higherSchoolName.trim();
    }

    public Integer getClassOrder() {
        return classOrder;
    }

    public void setClassOrder(Integer classOrder) {
        this.classOrder = classOrder;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state == null ? null : state.trim();
    }

    public Date getApplyCancelDate() {
        return applyCancelDate;
    }

    public void setApplyCancelDate(Date applyCancelDate) {
        this.applyCancelDate = applyCancelDate;
    }

    public Date getApproveCancelDate() {
        return approveCancelDate;
    }

    public void setApproveCancelDate(Date approveCancelDate) {
        this.approveCancelDate = approveCancelDate;
    }

    public String getHandType() {
        return handType;
    }

    public void setHandType(String handType) {
        this.handType = handType == null ? null : handType.trim();
    }

    public Date getApplyOpenDate() {
        return applyOpenDate;
    }

    public void setApplyOpenDate(Date applyOpenDate) {
        this.applyOpenDate = applyOpenDate;
    }

    public String getUpdateStartRemark() {
        return updateStartRemark;
    }

    public void setUpdateStartRemark(String updateStartRemark) {
        this.updateStartRemark = updateStartRemark == null ? null : updateStartRemark.trim();
    }

    public String getCancelOpenRemark() {
        return cancelOpenRemark;
    }

    public void setCancelOpenRemark(String cancelOpenRemark) {
        this.cancelOpenRemark = cancelOpenRemark == null ? null : cancelOpenRemark.trim();
    }

    public Integer getOpenClassNum() {
        return openClassNum;
    }

    public void setOpenClassNum(Integer openClassNum) {
        this.openClassNum = openClassNum;
    }

    public Integer getGradHours() {
        return gradHours;
    }

    public void setGradHours(Integer gradHours) {
        this.gradHours = gradHours;
    }

    public Integer getExpNum() {
        return expNum;
    }

    public void setExpNum(Integer expNum) {
        this.expNum = expNum;
    }
    
	public String getStudentChannelTypeName() {
		return studentChannelTypeName;
	}

	public void setStudentChannelTypeName(String studentChannelTypeName) {
		this.studentChannelTypeName = studentChannelTypeName;
	}

	public String getHandTypeName() {
		return handTypeName;
	}

	public void setHandTypeName(String handTypeName) {
		this.handTypeName = handTypeName;
	}

	public String getOpenClassTypeName() {
		return openClassTypeName;
	}

	public void setOpenClassTypeName(String openClassTypeName) {
		this.openClassTypeName = openClassTypeName;
	}
	
	public double getLicenseRate() {
		return licenseRate;
	}

	public void setLicenseRate(double licenseRate) {
		this.licenseRate = licenseRate;
	}

	public List<SchooltimeT> getSchooltimeList() {
		return schooltimeList;
	}

	public void setSchooltimeList(List<SchooltimeT> schooltimeList) {
		this.schooltimeList = schooltimeList;
	}
    
}