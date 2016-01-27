package com.rise.controller;

import java.io.OutputStream;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rise.pub.base.JacksonJsonMapper;
import com.rise.service.ActionService;
import com.rise.service.AuthService;
import com.rise.service.ExportService;

@Controller
@RequestMapping("/export")
public class ExportController 
{
	private static Log log = LogFactory.getLog(ExportController.class);
	
	@Autowired
	private ExportService es;
	
	@RequestMapping("/normalExport.do")
	public void normalExport(String fileName,String param, HttpServletResponse response , HttpServletRequest request)
	{
		OutputStream out = null;
		try
		{
			StringBuffer displayFileName = new StringBuffer(fileName);
			displayFileName.append(new SimpleDateFormat("yyMMdd").format(new Date()));
			displayFileName.append(".xls");
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-Disposition", "attachment;fileName="+URLEncoder.encode(displayFileName.toString(),"utf-8"));
			out = response.getOutputStream();
			es.normalExport(fileName,param , out);
		}
		catch(Exception err)
		{
			err.printStackTrace();
		}

	}
	
	@RequestMapping("/normalMergeExport.do")
	public void normalMergeExport(String fileName,String mergeName,String mergeIndex,String param, HttpServletResponse response , HttpServletRequest request)
	{
		OutputStream out = null;
		try
		{
			StringBuffer displayFileName = new StringBuffer(fileName);
			displayFileName.append(new SimpleDateFormat("yyMMdd").format(new Date()));
			displayFileName.append(".xls");
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-Disposition", "attachment;fileName="+URLEncoder.encode(displayFileName.toString(),"utf-8"));
			out = response.getOutputStream();
			es.normalMergeExport(fileName, mergeName, mergeIndex, param, out);
		}
		catch(Exception err)
		{
			err.printStackTrace();
		}

	}
	
	
	//导出总校教质汇总
	@RequestMapping("/exportCenterTeaFeedback.do")
	public void exportCenterTeaFeedback(String fileName,String param, HttpServletResponse response , HttpServletRequest request)
	{
		OutputStream out = null;
		try
		{
			StringBuffer displayFileName = new StringBuffer(fileName);
			displayFileName.append(new SimpleDateFormat("yyMMdd").format(new Date()));
			displayFileName.append(".xls");
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-Disposition", "attachment;fileName="+URLEncoder.encode(displayFileName.toString(),"utf-8"));
			out = response.getOutputStream();
			es.exportCenterTeaFeedback(fileName,param , out);
		}
		catch(Exception err)
		{
			err.printStackTrace();
		}

	}
	
