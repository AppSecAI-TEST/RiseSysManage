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

import com.rise.service.AttendClassService;

/**
 * 在读班管理
 * @author wm
 */
@Controller
@RequestMapping("/attendClass")
public class AttendClassController {
	private static Log log = LogFactory.getLog(AttendClassController.class);
	
	@Autowired
	private AttendClassService attendClassService;
	
	@RequestMapping(value = "/qryAttendClass.do")
	public ModelAndView qryAttendClass(String classInstId, String type, String funcNodeId) {
		log.error(classInstId);
		ModelAndView view = null;
		if("maintenance".equals(type)) {
			view = new ModelAndView("attendClass/maintenanceClass");
		} else if("disband".equals(type)) {
			view = new ModelAndView("attendClass/disbandClass");
		} else if("view".equals(type)) {
			view = new ModelAndView("attendClass/viewAttendClass");
		} else if("finish".equals(type)) {
			view = new ModelAndView("finishClass/finishClass");
		} else if("viewFinish".equals(type)) {
			view = new ModelAndView("finishClass/viewFinishClass");
		}else if("numChange".equals(type)) {
			view = new ModelAndView("baseChange/change");
		} else if("changeHist".equals(type)) {
			view = new ModelAndView("baseChange/changeHist");
		} else if("updateFinishDate".equals(type)) {
			view = new ModelAndView("attendClass/updateFinishDate");
		}else if("feedback".equals(type)) {
			view = new ModelAndView("attendClass/stuFeedback");
		}else if("stuReview".equals(type)) {
			view = new ModelAndView("attendClass/stuReview");
		}
		try {
			String retVal = attendClassService.qryAttendClassById(classInstId);
			JSONObject obj = JSONObject.fromObject(retVal);
			log.error(obj);
			view.addObject("obj", obj);
			view.addObject("funcNodeId", funcNodeId);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return view;
	}
	
	
	@RequestMapping(value = "/disbandClass.do")
	public void disbandClass(String param, HttpServletResponse response) {
		log.error(param);
		PrintWriter out = null;
		try {
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = attendClassService.disbandClass(param);
			log.error(retVal);
			out.write(retVal);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(out != null) {
				out.close();
			}
		}
	}
	
	//在读班变更老师
	@RequestMapping(value = "/changeTeacher.do")
	public void changeTeacher(String param, HttpServletResponse response) {
		log.error(param);
		PrintWriter out = null;
		try {
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = attendClassService.changeTeacher(param);
			log.error(retVal);
			out.write(retVal);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(out != null) {
				out.close();
			}
		}
	}
	
	//在读班结课
	@RequestMapping(value = "/finishClass.do")
	public void finishClass(String param, HttpServletResponse response) {
		log.error(param);
		PrintWriter out = null;
		try {
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = attendClassService.finishClass(param);
			log.error(retVal);
			out.write(retVal);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(out != null) {
				out.close();
			}
		}
	}
	
	//修改结课时间
	@RequestMapping(value = "/updateFinishDate.do")
	public void updateFinishDate(String param, HttpServletResponse response) {
		log.error(param);
		PrintWriter out = null;
		try {
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = attendClassService.updateFinishDate(param);
			log.error(retVal);
			out.write(retVal);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(out != null) {
				out.close();
			}
		}
	}
	
	@RequestMapping(value="/viewFeedStuInfo.do")
	public ModelAndView viewFeedStuInfo(String studentId,String studentCourseId,String classInstId)
	{
		ModelAndView view = null;
		try {
			view = new ModelAndView("attendClass/addFeedback");
			String ret = attendClassService.viewFeedStuInfo(studentId, studentCourseId, classInstId);
			view.addObject("studentId",studentId);
			view.addObject("classInstId",classInstId);
			view.addObject("obj", JSONObject.fromObject(ret));
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return view;
	}
	
	@RequestMapping(value="/reviewStuInfo.do")
	public ModelAndView reviewStuInfo(String studentId,String studentCourseId,String classInstId)
	{
		ModelAndView view = null;
		try {
			view = new ModelAndView("attendClass/addStuReview");
			String ret = attendClassService.viewFeedStuInfo(studentId, studentCourseId, classInstId);
			view.addObject("studentId",studentId);
			view.addObject("classInstId",classInstId);
			view.addObject("obj", JSONObject.fromObject(ret));
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return view;
	}
	
	//添加跟进记录
	@RequestMapping(value="/addStuFollow.do")
	public void addStuFeedback(String param,HttpServletResponse response)
	{
		PrintWriter out = null;
		try {
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = attendClassService.addStuFollow(param);
			out.write(retVal);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(out != null)
			{
				out.close();
			}
		}
	}
	
	//添加跟进记录
	@RequestMapping(value="/addStuReview.do")
	public void addStuReview(String param,HttpServletResponse response)
	{
		PrintWriter out = null;
		try {
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = attendClassService.addStuReview(param);
			out.write(retVal);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(out != null)
			{
				out.close();
			}
		}
	}
}
