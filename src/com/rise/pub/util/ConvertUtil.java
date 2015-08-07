package com.rise.pub.util;

import java.lang.reflect.Field;
import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONObject;

import com.rise.pub.base.JacksonJsonMapper;

/**
 * 
 * @author : tiankang
 * 
 */
public class ConvertUtil
{
	/**
	 * @author : tiankang
	 * @param obj
	 * @param clazz
	 * @return
	 * @throws Exception
	 * 转化成指定对象
	 */
	public static Object getObj(Object obj,Class clazz) throws Exception
	{
		JSONObject jsonObj = JSONObject.fromObject(obj);
		Object result = clazz.newInstance();
		for(Field field : clazz.getDeclaredFields())
		{
			field.setAccessible(true);
			String fieldName = field.getName();
			if("serialVersionUID".equals(fieldName))
			{
				continue;
			}
			String types = getTokenStr(field.getType().toString(),".");
			String res = StringUtil.getJSONObjectKeyVal(jsonObj, fieldName);
			if("Timestamp".equals(types))
			{
				if("null".equals(res))
				{
					field.set(result, null);
				}
				else
				{
					JSONObject dateObj = JSONObject.fromObject(res);
					Date date = new Date();
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					date.setTime(Long.parseLong(StringUtil.getJSONObjectKeyVal(dateObj, "time")));
					String dateStr = sdf.format(date);
					Timestamp sta = Timestamp.valueOf(dateStr);
					field.set(result, sta);
				}
			}
			else if("Date".equals(types))
			{
				if("null".equals(res))
				{
					field.set(result, null);
				}
				else
				{
					JSONObject dateObj = JSONObject.fromObject(res);
					Date date = new Date();
					date.setTime(Long.parseLong(StringUtil.getJSONObjectKeyVal(dateObj, "time")));
					field.set(result, date);
				}
			}
			else if("Long".equals(types) || "long".equals(types))
			{
				if("null".equals(res))
				{
					field.set(result, null);
				}
				else
				{
					long val = Long.parseLong(res);
					field.set(result, val);
				}
			}
			else if("int".equals(types) || "Integer".equals(types))
			{
				if("null".equals(res))
				{
					field.set(result, null);
				}
				else
				{
					int val = Integer.parseInt(res);
					field.set(result, val);
				}
			}
			else if("double".equals(types) || "Double".equals(types))
			{
				if("null".equals(res))
				{
					field.set(result, null);
				}
				else
				{
					double val = Double.parseDouble(res);
					field.set(result, val);
				}
			}
			else if("Short".equals(types) || "short".equals(types))
			{
				if("null".equals(res))
				{
					field.set(result, null);
				}
				else
				{
					short val = Short.parseShort(res);
					field.set(result, val);
				}
			}
			else if("Boolean".equals(types) || "boolean".equals(types))
			{
				if("null".equals(res))
				{
					field.set(result, null);
				}
				else
				{
					if("true".equals(res))
					{
						field.set(result, true);
					}
					else
					{
						field.set(result, false);
					}
				}
			}
			else if("Byte".equals(types) || "byte".equals(types))
			{
				if("null".equals(res))
				{
					field.set(result, null);
				}
				else
				{
					byte val = Byte.parseByte(res);
					field.set(result, val);
				}
			}
			else if("ArrayList".equals(types))
			{
				if("[]".equals(res))
				{
					field.set(result, null);
				}
				else
				{
					Type type = field.getGenericType();
					String className="";
					if(type instanceof ParameterizedType)
					{
						ParameterizedType ts = (ParameterizedType)type;
						for(Type temp : ts.getActualTypeArguments())
						{
							className = getTokenStr(temp.toString()," ");
						}
					}
					Class subClass = Class.forName(className);
					List jsonList = JacksonJsonMapper.getInstance().readValue(res, List.class);
					List tempList = getList(jsonList, subClass);
					field.set(result, tempList);	
				}
			}
			else if("String".equals(types))
			{
				field.set(result, res);
			}
		}
		return result;
	}
	
