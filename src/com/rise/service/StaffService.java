package com.rise.service;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;

import com.rise.model.StaffT;
import com.rise.pub.invoke.ServiceEngine;

@Service
public class StaffService {
	
	public String qryStaffListByDeptId(String deptId , Integer page , Integer rows) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2003\",securityCode:\"0000000000\",params:{deptId:\""+deptId+"\",page:\""+page+"\",rows:\""+rows+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String addStaff(StaffT staffT) throws Exception
	{
		JSONObject json = JSONObject.fromObject(staffT);
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2004\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String updateStaff(StaffT staffT) throws Exception
	{
		JSONObject json = JSONObject.fromObject(staffT);
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2005\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String deleteStaff(String staffId) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2006\",securityCode:\"0000000000\",params:{deptId:\""+staffId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
}
