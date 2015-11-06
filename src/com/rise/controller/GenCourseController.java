package com.rise.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.rise.pub.util.StringUtil;
import com.rise.service.GenCourseService;


@Controller
@RequestMapping("/genCourseConfig")
public class GenCourseController {

	private static Log log = LogFactory.getLog(GenCourseController.class);
	
	@Autowired
	private GenCourseService genCourseService;
	
	//新增课程阶段
	@RequestMapping(value="/addStage.do")
	public void addStage(HttpServletResponse response,String json)
	{
		log.error(json);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = genCourseService.addStage(json);
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
	
	//修改课程阶段
	@RequestMapping(value="/updateStage.do")
	public void updateStageConfig(HttpServletResponse response,String json)
	{
		log.error(json);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = genCourseService.updateStageConfig(json);
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
	
	//新增班级类型
	@RequestMapping(value="/addClassType.do")
	public void addClassTypeConfig(HttpServletResponse response,String json)
	{
		log.error(json);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = genCourseService.addClassTypeConfig(json);
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
	
	//修改班级类型
	@RequestMapping(value="/updateClassType.do")
	public void updateClassTypeConfig(HttpServletResponse response,String json)
	{
		log.error(json);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = genCourseService.updateClassTypeConfig(json);
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
	
	//删除班级类型
	@RequestMapping(value="/deleteClassType.do")
	public void deleteClassTypeConfig(HttpServletResponse response,String classId)
	{
		log.error(classId);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = genCourseService.deleteClassTypeConfig(classId);
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
	
	//删除课程阶段
	@RequestMapping(value="/deleteStage.do")
	public void deleteStageConfig(HttpServletResponse response,String id,String stageId)
	{
		log.error(id);
		log.error(stageId);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = genCourseService.deleteStageConfig(id,stageId);
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
	
	//修改开班人数
	@RequestMapping(value="/updateClassNum.do")
	public void updateClassNum(HttpServletResponse response,String json)
	{
		log.error(json);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = genCourseService.updateClassNum(json);
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
	
	//体系首页面查询
	@RequestMapping(value = "/qryDataListByPage.do")
	public void qryDataListByPage(String page, String rows, String param, String funcNodeId, HttpServletResponse response)
	{
		log.error(page);
		log.error(rows);
		log.error(param);
		log.error(funcNodeId);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = genCourseService.qryDataListByPage(page, rows, param, funcNodeId);
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
	
	//跳转添加页面
	@RequestMapping(value="/jumpToAddPrice.do")
	public ModelAndView jumpToAddPrice(String type)
	{
		ModelAndView view = null;
		try {
			if("COMMON".equals(type)){//跳转添加课程价格配置页面
				view = new ModelAndView("genCourseConfig/addComPrice");
				String ret = genCourseService.getAllClassType();
				view.addObject("obj",JSONObject.fromObject(ret));
			}else if("LINK".equals(type)){//跳转添加连报优惠配置页面
				view = new ModelAndView("genCourseConfig/addLinkPrice");
			}else if("DISCOUNT".equals(type)){//跳转添加复读折扣配置页面
				view = new ModelAndView("genCourseConfig/addDiscountPrice");
			}
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return view;
	}
	
	//添加体系提交
	@RequestMapping(value="/addPriceSystem.do")
	public void addPriceSystem(HttpServletResponse response,String priceJson,String classJson,String type)
	{
		log.error(priceJson);
		log.error(classJson);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = genCourseService.addPriceSystem(priceJson,classJson,type);
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
	
//	@RequestMapping(value="/updatePirceOpenState.do")
//	public void updatePirceOpenState(HttpServletResponse response,String setPriceId,String operType,String priceType)
//	{
//		log.error(setPriceId);
//		log.error(operType);
//		log.error(priceType);
//		PrintWriter out = null;
//		try
//		{
//			response.setCharacterEncoding("UTF-8");
//			out = response.getWriter();
//			String retVal = genCourseService.updatePirceOpenState(setPriceId,operType,priceType);
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

	//删除体系
	@RequestMapping(value="/deletePriceSystem.do")
	public void deletePriceSystem(HttpServletResponse response,String setPriceId,String type)
	{
		log.error(setPriceId);
		log.error(type);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = genCourseService.deletePriceSystem(setPriceId,type);
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
	
	//浏览体系
	@RequestMapping(value="/viewPriceSystem.do")
	public ModelAndView viewPriceSystem(String json,String type)
	{
		log.error(json);
		log.error(type);
		ModelAndView view = null;
		try {
			JSONObject obj = JSONObject.fromObject(json);
			if("COMMON".equals(type)){//跳转浏览课程价格配置页面
				view = new ModelAndView("genCourseConfig/viewComPrice");
				String setPriceId = StringUtil.getJSONObjectKeyVal(obj, "setPriceId");
				String ret = genCourseService.viewPriceSystem(setPriceId,type);
				view.addObject("retObj", JSONObject.fromObject(ret));
			}else if("LINK".equals(type)){//跳转浏览连报优惠配置页面
				view = new ModelAndView("genCourseConfig/viewLinkPrice");
				String setPriceId = StringUtil.getJSONObjectKeyVal(obj, "setPriceId");
				String ret = genCourseService.viewPriceSystem(setPriceId,type);
				view.addObject("retObj", JSONObject.fromObject(ret));
			}else if("DISCOUNT".equals(type)){//跳转浏览复读折扣配置页面
				view = new ModelAndView("genCourseConfig/viewDiscountPrice");
			}
			view.addObject("obj",obj);
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return view;
	}
	
	//跳转体系修改页面
	@RequestMapping(value="/jumpToUpdatePrice.do")
	public ModelAndView jumpToUpdatePrice(String json,String type)
	{
		log.error(json);
		log.error(type);
		ModelAndView view = null;
		try {
			JSONObject obj = JSONObject.fromObject(json);
			if("COMMON".equals(type)){//跳转修改课程价格配置页面
				view = new ModelAndView("genCourseConfig/updateComPrice");
				String setPriceId = StringUtil.getJSONObjectKeyVal(obj, "setPriceId");
				String ret = genCourseService.viewPriceSystem(setPriceId,"UPDATECOM");
				view.addObject("retObj", JSONObject.fromObject(ret));
			}else if("LINK".equals(type)){//跳转修改连报优惠配置页面
				view = new ModelAndView("genCourseConfig/updateLinkPrice");
				String setPriceId = StringUtil.getJSONObjectKeyVal(obj, "setPriceId");
				String ret = genCourseService.viewPriceSystem(setPriceId,type);
				view.addObject("retObj", JSONObject.fromObject(ret));
			}else if("DISCOUNT".equals(type)){//跳转修改复读折扣配置页面
				view = new ModelAndView("genCourseConfig/updateDiscountPrice");
			}
			view.addObject("obj",obj);
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return view;
	}
	
	//体系修改提交
	@RequestMapping(value="/updatePriceSystem.do")
	public void updatePriceSystem(HttpServletResponse response,String priceJson,String classJson,String type)
	{
		log.error(priceJson);
		log.error(classJson);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = genCourseService.updatePriceSystem(priceJson,classJson,type);
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
	
	/**
	 * 查询班级阶段
	 * @param response
	 */
	@RequestMapping(value = "/qrySetClassPrice.do")
	public void getSetClassPrice(String stageId,HttpServletResponse response)
	{
	 
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = genCourseService.getSetClassPrice(stageId);
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
}
