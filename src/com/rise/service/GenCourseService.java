package com.rise.service;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;

import com.rise.pub.invoke.ServiceEngine;
import com.rise.pub.util.ObjectCensor;

@Service
public class GenCourseService {

	//�����γ̽׶�
	public String addStage(String json)throws Exception{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1501\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	//�޸Ŀγ̽׶�
	public String updateStageConfig(String json)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1502\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//�����༶����
	public String addClassTypeConfig(String json)throws Exception{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1503\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	//�޸İ༶����
	public String updateClassTypeConfig(String json)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1504\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	//ɾ���༶����
	public String deleteClassTypeConfig(String classId)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1505\",securityCode:\"0000000000\",params:{classId:'"+classId+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	//ɾ���γ̽׶�
	public String deleteStageConfig(String id,String stageId)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1506\",securityCode:\"0000000000\",params:{id:'"+id+"',stageId:'"+stageId+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//�޸Ŀ�������
	public String updateClassNum(String json)throws Exception{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1507\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	//��ϵ��ҳ���ѯ
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
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1508\",securityCode:\"0000000000\",params:{param:"+obj+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	//��ȡ���а༶������Ϣ
	public String getAllClassType()throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1509\",securityCode:\"0000000000\",params:{},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//�����ϵ�ύ
	public String addPriceSystem(String priceJson, String classJson, String type)throws Exception{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS15010\",securityCode:\"0000000000\",params:{priceJson:'"+priceJson+"',classJson:'"+classJson+"',type:'"+type+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
//	public String updatePirceOpenState(String setPriceId,String operType,String priceType)throws Exception{
//		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS15011\",securityCode:\"0000000000\",params:{setPriceId:'"+setPriceId+"',operType:'"+operType+"',priceType:'"+priceType+"'},rtnDataFormatType:\"user-defined\"}";
//		return ServiceEngine.invokeHttp(param);
//	}
	
	//ɾ����ϵ
	public String deletePriceSystem(String setPriceId,String type)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS15012\",securityCode:\"0000000000\",params:{setPriceId:'"+setPriceId+"',type:'"+type+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//�����ϵ
	public String viewPriceSystem(String setPriceId, String type)throws Exception{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS15013\",securityCode:\"0000000000\",params:{setPriceId:'"+setPriceId+"',type:'"+type+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//�޸���ϵ
	public String updatePriceSystem(String priceJson, String classJson,String type)throws Exception{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS15015\",securityCode:\"0000000000\",params:{priceJson:'"+priceJson+"',classJson:'"+classJson+"',type:'"+type+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
}
