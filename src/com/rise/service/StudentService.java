package com.rise.service;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;

import com.rise.pub.invoke.ServiceEngine;
import com.rise.pub.util.ObjectCensor;

@Service
public class StudentService 
{
	public String qryStudentList(String page, String rows, String param, String funcNodeId) throws Exception 
	{
		Integer pageNum = Integer.parseInt(page) - 1;
		Integer pageSize = Integer.parseInt(rows);
		pageNum = pageNum * pageSize;
		JSONObject obj = new JSONObject();
		if(ObjectCensor.isStrRegular(param))
		{
			obj = JSONObject.fromObject(param);
		}
		if(ObjectCensor.isStrRegular(funcNodeId))
		{
			obj.element("funcNodeId", funcNodeId);
		}
		obj.element("start", pageNum);
		obj.element("rownum", pageSize);
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0041\",securityCode:\"0000000000\",params:{param:"+obj+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String validate(String param) throws Exception 
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0042\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}

	public String addStudent(String param) throws Exception 
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0043\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String qryStudentById(String studentId) throws Exception 
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0044\",securityCode:\"0000000000\",params:{studentId:\""+studentId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	public String updateStudent(String param) throws Exception  
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0045\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}

	public String addActivity(String param) throws Exception 
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0046\",securityCode:\"0000000000\",params:{param:{studentId:\"2\",title:\"2015瑞思杯\",activityDate:\"2015-06-01\",award:\"活动小组第一名\",remark:\"2015瑞思杯\"}},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}

	public String setVip(String studentId) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0047\",securityCode:\"0000000000\",params:{studentId:\""+studentId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	public String addVipRemark(String param) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0048\",securityCode:\"0000000000\",params:{param:{studentId:\"2\", staffId:\"1234\", remark:\"该学员系校方关系，设置VIP标识，2015年报名S1，原价20000元，减免学费5000元，实收15000元。\"}},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}

	public String qryVipRemarkList(String studentId) throws Exception 
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0049\",securityCode:\"0000000000\",params:{studentId:\""+studentId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
}
