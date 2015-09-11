package com.rise.model;
// default package

import java.util.Date;

/**
 * StaffT entity. @author MyEclipse Persistence Tools
 */
public class StaffT implements java.io.Serializable {

	// Fields

	private Integer staffId;
	private Integer schoolId;
	private String staffName;
	private String userName;
	private String password;
	private Integer post;
	private Date hireDate;
	private String phone;
	private String state;
	private Date createDate;
	private Integer handlerId;
	private String remoteIp;
	private Date lastDate;

	// Constructors

	/** default constructor */
	public StaffT() {
	}

	/** minimal constructor */
	public StaffT(Integer staffId, Integer schoolId, String staffName,
			String userName, String password, Integer post, Date hireDate,
			String state, Date createDate, Integer handlerId) {
		this.staffId = staffId;
		this.schoolId = schoolId;
		this.staffName = staffName;
		this.userName = userName;
		this.password = password;
		this.post = post;
		this.hireDate = hireDate;
		this.state = state;
		this.createDate = createDate;
		this.handlerId = handlerId;
	}

	/** full constructor */
	public StaffT(Integer staffId, Integer schoolId, String staffName,
			String userName, String password, Integer post, Date hireDate,
			String phone, String state, Date createDate,
			Integer handlerId, String remoteIp, Date lastDate) {
		this.staffId = staffId;
		this.schoolId = schoolId;
		this.staffName = staffName;
		this.userName = userName;
		this.password = password;
		this.post = post;
		this.hireDate = hireDate;
		this.phone = phone;
		this.state = state;
		this.createDate = createDate;
		this.handlerId = handlerId;
		this.remoteIp = remoteIp;
		this.lastDate = lastDate;
	}

	// Property accessors
	public Integer getStaffId() {
		return this.staffId;
	}

	public void setStaffId(Integer staffId) {
		this.staffId = staffId;
	}

	public Integer getSchoolId() {
		return this.schoolId;
	}

	public void setSchoolId(Integer schoolId) {
		this.schoolId = schoolId;
	}

	public String getStaffName() {
		return this.staffName;
	}

	public void setStaffName(String staffName) {
		this.staffName = staffName;
	}

	public String getUserName() {
		return this.userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return this.password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public Integer getPost() {
		return this.post;
	}

	public void setPost(Integer post) {
		this.post = post;
	}

	public Date getHireDate() {
		return this.hireDate;
	}

	public void setHireDate(Date hireDate) {
		this.hireDate = hireDate;
	}

	public String getPhone() {
		return this.phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public Date getCreateDate() {
		return this.createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public Integer getHandlerId() {
		return this.handlerId;
	}

	public void setHandlerId(Integer handlerId) {
		this.handlerId = handlerId;
	}

	public String getRemoteIp() {
		return this.remoteIp;
	}

	public void setRemoteIp(String remoteIp) {
		this.remoteIp = remoteIp;
	}

	public Date getLastDate() {
		return this.lastDate;
	}

	public void setLastDate(Date lastDate) {
		this.lastDate = lastDate;
	}

}