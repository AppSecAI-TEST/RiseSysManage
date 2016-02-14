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
	private static Log log = LogFactory.getLog(QryPubDataController.class);
	
	@Autowired
	private QryPubDataService qryPubDataService;
	
	//查询code_name_t表
	@RequestMapping(value = "/qryCodeNameList.do")
	public void qryCodeNameList(String tableName, String codeType, String codeFlag, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = qryPubDataService.qryCodeNameList(tableName, codeType, codeFlag);
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
	
	//查询学校列表
	@RequestMapping(value = "/qrySchoolList.do")
	public void qrySchoolList(String schoolId, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = qryPubDataService.qrySchoolList(schoolId);
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
	
	//查询学校列表
	@RequestMapping(value = "/qrySchoolListWithTS.do")
	public void qrySchoolListWithTS(String schoolId, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = qryPubDataService.qrySchoolListWithTS(schoolId);
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
	
	//查询职务列表
	@RequestMapping(value = "/qryPostList.do")
	public void qryPostList(String postId, String postType, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = qryPubDataService.qryPostList(postId,postType);
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
	
	//查询员工
	@RequestMapping(value = "/qryStaffList.do")
	public void qryStaffList(String post, String schoolId, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = qryPubDataService.qryStaffList(post, schoolId);
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
	
	//查询para_confgi表
	@RequestMapping(value = "/qryParaConfigList.do")
	public void qryParaConfigList(String paramType, String paramValue, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = qryPubDataService.qryParaConfigList(paramType, paramValue);
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
	
	//查询班级实例
	@RequestMapping(value = "/qryClassInstList.do")
	public void qryClassInstList(String schoolId, String courseType, String stageId, 
			String classType, String classState, String classInstId, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = qryPubDataService.qryClassInstList(schoolId, courseType, stageId, classType, classState, classInstId);
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
	
	//查询上课时段
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
	
	//查询教室
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
	
	//查询老师列表
	@RequestMapping(value = "/qryTeacherList.do")
	public void qryTeacherList(String schoolId, String classType, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = qryPubDataService.qryTeacherList(schoolId, classType);
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
	
	//查询学员资料列表
	@RequestMapping(value = "/qryDataListByPage.do")
	public void qryDataListByPage(String page, String rows, String param, String funcNodeId, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = qryPubDataService.qryDataListByPage(page, rows, param, funcNodeId);
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
	
	@RequestMapping(value = "/qryData.do")
	public void qryData( String param, HttpServletResponse response)
	{
		log.error(param);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = qryPubDataService.qryData(param);
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
	
	@RequestMapping(value = "/qryAction.do")
	public void qryAction(String schoolId, HttpServletResponse response)
	{
	 
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = qryPubDataService.qryAction(schoolId);
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
	
	/**
	 * 查询阶段
	 * @param response
	 */
	@RequestMapping(value = "/qryStage.do")
	public void getStage( HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = qryPubDataService.getStage();
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
	
	/**
	 * 查询班级价格体系
	 * @author Lapalnd_Alone
	 * @param response
	 */
	@RequestMapping(value = "/getClassPrice.do")
	public void getClassPrice(String stageId,String schoolId, HttpServletResponse response)
	{
	 
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = qryPubDataService.getClassPrice(schoolId, stageId);
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
	
	/**
	 * 查询班级
	 * @author Lapalnd_Alone
	 * @param response
	 */
	@RequestMapping(value = "/getClassType.do")
	public void getClassType(String stageId,HttpServletResponse response)
	{
	 
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = qryPubDataService.getClassType(stageId);
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
	
	/**
	 * 查询指定校区所拥有的老师
	 * @param schoolId
	 * @param response
	 */
	@RequestMapping(value = "/getTeacherBySchoolId.do")
	public void getTeacherBySchoolId(String schoolId,HttpServletResponse response)
	{
	 
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = qryPubDataService.getTeacherBySchoolId(schoolId);
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
	
	//查询短期课
	@RequestMapping(value = "/qryShortClass.do") 
	public void qryShortClass(HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = qryPubDataService.qryShortClass();
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
	
	@RequestMapping(value = "/qryStudentListByClassInstId.do") 
	public void qryStudentListByClassInstId(String classInstId, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = qryPubDataService.qryStudentListByClassInstId(classInstId);
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
	
	@RequestMapping(value = "/qryQuarterList.do")
	public void qryQuarterList(HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = qryPubDataService.qryQuarterList();
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
	
	@RequestMapping(value = "/qryMonthList.do")
	public void qryMonthList(String quarter, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = qryPubDataService.qryMonthList(quarter);
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
	
	@RequestMapping(value = "/qryRegionList.do")
	public void qryRegionList(HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = qryPubDataService.qryRegionList();
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
	
	@RequestMapping(value = "/qryReportYearList.do")
	public void qryReportYearList(String tableName, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = qryPubDataService.qryReportYearList(tableName);
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
	
	@RequestMapping(value = "/qryReportMonthList.do")
	public void qryReportMonthList(String tableName, String year, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = qryPubDataService.qryReportMonthList(tableName, year);
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
	
	@RequestMapping(value = "/qryReportWeekList.do")
	public void qryReportWeekList(String tableName, String year, String month, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = qryPubDataService.qryReportWeekList(tableName, year, month);
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
