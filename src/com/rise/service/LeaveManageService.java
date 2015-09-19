package com.rise.service;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;

import com.rise.pub.invoke.ServiceEngine;
import com.rise.pub.util.ObjectCensor;

@Service
public class LeaveManageService {

	//查询休学学员相关信息
	public String viewLeaveInfo(String studentId,String leaveId,String funcNodeId)throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1203\",securityCode:\"0000000000\",params:{param:{studentId:\""+studentId+"\",leaveId:\""+leaveId+"\",functionId:\""+funcNodeId+"\"}},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	//复课
	public String restartClass(String studentId,String leaveId,String resumeType,String studentCourseId,String handlerId)throws Exception{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1204\",securityCode:\"0000000000\",params:{param:{studentId:\""+studentId+"\",leaveId:\""+leaveId+"\",resumeType:\""+resumeType+"\",studentCourseId:\""+studentCourseId+"\",handlerId:\""+handlerId+"\"}},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//修改休学时长
	public String updateLeaveTime(String leaveId, String delayDate,String updateRemark,String handlerId) throws Exception{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1205\",securityCode:\"0000000000\",params:{param:{leaveId:\""+leaveId+"\",delayDate:\""+delayDate+"\",updateRemark:\""+updateRemark+"\",handlerId:\""+handlerId+"\"}},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//添加休学
	public String addLeaveInfo(String json) throws Exception{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1202\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

}
