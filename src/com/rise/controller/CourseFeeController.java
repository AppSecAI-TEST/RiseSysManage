package com.rise.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rise.service.CourseFeeService;


@Controller
@RequestMapping("/courseFee")
public class CourseFeeController 
{
	private static Log log = LogFactory.getLog(CourseFeeController.class);
	
	@Autowired
	private CourseFeeService cfs;
	
	@RequestMapping("/getCourseFeeInfo.do")
	public void getCourseFeeInfo(String studentCourseId, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = cfs.getCourseFeeInfo(studentCourseId);
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
	
	
	@RequestMapping("/changeFee.do")
	public void changeFee(String param, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = cfs.changeFee(param);
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
	
	
	@RequestMapping("/qryFeeChangeInfo.do")
	public void qryFeeChangeInfo(String studentCourseId, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = cfs.qryFeeChangeInfo(studentCourseId);
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
