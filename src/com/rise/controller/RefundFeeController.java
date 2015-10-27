package com.rise.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rise.service.FeeService;

@Controller
@RequestMapping("/fee")
public class RefundFeeController
{

	@Autowired
	FeeService feeService;
	
	/**
	 * 退费申请
	 * @param param
	 * @param response
	 * @param request
	 */
	@RequestMapping(value = "/apply.do")
	public void applyRefund(String param,HttpServletResponse response, HttpServletRequest request)
	{
		
		String params="{\"account\":\"冉海全\",\"amount\": 30000,\"approveId\": \"10001\",\"bankCard\": 6225882701114412,\"bankName\": \"中国银行\",\"createDate\": null,\"customerReason\": \"\",\"handlerId\": 10001,\"isAcademic\": \"Y\",\"otherResaon\": \"\",\"processInstanceId\": \"\",\"realAmount\": 20000,\"refundFeeId\": 0,\"refundType\": \"card\",\"refundWay\": \"common\",\"remark\": \"\",\"schoolId\": 1001,\"schoolReason\": \"\",\"schoolReasonType\": \"\",\"state\": \"00A\",\"studentId\": 26}";
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = feeService.applyRefundFee(params);
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
	 * 判断用户是否能退费审批
	 * @param param
	 * @param response
	 * @param request
	 */
	@RequestMapping(value = "/isApprove.do")
	public void isApprove(String processInstId,String approveId,HttpServletResponse response,HttpServletRequest request)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = feeService.getProcessById(processInstId, approveId);
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
	 * 用户退费审批
	 * @param param
	 * @param response
	 * @param request
	 */
	@RequestMapping(value = "/approve.do")
	public void approve(String param,HttpServletResponse response,HttpServletRequest request)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = feeService.updateRefundFee(param);
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
