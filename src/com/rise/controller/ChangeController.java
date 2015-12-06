package com.rise.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.rise.service.ChangeService;

/**
 * 转班、转校
 * @author wm
 */
@Controller
@RequestMapping("/change")
public class ChangeController 
{
	private static Log log = LogFactory.getLog(ChangeController.class);
	
	@Autowired
	private ChangeService changeService;
	
	//申请转班
	@RequestMapping(value = "/applyChangeClass.do")
	public void applyChangeClass(String param, HttpServletResponse response)
	{
		log.error(param);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = changeService.applyChangeClass(param);
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
	
	//转班审批
	@RequestMapping(value = "/approveChangeClass.do")
	public void approveChangeClass(String param, HttpServletResponse response)
	{
		log.error(param);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = changeService.approveChangeClass(param);
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
	
	//转出班级
	@RequestMapping(value = "/changeOut.do")
	public void changeOut(String param, HttpServletResponse response)
	{
		log.error(param);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = changeService.changeOut(param);
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
	
	//转入班级
	@RequestMapping(value = "/changeIn.do")
	public void changeIn(String param, HttpServletResponse response)
	{
		log.error(param);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = changeService.changeIn(param);
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
	
	//取消转班
	@RequestMapping(value = "/cancelChange.do")
	public void cancelChange(String param, HttpServletResponse response)
	{
		log.error(param);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = changeService.cancelChange(param);
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
	
	//更改转班
	@RequestMapping(value = "/updateChangeClass.do")
	public void updateChangeClass(String param, HttpServletResponse response)
	{
		log.error(param);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = changeService.updateChangeClass(param);
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
	
	//转出校区
	@RequestMapping(value = "/changeOutSchool.do")
	public void changeOutSchool(String param, HttpServletResponse response)
	{
		log.error(param);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = changeService.changeOutSchool(param);
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
	
	//转入校区
	@RequestMapping(value = "/changeInSchool.do")
	public void changeInSchool(String param, HttpServletResponse response)
	{
		log.error(param);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = changeService.changeInSchool(param);
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
	
	//取消转校
	@RequestMapping(value = "/cancelChangeSchool.do")
	public void cancelChangeSchool(String param, HttpServletResponse response)
	{
		log.error(param);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = changeService.cancelChangeSchool(param);
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
	
	@RequestMapping(value = "/viewChangeInfo.do")
	public ModelAndView viewChangeInfo(String param, String changeType)
	{
		log.error(changeType);
		ModelAndView view = null;
		if("changeClass".equals(changeType)) {
			view = new ModelAndView("changeClass/studentChangeClassList");
		} else if("changeSchool".equals(changeType)) {
			view = new ModelAndView("changeSchool/studentChangeSchoolList");
		} else if("leave".equals(changeType)) {
			view = new ModelAndView("leaveManage/studentLeaveList");
		} else if("exception".equals(changeType)) {
			view = new ModelAndView("exception/studentExceptionList");
		}
		try 
		{
			log.error(param);
			String retVal = changeService.viewChangeInfo(param);
			JSONArray array = JSONArray.fromObject(retVal);
			log.error(array);
			view.addObject("array", array);
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return view;
	}
}
