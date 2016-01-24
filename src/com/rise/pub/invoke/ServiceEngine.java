package com.rise.pub.invoke;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.xml.namespace.QName;

import net.sf.json.JSONObject;

import org.apache.axis.client.Call;
import org.apache.axis.client.Service;
import org.apache.axis2.AxisFault;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.rise.pub.pubData.QryPropertiesConfig;
import com.rise.pub.util.ObjectCensor;
import com.rise.pub.util.StringUtil;

/**
 * 调用WEB_SERVICE服务
 * @author RHQ
 *
 */
public class ServiceEngine
{
	//WEB_SERVICE 地址
	private static String address="";
	public static Log log = LogFactory.getLog(ServiceEngine.class);
	
 
	//private final static String url = "http://127.0.0.1:7001/sysEngine/invoke/commorder.do";
	private final static String url = "http://114.215.130.45/sysEngine/invoke/commorder.do";
 
	public static String invokeHttp(String param) throws Exception
	{
		//log.error("param:"+param);
		Map<String,String> params = new HashMap<String,String>();
		params.put("param", param);
		JSONObject object = JSONObject.fromObject(HttpUtil.http(url, params));
		if("success".equals(StringUtil.getJSONObjectKeyVal(object, "executeType")))
		{
			return StringUtil.getJSONObjectKeyVal(object, "returnMsg");
		}
		else
		{
			return StringUtil.getJSONObjectKeyVal(object, "exceptionMsg");
		}
	}
	
	public static String invokeService(String param) throws Exception 
	{
		HttpServletRequest request = ((ServletRequestAttributes)RequestContextHolder.getRequestAttributes()).getRequest();    
		param = modParam(param,request.getHeader("User-Agent"));
		Service service = new Service();
		Call call = null;
		if(ObjectCensor.checkObjectIsNull(address))
		{
			address = QryPropertiesConfig.getPropertyById("ESE_SERVICE_URL");
		}
		try
		{
			call = (Call) service.createCall();
			call.setTargetEndpointAddress(new java.net.URL(address));
			call.setOperationName(new QName("http://access.hbgz.com","openService"));
		
			Object obj =  call.invoke(new Object[] { param });
			if(obj!=null)
			{
				return obj.toString();
			}
		} catch (Exception se)
		{
			se.printStackTrace();
		}
		return null;
	}
	
	public static String invokeServiceByIp(String linkStr,String param) throws Exception 
	{
		Service service = new Service();
		Call call = null;
		call = (Call) service.createCall();
		call.setTargetEndpointAddress(new java.net.URL(linkStr));
		call.setOperationName(new QName("http://share.service.hbgz.com","singleSignService"));
		Object obj =  call.invoke(new Object[] { param });
		if(obj!=null)
		{
			return obj.toString();
		}
		else
		{
			return null;
		}
	}
	
	/**
	 * @author : tiankang
	 * @param param
	 * @param reqStr
	 * @return
	 */
	private static String modParam(String param,String reqStr)
	{
		try
		{
			int pos = -1;
			pos = reqStr.indexOf(")");
			String[] posArr = reqStr.substring(0,pos).split(";");
			if("U".equals(posArr[1].trim()))
			{
				JSONObject obj = JSONObject.fromObject(param);
				obj.put("channelType", "PAD");
				return obj.toString();
			}
			else
			{
				return param;
			}
		}
		catch(Exception err)
		{
			return param;
		}
	}
	
	/**
	 * 
	 * @param args
	 * @throws AxisFault
	 */
//	public static void main(String[] args) throws AxisFault 
//	{
//		Service service = new Service();
//		Call call = null;
//		String address = "http://192.168.110.111:7001/aoe/services/ability?wsdl";
//		String json = "{appId:\"0000000000\",channelId:\"Q\",serviceType:\"BUS1002\",abilityId:\"BUS1001\",transactionId:\"BUS1001\",signCode:\"PC\",encryptType:\"0000000000\",params:{\"appDesc\": \"1000社区\",\"appId\": 10001,\"appName\": \"1000社区\",\"appProtocolDoc\": \"123\",\"appRate\": \"123\",\"appSafeLevel\": \"1\",\"busiDepartment\": \"1\",\"channelId\": \"1000\",\"depContNumber\": \"1\",\"depContPerson\": \"1\",\"encPriKey\": \"12345644\",\"encPubKey\": \"45674\",\"encryptType\": \"12332\",\"joinReason\": \"123\",\"modifyDate\": null,\"netType\": \"112\",\"operStaff\": \"123\",\"recordState\": \"00A\",\"signCode\": \"1233\",\"userId\": 0 },rtnDataFormatType:\"json\"}";
//		try
//		{
//			call = (Call) service.createCall();
//			call.setTargetEndpointAddress(new java.net.URL(address));
//			call.setOperationName(new QName("http://access.hbgz.com", "openService"));
//		
//			Object obj =  call.invoke(new Object[] { json });
//			System.out.println(obj);
//		} catch (Exception se)
//		{
//			se.printStackTrace();
//		}
//	}
	
	public static void main(String[] args) {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0011\",securityCode:\"0000000000\",params:{busAccount:\"hls1001\",busPassword:\"123123\"},rtnDataFormatType:\"user-defined\"}";
		String param1 = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0021\",securityCode:\"0000000000\",params:{busDetailId:\"1001\",state:\"A\",pageNum:\"1\",pageSize:\"10\"},rtnDataFormatType:\"user-defined\"}";
		String param2 = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0022\",securityCode:\"0000000000\",params:{busDetailId:\"1001\"},rtnDataFormatType:\"user-defined\"}";
		String param3 = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0023\",securityCode:\"0000000000\",params:{orderId:\"E20150825101518100000156\",state:\"H\"},rtnDataFormatType:\"user-defined\"}";
		String param4 = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0024\",securityCode:\"0000000000\",params:{busDetailId:\"1019\",orderIds:\"E20150916111042100000300\"},rtnDataFormatType:\"user-defined\"}";
		
		try {
			System.out.println(invokeHttp(param4));
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	
}

