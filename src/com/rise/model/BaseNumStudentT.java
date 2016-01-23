package com.rise.model;

import java.util.Date;

public class BaseNumStudentT {
    private Integer baseNumStudentId;

    private Integer baseNumId;

    private Integer classInstId;

    private Integer studentId;

    private Integer studentCourseId;

    private Integer studyingNum;

    private String higherBaseNum;

    private String higherNum;

    private Date createDate;

    private Date stateDate;

    public Integer getBaseNumStudentId() {
        return baseNumStudentId;
    }

    public void setBaseNumStudentId(Integer baseNumStudentId) {
        this.baseNumStudentId = baseNumStudentId;
    }

    public Integer getBaseNumId() {
        return baseNumId;
    }

    public void setBaseNumId(Integer baseNumId) {
        this.baseNumId = baseNumId;
    }

    public Integer getClassInstId() {
        return classInstId;
    }

    public void setClassInstId(Integer classInstId) {
        this.classInstId = classInstId;
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

    public Integer getStudyingNum() {
        return studyingNum;
    }

    public void setStudyingNum(Integer studyingNum) {
        this.studyingNum = studyingNum;
    }

    public String getHigherBaseNum() {
        return higherBaseNum;
    }

    public void setHigherBaseNum(String higherBaseNum) {
        this.higherBaseNum = higherBaseNum == null ? null : higherBaseNum.trim();
    }

    public String getHigherNum() {
        return higherNum;
    }

    public void setHigherNum(String higherNum) {
        this.higherNum = higherNum == null ? null : higherNum.trim();
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
}