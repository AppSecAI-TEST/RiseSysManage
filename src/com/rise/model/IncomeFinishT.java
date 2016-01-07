package com.rise.model;

import java.util.Date;

public class IncomeFinishT {
    private Integer incomeFinishId;

    private Integer schoolId;

    private Integer classInstId;

    private Date startDate;

    private Date endDate;

    private Date finishDate;

    private String incomeType;

    private String isFinish;

    private String state;

    private Date createDate;

    private Integer handlerId;

    public Integer getIncomeFinishId() {
        return incomeFinishId;
    }

    public void setIncomeFinishId(Integer incomeFinishId) {
        this.incomeFinishId = incomeFinishId;
    }

    public Integer getSchoolId() {
        return schoolId;
    }

    public void setSchoolId(Integer schoolId) {
        this.schoolId = schoolId;
    }

    public Integer getClassInstId() {
        return classInstId;
    }

    public void setClassInstId(Integer classInstId) {
        this.classInstId = classInstId;
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

    public Date getFinishDate() {
        return finishDate;
    }

    public void setFinishDate(Date finishDate) {
        this.finishDate = finishDate;
    }

    public String getIncomeType() {
        return incomeType;
    }

    public void setIncomeType(String incomeType) {
        this.incomeType = incomeType == null ? null : incomeType.trim();
    }

    public String getIsFinish() {
        return isFinish;
    }

    public void setIsFinish(String isFinish) {
        this.isFinish = isFinish == null ? null : isFinish.trim();
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

    public Integer getHandlerId() {
        return handlerId;
    }

    public void setHandlerId(Integer handlerId) {
        this.handlerId = handlerId;
    }
}