package com.rise.service;

import org.springframework.stereotype.Service;

import com.rise.pub.invoke.ServiceEngine;

@Service
public class RefundService 
{
	public String qryApplyRefund(String studentCourseId, String studentId) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS9004\",securityCode:\"0000000000\",params:{param:{studentCourseId:\""+studentCourseId+"\",studentId:\""+studentId+"\",queryCode:\"qryRefundStudentInfo\"}},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	public String applyRefund(String param) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS9001\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}

	public String qryApproveRefund(String refundFeeId) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS9005\",securityCode:\"0000000000\",params:{param:{refundFeeId:\""+refundFeeId+"\",queryCode:\"qryRefundFeeInfo\"}},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	public String approveRefund(String param) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS9003\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}

	public String cancelRefund(String param) throws Exception 
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS9006\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public String isCancel(String processInstId, String approveId) throws Exception 
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS9007\",securityCode:\"0000000000\",params:{processInstId:\""+processInstId+"\", approveId:\""+approveId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
}
