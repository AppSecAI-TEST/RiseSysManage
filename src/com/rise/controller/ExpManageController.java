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

import com.rise.service.ExpManageService;

@Controller
@RequestMapping("/expManage")
public class ExpManageController {

	private static Log log = LogFactory.getLog(ExpManageController.class);
	
	@Autowired
	private ExpManageService expManageService;
	
	//�춯ά����ҳ���ѯ
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
			String retVal = expManageService.qryDataListByPage(page, rows, param, funcNodeId);
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
	
	//��ת�ͻ�ά��ҳ��
	@RequestMapping(value="/viewExpStuInfo.do")
	public ModelAndView viewExpStuInfo(String studentId,String studentCourseId,String expType,String json)
	{
		ModelAndView view = null;
		try {
			view = new ModelAndView("exceptionManage/viewExpStuInfo");
			String ret = expManageService.viewExpStuInfo(studentId, studentCourseId, expType);
			view.addObject("obj", JSONObject.fromObject(ret));
			view.addObject("expType",expType);
			view.addObject("expInfo", JSONObject.fromObject(json));
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return view;
	}
	
	//��ת���ҳ��
	@RequestMapping(value="/qryExpStuDetailInfo.do")
	public ModelAndView qryExpStuDetailInfo(String studentId,String studentCourseId,String expType)
	{
		ModelAndView view = null;
		try {
			view = new ModelAndView("exceptionManage/viewExpInfo");
			String ret = expManageService.qryExpStuDetailInfo(studentId, studentCourseId, expType);
			view.addObject("obj", JSONObject.fromObject(ret));
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return view;
	}
	
	//��Ӹ�����¼
	@RequestMapping(value="/addStuExpFollowInfo.do")
	public void addStuExpFollowInfo(HttpServletResponse response,String json)
	{
		log.error(json);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = expManageService.addStuExpFollowInfo(json);
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
