package com.rise.pub.invoke;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

public class HttpUtil
{
	public static Log log = LogFactory.getLog(HttpUtil.class);
	
	public static String http(String url, Map<String, String> params) throws Exception
	{
		URL u = null;
		HttpURLConnection con = null;
		// 构建请求参数
		StringBuffer sb = new StringBuffer();
		if (params != null) 
		{
			for (Entry<String, String> e : params.entrySet()) 
			{
				sb.append(e.getKey());
				sb.append("=");
				sb.append(URLEncoder.encode(e.getValue(), "utf-8"));
				sb.append("&");
			}
			sb.replace(0, sb.length(), sb.substring(0, sb.length() - 1));
		}
		log.warn("send_url:" + url + "?" + sb.toString());
		log.warn("send_data:" + sb.toString());

		try 
		{
			u = new URL(url);
			con = (HttpURLConnection) u.openConnection();
			con.setDoInput(true);        //设置输入流采用字节流
			con.setDoOutput(true);        //设置输出流采用字节流
			con.setRequestMethod("POST");
			con.setUseCaches(false);    //设置缓存
			con.setRequestProperty("Content-Type", "application/x-www-form-urlencoded");
			OutputStreamWriter osw = new OutputStreamWriter(con.getOutputStream(), "UTF-8");
			osw.write(sb.toString());
			osw.flush();
			osw.close();
		}
		catch (Exception e) 
		{
			e.printStackTrace();
		} 
		finally 
		{
			if (con != null)
			{
				con.disconnect();
			}
		}

		// 读取返回内容
		StringBuffer buffer = new StringBuffer();
		BufferedReader br = null;
		try
		{
			br = new BufferedReader(new InputStreamReader(con.getInputStream()));
			String temp;
			while ((temp = br.readLine()) != null) 
			{
				buffer.append(temp);
				buffer.append("\n");
			}
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
		finally
		{
			if(br != null)
			{
				br.close();
			}
		}
		return URLDecoder.decode(buffer.toString(), "utf-8");
	}

}
