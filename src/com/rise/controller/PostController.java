package com.rise.controller;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.rise.model.PostT;
import com.rise.service.PostService;

@Controller
@RequestMapping("/post")
public class PostController 
{
	@Autowired
	private PostService postService;
	
	@RequestMapping("/queryPostList.do")
	public void queryPostList(HttpServletResponse response, String page, String rows, String postName)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			Integer pageNumInt = Integer.parseInt(page)-1;
			Integer pageSizeInt = Integer.parseInt(rows);
			String retVal = postService.queryPostList(pageNumInt*pageSizeInt, pageSizeInt, postName);
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
	
	@RequestMapping("/getPostInfo.do")
	public ModelAndView getPostInfo(String postId , String funcNodeId)
	{
		ModelAndView model = new ModelAndView("manage/postDetail");
		try {
			postService.getPostInfo(model, postId, funcNodeId);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return model;
	}
	
	
	@RequestMapping("/addPost.do")
	public void addPost(HttpServletResponse response , PostT postT)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = postService.addPost(postT);
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
	
	@RequestMapping("/updatePost.do")
	public void updatePost(HttpServletResponse response , PostT postT)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = postService.updatePost(postT);
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
	
	@RequestMapping("/deletePost.do")
	public void deletePost(HttpServletResponse response , String postId)
	{
		PrintWriter out = null;
		try
		{
			response.setCharacterEncoding("UTF-8");
			out = response.getWriter();
			String retVal = postService.deletePost(postId);
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
