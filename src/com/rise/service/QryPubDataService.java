package com.rise.service;

import org.springframework.stereotype.Service;

import com.rise.pub.invoke.ServiceEngine;

@Service
public class QryPubDataService 
{
	public String qryCodeNameList(String tableName, String codeType, String codeFlag) throws Exception 
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1013\",securityCode:\"0000000000\",params:{tableName:\""+tableName+"\",codeType:\""+codeType+"\",codeFlag:\""+codeFlag+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	public String qrySchoolList(String schoolId) throws Exception  
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1011\",securityCode:\"0000000000\",params:{schoolId:\""+schoolId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	public String qryStaffList(String post, String schoolId) throws Exception 
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1012\",securityCode:\"0000000000\",params:{schoolId:\""+schoolId+"\",post:\""+post+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	public String qryParaConfigList(String paramType, String paramValue) throws Exception 
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1015\",securityCode:\"0000000000\",params:{paramType:\""+paramType+"\",paramValue:\""+paramValue+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
}
