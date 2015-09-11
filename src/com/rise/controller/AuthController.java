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

import com.rise.model.StaffT;
import com.rise.pub.util.ObjectCensor;
import com.rise.pub.util.SecurityCodeCreater;
import com.rise.service.AuthService;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

/**
 * @author LEO
 * ��¼��Ϣ��֤���ȡ
 */
@Controller
@RequestMapping("/auth.do")
public class AuthController 
{

	@Autowired
	private AuthService authService;
	
	//��ȡͼƬ��֤��
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
	
	//��֤��¼��Ϣ
	@RequestMapping(params = "method=authStaff")
	public void authStaff(HttpServletResponse response , HttpServletRequest request , String username , String password , String code)
	{
		PrintWriter out = null;
		String retVal = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			HttpSession session = request.getSession();
			String srccode = (String)session.getAttribute("code");
			if(ObjectCensor.isStrRegular(srccode))
			{
				if(srccode.equals(code))
				{
					retVal = authService.userCenter(session, username, password);
				}
				else
				{
					retVal = "��֤�����,���ʵ�����³���";
				}
			}
			else
			{
				retVal = "��֤�����,���ʵ�����³���";
			}
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

	//��ȡ�˵���Ϣ
	@RequestMapping(params = "method=menuLeft")
	public void menuLeft(String menuId, HttpServletResponse response, HttpServletRequest request)
	{
		PrintWriter out = null;
		try
		{
			HttpSession session = request.getSession();
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			StaffT staffT = (StaffT)session.getAttribute("StaffT");
			String retVal = authService.menuLeft(menuId , staffT);
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
	
	//�û�ע������
	@RequestMapping(params = "method=logout")
	public ModelAndView logout(String param, HttpServletResponse response , HttpServletRequest request)
	{
		ModelAndView model = new ModelAndView("login");
		try
		{
			HttpSession session = request.getSession();
			session.removeAttribute("StaffT");
			session.removeAttribute("funcNodeInfo");
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		return model;
	}
	
}
