package com.rise.service;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;

import com.rise.pub.invoke.ServiceEngine;
import com.rise.pub.util.ObjectCensor;

@Service
public class LicenseService {

	//查询教师还未持证的列表
	public String qryTeacherHasntLicense(String teacherId)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1901\",securityCode:\"0000000000\",params:{teacherId:\""+teacherId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//新增持证
	public String addLicense(String json)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1902\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	

	//新增持证
	public String delLicense(String json)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1905\",securityCode:\"0000000000\",params:{param:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//浏览教师持证信息
	public String viewLicenseInfo(String teacherId)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1903\",securityCode:\"0000000000\",params:{teacherId:\""+teacherId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//教师持证列表
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
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1904\",securityCode:\"0000000000\",params:{param:"+obj+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	
	
}
