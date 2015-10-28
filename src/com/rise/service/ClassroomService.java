package com.rise.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.rise.model.FuncNodeTree;
import com.rise.model.StaffT;
import com.rise.pub.base.JacksonJsonMapper;
import com.rise.pub.invoke.ServiceEngine;

@Service
public class ClassroomService 
{
	public String addClassroom(String params) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS3042\",securityCode:\"0000000000\",params:{param:"+params+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String updateClassroom(String params) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS3043\",securityCode:\"0000000000\",params:{param:"+params+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String deleteClassroom(String roomId) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS3044\",securityCode:\"0000000000\",params:{roomId:\""+roomId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String getClassroomInfo(String roomId) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS3045\",securityCode:\"0000000000\",params:{roomId:\""+roomId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
}

