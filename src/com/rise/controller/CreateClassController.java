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

@Controller
@RequestMapping("/applyClass")
public class CreateClassController 
{
	private static Log log = LogFactory.getLog(CreateClassController.class);
	
	@Autowired
	private CreateClassService createClassService;
	
	//����Ű�
	@RequestMapping(value = "/applyCreateClass.do")
	public void applyCreateClass(String param, HttpServletResponse response)
	{
		log.error(param);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = createClassService.applyCreateClass(param);
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
	
	//���ݰ༶ʵ��ID��ѯ����Ű�����
	@RequestMapping(value = "/qryCreateClassById.do")
	public void qryCreateClassById(String classInstId, HttpServletResponse response)
	{
		log.error(classInstId);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = createClassService.qryCreateClassById(classInstId);
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
	
	//�����Ű����������ȡ���Ű�����
	@RequestMapping(value = "/approveApplyClass.do")
	public void approveApplyClass(String param, HttpServletResponse response)
	{
		log.error(param);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = createClassService.approveApplyClass(param);
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
	
	//ȡ���Ű�����
	@RequestMapping(value = "/cancelApplyClass.do")
	public void cancelApplyClass(String param, HttpServletResponse response)
	{
		log.error(param);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = createClassService.cancelApplyClass(param);
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
	
	@RequestMapping(value = "/qryCreateClass.do")
	public ModelAndView qryCreateClass(String classInstId, String type)
	{
		log.error(classInstId);
		ModelAndView view = null;
		if("update".equals(type)) {
			view = new ModelAndView("applyClass/updateApplyClass");
		} else {
			view = new ModelAndView("applyClass/viewApplyClass");
		}
		try 
		{
			String retVal = createClassService.qryCreateClassById(classInstId);
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
	
	//�༶ά��
	@RequestMapping(value = "/updateCreateClass.do")
	public void updateCreateClass(String param, HttpServletResponse response)
	{
		log.error(param);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = createClassService.updateCreateClass(param);
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
	
	//�����Ƴ�ѧԱ
	@RequestMapping(value = "/batchRemoveStudent.do")
	public void batchRemoveStudent(String param, HttpServletResponse response)
	{
		log.error(param);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = createClassService.batchRemoveStudent(param);
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
	
	//��༶���ѧԱ
	@RequestMapping(value = "/addClassStudent.do")
	public void addClassStudent(String param, HttpServletResponse response)
	{
		log.error(param);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = createClassService.addClassStudent(param);
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
	
	//��ѯ�����༶��ѧԱ��Ϣ
	@RequestMapping(value = "/qryDataByQueryCode.do")
	public void qryDataByQueryCode(String param, HttpServletResponse response)
	{
		log.error(param);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = createClassService.qryDataByQueryCode(param);
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
	
	@RequestMapping(value = "/qryClassName.do")
	public void qryClassName(String courseType, String classType, String stageId, HttpServletResponse response)
	{
		log.error(courseType);
		log.error(classType);
		log.error(stageId);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = createClassService.qryClassName(courseType, classType, stageId);
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
