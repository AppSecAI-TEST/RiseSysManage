package com.rise.service;

import org.springframework.stereotype.Service;

import com.rise.pub.invoke.ServiceEngine;

@Service
public class SysCacheService 
{

	public String flushCache(String cacheName) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2071\",securityCode:\"0000000000\",params:{cacheName:\""+cacheName+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String flushAllCache() throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2072\",securityCode:\"0000000000\",params:{},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String sysCacheList(Integer page, Integer rows) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2073\",securityCode:\"0000000000\",params:{page:\""+page+"\",rows:\""+rows+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
}
