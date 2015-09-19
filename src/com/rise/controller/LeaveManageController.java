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

import com.rise.service.LeaveManageService;

@Controller
@RequestMapping("/leaveManage")
public class LeaveManageController {

	private static Log log = LogFactory.getLog(LeaveManageController.class);

	@Autowired
	private LeaveManageService leaveManageService;
	
	//页面跳转根据type区分，带出休学学员相关信息
	@RequestMapping(value="/viewLeaveInfo.do")
	public ModelAndView viewLeaveInfo(String studentId,String leaveId,String funcNodeId,String type,String courseState,String studentCourseId,String currentHours)
	{
		log.error(studentId);
		log.error(funcNodeId);
		log.error(leaveId);
		ModelAndView view = null;
		if("view".equals(type)){
			view = new ModelAndView("leaveManage/viewLeaveInfo");
		}else if("restart".equals(type)){
			view = new ModelAndView("leaveManage/restartClass");
		}else if("update".equals(type)){
			view = new ModelAndView("leaveManage/updateLeaveTime");
		}else if("add".equals(type)){
			view = new ModelAndView("leaveManage/addLeaveInfo");
			view.addObject("courseState",courseState);
			view.addObject("studentCourseId",studentCourseId);
			view.addObject("currentHours", currentHours);
		}
		try {
			String ret = leaveManageService.viewLeaveInfo(studentId, leaveId, funcNodeId);
			JSONObject obj = JSONObject.fromObject(ret);
			view.addObject("obj",obj);
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return view;
	}
	
	//复课
	@RequestMapping(value="/restartClass.do")
	public void restartClass(HttpServletResponse response,String studentId,String leaveId,String resumeType,String studentCourseId,String handlerId)
	{
		log.error(studentId);
		log.error(leaveId);
		log.error(resumeType);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = leaveManageService.restartClass(studentId, leaveId, resumeType, studentCourseId, handlerId);
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
	
	//修改休学时长
	@RequestMapping(value="/updateLeaveTime.do")
	public void updateLeaveTime(HttpServletResponse response,String leaveId,String delayDate,String updateRemark,String handlerId)
	{
		log.error(leaveId);
		log.error(delayDate);
		log.error(updateRemark);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = leaveManageService.updateLeaveTime(leaveId, delayDate, updateRemark,handlerId);
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

	//新增休学
	@RequestMapping(value="/addLeaveInfo.do")
	public void addLeaveInfo(HttpServletResponse response,String json)
	{
		log.error(json);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = leaveManageService.addLeaveInfo(json);
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
