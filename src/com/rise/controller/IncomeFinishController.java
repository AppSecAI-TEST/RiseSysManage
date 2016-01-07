package com.rise.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.rise.service.IncomeFinishService;

@Controller
@RequestMapping("/incomeFinish")
public class IncomeFinishController 
{
	@Autowired
	private IncomeFinishService incomeFinishService;
	
	@RequestMapping(value = "/accessRecordPage.do")
	public ModelAndView accessRecordPage(String incomeFlag)
	{
		StringBuilder pageBuf = new StringBuilder("tieOff/").append(incomeFlag).append("TieOffRecord");
		ModelAndView model = new ModelAndView(pageBuf.toString());
		try 
		{
			incomeFinishService.accessRecordPage(model, incomeFlag);
		}
		catch (Exception e) 
		{
			// TODO: handle exception
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping(value = "/getRecordInfo.do")
	public void getRecordInfo(HttpServletResponse response , String monthDate , String incomeFlag)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = incomeFinishService.getRecordInfo(monthDate, incomeFlag);
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
	
	@RequestMapping(value = "/addIncomeFinishRecord.do")
	public void addIncomeFinishRecord(HttpServletResponse response , String json)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = incomeFinishService.addIncomeFinishRecord(json);
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
