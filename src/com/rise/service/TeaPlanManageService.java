package com.rise.service;

import org.springframework.stereotype.Service;

import com.rise.pub.invoke.ServiceEngine;

@Service
public class TeaPlanManageService {

	//根据学校Id查所有有效班级实例
	public String qryClassInfoById(String schoolId)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS4101\",securityCode:\"0000000000\",params:{schoolId:'"+schoolId+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	//新增教质计划
	public String addTeachingPlan(String createJson, String teachingJson)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS4102\",securityCode:\"0000000000\",params:{createJson:'"+createJson+"',teachingJson:'"+teachingJson+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//查询教质计划信息
	public String viewTeachingPlanInfo(String createQualityId)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS4103\",securityCode:\"0000000000\",params:{createQualityId:\""+createQualityId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//修改教质计划
	public String updateTeachingPlan(String json)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS4104\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	
}
