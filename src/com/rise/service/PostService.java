package com.rise.service;

import java.util.List;

import net.sf.json.JSONObject;

import org.springframework.stereotype.Service;
import org.springframework.web.servlet.ModelAndView;

import com.rise.model.PostT;
import com.rise.pub.base.JacksonJsonMapper;
import com.rise.pub.invoke.ServiceEngine;
import com.rise.pub.util.ObjectCensor;
import com.rise.pub.util.StringUtil;

@Service
public class PostService 
{
	public String queryPostList(Integer page, Integer rows, String postName) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2031\",securityCode:\"0000000000\",params:{page:\""+page+"\",rows:\""+rows+"\",postName:\""+postName+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public void getPostInfo(ModelAndView model , String postId , String funcNodeId) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2032\",securityCode:\"0000000000\",params:{postId:\""+postId+"\"},rtnDataFormatType:\"user-defined\"}";
		String result = ServiceEngine.invokeHttp(param);
		JSONObject json = JSONObject.fromObject(result);
		if(ObjectCensor.isStrRegular(postId))
		{
			PostT postT = JacksonJsonMapper.getInstance().readValue(StringUtil.getJSONObjectKeyVal(json, "PostT"), PostT.class); 
			model.addObject("PostT", postT);
		}
		List schoolList = JacksonJsonMapper.getInstance().readValue(StringUtil.getJSONObjectKeyVal(json, "schoolList"), List.class); 
		model.addObject("SchoolList", schoolList);
		model.addObject("funcNodeId", funcNodeId);
	}
	
	public String addPost(PostT postT) throws Exception
	{
		JSONObject json = JSONObject.fromObject(postT);
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2033\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String updatePost(PostT postT) throws Exception
	{
		JSONObject json = JSONObject.fromObject(postT);
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2034\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String deletePost(String postId) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2035\",securityCode:\"0000000000\",params:{postId:\""+postId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
	
	public String qryPostInfoList() throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS2036\",securityCode:\"0000000000\",params:{},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}
}
