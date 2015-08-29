package com.rise.service;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;

import com.rise.pub.invoke.ServiceEngine;
import com.rise.pub.util.ObjectCensor;
import com.rise.pub.util.StringUtil;

@Service
public class StudentService 
{
	public String qryStudentList(String page, String rows, String param) throws Exception 
	{
		Integer pageNum = Integer.parseInt(page) - 1;
		Integer pageSize = Integer.parseInt(rows);
		pageNum = pageNum * pageSize;
		String schoolId = "", name = "", phone = "", identityId = "", advisterId = "", dutyAdvister = "", carer = "", startTime = "", endTime = "";
		if(ObjectCensor.isStrRegular(param))
		{
			JSONObject obj = JSONObject.fromObject(param);
			schoolId = StringUtil.getJSONObjectKeyVal(obj, "schoolId");
			name = StringUtil.getJSONObjectKeyVal(obj, "name");
			phone = StringUtil.getJSONObjectKeyVal(obj, "phone");
			identityId = StringUtil.getJSONObjectKeyVal(obj, "identityId");
			advisterId = StringUtil.getJSONObjectKeyVal(obj, "advisterId");
			dutyAdvister = StringUtil.getJSONObjectKeyVal(obj, "dutyAdvister");
			carer = StringUtil.getJSONObjectKeyVal(obj, "carer");
			startTime = StringUtil.getJSONObjectKeyVal(obj, "startTime");
			endTime = StringUtil.getJSONObjectKeyVal(obj, "endTime");
		}
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0041\",securityCode:\"0000000000\",params:{param:{start:"+pageNum+",rownum:"+pageSize+",schoolId:\""+schoolId+"\",name:\""+name+"\",phone:\""+phone+"\",identityId:\""+identityId+"\",advisterId:\""+advisterId+"\",dutyAdvister:\""+dutyAdvister+"\",carer:\""+carer+"\",startTime:\""+startTime+"\",endTime:\""+endTime+"\"}},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String validate(String param) throws Exception 
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0042\",securityCode:\"0000000000\",params:{param:{identityId:\"\",identityType:\"\",name:\"李丽华\",sex:\"0\",birthday:\"2009-6-01\"}},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}

	public String addStudent(String param) throws Exception 
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0043\",securityCode:\"0000000000\",params:{param:{schoolId:\"1001\",name:\"李丽华\",sex:\"0\",identityId:\"\",identityType:\"\",schoolRealId:\"10001\",schoolClassId:\"02\",address:\"武汉市江汉区\",byName:\"Alise\",birthday:\"2009-06-01\",remark:\"\",advisterIdA:\"1234\",advisterIdB:\"1234\",dutyAdvister:\"1234\",carer:\"1234\",handlerId:\"2589\",contactArray:[{identityId:\"123456789012345678\",identityType:\"2BA\",name:\"李雷\",phone:\"12345678901\",relationType:\"01\",job:\"公务员\",used:\"Y\"},{identityId:\"123456789012335687\",identityType:\"2BA\",name:\"韩梅梅\",phone:\"12345675963\",relationType:\"02\",job:\"会计\",used:\"N\"}]}},rtnDataFormatType:\"user-defined\"}";
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
}
