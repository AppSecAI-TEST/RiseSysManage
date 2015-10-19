package com.rise.service;

import org.springframework.stereotype.Service;

import com.rise.pub.invoke.ServiceEngine;

@Service
public class GiftConfigService {

	//新增赠品小类配置根据类型区分（教材跟实物包含在里面）
	public String addGiftConfig(String json,String type)throws Exception{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1401\",securityCode:\"0000000000\",params:{json:'"+json+"',type:'"+type+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//修改赠品小类信息根据不同类型分为实物、赠课、赠券、教材
	public String updateGiftConfig(String json, String type)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1402\",securityCode:\"0000000000\",params:{json:'"+json+"',type:'"+type+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//删除赠品小类
	public String deleteGiftConfig(String giftId, String type)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1403\",securityCode:\"0000000000\",params:{giftId:'"+giftId+"',type:'"+type+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//新增赠品配置大类，根据类型区分
	public String addGiftTypeConfig(String json, String type)throws Exception{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1404\",securityCode:\"0000000000\",params:{json:'"+json+"',type:'"+type+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//修改赠品配置大类，根据类型区分 
	public String updateGiftTypeConfig(String json, String type)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1405\",securityCode:\"0000000000\",params:{json:'"+json+"',type:'"+type+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//删除赠品大类，若大类下面有小类则一并删除
	public String deleteGiftTypeConfig(String giftTypeId, String type)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1406\",securityCode:\"0000000000\",params:{giftTypeId:'"+giftTypeId+"',type:'"+type+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

}
