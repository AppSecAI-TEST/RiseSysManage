package com.rise.service;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;

import com.rise.pub.invoke.ServiceEngine;
import com.rise.pub.util.ObjectCensor;
import com.rise.pub.util.StringUtil;

@Service
public class FuncNodeService 
{
	public String qryFuncNodeList(String page, String rows, String params) throws Exception 
	{
		Integer pageNum = Integer.parseInt(page) - 1;
		Integer pageSize = Integer.parseInt(rows);
		pageNum = pageNum * pageSize;
		String funcNodeName = "";
		if(ObjectCensor.isStrRegular(params))
		{
			JSONObject obj = JSONObject.fromObject(params);
			funcNodeName = obj.getString("funcNodeName");
		}
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0024\",securityCode:\"0000000000\",params:{param:{start:"+pageNum+",rownum:"+pageSize+",funcNodeName:\""+funcNodeName+"\"}},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String addFuncNode(String params) throws Exception 
	{
		JSONObject obj = JSONObject.fromObject(params);
		String funcNodeName = StringUtil.getJSONObjectKeyVal(obj, "funcNodeName");
		String description = StringUtil.getJSONObjectKeyVal(obj, "funcNodeName"); 
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0021\",securityCode:\"0000000000\",params:{param:{parentFuncNodeId:\"1\",funcNodeCode:\"role\",funcNodeName:\""+funcNodeName+"\",subSysTypeCd:\"S\",funcNodeType:\"M\",subFuncNodeType:\"L\",funcNodeSeq:\"1\",html:\"\",description:\""+description+"\"}},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String updateFuncNode(String params) throws Exception 
	{
		JSONObject obj = JSONObject.fromObject(params);
		String funcNodeId = StringUtil.getJSONObjectKeyVal(obj, "funcNodeId");
		String funcNodeName = StringUtil.getJSONObjectKeyVal(obj, "funcNodeName");
		String description = StringUtil.getJSONObjectKeyVal(obj, "description"); 
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0022\",securityCode:\"0000000000\",params:{param:{funcNodeId:\""+funcNodeId+"\",funcNodeCode:\"student\",funcNodeName:\""+funcNodeName+"\",subSysTypeCd:\"S\",funcNodeType:\"M\",subFuncNodeType:\"L\",funcNodeSeq:\"1\",html:\"\",description:\""+description+"\"}},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String deleteFuncNode(String funcNodeId) throws Exception 
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0023\",securityCode:\"0000000000\",params:{funcNodeId:\""+funcNodeId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
}
