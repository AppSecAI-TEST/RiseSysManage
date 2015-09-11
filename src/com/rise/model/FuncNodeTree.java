package com.rise.model;

import java.util.List;

public class FuncNodeTree
{
	public FuncNodeT funcNodeObj;
	
	public List<FuncNodeT> funcNodeList;

	public FuncNodeT getFuncNodeObj() {
		return funcNodeObj;
	}

	public void setFuncNodeObj(FuncNodeT funcNodeObj) {
		this.funcNodeObj = funcNodeObj;
	}

	public List<FuncNodeT> getFuncNodeList() {
		return funcNodeList;
	}

	public void setFuncNodeList(List<FuncNodeT> funcNodeList) {
		this.funcNodeList = funcNodeList;
	}
}