	//查询总校教质汇总
	@RequestMapping(value = "/qryCenterTeaFeedback.do")
	public void qryCenterTeaFeedback(String param, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = es.qryCenterTeaFeedback(param);
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
	
	//查询教质未完成明细
	@RequestMapping(value = "/qryUnfinishFeedback.do")
	public void qryUnfinishFeedback(String param, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = es.qryUnfinishFeedback(param);
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
	
	// 导出教质未完成明细
	@RequestMapping(value = "/exportUnfinishFeedback.do")
	public void exportUnfinishFeedback(String fileName,String param, HttpServletResponse response , HttpServletRequest request)
	{
		OutputStream out = null;
		try
		{
			StringBuffer displayFileName = new StringBuffer(fileName);
			displayFileName.append(new SimpleDateFormat("yyMMdd").format(new Date()));
			displayFileName.append(".xls");
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-Disposition", "attachment;fileName="+URLEncoder.encode(displayFileName.toString(),"utf-8"));
			out = response.getOutputStream();
			es.exportUnfinishFeedback(fileName,param , out);
		}
		catch(Exception err)
		{
			err.printStackTrace();
		}
	}
	
	// 导出教师课时反馈
	@RequestMapping(value = "/exportTeacherAttend.do")
	public void exportTeacherAttend(String fileName,String param, HttpServletResponse response , HttpServletRequest request)
	{
		OutputStream out = null;
		try
		{
			StringBuffer displayFileName = new StringBuffer(fileName);
			displayFileName.append(new SimpleDateFormat("yyMMdd").format(new Date()));
			displayFileName.append(".xls");
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-Disposition", "attachment;fileName="+URLEncoder.encode(displayFileName.toString(),"utf-8"));
			out = response.getOutputStream();
			es.exportTeacherAttend(fileName,param , out);
		}
		catch(Exception err)
		{
			err.printStackTrace();
		}
	}
	
	
	// 导出教师个人业绩
	@RequestMapping(value = "/exportTeacherNum.do")
	public void exportTeacherNum(String fileName,String param, HttpServletResponse response , HttpServletRequest request)
	{
		OutputStream out = null;
		try
		{
			StringBuffer displayFileName = new StringBuffer(fileName);
			displayFileName.append(new SimpleDateFormat("yyMMdd").format(new Date()));
			displayFileName.append(".xls");
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-Disposition", "attachment;fileName="+URLEncoder.encode(displayFileName.toString(),"utf-8"));
			out = response.getOutputStream();
			es.exportTeacherNum(fileName,param , out);
		}
		catch(Exception err)
		{
			err.printStackTrace();
		}
	}
	
	// 导出班级明细
	@RequestMapping("/exportClassInstDetail.do")
	public void exportClassInstDetail(String fileName,String mergeName,String mergeIndex,String param, HttpServletResponse response , HttpServletRequest request)
	{
		OutputStream out = null;
		try
		{
			StringBuffer displayFileName = new StringBuffer(fileName);
			displayFileName.append(new SimpleDateFormat("yyMMdd").format(new Date()));
			displayFileName.append(".xls");
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-Disposition", "attachment;fileName="+URLEncoder.encode(displayFileName.toString(),"utf-8"));
			out = response.getOutputStream();
			es.exportClassInstDetail(fileName, mergeName, mergeIndex, param, out);
		}
		catch(Exception err)
		{
			err.printStackTrace();
		}

	}
	
	// 校区月季度升学率
	@RequestMapping("/exportSchoolMSGradRate.do")
	public void exportSchoolMSGradRate(String fileName,String year,String param, HttpServletResponse response , HttpServletRequest request)
	{
		OutputStream out = null;
		try
		{
			StringBuffer displayFileName = new StringBuffer(fileName);
			displayFileName.append(new SimpleDateFormat("yyMMdd").format(new Date()));
			displayFileName.append(".xls");
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-Disposition", "attachment;fileName="+URLEncoder.encode(displayFileName.toString(),"utf-8"));
			out = response.getOutputStream();
			es.exportSchoolMSGradRate(fileName, year, param, out);
		}
		catch(Exception err)
		{
			err.printStackTrace();
		}

	}
	
	
	// 总校年级升学率
	@RequestMapping("/exportCenterGradeRate.do")
	public void exportCenterGradeRate(String fileName,String param, HttpServletResponse response , HttpServletRequest request)
	{
		OutputStream out = null;
		try
		{
			StringBuffer displayFileName = new StringBuffer(fileName);
			displayFileName.append(new SimpleDateFormat("yyMMdd").format(new Date()));
			displayFileName.append(".xls");
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-Disposition", "attachment;fileName="+URLEncoder.encode(displayFileName.toString(),"utf-8"));
			out = response.getOutputStream();
			es.exportCenterGradeRate(fileName, param, out);
		}
		catch(Exception err)
		{
			err.printStackTrace();
		}

	}
	
	//总校月季度升学率
	@RequestMapping("/exportCenterMSRate.do")
	public void exportCenterMSRate(String fileName,String year,String param, HttpServletResponse response , HttpServletRequest request)
	{
		OutputStream out = null;
		try
		{
			StringBuffer displayFileName = new StringBuffer(fileName);
			displayFileName.append(new SimpleDateFormat("yyMMdd").format(new Date()));
			displayFileName.append(".xls");
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-Disposition", "attachment;fileName="+URLEncoder.encode(displayFileName.toString(),"utf-8"));
			out = response.getOutputStream();
			es.exportCenterMSRate(fileName,year, param, out);
		}
		catch(Exception err)
		{
			err.printStackTrace();
		}

	}
	
	//升学率缺口
	@RequestMapping("/exportLackOfGradRate.do")
	public void exportLackOfGradRate(String fileName,String year,String quarter, String param, HttpServletResponse response , HttpServletRequest request)
	{
		OutputStream out = null;
		try
		{
			StringBuffer displayFileName = new StringBuffer(fileName);
			displayFileName.append(new SimpleDateFormat("yyMMdd").format(new Date()));
			displayFileName.append(".xls");
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-Disposition", "attachment;fileName="+URLEncoder.encode(displayFileName.toString(),"utf-8"));
			out = response.getOutputStream();
			es.exportLackOfGradRate(fileName,year,quarter,param, out);
		}
		catch(Exception err)
		{
			err.printStackTrace();
		}

	}
	
	//片区升学率
	@RequestMapping("/exportRegionGradRate.do")
	public void exportRegionGradRate(String fileName,String param, HttpServletResponse response , HttpServletRequest request)
	{
		OutputStream out = null;
		try
		{
			StringBuffer displayFileName = new StringBuffer(fileName);
			displayFileName.append(new SimpleDateFormat("yyMMdd").format(new Date()));
			displayFileName.append(".xls");
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-Disposition", "attachment;fileName="+URLEncoder.encode(displayFileName.toString(),"utf-8"));
			out = response.getOutputStream();
			es.exportRegionGradRate(fileName,param, out);
		}
		catch(Exception err)
		{
			err.printStackTrace();
		}

	}
	
	
	//异常开班明细
	@RequestMapping("/exportExpClassDetai.do")
	public void exportExpClassDetai(String fileName,String param, HttpServletResponse response , HttpServletRequest request)
	{
		OutputStream out = null;
		try
		{
			StringBuffer displayFileName = new StringBuffer(fileName);
			displayFileName.append(new SimpleDateFormat("yyMMdd").format(new Date()));
			displayFileName.append(".xls");
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-Disposition", "attachment;fileName="+URLEncoder.encode(displayFileName.toString(),"utf-8"));
			out = response.getOutputStream();
			es.exportExpClassDetai(fileName,param, out);
		}
		catch(Exception err)
		{
			err.printStackTrace();
		}

	}
	
	
	//班级课时进度统计(类似导出可通用)
	@RequestMapping("/exportExpClassDetail.do")
	public void exportClassHourDetail(HttpServletResponse response , HttpServletRequest request)
	{
		OutputStream out = null;
		try
		{
			JSONObject json =JSONObject.fromObject(request.getParameter("param"));
			String fileName =json.getString("fileName");
			String param =json.getString("info");
			StringBuffer displayFileName = new StringBuffer(fileName);
			displayFileName.append(new SimpleDateFormat("yyMMdd").format(new Date()));
			displayFileName.append(".xls");
			response.setCharacterEncoding("UTF-8");
			response.setContentType("application/vnd.ms-excel");
			response.setHeader("Content-Disposition", "attachment;fileName="+URLEncoder.encode(displayFileName.toString(),"utf-8"));
			out = response.getOutputStream();
			es.exportClassHourDetail(fileName,param, out);
		}
		catch(Exception err)
		{
			err.printStackTrace();
		}

	}
}
