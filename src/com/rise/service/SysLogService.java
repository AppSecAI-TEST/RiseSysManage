package com.rise.service;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;

import com.rise.pub.invoke.ServiceEngine;
import com.rise.pub.util.ObjectCensor;

@Service
public class SysLogService {
	public String deleteLog(String logIds) throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0131\",securityCode:\"0000000000\",params:{logIds:\""+logIds+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	public String deleteAllLog() throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0132\",securityCode:\"0000000000\",params:{},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	public String qrySysLogListByPage(String page, String rows, String param, String funcNodeId) throws Exception {
		JSONObject obj = new JSONObject();
		if(ObjectCensor.isStrRegular(param)) {
			obj = JSONObject.fromObject(param);
		}
		if(ObjectCensor.isStrRegular(page,rows)) {
			Integer pageNum = Integer.parseInt(page) - 1;
			Integer pageSize = Integer.parseInt(rows);
			pageNum = pageNum * pageSize;
			obj.element("start", pageNum);
			obj.element("rownum", pageSize);
		}
		if(ObjectCensor.isStrRegular(funcNodeId)) {
			obj.element("funcNodeId", funcNodeId);
		}
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0133\",securityCode:\"0000000000\",params:{param:"+obj+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
}
