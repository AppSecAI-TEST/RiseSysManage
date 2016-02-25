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
	
	private static String separator = System.getProperty("file.separator");
	
	public void doGet(HttpServletRequest request, HttpServletResponse response)
	{
		doPost(request, response);
	}
	
	public void doPost(HttpServletRequest request, HttpServletResponse response)
	{
		try 
		{
			JSONObject rstObj = new JSONObject();
			String path = "";
			String filePath = "";
			String folderName = "";
			String schoolCode = "";
			boolean flag = false;
			String type = request.getParameter("type");
			if(ObjectCensor.isStrRegular(type))
			{
				String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1015\",securityCode:\"0000000000\",params:{paramType:\"UPLOAD_PATH\",paramValue:\""+type+"\"},rtnDataFormatType:\"user-defined\"}";
				String rstMsg = ServiceEngine.invokeHttp(param);
				JSONArray array = JSONArray.fromObject(rstMsg);
				if(ObjectCensor.checkListIsNull(array))
				{
					JSONObject obj = array.getJSONObject(0);
					path = StringUtil.getJSONObjectKeyVal(obj, "param2");
					filePath = StringUtil.getJSONObjectKeyVal(obj, "param1");
					folderName = StringUtil.getJSONObjectKeyVal(obj, "param3");
				}
			}
			String schoolId = request.getParameter("schoolId");
			if(ObjectCensor.isStrRegular(schoolId))
			{
				String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1011\",securityCode:\"0000000000\",params:{schoolId:\""+schoolId+"\"},rtnDataFormatType:\"user-defined\"}";
				String rstMsg = ServiceEngine.invokeHttp(param);
				JSONArray array = JSONArray.fromObject(rstMsg);
				if(ObjectCensor.checkListIsNull(array))
				{
					JSONObject obj = array.getJSONObject(0);
					schoolCode = StringUtil.getJSONObjectKeyVal(obj, "shcoolCode");
				}
			}
			else
			{
				schoolCode ="zb";
			}	
			String handlerId = request.getParameter("handlerId");
			if(ObjectCensor.isStrRegular(path, schoolCode, folderName, filePath))
			{
				File file = new File(path + separator + schoolCode);
				if(!file.exists() && !file.isDirectory())
				{
					file.mkdir();
				}
				file = new File(path + separator + schoolCode + separator + folderName);
				if(!file.exists() && !file.isDirectory())
				{
					file.mkdir();
				}
				path += separator + schoolCode + separator + folderName;
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
					if (!item.isFormField()) 
					{
						String fileName = item.getName();
						File tempFile = new File(path + separator + fileName);
						if(tempFile.exists())
						{
							int index = fileName.lastIndexOf(".");
							for(int i = 1; i < 100; i++)
							{
								String newFileName = fileName.substring(0, index) + "��" + i + "��" + fileName.substring(index);
								tempFile = new File(path + separator + newFileName);
								if(!tempFile.exists())
								{
									filePath += schoolCode + separator + folderName + separator + newFileName;
									break;
								}
							}
						}
						else
						{
							filePath += schoolCode + separator + folderName + separator + fileName;
						}
						item.write(tempFile);
						flag = true;
					}
				}
				if(flag)
				{
					log.error(filePath);
					JSONObject obj = new JSONObject();
					if("zb".equals(schoolCode))
					{
						obj.element("fileType", "FILE");
					}
					else
					{
						obj.element("fileType", "IMG");
					}	
					obj.element("filePath", filePath);
					obj.element("ownerId", handlerId);
					obj.element("handlerId", handlerId);
					String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS0101\",securityCode:\"0000000000\",params:{param:"+obj.toString()+"},rtnDataFormatType:\"user-defined\"}";
					String rstMsg = ServiceEngine.invokeHttp(param);
					JSONObject retObj = JSONObject.fromObject(rstMsg);
					flag = retObj.getBoolean("flag");
					if(flag)
					{
						rstObj.element("fileId", StringUtil.getJSONObjectKeyVal(retObj, "fileId"));
					}
				}
			}
			else
			{
				rstObj.element("msg", "�����øù��ܵ���ϴ�·����");
			}
			rstObj.element("flag", flag);
			response.setCharacterEncoding("UTF-8");
			PrintWriter out = response.getWriter();
			out.print(rstObj);
			out.close();
		} 
		catch (Exception e) 
		{
			e.printStackTrace();
		}
	}
}
