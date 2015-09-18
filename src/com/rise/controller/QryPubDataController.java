package com.rise.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rise.service.QryPubDataService;

@Controller
@RequestMapping("/pubData")
public class QryPubDataController 
{
	private static Log log = LogFactory.getLog(StudentController.class);
	
	@Autowired
	private QryPubDataService qryPubDataService;
	
	//��ѯcode_name_t��
	@RequestMapping(value = "/qryCodeNameList.do")
	public void qryCodeNameList(String tableName, String codeType, String codeFlag, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = qryPubDataService.qryCodeNameList(tableName, codeType, codeFlag);
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
	
	//��ѯѧУ�б�
	@RequestMapping(value = "/qrySchoolList.do")
	public void qrySchoolList(String schoolId, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = qryPubDataService.qrySchoolList(schoolId);
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
	
	//��ѯԱ��
	@RequestMapping(value = "/qryStaffList.do")
	public void qryStaffList(String post, String schoolId, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = qryPubDataService.qryStaffList(post, schoolId);
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
	
	//��ѯpara_confgi��
	@RequestMapping(value = "/qryParaConfigList.do")
	public void qryParaConfigList(String paramType, String paramValue, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = qryPubDataService.qryParaConfigList(paramType, paramValue);
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
	
	//��ѯ�༶ʵ��
	@RequestMapping(value = "/qryClassInstList.do")
	public void qryClassInstList(String schoolId, String courseType, String stageId, 
			String classType, String classState, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = qryPubDataService.qryClassInstList(schoolId, courseType, stageId, classType, classState);
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
	
	//��ѯ�Ͽ�ʱ��
	@RequestMapping(value = "/qryHourRangeList.do")
	public void qryHourRangeList(String weekTime, HttpServletResponse response)
	{
		log.error(weekTime);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = qryPubDataService.qryHourRangeList(weekTime);
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
	
	//��ѯ����
	@RequestMapping(value = "/qryRoomList.do")
	public void qryRoomList(String schoolId, HttpServletResponse response)
	{
		log.error(schoolId);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = qryPubDataService.qryRoomList(schoolId);
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
	
	//��ѯ��ʦ�б�
	@RequestMapping(value = "/qryTeacherList.do")
	public void qryTeacherList(String schoolId, String classType, HttpServletResponse response)
	{
		log.error(schoolId);
		log.error(classType);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = qryPubDataService.qryTeacherList(schoolId, classType);
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
	
	//��ѯѧԱ�����б�
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
			String retVal = qryPubDataService.qryDataListByPage(page, rows, param, funcNodeId);
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