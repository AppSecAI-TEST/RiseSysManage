package com.rise.service;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;

import com.rise.model.StaffT;
import com.rise.model.SysRoleT;
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
	
	public String querySysRole(Integer page, Integer rows) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS00311\",securityCode:\"0000000000\",params:{page:\""+page+"\",rows:\""+rows+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String addRole(SysRoleT sysRoleT) throws Exception
	{
		JSONObject json = JSONObject.fromObject(sysRoleT);
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS00312\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String updateRole(SysRoleT sysRoleT) throws Exception
	{
		JSONObject json = JSONObject.fromObject(sysRoleT);
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS00313\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String deleteRole(String sysRoleId) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS00314\",securityCode:\"0000000000\",params:{sysRoleId:\""+sysRoleId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String saveChoiceRoleList(String sysRoleId , String staffIds , HttpSession session) throws Exception
	{
		StaffT staffT = (StaffT)session.getAttribute("StaffT");
		if(!ObjectCensor.checkObjectIsNull(staffT))
		{
			String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS00315\",securityCode:\"0000000000\",params:{sysRoleId:\""+sysRoleId+"\",staffIds:\""+staffIds+"\",handlerId:\""+staffT.getStaffId()+"\"},rtnDataFormatType:\"user-defined\"}";
			return ServiceEngine.invokeHttp(param);
		}
		else
		{
			return "缺乏用户信息,请核实后重新尝试";
		}
	}
	
	public String qryTotalRoleList() throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS00316\",securityCode:\"0000000000\",params:{},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String settingRoleFunc(String sysRoleId , String funcNodeIds , HttpSession session) throws Exception
	{
		StaffT staffT = (StaffT)session.getAttribute("StaffT");
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS00317\",securityCode:\"0000000000\",params:{sysRoleId:\""+sysRoleId+"\",funcNodeIds:\""+funcNodeIds+"\",staffId:\""+staffT.getStaffId()+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
}
