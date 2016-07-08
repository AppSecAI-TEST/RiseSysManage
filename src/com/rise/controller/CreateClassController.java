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

/**
 * 放班
 * @author wm
 */
@Controller
@RequestMapping("/applyClass")
public class CreateClassController 
{
	private static Log log = LogFactory.getLog(CreateClassController.class);
	
	@Autowired
	private CreateClassService createClassService;
	
	//校验班级名称和班号
	@RequestMapping(value = "/validateClass.do")
	public void validateClass(String param, HttpServletResponse response) {
		PrintWriter out = null;
		try {
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = createClassService.validateClass(param);
			out.write(retVal);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(out != null) {
				out.close();
			}
		}
	}
	
	//申请放班
	@RequestMapping(value = "/applyCreateClass.do")
	public void applyCreateClass(String param, HttpServletResponse response) {
		PrintWriter out = null;
		try {
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = createClassService.applyCreateClass(param);
			out.write(retVal);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(out != null) {
				out.close();
			}
		}
	}
	
	//根据班级实例ID查询申请放班内容
	@RequestMapping(value = "/qryCreateClassById.do")
	public void qryCreateClassById(String classInstId, String applyType, HttpServletResponse response) {
		PrintWriter out = null;
		try {
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = createClassService.qryCreateClassById(classInstId, applyType);
			out.write(retVal);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(out != null) {
				out.close();
			}
		}
	}
	
	//审批放班申请和审批取消放班申请
	@RequestMapping(value = "/approveApplyClass.do")
	public void approveApplyClass(String param, HttpServletResponse response) {
		PrintWriter out = null;
		try {
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = createClassService.approveApplyClass(param);
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
	
	//取消放班申请
	@RequestMapping(value = "/cancelApplyClass.do")
	public void cancelApplyClass(String param, HttpServletResponse response) {
		PrintWriter out = null;
		try {
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = createClassService.cancelApplyClass(param);
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
	
	@RequestMapping(value = "/qryCreateClass.do")
	public ModelAndView qryCreateClass(String classInstId, String applyType, String type, String classState, String funcNodeId, String channel)
	{
		ModelAndView view = null;
		if("update".equals(type)) {
			view = new ModelAndView("applyClass/updateApplyClass");
		} else {
			view = new ModelAndView("applyClass/viewApplyClass");
		}
		try {
			String retVal = createClassService.qryCreateClassById(classInstId, applyType);
			JSONObject obj = JSONObject.fromObject(retVal);
			obj.element("classState", classState);
			obj.element("funcNodeId", funcNodeId);
			obj.element("channel", channel);
			view.addObject("obj", obj);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return view;
	}
	
	//班级维护
	@RequestMapping(value = "/updateCreateClass.do")
	public void updateCreateClass(String param, HttpServletResponse response) {
		PrintWriter out = null;
		try {
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = createClassService.updateCreateClass(param);
			out.write(retVal);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(out != null) {
				out.close();
			}
		}
	}
	
	//批量移除学员
	@RequestMapping(value = "/batchRemoveStudent.do")
	public void batchRemoveStudent(String param, HttpServletResponse response) {
		PrintWriter out = null;
		try {
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = createClassService.batchRemoveStudent(param);
			out.write(retVal);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(out != null) {
				out.close();
			}
		}
	}
	
	//向班级添加学员
	@RequestMapping(value = "/addClassStudent.do")
	public void addClassStudent(String param, HttpServletResponse response) {
		PrintWriter out = null;
		try {
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = createClassService.addClassStudent(param);
			out.write(retVal);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(out != null) {
				out.close();
			}
		}
	}
	
	//向班级添加学员
	@RequestMapping(value = "/addShortClassStudent.do")
	public void addShortClassStudent(String param, HttpServletResponse response) {
		log.error(param);
		PrintWriter out = null;
		try {
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = createClassService.addShortClassStudent(param);
			out.write(retVal);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(out != null) {
				out.close();
			}
		}
	}
	
	//查询更换班级的学员信息
	@RequestMapping(value = "/qryDataByQueryCode.do")
	public void qryDataByQueryCode(String param, HttpServletResponse response) {
		PrintWriter out = null;
		try {
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = createClassService.qryDataByQueryCode(param);
			out.write(retVal);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(out != null) {
				out.close();
			}
		}
	}
	
	@RequestMapping(value = "/qryClassName.do")
	public void qryClassName(String courseType, String classType, 
			String stageId, String schoolId, HttpServletResponse response) {
		PrintWriter out = null;
		try {
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = createClassService.qryClassName(courseType, classType, stageId, schoolId);
			out.write(retVal);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(out != null) {
				out.close();
			}
		}
	}
	
	@RequestMapping(value = "/validateRoom.do")
	public void validateRoom(String param, HttpServletResponse response) {
		PrintWriter out = null;
		try {
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = createClassService.validateRoom(param);
			out.write(retVal);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(out != null) {
				out.close();
			}
		}
	}
	
	@RequestMapping(value = "/validateHourRange.do")
	public void validateHourRange(String param, HttpServletResponse response) {
		PrintWriter out = null;
		try {
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = createClassService.validateHourRange(param);
			out.write(retVal);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(out != null) {
				out.close();
			}
		}
	}
	
	@RequestMapping(value = "/qryClassInstDetail.do")
	public void qryClassInstDetail(String param, HttpServletResponse response) {
		PrintWriter out = null;
		try {
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = createClassService.qryClassInstDetail(param);
			out.write(retVal);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(out != null) {
				out.close();
			}
		}
	}
	
	@RequestMapping(value = "/getBonus.do")
	public void getBonus(String classInstId, String type, HttpServletResponse response) {
		PrintWriter out = null;
		try {
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = createClassService.getBonus(classInstId, type);
			out.write(retVal);
		} catch(Exception e) {
			e.printStackTrace();
		} finally {
			if(out != null) {
				out.close();
			}
		}
	}
}
