package com.rise.model;

import java.util.Date;

public class ShortClassT {
    private Integer shortClassId;

    private String className;

    private String isTeaching;

    private String state;

    private Integer handlerId;

    private Date createDate;

    public Integer getShortClassId() {
        return shortClassId;
    }

    public void setShortClassId(Integer shortClassId) {
        this.shortClassId = shortClassId;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className == null ? null : className.trim();
    }

    public String getIsTeaching() {
        return isTeaching;
    }

    public void setIsTeaching(String isTeaching) {
        this.isTeaching = isTeaching == null ? null : isTeaching.trim();
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state == null ? null : state.trim();
    }

    public Integer getHandlerId() {
        return handlerId;
    }

    public void setHandlerId(Integer handlerId) {
        this.handlerId = handlerId;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }
}