package com.rise.controller;

import java.io.OutputStream;
import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.rise.pub.util.SecurityCodeCreater;
import com.rise.service.AuthService;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

@Controller
@RequestMapping("/auth.do")
public class AuthController 
{

	@Autowired
	private AuthService authService;
	
	@RequestMapping(params = "method=getSecurityImage")
	public void getSecurityImage(HttpServletResponse response , HttpServletRequest request)
	{
		try
		{
			HttpSession session = request.getSession();
			OutputStream os = response.getOutputStream();
			JPEGImageEncoder encoder = JPEGCodec.createJPEGEncoder(os);
			String code = authService.getSecurityCode();
			session.setAttribute("code", code);
			encoder.encode(SecurityCodeCreater.getImage(code)); 
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
	}
	
	@RequestMapping(params = "method=userCenter")
	public ModelAndView userCenter(HttpServletResponse response , HttpServletRequest request , String username , String password , String code)
	{
		ModelAndView model = new ModelAndView("admin");
		try
		{
			HttpSession session = request.getSession();
			String remoteIp = request.getRemoteAddr();
			authService.userCenter(session, model, username, password, code, remoteIp);
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return model;
	}

	@RequestMapping(params = "method=menuLeft")
	public void menuLeft(String menuId, HttpServletResponse response)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = authService.menuLeft(menuId);
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
	
	@RequestMapping(params = "method=logout")
	public ModelAndView logout(String param, HttpServletResponse response , HttpServletRequest request)
	{
		ModelAndView model = new ModelAndView("login");
		try
		{
			HttpSession session = request.getSession();
			session.removeAttribute("UserInfo");
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return model;
	}
	
}
