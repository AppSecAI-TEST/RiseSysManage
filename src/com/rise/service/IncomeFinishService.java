package com.rise.service;

import java.util.List;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.rise.pub.base.JacksonJsonMapper;
import com.rise.pub.invoke.ServiceEngine;
import com.rise.pub.util.StringUtil;

@Service
public class IncomeFinishService 
{
	public void accessRecordPage(ModelAndView model , String incomeFlag) throws Exception
	{
		String result = getRecordInfo("" , incomeFlag);
		JSONObject retJson = JSONObject.fromObject(result);
		model.addObject("monthDate", StringUtil.getJSONObjectKeyVal(retJson, "monthDate"));
		List arrList = JacksonJsonMapper.getInstance().readValue(retJson.getJSONArray("arrList").toString()	, List.class);
		model.addObject("arrList", arrList);
	}
	
	public String getRecordInfo(String monthDate , String incomeFlag) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2061\",securityCode:\"0000000000\",params:{monthDate:'"+monthDate+"',incomeFlag:'"+incomeFlag+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String addIncomeFinishRecord(String json) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2062\",securityCode:\"0000000000\",params:{monthDate:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
}
