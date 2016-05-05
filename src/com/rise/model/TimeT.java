package com.rise.model;

import java.util.Date;

public class TimeT {
    private Long timeId;

    private String timeName;

    private String hourRange;

    private String weekTime;

    private String apm;

    private String timeState;

    private String state;

    private Date createDate;

    private Long handlerId;

    private Integer lessionHours;

    public Long getTimeId() {
        return timeId;
    }

    public void setTimeId(Long timeId) {
        this.timeId = timeId;
    }

    public String getTimeName() {
        return timeName;
    }

    public void setTimeName(String timeName) {
        this.timeName = timeName == null ? null : timeName.trim();
    }

    public String getHourRange() {
        return hourRange;
    }

    public void setHourRange(String hourRange) {
        this.hourRange = hourRange == null ? null : hourRange.trim();
    }

    public String getWeekTime() {
        return weekTime;
    }

    public void setWeekTime(String weekTime) {
        this.weekTime = weekTime == null ? null : weekTime.trim();
    }

    public String getApm() {
        return apm;
    }

    public void setApm(String apm) {
        this.apm = apm == null ? null : apm.trim();
    }

    public String getTimeState() {
        return timeState;
    }

    public void setTimeState(String timeState) {
        this.timeState = timeState == null ? null : timeState.trim();
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

    public Long getHandlerId() {
        return handlerId;
    }

    public void setHandlerId(Long handlerId) {
        this.handlerId = handlerId;
    }

    public Integer getLessionHours() {
        return lessionHours;
    }

    public void setLessionHours(Integer lessionHours) {
        this.lessionHours = lessionHours;
    }
}