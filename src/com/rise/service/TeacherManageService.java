package com.rise.service;

import org.springframework.stereotype.Service;

import com.rise.pub.invoke.ServiceEngine;

@Service
public class TeacherManageService {

	public String updateTeacherInfo(String json, String type)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1601\",securityCode:\"0000000000\",params:{json:'"+json+"',type:'"+type+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	public String getTeacherInfo(String teacherId, String type)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1602\",securityCode:\"0000000000\",params:{teacherId:'"+teacherId+"',type:'"+type+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	public String getTeacherInfo(String teacherId) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1603\",securityCode:\"0000000000\",params:{teacherId:\""+teacherId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	public String qryTeacherArchivesList(String param) throws Exception 
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1604\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
}
