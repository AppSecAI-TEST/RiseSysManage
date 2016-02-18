package com.rise.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rise.service.CourseSummaryService;

@Controller
@RequestMapping("/courseSummary")
public class CourseSummaryController {
	private static Log log = LogFactory.getLog(CourseSummaryController.class);
	
	@Autowired
	private CourseSummaryService courseSummaryService;
	
	@RequestMapping(value = "/qryNewCourseSummaryReport.do")
	public void qryNewCourseSummaryReport(String param, HttpServletResponse response) {
		PrintWriter out = null;
		try {
			log.error(param);
			response.setCharacterEncoding("utf-8");
			out = response.getWriter();
			String retVal = courseSummaryService.qryNewCourseSummaryReport(param);
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
