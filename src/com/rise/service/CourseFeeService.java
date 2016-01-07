package com.rise.service;

import org.springframework.stereotype.Service;

import com.rise.pub.invoke.ServiceEngine;

@Service
public class CourseFeeService 
{
	public String getCourseFeeInfo(String studentCourseId) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS3061\",securityCode:\"0000000000\",params:{studentCourseId:\""+studentCourseId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String changeFee(String params) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS3062\",securityCode:\"0000000000\",params:{params:"+params+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String qryFeeChangeInfo(String studentCourseId) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS3063\",securityCode:\"0000000000\",params:{studentCourseId:\""+studentCourseId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
}

