package com.rise.model;

import java.util.Date;

public class StudentExcT {
    private Long excId;

    private Long studentId;

    private Long studentCourseId;

    private String orignCourseState;

    private Short hours;

    private String excState;

    private String remark;

    private Date createDate;

    private Long handlerId;

    public Long getExcId() {
        return excId;
    }

    public void setExcId(Long excId) {
        this.excId = excId;
    }

    public Long getStudentId() {
        return studentId;
    }

    public void setStudentId(Long studentId) {
        this.studentId = studentId;
    }

    public Long getStudentCourseId() {
        return studentCourseId;
    }

    public void setStudentCourseId(Long studentCourseId) {
        this.studentCourseId = studentCourseId;
    }

    public String getOrignCourseState() {
        return orignCourseState;
    }

    public void setOrignCourseState(String orignCourseState) {
        this.orignCourseState = orignCourseState == null ? null : orignCourseState.trim();
    }

    public Short getHours() {
        return hours;
    }

    public void setHours(Short hours) {
        this.hours = hours;
    }

    public String getExcState() {
        return excState;
    }

    public void setExcState(String excState) {
        this.excState = excState == null ? null : excState.trim();
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
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
}