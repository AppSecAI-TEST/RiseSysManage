package com.rise.controller;

import java.io.PrintWriter;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.ServletRequestDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.rise.model.StaffT;
import com.rise.pub.util.DateEditor;
import com.rise.service.StaffService;

@Controller
@RequestMapping("/staff")
public class StaffController {
	
	@Autowired
	private StaffService staffService;
	
	@InitBinder
	protected void initBinder(HttpServletRequest request, ServletRequestDataBinder binder) throws Exception {
	    binder.registerCustomEditor(Date.class, new DateEditor());
	}
	
	@RequestMapping("/qryStaffListByDeptId.do")
	public void qryStaffListByDeptId(HttpServletResponse response, String page, String rows, String deptId)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			Integer pageNumInt = Integer.parseInt(page)-1;
			Integer pageSizeInt = Integer.parseInt(rows);
			String retVal = staffService.qryStaffListByDeptId(deptId, pageNumInt*pageSizeInt, pageSizeInt);
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
	
	@RequestMapping("/qryStaffListByCondition.do")
	public void qryStaffListByCondition(HttpServletResponse response, String page, String rows, String deptId , String userName , String post , String state)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			Integer pageNumInt = Integer.parseInt(page)-1;
			Integer pageSizeInt = Integer.parseInt(rows);
			String retVal = staffService.qryStaffListByCondition(deptId, userName, post, state, pageNumInt*pageSizeInt, pageSizeInt);
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
	
	@RequestMapping("/getStaffTotalList.do")
	public void getStaffTotalList(HttpServletResponse response, String deptId, String staffIds)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = staffService.getStaffTotalList(deptId,staffIds);
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
	
	@RequestMapping("/getStaffListByRoleId.do")
	public void getStaffListByRoleId(HttpServletResponse response, String sysRoleId)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = staffService.getStaffListByRoleId(sysRoleId);
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
	
	@RequestMapping("/getStaffDetail.do")
	public ModelAndView getStaffDetail(String pageFlag , String staffId , String funcNodeId)
	{
		ModelAndView model = new ModelAndView("manage/userDetail");
		try {
			staffService.getStaffDetail(model, pageFlag, staffId, funcNodeId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping("/addStaff.do")
	public void addStaff(HttpServletResponse response , StaffT StaffT)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = staffService.addStaff(StaffT);
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
	
	@RequestMapping("/updateStaff.do")
	public void updateStaff(HttpServletResponse response , StaffT StaffT)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = staffService.updateStaff(StaffT);
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
	
	@RequestMapping("/deleteStaff.do")
	public void deleteStaff(HttpServletResponse response , String staffId)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = staffService.deleteStaff(staffId);
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
		
	@RequestMapping("/dimissionStaff.do")
	public void dimissionStaff(HttpServletResponse response , String operType , String staffId)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = staffService.dimissionStaff(operType,staffId);
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
