package com.rise.service;

import java.util.List;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.rise.model.StaffT;
import com.rise.pub.base.JacksonJsonMapper;
import com.rise.pub.invoke.ServiceEngine;
import com.rise.pub.util.ObjectCensor;
import com.rise.pub.util.StringUtil;

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
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2006\",securityCode:\"0000000000\",params:{staffId:\""+staffId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String getStaffTotalList(String deptId , String staffIds) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2007\",securityCode:\"0000000000\",params:{deptId:\""+deptId+"\",staffIds:\""+staffIds+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String getStaffListByRoleId(String sysRoleId) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2008\",securityCode:\"0000000000\",params:{sysRoleId:\""+sysRoleId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String dimissionStaff(String operType , String staffId) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2009\",securityCode:\"0000000000\",params:{operType:\""+operType+"\",staffId:\""+staffId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String qryStaffListByCondition(String deptId , String userName , String post , String state , Integer page , Integer rows) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20010\",securityCode:\"0000000000\",params:{deptId:\""+deptId+"\",userName:\""+userName+"\",post:\""+post+"\",state:\""+state+"\",page:\""+page+"\",rows:\""+rows+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public void getStaffDetail(ModelAndView model , String pageFlag , String staffId , String funcNodeId) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20011\",securityCode:\"0000000000\",params:{staffId:\""+staffId+"\"},rtnDataFormatType:\"user-defined\"}";
		String result = ServiceEngine.invokeHttp(param);
		JSONObject json = JSONObject.fromObject(result);
		if(ObjectCensor.isStrRegular(staffId))
		{
			StaffT staffT = JacksonJsonMapper.getInstance().readValue(StringUtil.getJSONObjectKeyVal(json, "staffT"), StaffT.class); 
			model.addObject("staffT", staffT);
		}
		List postList = JacksonJsonMapper.getInstance().readValue(StringUtil.getJSONObjectKeyVal(json, "postList"), List.class);
		model.addObject("postList", postList);
		model.addObject("pageFlag", pageFlag);
		model.addObject("funcNodeId", funcNodeId);
	}

	public String updatePassword(String staffId, String oldPassword,String newPassword)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20012\",securityCode:\"0000000000\",params:{staffId:'"+staffId+"',oldPassword:'"+oldPassword+"',newPassword:'"+newPassword+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String getStaffMsg(String staffId,String flag)throws Exception {
//		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS9011\",securityCode:\"0000000000\",params:{staffId:'"+staffId+"',flag:'"+flag+"'},rtnDataFormatType:\"user-defined\"}";
//		return ServiceEngine.invokeHttp(param);
		return "[]";
	}
}
