package com.rise.model;

import java.util.Date;
import java.util.List;

public class StudentT {
    private Integer studentId;

    private Integer schoolId;

    private String name;

    private String sex;

    private String identityId;

    private String identityType;

    private String address;

    private String byName;

    private Date birthday;

    private String vip;

    private Date createDate;

    private String remark;

    private Integer advisterIdA;

    private Integer advisterIdB;

    private Integer dutyAdvister;

    private Integer carer;

    private Integer handlerId;

    private String state;

	private SchoolT schoolT;
	
	private List<ContactT> contactList;

    public Integer getStudentId() {
        return studentId;
    }

    public void setStudentId(Integer studentId) {
        this.studentId = studentId;
    }

    public Integer getSchoolId() {
        return schoolId;
    }

    public void setSchoolId(Integer schoolId) {
        this.schoolId = schoolId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name == null ? null : name.trim();
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex == null ? null : sex.trim();
    }

    public String getIdentityId() {
        return identityId;
    }

    public void setIdentityId(String identityId) {
        this.identityId = identityId == null ? null : identityId.trim();
    }

    public String getIdentityType() {
        return identityType;
    }

    public void setIdentityType(String identityType) {
        this.identityType = identityType == null ? null : identityType.trim();
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address == null ? null : address.trim();
    }

    public String getByName() {
        return byName;
    }

    public void setByName(String byName) {
        this.byName = byName == null ? null : byName.trim();
    }

    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    public String getVip() {
        return vip;
    }

    public void setVip(String vip) {
        this.vip = vip == null ? null : vip.trim();
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark == null ? null : remark.trim();
    }

    public Integer getAdvisterIdA() {
        return advisterIdA;
    }

    public void setAdvisterIdA(Integer advisterIdA) {
        this.advisterIdA = advisterIdA;
    }

    public Integer getAdvisterIdB() {
        return advisterIdB;
    }

    public void setAdvisterIdB(Integer advisterIdB) {
        this.advisterIdB = advisterIdB;
    }

    public Integer getDutyAdvister() {
        return dutyAdvister;
    }

    public void setDutyAdvister(Integer dutyAdvister) {
        this.dutyAdvister = dutyAdvister;
    }

    public Integer getCarer() {
        return carer;
    }

    public void setCarer(Integer carer) {
        this.carer = carer;
    }

    public Integer getHandlerId() {
        return handlerId;
    }

    public void setHandlerId(Integer handlerId) {
        this.handlerId = handlerId;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state == null ? null : state.trim();
    }

	public SchoolT getSchoolT() {
		return schoolT;
	}

	public void setSchoolT(SchoolT schoolT) {
		this.schoolT = schoolT;
	}

	public List<ContactT> getContactList() {
		return contactList;
	}

	public void setContactList(List<ContactT> contactList) {
		this.contactList = contactList;
	}
    
}