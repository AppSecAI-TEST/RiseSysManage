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

import com.rise.pub.util.StringUtil;
import com.rise.service.ShortCourseService;

@Controller
@RequestMapping("/shortCourseConfig")
public class ShortCourseController {

	private static Log log = LogFactory.getLog(ShortCourseController.class);
	
	@Autowired
	private ShortCourseService shortCourseService;
	
	//�������ڿ�
	@RequestMapping(value="/addShortClass.do")
	public void addShortClass(HttpServletResponse response,String json)
	{
		log.error(json);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = shortCourseService.addShortClass(json);
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
	
	//ɾ�����ڿ�
	@RequestMapping(value="/deleteShortClass.do")
	public void deleteShortClass(HttpServletResponse response,String shortClassId)
	{
		log.error(shortClassId);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = shortCourseService.deleteShortClass(shortClassId);
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
	
	//�������ڿ�����
	@RequestMapping(value="/addShortClassType.do")
	public void addShortClassType(HttpServletResponse response,String json)
	{
		log.error(json);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = shortCourseService.addShortClassType(json);
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
	
	//�޸Ķ��ڿ�����
	@RequestMapping(value="/updateShortClassType.do")
	public void updateShortClassType(HttpServletResponse response,String json)
	{
		log.error(json);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = shortCourseService.updateShortClassType(json);
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
	
	//ɾ�����ڿ�
	@RequestMapping(value="/deleteShortClassType.do")
	public void deleteShortClassType(HttpServletResponse response,String classTypeId)
	{
		log.error(classTypeId);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = shortCourseService.deleteShortClassType(classTypeId);
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
	
	//��ϵ��ҳ���ѯ
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
			String retVal = shortCourseService.qryDataListByPage(page, rows, param, funcNodeId);
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
	
	//��ת���ҳ��
	@RequestMapping(value="/jumpToAddPrice.do")
	public ModelAndView jumpToAddPrice(String type,String shortClassId)
	{
		ModelAndView view = null;
		try {
			if("PRICE".equals(type)){//��ת��Ӷ��ڿμ۸�����ҳ��
				view = new ModelAndView("shortCourseConfig/addShortPrice");
				String ret = shortCourseService.getAllClassType(shortClassId);
				view.addObject("obj",JSONObject.fromObject(ret));
			}else if("FAVOR".equals(type)){//��ת��Ӷ��ڿ��Ż�����ҳ��
				view = new ModelAndView("shortCourseConfig/addShortFavor");
			}
			view.addObject("shortClassId", shortClassId);
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return view;
	}
	
	//�����ϵ�ύ
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
			String retVal = shortCourseService.addPriceSystem(priceJson,classJson,type);
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
	
	//�����ϵ
	@RequestMapping(value="/viewPriceSystem.do")
	public ModelAndView viewPriceSystem(String json,String type)
	{
		log.error(json);
		log.error(type);
		ModelAndView view = null;
		try {
			JSONObject obj = JSONObject.fromObject(json);
			if("PRICE".equals(type)){//��ת������ڿμ۸�����ҳ��
				view = new ModelAndView("shortCourseConfig/viewShortPrice");
				String setPriceId = StringUtil.getJSONObjectKeyVal(obj, "setPriceId");
				String ret = shortCourseService.viewPriceSystem(setPriceId,type);
				view.addObject("retObj", JSONObject.fromObject(ret));
			}else if("FAVOR".equals(type)){//��ת������ڿ��Ż�����ҳ��
				view = new ModelAndView("shortCourseConfig/viewShortFavor");
				String setPriceId = StringUtil.getJSONObjectKeyVal(obj, "setPriceId");
				String ret = shortCourseService.viewPriceSystem(setPriceId,type);
				view.addObject("retObj", JSONObject.fromObject(ret));
			}
			view.addObject("obj",obj);
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return view;
	}
	
	//ɾ����ϵ
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
			String retVal = shortCourseService.deletePriceSystem(setPriceId,type);
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
	
	//��ת��ϵ�޸�ҳ��
	@RequestMapping(value="/jumpToUpdatePrice.do")
	public ModelAndView jumpToUpdatePrice(String json,String type)
	{
		log.error(json);
		log.error(type);
		ModelAndView view = null;
		try {
			JSONObject obj = JSONObject.fromObject(json);
			if("PRICE".equals(type)){//��ת�޸Ŀγ̼۸�����ҳ��
				view = new ModelAndView("shortCourseConfig/updateShortPrice");
				String setPriceId = StringUtil.getJSONObjectKeyVal(obj, "setPriceId");
				String ret = shortCourseService.viewPriceSystem(setPriceId,"UPDATEPRICE");
				view.addObject("retObj", JSONObject.fromObject(ret));
			}else if("FAVOR".equals(type)){//��ת�޸������Ż�����ҳ��
				view = new ModelAndView("shortCourseConfig/updateShortFavor");
				String setPriceId = StringUtil.getJSONObjectKeyVal(obj, "setPriceId");
				String ret = shortCourseService.viewPriceSystem(setPriceId,type);
				view.addObject("retObj", JSONObject.fromObject(ret));
			}
			view.addObject("obj",obj);
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return view;
	}
	
	//��ϵ�޸��ύ
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
			String retVal = shortCourseService.updatePriceSystem(priceJson,classJson,type);
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
