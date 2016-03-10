package com.rise.service;

import org.springframework.stereotype.Service;

import com.rise.pub.invoke.ServiceEngine;

@Service
public class SysLogService {
	public String deleteLog(String logIds) throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0131\",securityCode:\"0000000000\",params:{logIds:\""+logIds+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	public String deleteAllLog() throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0132\",securityCode:\"0000000000\",params:{},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
}
