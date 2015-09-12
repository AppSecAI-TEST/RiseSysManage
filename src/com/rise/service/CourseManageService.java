package com.rise.service;

import org.springframework.stereotype.Service;

import com.rise.pub.invoke.ServiceEngine;

@Service
public class CourseManageService {

	public String qryCourseInfo(Integer pageNumInt,Integer pageSizeInt,String json)throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1101\",securityCode:\"0000000000\",params:{pageNumInt:\""+pageNumInt+"\",pageSizeInt:\""+pageSizeInt+"\",json:\'"+json+"\'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
}
