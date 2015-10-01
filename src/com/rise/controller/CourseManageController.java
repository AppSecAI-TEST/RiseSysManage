package com.rise.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rise.pub.util.StringUtil;
import com.rise.service.CourseManageService;

@Controller
@RequestMapping("/courseManage")
public class CourseManageController {

	@Autowired
	private CourseManageService courseManageService;
}
