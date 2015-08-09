package com.rise.service;

import org.springframework.stereotype.Service;

import com.rise.pub.invoke.ServiceEngine;

@Service
public class ExampleService 
{
	
	public String addExample(String exampleName , String exampleValue) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0011\",securityCode:\"0000000000\",params:{exampleName:\""+exampleName+"\",exampleValue:\""+exampleValue+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String updateExample(String exampleId , String exampleName , String exampleValue) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0012\",securityCode:\"0000000000\",params:{exampleId:\""+exampleId+"\",exampleName:\""+exampleName+"\",exampleValue:\""+exampleValue+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String queryExample(Integer start ,Integer rownum) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0013\",securityCode:\"0000000000\",params:{start:\""+start+"\",rownum:\""+rownum+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String delExample(String exampleId) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0014\",securityCode:\"0000000000\",params:{exampleId:\""+exampleId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
}