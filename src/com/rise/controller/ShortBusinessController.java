package com.rise.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.rise.service.ShortBusinessService;

@Controller
@RequestMapping("/shortBus")
public class ShortBusinessController 
{
	@Autowired
	private ShortBusinessService shortBusinessService;
	
	/**
	 * 获取短期班类型
	 * @param typeName
	 * @param response
	 */
	@RequestMapping("/getShortClassTypeList.do")
	public void getShortClassTypeList(String typeName, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = shortBusinessService.getShortClassTypeList(typeName);
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
	
	@RequestMapping("/getShortClassInstTList.do")
	public void getShortClassInstTList(String typeName , String classTypeId , HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = shortBusinessService.getShortClassInstTList(typeName,classTypeId);
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
	
	@RequestMapping("/cancelShortClassInfo.do")
	public ModelAndView cancelShortClassInfo(String shortClassInstId , String funcNodeId)
	{
		ModelAndView model = new ModelAndView("shortClass/cancelShortClass");
		try
		{
			shortBusinessService.getShortClassInfo(model,shortClassInstId,funcNodeId);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping("/shortClassManInfo.do")
	public ModelAndView shortClassManInfo(String shortClassInstId , String funcNodeId)
	{
		ModelAndView model = new ModelAndView("shortClass/shortClassMan");
		try
		{
			shortBusinessService.getShortClassInfo(model,shortClassInstId,funcNodeId);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping("/viewShortClassPage.do")
	public ModelAndView viewShortClassPage(String shortClassInstId , String funcNodeId)
	{
		ModelAndView model = new ModelAndView("shortClass/viewShortClass");
		try
		{
			shortBusinessService.getShortClassInfo(model,shortClassInstId,funcNodeId);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping("/shortAttenceDetailPage.do")
	public ModelAndView shortAttenceDetailPage(String shortClassInstId , String funcNodeId)
	{
		ModelAndView model = new ModelAndView("shortClass/shortAttenceDetail");
		try
		{
			shortBusinessService.shortAttenceDetailPage(model,shortClassInstId,funcNodeId);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping("/cancelShortClassFunc.do")
	public void cancelShortClassFunc(String shortClassInstId , String remark , HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = shortBusinessService.cancelShortClassFunc(shortClassInstId,remark);
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
	
//	@RequestMapping("/getShortClassInfo.do")
//	public ModelAndView getShortClassInfo(String shortClassInstId , String funcNodeId)
//	{
//		ModelAndView model = new ModelAndView("shortClass/addInterClass");
//		try
//		{
//			shortBusinessService.getAddShortClassInfo(model,shortClassInstId,funcNodeId);
//		}
//		catch(Exception e)
//		{
//			e.printStackTrace();
//		}
//		return model;
//	}
	
	@RequestMapping("/getAddShortClassInfo.do")
	public ModelAndView getAddShortClassInfo(String shortClassInstId , String funcNodeId , String pageName)
	{
		ModelAndView model = new ModelAndView("shortClass/"+pageName);
		try
		{
			shortBusinessService.getAddShortClassInfo(model,shortClassInstId,funcNodeId);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping("/addShortSchooltimeTInfo.do")
	public void addShortSchooltimeTInfo(String json , HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = shortBusinessService.addShortSchooltimeTInfo(json);
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
	
	@RequestMapping("/delShortSchooltimeTInfo.do")
	public void delShortSchooltimeTInfo(String shortSchooltimeId , HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = shortBusinessService.delShortSchooltimeTInfo(shortSchooltimeId);
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
	
	@RequestMapping("/addShortClassInstTInfo.do")
	public void addShortClassInstTInfo(String json , HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = shortBusinessService.addShortClassInstTInfo(json);
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
	
	@RequestMapping("/addTourismClassInfo.do")
	public void addTourismClassInfo(String json , HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = shortBusinessService.addTourismClassInfo(json);
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
	
	@RequestMapping("/updateShortClassInstTInfo.do")
	public void updateShortClassInstTInfo(String json , HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = shortBusinessService.updateShortClassInstTInfo(json);
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
	
	
	@RequestMapping("/addShortStudentTInfo.do")
	public void addShortStudentTInfo(String json , HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = shortBusinessService.addShortStudentTInfo(json);
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
	
	@RequestMapping("/delShortStudentList.do")
	public void delShortStudentList(String shortClassInstId , String studentIds , String handlerId , HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = shortBusinessService.delShortStudentList(shortClassInstId , studentIds , handlerId);
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
	
	@RequestMapping("/getShortClassAttendTInfo.do")
	public ModelAndView getShortClassAttendTInfo(String shortClassInstId , String funcNodeId)
	{
		ModelAndView model = new ModelAndView();
		try
		{
			shortBusinessService.getShortClassAttendTInfo(model,shortClassInstId,funcNodeId);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping("/addShortAttendTInfo.do")
	public void addShortAttendTInfo(String json , HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = shortBusinessService.addShortAttendTInfo(json);
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
	
	@RequestMapping("/shortAttenceUpdatePage.do")
	public ModelAndView shortAttenceUpdatePage(String shortClassAttendId , String funcNodeId)
	{
		ModelAndView model = new ModelAndView("shortClass/shortAttenceUpdate");
		try
		{
			shortBusinessService.shortAttenceUpdatePage(model,shortClassAttendId,funcNodeId);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping("/shortAttenceViewPage.do")
	public ModelAndView shortAttenceViewPage(String shortClassAttendId , String funcNodeId)
	{
		ModelAndView model = new ModelAndView("shortClass/shortAttenceView");
		try
		{
			shortBusinessService.shortAttenceViewPage(model,shortClassAttendId,funcNodeId);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping("/updateShortAttendTInfo.do")
	public void updateShortAttendTInfo(String json , HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = shortBusinessService.updateShortAttendTInfo(json);
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
	
	@RequestMapping("/accessShortClassPage.do")
	public ModelAndView accessShortClassPage(String shortClassInstId , String funcNodeId , String classType , String pageName)
	{
		ModelAndView model = new ModelAndView("shortClass/"+pageName);
		try
		{
			shortBusinessService.accessShortClassPage(model,shortClassInstId,funcNodeId,classType);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping("/accessShortAttenceDetail.do")
	public ModelAndView accessShortAttenceDetail(String shortClassInstId , String funcNodeId , String pageName)
	{
		ModelAndView model = new ModelAndView("shortClass/"+pageName);
		try
		{
			shortBusinessService.accessShortAttenceDetail(model, shortClassInstId, funcNodeId);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping("/tourismAttenceRecordPage.do")
	public ModelAndView tourismAttenceRecordPage(String shortClassInstId , String funcNodeId)
	{
		ModelAndView model = new ModelAndView("shortClass/tourismAttenceRecord");
		try
		{
			shortBusinessService.tourismAttenceRecordPage(model, shortClassInstId, funcNodeId);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping("/addShortTourismAttendTInfo.do")
	public void addShortTourismAttendTInfo(String json , HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = shortBusinessService.addShortTourismAttendTInfo(json);
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
	
	@RequestMapping("/tourismAttenceRecUpdatePage.do")
	public ModelAndView tourismAttenceRecUpdatePage(String shortClassAttendId , String funcNodeId)
	{
		ModelAndView model = new ModelAndView("shortClass/tourismAttenceRecUpdate");
		try
		{
			shortBusinessService.tourismAttenceRecUpdatePage(model, shortClassAttendId, funcNodeId);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping("/updateShortTourismAttenceInfo.do")
	public void updateShortTourismAttenceInfo(String json , HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = shortBusinessService.updateShortTourismAttenceInfo(json);
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
	
	@RequestMapping("/shortTourismAttenceViewPage.do")
	public ModelAndView shortTourismAttenceViewPage(String shortClassAttendId , String funcNodeId)
	{
		ModelAndView model = new ModelAndView("shortClass/shortTourismAttenceView");
		try
		{
			shortBusinessService.tourismAttenceRecUpdatePage(model, shortClassAttendId, funcNodeId);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return model;
	}
	
}
