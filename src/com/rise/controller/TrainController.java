package com.rise.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.rise.service.TrainService;

@Controller
@RequestMapping("/trainManage")
public class TrainController {

	private static Log log = LogFactory.getLog(TrainController.class);

	@Autowired
	private TrainService trainService;
	
	//新增培训
	@RequestMapping(value="/addTrain.do")
	public void addTrain(HttpServletResponse response,String json)
	{
		log.error(json);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = trainService.addTrain(json);
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
	
	//教师培训信息，根据不同类型跳转不同页面
	@RequestMapping(value="/viewTrainInfo.do")
	public ModelAndView viewTrainInfo(String trainId,String name,String byName,String stateVal,String type)
	{
		log.error(trainId);
		log.error(type);
		ModelAndView view = null;
		try {
			if("update".equals(type)){
				view = new ModelAndView("trainManage/updateTrainInfo");
			}else if("view".equals(type)){
				view = new ModelAndView("trainManage/viewTrainInfo");
			}
			String ret = trainService.viewTrainInfo(trainId);
			view.addObject("name", name);
			view.addObject("byName", byName);
			view.addObject("stateVal", stateVal);
			view.addObject("obj",JSONObject.fromObject(ret));
		}catch(Exception e)
		{
			e.printStackTrace();
		}
		return view;
	}
	
	//修改教师培训
	@RequestMapping(value="/updateTrain.do")
	public void updateTrain(HttpServletResponse response,String json)
	{
		log.error(json);
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = trainService.updateTrain(json);
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
