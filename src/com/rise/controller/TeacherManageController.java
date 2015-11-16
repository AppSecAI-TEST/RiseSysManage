package com.rise.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rise.pub.util.StringUtil;
import com.rise.service.TeacherManageService;

@Controller
@RequestMapping("/teacherManage")
public class TeacherManageController {
	
	@Autowired
	private TeacherManageService teacherManageService;
	
	@RequestMapping(value="/qryArchivesInfo.do")
	public void qryArchivesInfo(HttpServletRequest request,HttpServletResponse response,String page,String rows,String json)
	{
		PrintWriter out = null;
		try {
			response.setCharacterEncoding("utf-8");
			out = response.getWriter();
			Integer pageNumInt = Integer.parseInt(page)-1;
			Integer pageSizeInt = Integer.parseInt(rows);
			JSONObject obj = JSONObject.fromObject(json);
			String schoolId = StringUtil.getJSONObjectKeyVal(obj, "schoolId");
			String chineseName = StringUtil.getJSONObjectKeyVal(obj, "chineseName");
			String englishName = StringUtil.getJSONObjectKeyVal(obj, "englishName");
			String permitteeLevel = StringUtil.getJSONObjectKeyVal(obj, "permitteeLevel");
			String permitteeNum = StringUtil.getJSONObjectKeyVal(obj, "permitteeNum");
			String workMonth = StringUtil.getJSONObjectKeyVal(obj, "workMonth");
			String workYear = StringUtil.getJSONObjectKeyVal(obj, "workYear");
			String workTime = StringUtil.getJSONObjectKeyVal(obj, "workTime");
			String leadClassLevel = StringUtil.getJSONObjectKeyVal(obj, "leadClassLevel");
			String trainingLevel = StringUtil.getJSONObjectKeyVal(obj, "trainingLevel");
			String retVal = teacherManageService.qryArchivesInfo(pageNumInt, pageSizeInt, schoolId, chineseName, englishName, permitteeLevel, permitteeNum, workMonth, workYear, workTime, leadClassLevel, trainingLevel);
			out.write(retVal);
		} catch (Exception e) {
			e.printStackTrace();
		}
		finally
		{
			if(out != null){
				out.close();
			}
		}
	}
	
	@RequestMapping(value="/addArchivesInfo.do")
	public void addArchivesInfo(HttpServletRequest request,HttpServletResponse response,String schoolId,String chineseName,String englishName,String permitteeLevel,String permitteeNum,String workMonth,String workYear,String workTime,String leadClassLevel,String trainingLevel)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("utf-8");
			out = response.getWriter();
			String retVal = teacherManageService.addArchivesInfo(schoolId, chineseName, englishName, permitteeLevel, permitteeNum, workMonth, workYear, workTime, leadClassLevel, trainingLevel);
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

	@RequestMapping(value="/updateArchivesInfo.do")
	public void updateArchivesInfo(HttpServletRequest request,HttpServletResponse response,String teacherId,String schoolId,String chineseName,String englishName,String permitteeLevel,String permitteeNum,String workMonth,String workYear,String workTime,String leadClassLevel,String trainingLevel)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("utf-8");
			out = response.getWriter();
			String retVal = teacherManageService.updateArchivesInfo(teacherId, schoolId, chineseName, englishName, permitteeLevel, permitteeNum, workMonth, workYear, workTime, leadClassLevel, trainingLevel);
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
	 * 获取老师信息
	 * @param request
	 * @param response
	 * @param teacherId
	 */
	@RequestMapping(value="/getTeacherInfo.do")
	public void getTeacherInfo(HttpServletRequest request,HttpServletResponse response,String teacherId)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("utf-8");
			out = response.getWriter();
			String retVal = teacherManageService.getTeacherInfo(teacherId);
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
	
	@RequestMapping(value="/deleteArchivesInfo.do")
	public void deleteArchivesInfo(HttpServletRequest request,HttpServletResponse response,String teacherId)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("utf-8");
			out = response.getWriter();
			String retVal = teacherManageService.deleteArchivesInfo(teacherId);
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
