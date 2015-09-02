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
		obj.put("name", "ѧԱ����");
		JSONArray itemArr = new JSONArray();
		String[] nameArr = {"��������","�γ̹���","ѡ�����","ת����� ","תУ����","��ѧ����","�쳣����","�˷ѹ���","VIPѧԱ����","���õ���","ȷ���������"};
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
		obj1.put("name", "ϵͳ����");
		JSONArray itemArr1 = new JSONArray();
		String[] nameArr1 = {"��������","�γ̹���","ѡ�����","ת����� ","תУ����","��ѧ����","�쳣����","�˷ѹ���","VIPѧԱ����","���õ���","ȷ���������"};
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

