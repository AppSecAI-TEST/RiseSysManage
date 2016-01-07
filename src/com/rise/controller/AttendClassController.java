package com.rise.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.rise.service.AttendClassService;

/**
 * 在读班管理
 * @author wm
 */
@Controller
@RequestMapping("/attendClass")
public class AttendClassController 
{
	private static Log log = LogFactory.getLog(AttendClassController.class);
	
	@Autowired
	private AttendClassService attendClassService;
	
	@RequestMapping(value = "/qryAttendClass.do")
	public ModelAndView qryAttendClass(String classInstId, String type)
	{
		log.error(classInstId);
		ModelAndView view = null;
		if("maintenance".equals(type)) {
			view = new ModelAndView("attendClass/maintenanceClass");
		} else if("disband".equals(type)) {
			view = new ModelAndView("attendClass/disbandClass");
		} else if("view".equals(type)) {
			view = new ModelAndView("attendClass/viewAttendClass");
		} else if("finish".equals(type)) {
			view = new ModelAndView("finishClass/finishClass");
		} else if("viewFinish".equals(type)) {
			view = new ModelAndView("finishClass/viewFinishClass");
		}else if("numChange".equals(type)) {
			view = new ModelAndView("baseChange/change");
		}    
		try 
		{
			String retVal = attendClassService.qryAttendClassById(classInstId);
			JSONObject obj = JSONObject.fromObject(retVal);
			log.error(obj);
			view.addObject("obj", obj);
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return view;
	}
	
	@RequestMapping(value = "/disbandClass.do")
	public void disbandClass(String param, HttpServletResponse response)
	{
		log.error(param);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = attendClassService.disbandClass(param);
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
	
	//在读班变更老师
	@RequestMapping(value = "/changeTeacher.do")
	public void changeTeacher(String param, HttpServletResponse response)
	{
		log.error(param);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = attendClassService.changeTeacher(param);
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
	
	//在读班结课
	@RequestMapping(value = "/finishClass.do")
	public void finishClass(String param, HttpServletResponse response)
	{
		log.error(param);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = attendClassService.finishClass(param);
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
