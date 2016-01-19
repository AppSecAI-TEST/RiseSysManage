package com.rise.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.rise.model.AttStudentObj;
import com.rise.model.CalendarItem;
import com.rise.model.ClassAttendT;
import com.rise.model.ClassInstT;
import com.rise.model.SchooltimeInstT;
import com.rise.pub.base.JacksonJsonMapper;
import com.rise.pub.invoke.ServiceEngine;
import com.rise.pub.util.ObjectCensor;
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
		String classProgressInfo = StringUtil.getJSONObjectKeyVal(json, "classProgressInfo");
		model.addObject("statistics", statistics);
		model.addObject("classProgressInfo", classProgressInfo);
		json.remove("classAttendStatistics");
		json.remove("classProgressInfo");
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
	
	public void getAttenceRecord(ModelAndView model , String schooltimeInstId , String funcNodeId , String selDateStr , String dateValue) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2043\",securityCode:\"0000000000\",params:{schooltimeInstId:\""+schooltimeInstId+"\"},rtnDataFormatType:\"user-defined\"}";
		String result = ServiceEngine.invokeHttp(param);
		try{
			JSONObject json = JSONObject.fromObject(result);
			SchooltimeInstT schooltimeInstT = (SchooltimeInstT)JacksonJsonMapper.getInstance().readValue(json.getJSONObject("schooltimeInstT").toString(), SchooltimeInstT.class);
			ClassInstT classInstT = (ClassInstT)JacksonJsonMapper.getInstance().readValue(json.getJSONObject("classInstT").toString(), ClassInstT.class);
			ObjectMapper mapper = JacksonJsonMapper.getInstance();
			JavaType javaType = mapper.getTypeFactory().constructParametricType(ArrayList.class, SchooltimeInstT.class);
			List schooltimeInstTList = (List)mapper.readValue(json.getJSONArray("schooltimeInstTList").toString(), javaType);
			model.addObject("isFirstFlag", StringUtil.getJSONObjectKeyVal(json, "isFirstFlag"));
			model.addObject("schooltimeInstT", schooltimeInstT);
			model.addObject("schooltimeInstTList", schooltimeInstTList);
			model.addObject("classInstT", classInstT);
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
		if(ObjectCensor.isStrRegular(dateValue))
		{
			if(dateValue.length() == 1)
			{
				dateValue = "0"+dateValue;
			}
			model.addObject("dateValue", dateValue);
		}
		model.addObject("funcNodeId", funcNodeId);
	}
	
	public void getAttenceRecordInst(ModelAndView model , String classInstId , String funcNodeId , String selDateStr , String dateValue) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2049\",securityCode:\"0000000000\",params:{classInstId:\""+classInstId+"\",selDateStr:\""+selDateStr+"\",dateValue:\""+dateValue+"\"},rtnDataFormatType:\"user-defined\"}";
		String result = ServiceEngine.invokeHttp(param);
		try
		{
			JSONObject json = JSONObject.fromObject(result);
			ClassInstT classInstT = (ClassInstT)JacksonJsonMapper.getInstance().readValue(json.getJSONObject("classInstT").toString(), ClassInstT.class);
			model.addObject("isFirstFlag", StringUtil.getJSONObjectKeyVal(json, "isFirstFlag"));
			model.addObject("classSchooltime", StringUtil.getJSONObjectKeyVal(json, "classSchooltime"));
			model.addObject("classWeekTime", StringUtil.getJSONObjectKeyVal(json, "classWeekTime"));
			model.addObject("classInstT", classInstT);
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
			model.addObject("stageId", StringUtil.getJSONObjectKeyVal(json, "stageId"));
			json.remove("hourRangeList");
			json.remove("roomList");
			json.remove("schoolList");
			json.remove("teacherList");
			json.remove("teacherTypeList");
			json.remove("stageId");
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
	
	public String convertClassOpenType(String classInstId) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2048\",securityCode:\"0000000000\",params:{classInstId:'"+classInstId+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public void getAttenceCalendarView(ModelAndView model , String classInstId , String year , String month , String funcNodeId) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20410\",securityCode:\"0000000000\",params:{classInstId:\""+classInstId+"\",year:\""+year+"\",month:\""+month+"\"},rtnDataFormatType:\"user-defined\"}";
		String result = ServiceEngine.invokeHttp(param);
		try{
			JSONObject json = JSONObject.fromObject(result);
			ObjectMapper mapper = JacksonJsonMapper.getInstance();
			JavaType javaType = mapper.getTypeFactory().constructParametricType(ArrayList.class, CalendarItem.class);
			List calendarInfo = (List)mapper.readValue(json.getJSONArray("calendarInfo").toString(), javaType);
			model.addObject("calendarInfo", calendarInfo);
			model.addObject("yearMonthInfo", json.getJSONArray("yearMonthInfo").toString());
			model.addObject("selDateStr", StringUtil.getJSONObjectKeyVal(json, "selDateStr"));
			model.addObject("year", StringUtil.getJSONObjectKeyVal(json, "year"));
			model.addObject("month", StringUtil.getJSONObjectKeyVal(json, "month"));
			model.addObject("classInstId", classInstId);
			model.addObject("funcNodeId", funcNodeId);
		}catch(Exception err){
			err.printStackTrace();
			model.addObject("errorInfo", err.getMessage());
		}
	}
	
	public void getClassStudentAttenceInfo(ModelAndView model , String classInstId  , String monthDate) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20411\",securityCode:\"0000000000\",params:{classInstId:\""+classInstId+"\",monthDate:\""+monthDate+"\"},rtnDataFormatType:\"user-defined\"}";
		String result = ServiceEngine.invokeHttp(param);
		try{
			ObjectMapper mapper = JacksonJsonMapper.getInstance();
			JavaType javaType = mapper.getTypeFactory().constructParametricType(ArrayList.class, AttStudentObj.class);
			List attStudentList = (List)mapper.readValue(result, javaType);
			model.addObject("attStudentList", attStudentList);
			model.addObject("classInstId", classInstId);
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
			Date month = sdf.parse(monthDate);
			model.addObject("monthDateStr", monthDate);
			model.addObject("monthDate", month);
			Calendar cal = Calendar.getInstance();
	        cal.setTime(month);
	        int maxDay=cal.getActualMaximum(Calendar.DAY_OF_MONTH);
	        model.addObject("maxDay", maxDay);
		}catch(Exception err){
			err.printStackTrace();
			model.addObject("errorInfo", err.getMessage());
		}
	}
	
	public void uploadLeavePage(ModelAndView model , String studentId , String funcNodeId) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20412\",securityCode:\"0000000000\",params:{studentId:\""+studentId+"\"},rtnDataFormatType:\"user-defined\"}";
		String result = ServiceEngine.invokeHttp(param);
		try{
			model.addObject("makeupInfo", result);
			model.addObject("studentId", studentId);
			model.addObject("funcNodeId", funcNodeId);
		}catch(Exception err){
			err.printStackTrace();
			model.addObject("errorInfo", err.getMessage());
		}
	}
	
	public void uploadLeaveDetailPage(ModelAndView model , String classAttendId , String studentId , String funcNodeId) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2045\",securityCode:\"0000000000\",params:{classAttendId:\""+classAttendId+"\"},rtnDataFormatType:\"user-defined\"}";
		String result = ServiceEngine.invokeHttp(param);
		try{
			ClassAttendT classAttendT = JacksonJsonMapper.getInstance().readValue(result, ClassAttendT.class);
			model.addObject("classAttendT", classAttendT);
			model.addObject("studentId", studentId);
			model.addObject("funcNodeId", funcNodeId);
		}catch(Exception err){
			err.printStackTrace();
			model.addObject("errorInfo", err.getMessage());
		}
	}
	
	public String uploadLeaveOper(String json) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20413\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public void commitMakeupDetailPage(ModelAndView model , String classAttendId , String studentAttendId , String studentId , String attendType , String interval , String funcNodeId) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20414\",securityCode:\"0000000000\",params:{classAttendId:\""+classAttendId+"\",studentAttendId:\""+studentAttendId+"\",studentId:\""+studentId+"\",attendType:\""+attendType+"\",interval:\""+interval+"\"},rtnDataFormatType:\"user-defined\"}";
		String result = ServiceEngine.invokeHttp(param);
		try{
			JSONObject json = JSONObject.fromObject(result);
			model.addObject("classHours", json.getJSONArray("classHours"));
			model.addObject("hourRangeArr", json.getJSONArray("hourRangeArr"));
			json.remove("classHours");
			json.remove("hourRangeArr");
			ClassAttendT classAttendT = JacksonJsonMapper.getInstance().readValue(json.toString(), ClassAttendT.class);
			model.addObject("classAttendT", classAttendT);
			model.addObject("studentAttendId", studentAttendId);
			model.addObject("studentId", studentId);
			model.addObject("funcNodeId", funcNodeId);
		}catch(Exception err){
			err.printStackTrace();
			model.addObject("errorInfo", err.getMessage());
		}
	}
	
	public String addStudentMakeupInfo(String json) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20415\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
}
