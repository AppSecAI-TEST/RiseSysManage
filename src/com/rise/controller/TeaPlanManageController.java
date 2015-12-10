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

import com.rise.service.TeaPlanManageService;

@Controller
@RequestMapping("/teaPlanManage")
public class TeaPlanManageController {

	private static Log log = LogFactory.getLog(TeaPlanManageController.class);
	
	@Autowired
	private TeaPlanManageService teaPlanManageService;
	
	//根据学校Id查所有有效班级实例
	@RequestMapping(value = "/qryClassInfoById.do")
	public void qryClassInfoById(HttpServletResponse response,String schoolId)
	{
		log.error(schoolId);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = teaPlanManageService.qryClassInfoById(schoolId);
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
	
	//新增教质计划
	@RequestMapping(value="/addTeachingPlan.do")
	public void addTeachingPlan(HttpServletResponse response,String createJson,String teachingJson)
	{
		log.error(createJson);
		log.error(teachingJson);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = teaPlanManageService.addTeachingPlan(createJson,teachingJson);
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
	
	//教质计划信息，根据不同类型跳转不同页面
	@RequestMapping(value="/viewTeachingPlanInfo.do")
	public ModelAndView viewTeachingPlanInfo(String createQualityId,String schoolName,String month,String type)
	{
		log.error(createQualityId);
		log.error(type);
		ModelAndView view = null;
		try {
			if("update".equals(type)){
				view = new ModelAndView("teaPlanManage/updateTeacherPlan");
			}else if("view".equals(type)){
				view = new ModelAndView("teaPlanManage/viewTeacherPlan");
			}
			String ret = teaPlanManageService.viewTeachingPlanInfo(createQualityId);
			view.addObject("schoolName", schoolName);
			view.addObject("month", month);
			view.addObject("obj",JSONObject.fromObject(ret));
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return view;
	}
	
	//修改教质计划
	@RequestMapping(value="/updateTeachingPlan.do")
	public void updateTeachingPlan(HttpServletResponse response,String json)
	{
		log.error(json);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = teaPlanManageService.updateTeachingPlan(json);
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
