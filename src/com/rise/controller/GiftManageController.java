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
import com.rise.service.GiftManageService;

@Controller
@RequestMapping("/giftManage")
public class GiftManageController {

	private static Log log = LogFactory.getLog(GiftManageController.class);
	
	@Autowired
	private GiftManageService giftManageService;
	
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
			String retVal = giftManageService.qryDataListByPage(page, rows, param, funcNodeId);
			
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
	
	//������Ʒ������������
	@RequestMapping(value="/addGiftInfo.do")
	public void addGiftInfo(HttpServletResponse response,String json,String type)
	{
		log.error(json);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = giftManageService.addGiftInfo(json,type);
			
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
	
	//��ת��Ʒ��ȡ���˻�ҳ�����type����
	@RequestMapping(value="/jumpToGetAndRtn.do")
	public ModelAndView jumpToGetAndRtn(String json,String funcNodeId,String type)
	{
		log.error(json);
		log.error(funcNodeId);
		ModelAndView view = null;
		if("goodsGet".equals(type)){//ʵ��̲���ȡ
			view = new ModelAndView("giftManage/getGoodsGift");
		}else if("goodsRtn".equals(type)){//ʵ��̲��˻�
			view = new ModelAndView("giftManage/rtnGoodsGift");
		}else if("couponGet".equals(type)){//ȯ����ȡ
			view = new ModelAndView("giftManage/getCouponGift");
		}
		try {
			JSONArray array = JSONArray.fromObject(json);
			view.addObject("obj",array);
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return view;
	}
	
	//�̲�ʵ��� ��Ϣ�����������ֲ�ͬ�߼�
	@RequestMapping(value="/updateGiftInfo.do")
	public void updateGiftInfo(HttpServletResponse response,String json,String type)
	{
		log.error(json);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = giftManageService.updateGiftInfo(json,type);
			
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
	
	//���ʵ��̲���Ʒ��Ϣ
	@RequestMapping(value="/viewGoodsGiftInfo.do")
	public ModelAndView viewGoodsGiftInfo(String studentGiftId,String channelName,String isGetVal,String isRtnVal,String funcNodeId)
	{
		log.error(studentGiftId);
		log.error(funcNodeId);
		ModelAndView view = null;
		view = new ModelAndView("giftManage/viewGoodsGift");
		try {
			String ret = giftManageService.viewGiftInfo(studentGiftId, funcNodeId);
			JSONObject obj = JSONObject.fromObject(ret);
			view.addObject("obj",obj);
			view.addObject("channelName",channelName);
			view.addObject("isGetVal",isGetVal);
			view.addObject("isRtnVal",isRtnVal);
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return view;
	}
	
	//��ȡ��ȯ��Ϣ������������ת����ͬҳ��
	@RequestMapping(value="/viewCouponGiftInfo.do")
	public ModelAndView viewCouponGiftInfo(String json,String funcNodeId,String type)
	{
		log.error(json);
		log.error(funcNodeId);
		ModelAndView view = null;
		try {
			JSONObject obj = JSONObject.fromObject(json);
			if("exchange".equals(type)){
				view = new ModelAndView("giftManage/couponExchange");//��ȯ�һ�
			}else if("invalidate".equals(type)){
				view = new ModelAndView("giftManage/couponInvalidate");//��ȯ����
			}else if("delay".equals(type)){
				view = new ModelAndView("giftManage/couponDelay");//��ȯ����
			}else if("view".equals(type)){
				view = new ModelAndView("giftManage/viewCouponGift");//��ȯ���
				String studentGiftId = StringUtil.getJSONObjectKeyVal(obj, "studentGiftId");
				String ret = giftManageService.viewCouponGiftInfo(studentGiftId, funcNodeId);
				JSONObject retObj = JSONObject.fromObject(ret);
				view.addObject("retObj", retObj);
			}
			view.addObject("obj",obj);
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return view;
	}
	
	//��������Ϣ������������
	@RequestMapping(value="/updateCouponGiftInfo.do")
	public void updateCouponGiftInfo(HttpServletResponse response,String json,String type)
	{
		log.error(json);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = giftManageService.updateCouponGiftInfo(json,type);
			
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
	
	//��ȡ������Ϣ���ݲ�ͬ������ת��ͬҳ��
	@RequestMapping(value="/viewCourseGiftInfo.do")
	public ModelAndView viewCourseGiftInfo(String json,String funcNodeId,String type)
	{
		log.error(json);
		log.error(funcNodeId);
		ModelAndView view = null;
		try {
			JSONObject obj = JSONObject.fromObject(json);
			if("finish".equals(type)){
				view = new ModelAndView("giftManage/courseFinish");//��ת��ֹ����
				String studentGiftId = StringUtil.getJSONObjectKeyVal(obj, "studentGiftId");
				String ret = giftManageService.viewGiftInfo(studentGiftId, funcNodeId);
				view.addObject("retObj", JSONObject.fromObject(ret));
			}else if("view".equals(type)){//��ת�������
				view = new ModelAndView("giftManage/viewCourseGift");
			}
			view.addObject("obj",obj);
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return view;
	}
	
	//��ֹ����
	@RequestMapping(value="/updateCourseGiftInfo.do")
	public void updateCourseGiftInfo(HttpServletResponse response,String json)
	{
		log.error(json);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = giftManageService.updateCourseGiftInfo(json);
			
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
