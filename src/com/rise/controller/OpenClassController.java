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

import com.rise.service.CreateClassService;
import com.rise.service.OpenClassService;

/**
 * 开班
 * @author wm
 */
@Controller
@RequestMapping("/openClass")
public class OpenClassController 
{
	private static Log log = LogFactory.getLog(CreateClassController.class);
	
	@Autowired
	private CreateClassService createClassService;
	
	@Autowired
	private OpenClassService openClassService;
	
	@RequestMapping(value = "/qryCreateClass.do")
	public ModelAndView qryCreateClass(String classInstId, String applyType, String type)
	{
		log.error(classInstId);
		ModelAndView view = null;
		if("normal".equals(type)) {
			view = new ModelAndView("openClass/normalOpenClass");
		} else if("exception".equals(type)) {
			view = new ModelAndView("openClass/exceptionOpenClass");
		} else if("update".equals(type)) {
			view = new ModelAndView("openClass/updateStartDate");
		} else if("view".equals(type)) {
			view = new ModelAndView("openClass/viewOpenClass");
		} else if("cancel".equals(type)) {
			view = new ModelAndView("openClass/cancelOpenClass");
		} else if("approve".equals(type)) {
			view = new ModelAndView("openClass/approveOpenClass");
		}
		try 
		{
			String retVal = createClassService.qryCreateClassById(classInstId, applyType);
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
	
	//开班申请
	@RequestMapping(value = "/applyOpenClass.do")
	public void applyOpenClass(String param, HttpServletResponse response)
	{
		log.error(param);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = openClassService.applyOpenClass(param);
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
	
	//修改开课时间或者是取消放班
	@RequestMapping(value = "/updateOrCancel.do")
	public void updateOrCancel(String param, HttpServletResponse response)
	{
		log.error(param);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = openClassService.updateOrCancel(param);
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
	
	//开班审批
	@RequestMapping(value = "/approveOpenClass.do")
	public void approveOpenClass(String param, HttpServletResponse response)
	{
		log.error(param);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = openClassService.approveOpenClass(param);
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
	
	//校验老师在某一个时间段内是否带课
	@RequestMapping(value = "/validateTeacher.do")
	public void validateTeacher(String param, HttpServletResponse response)
	{
		log.error(param);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = openClassService.validateTeacher(param);
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
