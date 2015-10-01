package com.rise.service;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;

import com.rise.model.OrgDeptT;
import com.rise.pub.invoke.ServiceEngine;

@Service
public class OrgDeptService 
{
	
	public String qryOrgDeptList() throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2021\",securityCode:\"0000000000\",params:{},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String getRootOrgDept() throws Exception
	{
		String result = qryOrgDeptList();
		result = result.replaceAll("deptId", "id");
		result = result.replaceAll("deptName", "text");
		return result;
	}
	
	public String getOrgList(String id) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2027\",securityCode:\"0000000000\",params:{deptId:\""+id+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String getSubOrgDeptList(String id) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2026\",securityCode:\"0000000000\",params:{deptId:\""+id+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String addOrgDept(OrgDeptT orgDeptT) throws Exception
	{
		JSONObject json = JSONObject.fromObject(orgDeptT);
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2022\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String updateOrgDept(OrgDeptT orgDeptT) throws Exception
	{
		JSONObject json = JSONObject.fromObject(orgDeptT);
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2023\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String deleteOrgDept(String deptId) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2024\",securityCode:\"0000000000\",params:{deptId:\""+deptId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String getAreaOrgDeptList() throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2025\",securityCode:\"0000000000\",params:{},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String getCtrlAreaOrgDept() throws Exception
	{
		String result = getAreaOrgDeptList();
		result = result.replaceAll("deptId", "id");
		result = result.replaceAll("deptName", "text");
		return result;
	}
	
}
