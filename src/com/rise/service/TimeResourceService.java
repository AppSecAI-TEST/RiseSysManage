package com.rise.service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.rise.model.FuncNodeTree;
import com.rise.model.StaffT;
import com.rise.pub.base.JacksonJsonMapper;
import com.rise.pub.invoke.ServiceEngine;
import com.rise.pub.util.ObjectCensor;
import com.rise.pub.util.StringUtil;

@Service
public class TimeResourceService 
{
	@Autowired
	private QryPubDataService pubService;
	
	public String addTimeResource(String params) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS3052\",securityCode:\"0000000000\",params:{param:"+params+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String addClassTimeConfig(String params) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS3054\",securityCode:\"0000000000\",params:{param:"+params+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	
	public String updateTimeResource(String params) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS3053\",securityCode:\"0000000000\",params:{param:"+params+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
		
	public String getYearTimeResource(String year) throws Exception
	{
		JSONObject json =new JSONObject();
		json.put("total", 12);
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS3051\",securityCode:\"0000000000\",params:{year:\""+year+"\"},rtnDataFormatType:\"user-defined\"}";
		JSONArray timeArr =JSONArray.fromObject(ServiceEngine.invokeHttp(param));
		JSONArray rowArray=new JSONArray();
		for(int i=1;i<=12;i++)
		{
			JSONObject obj =new JSONObject();
			obj.put("month",i);
			obj.put("year","");
			obj.put("days","");
			obj.put("daysValue","");
			obj.put("schoolTimeId","");
			for(int j=timeArr.size()-1;j>=0;j--)
			{
				JSONObject timeJSON =timeArr.getJSONObject(j);
				if((StringUtil.getJSONObjectKeyVal(obj, "month")).equals(StringUtil.getJSONObjectKeyVal(timeJSON, "month")))
				{
					obj.put("year", StringUtil.getJSONObjectKeyVal(timeJSON, "year"));
					obj.put("days", StringUtil.getJSONObjectKeyVal(timeJSON, "days"));
					obj.put("daysValue",getDaysValue(StringUtil.getJSONObjectKeyVal(timeJSON, "month"),StringUtil.getJSONObjectKeyVal(timeJSON, "days")));
					obj.put("schoolTimeId", StringUtil.getJSONObjectKeyVal(timeJSON, "schoolTimeId"));
					timeArr.remove(j);
				}
			}
			rowArray.add(obj);
		}
		json.put("rows", rowArray);
		return json.toString();
	}
	
	
	public JSONObject getClassTimeConfigInfo() throws Exception
	{
		JSONObject json =new JSONObject();
		JSONArray array =new JSONArray();
		JSONArray week =JSONArray.fromObject(pubService.qryCodeNameList("SCHOOLTIME_T", "WEEK_TIME", ""));
		JSONArray config =JSONArray.fromObject(pubService.qryParaConfigList("HOUR_RANGE", ""));
		JSONArray timeRange=this.qryTimeConfig();
		if(week.size()>0&&config.size()>0)
		{
			json.put("rowspan", config.size());
			for(int i=0;i<week.size();i++)
			{
				JSONObject weekJSON =week.getJSONObject(i);
				for(int j =0;j<config.size();j++)
				{
					JSONObject configJSON =config.getJSONObject(j);
					JSONObject obj =new JSONObject();
					obj.put("weekTime", StringUtil.getJSONObjectKeyVal(weekJSON, "codeFlag"));
					obj.put("weekTimeVal", StringUtil.getJSONObjectKeyVal(weekJSON, "codeName"));
					obj.put("hourRange", StringUtil.getJSONObjectKeyVal(configJSON, "paramValue"));
					obj.put("hourRangeVal", StringUtil.getJSONObjectKeyVal(configJSON, "paramDesc"));
					obj.put("apm", StringUtil.getJSONObjectKeyVal(configJSON, "param2"));
					obj.put("apmVal", StringUtil.getJSONObjectKeyVal(configJSON, "param3"));
					obj.put("lessionHours",StringUtil.getJSONObjectKeyVal(configJSON, "param4"));
					obj.put("timeState","");
					for(int k=timeRange.size()-1;k>=0;k--)
					{
						JSONObject rangeJSON =timeRange.getJSONObject(k);
						if((StringUtil.getJSONObjectKeyVal(obj, "weekTime").equals(StringUtil.getJSONObjectKeyVal(rangeJSON, "weekTime")))&&(StringUtil.getJSONObjectKeyVal(obj, "hourRange").equals(StringUtil.getJSONObjectKeyVal(rangeJSON, "hourRange"))))
						{
							obj.put("timeState", StringUtil.getJSONObjectKeyVal(rangeJSON, "timeState"));
							timeRange.remove(k);
						}
					}	
					array.add(obj);
				}	
			}
		}
		json.put("configInfo", array);
		return json;
	}
	
	private JSONArray qryTimeConfig() throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS3055\",securityCode:\"0000000000\",params:{},rtnDataFormatType:\"user-defined\"}";
		return JSONArray.fromObject(ServiceEngine.invokeHttp(param));
	}
	
	
	private String getDaysValue(String month,String days) throws Exception
	{
		StringBuffer sb =new StringBuffer();
		if(!ObjectCensor.isStrRegular(month,days))
		{
			return "";
		}
		else
		{
			String[] arr =days.split(",");
			for(int i=0;i<arr.length;i++)
			{
				sb.append(month+"ÔÂ"+arr[i]+"ºÅ,");
			}	
		}
		return sb.toString().substring(0,sb.toString().length()-1);
	}
}

