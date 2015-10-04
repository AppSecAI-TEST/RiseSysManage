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
}
