package com.rise.service;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.rise.model.UserInfo;

@Service
public class AuthService {

	public String getSecurityCode()
	{
		int randNum = (int)(Math.random()*9000)+1000;
		return String.valueOf(randNum%10000);
	}
	
	public void userCenter(HttpSession session , ModelAndView model , String username , String password  , String code , String remoteIp)
	{
		UserInfo userInfo = new UserInfo();
		userInfo.setUserName(username);
		userInfo.setRealName("admin");
		userInfo.setUserIp(remoteIp);
		userInfo.setLastDate(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date()));
		session.setAttribute("UserInfo", userInfo);
	}
	
	public String menuLeft(String menuId)
	{
		JSONArray json = new JSONArray();
		JSONObject obj = new JSONObject();
		obj.put("name", "学员管理");
		JSONArray itemArr = new JSONArray();
		String[] nameArr = {"档案管理","课程管理","选班管理","转班管理 ","转校管理","休学管理","异常管理","退费管理","VIP学员管理","费用调整","确认收入管理"};
		for(int i = 0,n = nameArr.length;i < n;i++)
		{
			JSONObject item = new JSONObject();
			item.put("text", nameArr[i]);
			item.put("url", "/sys/teacherManage/archivesManage.jsp");
			itemArr.add(item);
		}
		obj.put("son", itemArr);
		json.add(obj);
		JSONObject obj1 = new JSONObject();
		obj1.put("name", "系统设置");
		JSONArray itemArr1 = new JSONArray();
		String[] nameArr1 = {"档案管理","课程管理","选班管理","转班管理 ","转校管理","休学管理","异常管理","退费管理","VIP学员管理","费用调整","确认收入管理"};
		for(int i = 0,n = nameArr.length;i < n;i++)
		{
			JSONObject item = new JSONObject();
			item.put("text", nameArr[i]);
			item.put("url", "/sys/student/studentList.jsp");
			itemArr1.add(item);
		}
		obj1.put("son", itemArr1);
		json.add(obj1);
		return json.toString();
	}
}

