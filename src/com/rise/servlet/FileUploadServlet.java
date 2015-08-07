package com.rise.servlet;

import java.io.File;
import java.io.PrintWriter;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.rise.pub.invoke.ServiceEngine;
import com.rise.pub.util.ObjectCensor;
import com.rise.pub.util.StringUtil;

public class FileUploadServlet extends HttpServlet
{
	private static final long serialVersionUID = 1L;
	
	private Log log = LogFactory.getLog(FileUploadServlet.class);
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
	{
		doPost(request, response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
	{
		try 
		{
			String retVal = "";
			String path = "";
			JSONObject object = new JSONObject();
			//�����ļ�������,����������FileItem����
			DiskFileItemFactory factory = new DiskFileItemFactory();
			//����request�Ľ�����,���Ὣ���ݷ�װ��FileItem������
			ServletFileUpload sfu = new ServletFileUpload(factory);
			//����������request�е����ݲ�����list����
			List items = sfu.parseRequest(request);
			//����list����,ȡ��ÿһ���������FileItem����,���ֱ��ȡ����
			Iterator itr = items.iterator();
			while (itr.hasNext())
			{
				FileItem item = (FileItem) itr.next();
				if (item.isFormField()) 
				{
					object.element(item.getFieldName(), item.getString("UTF-8"));
				}
				else
				{
					String type = StringUtil.getJSONObjectKeyVal(object, "type");
					if(ObjectCensor.isStrRegular(type))
					{
						if(!ObjectCensor.isStrRegular(path))
						{
							String param = "{appId:\"0000000000\",channelId:\"Q\",serviceType:\"BUS3001\",capInstId:\"BUS3001\",transactionId:\"BUS3001\",signCode:\"PC\",encryptCode:\"0000000000\",params:{paraType:\"UPLOAD_PATH\",paraFlag:\""+type+"\"},rtnDataFormatType:\"json\"}";
							String rstMsg = ServiceEngine.invokeService(param);
							JSONObject obj = JSONObject.fromObject(rstMsg);
							String executeType = StringUtil.getJSONObjectKeyVal(obj, "executeType");
							if("success".equals(executeType))
							{
								String returnMsg = StringUtil.getJSONObjectKeyVal(obj, "returnMsg");
								JSONArray array = JSONArray.fromObject(returnMsg);
								JSONObject rstObj = array.getJSONObject(0);
								path = StringUtil.getJSONObjectKeyVal(rstObj, "para_refer");
							}
							else
							{
								retVal = StringUtil.getJSONObjectKeyVal(obj, "exceptionMsg");
							}
						}
						if(ObjectCensor.isStrRegular(path))
						{
							String fileName = item.getName();
							File tempFile = new File(path + "/" + fileName);
							if(tempFile.exists())
							{
								int index = fileName.lastIndexOf(".");
								for(int i = 1; i < 100; i++)
								{
									String newFileName = fileName.substring(0, index) + "��" + i + "��" + fileName.substring(index);
									tempFile = new File(path + "/" + newFileName);
									if(!tempFile.exists())
									{
										retVal = newFileName;
										break;
									}
								}
							}
							else
							{
								retVal = fileName;
							}
							item.write(tempFile);
						}
					}
				}
			}
			log.error(object);
			log.error(retVal);
			response.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			out.println(retVal);
			out.close();
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
	}
}
