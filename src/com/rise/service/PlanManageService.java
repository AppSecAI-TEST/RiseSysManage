package com.rise.service;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;

import com.rise.pub.invoke.ServiceEngine;
import com.rise.pub.util.ObjectCensor;

@Service
public class PlanManageService 
{
	public String addPlan(String params) throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS3121\",securityCode:\"0000000000\",params:{param:"+params+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String updatePlan(String params) throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS3122\",securityCode:\"0000000000\",params:{param:"+params+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String deletePlan(String planId) throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS3123\",securityCode:\"0000000000\",params:{planId:\""+planId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	public String qryPlan(String schoolId, String planYear, String planType) throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS3124\",securityCode:\"0000000000\",params:{schoolId:\""+schoolId+"\",planYear:\""+planYear+"\",planType:\""+planType+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	public String delPlan(String schoolId, String planYear, String planType) throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS3125\",securityCode:\"0000000000\",params:{schoolId:\""+schoolId+"\",planYear:\""+planYear+"\",planType:\""+planType+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	public String add(String params) throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS3126\",securityCode:\"0000000000\",params:{param:"+params+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String update(String params) throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS3127\",securityCode:\"0000000000\",params:{param:"+params+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	public String qryDataListByPage(String param) throws Exception {
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS3128\",securityCode:\"0000000000\",params:{param:" + param + "},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
}

