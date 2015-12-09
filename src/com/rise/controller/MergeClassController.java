package com.rise.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rise.service.ActionService;
import com.rise.service.MergeClassService;

@Controller
@RequestMapping("/mergeClass")
public class MergeClassController 
{
	private static Log log = LogFactory.getLog(MergeClassController.class);
	
	@Autowired
	private MergeClassService msc;
	
	@RequestMapping("/qryClassInstList.do")
	public void qryClassInstList(String classInstIds, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = msc.qryClassInstList(classInstIds);
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
