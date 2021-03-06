package com.rise.model;

import java.util.Date;
import java.util.List;

public class ShortClassInstT {
    private Integer shortClassInstId;

    private Integer schoolId;

    private Integer shortClassId;

    private String classTypeId;

    private String className;

    private String classState;

    private Integer planHours;

    private Integer totalLessionHours;

    private Integer classProgress;

    private String stageId;

    private Integer planClassNum;

    private Integer realClassNum;

    private Integer personNum;

    private Integer maxNum;

    private Date planClassDate;

    private Date putClassDate;

    private Date openDate;

    private Date finishDate;

    private Date approvePerson;

    private Date approveDate;
    
    private String verifyRemark;
    
	private String remark;

    private Integer createId;

    private Date createDate;

    private Date stateDate;

    private Integer handlerId;
    
	private Integer cancelHandlerId;
	
	private Date cancelDate;
    
    private SchoolT schoolT;
    
	private ShortClassT shortClassT;
	
	private ShortClassTypeT shortClassTypeT;
	
	private GiftTypeT giftTypeT;
	
	private StageT stageT;
	
	private StaffT approvePersonObj;
	
	private StaffT creatorObj;
	
	private StaffT cancelHandlerObj;

	private List<ShortSchooltimeT> classSchooltimeList;
	
	private List<ShortClassStudentT> classStudentList;

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

    public Integer getShortClassId() {
        return shortClassId;
    }

    public void setShortClassId(Integer shortClassId) {
        this.shortClassId = shortClassId;
    }

    public String getClassTypeId() {
		return classTypeId;
	}

	public void setClassTypeId(String classTypeId) {
		this.classTypeId = classTypeId;
	}

	public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className == null ? null : className.trim();
    }

    public String getClassState() {
        return classState;
    }

    public void setClassState(String classState) {
        this.classState = classState == null ? null : classState.trim();
    }

    public Integer getPlanHours() {
        return planHours;
    }

    public void setPlanHours(Integer planHours) {
        this.planHours = planHours;
    }

    public Integer getTotalLessionHours() {
        return totalLessionHours;
    }

    public void setTotalLessionHours(Integer totalLessionHours) {
        this.totalLessionHours = totalLessionHours;
    }

    public Integer getClassProgress() {
        return classProgress;
    }

    public void setClassProgress(Integer classProgress) {
        this.classProgress = classProgress;
    }

    public String getStageId() {
        return stageId;
    }

    public void setStageId(String stageId) {
        this.stageId = stageId;
    }

    public Integer getPlanClassNum() {
        return planClassNum;
    }

    public void setPlanClassNum(Integer planClassNum) {
        this.planClassNum = planClassNum;
    }

    public Integer getRealClassNum() {
        return realClassNum;
    }

    public void setRealClassNum(Integer realClassNum) {
        this.realClassNum = realClassNum;
    }

    public Integer getPersonNum() {
        return personNum;
    }

    public void setPersonNum(Integer personNum) {
        this.personNum = personNum;
    }

    public Integer getMaxNum() {
        return maxNum;
    }

    public void setMaxNum(Integer maxNum) {
        this.maxNum = maxNum;
    }

    public Date getPlanClassDate() {
        return planClassDate;
    }

    public void setPlanClassDate(Date planClassDate) {
        this.planClassDate = planClassDate;
    }

    public Date getPutClassDate() {
        return putClassDate;
    }

    public void setPutClassDate(Date putClassDate) {
        this.putClassDate = putClassDate;
    }

    public Date getOpenDate() {
        return openDate;
    }

    public void setOpenDate(Date openDate) {
        this.openDate = openDate;
    }

    public Date getFinishDate() {
        return finishDate;
    }

    public void setFinishDate(Date finishDate) {
        this.finishDate = finishDate;
    }

    public Date getApprovePerson() {
		return approvePerson;
	}

	public void setApprovePerson(Date approvePerson) {
		this.approvePerson = approvePerson;
	}

	public Date getApproveDate() {
        return approveDate;
    }

    public void setApproveDate(Date approveDate) {
        this.approveDate = approveDate;
    }
    
    public String getVerifyRemark() {
		return verifyRemark;
	}

	public void setVerifyRemark(String verifyRemark) {
		this.verifyRemark = verifyRemark;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Integer getCreateId() {
        return createId;
    }

    public void setCreateId(Integer createId) {
        this.createId = createId;
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
    
	public Integer getCancelHandlerId() {
		return cancelHandlerId;
	}

	public void setCancelHandlerId(Integer cancelHandlerId) {
		this.cancelHandlerId = cancelHandlerId;
	}

	public Date getCancelDate() {
		return cancelDate;
	}

	public void setCancelDate(Date cancelDate) {
		this.cancelDate = cancelDate;
	}

	public SchoolT getSchoolT() {
		return schoolT;
	}

	public void setSchoolT(SchoolT schoolT) {
		this.schoolT = schoolT;
	}

	public ShortClassT getShortClassT() {
		return shortClassT;
	}

	public void setShortClassT(ShortClassT shortClassT) {
		this.shortClassT = shortClassT;
	}

	public ShortClassTypeT getShortClassTypeT() {
		return shortClassTypeT;
	}

	public void setShortClassTypeT(ShortClassTypeT shortClassTypeT) {
		this.shortClassTypeT = shortClassTypeT;
	}
	
	public GiftTypeT getGiftTypeT() {
		return giftTypeT;
	}

	public void setGiftTypeT(GiftTypeT giftTypeT) {
		this.giftTypeT = giftTypeT;
	}

	public StageT getStageT() {
		return stageT;
	}

	public void setStageT(StageT stageT) {
		this.stageT = stageT;
	}

	public StaffT getApprovePersonObj() {
		return approvePersonObj;
	}

	public void setApprovePersonObj(StaffT approvePersonObj) {
		this.approvePersonObj = approvePersonObj;
	}

	public StaffT getCreatorObj() {
		return creatorObj;
	}

	public void setCreatorObj(StaffT creatorObj) {
		this.creatorObj = creatorObj;
	}
	
	public StaffT getCancelHandlerObj() {
		return cancelHandlerObj;
	}

	public void setCancelHandlerObj(StaffT cancelHandlerObj) {
		this.cancelHandlerObj = cancelHandlerObj;
	}

	public List<ShortSchooltimeT> getClassSchooltimeList() {
		return classSchooltimeList;
	}

	public void setClassSchooltimeList(List<ShortSchooltimeT> classSchooltimeList) {
		this.classSchooltimeList = classSchooltimeList;
	}

	public List<ShortClassStudentT> getClassStudentList() {
		return classStudentList;
	}

	public void setClassStudentList(List<ShortClassStudentT> classStudentList) {
		this.classStudentList = classStudentList;
	}

}