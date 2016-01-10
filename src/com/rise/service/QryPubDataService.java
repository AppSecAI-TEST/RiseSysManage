package com.rise.service;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;

import com.rise.pub.invoke.ServiceEngine;
import com.rise.pub.util.ObjectCensor;

@Service
public class QryPubDataService 
{
	public String qryCodeNameList(String tableName, String codeType, String codeFlag) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1013\",securityCode:\"0000000000\",params:{tableName:\""+tableName+"\",codeType:\""+codeType+"\",codeFlag:\""+codeFlag+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	public String qrySchoolList(String schoolId) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1011\",securityCode:\"0000000000\",params:{schoolId:\""+schoolId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	public String qryStaffList(String post, String schoolId) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1012\",securityCode:\"0000000000\",params:{schoolId:\""+schoolId+"\",post:\""+post+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	public String qryParaConfigList(String paramType, String paramValue) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1015\",securityCode:\"0000000000\",params:{paramType:\""+paramType+"\",paramValue:\""+paramValue+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	public String qryClassInstList(String schoolId, String courseType, String stageId, String classType, String classState, String classInstId) throws Exception  
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1014\",securityCode:\"0000000000\",params:{schoolId:\""+schoolId+"\",courseType:\""+courseType+"\",stageId:\""+stageId+"\",classType:\""+classType+"\",classState:\""+classState+"\",classInstId:\""+classInstId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String qryHourRangeList(String weekTime) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1016\",securityCode:\"0000000000\",params:{weekTime:\""+weekTime+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	public String qryRoomList(String schoolId) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1017\",securityCode:\"0000000000\",params:{schoolId:\""+schoolId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	public String qryTeacherList(String schoolId, String classType) throws Exception 
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1018\",securityCode:\"0000000000\",params:{schoolId:\""+schoolId+"\",classType:\""+classType+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	public String qryDataListByPage(String page, String rows, String param, String funcNodeId) throws Exception 
	{
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
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1019\",securityCode:\"0000000000\",params:{param:"+obj+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String qryData(String param) throws Exception 
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS10110\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String qryAction(String schoolId) throws Exception 
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS10111\",securityCode:\"0000000000\",params:{schoolId:"+schoolId+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	
	/**
	 * 查询阶段
	 * @author Lapalnd_Alone
	 * @return
	 * @throws Exception
	 */
	public String getStage() throws Exception 
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS10112\",securityCode:\"0000000000\",params:{},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	/**
	 * 查询班级定价
	 * @author Lapalnd_Alone
	 * @param schoolId
	 * @param stageId
	 * @return
	 * @throws Exception
	 */
	public String getClassPrice(String schoolId,String stageId) throws Exception 
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS10113\",securityCode:\"0000000000\",params:{schoolId:\""+schoolId+"\",stageId:\""+stageId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	/**
	 * 查询班级
	 * @param schoolId
	 * @param stageId
	 * @return
	 * @throws Exception
	 */
	public String getClassType(String stageId) throws Exception 
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS10114\",securityCode:\"0000000000\",params:{stageId:\""+stageId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}

	/**
	 * 查询职务
	 * @param postId
	 * @return
	 * @throws Exception
	 */
	public String qryPostList(String postId,String postType) throws Exception{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS10115\",securityCode:\"0000000000\",params:{postId:\""+postId+"\",postType:\""+postType+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	/**
	 * 查询指定校区所拥有的老师
	 * @param schoolId
	 * @return
	 * @throws Exception
	 */
	public String getTeacherBySchoolId(String schoolId) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS10116\",securityCode:\"0000000000\",params:{schoolId:\""+schoolId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}

	public String qryShortClass() throws Exception  
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS10117\",securityCode:\"0000000000\",params:{},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}

	public String qryStudentListByClassInstId(String classInstId) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS10118\",securityCode:\"0000000000\",params:{classInstId:\""+classInstId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String qryQuarterList() throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS10119\",securityCode:\"0000000000\",params:{},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}

	public String qryMonthList(String quarter) throws Exception 
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS10120\",securityCode:\"0000000000\",params:{quarter:\""+quarter+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}

	public String qryRegionList() throws Exception 
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS10121\",securityCode:\"0000000000\",params:{},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}

	public String qryReportMonthList(String tableName, String year) throws Exception  
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS10122\",securityCode:\"0000000000\",params:{tableName:\""+tableName+"\",year:\""+year+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String qryReportWeekList(String tableName, String year, String month) throws Exception  
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS10123\",securityCode:\"0000000000\",params:{tableName:\""+tableName+"\",year:\""+year+"\",month:\""+month+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}

	public String qryReportYearList(String tableName) throws Exception 
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS10124\",securityCode:\"0000000000\",params:{tableName:\""+tableName+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
}
