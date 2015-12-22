package com.rise.service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;
import java.util.TimeZone;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.rise.model.ShortClassAttendT;
import com.rise.model.ShortClassInstT;
import com.rise.model.ShortClassTeacherT;
import com.rise.model.ShortSchooltimeT;
import com.rise.pub.base.JacksonJsonMapper;
import com.rise.pub.invoke.ServiceEngine;
import com.rise.pub.util.StringUtil;

@Service
public class ShortBusinessService 
{
	
	public String getShortClassTypeList(String typeName) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2051\",securityCode:\"0000000000\",params:{typeName:\""+typeName+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String getShortClassInstTList(String typeName , String classTypeId) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2052\",securityCode:\"0000000000\",params:{typeName:\""+typeName+"\",classTypeId:\""+classTypeId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public void getShortClassInfo(ModelAndView model , String shortClassInstId , String funcNodeId) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2053\",securityCode:\"0000000000\",params:{shortClassInstId:\""+shortClassInstId+"\"},rtnDataFormatType:\"user-defined\"}";
		String result = ServiceEngine.invokeHttp(params);
		try{
			ShortClassInstT shortClassInstT = JacksonJsonMapper.getInstance().readValue(result.toString(), ShortClassInstT.class);
			model.addObject("shortClassInstT", shortClassInstT);
			model.addObject("funcNodeId", funcNodeId);
		}catch(Exception err){
			err.printStackTrace();
			model.addObject("ErrorInfo", err.getMessage());
		}
	}
	
	public void getAddShortClassInfo(ModelAndView model , String shortClassInstId , String funcNodeId) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2054\",securityCode:\"0000000000\",params:{shortClassInstId:\""+shortClassInstId+"\"},rtnDataFormatType:\"user-defined\"}";
		String result = ServiceEngine.invokeHttp(params);
		try
		{
			JSONObject obj = JSONObject.fromObject(result);
			model.addObject("shortClassInstId", StringUtil.getJSONObjectKeyVal(obj, "shortClassInstId"));
			JSONArray jsonArr = obj.getJSONArray("shortClassList");
			if(jsonArr.size() != 0)
			{
				ObjectMapper mapper = JacksonJsonMapper.getInstance();
				JavaType javaType = mapper.getTypeFactory().constructParametricType(ArrayList.class, ShortSchooltimeT.class);
				List shortClassList = mapper.readValue(jsonArr.toString(), javaType);
				model.addObject("shortClassList", shortClassList);
			}
			else
			{
				model.addObject("shortClassList", new ArrayList<ShortSchooltimeT>());
			}
			model.addObject("funcNodeId", funcNodeId);
		}
		catch(Exception err)
		{			
			err.printStackTrace();
			model.addObject("ErrorInfo", err.getMessage());
		}
	}
	
	public String addShortSchooltimeTInfo(String json) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2055\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String addShortClassInstTInfo(String json , String className) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2056\",securityCode:\"0000000000\",params:{json:'"+json+"',className:\""+className+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String delShortSchooltimeTInfo(String shortSchooltimeId) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2057\",securityCode:\"0000000000\",params:{shortSchooltimeId:'"+shortSchooltimeId+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String cancelShortClassFunc(String shortClassInstId , String remark) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2058\",securityCode:\"0000000000\",params:{shortClassInstId:\""+shortClassInstId+"\",remark:\""+remark+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String addShortStudentTInfo(String json) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2059\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String delShortStudentList(String shortClassInstId , String studentIds , String handlerId) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20510\",securityCode:\"0000000000\",params:{shortClassInstId:\""+shortClassInstId+"\",studentIds:\""+studentIds+"\",handlerId:\""+handlerId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String updateShortClassInstTInfo(String json) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20511\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public void getShortClassAttendTInfo(ModelAndView model , String shortClassInstId , String funcNodeId , String pageName) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20512\",securityCode:\"0000000000\",params:{shortClassInstId:\""+shortClassInstId+"\"},rtnDataFormatType:\"user-defined\"}";
		String result = ServiceEngine.invokeHttp(params);
		try
		{
			JSONObject obj = JSONObject.fromObject(result);
			ShortClassInstT shortClassInstT = JacksonJsonMapper.getInstance().readValue(obj.getJSONObject("shortClassInstT").toString(), ShortClassInstT.class);
			ShortSchooltimeT shortSchooltimeT = JacksonJsonMapper.getInstance().readValue(obj.getJSONObject("shortSchooltimeT").toString(), ShortSchooltimeT.class);
			model.addObject("hourRangeList", obj.getJSONArray("hourRangeList"));
			model.addObject("roomList", obj.getJSONArray("roomList"));
			model.addObject("schoolList", obj.getJSONArray("schoolList"));
			model.addObject("teacherTypeList", obj.getJSONArray("teacherTypeList"));
			model.addObject("shortClassInstT", shortClassInstT);
			model.addObject("shortSchooltimeT", shortSchooltimeT);
			model.addObject("funcNodeId", funcNodeId);
			model.addObject("pageName", pageName);
		}
		catch(Exception err)
		{
			err.printStackTrace();
			model.addObject("ErrorInfo", err.getMessage());
		}
	}
	
	public void shortAttenceDetailPage(ModelAndView model , String shortClassInstId , String funcNodeId) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20514\",securityCode:\"0000000000\",params:{shortClassInstId:\""+shortClassInstId+"\"},rtnDataFormatType:\"user-defined\"}";
		String result = ServiceEngine.invokeHttp(params);
		try{
			JSONObject json = JSONObject.fromObject(result);
			ShortClassInstT shortClassInstT = JacksonJsonMapper.getInstance().readValue(json.getJSONObject("shortClassInstT").toString(), ShortClassInstT.class);
			ObjectMapper mapper = JacksonJsonMapper.getInstance();
			JavaType javaType = mapper.getTypeFactory().constructParametricType(ArrayList.class, ShortClassAttendT.class);
			List<ShortClassAttendT> shortClassAttendTList = mapper.readValue(json.getJSONArray("shortClassAttendTList").toString(), javaType);
			model.addObject("shortClassInstT", shortClassInstT);
			model.addObject("shortClassAttendTList", shortClassAttendTList);
			model.addObject("funcNodeId", funcNodeId);
		}catch(Exception err){
			err.printStackTrace();
			model.addObject("ErrorInfo", err.getMessage());
		}
	}
	
	public String addShortAttendTInfo(String json) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20513\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public void shortAttenceUpdatePage(ModelAndView model , String shortClassAttendId , String funcNodeId , String pageName) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20515\",securityCode:\"0000000000\",params:{shortClassAttendId:\""+shortClassAttendId+"\"},rtnDataFormatType:\"user-defined\"}";
		String result = ServiceEngine.invokeHttp(params);
		try{
			JSONObject obj = JSONObject.fromObject(result);
			ShortClassAttendT shortClassAttendT = JacksonJsonMapper.getInstance().readValue(obj.getJSONObject("shortClassAttendT").toString(), ShortClassAttendT.class);
			model.addObject("hourRangeList", obj.getJSONArray("hourRangeList"));
			model.addObject("roomList", obj.getJSONArray("roomList"));
			model.addObject("schoolList", obj.getJSONArray("schoolList"));
			model.addObject("teacherTypeList", obj.getJSONArray("teacherTypeList"));
			model.addObject("shortClassAttendT", shortClassAttendT);
			model.addObject("funcNodeId", funcNodeId);
			model.addObject("pageName", pageName);
		}catch(Exception err){
			err.printStackTrace();
			model.addObject("ErrorInfo", err.getMessage());
		}
	}
	
	public void shortAttenceViewPage(ModelAndView model , String shortClassAttendId , String funcNodeId , String pageName) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20516\",securityCode:\"0000000000\",params:{shortClassAttendId:\""+shortClassAttendId+"\"},rtnDataFormatType:\"user-defined\"}";
		String result = ServiceEngine.invokeHttp(params);
		try{
			ShortClassAttendT shortClassAttendT = JacksonJsonMapper.getInstance().readValue(result, ShortClassAttendT.class);
			model.addObject("shortClassAttendT", shortClassAttendT);
			model.addObject("funcNodeId", funcNodeId);
			model.addObject("pageName", pageName);
		}catch(Exception err){
			err.printStackTrace();
			model.addObject("ErrorInfo", err.getMessage());
		}
	}
	
	public String updateShortAttendTInfo(String json) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20517\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String addTourismClassInfo(String json) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20518\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public void accessShortClassPage(ModelAndView model , String shortClassInstId , String funcNodeId , String classType) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20519\",securityCode:\"0000000000\",params:{shortClassInstId:\""+shortClassInstId+"\",classType:\""+classType+"\"},rtnDataFormatType:\"user-defined\"}";
		String result = ServiceEngine.invokeHttp(params);
		try{
			JSONObject obj = JSONObject.fromObject(result);
			ShortClassInstT shortClassInstT = JacksonJsonMapper.getInstance().readValue(obj.getJSONObject("shortClassInstT").toString(), ShortClassInstT.class);
			ObjectMapper mapper = JacksonJsonMapper.getInstance();
			JavaType javaType = mapper.getTypeFactory().constructParametricType(ArrayList.class, ShortClassTeacherT.class);
			List<ShortClassTeacherT> shortClassTeacherTList = mapper.readValue(obj.getJSONArray("shortClassTeacherTList").toString(), javaType);
			model.addObject("shortClassInstId", StringUtil.getJSONObjectKeyVal(obj, "shortClassInstId"));
			model.addObject("shortClassId", StringUtil.getJSONObjectKeyVal(obj, "shortClassId"));
			model.addObject("shortClassInstT", shortClassInstT);
			model.addObject("shortClassTeacherTList", shortClassTeacherTList);
			model.addObject("funcNodeId", funcNodeId);
		}catch(Exception err){
			err.printStackTrace();
			model.addObject("ErrorInfo", err.getMessage());
		}
	}
	
	public void accessShortAttenceDetail(ModelAndView model , String shortClassInstId , String funcNodeId) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20514\",securityCode:\"0000000000\",params:{shortClassInstId:\""+shortClassInstId+"\"},rtnDataFormatType:\"user-defined\"}";
		String result = ServiceEngine.invokeHttp(params);
		try{
			JSONObject obj = JSONObject.fromObject(result);
			ShortClassInstT shortClassInstT = JacksonJsonMapper.getInstance().readValue(obj.getJSONObject("shortClassInstT").toString(), ShortClassInstT.class);
			ObjectMapper mapper = JacksonJsonMapper.getInstance();
			JavaType javaType = mapper.getTypeFactory().constructParametricType(ArrayList.class, ShortClassAttendT.class);
			List<ShortClassAttendT> shortClassAttendTList = mapper.readValue(obj.getJSONArray("shortClassAttendTList").toString(), javaType);
			model.addObject("shortClassInstT", shortClassInstT);
			model.addObject("shortClassAttendTList", shortClassAttendTList);
			model.addObject("funcNodeId", funcNodeId);
		}catch(Exception err){
			err.printStackTrace();
			model.addObject("ErrorInfo", err.getMessage());
		}
	}
	
	public void tourismAttenceRecordPage(ModelAndView model , String shortClassInstId , String funcNodeId) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20520\",securityCode:\"0000000000\",params:{shortClassInstId:\""+shortClassInstId+"\"},rtnDataFormatType:\"user-defined\"}";
		String result = ServiceEngine.invokeHttp(params);
		try{
			JSONObject obj = JSONObject.fromObject(result);
			ShortClassInstT shortClassInstT = JacksonJsonMapper.getInstance().readValue(obj.getJSONObject("shortClassInstT").toString(), ShortClassInstT.class);
			ObjectMapper mapper = JacksonJsonMapper.getInstance();
			JavaType javaType = mapper.getTypeFactory().constructParametricType(ArrayList.class, ShortClassTeacherT.class);
			List<ShortClassTeacherT> shortClassTeacherTList = mapper.readValue(obj.getJSONArray("shortClassTeacherTList").toString(), javaType);
			model.addObject("schoolList", obj.getJSONArray("schoolList"));
			model.addObject("shortClassInstT", shortClassInstT);
			model.addObject("shortClassTeacherTList", shortClassTeacherTList);
			model.addObject("funcNodeId", funcNodeId);
		}catch(Exception err){
			err.printStackTrace();
			model.addObject("ErrorInfo", err.getMessage());
		}
	}
	
	public String addShortTourismAttendTInfo(String json) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20521\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public void tourismAttenceRecUpdatePage(ModelAndView model , String shortClassAttendId , String funcNodeId) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20522\",securityCode:\"0000000000\",params:{shortClassAttendId:\""+shortClassAttendId+"\"},rtnDataFormatType:\"user-defined\"}";
		String result = ServiceEngine.invokeHttp(params);
		try{
			JSONObject obj = JSONObject.fromObject(result);
			ShortClassInstT shortClassInstT = JacksonJsonMapper.getInstance().readValue(obj.getJSONObject("shortClassInstT").toString(), ShortClassInstT.class);
			ShortClassAttendT shortClassAttendT = JacksonJsonMapper.getInstance().readValue(obj.getJSONObject("shortClassAttendT").toString(), ShortClassAttendT.class);
			model.addObject("schoolList", obj.getJSONArray("schoolList"));
			model.addObject("shortClassInstT", shortClassInstT);
			model.addObject("shortClassAttendT", shortClassAttendT);
			model.addObject("funcNodeId", funcNodeId);
		}catch(Exception err){
			err.printStackTrace();
			model.addObject("ErrorInfo", err.getMessage());
		}
	}
	
	public String updateShortTourismAttenceInfo(String json) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20523\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String verifyShortClassFunc(String shortClassInstId , String handlerId , String isPutClass , String verifyCont) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20524\",securityCode:\"0000000000\",params:{shortClassInstId:'"+shortClassInstId+"',handlerId:\""+handlerId+"\",isPutClass:\""+isPutClass+"\",verifyCont:\""+verifyCont+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
}
