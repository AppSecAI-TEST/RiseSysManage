package com.rise.filter;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import com.rise.model.StaffT;

public class SessionTimeoutInterceptor implements HandlerInterceptor 
{

	private List<String> allowUrls;
	
	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception exception) throws Exception {
		// TODO Auto-generated method stub
		
	}

	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView model) throws Exception {
		// TODO Auto-generated method stub
		
	}

	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		// TODO Auto-generated method stub
		 String requestUrl = request.getRequestURI();    
         if(requestUrl.indexOf(".do")!=-1)
         {  
             for(String url : allowUrls) 
             {    
                 if(requestUrl.endsWith(url)) 
                 {    
                     return true;
                 }    
             }   
             StaffT staffT = (StaffT)request.getSession().getAttribute("StaffT");
             if(staffT == null) 
             {    
                 response.sendRedirect("/sys/common/userSessionout.jsp");
             }    
             return true;  
         }else{  
             return true;  
         } 
	}

	public List<String> getAllowUrls() {
		return allowUrls;
	}

	public void setAllowUrls(List<String> allowUrls) {
		this.allowUrls = allowUrls;
	}
	
}
