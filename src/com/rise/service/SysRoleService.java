package com.rise.service;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;

import com.rise.pub.invoke.ServiceEngine;
import com.rise.pub.util.ObjectCensor;
import com.rise.pub.util.StringUtil;

@Service
public class SysRoleService 
{
	public String qrySysRoleList(String page, String rows, String params) throws Exception
	{
		Integer pageNum = Integer.parseInt(page) - 1;
		Integer pageSize = Integer.parseInt(rows);
		pageNum = pageNum * pageSize;
		String sysRoleName = "";
		if(ObjectCensor.isStrRegular(params))
		{
			JSONObject obj = JSONObject.fromObject(params);
			sysRoleName = obj.getString("sysRoleName");
		}
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0034\",securityCode:\"0000000000\",params:{param:{start:"+pageNum+",rownum:"+pageSize+",sysRoleName:\""+sysRoleName+"\",staffId:1}},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	public String addSysRole(String params) throws Exception
	{
		JSONObject obj = JSONObject.fromObject(params);
		String sysRoleName = StringUtil.getJSONObjectKeyVal(obj, "sysRoleName");
		String roleMemo = StringUtil.getJSONObjectKeyVal(obj, "roleMemo");
//		String schoolId = StringUtil.getJSONObjectKeyVal(obj, "schoolId");
//		String staffId = StringUtil.getJSONObjectKeyVal(obj, "staffId");
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0031\",securityCode:\"0000000000\",params:{param:{sysRoleName:\""+sysRoleName+"\",roleMemo:\""+roleMemo+"\",schoolId:1,staffId:1}},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	public String updateSysRole(String params) throws Exception 
	{
		JSONObject obj = JSONObject.fromObject(params);
		String sysRoleId = StringUtil.getJSONObjectKeyVal(obj, "sysRoleId");
		String sysRoleName = StringUtil.getJSONObjectKeyVal(obj, "sysRoleName");
		String roleMemo = StringUtil.getJSONObjectKeyVal(obj, "roleMemo");
//		String schoolId = StringUtil.getJSONObjectKeyVal(obj, "schoolId");
//		String staffId = StringUtil.getJSONObjectKeyVal(obj, "staffId");
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0032\",securityCode:\"0000000000\",params:{param:{sysRoleId:"+sysRoleId+",staffId:1,sysRoleName:\""+sysRoleName+"\",roleMemo:\""+roleMemo+"\",schoolId:1}},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String deleteSysRole(String sysRoleId, String staffId) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0033\",securityCode:\"0000000000\",params:{sysRoleId:"+sysRoleId+",staffId:1},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String qrySysRoleAllocList(String sysRoleId, String staffId) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0035\",securityCode:\"0000000000\",params:{sysRoleId:\""+sysRoleId+"\",staffId:\"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String qrySysRoleNotAllocList(String sysRoleId, String staffId) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0036\",securityCode:\"0000000000\",params:{sysRoleId:\""+sysRoleId+"\",staffId:\"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	public String allocSysRole(String sysRoleId, String staffId, String allocArray, String sysRoleAllocId) throws Exception 
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0037\",securityCode:\"0000000000\",params:{param:{sysRoleId:\""+sysRoleId+"\",staffId:\""+staffId+"\",allocArray:"+allocArray+",sysRoleAllocId:\""+sysRoleAllocId+"\"}},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
}
