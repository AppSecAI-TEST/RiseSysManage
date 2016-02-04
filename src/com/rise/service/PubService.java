package com.rise.service;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;

import com.rise.pub.invoke.ServiceEngine;
import com.rise.pub.util.ObjectCensor;
import com.rise.pub.util.StringUtil;

@Service
public class PubService 
{
	public String pageCategory(String staffId , Map paramMap , String fieldId , HttpSession session) throws Exception
	{
		if("schoolId".equals(fieldId))
		{
			String result = (String)session.getAttribute("privSchoolInfo");
			if(ObjectCensor.isStrRegular(result))
			{
				return result;
			}
			else
			{
				result = pageCategoryInvoke(paramMap);
				session.setAttribute("privSchoolInfo", result);
				return result;
			}
		}
		else if(!ObjectCensor.isStrRegular(fieldId))
		{
			String funcNodeId = StringUtil.getMapKeyVal(paramMap , "funcNodeId");
			Map<String,String> map = (Map<String,String>)session.getAttribute("privNodeInfo");
			if(ObjectCensor.checkObjectIsNull(map))
			{
				map = new HashMap<String,String>();
			}
			if(map.containsKey(funcNodeId))
			{
				return map.get(funcNodeId);
			}
			else
			{
				String result = pageCategoryInvoke(paramMap);
				map.put(funcNodeId, result);
				session.setAttribute("privNodeInfo", map);
				return result;
			}
		}
		else
		{
			return pageCategoryInvoke(paramMap);
		}
	}
	
	private String pageCategoryInvoke(Map paramMap) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2011\",securityCode:\"0000000000\",params:{json:'"+convertParam(paramMap).toString()+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	private JSONObject convertParam(Map<String,String[]> paramMap)
	{
		JSONObject json = new JSONObject();
		for(Map.Entry<String, String[]> entry : paramMap.entrySet())
		{
			String key = entry.getKey();
			String[] value = entry.getValue();
			if(value.length > 0)
			{
				json.put(key, value[0]);
			}
		}
		return json;
	}
	
	public String pageComboxList(String funcNodeId , String fieldId) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2012\",securityCode:\"0000000000\",params:{funcNodeId:\""+funcNodeId+"\",fieldId:\""+fieldId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String paramComboxList(Map<String,String[]> paramMap) throws Exception
	{
		JSONObject obj = new JSONObject();
		for(String key : paramMap.keySet())
		{
			obj.put(key, paramMap.get(key)[0]);
		}
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2013\",securityCode:\"0000000000\",params:{json:'"+obj.toString()+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
}
