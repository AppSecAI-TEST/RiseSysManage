package com.rise.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.rise.model.FuncNodeTree;
import com.rise.model.StaffT;
import com.rise.pub.base.JacksonJsonMapper;
import com.rise.pub.invoke.ServiceEngine;
import com.rise.pub.util.ObjectCensor;
import com.rise.pub.util.StringUtil;

/**
 * @author LEO
 * 登录信息验证与获取(子项目服务层)
 */
@Service
public class AuthService 
{

	//获取随机字符串
	public String getSecurityCode()
	{
		int randNum = (int)(Math.random()*9000)+1000;
		return String.valueOf(randNum%10000);
	}
	
	public String userCenter(HttpSession session , String username , String password) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2001\",securityCode:\"0000000000\",params:{userName:\""+username+"\",password:\""+password+"\"},rtnDataFormatType:\"user-defined\"}";
		String result = ServiceEngine.invokeHttp(param);
		String retVal = null;
		try
		{
			JSONObject json = JSONObject.fromObject(result);
			String flag = StringUtil.getJSONObjectKeyVal(json, "flag");
			if(!ObjectCensor.isStrRegular(flag))
			{
				ObjectMapper mapper = JacksonJsonMapper.getInstance();
				JavaType javaType = mapper.getTypeFactory().constructParametricType(ArrayList.class, FuncNodeTree.class);
				List funcNodeInfo = (List)mapper.readValue(json.getJSONArray("funcNodeInfo").toString(), javaType);
				StaffT staffT = (StaffT)JSONObject.toBean(json.getJSONObject("staff"), StaffT.class);
				session.setAttribute("StaffT", staffT);
				session.setAttribute("funcNodeInfo", funcNodeInfo);
				retVal = "success";
			}
			else
			{
				retVal = StringUtil.getJSONObjectKeyVal(json, "msg");
			}
		}
		catch(Exception err)
		{
			err.printStackTrace();
			retVal = result;
		}
		return retVal;
	}
	
	public String menuLeft(String menuId , StaffT staffT , HttpSession session) throws Exception
	{
		Map<String,String> map = (Map<String,String>)session.getAttribute("menuNodeInfo");
		if(ObjectCensor.checkObjectIsNull(map))
		{
			map = new HashMap<String,String>();
		}
		if(map.containsKey(menuId))
		{
			return map.get(menuId);
		}
		else
		{
			String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2002\",securityCode:\"0000000000\",params:{menuId:\""+menuId+"\",staffId:\""+staffT.getStaffId()+"\"},rtnDataFormatType:\"user-defined\"}";
			String result = ServiceEngine.invokeHttp(param);
			map.put(menuId, result);
			session.setAttribute("menuNodeInfo", map);
			return result;
		}
	}
	
	public String logoutStaff(int staffId , String remoteIp) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20014\",securityCode:\"0000000000\",params:{staffId:\""+staffId+"\",remoteIp:\""+remoteIp+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
}

