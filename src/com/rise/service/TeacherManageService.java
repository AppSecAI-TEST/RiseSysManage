package com.rise.service;

import org.springframework.stereotype.Service;

import com.rise.pub.invoke.ServiceEngine;

@Service
public class TeacherManageService {

	public String qryArchivesInfo(Integer pageNumInt,Integer pageSizeInt,String schoolId,String chineseName,String englishName,String permitteeLevel,String permitteeNum,String workMonth,String workYear,String workTime,String leadClassLevel,String trainingLevel)throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1001\",securityCode:\"0000000000\",params:{pageNumInt:\""+pageNumInt+"\",pageSizeInt:\""+pageSizeInt+"\",schoolId:\""+schoolId+"\",chineseName:\""+chineseName+"\",englishName:\""+englishName+"\",permitteeLevel:\""+permitteeLevel+"\",permitteeNum:\""+permitteeNum+"\",workMonth:\""+workMonth+"\",workYear:\""+workYear+"\",workTime:\""+workTime+"\",leadClassLevel:\""+leadClassLevel+"\",trainingLevel:\""+trainingLevel+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String addArchivesInfo(String schoolId,String chineseName,String englishName,String permitteeLevel,String permitteeNum,String workMonth,String workYear,String workTime,String leadClassLevel,String trainingLevel)throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1002\",securityCode:\"0000000000\",params:{schoolId:\""+schoolId+"\",chineseName:\""+chineseName+"\",englishName:\""+englishName+"\",permitteeLevel:\""+permitteeLevel+"\",permitteeNum:\""+permitteeNum+"\",workMonth:\""+workMonth+"\",workYear:\""+workYear+"\",workTime:\""+workTime+"\",leadClassLevel:\""+leadClassLevel+"\",trainingLevel:\""+trainingLevel+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String updateArchivesInfo(String teacherId,String schoolId,String chineseName,String englishName,String permitteeLevel,String permitteeNum,String workMonth,String workYear,String workTime,String leadClassLevel,String trainingLevel)throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1003\",securityCode:\"0000000000\",params:{teacherId:\""+teacherId+"\",schoolId:\""+schoolId+"\",chineseName:\""+chineseName+"\",englishName:\""+englishName+"\",permitteeLevel:\""+permitteeLevel+"\",permitteeNum:\""+permitteeNum+"\",workMonth:\""+workMonth+"\",workYear:\""+workYear+"\",workTime:\""+workTime+"\",leadClassLevel:\""+leadClassLevel+"\",trainingLevel:\""+trainingLevel+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String deleteArchivesInfo(String teacherId)throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1004\",securityCode:\"0000000000\",params:{teacherId:\""+teacherId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
}
