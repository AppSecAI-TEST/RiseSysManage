package com.rise.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rise.service.ReportService;

@Controller
@RequestMapping("/report")
public class ReportController
{
	@Autowired
	ReportService reportService;
	
	/**
	 * 获取老师考勤课时
	 * @param request
	 * @param response
	 * @param teacherId
	 */
	@RequestMapping(value="/getTeacherAttendHours.do")
	public void getTeacherAttendHour(HttpServletRequest request,HttpServletResponse response,String schoolId,String teacherId,String month)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("utf-8");
			out = response.getWriter();
			String retVal = reportService.getTeacherAttendHours(schoolId,teacherId,month);
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
