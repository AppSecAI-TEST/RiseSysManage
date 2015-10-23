package com.rise.service;

import org.springframework.stereotype.Service;

import com.rise.pub.invoke.ServiceEngine;

@Service
public class FeeService
{
	
	public String applyRefundFee(String param) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS9001\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}

	public String getProcessById(String processInstId,String approveId) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS9002\",securityCode:\"0000000000\",params:{processInstId:\""+processInstId+"\",approveId:\""+approveId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}

	public String updateRefundFee(String param) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS9003\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	public static void main(String[] args) throws Exception
	{
		String param="{\"account\":\"冉海全\",\"amount\": 30000,\"approveId\": \"10001\",\"bankCard\": 6225882701114412,\"bankName\": \"中国银行\",\"createDate\": null,\"customerReason\": \"\",\"handlerId\": 10001,\"isAcademic\": \"Y\",\"otherResaon\": \"\",\"processInstanceId\": \"\",\"realAmount\": 20000,\"refundFeeId\": 0,\"refundType\": \"card\",\"refundWay\": \"common\",\"remark\": \"\",\"schoolId\": 1001,\"schoolReason\": \"\",\"schoolReasonType\": \"\",\"state\": \"00A\",\"studentId\": 10001}";
		new FeeService().applyRefundFee(param);
//		new FeeService().getProcessById("fee.10001", "10001");
//		new FeeService().updateRefundFee("fee.7", "100002","Y");
	}
}



