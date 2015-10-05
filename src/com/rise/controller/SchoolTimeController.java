package com.rise.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rise.service.SchoolTimeService;

/**
 * 排课
 * @author Lapalnd_Alone
 *
 */
@Controller
@RequestMapping("/time")
public class SchoolTimeController
{

	@Autowired
	public SchoolTimeService schoolTimeService;
	
	/**
	 * 获取一周的排课计划
	 * @param param
	 * @param response
	 * @throws Exception
	 */
	@RequestMapping(value = "/getTimeByWeek.do")
	public void getStuCourses(String param, HttpServletResponse response) throws Exception
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = schoolTimeService.getSchoolTimeByWeek(param);
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
	
	@RequestMapping(value="/add.do")
	public void addSchoolTime(String param,HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = schoolTimeService.addSchoolTime(param);
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
