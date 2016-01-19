package com.rise.model;

import java.util.Date;

public class StudentCourseT {
    private Integer studentCourseId;

    private Integer studentId;

    private String courseType;

    private String classType;

    private String stageId;

    private Integer stageOrder;

    private String courseState;

    private String feeType;

    private Double totalAmount;

    private String favorType;

    private Double minusAmount;

    private Double favorAmount;

    private Double amount;

    private Double lastAmount;
    
    private Double adjustAmount;

    private Integer linkId;

    private Integer linkOrder;

    private Integer coursePriceId;

    private Integer linkFavorId;

    private Integer adviserA;

    private Integer adviserB;

    private Integer adviserTeacherA;

    private Integer adviserTeacherB;

    private Date payDate;

    private Date exceptionDate;

    private String feeState;

    private Date refundDate;

    private String remark;
    
	private String minusRemark;

    private Date createDate;

    private String exceptionRemark;

    private String imgUrl;

    private Integer paySchoolId;

    private Integer finishSchoolId;
    
    private String courseStateName;
    
    private String studentClassName;
    
	private StaffT adviserAObj;
	
	private StaffT adviserBObj;
	
	private StaffT adviserTeacherAObj;
	
	private StaffT adviserTeacherBObj;

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

    public Integer getStageOrder() {
        return stageOrder;
    }

    public void setStageOrder(Integer stageOrder) {
        this.stageOrder = stageOrder;
    }

    public String getCourseState() {
        return courseState;
    }

    public void setCourseState(String courseState) {
        this.courseState = courseState == null ? null : courseState.trim();
    }

    public String getFeeType() {
        return feeType;
    }

    public void setFeeType(String feeType) {
        this.feeType = feeType == null ? null : feeType.trim();
    }

    public Double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(Double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public String getFavorType() {
        return favorType;
    }

    public void setFavorType(String favorType) {
        this.favorType = favorType == null ? null : favorType.trim();
    }

    public Double getMinusAmount() {
        return minusAmount;
    }

    public void setMinusAmount(Double minusAmount) {
        this.minusAmount = minusAmount;
    }

    public Double getFavorAmount() {
        return favorAmount;
    }

    public void setFavorAmount(Double favorAmount) {
        this.favorAmount = favorAmount;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public Double getLastAmount() {
        return lastAmount;
    }

    public void setLastAmount(Double lastAmount) {
        this.lastAmount = lastAmount;
    }
    
    public Double getAdjustAmount() {
		return adjustAmount;
	}

	public void setAdjustAmount(Double adjustAmount) {
		this.adjustAmount = adjustAmount;
	}

	public Integer getLinkId() {
        return linkId;
    }

    public void setLinkId(Integer linkId) {
        this.linkId = linkId;
    }

    public Integer getLinkOrder() {
        return linkOrder;
    }

    public void setLinkOrder(Integer linkOrder) {
        this.linkOrder = linkOrder;
    }

    public Integer getCoursePriceId() {
        return coursePriceId;
    }

    public void setCoursePriceId(Integer coursePriceId) {
        this.coursePriceId = coursePriceId;
    }

    public Integer getLinkFavorId() {
        return linkFavorId;
    }

    public void setLinkFavorId(Integer linkFavorId) {
        this.linkFavorId = linkFavorId;
    }

    public Integer getAdviserA() {
        return adviserA;
    }

    public void setAdviserA(Integer adviserA) {
        this.adviserA = adviserA;
    }

    public Integer getAdviserB() {
        return adviserB;
    }

    public void setAdviserB(Integer adviserB) {
        this.adviserB = adviserB;
    }

    public Integer getAdviserTeacherA() {
        return adviserTeacherA;
    }

    public void setAdviserTeacherA(Integer adviserTeacherA) {
        this.adviserTeacherA = adviserTeacherA;
    }

    public Integer getAdviserTeacherB() {
        return adviserTeacherB;
    }

    public void setAdviserTeacherB(Integer adviserTeacherB) {
        this.adviserTeacherB = adviserTeacherB;
    }

    public Date getPayDate() {
        return payDate;
    }

    public void setPayDate(Date payDate) {
        this.payDate = payDate;
    }

    public Date getExceptionDate() {
        return exceptionDate;
    }

    public void setExceptionDate(Date exceptionDate) {
        this.exceptionDate = exceptionDate;
    }

    public String getFeeState() {
        return feeState;
    }

    public void setFeeState(String feeState) {
        this.feeState = feeState == null ? null : feeState.trim();
    }

    public Date getRefundDate() {
        return refundDate;
    }

    public void setRefundDate(Date refundDate) {
        this.refundDate = refundDate;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }
    
    public String getMinusRemark() {
		return minusRemark;
	}

	public void setMinusRemark(String minusRemark) {
		this.minusRemark = minusRemark;
	}

	public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getExceptionRemark() {
        return exceptionRemark;
    }

    public void setExceptionRemark(String exceptionRemark) {
        this.exceptionRemark = exceptionRemark == null ? null : exceptionRemark.trim();
    }

    public String getImgUrl() {
        return imgUrl;
    }

    public void setImgUrl(String imgUrl) {
        this.imgUrl = imgUrl == null ? null : imgUrl.trim();
    }

    public Integer getPaySchoolId() {
        return paySchoolId;
    }

    public void setPaySchoolId(Integer paySchoolId) {
        this.paySchoolId = paySchoolId;
    }

    public Integer getFinishSchoolId() {
        return finishSchoolId;
    }

    public void setFinishSchoolId(Integer finishSchoolId) {
        this.finishSchoolId = finishSchoolId;
    }

	public String getCourseStateName() {
		return courseStateName;
	}

	public void setCourseStateName(String courseStateName) {
		this.courseStateName = courseStateName;
	}

	public String getStudentClassName() {
		return studentClassName;
	}

	public void setStudentClassName(String studentClassName) {
		this.studentClassName = studentClassName;
	}
	
	public StaffT getAdviserAObj() {
		return adviserAObj;
	}

	public void setAdviserAObj(StaffT adviserAObj) {
		this.adviserAObj = adviserAObj;
	}

	public StaffT getAdviserBObj() {
		return adviserBObj;
	}

	public void setAdviserBObj(StaffT adviserBObj) {
		this.adviserBObj = adviserBObj;
	}

	public StaffT getAdviserTeacherAObj() {
		return adviserTeacherAObj;
	}

	public void setAdviserTeacherAObj(StaffT adviserTeacherAObj) {
		this.adviserTeacherAObj = adviserTeacherAObj;
	}

	public StaffT getAdviserTeacherBObj() {
		return adviserTeacherBObj;
	}

	public void setAdviserTeacherBObj(StaffT adviserTeacherBObj) {
		this.adviserTeacherBObj = adviserTeacherBObj;
	}
    
}