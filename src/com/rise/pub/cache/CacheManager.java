package com.rise.pub.cache;

import org.springframework.stereotype.Component;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.rise.pub.invoke.ServiceEngine;
import com.rise.pub.util.StringUtil;

@Component
public class CacheManager 
{
    public JSONArray qryConfigInfo(String codeType,String codeFlag) throws Exception
    {
    	String param="{appId:\"0000000000\",channelId:\"Q\",serviceType:\"BUS3002\",capInstId:\"BUS3002\",transactionId:\"BUS3002\",signCode:\"PC\",encryptCode:\"0000000000\",params:{codeType:\""+codeType+"\",codeFlag:\""+codeFlag+"\"},rtnDataFormatType:\"json\"}";
    	String str = ServiceEngine.invokeService(param);
    	JSONObject object = JSONObject.fromObject(str);
    	String returnMsg = StringUtil.getJSONObjectKeyVal(object, "returnMsg");
    	return JSONArray.fromObject(returnMsg);
    }
    
    public JSONArray qryBusiCapaTypeInfo() throws Exception
    {
    	String param="{appId:\"0000000000\",channelId:\"Q\",serviceType:\"BUS3003\",capInstId:\"BUS3003\",transactionId:\"BUS3003\",signCode:\"PC\",encryptCode:\"0000000000\",params:{},rtnDataFormatType:\"json\"}";
    	String str = ServiceEngine.invokeService(param);
    	JSONObject object = JSONObject.fromObject(str);
    	String returnMsg = StringUtil.getJSONObjectKeyVal(object, "returnMsg");
    	return JSONArray.fromObject(returnMsg);
    }
    
    public JSONArray qryBusiCapaTypeLevel() throws Exception
    {
    	String param="{appId:\"0000000000\",channelId:\"Q\",serviceType:\"BUS1408\",capInstId:\"BUS1408\",transactionId:\"BUS1408\",signCode:\"PC\",encryptCode:\"0000000000\",params:{},rtnDataFormatType:\"json\"}";
    	String str = ServiceEngine.invokeService(param);
    	JSONObject object = JSONObject.fromObject(str);
    	String returnMsg = StringUtil.getJSONObjectKeyVal(object, "returnMsg");
    	return JSONArray.fromObject(returnMsg);
    }
}
