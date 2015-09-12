package com.rise.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rise.pub.util.StringUtil;
import com.rise.service.CourseManageService;

@Controller
@RequestMapping("/courseManage")
public class CourseManageController {

	@Autowired
	private CourseManageService courseManageService;
	
	@RequestMapping(value="/qryCourseInfo.do")
	public void qryCourseInfo(HttpServletRequest request,HttpServletResponse response,String page,String rows,String json)
	{
		PrintWriter out = null;
		try {
			response.setCharacterEncoding("utf-8");
			out = response.getWriter();
			Integer pageNumInt = Integer.parseInt(page)-1;
			Integer pageSizeInt = Integer.parseInt(rows);
			String retVal = courseManageService.qryCourseInfo(pageNumInt, pageSizeInt, json);
			out.write(retVal);
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			if(out != null){
				out.close();
			}
		}
	}
	
}
