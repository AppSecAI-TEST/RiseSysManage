package com.rise.service;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;

import com.rise.pub.invoke.ServiceEngine;
import com.rise.pub.util.ObjectCensor;

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

	//���ʻط����������ѯ
	public String qryDataListByPage(String page, String rows, String param, String funcNodeId)throws Exception{
		JSONObject obj = new JSONObject();
		if(ObjectCensor.isStrRegular(param))
		{
			obj = JSONObject.fromObject(param);
		}
		if(ObjectCensor.isStrRegular(page,rows))
		{
			Integer pageNum = Integer.parseInt(page) - 1;
			Integer pageSize = Integer.parseInt(rows);
			pageNum = pageNum * pageSize;
			obj.element("start", pageNum);
			obj.element("rownum", pageSize);
		}
		if(ObjectCensor.isStrRegular(funcNodeId))
		{
			obj.element("funcNodeId", funcNodeId);
		}
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS4205\",securityCode:\"0000000000\",params:{param:"+obj+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
}
