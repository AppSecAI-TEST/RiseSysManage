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
	public ModelAndView shortClassManInfo(String shortClassInstId , String funcNodeId , String pageName)
	{
		ModelAndView model = new ModelAndView("shortClass/"+pageName);
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
	public ModelAndView viewShortClassPage(String shortClassInstId , String funcNodeId , String pageName)
	{
		ModelAndView model = new ModelAndView("shortClass/"+pageName);
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
	public ModelAndView shortAttenceDetailPage(String shortClassInstId , String funcNodeId , String pageName)
	{
		ModelAndView model = new ModelAndView("shortClass/"+pageName);
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
	public void cancelShortClassFunc(String shortClassInstId , String remark , String handleId , HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = shortBusinessService.cancelShortClassFunc(shortClassInstId , remark , handleId);
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
	public void addShortClassInstTInfo(String json , String className , HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = shortBusinessService.addShortClassInstTInfo(json , className);
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
	public void addShortStudentTInfo(String json , String classType , HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = shortBusinessService.addShortStudentTInfo(json , classType);
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
	public ModelAndView getShortClassAttendTInfo(String shortClassInstId , String funcNodeId , String pageName)
	{
		ModelAndView model = new ModelAndView("shortClass/shortAttenceRecord");
		try
		{
			shortBusinessService.getShortClassAttendTInfo(model , shortClassInstId , funcNodeId , pageName);
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
	public ModelAndView shortAttenceUpdatePage(String shortClassAttendId , String funcNodeId , String pageName)
	{
		ModelAndView model = new ModelAndView("shortClass/shortAttenceUpdate");
		try
		{
			shortBusinessService.shortAttenceUpdatePage(model,shortClassAttendId,funcNodeId,pageName);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping("/shortAttenceViewPage.do")
	public ModelAndView shortAttenceViewPage(String shortClassAttendId , String funcNodeId , String pageName)
	{
		ModelAndView model = new ModelAndView("shortClass/shortAttenceView");
		try
		{
			shortBusinessService.shortAttenceViewPage(model,shortClassAttendId,funcNodeId,pageName);
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
	
	@RequestMapping("/verifyShortClassFunc.do")
	public void verifyShortClassFunc(String shortClassInstId , String handlerId , String isPutClass , String verifyCont , HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = shortBusinessService.verifyShortClassFunc(shortClassInstId, handlerId, isPutClass, verifyCont);
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
	
	@RequestMapping("/getGiftTypeList.do")
	public void getGiftTypeList(HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = shortBusinessService.getGiftTypeList();
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
	
	@RequestMapping("/addDirectShortClassInstInfo.do")
	public void addDirectShortClassInstInfo(HttpServletResponse response , String json , String classType , String schoolId , String stageId)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = shortBusinessService.addDirectShortClassInstInfo(json , classType , schoolId , stageId);
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
	
	@RequestMapping("/cancelGiftClassFunc.do")
	public void cancelGiftClassFunc(String shortClassInstId , String remark , String classType , String handleId , HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = shortBusinessService.cancelGiftClassFunc(shortClassInstId , remark , classType , handleId);
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
	
	@RequestMapping("/getForeignAttendTInfo.do")
	public ModelAndView getForeignAttendTInfo(String shortClassInstId , String funcNodeId)
	{
		ModelAndView model = new ModelAndView("shortClass/shortAttenceForeignRecord");
		try
		{
			shortBusinessService.getShortClassAttendTInfo(model , shortClassInstId , funcNodeId , "");
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return model;
	}
	
	@RequestMapping(value = "/qryDataListByPage.do")
	public void qryDataListByPage(String page, String rows, String param, String funcNodeId, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = shortBusinessService.qryDataListByPage(page, rows, param, funcNodeId);
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
