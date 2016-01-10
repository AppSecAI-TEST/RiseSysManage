package com.rise.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rise.service.SysCacheService;

@Controller
@RequestMapping("/cache")
public class SysCacheController 
{

	@Autowired
	private SysCacheService sysCacheService;
	
	@RequestMapping("/flushCache.do")
	public void flushCache(HttpServletResponse response , String cacheName)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = sysCacheService.flushCache(cacheName);
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
	
	@RequestMapping("/flushAllCache.do")
	public void flushAllCache(HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = sysCacheService.flushAllCache();
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
	
	@RequestMapping(value = "/sysCacheList.do")
	public void sysCacheList(String page, String rows, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			Integer pageNumInt = Integer.parseInt(page)-1;
			Integer pageSizeInt = Integer.parseInt(rows);
			String retVal = sysCacheService.sysCacheList(pageNumInt*pageSizeInt, pageSizeInt);
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
