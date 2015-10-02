package com.rise.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rise.model.SysRoleT;
import com.rise.service.SysRoleService;

@Controller
@RequestMapping("/sysRole")
public class SysRoleController 
{
	private static Log log = LogFactory.getLog(SysRoleController.class);
	
	@Autowired
	private SysRoleService sysRoleService;
	
	@RequestMapping(value = "/qrySysRoleList.do")
	public void qrySysRoleList(String page, String rows, String param, HttpServletResponse response)
	{
		log.error(page);
		log.error(rows);
		log.error(param);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = sysRoleService.qrySysRoleList(page, rows, param);
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
	
	@RequestMapping(value = "/addSysRole.do")
	public void addSysRole(String param, HttpServletResponse response)
	{
		log.error(param);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = sysRoleService.addSysRole(param);
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
	
	@RequestMapping(value = "/updateSysRole.do")
	public void updateSysRole(String param, HttpServletResponse response)
	{
		log.error(param);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = sysRoleService.updateSysRole(param);
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
	
	@RequestMapping(value = "/deleteSysRole.do")
	public void deleteSysRole(String sysRoleId, String staffId, HttpServletResponse response)
	{
		log.error(sysRoleId);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = sysRoleService.deleteSysRole(sysRoleId, staffId);
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
	
	@RequestMapping(value = "/qrySysRoleAllocList.do")
	public void qrySysRoleAllocList(String sysRoleId, String staffId, HttpServletResponse response)
	{
		log.error(sysRoleId);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = sysRoleService.qrySysRoleAllocList(sysRoleId, staffId);
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
	
	@RequestMapping(value = "/qrySysRoleNotAllocList.do")
	public void qrySysRoleNotAllocList(String sysRoleId, String staffId, HttpServletResponse response)
	{
		log.error(sysRoleId);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = sysRoleService.qrySysRoleNotAllocList(sysRoleId, staffId);
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
	
	@RequestMapping(value = "/allocSysRole.do")
	public void allocSysRole(String sysRoleId, String staffId, String allocArray, String sysRoleAllocId, HttpServletResponse response)
	{
		log.error(sysRoleId);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = sysRoleService.allocSysRole(sysRoleId, staffId, allocArray, sysRoleAllocId);
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
	
	@RequestMapping(value = "/roleList.do")
	public void roleList(String page, String rows, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			Integer pageNumInt = Integer.parseInt(page)-1;
			Integer pageSizeInt = Integer.parseInt(rows);
			String retVal = sysRoleService.querySysRole(pageNumInt, pageSizeInt);
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
	
	@RequestMapping("/addRole.do")
	public void addRole(HttpServletResponse response , SysRoleT sysRoleT)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = sysRoleService.addRole(sysRoleT);
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
	
	@RequestMapping("/updateRole.do")
	public void updateRole(HttpServletResponse response , SysRoleT sysRoleT)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = sysRoleService.updateRole(sysRoleT);
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
	
	@RequestMapping("/deleteRole.do")
	public void deleteRole(HttpServletResponse response , String sysRoleId)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = sysRoleService.deleteRole(sysRoleId);
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
	
	@RequestMapping("/saveChoiceRoleList.do")
	public void saveChoiceRoleList(HttpServletResponse response , HttpServletRequest request , String staffIds , String sysRoleId)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			HttpSession session = request.getSession();
			String retVal = sysRoleService.saveChoiceRoleList(sysRoleId , staffIds , session);
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
