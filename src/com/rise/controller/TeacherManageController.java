package com.rise.controller;

import java.io.PrintWriter;
import java.text.NumberFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.rise.pub.util.StringUtil;
import com.rise.service.TeacherManageService;

@Controller
@RequestMapping("/teacherManage")
public class TeacherManageController {
	
	private static Log log = LogFactory.getLog(TeacherManageController.class);
	
	@Autowired
	private TeacherManageService teacherManageService;
	
	//���ݲ�ͬ������ת����ʦ�������ҳ��
	@RequestMapping(value="/viewTeacherInfo.do")
	public ModelAndView viewTeacherInfo(String json,String funcNodeId,String type)
	{
		log.error(json);
		log.error(funcNodeId);
		ModelAndView view = null;
		try {
			JSONObject obj = JSONObject.fromObject(json);
			String teacherId = StringUtil.getJSONObjectKeyVal(obj, "teacherId");
			if("update".equals(type)){
				view = new ModelAndView("teacherManage/updateFile");//����ά��
			}else if("rl".equals(type)){
				view = new ModelAndView("teacherManage/preResign");//Ԥ��ְ
			}else if("rlp".equals(type)){
				view = new ModelAndView("teacherManage/preResignRegain");//Ԥ��ְ��ְ
				String ret = teacherManageService.getTeacherInfo(teacherId,type);
				view.addObject("retObj",JSONObject.fromObject(ret));
			}else if("l".equals(type)){
				view = new ModelAndView("teacherManage/resign");//��ְ
				String ret = teacherManageService.getTeacherInfo(teacherId,type);
				view.addObject("retObj",JSONObject.fromObject(ret));
			}else if("lp".equals(type)){
				view = new ModelAndView("teacherManage/resignRegain");//��ְ��ְ
				String ret = teacherManageService.getTeacherInfo(teacherId,type);
				view.addObject("retObj",JSONObject.fromObject(ret));
			}else if("org".equals(type)){
				view = new ModelAndView("teacherManage/updateOrg");//������֯
			}else if("view".equals(type)){
				view = new ModelAndView("teacherManage/viewTeacherInfo");//���
				String ret = teacherManageService.getTeacherInfo(teacherId,type);
				view.addObject("retObj",JSONObject.fromObject(ret));
			}
			//�����֤��
			String licenses = StringUtil.getJSONObjectKeyVal(obj, "licenses");
			String stageIds = StringUtil.getJSONObjectKeyVal(obj, "stageIds"); 
			if("".equals(licenses)){
				view.addObject("licenseNum", "0");
			}else{
				view.addObject("licenseNum",licenses.split("��").length);
			}
			if("".equals(stageIds)){
				view.addObject("rate","0%");
			}else{
				if("".equals(licenses)){
					view.addObject("rate","0%");
				}else{
					String lic[] = licenses.split("��");
					String stage[] = stageIds.split("��");
					int count = 0;
					for(int i = 0;i < stage.length;i++){
						for(int j = 0;j < lic.length;j++){
							if(stage[i].equals(lic[j])){
								count++;
								break;
							}
						}
					}
					NumberFormat numberFormat = NumberFormat.getInstance();  //�����֤��
					numberFormat.setMaximumFractionDigits(2);  
					String result = numberFormat.format((float) count / (float) stage.length * 100);  
					view.addObject("rate", result+"%");
				}
			}
			view.addObject("obj",obj);
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return view;
	}
	
	//���Ľ�ʦ��Ϣ�����ݲ�ͬ��������
	@RequestMapping(value="/updateTeacherInfo.do")
	public void updateTeacherInfo(HttpServletResponse response,String json,String type)
	{
		log.error(json);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = teacherManageService.updateTeacherInfo(json,type);
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
	
	/**
	 * ��ȡ��ʦ��Ϣ
	 * @param request
	 * @param response
	 * @param teacherId
	 */
	@RequestMapping(value="/getTeacherInfo.do")
	public void getTeacherInfo(HttpServletRequest request,HttpServletResponse response,String teacherId)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("utf-8");
			out = response.getWriter();
			String retVal = teacherManageService.getTeacherInfo(teacherId);
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
	
	@RequestMapping(value = "/qryTeacherArchivesList.do")
	public void qryTeacherArchives(String param, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			log.error(param);
			response.setCharacterEncoding("utf-8");
			out = response.getWriter();
			String retVal = teacherManageService.qryTeacherArchivesList(param);
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
