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
}