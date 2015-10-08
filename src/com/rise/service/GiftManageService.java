package com.rise.service;

import org.springframework.stereotype.Service;

import com.rise.pub.invoke.ServiceEngine;

@Service
public class GiftManageService {

	//����ʵ��̲���Ʒ
	public String addGiftInfo(String json) throws Exception{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1301\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//�̲�ʵ��� ��Ϣ����
	public String updateGiftInfo(String json, String type) throws Exception{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1302\",securityCode:\"0000000000\",params:{json:'"+json+"',type:'"+type+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//�����Ʒ��Ϣ
	public String viewGiftInfo(String studentGiftId,String funcNodeId)throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1303\",securityCode:\"0000000000\",params:{studentGiftId:\""+studentGiftId+"\",functionId:\""+funcNodeId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//��������Ϣ������������
	public String updateCouponGiftInfo(String json, String type)throws Exception 
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1304\",securityCode:\"0000000000\",params:{json:'"+json+"',type:'"+type+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	//�����ȯ��Ϣ
	public String viewCouponGiftInfo(String studentGiftId,String funcNodeId)throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1305\",securityCode:\"0000000000\",params:{param:{studentGiftId:\""+studentGiftId+"\",functionId:\""+funcNodeId+"\"}},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//��ֹ����
	public String updateCourseGiftInfo(String json)throws Exception{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1306\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
}
