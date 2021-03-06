package com.rise.service;

import java.util.ArrayList;
import java.util.List;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.rise.model.ShortClassAttendT;
import com.rise.model.ShortClassInstT;
import com.rise.model.ShortClassTeacherT;
import com.rise.model.ShortSchooltimeT;
import com.rise.pub.base.JacksonJsonMapper;
import com.rise.pub.invoke.ServiceEngine;
import com.rise.pub.util.ObjectCensor;
import com.rise.pub.util.StringUtil;

@Service
public class ShortBusinessService 
{
	
	public String getShortClassTypeList(String typeName) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2051\",securityCode:\"0000000000\",params:{typeName:\""+typeName+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String getShortClassInstTList(String typeName , String classTypeId) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2052\",securityCode:\"0000000000\",params:{typeName:\""+typeName+"\",classTypeId:\""+classTypeId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public void getShortClassInfo(ModelAndView model , String shortClassInstId , String funcNodeId) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2053\",securityCode:\"0000000000\",params:{shortClassInstId:\""+shortClassInstId+"\"},rtnDataFormatType:\"user-defined\"}";
		String result = ServiceEngine.invokeHttp(params);
		try{
			ShortClassInstT shortClassInstT = JacksonJsonMapper.getInstance().readValue(result.toString(), ShortClassInstT.class);
			model.addObject("shortClassInstT", shortClassInstT);
			model.addObject("funcNodeId", funcNodeId);
		}catch(Exception err){
			err.printStackTrace();
			model.addObject("ErrorInfo", err.getMessage());
		}
	}
	
	public void getAddShortClassInfo(ModelAndView model , String shortClassInstId , String funcNodeId) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2054\",securityCode:\"0000000000\",params:{shortClassInstId:\""+shortClassInstId+"\"},rtnDataFormatType:\"user-defined\"}";
		String result = ServiceEngine.invokeHttp(params);
		try
		{
			JSONObject obj = JSONObject.fromObject(result);
			model.addObject("shortClassInstId", StringUtil.getJSONObjectKeyVal(obj, "shortClassInstId"));
			JSONArray jsonArr = obj.getJSONArray("shortClassList");
			if(jsonArr.size() != 0)
			{
				ObjectMapper mapper = JacksonJsonMapper.getInstance();
				JavaType javaType = mapper.getTypeFactory().constructParametricType(ArrayList.class, ShortSchooltimeT.class);
				List shortClassList = mapper.readValue(jsonArr.toString(), javaType);
				model.addObject("shortClassList", shortClassList);
			}
			else
			{
				model.addObject("shortClassList", new ArrayList<ShortSchooltimeT>());
			}
			model.addObject("funcNodeId", funcNodeId);
		}
		catch(Exception err)
		{			
			err.printStackTrace();
			model.addObject("ErrorInfo", err.getMessage());
		}
	}
	
	public String addShortSchooltimeTInfo(String json) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2055\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String addShortClassInstTInfo(String jsonClass , String jsonSchooltimeGroup , String className) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2056\",securityCode:\"0000000000\",params:{jsonClass:'"+jsonClass+"',jsonSchooltimeGroup:'"+jsonSchooltimeGroup+"',className:\""+className+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String delShortSchooltimeTInfo(String shortSchooltimeId) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2057\",securityCode:\"0000000000\",params:{shortSchooltimeId:'"+shortSchooltimeId+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String cancelShortClassFunc(String shortClassInstId , String remark , String handleId) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2058\",securityCode:\"0000000000\",params:{shortClassInstId:\""+shortClassInstId+"\",remark:\""+remark+"\",handleId:\""+handleId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String addShortStudentTInfo(String json , String classType , String shortClassInstId) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2059\",securityCode:\"0000000000\",params:{json:'"+json+"',classType:\""+classType+"\",shortClassInstId:\""+shortClassInstId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String delShortStudentList(String shortClassInstId , String studentIds , String handlerId) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20510\",securityCode:\"0000000000\",params:{shortClassInstId:\""+shortClassInstId+"\",studentIds:\""+studentIds+"\",handlerId:\""+handlerId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String updateShortClassInstTInfo(String json) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20511\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public void getShortClassAttendTInfo(ModelAndView model , String shortClassInstId , String funcNodeId , String pageName , int staffId) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20512\",securityCode:\"0000000000\",params:{shortClassInstId:\""+shortClassInstId+"\",staffId:\""+staffId+"\"},rtnDataFormatType:\"user-defined\"}";
		String result = ServiceEngine.invokeHttp(params);
		try
		{
			JSONObject obj = JSONObject.fromObject(result);
			ShortClassInstT shortClassInstT = JacksonJsonMapper.getInstance().readValue(obj.getJSONObject("shortClassInstT").toString(), ShortClassInstT.class);
			ShortSchooltimeT shortSchooltimeT = JacksonJsonMapper.getInstance().readValue(obj.getJSONObject("shortSchooltimeT").toString(), ShortSchooltimeT.class);
			model.addObject("roomList", obj.getJSONArray("roomList"));
			model.addObject("schoolList", obj.getJSONArray("schoolList"));
			model.addObject("teacherTypeList", obj.getJSONArray("teacherTypeList"));
			model.addObject("shortClassInstT", shortClassInstT);
			model.addObject("shortSchooltimeT", shortSchooltimeT);
			model.addObject("funcNodeId", funcNodeId);
			model.addObject("pageName", pageName);
		}
		catch(Exception err)
		{
			err.printStackTrace();
			model.addObject("ErrorInfo", err.getMessage());
		}
	}
	
	public void shortAttenceDetailPage(ModelAndView model , String shortClassInstId , String funcNodeId) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20514\",securityCode:\"0000000000\",params:{shortClassInstId:\""+shortClassInstId+"\"},rtnDataFormatType:\"user-defined\"}";
		String result = ServiceEngine.invokeHttp(params);
		try{
			JSONObject json = JSONObject.fromObject(result);
			ShortClassInstT shortClassInstT = JacksonJsonMapper.getInstance().readValue(json.getJSONObject("shortClassInstT").toString(), ShortClassInstT.class);
			ObjectMapper mapper = JacksonJsonMapper.getInstance();
			JavaType javaType = mapper.getTypeFactory().constructParametricType(ArrayList.class, ShortClassAttendT.class);
			List<ShortClassAttendT> shortClassAttendTList = mapper.readValue(json.getJSONArray("shortClassAttendTList").toString(), javaType);
			model.addObject("shortClassInstT", shortClassInstT);
			model.addObject("shortClassAttendTList", shortClassAttendTList);
			model.addObject("funcNodeId", funcNodeId);
		}catch(Exception err){
			err.printStackTrace();
			model.addObject("ErrorInfo", err.getMessage());
		}
	}
	
	public String addShortAttendTInfo(String json) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20513\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public void shortAttenceUpdatePage(ModelAndView model , String shortClassAttendId , String funcNodeId , String pageName) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20515\",securityCode:\"0000000000\",params:{shortClassAttendId:\""+shortClassAttendId+"\"},rtnDataFormatType:\"user-defined\"}";
		String result = ServiceEngine.invokeHttp(params);
		try{
			JSONObject obj = JSONObject.fromObject(result);
			ShortClassAttendT shortClassAttendT = JacksonJsonMapper.getInstance().readValue(obj.getJSONObject("shortClassAttendT").toString(), ShortClassAttendT.class);
			model.addObject("roomList", obj.getJSONArray("roomList"));
			model.addObject("schoolList", obj.getJSONArray("schoolList"));
			model.addObject("teacherTypeList", obj.getJSONArray("teacherTypeList"));
			model.addObject("shortClassAttendT", shortClassAttendT);
			model.addObject("funcNodeId", funcNodeId);
			model.addObject("pageName", pageName);
		}catch(Exception err){
			err.printStackTrace();
			model.addObject("ErrorInfo", err.getMessage());
		}
	}
	
	public void shortAttenceViewPage(ModelAndView model , String shortClassAttendId , String funcNodeId , String pageName) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20516\",securityCode:\"0000000000\",params:{shortClassAttendId:\""+shortClassAttendId+"\"},rtnDataFormatType:\"user-defined\"}";
		String result = ServiceEngine.invokeHttp(params);
		try{
			ShortClassAttendT shortClassAttendT = JacksonJsonMapper.getInstance().readValue(result, ShortClassAttendT.class);
			model.addObject("shortClassAttendT", shortClassAttendT);
			model.addObject("funcNodeId", funcNodeId);
			model.addObject("pageName", pageName);
		}catch(Exception err){
			err.printStackTrace();
			model.addObject("ErrorInfo", err.getMessage());
		}
	}
	
	public String updateShortAttendTInfo(String json) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20517\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String addTourismClassInfo(String json) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20518\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public void accessShortClassPage(ModelAndView model , String shortClassInstId , String funcNodeId , String classType) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20519\",securityCode:\"0000000000\",params:{shortClassInstId:\""+shortClassInstId+"\",classType:\""+classType+"\"},rtnDataFormatType:\"user-defined\"}";
		String result = ServiceEngine.invokeHttp(params);
		try{
			JSONObject obj = JSONObject.fromObject(result);
			ShortClassInstT shortClassInstT = JacksonJsonMapper.getInstance().readValue(obj.getJSONObject("shortClassInstT").toString(), ShortClassInstT.class);
			ObjectMapper mapper = JacksonJsonMapper.getInstance();
			JavaType javaType = mapper.getTypeFactory().constructParametricType(ArrayList.class, ShortClassTeacherT.class);
			List<ShortClassTeacherT> shortClassTeacherTList = mapper.readValue(obj.getJSONArray("shortClassTeacherTList").toString(), javaType);
			model.addObject("shortClassInstId", StringUtil.getJSONObjectKeyVal(obj, "shortClassInstId"));
			model.addObject("shortClassId", StringUtil.getJSONObjectKeyVal(obj, "shortClassId"));
			model.addObject("shortClassInstT", shortClassInstT);
			model.addObject("shortClassTeacherTList", shortClassTeacherTList);
			model.addObject("funcNodeId", funcNodeId);
		}catch(Exception err){
			err.printStackTrace();
			model.addObject("ErrorInfo", err.getMessage());
		}
	}
	
	public void accessShortAttenceDetail(ModelAndView model , String shortClassInstId , String funcNodeId) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20514\",securityCode:\"0000000000\",params:{shortClassInstId:\""+shortClassInstId+"\"},rtnDataFormatType:\"user-defined\"}";
		String result = ServiceEngine.invokeHttp(params);
		try{
			JSONObject obj = JSONObject.fromObject(result);
			ShortClassInstT shortClassInstT = JacksonJsonMapper.getInstance().readValue(obj.getJSONObject("shortClassInstT").toString(), ShortClassInstT.class);
			ObjectMapper mapper = JacksonJsonMapper.getInstance();
			JavaType javaType = mapper.getTypeFactory().constructParametricType(ArrayList.class, ShortClassAttendT.class);
			List<ShortClassAttendT> shortClassAttendTList = mapper.readValue(obj.getJSONArray("shortClassAttendTList").toString(), javaType);
			model.addObject("shortClassInstT", shortClassInstT);
			model.addObject("shortClassAttendTList", shortClassAttendTList);
			model.addObject("funcNodeId", funcNodeId);
		}catch(Exception err){
			err.printStackTrace();
			model.addObject("ErrorInfo", err.getMessage());
		}
	}
	
	public void tourismAttenceRecordPage(ModelAndView model , String shortClassInstId , String funcNodeId , int staffId) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20520\",securityCode:\"0000000000\",params:{shortClassInstId:\""+shortClassInstId+"\",staffId:\""+staffId+"\"},rtnDataFormatType:\"user-defined\"}";
		String result = ServiceEngine.invokeHttp(params);
		try{
			JSONObject obj = JSONObject.fromObject(result);
			ShortClassInstT shortClassInstT = JacksonJsonMapper.getInstance().readValue(obj.getJSONObject("shortClassInstT").toString(), ShortClassInstT.class);
			ObjectMapper mapper = JacksonJsonMapper.getInstance();
			JavaType javaType = mapper.getTypeFactory().constructParametricType(ArrayList.class, ShortClassTeacherT.class);
			List<ShortClassTeacherT> shortClassTeacherTList = mapper.readValue(obj.getJSONArray("shortClassTeacherTList").toString(), javaType);
			model.addObject("schoolList", obj.getJSONArray("schoolList"));
			model.addObject("shortClassInstT", shortClassInstT);
			model.addObject("shortClassTeacherTList", shortClassTeacherTList);
			model.addObject("funcNodeId", funcNodeId);
		}catch(Exception err){
			err.printStackTrace();
			model.addObject("ErrorInfo", err.getMessage());
		}
	}
	
	public String addShortTourismAttendTInfo(String json) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20521\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public void tourismAttenceRecUpdatePage(ModelAndView model , String shortClassAttendId , String funcNodeId , int staffId) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20522\",securityCode:\"0000000000\",params:{shortClassAttendId:\""+shortClassAttendId+"\",staffId:\""+staffId+"\"},rtnDataFormatType:\"user-defined\"}";
		String result = ServiceEngine.invokeHttp(params);
		try{
			JSONObject obj = JSONObject.fromObject(result);
			ShortClassInstT shortClassInstT = JacksonJsonMapper.getInstance().readValue(obj.getJSONObject("shortClassInstT").toString(), ShortClassInstT.class);
			ShortClassAttendT shortClassAttendT = JacksonJsonMapper.getInstance().readValue(obj.getJSONObject("shortClassAttendT").toString(), ShortClassAttendT.class);
			model.addObject("schoolList", obj.getJSONArray("schoolList"));
			model.addObject("shortClassInstT", shortClassInstT);
			model.addObject("shortClassAttendT", shortClassAttendT);
			model.addObject("funcNodeId", funcNodeId);
		}catch(Exception err){
			err.printStackTrace();
			model.addObject("ErrorInfo", err.getMessage());
		}
	}
	
	public String updateShortTourismAttenceInfo(String json) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20523\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String verifyShortClassFunc(String shortClassInstId , String handlerId , String isPutClass , String verifyCont) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20524\",securityCode:\"0000000000\",params:{shortClassInstId:'"+shortClassInstId+"',handlerId:\""+handlerId+"\",isPutClass:\""+isPutClass+"\",verifyCont:\""+verifyCont+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String getGiftTypeList() throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20525\",securityCode:\"0000000000\",params:{},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String addDirectShortClassInstInfo(String json , String classType , String schoolId , String stageId) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20526\",securityCode:\"0000000000\",params:{json:'"+json+"',classType:\""+classType+"\",schoolId:\""+schoolId+"\",stageId:\""+stageId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String cancelGiftClassFunc(String shortClassInstId , String remark , String classType , String handleId) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20527\",securityCode:\"0000000000\",params:{shortClassInstId:\""+shortClassInstId+"\",remark:\""+remark+"\",classType:\""+classType+"\",handleId:\""+handleId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
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
		String result = ServiceEngine.invokeHttp(params);
		JSONObject json = JSONObject.fromObject(result);
		if(json.containsKey("rows"))
		{
			JSONArray arrJSON = json.getJSONArray("rows");
			int warmupTimesNum = 0;
			int planHoursNum = 0;
			for(int i = 0,n = arrJSON.size();i < n;i++)
			{
				JSONObject item = arrJSON.getJSONObject(i);
				String warmupTimes = StringUtil.getJSONObjectKeyVal(item, "warmupTimes");
				String planHours = StringUtil.getJSONObjectKeyVal(item, "planHoursNum");
				if(ObjectCensor.isStrRegular(warmupTimes) && StringUtil.checkStringIsNum(warmupTimes))
				{
					warmupTimesNum += Integer.parseInt(warmupTimes);
				}
				if(ObjectCensor.isStrRegular(planHours) && StringUtil.checkStringIsNum(planHours))
				{
					planHoursNum += Integer.parseInt(planHours);
				}
			}
			JSONArray footArr = new JSONArray();
			JSONObject footJson = new JSONObject();
			footJson.put("schoolName", "�ܼ�");
			footJson.put("warmupTimes", warmupTimesNum);
			footJson.put("planHoursNum", planHoursNum);
			footArr.add(footJson);
			json.put("footer", footArr);
		}
		return json.toString();
	}
	
}
