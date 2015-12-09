package com.rise.service;


import org.springframework.stereotype.Service;
import com.rise.pub.invoke.ServiceEngine;

@Service
public class MergeClassService 
{
	public String qryClassInstList(String classInstIds) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS3111\",securityCode:\"0000000000\",params:{classInstIds:\""+classInstIds+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
}

