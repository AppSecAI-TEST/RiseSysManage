package com.rise.service;

import org.springframework.stereotype.Service;

import com.rise.pub.invoke.ServiceEngine;

/**
 * 排课
 * @author Lapalnd_Alone
 *
 */
@Service
public class SchoolTimeService
{
	/**
	 * 获取某月份，第几周的排课计划
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public String getSchoolTimeByWeek(String param) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS8002\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String getAllSchoolTimeByWeek(String param) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS80017\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	/**
	 * 增加排课
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public String addSchoolTime(String param) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS8003\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	/**
	 * 删除排课
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public String delSchoolTime(String param) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS8004\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	/**
	 * 获取一个月周的范围
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public String getWeek(String param) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS8005\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	/**
	 * 刷新排课
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public String refreshPlan(String param) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS80016\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	/**
	 *老师课时计划
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public String getTpaln(String param) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS8006\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	/**
	 *时间段教室课时计划
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public String getRoomTimePlans(String param) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS80011\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	/**
	 * 修改排课标识
	 * @param createWeekId
	 * @return
	 * @throws Exception
	 */
	public String updateCreateWeek(String createWeekId) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS8007\",securityCode:\"0000000000\",params:{createWeekId:"+createWeekId+",classInstId:''},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String getRoomPlan(String schoolId) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS8009\",securityCode:\"0000000000\",params:{schoolId:"+schoolId+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String getTeacherPlan(String schoolId) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS80010\",securityCode:\"0000000000\",params:{schoolId:"+schoolId+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String getHoursPlan(String schoolId,String month) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS80012\",securityCode:\"0000000000\",params:{schoolId:"+schoolId+",month:\""+month+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	
	public String getPlanTime(String schoolId,String month) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS80015\",securityCode:\"0000000000\",params:{schoolId:"+schoolId+",month:\""+month+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
}
