package com.rise.model;

import java.util.Date;

public class ClassMonthHoursT {
    private Integer monthHoursId;

    private Integer classInstId;

    private Integer schoolId;

    private String month;

    private Integer needPlanHours;

    private Integer planHours;

    private Integer realHours;

    private Integer finishHours;

    private Integer planTotalHours;

    private Integer totalHours;

    private Integer diffHours;

    private Integer addHours;

    private String attendPer;

    private Date createDate;

    private Integer handlerId;

    public Integer getMonthHoursId() {
        return monthHoursId;
    }

    public void setMonthHoursId(Integer monthHoursId) {
        this.monthHoursId = monthHoursId;
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

    public String getMonth() {
        return month;
    }

    public void setMonth(String month) {
        this.month = month == null ? null : month.trim();
    }

    public Integer getNeedPlanHours() {
        return needPlanHours;
    }

    public void setNeedPlanHours(Integer needPlanHours) {
        this.needPlanHours = needPlanHours;
    }

    public Integer getPlanHours() {
        return planHours;
    }

    public void setPlanHours(Integer planHours) {
        this.planHours = planHours;
    }

    public Integer getRealHours() {
        return realHours;
    }

    public void setRealHours(Integer realHours) {
        this.realHours = realHours;
    }

    public Integer getFinishHours() {
        return finishHours;
    }

    public void setFinishHours(Integer finishHours) {
        this.finishHours = finishHours;
    }

    public Integer getPlanTotalHours() {
        return planTotalHours;
    }

    public void setPlanTotalHours(Integer planTotalHours) {
        this.planTotalHours = planTotalHours;
    }

    public Integer getTotalHours() {
        return totalHours;
    }

    public void setTotalHours(Integer totalHours) {
        this.totalHours = totalHours;
    }

    public Integer getDiffHours() {
        return diffHours;
    }

    public void setDiffHours(Integer diffHours) {
        this.diffHours = diffHours;
    }

    public Integer getAddHours() {
        return addHours;
    }

    public void setAddHours(Integer addHours) {
        this.addHours = addHours;
    }

    public String getAttendPer() {
        return attendPer;
    }

    public void setAttendPer(String attendPer) {
        this.attendPer = attendPer == null ? null : attendPer.trim();
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