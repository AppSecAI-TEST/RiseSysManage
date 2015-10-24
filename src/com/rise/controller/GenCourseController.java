package com.rise.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.rise.service.GenCourseService;


@Controller
@RequestMapping("/genCourseConfig")
public class GenCourseController {

	private static Log log = LogFactory.getLog(GenCourseController.class);
	
	@Autowired
	private GenCourseService genCourseService;
	
	//�����γ̽׶�
	@RequestMapping(value="/addStage.do")
	public void addStage(HttpServletResponse response,String json)
	{
		log.error(json);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = genCourseService.addStage(json);
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
	
	//�޸Ŀγ̽׶�
	@RequestMapping(value="/updateStage.do")
	public void updateStageConfig(HttpServletResponse response,String json)
	{
		log.error(json);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = genCourseService.updateStageConfig(json);
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
	
	//�����༶����
	@RequestMapping(value="/addClassType.do")
	public void addClassTypeConfig(HttpServletResponse response,String json)
	{
		log.error(json);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = genCourseService.addClassTypeConfig(json);
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
	
	//�޸İ༶����
	@RequestMapping(value="/updateClassType.do")
	public void updateClassTypeConfig(HttpServletResponse response,String json)
	{
		log.error(json);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = genCourseService.updateClassTypeConfig(json);
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
	
	//ɾ���༶����
	@RequestMapping(value="/deleteClassType.do")
	public void deleteClassTypeConfig(HttpServletResponse response,String classId)
	{
		log.error(classId);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = genCourseService.deleteClassTypeConfig(classId);
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
	
	//ɾ���γ̽׶�
	@RequestMapping(value="/deleteStage.do")
	public void deleteStageConfig(HttpServletResponse response,String id,String stageId)
	{
		log.error(id);
		log.error(stageId);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = genCourseService.deleteStageConfig(id,stageId);
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
	
	//�޸Ŀ�������
	@RequestMapping(value="/updateClassNum.do")
	public void updateClassNum(HttpServletResponse response,String json)
	{
		log.error(json);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = genCourseService.updateClassNum(json);
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
			String retVal = genCourseService.qryDataListByPage(page, rows, param, funcNodeId);
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
	
	@RequestMapping(value="/jumpToAddPrice.do")
	public ModelAndView jumpToAddPrice(String type)
	{
		ModelAndView view = null;
		try {
			if("COMMON".equals(type)){//��ת��ӿγ̼۸�����ҳ��
				view = new ModelAndView("genCourseConfig/addComPrice");
				String ret = genCourseService.getAllClassType();
				view.addObject("obj",JSONObject.fromObject(ret));
			}else if("LINK".equals(type)){//��ת��������Ż�����ҳ��
				view = new ModelAndView("genCourseConfig/addLinkPrice");
			}else if("DISCOUNT".equals(type)){//��ת��Ӹ����ۿ�����ҳ��
				view = new ModelAndView("genCourseConfig/addDiscountPrice");
			}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return view;
	}
	
}
