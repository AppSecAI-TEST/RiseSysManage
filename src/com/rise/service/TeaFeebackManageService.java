package com.rise.service;

import org.springframework.stereotype.Service;

import com.rise.pub.invoke.ServiceEngine;

@Service
public class TeaFeebackManageService {

	//���ݰ༶ʵ��Id�����а༶ѧԱ
	public String qryClassStuByInstId(String classInstId,String qualityId)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS4201\",securityCode:\"0000000000\",params:{classInstId:'"+classInstId+"',qualityId:'"+qualityId+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//�������ʷ���
	public String addTeachingFeedback(String feedbackJson,String feedbackDetailJson)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS4202\",securityCode:\"0000000000\",params:{feedbackJson:'"+feedbackJson+"',feedbackDetailJson:'"+feedbackDetailJson+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//������ʷ�����Ϣ
	public String viewTeachingFeedback(String feedbackId)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS4203\",securityCode:\"0000000000\",params:{feedbackId:\""+feedbackId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//�޸Ľ��ʷ�����Ϣ
	public String updateTeachingFeedback(String json)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS4204\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
}
