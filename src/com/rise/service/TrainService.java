package com.rise.service;

import org.springframework.stereotype.Service;

import com.rise.pub.invoke.ServiceEngine;

@Service
public class TrainService {

	//–¬‘ˆ≈‡—µ
	public String addTrain(String json) throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS4001\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//‰Ø¿¿≈‡—µ
	public String viewTrainInfo(String trainId)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS4002\",securityCode:\"0000000000\",params:{trainId:\""+trainId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	public String updateTrain(String json) throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS4003\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

}
