package com.rise.service;

import org.springframework.stereotype.Service;

import com.rise.pub.invoke.ServiceEngine;

@Service
public class ReportService
{
	public String getTeacherAttendHours(String schoolId,String teacherId,String month) throws Exception  
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS8201\",securityCode:\"0000000000\",params:{schoolId:'"+schoolId+"',teacherId:'"+teacherId+"',month:'"+month+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}

	public String getTeacherNum(String schoolId,String teacherId,String month) throws Exception  
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS8202\",securityCode:\"0000000000\",params:{schoolId:'"+schoolId+"',teacherName:'"+teacherId+"',month:'"+month+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String getCourseIncome(String schoolId,String feeType,String month) throws Exception  
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS8211\",securityCode:\"0000000000\",params:{schoolId:'"+schoolId+"',teacherId:'"+feeType+"',month:'"+month+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String getHours(String param) throws Exception  
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS8203\",securityCode:\"0000000000\",params:{param:'"+param+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String recordDiffInfo(String param) throws Exception  
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS8204\",securityCode:\"0000000000\",params:{param:'"+param+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
}
