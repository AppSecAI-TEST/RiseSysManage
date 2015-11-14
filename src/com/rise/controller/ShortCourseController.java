package com.rise.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rise.service.ShortCourseService;

@Controller
@RequestMapping("/shortCourseConfig")
public class ShortCourseController {

	private static Log log = LogFactory.getLog(ShortCourseController.class);
	
	@Autowired
	private ShortCourseService shortCourseService;
	
	//新增短期课
	@RequestMapping(value="/addShortClass.do")
	public void addShortClass(HttpServletResponse response,String json)
	{
		log.error(json);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = shortCourseService.addShortClass(json);
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
	
	//删除短期课
	@RequestMapping(value="/deleteShortClass.do")
	public void deleteShortClass(HttpServletResponse response,String shortClassId)
	{
		log.error(shortClassId);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = shortCourseService.deleteShortClass(shortClassId);
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
	
	//新增短期课类型
	@RequestMapping(value="/addShortClassType.do")
	public void addShortClassType(HttpServletResponse response,String json)
	{
		log.error(json);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = shortCourseService.addShortClassType(json);
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
	
	//修改短期课类型
	@RequestMapping(value="/updateShortClassType.do")
	public void updateShortClassType(HttpServletResponse response,String json)
	{
		log.error(json);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = shortCourseService.updateShortClassType(json);
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
	
	//删除短期课
	@RequestMapping(value="/deleteShortClassType.do")
	public void deleteShortClassType(HttpServletResponse response,String classTypeId)
	{
		log.error(classTypeId);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = shortCourseService.deleteShortClassType(classTypeId);
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
