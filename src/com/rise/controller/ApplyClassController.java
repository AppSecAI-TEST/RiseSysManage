package com.rise.controller;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/applyClass.htm")
public class ApplyClassController 
{
	private static Log log = LogFactory.getLog(ApplyClassController.class);
	
	@RequestMapping(params = "method=qryApplyClassList")
	public void qryApplyClassList(String param, HttpServletResponse response)
	{
		log.error(param);
	}
}
