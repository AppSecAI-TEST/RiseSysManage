package com.rise.pub.util;

import java.util.List;

import com.rise.pub.exception.JsonException;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.util.JSONUtils;

/**
 * json转java对象
 * @author RHQ
 *
 */
public class JsonUtils
{
	/**
	 * json转JavaBean
	 * @param jsonStr
	 * @param beanClass
	 * @return
	 * @throws JsonException
	 */
	public static Object toBean(String jsonStr, Class beanClass) throws JsonException
	{
		try
		{
			JSONObject jsonPerson = JSONObject.fromObject(jsonStr); 
			JSONUtils.getMorpherRegistry().registerMorpher(new TimestampMorpher()); 
			return JSONObject.toBean(jsonPerson, beanClass); 
			
		}catch (Exception e)
		{
			throw new JsonException("jsonStr:"+jsonStr+" conver to "+beanClass);
		} 
	}

	/**
	 * json转list
	 * @param jsonStr
	 * @param beanClass
	 * @return
	 * @throws JsonException
	 */
	public static List toArray(String jsonStr,Class beanClass) throws JsonException
	{
		try
		{
			JSONUtils.getMorpherRegistry().registerMorpher(new TimestampMorpher()); 
			JSONArray jsonArray = JSONArray.fromObject(jsonStr);
			return (List) JSONArray.toCollection(jsonArray, beanClass);
		}catch (Exception e)
		{
			throw new JsonException("jsonStr:"+jsonStr+" conver to "+beanClass);
		}
	}
	
	
}