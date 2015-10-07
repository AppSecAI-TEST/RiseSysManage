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

import com.rise.model.FuncNodeT;
import com.rise.model.ResourceT;
import com.rise.service.FuncNodeService;

@Controller
@RequestMapping("/funcNode")
public class FuncNodeController 
{
	private static Log log = LogFactory.getLog(SysRoleController.class);
	
	@Autowired
	private FuncNodeService funcNodeService;
	
//	@RequestMapping(value = "/qryFuncNodeList.do")
//	public void qryFuncNodeList(String page, String rows, String param, HttpServletResponse response)
//	{
//		log.error(page);
//		log.error(rows);
//		log.error(param);
//		PrintWriter out = null;
//		try
//		{
//			response.setCharacterEncoding("UTF-8");
//			out = response.getWriter();
//			String retVal = funcNodeService.qryFuncNodeList(page, rows, param);
//			log.error(retVal);
//			out.write(retVal);
//		}
//		catch(Exception e)
//		{
//			e.printStackTrace();
//		}
//		finally
//		{
//			if(out != null)
//			{
//				out.close();
//			}
//		}
//	}
	
	@RequestMapping(value = "/getFuncNodeTableList.do")
	public void getFuncNodeTableList(HttpServletResponse response , String id , String page, String rows)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			Integer pageNumInt = Integer.parseInt(page)-1;
			Integer pageSizeInt = Integer.parseInt(rows);
			String retVal = funcNodeService.getFuncNodeTableList(id, pageNumInt*pageSizeInt, pageSizeInt);
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
	
	@RequestMapping(value = "/getFuncNodeInfoList.do")
	public void getFuncNodeInfoList(HttpServletResponse response , String id)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = funcNodeService.getFuncNodeInfoList(id);
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
	
	@RequestMapping(value = "/getSubFuncNodeList.do")
	public void getSubFuncNodeList(HttpServletResponse response , String id)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = funcNodeService.getSubFuncNodeList(id);
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
	
	@RequestMapping(value = "/getSubFuncNodeListWithRole.do")
	public void getSubFuncNodeListWithRole(HttpServletResponse response , String sysRoleId)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = funcNodeService.getSubFuncNodeListWithRole(sysRoleId);
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
	
	@RequestMapping("/addFuncNodeInfo.do")
	public void addFuncNodeInfo(HttpServletResponse response , FuncNodeT funcNodeT , ResourceT resourceT)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = funcNodeService.addFuncNodeInfo(funcNodeT,resourceT);
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
	
	@RequestMapping("/updateFuncNodeInfo.do")
	public void updateFuncNodeInfo(HttpServletResponse response , FuncNodeT funcNodeT , ResourceT resourceT)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = funcNodeService.updateFuncNodeInfo(funcNodeT,resourceT);
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
	
	@RequestMapping("/deleteFuncNodeInfo.do")
	public void deleteFuncNodeInfo(HttpServletResponse response , String funcNodeId)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = funcNodeService.deleteFuncNodeInfo(funcNodeId);
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
	
	@RequestMapping("/getParentMenuList.do")
	public void getParentMenuList(HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = funcNodeService.getParentMenuList();
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
	
	@RequestMapping("/getParentOperList.do")
	public void getParentOperList(HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = funcNodeService.getParentOperList();
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
	
	@RequestMapping("/getParentPrivList.do")
	public void getParentPrivList(HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = funcNodeService.getParentPrivList();
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
	
//	@RequestMapping(value = "/addFuncNode.do")
//	public void addFuncNode(String param, HttpServletResponse response)
//	{
//		log.error(param);
//		PrintWriter out = null;
//		try
//		{
//			response.setCharacterEncoding("UTF-8");
//			out = response.getWriter();
//			String retVal = funcNodeService.addFuncNode(param);
//			log.error(retVal);
//			out.write(retVal);
//		}
//		catch(Exception e)
//		{
//			e.printStackTrace();
//		}
//		finally
//		{
//			if(out != null)
//			{
//				out.close();
//			}
//		}
//	}
//	
//	@RequestMapping(value = "/updateFuncNode.do")
//	public void updateFuncNode(String param, HttpServletResponse response)
//	{
//		log.error(param);
//		PrintWriter out = null;
//		try
//		{
//			response.setCharacterEncoding("UTF-8");
//			out = response.getWriter();
//			String retVal = funcNodeService.updateFuncNode(param);
//			log.error(retVal);
//			out.write(retVal);
//		}
//		catch(Exception e)
//		{
//			e.printStackTrace();
//		}
//		finally
//		{
//			if(out != null)
//			{
//				out.close();
//			}
//		}
//	}
//	
//	@RequestMapping(value = "/deleteFuncNode.do")
//	public void deleteFuncNode(String funcNodeId, HttpServletResponse response)
//	{
//		log.error(funcNodeId);
//		PrintWriter out = null;
//		try
//		{
//			response.setCharacterEncoding("UTF-8");
//			out = response.getWriter();
//			String retVal = funcNodeService.deleteFuncNode(funcNodeId);
//			log.error(retVal);
//			out.write(retVal);
//		}
//		catch(Exception e)
//		{
//			e.printStackTrace();
//		}
//		finally
//		{
//			if(out != null)
//			{
//				out.close();
//			}
//		}
//	}
	
	@RequestMapping("/getCtrlData.do")
	public void getCtrlData(HttpServletResponse response , HttpServletRequest request , String resourceId , String funcNodeId)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			HttpSession session = request.getSession();
			String retVal = funcNodeService.getCtrlData(resourceId, funcNodeId, session);
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
	
	@RequestMapping("/comboboxSetting.do")
	public void comboboxSetting(HttpServletResponse response , HttpServletRequest request , String resourceId , String funcNodeId)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			HttpSession session = request.getSession();
			String retVal = funcNodeService.getCtrlData(resourceId, funcNodeId, session);
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
	
	@RequestMapping("/getPrivFuncNodeList.do")
	public void getPrivFuncNodeList(HttpServletResponse response , String sysRoleId)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = funcNodeService.getPrivFuncNodeList(sysRoleId);
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
