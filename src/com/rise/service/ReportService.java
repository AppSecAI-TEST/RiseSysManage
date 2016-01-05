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

}
