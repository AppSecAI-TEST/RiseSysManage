package com.rise.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.rise.service.LicenseService;

@Controller
@RequestMapping("/licenseManage")
public class LicenseController {

	private static Log log = LogFactory.getLog(LicenseController.class);

	@Autowired
	private LicenseService licenseService;
	
	//��ѯ��ʦ��δ��֤���б�
	@RequestMapping(value = "/qryTeacherHasntLicense.do")
	public void qryTeacherHasntLicense(String teacherId, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = licenseService.qryTeacherHasntLicense(teacherId);
			log.error(retVal);
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
	
	//������֤
	@RequestMapping(value="/addLicense.do")
	public void addLicense(HttpServletResponse response,String json)
	{
		log.error(json);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = licenseService.addLicense(json);
			log.error(retVal);
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
	
	//�����ʦ��֤��Ϣ
	@RequestMapping(value="/viewLicenseInfo.do")
	public ModelAndView viewLicenseInfo(String teacherId,String funcNodeId)
	{
		log.error(teacherId);
		log.error(funcNodeId);
		ModelAndView view = new ModelAndView("licenseManage/viewLicenseInfo");
		try {
			String ret = licenseService.viewLicenseInfo(teacherId);
			view.addObject("obj",JSONObject.fromObject(ret));
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return view;
	}
	
	//��ʦ��֤�б�
	@RequestMapping(value = "/qryDataListByPage.do")
	public void qryDataListByPage(String page, String rows, String param, String funcNodeId, HttpServletResponse response)
	{
		log.error(page);
		log.error(rows);
		log.error(param);
		log.error(funcNodeId);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = licenseService.qryDataListByPage(page, rows, param, funcNodeId);
			log.error(retVal);
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
