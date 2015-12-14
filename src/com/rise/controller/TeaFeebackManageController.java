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
	public ModelAndView qryClassStuByInstId(HttpServletResponse response,String classInstId,String qualityId,String schoolId,String className)
	{
		log.error(classInstId);
		ModelAndView view = new ModelAndView("teaFeebackManage/addTeaFeedback");
		try {
			String ret = teaFeebackManageService.qryClassStuByInstId(classInstId);
			view.addObject("classInstId", classInstId);
			view.addObject("qualityId", qualityId);
			view.addObject("schoolId", schoolId);
			view.addObject("className", className);
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
	public ModelAndView viewTeachingFeedback(String feedbackId)
	{
		log.error(feedbackId);
		ModelAndView view = new ModelAndView("teaFeebackManage/viewTeaFeedback");
		try {
			String ret = teaFeebackManageService.viewTeachingFeedback(feedbackId);
			view.addObject("obj",JSONObject.fromObject(ret));
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return view;
	}
	
}
