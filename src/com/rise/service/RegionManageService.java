package com.rise.service;

import org.springframework.stereotype.Service;

import com.rise.pub.invoke.ServiceEngine;

@Service
public class RegionManageService {

	//����Ƭ��
	public String addRegion(String json)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS4301\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//�޸�Ƭ��
	public String updateRegion(String json)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS4302\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//ɾ��Ƭ��
	public String deleteRegion(String regionId)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS4303\",securityCode:\"0000000000\",params:{regionId:'"+regionId+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	
	
}
