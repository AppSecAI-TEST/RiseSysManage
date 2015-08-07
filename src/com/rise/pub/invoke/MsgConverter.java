package com.rise.pub.invoke;

import net.sf.json.JSONObject;

import com.rise.pub.base.JacksonJsonMapper;
import com.rise.pub.util.ObjectCensor;
import com.rise.pub.util.StringUtil;

public class MsgConverter
{
    public static Object getServiceRstMessage(String rst, Class paramClassType) throws Exception 
    {

	JSONObject object = JSONObject.fromObject(rst);
	String executeType = StringUtil.getJSONObjectKeyVal(object, "executeType");
	String returnMsgType = StringUtil.getJSONObjectKeyVal(object, "returnMsgType");
	if ("success".equals(executeType)) 
	{
	    if ("JSONArray".equals(returnMsgType)) 
	    {
		String returnMsg = StringUtil.getJSONObjectKeyVal(object, "returnMsg");
		return JacksonJsonMapper.getInstance().readValue(returnMsg, paramClassType);
	    } 
	    else 
	    {
		String returnMsg = StringUtil.getJSONObjectKeyVal(object, "returnMsg");
		if(ObjectCensor.isStrRegular(returnMsg) && !"null".equals(returnMsg) )
		{
		    JSONObject jsonObject = JSONObject.fromObject(returnMsg);
		    return jsonObject.toBean(jsonObject, paramClassType);
		}
		return null;
	    }
	} 
	else 
	{
	    String execeptionMsg = StringUtil.getJSONObjectKeyVal(object, "exceptionMsg");
	    throw new Exception(execeptionMsg);
	}
    }
}
