package com.rise.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.rise.service.ClassAttendService;

@Controller
@RequestMapping("/attend")
public class ClassAttendController 
{
	@Autowired
	private ClassAttendService classAttendService;
	
	@RequestMapping("/getAttendDetail.do")
	public ModelAndView getAttendDetail(String classInstId , String funcNodeId)
	{
		ModelAndView model = new ModelAndView("attence/attenceDetailMan");
		try {
			classAttendService.getAttendDetail(model, classInstId, funcNodeId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping("/getAttendOperate.do")
	public ModelAndView getAttendOperate(String classInstId , String funcNodeId , String selDateStr)
	{
		ModelAndView model = new ModelAndView("attence/attenceOperate");
		try 
		{
			
		}
		catch (Exception e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping("/getAttendView.do")
	public ModelAndView getAttendView(String classInstId , String funcNodeId , String selDateStr)
	{
		ModelAndView model = new ModelAndView("attence/attenceView");
		try 
		{
			
		}
		catch (Exception e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return model;
	}
	
}
