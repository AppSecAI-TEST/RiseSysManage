package com.rise.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.rise.model.StaffT;
import com.rise.pub.util.ObjectCensor;
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
	public ModelAndView getAttenceRecord(HttpServletRequest request , String schooltimeInstId , String funcNodeId , String selDateStr , String dateValue , String classAttendIds , String schooltimeInstIds)
	{
		ModelAndView model = new ModelAndView("attence/attenceRecord");
		try
		{
			HttpSession session = request.getSession();
			StaffT staffT = (StaffT)session.getAttribute("StaffT");
			if(!ObjectCensor.checkObjectIsNull(staffT))
			{
				classAttendService.getAttenceRecord(model, schooltimeInstId, funcNodeId, selDateStr, dateValue, staffT.getStaffId(), classAttendIds, schooltimeInstIds);
			}
			else
			{
				model.setViewName("common/userSessionout");
			}
		}
		catch (Exception e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping("/getAttenceRecordInst.do")
	public ModelAndView getAttenceRecordInst(HttpServletRequest request , String classInstId , String funcNodeId , String selDateStr , String dateValue , String hourRange , String classAttendIds , String schooltimeInstIds)
	{
		ModelAndView model = new ModelAndView("attence/attenceRecordInst");
		try
		{
			HttpSession session = request.getSession();
			StaffT staffT = (StaffT)session.getAttribute("StaffT");
			if(!ObjectCensor.checkObjectIsNull(staffT))
			{
				classAttendService.getAttenceRecordInst(model, classInstId, funcNodeId, selDateStr, dateValue, staffT.getStaffId(), hourRange, classAttendIds, schooltimeInstIds);
			}
			else
			{
				model.setViewName("common/userSessionout");
			}
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
	public ModelAndView getUpdateAttenceRecord(HttpServletRequest request , String classAttendId , String classAttendIds , String funcNodeId , String selDateStr)
	{
		ModelAndView model = new ModelAndView("attence/updateAttenceRecord");
		try 
		{
			HttpSession session = request.getSession();
			StaffT staffT = (StaffT)session.getAttribute("StaffT");
			if(!ObjectCensor.checkObjectIsNull(staffT))
			{
				classAttendService.getUpdateAttenceRecord(model, classAttendId , classAttendIds , funcNodeId, selDateStr, staffT.getStaffId());
			}
			else
			{
				model.setViewName("common/userSessionout");
			}
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
	 * 正常班转异常班
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
	public ModelAndView getAttenceCalendarView(String classInstId , String year , String month , String funcNodeId , String flag)
	{
		ModelAndView model = new ModelAndView("attence/attenceCalendarView");
		try 
		{
			classAttendService.getAttenceCalendarView(model, classInstId, year, month, funcNodeId, flag);
		}
		catch (Exception e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping("/getClassStudentAttenceInfo.do")
	public ModelAndView getClassStudentAttenceInfo(String classInstId , String monthDate)
	{
		ModelAndView model = new ModelAndView("report/班级考勤之学生明细");
		try 
		{
			classAttendService.getClassStudentAttenceInfo(model, classInstId, monthDate);
		}
		catch (Exception e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping("/uploadLeavePage.do")
	public ModelAndView uploadLeavePage(String studentCourseId , String funcNodeId)
	{
		ModelAndView model = new ModelAndView("attence/uploadLeavePage");
		try 
		{
			classAttendService.uploadLeavePage(model, studentCourseId, funcNodeId);
		}
		catch (Exception e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping("/uploadLeaveDetailPage.do")
	public ModelAndView uploadLeaveDetailPage(String classAttendId , String studentCourseId , String funcNodeId)
	{
		ModelAndView model = new ModelAndView("attence/uploadLeaveDetail");
		try 
		{
			classAttendService.uploadLeaveDetailPage(model, classAttendId, studentCourseId , funcNodeId);
		}
		catch (Exception e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping("/uploadLeaveOper.do")
	public void uploadLeaveOper(String json , HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = classAttendService.uploadLeaveOper(json);
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
	
	@RequestMapping("/commitMakeupPage.do")
	public ModelAndView commitMakeupPage(String studentCourseId , String funcNodeId)
	{
		ModelAndView model = new ModelAndView("attence/commitMakeupPage");
		try 
		{
			classAttendService.uploadLeavePage(model, studentCourseId, funcNodeId);
		}
		catch (Exception e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping("/commitMakeupDetailPage.do")
	public ModelAndView commitMakeupDetailPage(String classAttendId , String studentAttendId , String studentCourseId , String attendType , String interval , String funcNodeId)
	{
		ModelAndView model = new ModelAndView("attence/commitMakeupDetail");
		try 
		{
			classAttendService.commitMakeupDetailPage(model, classAttendId , studentAttendId , studentCourseId , attendType , interval , funcNodeId);
		}
		catch (Exception e) 
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping("/addStudentMakeupInfo.do")
	public void addStudentMakeupInfo(String json , HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = classAttendService.addStudentMakeupInfo(json);
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
	
}
