package com.rise.service;

import org.springframework.stereotype.Service;

import com.rise.pub.invoke.ServiceEngine;

@Service
public class PubService 
{
	public String pageCategory(String staffId , String funcNodeId , String fieldId) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2011\",securityCode:\"0000000000\",params:{staffId:\""+staffId+"\",funcNodeId:\""+funcNodeId+"\",fieldId:\""+fieldId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String pageComboxList(String funcNodeId , String fieldId) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2012\",securityCode:\"0000000000\",params:{funcNodeId:\""+funcNodeId+"\",fieldId:\""+fieldId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
}
