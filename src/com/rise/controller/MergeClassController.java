package com.rise.controller;

import java.io.PrintWriter;
import java.net.URLDecoder;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.rise.pub.util.ObjectCensor;
import com.rise.service.ActionService;
import com.rise.service.MergeClassService;

@Controller
@RequestMapping("/mergeClass")
public class MergeClassController 
{
	private static Log log = LogFactory.getLog(MergeClassController.class);
	
	@Autowired
	private MergeClassService msc;
	
	@RequestMapping("/qryClassInstList.do")
	public void qryClassInstList(String classInstIds, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = msc.qryClassInstList(classInstIds);
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
	
	@RequestMapping("/mergeClassApply.do")
	public void mergeClassApply(String param, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			param = param.replaceAll("%(?![0-9a-fA-F]{2})", "%25");  
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = msc.mergeClassApply(param);
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
	
	
	@RequestMapping("/getMergeInfo.do")
	public void getMergeInfo(String applyId,String approveFlag, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = msc.getMergeInfo(applyId, approveFlag);
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
	
	@RequestMapping("/cancelApply.do")
	public void cancelApply(String param, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = msc.cancelApply(param);
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
	
	
	@RequestMapping("/approveApply.do")
	public void approveApply(String param, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = msc.approveApply(param);
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
	
	
	@RequestMapping("/qryMergeClassStudent.do")
	public void qryMergeClassStudent(String applyId, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = msc.qryMergeClassStudent(applyId);
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
	
	
	@RequestMapping("/orderClass.do")
	public void orderClass(String param, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = msc.orderClass(param);
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
	
	@RequestMapping(value = "/adjustSchooltime.do")
	public ModelAndView adjustSchooltime(String applyId) {
		ModelAndView view = null;
		if(ObjectCensor.isStrRegular(applyId)) {
			log.error(applyId);
			view = new ModelAndView("mergeClass/adjustSchooltime");
			try {
				String rstVal = msc.qryMergeClassInstList(applyId);
				log.error(rstVal);
				if(ObjectCensor.isStrRegular(rstVal)) {
					JSONArray array = JSONArray.fromObject(rstVal);
					view.addObject("list", array);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return view;
	}
	
	@RequestMapping(value = "/adjust.do")
	public void adjust(String param, HttpServletResponse response) {
		PrintWriter out = null;
		try {
			log.error(param);
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = msc.adjust(param);
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
