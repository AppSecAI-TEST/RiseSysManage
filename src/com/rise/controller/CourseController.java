package com.rise.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rise.service.CourseSerivce;

/**
 * �γ�
 * @author Lapalnd_Alone
 *
 */
@Controller
@RequestMapping("/course")
public class CourseController 
{

	@Autowired
	CourseSerivce courseSerivce;
	
	/**
	 * ��������γ�
	 * @param param
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/addLinkCourses.do")
	public void addLinkCourses(String param, HttpServletResponse response) throws Exception
	{
		courseSerivce.addLinkCourses(param);
	}
	
	/**
	 * ��ȡѧԱ�γ��б�
	 * @param param
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/getStuCourses.do")
	public void getStuCourses(String param, HttpServletResponse response) throws Exception
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = courseSerivce.getStuCourses(param);;
			out.write(retVal);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			if(out != null)
			{
				out.close();
			}
		}
	}
}
