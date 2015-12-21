package com.rise.model;

import java.util.Date;

public class BaseNumT {
    private Integer baseNumId;

    private Integer classInstId;

    private Integer studyingNum;

    private Double higherBaseNum;

    private Double higherNum;

    private String higherRate;

    private Integer originStudyingNum;

    private Integer originHigherBaseNum;

    private Integer originHigherNum;

    private Date createDate;

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

    public Integer getStudyingNum() {
        return studyingNum;
    }

    public void setStudyingNum(Integer studyingNum) {
        this.studyingNum = studyingNum;
    }

    public Double getHigherBaseNum() {
        return higherBaseNum;
    }

    public void setHigherBaseNum(Double higherBaseNum) {
        this.higherBaseNum = higherBaseNum;
    }

    public Double getHigherNum() {
        return higherNum;
    }

    public void setHigherNum(Double higherNum) {
        this.higherNum = higherNum;
    }

    public String getHigherRate() {
        return higherRate;
    }

    public void setHigherRate(String higherRate) {
        this.higherRate = higherRate == null ? null : higherRate.trim();
    }

    public Integer getOriginStudyingNum() {
        return originStudyingNum;
    }

    public void setOriginStudyingNum(Integer originStudyingNum) {
        this.originStudyingNum = originStudyingNum;
    }

    public Integer getOriginHigherBaseNum() {
        return originHigherBaseNum;
    }

    public void setOriginHigherBaseNum(Integer originHigherBaseNum) {
        this.originHigherBaseNum = originHigherBaseNum;
    }

    public Integer getOriginHigherNum() {
        return originHigherNum;
    }

    public void setOriginHigherNum(Integer originHigherNum) {
        this.originHigherNum = originHigherNum;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }
}