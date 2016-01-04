package com.rise.model;

import java.util.Date;

public class StudentMakeupT {
    private Integer studentMakeupId;

    private Integer studentAttendId;

    private String makeupType;

    private Date schooltime;

    private String hourRange;

    private Integer baseHour;

    private Integer hours;

    private Integer classInstId;

    private Integer teacherId;

    private String leaveUrl;

    private String makeupUrl;

    private Date createDate;

    private Date stateDate;

    private String state;

    public Integer getStudentMakeupId() {
        return studentMakeupId;
    }

    public void setStudentMakeupId(Integer studentMakeupId) {
        this.studentMakeupId = studentMakeupId;
    }

    public Integer getStudentAttendId() {
        return studentAttendId;
    }

    public void setStudentAttendId(Integer studentAttendId) {
        this.studentAttendId = studentAttendId;
    }

    public String getMakeupType() {
        return makeupType;
    }

    public void setMakeupType(String makeupType) {
        this.makeupType = makeupType == null ? null : makeupType.trim();
    }

    public Date getSchooltime() {
        return schooltime;
    }

    public void setSchooltime(Date schooltime) {
        this.schooltime = schooltime;
    }

    public String getHourRange() {
        return hourRange;
    }

    public void setHourRange(String hourRange) {
        this.hourRange = hourRange == null ? null : hourRange.trim();
    }

    public Integer getBaseHour() {
        return baseHour;
    }

    public void setBaseHour(Integer baseHour) {
        this.baseHour = baseHour;
    }

    public Integer getHours() {
        return hours;
    }

    public void setHours(Integer hours) {
        this.hours = hours;
    }

    public Integer getClassInstId() {
        return classInstId;
    }

    public void setClassInstId(Integer classInstId) {
        this.classInstId = classInstId;
    }

    public Integer getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(Integer teacherId) {
        this.teacherId = teacherId;
    }

    public String getLeaveUrl() {
        return leaveUrl;
    }

    public void setLeaveUrl(String leaveUrl) {
        this.leaveUrl = leaveUrl == null ? null : leaveUrl.trim();
    }

    public String getMakeupUrl() {
        return makeupUrl;
    }

    public void setMakeupUrl(String makeupUrl) {
        this.makeupUrl = makeupUrl == null ? null : makeupUrl.trim();
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

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state == null ? null : state.trim();
    }
}