package com.rise.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

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
	
}
