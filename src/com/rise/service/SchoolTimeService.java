package com.rise.service;

import org.springframework.stereotype.Service;

import com.rise.pub.invoke.ServiceEngine;

/**
 * �ſ�
 * @author Lapalnd_Alone
 *
 */
@Service
public class SchoolTimeService
{
	/**
	 * ��ȡĳ�·ݣ��ڼ��ܵ��ſμƻ�
	 * @param param
	 * @return
	 * @throws Exception
	 */
	public String getSchoolTimeByWeek(String param) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS8002\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	/**
	 * �����ſ�
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
	 * ɾ���ſ�
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
	 * ��ȡһ�����ܵķ�Χ
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
	 *��ʦ��ʱ�ƻ�
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
	 * �޸��ſα�ʶ
	 * @param createWeekId
	 * @return
	 * @throws Exception
	 */
	public String updateCreateWeek(String createWeekId) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS8007\",securityCode:\"0000000000\",params:{createWeekId:"+createWeekId+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String getRoomPlan(String schoolId) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS8009\",securityCode:\"0000000000\",params:{schoolId:"+schoolId+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
}
