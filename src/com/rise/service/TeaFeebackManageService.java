package com.rise.service;

import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.poifs.filesystem.POIFSFileSystem;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.rise.pub.exception.ServiceException;
import com.rise.pub.invoke.ServiceEngine;
import com.rise.pub.util.ObjectCensor;

@Service
public class TeaFeebackManageService {

	//根据班级实例Id查所有班级学员
	public String qryClassStuByInstId(String classInstId,String qualityId)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS4201\",securityCode:\"0000000000\",params:{classInstId:'"+classInstId+"',qualityId:'"+qualityId+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//新增教质反馈
	public String addTeachingFeedback(String feedbackJson,String feedbackDetailJson)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS4202\",securityCode:\"0000000000\",params:{feedbackJson:'"+feedbackJson+"',feedbackDetailJson:'"+feedbackDetailJson+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//浏览教质反馈信息
	public String viewTeachingFeedback(String feedbackId)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS4203\",securityCode:\"0000000000\",params:{feedbackId:\""+feedbackId+"\"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//修改教质反馈信息
	public String updateTeachingFeedback(String json)throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS4204\",securityCode:\"0000000000\",params:{json:'"+json+"'},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(param);
	}

	//教质回访名单报表查询
	public String qryDataListByPage(String page, String rows, String param, String funcNodeId)throws Exception{
		JSONObject obj = new JSONObject();
		if(ObjectCensor.isStrRegular(param))
		{
			obj = JSONObject.fromObject(param);
		}
		if(ObjectCensor.isStrRegular(page,rows))
		{
			Integer pageNum = Integer.parseInt(page) - 1;
			Integer pageSize = Integer.parseInt(rows);
			pageNum = pageNum * pageSize;
			obj.element("start", pageNum);
			obj.element("rownum", pageSize);
		}
		if(ObjectCensor.isStrRegular(funcNodeId))
		{
			obj.element("funcNodeId", funcNodeId);
		}
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS4205\",securityCode:\"0000000000\",params:{param:"+obj+"},rtnDataFormatType:\"user-defined\"}";
		return ServiceEngine.invokeHttp(params);
	}
	
	/**
	 * @param type : 查询依据
	 * @param staffId : 用户Id
	 * @param mulRequest : MultipartHttpServletRequest对象
	 * @throws Exception
	 * 文件上传响应模块
	 */
	public String uploadFile(String qualityId,String classInstId,String staffId ,MultipartHttpServletRequest mulRequest) throws Exception
	{
		Map<String,MultipartFile> map = mulRequest.getFileMap();
		JSONArray jsonTotal = new JSONArray();
		JSONObject obj = new JSONObject();
		obj.put("staffId", staffId);
		obj.put("qualityId", qualityId);
		for(Map.Entry<String, MultipartFile>  entity : map.entrySet())
		{
			MultipartFile file = entity.getValue();
			String fileName = file.getOriginalFilename();
			String extFileName = fileName.substring(fileName.lastIndexOf(".")+1);
			
			try
			{
				
				InputStream inputFile = file.getInputStream();
				if("xls".equals(extFileName))
				{
					POIFSFileSystem fs = new POIFSFileSystem(inputFile);
					HSSFWorkbook wb = new HSSFWorkbook(fs);
					HSSFSheet sheet = wb.getSheetAt(0);
						
					for(int i = 1 ,n = sheet.getLastRowNum();i<=n;i++)
					{
						HSSFRow row = sheet.getRow(i);
						JSONObject item = new JSONObject();
						if(row != null)
						{
							
							for(int j = 0,m = row.getLastCellNum();j<m;j++)
							{
								HSSFCell cell = row.getCell((short)j);
								if(cell != null)
								{
									String val="";
									switch(cell.getCellType())
									{
										case HSSFCell.CELL_TYPE_NUMERIC:
											val = String.valueOf((long)cell.getNumericCellValue());
											break;
										case HSSFCell.CELL_TYPE_STRING:
											val = cell.getStringCellValue();
											break;
									}
									if(j==0)
									{
										item.put("studentName",val);
									} else if(j==1)
									{
										item.put("phone",val);
									}else if(j==2)
									{
										item.put("teachingNum",val);
									}else if(j==3)
									{
										item.put("strativeCsi",val);
									}else if(j==4 && !ObjectCensor.checkObjectIsNull(val))
									{
										item.put("startIsAttend","Y");
										item.put("startCsi",val);
									}else if(j==5 && !ObjectCensor.checkObjectIsNull(val))
									{
										item.put("meetingIsAttend","Y");
										item.put("meetingCsi",val);
									}else if(j==6 && !ObjectCensor.checkObjectIsNull(val))
									{
										item.put("openIsAttend","Y");
										item.put("openCsi",val);
									}else if(j==7 && !ObjectCensor.checkObjectIsNull(val))
									{
										item.put("gradIsAttend","Y");
										item.put("gradCsi",val);
									}
								}
								else
								{
									break;
								}
							}
						}
						else
						{
							break;
						}
						jsonTotal.add(item);
					}
					 jsonTotal.add(obj);
				}
				else
				{
					XSSFWorkbook wb = new XSSFWorkbook(inputFile);
					XSSFSheet sheet = wb.getSheetAt(0);
				 
					for(int i = 1 ,n = sheet.getLastRowNum();i<=n;i++)
					{
						JSONObject item = new JSONObject();
						XSSFRow row = sheet.getRow(i);
						for(int j = 0,m = row.getLastCellNum();j<m;j++)
						{
							XSSFCell cell = row.getCell((short)j);
							String val="";
							switch(cell.getCellType())
							{
								case XSSFCell.CELL_TYPE_NUMERIC:
									val = String.valueOf((long)cell.getNumericCellValue());
									break;
								case XSSFCell.CELL_TYPE_STRING:
									val = cell.getStringCellValue();
									break;
							}
							if(j==0)
							{
								item.put("studentName",val);
							} else if(j==1)
							{
								item.put("phone",val);
							}else if(j==2)
							{
								item.put("teachingNum",val);
							}else if(j==3)
							{
								item.put("strativeCsi",val);
							}else if(j==4 && !ObjectCensor.checkObjectIsNull(val))
							{
								item.put("startIsAttend","Y");
								item.put("startCsi",val);
							}else if(j==5 && !ObjectCensor.checkObjectIsNull(val))
							{
								item.put("meetingIsAttend","Y");
								item.put("meetingCsi",val);
							}else if(j==6 && !ObjectCensor.checkObjectIsNull(val))
							{
								item.put("openIsAttend","Y");
								item.put("openCsi",val);
							}else if(j==7 && !ObjectCensor.checkObjectIsNull(val))
							{
								item.put("gradIsAttend","Y");
								item.put("gradCsi",val);
							}
						}
						jsonTotal.add(item);
					}
				}
			} 
			catch (IOException e)
			{
				throw new ServiceException(e);
			}
		}
	 
		String ss=jsonTotal.toString().replace("\"", "'");
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS4206\",securityCode:\"0000000000\",params:{staffId:\""+staffId+"\",qualityId:\""+qualityId+"\",classInstId:\""+classInstId+"\",data:\""+ss+"\"},rtnDataFormatType:\"json\"}";
		String rst = ServiceEngine.invokeHttp(param);
		return rst;
	}
	
	
	
}
