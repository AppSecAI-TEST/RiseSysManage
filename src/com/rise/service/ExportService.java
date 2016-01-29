package com.rise.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.jxls.transformer.Sheet;
import net.sf.jxls.transformer.XLSTransformer;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.http.HttpResponse;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.Region;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Service;
import org.springframework.web.context.support.ServletContextResource;



import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.rise.model.FuncNodeTree;
import com.rise.model.StaffT;
import com.rise.pub.base.JacksonJsonMapper;
import com.rise.pub.invoke.ServiceEngine;
import com.rise.pub.util.ObjectCensor;
import com.rise.pub.util.StringUtil;

@SuppressWarnings("deprecation")
@Service
public class ExportService 
{	
	public void normalExport(String fileName,String param,OutputStream out) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1019\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		String result= ServiceEngine.invokeHttp(params);
		JSONObject obj =JSONObject.fromObject(result);
		if(ObjectCensor.isStrRegular(StringUtil.getJSONObjectKeyVal(obj, "rows")))
		{
			List list = JacksonJsonMapper.getInstance().readValue(obj.getString("rows"), List.class);
			String filePath =this.getFullFilePath(fileName);
			HttpClient client = new HttpClient();   
			GetMethod httpGet = new GetMethod(filePath);  
			client.executeMethod(httpGet); 
			InputStream inputStream =httpGet.getResponseBodyAsStream();
			Map<String, List<Map>> beanParams = new HashMap<String, List<Map>>();
			beanParams.put("reportList", list);  
	        XLSTransformer former = new XLSTransformer(); 
	        HSSFWorkbook workBook = (HSSFWorkbook)former.transformXLS(inputStream, beanParams);
	        HSSFSheet sheet= workBook.getSheetAt(0);
	        int rows = sheet.getPhysicalNumberOfRows();
	        HSSFCellStyle cellStyle=workBook.createCellStyle();  
	        cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 左右居中   
	        cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 上下居中 
	        cellStyle.setWrapText(true); 
	        for (int i = 1; i < rows; i++) 
	        {
	        	HSSFRow row = sheet.getRow(i);
	        	if (row != null) 
	        	{
	        		int cells = row.getPhysicalNumberOfCells();
	        		for (int j = 0; j < cells; j++) 
	        		{
	        			HSSFCell cell = row.getCell(j);
	        			if (cell != null&&(HSSFCell.CELL_TYPE_STRING==cell.getCellType())) 
	        			{
	        				cell.setCellStyle(cellStyle);
	        				cell.setCellValue(new HSSFRichTextString(cell.getStringCellValue().replaceAll("<(/)?br(/)?>", "/")));
	        			}
	        		}
	        	}	
	        }
	        workBook.write(out);
			inputStream.close();
			out.close();
		}
	}
	
	public void exportClassHourDetail(String fileName,String param,OutputStream out) throws Exception
	{
		List list = JacksonJsonMapper.getInstance().readValue(param, List.class);
		String filePath =this.getFullFilePath(fileName);
		HttpClient client = new HttpClient();   
		GetMethod httpGet = new GetMethod(filePath);  
		client.executeMethod(httpGet); 
		InputStream inputStream =httpGet.getResponseBodyAsStream();
		Map<String, List<Map>> beanParams = new HashMap<String, List<Map>>();
		beanParams.put("reportList", list);  
        XLSTransformer former = new XLSTransformer(); 
        HSSFWorkbook workBook = (HSSFWorkbook)former.transformXLS(inputStream, beanParams);
        //加入换行格式
        HSSFCellStyle cellStyle=workBook.createCellStyle();  
        cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 左右居中   
        cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 上下居中 
        cellStyle.setWrapText(true); 
        for(int i=1;i<=list.size()+1;i++)
        {
        	Cell obj =workBook.getSheetAt(0).getRow(i).getCell(3);
        	obj.setCellStyle(cellStyle);
        	obj.setCellValue(new HSSFRichTextString(obj.getStringCellValue().replaceAll("<(/)?br(/)?>", "/")));
        }	
        
        workBook.write(out);
		inputStream.close();
		out.close();
	}
	
	public void exportLackOfGradRate(String fileName,String year,String quarter,String param,OutputStream out) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1019\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		String result= ServiceEngine.invokeHttp(params);
		JSONObject obj =JSONObject.fromObject(result);
		if(ObjectCensor.isStrRegular(StringUtil.getJSONObjectKeyVal(obj, "rows")))
		{
			List list = JacksonJsonMapper.getInstance().readValue(obj.getString("rows"), List.class);
			String filePath =this.getFullFilePath(fileName);
			HttpClient client = new HttpClient();   
			GetMethod httpGet = new GetMethod(filePath);  
			client.executeMethod(httpGet); 
			InputStream inputStream =httpGet.getResponseBodyAsStream();
			Map<String, List<Map>> beanParams = new HashMap<String, List<Map>>();
			beanParams.put("reportList", list);  
	        XLSTransformer former = new XLSTransformer(); 
	        HSSFWorkbook workBook = (HSSFWorkbook)former.transformXLS(inputStream, beanParams);
		    HSSFSheet sheet = workBook.getSheetAt(0);
		    sheet.getRow(0).getCell(0).setCellValue(year+"升学率缺口");
		    String name1="",name2="",name3="",name4="",name5="";
		    if("1".equals(quarter))
		    {
		    	name1 ="一季度距目标缺口";
		    	name2 ="1月升学率";
		    	name3 ="2月升学率";
		    	name4 ="3月升学率";
		    	name5 ="一季度升学率";
		    }
		    else if("2".equals(quarter))
		    {
		    	name1 ="二季度距目标缺口";
		    	name2 ="4月升学率";
		    	name3 ="5月升学率";
		    	name4 ="6月升学率";
		    	name5 ="二季度升学率";
		    }	
		    else if("3".equals(quarter))
		    {
		    	name1 ="三季度距目标缺口";
		    	name2 ="7月升学率";
		    	name3 ="8月升学率";
		    	name4 ="9月升学率";
		    	name5 ="三季度升学率";
		    }	
		    else if("4".equals(quarter))
		    {
		    	name1 ="四季度距目标缺口";
		    	name2 ="10月升学率";
		    	name3 ="11月升学率";
		    	name4 ="12月升学率";
		    	name5 ="四季度升学率";
		    }
		    sheet.getRow(1).getCell(1).setCellValue(name1);
		    sheet.getRow(1).getCell(3).setCellValue(name2);
		    sheet.getRow(1).getCell(4).setCellValue(name3);
		    sheet.getRow(1).getCell(5).setCellValue(name4);
		    sheet.getRow(1).getCell(7).setCellValue(name5);
	        workBook.write(out);
			inputStream.close();
			out.close();
		}
	}
	
	public void normalMergeExport(String fileName,String mergeName,String mergeIndex,String param,OutputStream out) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1019\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		String result= ServiceEngine.invokeHttp(params);
		JSONObject obj =JSONObject.fromObject(result);
		if(ObjectCensor.isStrRegular(StringUtil.getJSONObjectKeyVal(obj, "rows")))
		{
			List list = JacksonJsonMapper.getInstance().readValue(obj.getString("rows"), List.class);
			String filePath =this.getFullFilePath(fileName);
			HttpClient client = new HttpClient();   
			GetMethod httpGet = new GetMethod(filePath);  
			client.executeMethod(httpGet); 
			InputStream inputStream =httpGet.getResponseBodyAsStream();
			Map<String, List<Map>> beanParams = new HashMap<String, List<Map>>();
			beanParams.put("reportList", list);  
	        XLSTransformer former = new XLSTransformer(); 
	        List<CellRangeAddress> cellRangeList =new ArrayList<CellRangeAddress>();
	        HSSFWorkbook workBook = (HSSFWorkbook)former.transformXLS(inputStream, beanParams);
		    HSSFSheet sheet = workBook.getSheetAt(0);
		    JSONArray array =obj.getJSONArray("rows");
		    if(array.size()>0)
		    {
		    	boolean flag =false;
		    	int fr=1,tr=1;
		    	String value =StringUtil.getJSONObjectKeyVal(array.getJSONObject(0), mergeName);
		    	String []indexArr=mergeIndex.split(",");
		    	for(int j=1;j<array.size();j++)
				{
					JSONObject item =array.getJSONObject(j);
					if(value.equals(StringUtil.getJSONObjectKeyVal(item, mergeName)))
					{
						flag =true;	
						tr =j+1;
						if(j==(array.size()-1)&&flag)
						{
							for(int m=0;m<indexArr.length;m++)
							{
								int cIndex =Integer.valueOf(indexArr[m]);
								CellRangeAddress range1 =new CellRangeAddress(fr, tr, cIndex,cIndex);
								cellRangeList.add(range1);
							}	
							
						}	
					}
					else
					{
						if(flag)
						{
							for(int m=0;m<indexArr.length;m++)
							{
								int cIndex =Integer.valueOf(indexArr[m]);
								CellRangeAddress range2 =new CellRangeAddress(fr, tr, cIndex,cIndex);
								cellRangeList.add(range2);
							}
							flag =false;
						}
						fr =j+1;
						value =StringUtil.getJSONObjectKeyVal(item, mergeName);
					}
				}	
		    }	
		    for(CellRangeAddress cellRange:cellRangeList)
		    {
		    	sheet.addMergedRegion(cellRange);
		    }	
	        workBook.write(out);
			inputStream.close();
			out.close();
		}
	}
	
	
	
	private String getFullFilePath(String fileName) throws Exception
	{
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1015\",securityCode:\"0000000000\",params:{paramType:\"UPLOAD_PATH\",paramValue:\"excel_model\"},rtnDataFormatType:\"user-defined\"}";
		String rstMsg = ServiceEngine.invokeHttp(param);
		JSONArray array = JSONArray.fromObject(rstMsg);
		if(ObjectCensor.checkListIsNull(array))
		{
			JSONObject obj = array.getJSONObject(0);
			String path = StringUtil.getJSONObjectKeyVal(obj, "param1");
			String folderName = StringUtil.getJSONObjectKeyVal(obj, "param2");
			return path+folderName+URLEncoder.encode(fileName, "utf-8")+".xls";
		}
		else
		{
			return null;
		}	
	}
	
	public void exportCenterTeaFeedback(String fileName,String param,OutputStream out) throws Exception
	{
		String result=qryCenterTeaFeedback(param);
		JSONObject obj =JSONObject.fromObject(result);
		List list = JacksonJsonMapper.getInstance().readValue(obj.getString("rows"), List.class);
		String filePath =this.getFullFilePath(fileName);
		HttpClient client = new HttpClient();   
		GetMethod httpGet = new GetMethod(filePath);  
		client.executeMethod(httpGet); 
		InputStream inputStream =httpGet.getResponseBodyAsStream();
		Map<String, List<Map>> beanParams = new HashMap<String, List<Map>>();
		beanParams.put("reportList", list);  
        XLSTransformer former = new XLSTransformer(); 
        Workbook workBook = former.transformXLS(inputStream, beanParams);
        workBook.write(out);
		inputStream.close();
		out.close();
	}
	
	public void exportTeacherAttend(String fileName,String param,OutputStream out) throws Exception
	{
		JSONObject pjson =JSONObject.fromObject(param);
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS8201\",securityCode:\"0000000000\",params:{schoolId:'"+StringUtil.getJSONObjectKeyVal(pjson, "schoolId")+"',teacherId:'"+StringUtil.getJSONObjectKeyVal(pjson, "teacherId")+"',month:'"+StringUtil.getJSONObjectKeyVal(pjson, "month")+"'},rtnDataFormatType:\"user-defined\"}";
		JSONArray array =JSONArray.fromObject(ServiceEngine.invokeHttp(params));
		if(array.size()>0)
		{
			List list = JacksonJsonMapper.getInstance().readValue(array.toString(), List.class);
			String filePath =this.getFullFilePath(fileName);
			HttpClient client = new HttpClient();   
			GetMethod httpGet = new GetMethod(filePath);  
			client.executeMethod(httpGet); 
			InputStream inputStream =httpGet.getResponseBodyAsStream();
			Map<String, List<Map>> beanParams = new HashMap<String, List<Map>>();
			beanParams.put("reportList", list);  
	        XLSTransformer former = new XLSTransformer(); 
	        List<CellRangeAddress> cellRangeList =new ArrayList<CellRangeAddress>();
	        HSSFWorkbook workBook = (HSSFWorkbook)former.transformXLS(inputStream, beanParams);
		    HSSFSheet sheet = workBook.getSheetAt(0);
		    if(array.size()>0)
		    {
		    	boolean flag1 =false,flag2 =false;
		    	int fr1=2,tr1=2,fr2=2,tr2=2;
		    	String value1 =StringUtil.getJSONObjectKeyVal(array.getJSONObject(0), "schoolId");
		    	String value2 =StringUtil.getJSONObjectKeyVal(array.getJSONObject(0), "teacherId");
		    	for(int j=1;j<array.size();j++)
				{
					JSONObject item =array.getJSONObject(j);
					if(value1.equals(StringUtil.getJSONObjectKeyVal(item,"schoolId")))
					{
						flag1 =true;	
						tr1 =j+2;
						if(j==(array.size()-1)&&flag1)
						{
							CellRangeAddress range1 =new CellRangeAddress(fr1, tr1, 0,0);
							cellRangeList.add(range1);
							
						}	
					}
					else
					{
						if(flag1)
						{
							CellRangeAddress range2 =new CellRangeAddress(fr1, tr1, 0,0);
							cellRangeList.add(range2);
							flag1 =false;
						}
						fr1 =j+2;
						value1 =StringUtil.getJSONObjectKeyVal(item, "schoolId");
					}
					if(value2.equals(StringUtil.getJSONObjectKeyVal(item,"teacherId")))
					{
						flag2 =true;	
						tr2 =j+2;
						if(j==(array.size()-1)&&flag1)
						{
							CellRangeAddress range1 =new CellRangeAddress(fr2, tr2, 1,1);
							cellRangeList.add(range1);
							range1 =new CellRangeAddress(fr2, tr2,2,2);
							cellRangeList.add(range1);
						}	
					}
					else
					{
						if(flag2)
						{
							CellRangeAddress range1 =new CellRangeAddress(fr2, tr2, 1,1);
							cellRangeList.add(range1);
							range1 =new CellRangeAddress(fr2, tr2,2,2);
							cellRangeList.add(range1);
							flag2 =false;
						}
						fr2 =j+2;
						value2 =StringUtil.getJSONObjectKeyVal(item, "teacherId");
					}
				}	
		    }	
		    for(CellRangeAddress cellRange:cellRangeList)
		    {
		    	sheet.addMergedRegion(cellRange);
		    }	
	        workBook.write(out);
			inputStream.close();
			out.close();
		}
	}
	
	public void exportTeacherNum(String fileName,String param,OutputStream out) throws Exception
	{
		JSONObject pjson =JSONObject.fromObject(param);
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS8202\",securityCode:\"0000000000\",params:{schoolId:'"+StringUtil.getJSONObjectKeyVal(pjson, "schoolId")+"',teacherId:'"+StringUtil.getJSONObjectKeyVal(pjson, "teacherId")+"',month:'"+StringUtil.getJSONObjectKeyVal(pjson, "month")+"'},rtnDataFormatType:\"user-defined\"}";
		JSONArray array =JSONArray.fromObject(ServiceEngine.invokeHttp(params));
		if(array.size()>0)
		{
			List list = JacksonJsonMapper.getInstance().readValue(array.toString(), List.class);
			String filePath =this.getFullFilePath(fileName);
			HttpClient client = new HttpClient();   
			GetMethod httpGet = new GetMethod(filePath);  
			client.executeMethod(httpGet); 
			InputStream inputStream =httpGet.getResponseBodyAsStream();
			Map<String, List<Map>> beanParams = new HashMap<String, List<Map>>();
			beanParams.put("reportList", list);  
	        XLSTransformer former = new XLSTransformer(); 
	        List<CellRangeAddress> cellRangeList =new ArrayList<CellRangeAddress>();
	        HSSFWorkbook workBook = (HSSFWorkbook)former.transformXLS(inputStream, beanParams);
//		    HSSFSheet sheet = workBook.getSheetAt(0);
//		    if(array.size()>0)
//		    {
//		    	boolean flag1 =false,flag2 =false;
//		    	int fr1=2,tr1=2,fr2=2,tr2=2;
//		    	String value1 =StringUtil.getJSONObjectKeyVal(array.getJSONObject(0), "schoolId");
//		    	String value2 =StringUtil.getJSONObjectKeyVal(array.getJSONObject(0), "teacherId");
//		    	for(int j=1;j<array.size();j++)
//				{
//					JSONObject item =array.getJSONObject(j);
//					if(value1.equals(StringUtil.getJSONObjectKeyVal(item,"schoolId")))
//					{
//						flag1 =true;	
//						tr1 =j+2;
//						if(j==(array.size()-1)&&flag1)
//						{
//							CellRangeAddress range1 =new CellRangeAddress(fr1, tr1, 0,0);
//							cellRangeList.add(range1);
//							
//						}	
//					}
//					else
//					{
//						if(flag1)
//						{
//							CellRangeAddress range2 =new CellRangeAddress(fr1, tr1, 0,0);
//							cellRangeList.add(range2);
//							flag1 =false;
//						}
//						fr1 =j+2;
//						value1 =StringUtil.getJSONObjectKeyVal(item, "schoolId");
//					}
//					if(value2.equals(StringUtil.getJSONObjectKeyVal(item,"teacherId")))
//					{
//						flag2 =true;	
//						tr2 =j+2;
//						if(j==(array.size()-1)&&flag1)
//						{
//							CellRangeAddress range1 =new CellRangeAddress(fr2, tr2, 1,1);
//							cellRangeList.add(range1);
//							range1 =new CellRangeAddress(fr2, tr2,2,2);
//							cellRangeList.add(range1);
//						}	
//					}
//					else
//					{
//						if(flag2)
//						{
//							CellRangeAddress range1 =new CellRangeAddress(fr2, tr2, 1,1);
//							cellRangeList.add(range1);
//							range1 =new CellRangeAddress(fr2, tr2,2,2);
//							cellRangeList.add(range1);
//							flag2 =false;
//						}
//						fr2 =j+2;
//						value2 =StringUtil.getJSONObjectKeyVal(item, "teacherId");
//					}
//				}	
//		    }	
//		    for(CellRangeAddress cellRange:cellRangeList)
//		    {
//		    	sheet.addMergedRegion(cellRange);
//		    }	
	        workBook.write(out);
			inputStream.close();
			out.close();
		}
	}
	
	public void exportClassInstDetail(String fileName,String mergeName,String mergeIndex,String param,OutputStream out) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS00710\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		JSONArray array =JSONArray.fromObject(ServiceEngine.invokeHttp(params));
		if(array.size()>0)
		{
			List list = JacksonJsonMapper.getInstance().readValue(array.toString(), List.class);
			String filePath =this.getFullFilePath(fileName);
			HttpClient client = new HttpClient();   
			GetMethod httpGet = new GetMethod(filePath);  
			client.executeMethod(httpGet); 
			InputStream inputStream =httpGet.getResponseBodyAsStream();
			Map<String, List<Map>> beanParams = new HashMap<String, List<Map>>();
			beanParams.put("reportList", list);  
	        XLSTransformer former = new XLSTransformer(); 
	        List<CellRangeAddress> cellRangeList =new ArrayList<CellRangeAddress>();
	        HSSFWorkbook workBook = (HSSFWorkbook)former.transformXLS(inputStream, beanParams);
		    HSSFSheet sheet = workBook.getSheetAt(0);
		    if(array.size()>0)
		    {
		    	boolean flag =false;
		    	int fr=1,tr=1;
		    	String value =StringUtil.getJSONObjectKeyVal(array.getJSONObject(0), mergeName);
		    	String []indexArr=mergeIndex.split(",");
		    	for(int j=1;j<array.size();j++)
				{
					JSONObject item =array.getJSONObject(j);
					if(value.equals(StringUtil.getJSONObjectKeyVal(item, mergeName)))
					{
						flag =true;	
						tr =j+1;
						if(j==(array.size()-1)&&flag)
						{
							for(int m=0;m<indexArr.length;m++)
							{
								int cIndex =Integer.valueOf(indexArr[m]);
								CellRangeAddress range1 =new CellRangeAddress(fr, tr, cIndex,cIndex);
								cellRangeList.add(range1);
							}	
							
						}	
					}
					else
					{
						if(flag)
						{
							for(int m=0;m<indexArr.length;m++)
							{
								int cIndex =Integer.valueOf(indexArr[m]);
								CellRangeAddress range2 =new CellRangeAddress(fr, tr, cIndex,cIndex);
								cellRangeList.add(range2);
							}
							flag =false;
						}
						fr =j+1;
						value =StringUtil.getJSONObjectKeyVal(item, mergeName);
					}
				}	
		    }	
		    for(CellRangeAddress cellRange:cellRangeList)
		    {
		    	sheet.addMergedRegion(cellRange);
		    }	
	        workBook.write(out);
			inputStream.close();
			out.close();
		}
	}
	
	
	
	public void exportSchoolMSGradRate(String fileName,String year,String param,OutputStream out) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1019\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		String result= ServiceEngine.invokeHttp(params);
		JSONObject obj =JSONObject.fromObject(result);
		if(ObjectCensor.isStrRegular(StringUtil.getJSONObjectKeyVal(obj, "rows")))
		{
			List list = JacksonJsonMapper.getInstance().readValue(obj.getString("rows"), List.class);
			String filePath =this.getFullFilePath(fileName);
			HttpClient client = new HttpClient();   
			GetMethod httpGet = new GetMethod(filePath);  
			client.executeMethod(httpGet); 
			InputStream inputStream =httpGet.getResponseBodyAsStream();
			Map<String, List<Map>> beanParams = new HashMap<String, List<Map>>();
			beanParams.put("reportList", list);  
	        XLSTransformer former = new XLSTransformer(); 
	        List<CellRangeAddress> cellRangeList =new ArrayList<CellRangeAddress>();
	        HSSFWorkbook workBook = (HSSFWorkbook)former.transformXLS(inputStream, beanParams);
		    HSSFSheet sheet = workBook.getSheetAt(0);
		    sheet.getRow(0).getCell(0).setCellValue(year+"月度/季度升学率");
		    JSONArray array =obj.getJSONArray("rows");
		    if(array.size()>0)
		    {
		    	boolean flag =false;
		    	int fr=2,tr=2;
		    	String value =StringUtil.getJSONObjectKeyVal(array.getJSONObject(0), "quarter");
		    	for(int j=1;j<array.size();j++)
				{
					JSONObject item =array.getJSONObject(j);
					if(value.equals(StringUtil.getJSONObjectKeyVal(item,"quarter")))
					{
						flag =true;	
						tr =j+2;
						if(j==(array.size()-1)&&flag)
						{
							CellRangeAddress range1 =new CellRangeAddress(fr, tr, 4,4);
							cellRangeList.add(range1);
							
						}	
					}
					else
					{
						if(flag)
						{
							CellRangeAddress range2 =new CellRangeAddress(fr, tr, 4,4);
							cellRangeList.add(range2);
							flag =false;
						}
						fr =j+2;
						value =StringUtil.getJSONObjectKeyVal(item, "quarter");
					}
				}	
		    }	
		    for(CellRangeAddress cellRange:cellRangeList)
		    {
		    	sheet.addMergedRegion(cellRange);
		    }	
	        workBook.write(out);
			inputStream.close();
			out.close();
		}
	}
	
	public void exportCenterGradeRate(String fileName,String param,OutputStream out) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1019\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		String result= ServiceEngine.invokeHttp(params);
		JSONObject obj =JSONObject.fromObject(result);
		if(ObjectCensor.isStrRegular(StringUtil.getJSONObjectKeyVal(obj, "rows")))
		{
			List list = JacksonJsonMapper.getInstance().readValue(obj.getString("rows"), List.class);
			String filePath =this.getFullFilePath(fileName);
			HttpClient client = new HttpClient();   
			GetMethod httpGet = new GetMethod(filePath);  
			client.executeMethod(httpGet); 
			InputStream inputStream =httpGet.getResponseBodyAsStream();
			Map<String, List<Map>> beanParams = new HashMap<String, List<Map>>();
			beanParams.put("reportList", list);  
	        XLSTransformer former = new XLSTransformer(); 
	        List<CellRangeAddress> cellRangeList =new ArrayList<CellRangeAddress>();
	        HSSFWorkbook workBook = (HSSFWorkbook)former.transformXLS(inputStream, beanParams);
		    HSSFSheet sheet = workBook.getSheetAt(0);
		    JSONArray array =obj.getJSONArray("rows");
		    if(array.size()>0)
		    {
		    	boolean flag =false;
		    	int fr=2,tr=2;
		    	String value =StringUtil.getJSONObjectKeyVal(array.getJSONObject(0), "schoolId");
		    	for(int j=1;j<array.size();j++)
				{
					JSONObject item =array.getJSONObject(j);
					if(value.equals(StringUtil.getJSONObjectKeyVal(item,"schoolId")))
					{
						flag =true;	
						tr =j+2;
						if(j==(array.size()-1)&&flag)
						{
							CellRangeAddress range1 =new CellRangeAddress(fr, tr, 0,0);
							cellRangeList.add(range1);
							
						}	
					}
					else
					{
						if(flag)
						{
							CellRangeAddress range2 =new CellRangeAddress(fr, tr, 0,0);
							cellRangeList.add(range2);
							flag =false;
						}
						fr =j+2;
						value =StringUtil.getJSONObjectKeyVal(item, "schoolId");
					}
				}	
		    }	
		    for(CellRangeAddress cellRange:cellRangeList)
		    {
		    	sheet.addMergedRegion(cellRange);
		    }	
	        workBook.write(out);
			inputStream.close();
			out.close();
		}
	}
	
	public void exportCenterMSRate(String fileName,String year,String param,OutputStream out) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1019\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		String result= ServiceEngine.invokeHttp(params);
		JSONObject obj =JSONObject.fromObject(result);
		if(ObjectCensor.isStrRegular(StringUtil.getJSONObjectKeyVal(obj, "rows")))
		{
			List list = JacksonJsonMapper.getInstance().readValue(obj.getString("rows"), List.class);
			String filePath =this.getFullFilePath(fileName);
			HttpClient client = new HttpClient();   
			GetMethod httpGet = new GetMethod(filePath);  
			client.executeMethod(httpGet); 
			InputStream inputStream =httpGet.getResponseBodyAsStream();
			Map<String, List<Map>> beanParams = new HashMap<String, List<Map>>();
			beanParams.put("reportList", list);  
	        XLSTransformer former = new XLSTransformer(); 
	        List<CellRangeAddress> cellRangeList =new ArrayList<CellRangeAddress>();
	        HSSFWorkbook workBook = (HSSFWorkbook)former.transformXLS(inputStream, beanParams);
		    HSSFSheet sheet = workBook.getSheetAt(0);
		    sheet.getRow(0).getCell(0).setCellValue(year+"月度/季度升学率");
		    JSONArray array =obj.getJSONArray("rows");
		    if(array.size()>0)
		    {
		    	boolean flag1 =false,flag2 =false;
		    	int fr1=2,tr1=2,fr2=2,tr2=2;
		    	String value1 =StringUtil.getJSONObjectKeyVal(array.getJSONObject(0), "schoolId");
		    	String value2 =StringUtil.getJSONObjectKeyVal(array.getJSONObject(0), "quarter");
		    	for(int j=1;j<array.size();j++)
				{
					JSONObject item =array.getJSONObject(j);
					if(value1.equals(StringUtil.getJSONObjectKeyVal(item,"schoolId")))
					{
						flag1 =true;	
						tr1 =j+2;
						if(j==(array.size()-1)&&flag1)
						{
							CellRangeAddress range1 =new CellRangeAddress(fr1, tr1, 0,0);
							cellRangeList.add(range1);
							
						}	
					}
					else
					{
						if(flag1)
						{
							CellRangeAddress range2 =new CellRangeAddress(fr1, tr1, 0,0);
							cellRangeList.add(range2);
							flag1 =false;
						}
						fr1 =j+2;
						value1 =StringUtil.getJSONObjectKeyVal(item, "schoolId");
					}
					if(value2.equals(StringUtil.getJSONObjectKeyVal(item,"quarter")))
					{
						flag2 =true;	
						tr2 =j+2;
						if(j==(array.size()-1)&&flag1)
						{
							CellRangeAddress range1 =new CellRangeAddress(fr2, tr2, 5,5);
							cellRangeList.add(range1);
							
						}	
					}
					else
					{
						if(flag2)
						{
							CellRangeAddress range2 =new CellRangeAddress(fr2, tr2,5,5);
							cellRangeList.add(range2);
							flag2 =false;
						}
						fr2 =j+2;
						value2 =StringUtil.getJSONObjectKeyVal(item, "quarter");
					}
				}	
		    }	
		    for(CellRangeAddress cellRange:cellRangeList)
		    {
		    	sheet.addMergedRegion(cellRange);
		    }	
	        workBook.write(out);
			inputStream.close();
			out.close();
		}
	}
	
	
	public void exportRegionGradRate(String fileName,String param,OutputStream out) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1019\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		String result= ServiceEngine.invokeHttp(params);
		JSONObject obj =JSONObject.fromObject(result);
		if(ObjectCensor.isStrRegular(StringUtil.getJSONObjectKeyVal(obj, "rows")))
		{
			List list = JacksonJsonMapper.getInstance().readValue(obj.getString("rows"), List.class);
			String filePath =this.getFullFilePath(fileName);
			HttpClient client = new HttpClient();   
			GetMethod httpGet = new GetMethod(filePath);  
			client.executeMethod(httpGet); 
			InputStream inputStream =httpGet.getResponseBodyAsStream();
			Map<String, List<Map>> beanParams = new HashMap<String, List<Map>>();
			beanParams.put("reportList", list);  
	        XLSTransformer former = new XLSTransformer(); 
	        List<CellRangeAddress> cellRangeList =new ArrayList<CellRangeAddress>();
	        HSSFWorkbook workBook = (HSSFWorkbook)former.transformXLS(inputStream, beanParams);
		    HSSFSheet sheet = workBook.getSheetAt(0);
		    JSONArray array =obj.getJSONArray("rows");
		    if(array.size()>0)
		    {
		    	boolean flag1 =false,flag2 =false;
		    	int fr1=1,tr1=1,fr2=1,tr2=1;
		    	String value1 =StringUtil.getJSONObjectKeyVal(array.getJSONObject(0), "regionId");
		    	String value2 =StringUtil.getJSONObjectKeyVal(array.getJSONObject(0), "quarter");
		    	for(int j=1;j<array.size();j++)
				{
					JSONObject item =array.getJSONObject(j);
					if(value1.equals(StringUtil.getJSONObjectKeyVal(item,"regionId")))
					{
						flag1 =true;	
						tr1 =j+1;
						if(j==(array.size()-1)&&flag1)
						{
							CellRangeAddress range1 =new CellRangeAddress(fr1, tr1, 0,0);
							cellRangeList.add(range1);
							
						}	
					}
					else
					{
						if(flag1)
						{
							CellRangeAddress range2 =new CellRangeAddress(fr1, tr1, 0,0);
							cellRangeList.add(range2);
							flag1 =false;
						}
						fr1 =j+1;
						value1 =StringUtil.getJSONObjectKeyVal(item, "regionId");
					}
					if(value2.equals(StringUtil.getJSONObjectKeyVal(item,"quarter")))
					{
						flag2 =true;	
						tr2 =j+1;
						if(j==(array.size()-1)&&flag1)
						{
							CellRangeAddress range1 =new CellRangeAddress(fr2, tr2, 5,5);
							cellRangeList.add(range1);
							
						}	
					}
					else
					{
						if(flag2)
						{
							CellRangeAddress range2 =new CellRangeAddress(fr2, tr2,5,5);
							cellRangeList.add(range2);
							flag2 =false;
						}
						fr2 =j+1;
						value2 =StringUtil.getJSONObjectKeyVal(item, "quarter");
					}
				}	
		    }	
		    for(CellRangeAddress cellRange:cellRangeList)
		    {
		    	sheet.addMergedRegion(cellRange);
		    }	
	        workBook.write(out);
			inputStream.close();
			out.close();
		}
	}
	
	
	public void exportExpClassDetai(String fileName,String param,OutputStream out) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1019\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		String result= ServiceEngine.invokeHttp(params);
		JSONObject obj =JSONObject.fromObject(result);
		if(ObjectCensor.isStrRegular(StringUtil.getJSONObjectKeyVal(obj, "rows")))
		{
			List list = JacksonJsonMapper.getInstance().readValue(obj.getString("rows"), List.class);
			String filePath =this.getFullFilePath(fileName);
			HttpClient client = new HttpClient();   
			GetMethod httpGet = new GetMethod(filePath);  
			client.executeMethod(httpGet); 
			InputStream inputStream =httpGet.getResponseBodyAsStream();
			Map<String, List<Map>> beanParams = new HashMap<String, List<Map>>();
			beanParams.put("reportList", list);  
	        XLSTransformer former = new XLSTransformer(); 
	        List<CellRangeAddress> cellRangeList =new ArrayList<CellRangeAddress>();
	        HSSFWorkbook workBook = (HSSFWorkbook)former.transformXLS(inputStream, beanParams);
		    HSSFSheet sheet = workBook.getSheetAt(0);
		    JSONArray array =obj.getJSONArray("rows");
		    if(array.size()>0)
		    {
		    	boolean flag1 =false,flag2 =false;
		    	int fr1=2,tr1=2,fr2=2,tr2=2;
		    	String value1 =StringUtil.getJSONObjectKeyVal(array.getJSONObject(0), "schoolId");
		    	String value2 =StringUtil.getJSONObjectKeyVal(array.getJSONObject(0), "stageId");
		    	for(int j=1;j<array.size();j++)
				{
					JSONObject item =array.getJSONObject(j);
					if(value1.equals(StringUtil.getJSONObjectKeyVal(item,"schoolId")))
					{
						flag1 =true;	
						tr1 =j+2;
						if(j==(array.size()-1)&&flag1)
						{
							CellRangeAddress range1 =new CellRangeAddress(fr1, tr1, 0,0);
							cellRangeList.add(range1);
							
						}	
					}
					else
					{
						if(flag1)
						{
							CellRangeAddress range2 =new CellRangeAddress(fr1, tr1, 0,0);
							cellRangeList.add(range2);
							flag1 =false;
						}
						fr1 =j+2;
						value1 =StringUtil.getJSONObjectKeyVal(item, "schoolId");
					}
					if(value2.equals(StringUtil.getJSONObjectKeyVal(item,"stageId")))
					{
						flag2 =true;	
						tr2 =j+2;
						if(j==(array.size()-1)&&flag1)
						{
							CellRangeAddress range1 =new CellRangeAddress(fr2, tr2, 1,1);
							cellRangeList.add(range1);
							range1 =new CellRangeAddress(fr2, tr2, 2,2);
							cellRangeList.add(range1);
							range1 =new CellRangeAddress(fr2, tr2, 5,5);
							cellRangeList.add(range1);
							range1 =new CellRangeAddress(fr2, tr2, 6,6);
							cellRangeList.add(range1);
							
						}	
					}
					else
					{
						if(flag2)
						{
							CellRangeAddress range2 =new CellRangeAddress(fr2, tr2, 1,1);
							cellRangeList.add(range2);
							range2 =new CellRangeAddress(fr2, tr2, 2,2);
							cellRangeList.add(range2);
							range2 =new CellRangeAddress(fr2, tr2, 5,5);
							cellRangeList.add(range2);
							range2 =new CellRangeAddress(fr2, tr2, 6,6);
							cellRangeList.add(range2);
							flag2 =false;
						}
						fr2 =j+2;
						value2 =StringUtil.getJSONObjectKeyVal(item, "stageId");
					}
				}	
		    }	
		    for(CellRangeAddress cellRange:cellRangeList)
		    {
		    	sheet.addMergedRegion(cellRange);
		    }	
	        workBook.write(out);
			inputStream.close();
			out.close();
		}
	}
	
	
	public void exportUnfinishFeedback(String fileName,String param,OutputStream out) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1019\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		JSONObject json =JSONObject.fromObject(ServiceEngine.invokeHttp(params));
		if(ObjectCensor.isStrRegular(StringUtil.getJSONObjectKeyVal(json, "rows")))
		{
			JSONArray array =json.getJSONArray("rows");
			if(array.size()>0)
			{
				List<CellRangeAddress> cellRangeList =new ArrayList<CellRangeAddress>();
				int fr1=1,tr1=1,fr2=1,tr2=1;
				boolean flag1=false,flag2=false;
				String schoolIndex=StringUtil.getJSONObjectKeyVal(array.getJSONObject(0), "schoolId"),classIndex=StringUtil.getJSONObjectKeyVal(array.getJSONObject(0), "classInstId");
				for(int j=1;j<array.size();j++)
				{
					JSONObject item =array.getJSONObject(j);
					if(schoolIndex.equals(StringUtil.getJSONObjectKeyVal(item, "schoolId")))
					{
						flag1 =true;	
						tr1 =j+1;
						if(j==(array.size()-1)&&flag1)
						{
							CellRangeAddress range1 =new CellRangeAddress(fr1, tr1, 0, 0);
							cellRangeList.add(range1);
						}	
					}
					else
					{
						if(flag1)
						{
							CellRangeAddress range1 =new CellRangeAddress(fr1, tr1, 0, 0);
							cellRangeList.add(range1);
							flag1 =false;
						}
						fr1 =j+1;
						schoolIndex =StringUtil.getJSONObjectKeyVal(item, "schoolId");
					}
					if(classIndex.equals(StringUtil.getJSONObjectKeyVal(item, "classInstId")))
					{
						flag2 =true;	
						tr2 =j+1;
						if(j==(array.size()-1)&&flag2)
						{
							CellRangeAddress range2 =new CellRangeAddress(fr2, tr2, 1, 1);
							CellRangeAddress range3 =new CellRangeAddress(fr2, tr2, 2, 2);
							cellRangeList.add(range2);
							cellRangeList.add(range3);
						}
					}
					else
					{
						if(flag2)
						{
							CellRangeAddress range2 =new CellRangeAddress(fr2, tr2, 1, 1);
							CellRangeAddress range3 =new CellRangeAddress(fr2, tr2, 2, 2);
							cellRangeList.add(range2);
							cellRangeList.add(range3);
							flag2 =false;
						}
						fr2 =j+1;
						classIndex =StringUtil.getJSONObjectKeyVal(item, "classInstId");
					}
				}	
				List list = JacksonJsonMapper.getInstance().readValue(array.toString(), List.class);
				String filePath =this.getFullFilePath(fileName);
				HttpClient client = new HttpClient();   
				GetMethod httpGet = new GetMethod(filePath);  
				client.executeMethod(httpGet); 
				InputStream inputStream =httpGet.getResponseBodyAsStream();
				Map<String, List<Map>> beanParams = new HashMap<String, List<Map>>();
				beanParams.put("reportList", list);  
			    XLSTransformer former = new XLSTransformer(); 
			    HSSFWorkbook workBook = (HSSFWorkbook)former.transformXLS(inputStream, beanParams);
			    HSSFSheet sheet = workBook.getSheetAt(0);
			    for(CellRangeAddress cellRange:cellRangeList)
			    {
			    	sheet.addMergedRegion(cellRange);
			    }	
			    workBook.write(out);
			    inputStream.close();
				out.close();
			}
			
		}
	}
	
	
	
	
	public String qryCenterTeaFeedback(String param) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1019\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		JSONObject json =JSONObject.fromObject(ServiceEngine.invokeHttp(params));
		if(ObjectCensor.isStrRegular(StringUtil.getJSONObjectKeyVal(json, "rows")))
		{
			JSONArray array =json.getJSONArray("rows");
			JSONArray newArray =new JSONArray();
			if(array.size()>0)
			{
				double[]total =new double[10];
				Arrays.fill(total,0);
				BigDecimal[] per=new BigDecimal[9];
				Arrays.fill(per,new BigDecimal("0.00"));
				int[] count=new int[9];
				Arrays.fill(count, 0);
				String[] arr1=new String[]{"classNum","studentNum","teachingNum","oneNum","planMeetingNum","meetingNum","planOpenNum","openNum","planGradNum","gradNum"};
				String[] arr2=new String[]{"teachingPer","meetingPer","openPer","gradPer","finishPer","meetingCsi","openCsi","gradCsi","csiPer"};
				for(int i=0;i<array.size();i++)
				{
					JSONObject item =array.getJSONObject(i);
					for(int j=0;j<arr1.length;j++)
					{
						if(ObjectCensor.isStrRegular(StringUtil.getJSONObjectKeyVal(item, arr1[j])))
						{
							total[j]+=Double.valueOf(StringUtil.getJSONObjectKeyVal(item, arr1[j]));
						}	
					}
					for(int k=0;k<arr2.length;k++)
					{
						if(ObjectCensor.isStrRegular(StringUtil.getJSONObjectKeyVal(item, arr2[k])))
						{
							per[k]=per[k].add(new BigDecimal(StringUtil.getJSONObjectKeyVal(item, arr2[k])));
							count[k]=count[k]+1;
							item.put(arr2[k], StringUtil.getJSONObjectKeyVal(item, arr2[k])+"%");
						}	
					}
					newArray.add(item);
				}
				JSONObject tobj =new JSONObject();
				tobj.element("schoolName", "总计");
				for(int m=0;m<arr1.length;m++)
				{
					tobj.element(arr1[m], total[m]);	
				}
				for(int n=0;n<arr2.length;n++)
				{
					if(count[n]>0)
					{
						tobj.element(arr2[n], per[n].divide(new BigDecimal(count[n]), 2)+"%");
					}	
					else
					{
						tobj.element(arr2[n], "");
					}	
				}
				newArray.add(tobj);
				json.put("rows", newArray);
			}
		}	
		return json.toString();
	}
	
	public String qryUnfinishFeedback(String param) throws Exception
	{
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1019\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		JSONObject json =JSONObject.fromObject(ServiceEngine.invokeHttp(params));
		if(ObjectCensor.isStrRegular(StringUtil.getJSONObjectKeyVal(json, "rows")))
		{
			JSONArray array =json.getJSONArray("rows");
			JSONArray newArray =new JSONArray();
			if(array.size()>0)
			{
				for(int i=0;i<array.size();i++)
				{
					JSONObject obj =array.getJSONObject(i);
					if("".equals(StringUtil.getJSONObjectKeyVal(obj, "isOpenFinish"))&&"".equals(StringUtil.getJSONObjectKeyVal(obj, "isTeachingFinish"))&&"".equals(StringUtil.getJSONObjectKeyVal(obj, "isMeetingFinish"))&&"".equals(StringUtil.getJSONObjectKeyVal(obj, "isGradFinish")))
					{
						obj.element("type", "");
						obj.element("reason", "未开教质事件");
						newArray.add(obj);
					}
					else
					{
						if("N".equals(StringUtil.getJSONObjectKeyVal(obj, "isTeachingFinish")))
						{
							obj.element("type", "电教");
							obj.element("reason", "电教未完成");
							newArray.add(obj);
						}
						if("N".equals(StringUtil.getJSONObjectKeyVal(obj, "isMeetingFinish")))
						{
							obj.element("type", "家长会");
							obj.element("reason", "出勤未达80%");
							newArray.add(obj);
						}
						if("N".equals(StringUtil.getJSONObjectKeyVal(obj, "isOpenFinish")))
						{
							obj.element("type", "公开课");
							obj.element("reason", "出勤未达80%");
							newArray.add(obj);
						}
						if("N".equals(StringUtil.getJSONObjectKeyVal(obj, "isGradFinish")))
						{
							obj.element("type", "毕业典礼");
							obj.element("reason", "出勤未达80%");
							newArray.add(obj);
						}
					}	
				}
				
			}	
			json.put("rows", newArray);
		}
		return json.toString();
	}
	
}