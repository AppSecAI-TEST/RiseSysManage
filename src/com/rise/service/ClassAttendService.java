package com.rise.service;

import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.rise.model.CalendarItem;
import com.rise.model.ClassAttendT;
import com.rise.model.ClassInstT;
import com.rise.model.SchooltimeInstT;
import com.rise.pub.base.JacksonJsonMapper;
import com.rise.pub.invoke.ServiceEngine;
import com.rise.pub.util.StringUtil;

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
	
	public void getAttenceRecord(ModelAndView model , String schooltimeInstId , String funcNodeId , String selDateStr) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2043\",securityCode:\"0000000000\",params:{schooltimeInstId:\""+schooltimeInstId+"\"},rtnDataFormatType:\"user-defined\"}";
		String result = ServiceEngine.invokeHttp(param);
		try{
			JSONObject json = JSONObject.fromObject(result);
			SchooltimeInstT schooltimeInstT = (SchooltimeInstT)JacksonJsonMapper.getInstance().readValue(json.getJSONObject("schooltimeInstT").toString(), SchooltimeInstT.class);
			ObjectMapper mapper = JacksonJsonMapper.getInstance();
			JavaType javaType = mapper.getTypeFactory().constructParametricType(ArrayList.class, SchooltimeInstT.class);
			List teacherTimeInstList = (List)mapper.readValue(json.getJSONArray("teacherTimeInstList").toString(), javaType);
			model.addObject("isFirstFlag", StringUtil.getJSONObjectKeyVal(json, "isFirstFlag"));
			model.addObject("schooltimeInstT", schooltimeInstT);
			model.addObject("teacherTimeInstList", teacherTimeInstList);
			model.addObject("hourRangeList", json.getJSONArray("hourRangeList"));
			model.addObject("roomList", json.getJSONArray("roomList"));
			model.addObject("schoolList", json.getJSONArray("schoolList"));
			model.addObject("teacherList", json.getJSONArray("teacherList"));
			model.addObject("teacherTypeList", json.getJSONArray("teacherTypeList"));
		}catch(Exception err){
			err.printStackTrace();
			model.addObject("errorInfo", err.getMessage());
		}
		model.addObject("selDateStr", selDateStr);
		model.addObject("funcNodeId", funcNodeId);
	}
	
	public String addAttend(String json) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2044\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public void showAttenceRecord(ModelAndView model , String classAttendId , String classInstId , String funcNodeId , String selDateStr , String comeFlag) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2045\",securityCode:\"0000000000\",params:{classAttendId:\""+classAttendId+"\"},rtnDataFormatType:\"user-defined\"}";
		String result = ServiceEngine.invokeHttp(param);
		try{
			JSONObject json = JSONObject.fromObject(result);
			ClassAttendT classAttendT = JacksonJsonMapper.getInstance().readValue(json.toString(), ClassAttendT.class);
			model.addObject("classAttendT", classAttendT);
			model.addObject("classInstId", classInstId);
			model.addObject("funcNodeId", funcNodeId);
			model.addObject("selDateStr", selDateStr);
			model.addObject("comeFlag", comeFlag);
		}catch(Exception err){
			err.printStackTrace();
			model.addObject("errorInfo", err.getMessage());
		}
	}
	
	public void getUpdateAttenceRecord(ModelAndView model , String classAttendId , String funcNodeId , String selDateStr) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2046\",securityCode:\"0000000000\",params:{classAttendId:\""+classAttendId+"\"},rtnDataFormatType:\"user-defined\"}";
		String result = ServiceEngine.invokeHttp(param);
		try{
			JSONObject json = JSONObject.fromObject(result);
			model.addObject("hourRangeList", json.getJSONArray("hourRangeList"));
			model.addObject("roomList", json.getJSONArray("roomList"));
			model.addObject("schoolList", json.getJSONArray("schoolList"));
			model.addObject("teacherList", json.getJSONArray("teacherList"));
			model.addObject("teacherTypeList", json.getJSONArray("teacherTypeList"));
			json.remove("hourRangeList");
			json.remove("roomList");
			json.remove("schoolList");
			json.remove("teacherList");
			json.remove("teacherTypeList");
			ClassAttendT classAttendT = JacksonJsonMapper.getInstance().readValue(json.toString(), ClassAttendT.class);
			model.addObject("classAttendT", classAttendT);
			model.addObject("funcNodeId", funcNodeId);
			model.addObject("selDateStr", selDateStr);
		}catch(Exception err){
			err.printStackTrace();
			model.addObject("errorInfo", err.getMessage());
		}
	}
	
	public String updateAttend(String json) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2047\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
}
