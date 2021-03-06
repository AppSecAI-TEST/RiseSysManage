package com.rise.service;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;

import com.rise.pub.invoke.ServiceEngine;
import com.rise.pub.util.ObjectCensor;

@Service
public class StudentService {
	public String qryStudentList(String page, String rows, String param, String funcNodeId) throws Exception {
		Integer pageNum = Integer.parseInt(page) - 1;
		Integer pageSize = Integer.parseInt(rows);
		pageNum = pageNum * pageSize;
		JSONObject obj = new JSONObject();
		if(ObjectCensor.isStrRegular(param)) {
			obj = JSONObject.fromObject(param);
		}
		if(ObjectCensor.isStrRegular(funcNodeId)) {
			obj.element("funcNodeId", funcNodeId);
		}
		obj.element("start", pageNum);
		obj.element("rownum", pageSize);
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0041\",securityCode:\"0000000000\",params:{param:"+obj+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String validate(String param) throws Exception {
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0042\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}

	public String addStudent(String param) throws Exception {
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0043\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String qryStudentById(String studentId, String funcNodeId) throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0044\",securityCode:\"0000000000\",params:{param:{studentId:\""+studentId+"\",funcNodeId:\""+funcNodeId+"\"}},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	public String updateStudent(String param) throws Exception {
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0045\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}

	public String addActivity(String param) throws Exception {
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0046\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}

	public String setVip(String param) throws Exception {
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0047\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}

	public String addVipRemark(String param) throws Exception {
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0048\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}

	public String qryVipRemarkList(String studentId) throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0049\",securityCode:\"0000000000\",params:{param:{studentId:\""+studentId+"\",queryCode:\"qryVipRemarkList\"}},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	public String batchUpdateAdvister(String param) throws Exception {
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS00410\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}

	public String qryStudentVipById(String studentId) throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS00411\",securityCode:\"0000000000\",params:{param:{studentId:\""+studentId+"\",queryCode:\"qryStudentById\"}},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	public String delStudent(String studentId, String handlerId) throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS00412\",securityCode:\"0000000000\",params:{studentId:\""+studentId+"\",handlerId:\""+handlerId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
}
