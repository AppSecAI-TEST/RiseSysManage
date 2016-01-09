package com.rise.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rise.service.ExceptionBudgetService;

@Controller
@RequestMapping("/budget")
public class ExceptionBudgetController 
{
	private static Log log = LogFactory.getLog(AttendClassController.class);
	
	@Autowired
	private ExceptionBudgetService exceptionBudgetService;
	
	@RequestMapping(value = "/createNextMonthBudget.do")
	public void createNextMonthBudget(String schoolId, String schoolName, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = exceptionBudgetService.createNextMonthBudget(schoolId, schoolName);
			log.error(retVal);
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
	
	@RequestMapping(value = "/batchUpdateNextMonthBudget.do")
	public void batchUpdateNextMonthBudget(String param, HttpServletResponse response)
	{
		log.error(param);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = exceptionBudgetService.batchUpdateNextMonthBudget(param);
			log.error(retVal);
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
