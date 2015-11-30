package com.rise.service;

import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.rise.model.FuncNodeTree;
import com.rise.model.ShortClassInstT;
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
	
	public String addShortClassInstTInfo(String json) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2056\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
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
	
}
