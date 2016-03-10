package com.rise.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rise.service.SysLogService;

@Controller
@RequestMapping("/log")
public class SysLogController {
	private static Log log = LogFactory.getLog(SysLogController.class);
	
	@Autowired
	private SysLogService sysLogService;
	
	@RequestMapping(value = "/deleteLog.do")
	public void deleteLog(String logIds, HttpServletResponse response)
	{
		PrintWriter out = null;
		try {
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = sysLogService.deleteLog(logIds);
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
	
	@RequestMapping(value = "/deleteAllLog.do")
	public void deleteAllLog(HttpServletResponse response)
	{
		PrintWriter out = null;
		try {
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = sysLogService.deleteAllLog();
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
