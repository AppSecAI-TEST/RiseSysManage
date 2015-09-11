package com.rise.model;

import java.sql.Timestamp;
import java.util.Date;

import com.rise.pub.base.SysDate;

public class FuncNodeT implements java.io.Serializable,Cloneable {

	// Fields

	private static final long serialVersionUID = 1L;
	private Integer funcNodeId;
	private Integer parentFuncNodeId;
	private String funcNodeCode;
	private String funcNodeName;
	private String subSysTypeCd;
	private String funcNodeType;
	private String subFuncNodeType;
	private Integer funcNodeSeq;
	private String html;
	private String description;
	private String state;
	private Date stateDate;

	// Constructors

	/** default constructor */
	public FuncNodeT() {
	}
	
	/** minimal constructor */
	public FuncNodeT(Integer parentFuncNodeId, String funcNodeCode,
			String funcNodeName, String subSysTypeCd, String funcNodeType,
			String subFuncNodeType, Integer funcNodeSeq, String html,
			String description) {
		this.parentFuncNodeId = parentFuncNodeId;
		this.funcNodeCode = funcNodeCode;
		this.funcNodeName = funcNodeName;
		this.subSysTypeCd = subSysTypeCd;
		this.funcNodeType = funcNodeType;
		this.subFuncNodeType = subFuncNodeType;
		this.funcNodeSeq = funcNodeSeq;
		this.html = html;
		this.description = description;
		this.state = "00A";
		this.stateDate = SysDate.getSysDate();
	}

	/** full constructor */
	public FuncNodeT(Integer parentFuncNodeId, String funcNodeCode,
			String funcNodeName, String subSysTypeCd, String funcNodeType,
			String subFuncNodeType, Integer funcNodeSeq, String html,
			String description, String state, Timestamp stateDate) {
		this.parentFuncNodeId = parentFuncNodeId;
		this.funcNodeCode = funcNodeCode;
		this.funcNodeName = funcNodeName;
		this.subSysTypeCd = subSysTypeCd;
		this.funcNodeType = funcNodeType;
		this.subFuncNodeType = subFuncNodeType;
		this.funcNodeSeq = funcNodeSeq;
		this.html = html;
		this.description = description;
		this.state = state;
		this.stateDate = stateDate;
	}

	// Property accessors
	public Integer getFuncNodeId() {
		return this.funcNodeId;
	}

	public void setFuncNodeId(Integer funcNodeId) {
		this.funcNodeId = funcNodeId;
	}

	public Integer getParentFuncNodeId() {
		return this.parentFuncNodeId;
	}

	public void setParentFuncNodeId(Integer parentFuncNodeId) {
		this.parentFuncNodeId = parentFuncNodeId;
	}

	public String getFuncNodeCode() {
		return this.funcNodeCode;
	}

	public void setFuncNodeCode(String funcNodeCode) {
		this.funcNodeCode = funcNodeCode;
	}

	public String getFuncNodeName() {
		return this.funcNodeName;
	}

	public void setFuncNodeName(String funcNodeName) {
		this.funcNodeName = funcNodeName;
	}

	public String getSubSysTypeCd() {
		return this.subSysTypeCd;
	}

	public void setSubSysTypeCd(String subSysTypeCd) {
		this.subSysTypeCd = subSysTypeCd;
	}

	public String getFuncNodeType() {
		return this.funcNodeType;
	}

	public void setFuncNodeType(String funcNodeType) {
		this.funcNodeType = funcNodeType;
	}

	public String getSubFuncNodeType() {
		return this.subFuncNodeType;
	}

	public void setSubFuncNodeType(String subFuncNodeType) {
		this.subFuncNodeType = subFuncNodeType;
	}

	public Integer getFuncNodeSeq() {
		return this.funcNodeSeq;
	}

	public void setFuncNodeSeq(Integer funcNodeSeq) {
		this.funcNodeSeq = funcNodeSeq;
	}

	public String getHtml() {
		return this.html;
	}

	public void setHtml(String html) {
		this.html = html;
	}

	public String getDescription() {
		return this.description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getState() {
		return this.state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public Date getStateDate() {
		return stateDate;
	}

	public void setStateDate(Date stateDate) {
		this.stateDate = stateDate;
	}

	@Override    
	public FuncNodeT clone() {
		FuncNodeT clone = null;         
		try{
			clone = (FuncNodeT) super.clone();          
		}catch(CloneNotSupportedException e){
			throw new RuntimeException(e);
		}
		return clone;     
	}

}