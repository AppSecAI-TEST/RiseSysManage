package com.rise.service;

import org.springframework.stereotype.Service;

import com.rise.pub.invoke.ServiceEngine;

@Service
public class AttendClassService {
	public String qryAttendClassById(String classInstId) throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0091\",securityCode:\"0000000000\",params:{param:{classInstId:\""+classInstId+"\",queryCode:\"qryAttendClassById\"}},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	public String disbandClass(String param) throws Exception {
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0092\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}

	public String changeTeacher(String param) throws Exception {
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0093\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}

	public String finishClass(String param) throws Exception {
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0094\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}

	public String updateFinishDate(String param) throws Exception {
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0095\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
}
