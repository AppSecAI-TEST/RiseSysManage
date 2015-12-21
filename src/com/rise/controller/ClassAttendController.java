package com.rise.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

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
			classAttendService.getAttendOperate(model , classInstId , funcNodeId , selDateStr);
		}
		catch (Exception e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping("/getAttenceRecord.do")
	public ModelAndView getAttenceRecord(String schooltimeInstId , String funcNodeId , String selDateStr)
	{
		ModelAndView model = new ModelAndView("attence/attenceRecord");
		try
		{
			classAttendService.getAttenceRecord(model, schooltimeInstId, funcNodeId, selDateStr);
		}
		catch (Exception e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping("/getAttenceRecordInst.do")
	public ModelAndView getAttenceRecordInst(String classInstId , String funcNodeId , String selDateStr , String dateValue)
	{
		ModelAndView model = new ModelAndView("attence/attenceRecordInst");
		try
		{
			classAttendService.getAttenceRecordInst(model, classInstId, funcNodeId, selDateStr, dateValue);
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
			classAttendService.getAttendOperate(model , classInstId , funcNodeId , selDateStr);
		}
		catch (Exception e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping("/addAttend.do")
	public void addAttend(String json , HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = classAttendService.addAttend(json);
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
	
	@RequestMapping("/showAttenceRecord.do")
	public ModelAndView showAttenceRecord(String classInstId , String funcNodeId , String selDateStr , String classAttendId , String comeFlag)
	{
		ModelAndView model = new ModelAndView("attence/attenceDisplay");
		try 
		{
			classAttendService.showAttenceRecord(model, classAttendId, classInstId, funcNodeId, selDateStr, comeFlag);
		}
		catch (Exception e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping("/getUpdateAttenceRecord.do")
	public ModelAndView getUpdateAttenceRecord(String classAttendId , String funcNodeId , String selDateStr)
	{
		ModelAndView model = new ModelAndView("attence/updateAttenceRecord");
		try 
		{
			classAttendService.getUpdateAttenceRecord(model, classAttendId, funcNodeId, selDateStr);
		}
		catch (Exception e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping("/updateAttend.do")
	public void updateAttend(String json , HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = classAttendService.updateAttend(json);
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
	
	/**
	 * ������ת�쳣��
	 * @param classInstId
	 * @param response
	 */
	@RequestMapping("/convertClassOpenType.do")
	public void convertClassOpenType(String classInstId , HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = classAttendService.convertClassOpenType(classInstId);
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
	
	@RequestMapping("/getAttenceCalendarView.do")
	public ModelAndView getAttenceCalendarView(String classInstId , String year , String month , String funcNodeId)
	{
		ModelAndView model = new ModelAndView("attence/attenceCalendarView");
		try 
		{
			classAttendService.getAttenceCalendarView(model, classInstId, year, month, funcNodeId);
		}
		catch (Exception e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return model;
	}
	
}
