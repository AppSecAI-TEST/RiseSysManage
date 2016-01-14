package com.rise.model;

import java.sql.Timestamp;

public class SysRoleT implements java.io.Serializable {

	private static final long serialVersionUID = 1L;
	private Integer sysRoleId;
	private String sysRoleName;
	private String roleMemo;
	private String privType;
	private String schoolIds;
	private String stageIds;
	private Timestamp createDate;
	private String state;
	private Timestamp stateDate;
	private Integer staffId;

	public Integer getSysRoleId() {
		return this.sysRoleId;
	}

	public void setSysRoleId(Integer sysRoleId) {
		this.sysRoleId = sysRoleId;
	}

	public String getSysRoleName() {
		return this.sysRoleName;
	}

	public void setSysRoleName(String sysRoleName) {
		this.sysRoleName = sysRoleName;
	}

	public String getRoleMemo() {
		return this.roleMemo;
	}

	public void setRoleMemo(String roleMemo) {
		this.roleMemo = roleMemo;
	}
	
	public String getPrivType() {
		return privType;
	}

	public void setPrivType(String privType) {
		this.privType = privType;
	}

	public String getSchoolIds() {
		return schoolIds;
	}

	public void setSchoolIds(String schoolIds) {
		this.schoolIds = schoolIds;
	}
	
	public String getStageIds() {
		return stageIds;
	}

	public void setStageIds(String stageIds) {
		this.stageIds = stageIds;
	}

	public Timestamp getCreateDate() {
		return this.createDate;
	}

	public void setCreateDate(Timestamp createDate) {
		this.createDate = createDate;
	}

	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public Timestamp getStateDate() {
		return this.stateDate;
	}

	public void setStateDate(Timestamp stateDate) {
		this.stateDate = stateDate;
	}

	public Integer getStaffId() {
		return this.staffId;
	}

	public void setStaffId(Integer staffId) {
		this.staffId = staffId;
	}

}