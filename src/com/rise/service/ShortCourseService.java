package com.rise.service;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;

import com.rise.pub.invoke.ServiceEngine;
import com.rise.pub.util.ObjectCensor;

@Service
public class ShortCourseService {

	//�������ڿ�
	public String addShortClass(String json)throws Exception{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1701\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//ɾ�����ڿ�
	public String deleteShortClass(String shortClassId)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1702\",securityCode:\"0000000000\",params:{shortClassId:'"+shortClassId+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	//�������ڿΰ༶����
	public String addShortClassType(String json)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1703\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//�޸Ķ��ڿΰ༶����
	public String updateShortClassType(String json)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1704\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//ɾ�����ڿΰ༶����
	public String deleteShortClassType(String classTypeId)throws Exception{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1705\",securityCode:\"0000000000\",params:{classTypeId:'"+classTypeId+"'},rtnDataFormatType:\"user-defined\"}";
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
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1706\",securityCode:\"0000000000\",params:{param:"+obj+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	//��ȡ���ж��ڿΰ༶������Ϣ
	public String getAllClassType(String shortClassId)throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1708\",securityCode:\"0000000000\",params:{shortClassId:'"+shortClassId+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	//�����ϵ�ύ
	public String addPriceSystem(String priceJson, String classJson, String type)throws Exception{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1709\",securityCode:\"0000000000\",params:{priceJson:'"+priceJson+"',classJson:'"+classJson+"',type:'"+type+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	//ɾ����ϵ
	public String deletePriceSystem(String setPriceId, String type)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS17010\",securityCode:\"0000000000\",params:{setPriceId:'"+setPriceId+"',type:'"+type+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	//�����ϵ
	public String viewPriceSystem(String setPriceId, String type)throws Exception{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS17011\",securityCode:\"0000000000\",params:{setPriceId:'"+setPriceId+"',type:'"+type+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//�޸���ϵ
	public String updatePriceSystem(String priceJson, String classJson,String type)throws Exception{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS17012\",securityCode:\"0000000000\",params:{priceJson:'"+priceJson+"',classJson:'"+classJson+"',type:'"+type+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
}
