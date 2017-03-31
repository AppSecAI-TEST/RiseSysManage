package com.rise.service;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;

import com.rise.pub.invoke.ServiceEngine;
import com.rise.pub.util.ObjectCensor;
import com.rise.pub.util.StringUtil;

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

	public String qryTeacherList(String schoolId, String stageId, String state) throws Exception 
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1018\",securityCode:\"0000000000\",params:{schoolId:\""+schoolId+"\",stageId:\""+stageId+"\",state:\""+state+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	public String qryDataListByPage(String page, String rows, String param, String funcNodeId) throws Exception {
		JSONObject obj = new JSONObject();
		if (ObjectCensor.isStrRegular(param)) {
			obj = JSONObject.fromObject(param);
		}
		if (ObjectCensor.isStrRegular(page, rows)) {
			Integer pageNum = Integer.parseInt(page) - 1;
			Integer pageSize = Integer.parseInt(rows);
			pageNum = pageNum * pageSize;
			obj.element("start", pageNum);
			obj.element("rownum", pageSize);
		}
		if (ObjectCensor.isStrRegular(funcNodeId)) {
			if("1072".equals(funcNodeId) || "1065".equals(funcNodeId) || "1094".equals(funcNodeId) || "1097".equals(funcNodeId)) {
				String schoolId = StringUtil.getJSONObjectKeyVal(obj, "schoolId");
				String staffSchoolId = StringUtil.getJSONObjectKeyVal(obj, "staffSchoolId");
				if(!ObjectCensor.isStrRegular(schoolId)) {
					//总部员工  且 没有选择校区
					if("10".equals(staffSchoolId)) {
						if("1072".equals(funcNodeId)) {
							funcNodeId = "1089";
						} else if("1065".equals(funcNodeId)) {
							funcNodeId = "1092";
						} else if("1094".equals(funcNodeId)) {
							funcNodeId = "1095";
						} else if("1097".equals(funcNodeId)) {
							funcNodeId = "1098";
						}
					} else {
						//角色为区域校长或者区域教务长 且没有选校区 则查询片区的数据
						String staffId = StringUtil.getJSONObjectKeyVal(obj, "staffId");
						//String staffPost = StringUtil.getJSONObjectKeyVal(obj, "staffPost");
						String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1019\",securityCode:\"0000000000\",params:{param:{staffId:\"" + staffId + "\",funcNodeId:\"1091\"}},rtnDataFormatType:\"user-defined\"}";
						JSONObject rstObj = JSONObject.fromObject(ServiceEngine.invokeHttp(params));
						String total = StringUtil.getJSONObjectKeyVal(rstObj, "total");
						if(ObjectCensor.isStrRegular(total) && Integer.parseInt(total) > 0) {
							if("1072".equals(funcNodeId)) {
								funcNodeId = "1090";
							} else if("1065".equals(funcNodeId)) {
								funcNodeId = "1093";
							} else if("1094".equals(funcNodeId)) {
								funcNodeId = "1096";
							} else if("1097".equals(funcNodeId)) {
								funcNodeId = "1099";
							}
							obj.element("staffId", staffId);
						}
					}
				}
			} else if("1056".equals(funcNodeId)) {
				String month = StringUtil.getJSONObjectKeyVal(obj, "month");
				String quarter = StringUtil.getJSONObjectKeyVal(obj, "quarter");
				if(!ObjectCensor.isStrRegular(month, quarter)) {
					funcNodeId = "1100";
				}
			}
			obj.element("funcNodeId", funcNodeId);
		}
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1019\",securityCode:\"0000000000\",params:{param:" + obj + "},rtnDataFormatType:\"user-defined\"}";
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

	public String qryReportMonthList(String tableName, String year, String schoolId) throws Exception  
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS10122\",securityCode:\"0000000000\",params:{tableName:\""+tableName+"\",year:\""+year+"\",schoolId:\""+schoolId+"\"},rtnDataFormatType:\"user-defined\"}";
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
	
	public String qrySchoolListWithTS(String schoolId) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS10125\",securityCode:\"0000000000\",params:{schoolId:\""+schoolId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
}
