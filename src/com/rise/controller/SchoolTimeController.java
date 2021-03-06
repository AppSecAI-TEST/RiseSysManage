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
	
	@RequestMapping(value = "/getAllTimeByWeek.do")
	public void getAllTimeByWeek(String param, HttpServletResponse response) throws Exception
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = schoolTimeService.getAllSchoolTimeByWeek(param);
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
	
	/**
	 * 增加排课
	 * @param param
	 * @param response
	 */
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
	
	/**
	 * 删除排课
	 * @param param
	 * @param response
	 */
	@RequestMapping(value="/delete.do")
	public void deleteSchoolTime(String param,HttpServletResponse response)
	{
		
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = schoolTimeService.delSchoolTime(param);
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
	
	/**
	 * 增加排课
	 * @param param
	 * @param response
	 */
	@RequestMapping(value="/getWeek.do")
	public void getWeek(String param,HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = schoolTimeService.getWeek(param);
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
	
	@RequestMapping(value="/refreshPlan.do")
	public void refreshPlan(String param,HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = schoolTimeService.refreshPlan(param);
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
	
	/**
	 * 查询校区老师排课
	 * @param param
	 * @param response
	 */
	@RequestMapping(value="/getTeacherPlan.do")
	public void getTeacherPlan(String param,HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = schoolTimeService.getTpaln(param);
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
	
	@RequestMapping(value="/getTeacherTimePlan.do")
	public void getTeacherTimePlan(String param,HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = schoolTimeService.getTeacherTimePlan(param);
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
	
	/**
	 * 查询校区教室排课
	 * @param param
	 * @param response
	 */
	@RequestMapping(value="/getRoomPlan.do")
	public void getRoomPlan(String param,HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = schoolTimeService.getRoomTimePlans(param);
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
		

	/**
	 * 查询校区老师排课
	 * @param param
	 * @param response
	 */
	@RequestMapping(value="/updateCreateWeek.do")
	public void updateCreateWeek(String createWeekId,HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = schoolTimeService.updateCreateWeek(createWeekId);
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
	
	/**
	 * 查询校区老师排课
	 * @param param
	 * @param response
	 */
	@RequestMapping(value="/roomPlan.do")
	public void getRoomWeekPlan(String schoolId,HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = schoolTimeService.getRoomPlan(schoolId);
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
	
	/**
	 * 查询校区老师排课
	 * @param param
	 * @param response
	 */
	@RequestMapping(value="/teacherPlan.do")
	public void getTeacherWeekPlan(String schoolId,HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = schoolTimeService.getTeacherPlan(schoolId);
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
	
	/**
	 * 查询校区老师排课
	 * @param param
	 * @param response
	 */
	@RequestMapping(value="/refreshClassDate.do")
	public void refreshClassDate(HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = schoolTimeService.reFreshClassDate();
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
	
	/**
	 * 查询校区老师排课
	 * @param param
	 * @param response
	 */
	@RequestMapping(value="/hoursPlan.do")
	public void hoursPlan(String schoolId,String month,HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = schoolTimeService.getHoursPlan(schoolId,month);
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
	
	/**
	 * 查询老师排期表时间
	 * @param param
	 * @param response
	 */
	@RequestMapping(value="/getPlanTime.do")
	public void getPlanTime(String schoolId,String month,HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = schoolTimeService.getPlanTime(schoolId,month);
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
