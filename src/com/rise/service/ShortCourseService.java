package com.rise.service;

import org.springframework.stereotype.Service;

import com.rise.pub.invoke.ServiceEngine;

@Service
public class ShortCourseService {

	//新增短期课
	public String addShortClass(String json)throws Exception{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1701\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//删除短期课
	public String deleteShortClass(String shortClassId)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1702\",securityCode:\"0000000000\",params:{shortClassId:'"+shortClassId+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	//新增短期课班级类型
	public String addShortClassType(String json)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1703\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//修改短期课班级类型
	public String updateShortClassType(String json)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1704\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//删除短期课班级类型
	public String deleteShortClassType(String classTypeId)throws Exception{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1705\",securityCode:\"0000000000\",params:{classTypeId:'"+classTypeId+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

}
