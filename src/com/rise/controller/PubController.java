package com.rise.controller;

import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rise.service.PubService;

@Controller
@RequestMapping("/pub")
public class PubController 
{
	@Autowired
	private PubService pubService;
	
	@RequestMapping("/pageCategory.do")
	public void pageCategory(HttpServletResponse response , String staffId , String funcNodeId , String fieldId)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = pubService.pageCategory(staffId , funcNodeId , fieldId);
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
	
	@RequestMapping("/pageComboxList.do")
	public void pageComboxList(HttpServletResponse response , String funcNodeId , String fieldId)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = pubService.pageComboxList(funcNodeId , fieldId);
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
	
	@RequestMapping("/paramComboxList.do")
	public void paramComboxList(HttpServletResponse response , HttpServletRequest request)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			Map<String,String[]> paramMap = request.getParameterMap();
			String retVal = pubService.paramComboxList(paramMap);
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
