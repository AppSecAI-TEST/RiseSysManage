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
	
	//新增赠品根据类型区分
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
	
	//跳转赠品领取和退回页面根据type区分
	@RequestMapping(value="/jumpToGetAndRtn.do")
	public ModelAndView jumpToGetAndRtn(String json,String funcNodeId,String type)
	{
		log.error(json);
		log.error(funcNodeId);
		ModelAndView view = null;
		if("goodsGet".equals(type)){//实物教材领取
			view = new ModelAndView("giftManage/getGoodsGift");
		}else if("goodsRtn".equals(type)){//实物教材退回
			view = new ModelAndView("giftManage/rtnGoodsGift");
		}else if("couponGet".equals(type)){//券类领取
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
	
	//教材实物劵类 信息更新类型区分不同逻辑
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
	
	//浏览实物教材赠品信息
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
	
	//获取赠券信息并根据类型跳转到不同页面
	@RequestMapping(value="/viewCouponGiftInfo.do")
	public ModelAndView viewCouponGiftInfo(String json,String funcNodeId,String type)
	{
		log.error(json);
		log.error(funcNodeId);
		ModelAndView view = null;
		try {
			JSONObject obj = JSONObject.fromObject(json);
			if("exchange".equals(type)){
				view = new ModelAndView("giftManage/couponExchange");//赠券兑换
			}else if("invalidate".equals(type)){
				view = new ModelAndView("giftManage/couponInvalidate");//赠券作废
			}else if("delay".equals(type)){
				view = new ModelAndView("giftManage/couponDelay");//赠券延期
			}else if("view".equals(type)){
				view = new ModelAndView("giftManage/viewCouponGift");//赠券浏览
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
	
	//更新劵类信息根据类型区分
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
	
	//获取赠课信息根据不同类型跳转不同页面
	@RequestMapping(value="/viewCourseGiftInfo.do")
	public ModelAndView viewCourseGiftInfo(String json,String funcNodeId,String type)
	{
		log.error(json);
		log.error(funcNodeId);
		ModelAndView view = null;
		try {
			JSONObject obj = JSONObject.fromObject(json);
			if("finish".equals(type)){
				view = new ModelAndView("giftManage/courseFinish");//跳转终止赠课
				String studentGiftId = StringUtil.getJSONObjectKeyVal(obj, "studentGiftId");
				String ret = giftManageService.viewGiftInfo(studentGiftId, funcNodeId);
				view.addObject("retObj", JSONObject.fromObject(ret));
			}else if("view".equals(type)){//跳转浏览赠课
				view = new ModelAndView("giftManage/viewCourseGift");
			}
			view.addObject("obj",obj);
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return view;
	}
	
	//终止赠课
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
