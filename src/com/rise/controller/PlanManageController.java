package com.rise.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rise.service.PlanManageService;

@Controller
@RequestMapping("/planManage")
public class PlanManageController 
{
	private static Log log = LogFactory.getLog(PlanManageController.class);
	
	@Autowired
	private PlanManageService pms;
	
	@RequestMapping("/addPlan.do")
	public void addPlan(String param, HttpServletResponse response) {
		PrintWriter out = null;
		try {
			log.error(param);
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = pms.addPlan(param);
			out.write(retVal);
		} catch(Exception e) {
			e.printStackTrace();
		} finally { 
			if(out != null) {
				out.close();
			}
		}
	}
	
	@RequestMapping("/qryPlan.do")
	public void qryPlan(String schoolId, String planYear, String planType, HttpServletResponse response) {
		PrintWriter out = null;
		try {
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = pms.qryPlan(schoolId, planYear, planType);
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
	
	@RequestMapping("/updatePlan.do")
	public void updatePlan(String param, HttpServletResponse response) {
		PrintWriter out = null;
		try {
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = pms.updatePlan(param);
			out.write(retVal);
		} catch(Exception e) {
			e.printStackTrace();
		} finally { 
			if(out != null) {
				out.close();
			}
		}
	}
	
	@RequestMapping("/deletePlan.do")
	public void deletePlan(String planId, HttpServletResponse response) {
		PrintWriter out = null;
		try {
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = pms.deletePlan(planId);
			out.write(retVal);
		} catch(Exception e) {
			e.printStackTrace();
		} finally { 
			if(out != null) {
				out.close();
			}
		}
	}
	
	@RequestMapping("/delPlan.do")
	public void delPlan(String schoolId, String planYear, String planType, HttpServletResponse response) {
		PrintWriter out = null;
		try {
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = pms.delPlan(schoolId, planYear, planType);
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
	
	@RequestMapping("/add.do")
	public void add(String param, HttpServletResponse response) {
		PrintWriter out = null;
		try {
			log.error(param);
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = pms.add(param);
			out.write(retVal);
		} catch(Exception e) {
			e.printStackTrace();
		} finally { 
			if(out != null) {
				out.close();
			}
		}
	}
	
	@RequestMapping("/update.do")
	public void update(String param, HttpServletResponse response) {
		PrintWriter out = null;
		try {
			log.error(param);
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = pms.update(param);
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
}