	/**
	 * @author : tiankang
	 * @param obj
	 * @param clazz
	 * @return
	 * @throws Exception
	 */
	public static Object getObjData(Object obj,Class clazz) throws Exception
	{
		JSONObject jsonObj = JSONObject.fromObject(obj);
		Object result = clazz.newInstance();
		for(Field field : clazz.getDeclaredFields())
		{
			field.setAccessible(true);
			String fieldName = field.getName();
			if("serialVersionUID".equals(fieldName))
			{
				continue;
			}
			String types = getTokenStr(field.getType().toString(),".");
			String res = StringUtil.getJSONObjectKeyVal(jsonObj, StringUtil.transObjToData(fieldName));
			if("Timestamp".equals(types))
			{
				if("null".equals(res))
				{
					field.set(result, null);
				}
				else
				{
					JSONObject dateObj = JSONObject.fromObject(res);
					Date date = new Date();
					SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
					date.setTime(Long.parseLong(StringUtil.getJSONObjectKeyVal(dateObj, "time")));
					String dateStr = sdf.format(date);
					Timestamp sta = Timestamp.valueOf(dateStr);
					field.set(result, sta);
				}
			}
			else if("Date".equals(types))
			{
				if("null".equals(res))
				{
					field.set(result, null);
				}
				else
				{
					JSONObject dateObj = JSONObject.fromObject(res);
					Date date = new Date();
					date.setTime(Long.parseLong(StringUtil.getJSONObjectKeyVal(dateObj, "time")));
					field.set(result, date);
				}
			}
			else if("Long".equals(types) || "long".equals(types))
			{
				long val = Long.parseLong(res);
				field.set(result, val);
			}
			else if("int".equals(types) || "Integer".equals(types))
			{
				int val = Integer.parseInt(res);
				field.set(result, val);
			}
			else if("double".equals(types) || "Double".equals(types))
			{
				double val = Double.parseDouble(res);
				field.set(result, val);
			}
			else if("Boolean".equals(types) || "boolean".equals(types))
			{
				if("true".equals(res))
				{
					field.set(result, true);
				}
				else
				{
					field.set(result, false);
				}
			}
			else if("Byte".equals(types) || "byte".equals(types))
			{
				byte val = Byte.parseByte(res);
				field.set(result, val);
			}
			else if("ArrayList".equals(types))
			{
				if("[]".equals(res))
				{
					field.set(result, null);
				}
				else
				{
					Type type = field.getGenericType();
					String className="";
					if(type instanceof ParameterizedType)
					{
						ParameterizedType ts = (ParameterizedType)type;
						for(Type temp : ts.getActualTypeArguments())
						{
							className = getTokenStr(temp.toString()," ");
						}
					}
					Class subClass = Class.forName(className);
					List jsonList = JacksonJsonMapper.getInstance().readValue(res, List.class);
					List tempList = getList(jsonList, subClass);
					field.set(result, tempList);	
				}
			}
			else if("String".equals(types))
			{
				field.set(result, res);
			}
		}
		return result;
	}
	
	/**
	 * @author : tiankang
	 * @param list
	 * @param clazz
	 * @return
	 * @throws Exception
	 * 转化成指定对象的List集合
	 */
	public static List getList(List list,Class clazz) throws Exception
	{
		List result = new ArrayList();
		for(int i = 0;i < list.size();i++)
		{
			Object obj = getObj(list.get(i),clazz);
			result.add(obj);
		}
		return result;
	}
	
	/**
	 * @author : tiankang
	 * @param map
	 * @param clazz
	 * @return
	 * 转化成指定对象的List集合
	 * @throws Exception 
	 */
	public static Map getMap(Map map,Class clazz) throws Exception
	{
		Map result = new HashMap();
		for(Object temp : result.entrySet())
		{
			Map.Entry entry = (Map.Entry)temp;
			result.put(entry.getKey(), getObj(entry.getValue(),clazz));
		}
		return result;
	}
	
	
	/**
	 * @author : tiankang
	 * @param fullType
	 * @param token
	 * @return
	 * 根据分隔符返回字符串最后的部分
	 */
    private static String getTokenStr(String fullType,String token)
    {
        int ind = fullType.lastIndexOf(token);
        if(ind == -1)
        {
            return fullType;
        }
        return fullType.substring(ind+1);
    }
}
