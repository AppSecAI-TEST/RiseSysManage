package com.rise.service;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;

import com.rise.model.FuncNodeT;
import com.rise.model.ResourceT;
import com.rise.model.StaffT;
import com.rise.pub.invoke.ServiceEngine;

@Service
public class FuncNodeService 
{
//	public String qryFuncNodeList(String page, String rows, String params) throws Exception 
//	{
//		Integer pageNum = Integer.parseInt(page) - 1;
//		Integer pageSize = Integer.parseInt(rows);
//		pageNum = pageNum * pageSize;
//		String funcNodeName = "";
//		if(ObjectCensor.isStrRegular(params))
//		{
//			JSONObject obj = JSONObject.fromObject(params);
//			funcNodeName = obj.getString("funcNodeName");
//		}
//		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0024\",securityCode:\"0000000000\",params:{param:{start:"+pageNum+",rownum:"+pageSize+",funcNodeName:\""+funcNodeName+"\"}},rtnDataFormatType:\"user-defined\"}";
//		return ServiceEngine.invokeHttp(param);
//	}
	
	public String getSubFuncNodeList(String id) throws Exception 
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0025\",securityCode:\"0000000000\",params:{funcNodeId:\""+id+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String getFuncNodeInfoList(String id) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0029\",securityCode:\"0000000000\",params:{funcNodeId:\""+id+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String getFuncNodeTableList(String id , Integer page , Integer rows) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS00213\",securityCode:\"0000000000\",params:{funcNodeId:\""+id+"\",page:\""+page+"\",rows:\""+rows+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
//	public String addFuncNode(String params) throws Exception 
//	{
//		JSONObject obj = JSONObject.fromObject(params);
//		String funcNodeName = StringUtil.getJSONObjectKeyVal(obj, "funcNodeName");
//		String description = StringUtil.getJSONObjectKeyVal(obj, "funcNodeName"); 
//		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0021\",securityCode:\"0000000000\",params:{param:{parentFuncNodeId:\"1\",funcNodeCode:\"role\",funcNodeName:\""+funcNodeName+"\",subSysTypeCd:\"S\",funcNodeType:\"M\",subFuncNodeType:\"L\",funcNodeSeq:\"1\",html:\"\",description:\""+description+"\"}},rtnDataFormatType:\"user-defined\"}";
//		return ServiceEngine.invokeHttp(param);
//	}
//	
//	public String updateFuncNode(String params) throws Exception 
//	{
//		JSONObject obj = JSONObject.fromObject(params);
//		String funcNodeId = StringUtil.getJSONObjectKeyVal(obj, "funcNodeId");
//		String funcNodeName = StringUtil.getJSONObjectKeyVal(obj, "funcNodeName");
//		String description = StringUtil.getJSONObjectKeyVal(obj, "description"); 
//		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0022\",securityCode:\"0000000000\",params:{param:{funcNodeId:\""+funcNodeId+"\",funcNodeCode:\"student\",funcNodeName:\""+funcNodeName+"\",subSysTypeCd:\"S\",funcNodeType:\"M\",subFuncNodeType:\"L\",funcNodeSeq:\"1\",html:\"\",description:\""+description+"\"}},rtnDataFormatType:\"user-defined\"}";
//		return ServiceEngine.invokeHttp(param);
//	}
//	
//	public String deleteFuncNode(String funcNodeId) throws Exception 
//	{
//		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0023\",securityCode:\"0000000000\",params:{funcNodeId:\""+funcNodeId+"\"},rtnDataFormatType:\"user-defined\"}";
//		return ServiceEngine.invokeHttp(param);
//	}
	
	public String addFuncNodeInfo(FuncNodeT funcNodeT , ResourceT resourceT) throws Exception
	{
		JSONObject jsonOne = JSONObject.fromObject(funcNodeT);
		JSONObject jsonTwo = JSONObject.fromObject(resourceT);
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0026\",securityCode:\"0000000000\",params:{jsonOne:'"+jsonOne+"',jsonTwo:'"+jsonTwo+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String updateFuncNodeInfo(FuncNodeT funcNodeT , ResourceT resourceT) throws Exception
	{
		JSONObject jsonOne = JSONObject.fromObject(funcNodeT);
		JSONObject jsonTwo = JSONObject.fromObject(resourceT);
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0027\",securityCode:\"0000000000\",params:{jsonOne:'"+jsonOne+"',jsonTwo:'"+jsonTwo+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String deleteFuncNodeInfo(String funcNodeId) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0028\",securityCode:\"0000000000\",params:{deptId:\""+funcNodeId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String getParentMenuList() throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS00210\",securityCode:\"0000000000\",params:{},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String getParentOperList() throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS00211\",securityCode:\"0000000000\",params:{},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String getParentPrivList() throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS00212\",securityCode:\"0000000000\",params:{},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String getCtrlData(String resourceId , String funcNodeId , String sysRoleId) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS00214\",securityCode:\"0000000000\",params:{resourceId:\""+resourceId+"\",funcNodeId:\""+funcNodeId+"\",sysRoleId:\""+sysRoleId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String getSubFuncNodeListWithRole(String sysRoleId) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS00215\",securityCode:\"0000000000\",params:{sysRoleId:\""+sysRoleId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String getPrivFuncNodeList(String sysRoleId , String funcNodeId) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS00216\",securityCode:\"0000000000\",params:{sysRoleId:\""+sysRoleId+"\",funcNodeId:\""+funcNodeId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String settingConditionInfo(String roleId , String funcNodeId , String resourceId , String valArr , String type) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS00217\",securityCode:\"0000000000\",params:{roleId:\""+roleId+"\",funcNodeId:\""+funcNodeId+"\",resourceId:\""+resourceId+"\",valArr:\""+valArr+"\",type:\""+type+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String getOperFuncNodeList(String sysRoleId) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS00218\",securityCode:\"0000000000\",params:{sysRoleId:\""+sysRoleId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
}
