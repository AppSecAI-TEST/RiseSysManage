package com.rise.service;


import org.springframework.stereotype.Service;

import com.rise.pub.invoke.ServiceEngine;

@Service
public class DemoClassService 
{
	public String qryDemoInfo(String shortClassInstId,String classState) throws Exception
	{
		String busCode ="BUS3301";
		if(!"001".equals(classState))
		{
			busCode ="BUS3302";
		}	
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\""+busCode+"\",securityCode:\"0000000000\",params:{shortClassInstId:\""+shortClassInstId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String feedBack(String classState,String params) throws Exception
	{
		String busCode ="BUS3303";
		if(!"001".equals(classState))
		{
			busCode ="BUS3304";
		}	
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\""+busCode+"\",securityCode:\"0000000000\",params:{param:"+params+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String addStuFeedback(String params) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS3305\",securityCode:\"0000000000\",params:{param:"+params+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	
	public String qryStuFeedbackInfo(String shortClassInstId) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS3306\",securityCode:\"0000000000\",params:{shortClassInstId:\""+shortClassInstId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String deleteStuFeedback(String studentLinkId) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS3307\",securityCode:\"0000000000\",params:{studentLinkId:\""+studentLinkId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String getStuFeedback(String studentLinkId) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS3308\",securityCode:\"0000000000\",params:{studentLinkId:\""+studentLinkId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String qryDemoDetailInfo(String shortClassInstId,String classState) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS3309\",securityCode:\"0000000000\",params:{shortClassInstId:\""+shortClassInstId+"\",classState:\""+classState+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
}


