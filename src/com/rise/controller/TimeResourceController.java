package com.rise.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rise.service.TimeResourceService;

@Controller
@RequestMapping("/timeResource")
public class TimeResourceController 
{
	private static Log log = LogFactory.getLog(TimeResourceController.class);
	
	@Autowired
	private TimeResourceService ts;
	
	@RequestMapping("/getYearTimeResource.do")
	public void getYearTimeResource(String year, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = ts.getYearTimeResource(year);
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
	
	
	
	@RequestMapping("/addTimeResource.do")
	public void addTimeResource(String param, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = ts.addTimeResource(param);
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
	
	@RequestMapping("/updateTimeResource.do")
	public void updateTimeResource(String param, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = ts.updateTimeResource(param);
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
	
	@RequestMapping("/getClassTimeConfigInfo.do")
	public void getClassTimeConfigInfo(HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			JSONObject retVal = ts.getClassTimeConfigInfo();
			out.write(retVal.toString());
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
	
	@RequestMapping("/addClassTimeConfig.do")
	public void addClassTimeConfig(String param,HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = ts.addClassTimeConfig(param);
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
