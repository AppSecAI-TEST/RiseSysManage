package com.rise.pub.util;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import net.sf.json.processors.JsonValueProcessor;
import net.sf.json.util.JSONUtils;

import com.rise.pub.exception.JsonException;

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
	
	public static JsonConfig getJsonConfig(final String format)
	{
		JsonConfig jsonConfig = new JsonConfig();
		jsonConfig.registerJsonValueProcessor(Timestamp.class,new JsonValueProcessor(){
			public Object processArrayValue(Object arg0, JsonConfig arg1) {
				// TODO Auto-generated method stub
				return null;
			}
			public Object processObjectValue(String key, Object value, JsonConfig jsonConfig) {
				// TODO Auto-generated method stub
				if(value==null)
					return "";
				if (value instanceof java.sql.Timestamp) {
					String str = new SimpleDateFormat(format).format((Timestamp) value);
					return str;
				}
				return value.toString();
			}
		});
		jsonConfig.registerJsonValueProcessor(java.util.Date.class,new JsonValueProcessor(){
			public Object processArrayValue(Object arg0, JsonConfig arg1) {
				// TODO Auto-generated method stub
				return null;
			}
			public Object processObjectValue(String key, Object value, JsonConfig jsonConfig) {
				// TODO Auto-generated method stub
				if(value==null)
					return "";
				if (value instanceof java.util.Date) {
					String str = new SimpleDateFormat(format).format((Date) value);
					return str;
				}
				return value.toString();
			}
		});
		return jsonConfig;
	}
}