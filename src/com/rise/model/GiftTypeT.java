package com.rise.model;

import java.util.Date;

public class GiftTypeT {
    private Integer giftType;

    private String giftCode;

    private String typeName;

    private String parentType;

    private String useType;

    private String manageType;

    private String isMinus;

    private String effNum;

    private String unit;

    private String effRemark;

    private String getRemark;

    private String state;

    private Date createDate;

    private Integer handlerId;

    public Integer getGiftType() {
        return giftType;
    }

    public void setGiftType(Integer giftType) {
        this.giftType = giftType;
    }

    public String getGiftCode() {
        return giftCode;
    }

    public void setGiftCode(String giftCode) {
        this.giftCode = giftCode == null ? null : giftCode.trim();
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName == null ? null : typeName.trim();
    }

    public String getParentType() {
        return parentType;
    }

    public void setParentType(String parentType) {
        this.parentType = parentType == null ? null : parentType.trim();
    }

    public String getUseType() {
        return useType;
    }

    public void setUseType(String useType) {
        this.useType = useType == null ? null : useType.trim();
    }

    public String getManageType() {
        return manageType;
    }

    public void setManageType(String manageType) {
        this.manageType = manageType == null ? null : manageType.trim();
    }

    public String getIsMinus() {
        return isMinus;
    }

    public void setIsMinus(String isMinus) {
        this.isMinus = isMinus == null ? null : isMinus.trim();
    }

    public String getEffNum() {
        return effNum;
    }

    public void setEffNum(String effNum) {
        this.effNum = effNum == null ? null : effNum.trim();
    }

    public String getUnit() {
        return unit;
    }

    public void setUnit(String unit) {
        this.unit = unit == null ? null : unit.trim();
    }

    public String getEffRemark() {
        return effRemark;
    }

    public void setEffRemark(String effRemark) {
        this.effRemark = effRemark == null ? null : effRemark.trim();
    }

    public String getGetRemark() {
        return getRemark;
    }

    public void setGetRemark(String getRemark) {
        this.getRemark = getRemark == null ? null : getRemark.trim();
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