package com.rise.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.rise.pub.util.ObjectCensor;

public class LoginFilter implements Filter
{

	public void destroy() 
	{
		
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException 
	{
		HttpServletRequest httpServletRequest = (HttpServletRequest) request;
		HttpSession session = httpServletRequest.getSession();
		HttpServletResponse httpServletResponse = (HttpServletResponse) response;
		String requestUrl = httpServletRequest.getRequestURI();
		String url = requestUrl.substring(requestUrl.lastIndexOf("/") + 1);
		String flag = "1";
		if("login.jsp".equals(url) || "index.jsp".equals(url))
		{
			flag = "0";
		}
		else
		{
			String staffId = (String) session.getAttribute("staffId");
			if("viewMenu.jsp".equals(url))
			{
				String channelId = request.getParameter("channelId");
				if(ObjectCensor.isStrRegular(channelId))
				{
					flag = "2";
					session.setAttribute("staffId", "-1");
				}
				else
				{
					if(ObjectCensor.isStrRegular(staffId))
					{
						flag = "0";
					}
				}
			}
			else
			{
				if(ObjectCensor.isStrRegular(staffId))
				{
					flag = "0";
				}
			}
		}
		if("0".equals(flag))
		{
			chain.doFilter(request, response);
		}
		else if("1".equals(flag))
		{
			httpServletResponse.sendRedirect("/sys/index.jsp");
		}
		else if("2".equals(flag))
		{
			httpServletResponse.sendRedirect("/sys/view/viewMenu.jsp");
		}
	}

	public void init(FilterConfig Config) throws ServletException 
	{
		
	}
}
