package com.rise.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.rise.service.StudentService;

@Controller
@RequestMapping("/student")
public class StudentController {
	@Autowired
	private StudentService studentService;

	// 查询学员资料列表
	@RequestMapping(value = "/qryStudentList.do")
	public void qryStudentList(String page, String rows, String param, String funcNodeId, HttpServletResponse response) {
		PrintWriter out = null;
		try {
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = studentService.qryStudentList(page, rows, param, funcNodeId);
			out.write(retVal);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (out != null) {
				out.close();
			}
		}
	}

	// 学员资料验重
	@RequestMapping(value = "/validate.do")
	public void validate(String param, HttpServletResponse response) {
		PrintWriter out = null;
		try {
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = studentService.validate(param);
			out.write(retVal);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (out != null) {
				out.close();
			}
		}
	}

	// 学员注册
	@RequestMapping(value = "/addStudent.do")
	public void addStudent(String param, HttpServletResponse response) {
		PrintWriter out = null;
		try {
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = studentService.addStudent(param);
			out.write(retVal);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (out != null) {
				out.close();
			}
		}
	}

	// 根据学员ID查询学员资料
	@RequestMapping(value = "/qryStudentById.do")
	public void qryStudentById(String studentId, String funcNodeId, HttpServletResponse response) {
		PrintWriter out = null;
		try {
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = studentService.qryStudentById(studentId, funcNodeId);
			out.write(retVal);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (out != null) {
				out.close();
			}
		}
	}

	// 修改学员资料
	@RequestMapping(value = "/updateStudent.do")
	public void updateStudent(String param, HttpServletResponse response) {
		PrintWriter out = null;
		try {
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = studentService.updateStudent(param);
			out.write(retVal);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (out != null) {
				out.close();
			}
		}
	}
	
	// 删除学员档案
	@RequestMapping(value = "/delStudent.do")
	public void delStudent(String studentId, String handlerId, HttpServletResponse response) {
		PrintWriter out = null;
		try {
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = studentService.delStudent(studentId, handlerId);
			out.write(retVal);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (out != null) {
				out.close();
			}
		}
	}

	// 添加活动奖项
	@RequestMapping(value = "/addActivity.do")
	public void addActivity(String param, HttpServletResponse response) {
		PrintWriter out = null;
		try {
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = studentService.addActivity(param);
			out.write(retVal);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (out != null) {
				out.close();
			}
		}
	}

	// 设置学员为VIP
	@RequestMapping(value = "/setVip.do")
	public void setVip(String param, HttpServletResponse response) {
		PrintWriter out = null;
		try {
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = studentService.setVip(param);
			out.write(retVal);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (out != null) {
				out.close();
			}
		}
	}

	// VIP学员维护
	@RequestMapping(value = "/updateVip.do")
	public void updateVip(String param, HttpServletResponse response) {
		PrintWriter out = null;
		try {
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = studentService.addVipRemark(param);
			out.write(retVal);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (out != null) {
				out.close();
			}
		}
	}

	// 查询学员的VIP维护信息
	@RequestMapping(value = "/qryVipRemarkList.do")
	public void qryVipRemarkList(String studentId, HttpServletResponse response) {
		PrintWriter out = null;
		try {
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = studentService.qryVipRemarkList(studentId);
			out.write(retVal);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (out != null) {
				out.close();
			}
		}
	}

	// 批量修改责任人
	@RequestMapping(value = "/batchUpdateAdvister.do")
	public void batchUpdateAdvister(String param, HttpServletResponse response) {
		PrintWriter out = null;
		try {
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = studentService.batchUpdateAdvister(param);
			out.write(retVal);
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (out != null) {
				out.close();
			}
		}
	}

	// 查询学员的VIP信息
	@RequestMapping(value = "/qryStudentVipById.do")
	public ModelAndView qryStudentVipById(String studentId, String type, String phone, String schoolName) {
		ModelAndView view = null;
		if ("ADD".equals(type)) {
			view = new ModelAndView("vip/setVip");
		} else if ("UPDATE".equals(type)) {
			view = new ModelAndView("vip/updateVip");
		} else if ("VIEW".equals(type)) {
			view = new ModelAndView("vip/viewVipRemarkList");
		}
		try {
			String retVal = studentService.qryStudentVipById(studentId);
			JSONObject obj = JSONObject.fromObject(retVal);
			view.addObject("obj", obj);
			view.addObject("phone", phone);
			view.addObject("schoolName", schoolName);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return view;
	}
}
