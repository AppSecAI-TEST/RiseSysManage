package com.rise.service;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.rise.model.ClassInstT;
import com.rise.pub.base.JacksonJsonMapper;
import com.rise.pub.invoke.ServiceEngine;

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
		model.addObject("statistics", statistics);
		json.remove("classAttendStatistics");
		ClassInstT classInstT = (ClassInstT)mapper.readValue(json.toString() , ClassInstT.class);
		model.addObject("classInstT", classInstT);
		model.addObject("funcNodeId", funcNodeId);
	}
}
