package com.rise.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.rise.service.PubService;

@Controller
@RequestMapping("/pub")
public class PubController 
{
	@Autowired
	private PubService pubService;
	
	private static String separator = System.getProperty("file.separator");

	@RequestMapping("/pageCategory.do")
	public void pageCategory(HttpServletResponse response , HttpServletRequest request , String staffId , String funcNodeId , String fieldId , String resourceId)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			Map paramMap = request.getParameterMap();
			HttpSession session = request.getSession();
			String retVal = pubService.pageCategory(staffId , paramMap , fieldId , session);
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
	
	@RequestMapping("/pageComboxList.do")
	public void pageComboxList(HttpServletResponse response , String funcNodeId , String fieldId)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = pubService.pageComboxList(funcNodeId , fieldId);
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
	
	@RequestMapping("/paramComboxList.do")
	public void paramComboxList(HttpServletResponse response , HttpServletRequest request)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			Map<String,String[]> paramMap = request.getParameterMap();
			String retVal = pubService.paramComboxList(paramMap);
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
	
	@RequestMapping("/downloadFile.do")
	public HttpServletResponse download(String fileId, HttpServletResponse response) 
	{
		   try 
		   {
			    String path =pubService.getFillePath(fileId);
			    String[] pathArr =path.split("/");
			    String realPath =pubService.getFolder()+pathArr[pathArr.length-3]+separator+pathArr[pathArr.length-2]+separator+pathArr[pathArr.length-1];
			    File file = new File(realPath);
	            InputStream fis = new BufferedInputStream(new FileInputStream(file));
	            byte[] buffer = new byte[fis.available()];
	            fis.read(buffer);
	            fis.close();
	            // Çå¿Õresponse
	            response.reset();
	            // ÉèÖÃresponseµÄHeader
	            response.addHeader("Content-Disposition", "attachment;filename=" + java.net.URLEncoder.encode(file.getName(), "UTF-8"));
	            response.addHeader("Content-Length", "" + file.length());
	            OutputStream toClient = new BufferedOutputStream(response.getOutputStream());
	            response.setContentType("application/octet-stream");
	            toClient.write(buffer);
	            toClient.flush();
	            toClient.close();
	        } 
		   	catch (Exception ex) 
		   	{
	            ex.printStackTrace();
	        }
	        return response;
	    }
	
	
	@RequestMapping("/deleteFile.do")
	public void deleteFile(String fileId, HttpServletResponse response)
	{
		PrintWriter out = null;
		String retVal = "false";
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String path =pubService.getFillePath(fileId);
			String[] pathArr =path.split("/");
			String realPath =pubService.getFolder()+pathArr[pathArr.length-3]+separator+pathArr[pathArr.length-2]+separator+pathArr[pathArr.length-1];
			File file = new File(realPath);
			if(file.exists()&&file.isFile())
			{
				if(file.delete())
				{
					retVal =pubService.deleteFile(fileId);
				}	
			}	
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			out.write(retVal);
			if(out != null)
			{
				out.close();
			}
		}
	}
	
}
