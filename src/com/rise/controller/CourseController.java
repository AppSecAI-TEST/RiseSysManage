package com.rise.controller;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rise.service.CourseSerivce;

/**
 * �γ�
 * @author Lapalnd_Alone
 *
 */
@Controller
@RequestMapping("/course")
public class CourseController 
{

	@Autowired
	CourseSerivce courseSerivce;
	//ѧԱע��
	@RequestMapping(value = "/addLinkCourses.do")
	public void addLinkCourses(String param, HttpServletResponse response) throws Exception
	{
		
		courseSerivce.addLinkCourses(param);
		
	}
}
