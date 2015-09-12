package com.rise.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rise.pub.util.StringUtil;
import com.rise.service.ExampleService;

@Controller
@RequestMapping("/example")
public class ExampleController 
{
	@Autowired
	private ExampleService exampleService;
	
	@RequestMapping(value = "/addExample.do")
	public void addExample(HttpServletRequest request , HttpServletResponse response ,String exampleName,String exampleValue)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("utf-8");
			out = response.getWriter();
			String retVal = exampleService.addExample(exampleName, exampleValue);
			out.write(retVal);
		}
		catch(Exception err)
		{
			out.write(err.getMessage());
			err.printStackTrace();
		}
		finally
		{
			if(out != null)
			{
				out.close();
			}
		}
	}
	
	@RequestMapping(value = "/queryExample.do")
	public void queryExample(HttpServletRequest request , HttpServletResponse response , String page , String rows, String json)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("utf-8");
			out = response.getWriter();
			Integer pageNumInt = Integer.parseInt(page)-1;
			Integer pageSizeInt = Integer.parseInt(rows);
			JSONObject obj = JSONObject.fromObject(json);
			String paramName = StringUtil.getJSONObjectKeyVal(obj, "paramName");
			String paramId = StringUtil.getJSONObjectKeyVal(obj, "paramId");
			System.out.println(paramName+"----");
			System.out.println(paramId+"========");
			String retVal = exampleService.queryExample(pageNumInt*pageSizeInt, pageSizeInt,paramName,paramId);
			out.write(retVal);
		}
		catch(Exception err)
		{
			err.printStackTrace();
		}
		finally
		{
			if(out != null)
			{
				out.close();
			}
		}
	}
	
	@RequestMapping(value = "/updateExample.do")
	public void updateExample(HttpServletRequest request , HttpServletResponse response , String exampleId , String exampleName , String exampleValue)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("utf-8");
			out = response.getWriter();
			String retVal = exampleService.updateExample(exampleId, exampleName, exampleValue);
			out.write(retVal);
		}
		catch(Exception err)
		{
			out.write(err.getMessage());
			err.printStackTrace();
		}
		finally
		{
			if(out != null)
			{
				out.close();
			}
		}
	}
	
	@RequestMapping(value = "/delExample.do")
	public void delExample(HttpServletRequest request , HttpServletResponse response , String exampleId)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("utf-8");
			out = response.getWriter();
			String retVal = exampleService.delExample(exampleId);
			out.write(retVal);
		}
		catch(Exception err)
		{
			out.write(err.getMessage());
			err.printStackTrace();
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