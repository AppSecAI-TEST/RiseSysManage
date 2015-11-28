package com.rise.service;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;

import com.rise.pub.invoke.ServiceEngine;
import com.rise.pub.util.ObjectCensor;

@Service
public class ExpManageService {

	//异动维护首页面查询
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
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1801\",securityCode:\"0000000000\",params:{param:"+obj+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}

	public String viewExpStuInfo(String studentId, String studentCourseId,String expType)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1802\",securityCode:\"0000000000\",params:{studentId:'"+studentId+"',studentCourseId:'"+studentCourseId+"',expType:'"+expType+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	public String qryExpStuDetailInfo(String studentId, String studentCourseId,String expType)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1803\",securityCode:\"0000000000\",params:{studentId:'"+studentId+"',studentCourseId:'"+studentCourseId+"',expType:'"+expType+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
}
