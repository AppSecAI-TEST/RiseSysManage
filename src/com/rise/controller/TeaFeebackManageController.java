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

import com.rise.service.TeaFeebackManageService;

@Controller
@RequestMapping("/teaFeebackManage")
public class TeaFeebackManageController {
	
private static Log log = LogFactory.getLog(TeaFeebackManageController.class);
	
	@Autowired
	private TeaFeebackManageService teaFeebackManageService;
	
	//根据班级实例Id查所有班级学员
	@RequestMapping(value="/qryClassStuByInstId.do")
	public ModelAndView qryClassStuByInstId(HttpServletResponse response,String classInstId,String qualityId,String schoolId,String className,String month)
	{
		log.error(classInstId);
		ModelAndView view = new ModelAndView("teaFeebackManage/addTeaFeedback");
		try {
			String ret = teaFeebackManageService.qryClassStuByInstId(classInstId,qualityId);
			view.addObject("classInstId", classInstId);
			view.addObject("qualityId", qualityId);
			view.addObject("schoolId", schoolId);
			view.addObject("className", className);
			view.addObject("month", month);
			view.addObject("obj",JSONObject.fromObject(ret));
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return view;
	}
	
	//新增教质反馈
	@RequestMapping(value="/addTeachingFeedback.do")
	public void addTeachingFeedback(HttpServletResponse response,String feedbackJson,String feedbackDetailJson)
	{
		log.error(feedbackJson);
		log.error(feedbackDetailJson);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = teaFeebackManageService.addTeachingFeedback(feedbackJson,feedbackDetailJson);
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
	
	//浏览教质反馈信息
	@RequestMapping(value="/viewTeachingFeedback.do")
	public ModelAndView viewTeachingFeedback(String feedbackId,String type)
	{
		log.error(feedbackId);
		ModelAndView view = null;
		try {
			if("view".equals(type)){
				view = new ModelAndView("teaFeebackManage/viewTeaFeedback");
			}else if("update".equals(type)){
				view = new ModelAndView("teaFeebackManage/updateTeaFeedback");
			}
			String ret = teaFeebackManageService.viewTeachingFeedback(feedbackId);
			view.addObject("obj",JSONObject.fromObject(ret));
			view.addObject("feedbackId", feedbackId);
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return view;
	}
	
	//修改教质反馈
	@RequestMapping(value="/updateTeachingFeedback.do")
	public void addTeachingFeedback(HttpServletResponse response,String json)
	{
		log.error(json);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = teaFeebackManageService.updateTeachingFeedback(json);
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
	
	//教质回访名单报表查询
	@RequestMapping(value = "/qryDataListByPage.do")
	public void qryDataListByPage(String page, String rows, String param, String funcNodeId, HttpServletResponse response)
	{
		log.error(page);
		log.error(rows);
		log.error(param);
		log.error(funcNodeId);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = teaFeebackManageService.qryDataListByPage(page, rows, param, funcNodeId);
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
