package com.rise.service;

import org.springframework.stereotype.Service;

import com.rise.pub.invoke.ServiceEngine;

@Service
public class GiftConfigService {

	//������ƷС�����ø����������֣��̲ĸ�ʵ����������棩
	public String addGiftConfig(String json,String type)throws Exception{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1401\",securityCode:\"0000000000\",params:{json:'"+json+"',type:'"+type+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//�޸���ƷС����Ϣ���ݲ�ͬ���ͷ�Ϊʵ����Ρ���ȯ���̲�
	public String updateGiftConfig(String json, String type)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1402\",securityCode:\"0000000000\",params:{json:'"+json+"',type:'"+type+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//ɾ����ƷС��
	public String deleteGiftConfig(String giftId, String type)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1403\",securityCode:\"0000000000\",params:{giftId:'"+giftId+"',type:'"+type+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//������Ʒ���ô��࣬������������
	public String addGiftTypeConfig(String json, String type)throws Exception{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1404\",securityCode:\"0000000000\",params:{json:'"+json+"',type:'"+type+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//�޸���Ʒ���ô��࣬������������ 
	public String updateGiftTypeConfig(String json, String type)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1405\",securityCode:\"0000000000\",params:{json:'"+json+"',type:'"+type+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//ɾ����Ʒ���࣬������������С����һ��ɾ��
	public String deleteGiftTypeConfig(String giftTypeId, String type)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1406\",securityCode:\"0000000000\",params:{giftTypeId:'"+giftTypeId+"',type:'"+type+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

}
