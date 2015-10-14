package com.rise.model;

import java.util.Date;

public class PostT {
    private Integer postId;

    private String postName;

    private Integer deptId;

    private String schoolIds;

    private String postRemark;

    private Date createDate;

    private Date stateDate;

    private String state;
    
    private OrgDeptT orgDeptT;

    public Integer getPostId() {
        return postId;
    }

    public void setPostId(Integer postId) {
        this.postId = postId;
    }

    public String getPostName() {
        return postName;
    }

    public void setPostName(String postName) {
        this.postName = postName == null ? null : postName.trim();
    }

    public Integer getDeptId() {
        return deptId;
    }

    public void setDeptId(Integer deptId) {
        this.deptId = deptId;
    }

    public String getSchoolIds() {
        return schoolIds;
    }

    public void setSchoolIds(String schoolIds) {
        this.schoolIds = schoolIds == null ? null : schoolIds.trim();
    }

    public String getPostRemark() {
        return postRemark;
    }

    public void setPostRemark(String postRemark) {
        this.postRemark = postRemark == null ? null : postRemark.trim();
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

	public OrgDeptT getOrgDeptT() {
		return orgDeptT;
	}

	public void setOrgDeptT(OrgDeptT orgDeptT) {
		this.orgDeptT = orgDeptT;
	}
    
}