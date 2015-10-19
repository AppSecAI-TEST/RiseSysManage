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

import com.rise.service.GiftConfigService;

@Controller
@RequestMapping("/giftConfig")
public class GiftConfigController {

private static Log log = LogFactory.getLog(GiftManageController.class);
	
	@Autowired
	private GiftConfigService giftConfigService;
	
	//������ƷС�����ø����������֣��̲ĸ�ʵ����������棩
	@RequestMapping(value="/addGiftConfig.do")
	public void addGiftConfig(HttpServletResponse response,String json,String type)
	{
		log.error(json);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = giftConfigService.addGiftConfig(json,type);
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
	
	//�޸���ƷС����Ϣ���ݲ�ͬ���ͷ�Ϊʵ����Ρ���ȯ���̲�
	@RequestMapping(value="/updateGiftConfig.do")
	public void updateGiftConfig(HttpServletResponse response,String json,String type)
	{
		log.error(json);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = giftConfigService.updateGiftConfig(json,type);
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
	
	//ɾ����ƷС��
	@RequestMapping(value="/deleteGiftConfig.do")
	public void deleteGiftConfig(HttpServletResponse response,String giftId,String type)
	{
		log.error(giftId);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = giftConfigService.deleteGiftConfig(giftId,type);
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
	
	//������Ʒ���ô��࣬������������
	@RequestMapping(value="/addGiftTypeConfig.do")
	public void addGiftTypeConfig(HttpServletResponse response,String json,String type)
	{
		log.error(json);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = giftConfigService.addGiftTypeConfig(json,type);
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
	
	//��תҳ�����Ʒ������Ϣ����ȥ������������ת��ͬҳ��
	@RequestMapping(value="/viewGiftTypeInfo.do")
	public ModelAndView viewGiftTypeInfo(String json,String type,String funcNodeId)
	{
		log.error(json);
		log.error(funcNodeId);
		ModelAndView view = null;
		try {
			JSONObject obj = JSONObject.fromObject(json);
			if("COURSE".equals(type)){
				view = new ModelAndView("giftConfig/updateCourseType");
			}else if("COUPON".equals(type)){
				view = new ModelAndView("giftConfig/updateCouponType");
			}
			view.addObject("obj",obj);
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return view;
	}
	
	//�޸���Ʒ���ô��࣬������������
	@RequestMapping(value="/updateGiftTypeConfig.do")
	public void updateGiftTypeConfig(HttpServletResponse response,String json,String type)
	{
		log.error(json);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = giftConfigService.updateGiftTypeConfig(json,type);
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
	
	//ɾ����Ʒ���࣬������������С����һ��ɾ��
	@RequestMapping(value="/deleteGiftTypeConfig.do")
	public void deleteGiftTypeConfig(HttpServletResponse response,String giftTypeId,String type)
	{
		log.error(giftTypeId);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = giftConfigService.deleteGiftTypeConfig(giftTypeId,type);
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
