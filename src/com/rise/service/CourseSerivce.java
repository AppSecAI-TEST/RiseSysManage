package com.rise.service;

import org.springframework.stereotype.Service;

import com.rise.pub.invoke.ServiceEngine;

/**
 * 课程管理服务 
 * @author Lapalnd_Alone
 *
 */
@Service
public class CourseSerivce {

	/**
	 * 添加连报课程
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public String addLinkCourses(String param) throws Exception 
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1105\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String getStuCourses(String param) throws Exception 
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1106\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String addSingleCourse(String param) throws Exception 
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1102\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String addGifts(String param) throws Exception 
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS11010\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String delCourse(String param) throws Exception 
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1107\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
}
