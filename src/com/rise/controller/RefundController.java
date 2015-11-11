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

import com.rise.service.RefundService;

@Controller
@RequestMapping("/refund")
public class RefundController 
{
	private static Log log = LogFactory.getLog(RefundController.class);
	
	@Autowired
	private RefundService refundService;
	
	@RequestMapping(value = "/qryApplyRefund.do")
	public ModelAndView qryApplyRefund(String studentCourseId, String studentId, String courseType)
	{
		ModelAndView view = null;
		if("001".equals(courseType)) {
			view = new ModelAndView("refund/refundApply");
		} else {
			view = new ModelAndView("refund/shortRefundApply");
		}
		try 
		{
			String retVal = refundService.qryApplyRefund(studentCourseId, studentId);
			JSONObject obj = JSONObject.fromObject(retVal);
			log.error(obj);
			obj.element("courseType", courseType);
			view.addObject("obj", obj);
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return view;
	}
	
	@RequestMapping(value = "/applyRefund.do")
	public void applyRefund(String param, HttpServletResponse response)
	{
		log.error(param);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = refundService.applyRefund(param);
			log.error(retVal);
			out.write(retVal);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			if(out != null)
			{
				out.close();
			}
		}
	}
	
	@RequestMapping(value = "/qryApproveRefund.do")
	public ModelAndView qryApproveRefund(String refundFeeId, String courseType)
	{
		ModelAndView view = null;
		if("001".equals(courseType)) {
			view = new ModelAndView("refund/refundApprove");
		} else {
			view = new ModelAndView("refund/shortRefundApprove");
		}
		try 
		{
			String retVal = refundService.qryApproveRefund(refundFeeId);
			JSONObject obj = JSONObject.fromObject(retVal);
			log.error(obj);
			obj.element("courseType", courseType);
			view.addObject("obj", obj);
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		return view;
	}
}
