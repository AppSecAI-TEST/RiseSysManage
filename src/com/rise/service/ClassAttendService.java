package com.rise.service;

import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.rise.model.CalendarItem;
import com.rise.model.ClassInstT;
import com.rise.model.FuncNodeTree;
import com.rise.model.StaffT;
import com.rise.pub.base.JacksonJsonMapper;
import com.rise.pub.invoke.ServiceEngine;

@Service
public class ClassAttendService 
{
	public void getAttendDetail(ModelAndView model , String classInstId , String funcNodeId) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2041\",securityCode:\"0000000000\",params:{classInstId:\""+classInstId+"\"},rtnDataFormatType:\"user-defined\"}";
		String result = ServiceEngine.invokeHttp(param);
		JSONObject json = JSONObject.fromObject(result);
		ObjectMapper mapper = JacksonJsonMapper.getInstance();
		String statistics = json.getJSONArray("classAttendStatistics").toString();
		model.addObject("statistics", statistics);
		json.remove("classAttendStatistics");
		ClassInstT classInstT = (ClassInstT)mapper.readValue(json.toString() , ClassInstT.class);
		model.addObject("classInstT", classInstT);
		model.addObject("funcNodeId", funcNodeId);
	}
	
	public void getAttendOperate(ModelAndView model , String classInstId , String funcNodeId , String selDateStr) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2042\",securityCode:\"0000000000\",params:{classInstId:\""+classInstId+"\",selDateStr:\""+selDateStr+"\"},rtnDataFormatType:\"user-defined\"}";
		String result = ServiceEngine.invokeHttp(param);
		try{
			JSONObject json = JSONObject.fromObject(result);
			ObjectMapper mapper = JacksonJsonMapper.getInstance();
			JavaType javaType = mapper.getTypeFactory().constructParametricType(ArrayList.class, CalendarItem.class);
			List calendarInfo = (List)mapper.readValue(json.getJSONArray("calendarInfo").toString(), javaType);
			model.addObject("calendarInfo", calendarInfo);
			model.addObject("classAttendInfo", json.getJSONArray("classAttendInfo"));
		}catch(Exception err){
			err.printStackTrace();
			model.addObject("errorInfo", err.getMessage());
		}
		model.addObject("selDateStr", selDateStr);
		model.addObject("classInstId", classInstId);
		model.addObject("funcNodeId", funcNodeId);
	}
}
