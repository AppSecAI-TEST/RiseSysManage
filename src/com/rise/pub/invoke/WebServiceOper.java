package com.rise.pub.invoke;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.rise.pub.base.JacksonJsonMapper;
import com.rise.pub.util.StringUtil;

/**
 * 
 * @author : tiankang
 * ������
 */
public class WebServiceOper
{
	/**
	 * @author : tiankang
	 * @param param
	 * @return
	 * @throws Exception
	 * ��WebService���񲢽������List����ʽ����
	 */
	public static List getServiceList(String param) throws Exception
	{
		List list = new ArrayList();
		String recParam = ServiceEngine.invokeService(param);
		JSONObject recObj = JSONObject.fromObject(recParam);
		String executeType = StringUtil.getJSONObjectKeyVal(recObj, "executeType");
		if("success".equals(executeType))
		{
			JSONArray arrJson = JSONArray.fromObject(StringUtil.getJSONObjectKeyVal(recObj, "returnMsg"));
			list = JacksonJsonMapper.getInstance().readValue(arrJson.toString(), List.class);
			return list;
		}
		else
		{
			return null;
		}
	}
	
	/**
	 * @author : tiankang
	 * @param param
	 * @return
	 * @throws Exception
	 * ��WebService���񲢽������Object����
	 */
	public static Object getServiceObj(String param) throws Exception
	{
		String recParam = ServiceEngine.invokeService(param);
		JSONObject recObj =JSONObject.fromObject(recParam);
		String executeType = StringUtil.getJSONObjectKeyVal(recObj, "executeType");
		if("success".equals(executeType))
		{
			JSONObject objJson = JSONObject.fromObject(StringUtil.getJSONObjectKeyVal(recObj, "returnMsg"));
			Object obj = JacksonJsonMapper.getInstance().readValue(objJson.toString(), Object.class);
			return obj;
		}
		else
		{
			return null;
		}
	}
	
	/**
	 * @author : tiankang
	 * @param param
	 * @return
	 * @throws Exception
	 * ��WebService���񲢽������Map����
	 */
	public static Map getServiceMap(String param) throws Exception
	{
		Map map = new HashMap();
		String recParam = ServiceEngine.invokeService(param);
		JSONObject recObj =JSONObject.fromObject(recParam);
		String executeType = StringUtil.getJSONObjectKeyVal(recObj, "executeType");
		if("success".equals(executeType))
		{
			JSONObject objJson = JSONObject.fromObject(StringUtil.getJSONObjectKeyVal(recObj, "returnMsg"));
			for(Object object : objJson.entrySet())
			{
				Map.Entry entry = (Map.Entry)object;
				map.put(entry.getKey(), entry.getValue());
			}
			return map;
		}
		else
		{
			return null;
		}
	}
	
	/**
	 * @author : tiankang
	 * @param param
	 * @return
	 * @throws Exception
	 * ��webservice���񲢽������String����
	 */
	public static String getServiceStr(String param) throws Exception
	{
		String recParam = ServiceEngine.invokeService(param);
		JSONObject recObj =JSONObject.fromObject(recParam);
		String executeType = StringUtil.getJSONObjectKeyVal(recObj, "executeType");
		if("success".equals(executeType))
		{
			return StringUtil.getJSONObjectKeyVal(recObj, "returnMsg");
		}
		else
		{
			return null;
		}
	}
}
