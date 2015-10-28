package com.rise.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;


import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rise.service.ClassroomService;

@Controller
@RequestMapping("/classroom")
public class ClassroomController 
{
	private static Log log = LogFactory.getLog(ClassroomController.class);
	
	@Autowired
	private ClassroomService cs;
	
	@RequestMapping("/addClassroom.do")
	public void addClassroom(String param, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = cs.addClassroom(param);
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
	
	@RequestMapping("/updateClassroom.do")
	public void updateClassroom(String param, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = cs.updateClassroom(param);
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
	
	@RequestMapping("/deleteClassroom.do")
	public void deleteClassroom(String roomId, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = cs.deleteClassroom(roomId);
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
	
	@RequestMapping("/getClassroomInfo.do")
	public void getClassroomInfo(String roomId, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = cs.getClassroomInfo(roomId);
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
