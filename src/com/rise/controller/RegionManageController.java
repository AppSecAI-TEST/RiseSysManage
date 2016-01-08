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

import com.rise.service.QryPubDataService;
import com.rise.service.RegionManageService;

@Controller
@RequestMapping("/regionManage")
public class RegionManageController {

	private static Log log = LogFactory.getLog(RegionManageController.class);
	
	@Autowired
	private RegionManageService regionManageService;
	
	@Autowired
	private QryPubDataService qryPubDataService;
	
	//跳转到新增、修改片区页面
	@RequestMapping(value="/jumpToRegion.do")
	public ModelAndView viewLicenseInfo(String json,String type)
	{
		log.error(json);
		log.error(type);
		ModelAndView view = null;
		try {
			if("ADD".equals(type)){
				view = new ModelAndView("manage/addRegion");
			}else if("UPDATE".equals(type)){
				view = new ModelAndView("manage/updateRegion");
				view.addObject("region",JSONObject.fromObject(json));
			}
			String retVal = qryPubDataService.qrySchoolList("");
			view.addObject("schoolList", JSONArray.fromObject(retVal));
			
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return view;
	}
	
	//新增片区
	@RequestMapping(value="/addRegion.do")
	public void addRegion(HttpServletResponse response,String json)
	{
		log.error(json);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = regionManageService.addRegion(json);
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
	
	//修改片区
	@RequestMapping(value="/updateRegion.do")
	public void updateRegion(HttpServletResponse response,String json)
	{
		log.error(json);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = regionManageService.updateRegion(json);
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
	
	//删除片区
	@RequestMapping(value="/deleteRegion.do")
	public void deleteRegion(HttpServletResponse response,String regionId)
	{
		log.error(regionId);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = regionManageService.deleteRegion(regionId);
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
