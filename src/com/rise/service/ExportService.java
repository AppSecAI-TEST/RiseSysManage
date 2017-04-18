package com.rise.service;

import java.io.InputStream;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.jxls.transformer.XLSTransformer;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.JavaType;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.rise.model.AttStuItem;
import com.rise.model.AttStudentObj;
import com.rise.pub.base.JacksonJsonMapper;
import com.rise.pub.invoke.ServiceEngine;
import com.rise.pub.util.DateUtils;
import com.rise.pub.util.ObjectCensor;
import com.rise.pub.util.StringUtil;

@SuppressWarnings("deprecation")
@Service
public class ExportService {
	@Autowired
	private QryPubDataService qryPubDataService;
	
	public void normalExport(String fileName, String param, String funcNodeId, OutputStream out) throws Exception {
		String result = qryPubDataService.qryDataListByPage(null, null, param, funcNodeId);
		JSONObject obj = JSONObject.fromObject(result);
		if (ObjectCensor.isStrRegular(StringUtil.getJSONObjectKeyVal(obj, "rows"))) {
			List list = JacksonJsonMapper.getInstance().readValue(obj.getString("rows"), List.class);
			String filePath = this.getFullFilePath(fileName);
			HttpClient client = new HttpClient();
			GetMethod httpGet = new GetMethod(filePath);
			client.executeMethod(httpGet);
			InputStream inputStream = httpGet.getResponseBodyAsStream();
			Map<String, List<Map>> beanParams = new HashMap<String, List<Map>>();
			beanParams.put("reportList", list);
			XLSTransformer former = new XLSTransformer();
			HSSFWorkbook workBook = (HSSFWorkbook) former.transformXLS(inputStream, beanParams);
			HSSFSheet sheet = workBook.getSheetAt(0);
			int rows = sheet.getPhysicalNumberOfRows();
			HSSFCellStyle cellStyle = workBook.createCellStyle();
			cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 左右居中
			cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 上下居中
			cellStyle.setWrapText(true);
			for (int i = 1; i < rows; i++) {
				HSSFRow row = sheet.getRow(i);
				if (row != null) {
					int cells = row.getPhysicalNumberOfCells();
					for (int j = 0; j < cells; j++) {
						HSSFCell cell = row.getCell(j);
						if (cell != null && (HSSFCell.CELL_TYPE_STRING == cell.getCellType())) {
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
	
	public void attendDetailNormalExport(String fileName,String classInstId,String monthDate,OutputStream out) throws Exception {
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS20411\",securityCode:\"0000000000\",params:{classInstId:\""+classInstId+"\",monthDate:\""+monthDate+"\"},rtnDataFormatType:\"user-defined\"}";
		String result = ServiceEngine.invokeHttp(params);
		ObjectMapper mapper = JacksonJsonMapper.getInstance();
		JavaType javaType = mapper.getTypeFactory().constructParametricType(ArrayList.class, AttStudentObj.class);
		List<AttStudentObj> attStudentList = (List) mapper.readValue(result, javaType);
		List<Map> lsts = new ArrayList<Map>();
		for (AttStudentObj map : attStudentList) {
			Map mapT = new HashMap();
			String name = map.getName();
			String byName = map.getByName();
			mapT.put("name", name);
			mapT.put("byName", byName);
			mapT.put("count", map.getAttendCount());
			List<AttStuItem> items = map.getAttendDates();
			for (int i = 1; i <= 31; i++) {
				String dateStr = monthDate + "-" + i;
				Date d = DateUtils.CHN_DATE_FORMAT.parse(dateStr);
				for (AttStuItem itemT : items) {
					Date date = itemT.getAttendDate();
					String hour = itemT.getAttendTotalHour();
					if (d.getDate() == date.getDate()) {
						mapT.put("date" + i, hour);
					}
				}
			}
			lsts.add(mapT);
		}

		String filePath = this.getFullFilePath(fileName);
		HttpClient client = new HttpClient();
		GetMethod httpGet = new GetMethod(filePath);
		client.executeMethod(httpGet);
		InputStream inputStream = httpGet.getResponseBodyAsStream();
		Map<String, List<Map>> beanParams = new HashMap<String, List<Map>>();
		beanParams.put("reportList", lsts);
		XLSTransformer former = new XLSTransformer();
		HSSFWorkbook workBook = (HSSFWorkbook) former.transformXLS(inputStream, beanParams);
		HSSFSheet sheet = workBook.getSheetAt(0);
		int rows = sheet.getPhysicalNumberOfRows();
		HSSFCellStyle cellStyle = workBook.createCellStyle();
		cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 左右居中
		cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 上下居中
		cellStyle.setWrapText(true);
		for (int i = 1; i < rows; i++) {
			HSSFRow row = sheet.getRow(i);
			if (row != null) {
				int cells = row.getPhysicalNumberOfCells();
				for (int j = 0; j < cells; j++) {
					HSSFCell cell = row.getCell(j);
					if (cell != null && (HSSFCell.CELL_TYPE_STRING == cell.getCellType())) {
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
	
	public void exportData(String fileName, String array, OutputStream out) throws Exception {
		List list = JacksonJsonMapper.getInstance().readValue(array, List.class);
		String filePath = this.getFullFilePath(fileName);
		HttpClient client = new HttpClient();
		GetMethod httpGet = new GetMethod(filePath);
		client.executeMethod(httpGet);
		InputStream inputStream = httpGet.getResponseBodyAsStream();
		Map<String, List<Map>> beanParams = new HashMap<String, List<Map>>();
		beanParams.put("reportList", list);
		XLSTransformer former = new XLSTransformer();
		HSSFWorkbook workBook = (HSSFWorkbook) former.transformXLS(inputStream, beanParams);
		workBook.write(out);
		inputStream.close();
		out.close();
	}
	
	public void exportClassHourDetail(String fileName, String param, OutputStream out) throws Exception {
		List list = JacksonJsonMapper.getInstance().readValue(param, List.class);
		String filePath = this.getFullFilePath(fileName);
		HttpClient client = new HttpClient();
		GetMethod httpGet = new GetMethod(filePath);
		client.executeMethod(httpGet);
		InputStream inputStream = httpGet.getResponseBodyAsStream();
		Map<String, List<Map>> beanParams = new HashMap<String, List<Map>>();
		beanParams.put("reportList", list);
		XLSTransformer former = new XLSTransformer();
		HSSFWorkbook workBook = (HSSFWorkbook) former.transformXLS(inputStream, beanParams);
		// 加入换行格式
		HSSFCellStyle cellStyle = workBook.createCellStyle();
		cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);// 左右居中
		cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 上下居中
		cellStyle.setWrapText(true);
		for (int i = 1; i <= list.size() + 1; i++) {
			Cell obj = workBook.getSheetAt(0).getRow(i).getCell(3);
			obj.setCellStyle(cellStyle);
			obj.setCellValue(new HSSFRichTextString(obj.getStringCellValue().replaceAll("<(/)?br(/)?>", "/")));
		}
		workBook.write(out);
		inputStream.close();
		out.close();
	}
	
	public void exportLackOfGradRate(String fileName, String year, String quarter, String param, String funcNodeId, OutputStream out) throws Exception {
		String result = qryPubDataService.qryDataListByPage(null, null, param, funcNodeId);
		JSONObject obj = JSONObject.fromObject(result);
		if (ObjectCensor.isStrRegular(StringUtil.getJSONObjectKeyVal(obj, "rows"))) {
			List list = JacksonJsonMapper.getInstance().readValue(obj.getString("rows"), List.class);
			String filePath = this.getFullFilePath(fileName);
			HttpClient client = new HttpClient();
			GetMethod httpGet = new GetMethod(filePath);
			client.executeMethod(httpGet);
			InputStream inputStream = httpGet.getResponseBodyAsStream();
			Map<String, List<Map>> beanParams = new HashMap<String, List<Map>>();
			beanParams.put("reportList", list);
			XLSTransformer former = new XLSTransformer();
			HSSFWorkbook workBook = (HSSFWorkbook) former.transformXLS(inputStream, beanParams);
			HSSFSheet sheet = workBook.getSheetAt(0);
			sheet.getRow(0).getCell(0).setCellValue(year + "升学率缺口");
			String name1 = "", name2 = "", name3 = "", name4 = "", name5 = "", name6 = "", name7 = "", name8 = "";
			if ("1".equals(quarter)) {
				name1 = "一季度距目标缺口";
				name2 = "1月升学率";
				name3 = "1月距目标缺口";
				name4 = "2月升学率";
				name5 = "2月距目标缺口";
				name6 = "3月升学率";
				name7 = "3月距目标缺口";
				name8 = "一季度升学率";
			} else if ("2".equals(quarter)) {
				name1 = "二季度距目标缺口";
				name2 = "4月升学率";
				name3 = "4月距目标缺口";
				name4 = "5月升学率";
				name5 = "5月距目标缺口";
				name6 = "6月升学率";
				name7 = "6月距目标缺口";
				name8 = "二季度升学率";
			} else if ("3".equals(quarter)) {
				name1 = "三季度距目标缺口";
				name2 = "7月升学率";
				name3 = "7月距目标缺口";
				name4 = "8月升学率";
				name5 = "8月距目标缺口";
				name6 = "9月升学率";
				name7 = "9月距目标缺口";
				name8 = "三季度升学率";
			} else if ("4".equals(quarter)) {
				name1 = "四季度距目标缺口";
				name2 = "10月升学率";
				name3 = "10月距目标缺口";
				name4 = "11月升学率";
				name5 = "11月距目标缺口";
				name6 = "12月升学率";
				name7 = "12月距目标缺口";
				name8 = "四季度升学率";
			}
			sheet.getRow(1).getCell(1).setCellValue(name1);
			sheet.getRow(1).getCell(2).setCellValue(name2);
			sheet.getRow(1).getCell(3).setCellValue(name3);
			sheet.getRow(1).getCell(4).setCellValue(name4);
			sheet.getRow(1).getCell(5).setCellValue(name5);
			sheet.getRow(1).getCell(6).setCellValue(name6);
			sheet.getRow(1).getCell(7).setCellValue(name7);
			sheet.getRow(1).getCell(9).setCellValue(name8);
			workBook.write(out);
			inputStream.close();
			out.close();
		}
	}
	
	public void normalMergeExport(String fileName, String mergeName, String mergeIndex, String param, String funcNodeId, OutputStream out) throws Exception {
		String result = qryPubDataService.qryDataListByPage(null, null, param, funcNodeId);
		JSONObject obj = JSONObject.fromObject(result);
		if (ObjectCensor.isStrRegular(StringUtil.getJSONObjectKeyVal(obj, "rows"))) {
			List list = JacksonJsonMapper.getInstance().readValue(obj.getString("rows"), List.class);
			String filePath = this.getFullFilePath(fileName);
			HttpClient client = new HttpClient();
			GetMethod httpGet = new GetMethod(filePath);
			client.executeMethod(httpGet);
			InputStream inputStream = httpGet.getResponseBodyAsStream();
			Map<String, List<Map>> beanParams = new HashMap<String, List<Map>>();
			beanParams.put("reportList", list);
			XLSTransformer former = new XLSTransformer();
			List<CellRangeAddress> cellRangeList = new ArrayList<CellRangeAddress>();
			HSSFWorkbook workBook = (HSSFWorkbook) former.transformXLS(inputStream, beanParams);
			HSSFSheet sheet = workBook.getSheetAt(0);
			JSONArray array = obj.getJSONArray("rows");
			if (ObjectCensor.checkListIsNull(array)) {
				boolean flag = false;
				int fr = 1, tr = 1;
				String value = StringUtil.getJSONObjectKeyVal(array.getJSONObject(0), mergeName);
				String[] indexArr = mergeIndex.split(",");
				for (int j = 1; j < array.size(); j++) {
					JSONObject item = array.getJSONObject(j);
					if (value.equals(StringUtil.getJSONObjectKeyVal(item, mergeName))) {
						flag = true;
						tr = j + 1;
						if (j == (array.size() - 1) && flag) {
							for (int m = 0; m < indexArr.length; m++) {
								int cIndex = Integer.valueOf(indexArr[m]);
								CellRangeAddress range1 = new CellRangeAddress(fr, tr, cIndex, cIndex);
								cellRangeList.add(range1);
							}
						}
					} else {
						if (flag) {
							for (int m = 0; m < indexArr.length; m++) {
								int cIndex = Integer.valueOf(indexArr[m]);
								CellRangeAddress range2 = new CellRangeAddress(fr, tr, cIndex, cIndex);
								cellRangeList.add(range2);
							}
							flag = false;
						}
						fr = j + 1;
						value = StringUtil.getJSONObjectKeyVal(item, mergeName);
					}
				}
			}
			for (CellRangeAddress cellRange : cellRangeList) {
				sheet.addMergedRegion(cellRange);
			}
			workBook.write(out);
			inputStream.close();
			out.close();
		}
	}
	
	public void refundStageOrReasonExport(String fileName, String mergeVerticalName, String mergeVerticalIndex, String param, 
			String funcNodeId, String mergeHorizontalIndex, String mergeHorizontalName, String mergeHorizontalCell, String mergeHorizontalVal, OutputStream out) throws Exception {
		String result = qryPubDataService.qryDataListByPage(null, null, param, funcNodeId);
		JSONObject obj = JSONObject.fromObject(result);
		if (ObjectCensor.isStrRegular(StringUtil.getJSONObjectKeyVal(obj, "rows"))) {
			List list = JacksonJsonMapper.getInstance().readValue(obj.getString("rows"), List.class);
			String filePath = this.getFullFilePath(fileName);
			HttpClient client = new HttpClient();
			GetMethod httpGet = new GetMethod(filePath);
			client.executeMethod(httpGet);
			InputStream inputStream = httpGet.getResponseBodyAsStream();
			Map<String, List<Map>> beanParams = new HashMap<String, List<Map>>();
			beanParams.put("reportList", list);
			XLSTransformer former = new XLSTransformer();
			List<CellRangeAddress> cellRangeList = new ArrayList<CellRangeAddress>();
			HSSFWorkbook workBook = (HSSFWorkbook) former.transformXLS(inputStream, beanParams);
			HSSFSheet sheet = workBook.getSheetAt(0);
			JSONArray array = obj.getJSONArray("rows");
			if (ObjectCensor.checkListIsNull(array)) {
				boolean flag = false;
				int fr = 1, tr = 1;
				String value = StringUtil.getJSONObjectKeyVal(array.getJSONObject(0), mergeVerticalName);
				String[] indexArr = mergeVerticalIndex.split(",");
				for (int j = 1; j < array.size(); j++) {
					JSONObject item = array.getJSONObject(j);
					if (value.equals(StringUtil.getJSONObjectKeyVal(item, mergeVerticalName))) {
						flag = true;
						tr = j + 1;
						if (j == (array.size() - 1) && flag) {
							for (int m = 0; m < indexArr.length; m++) {
								int cIndex = Integer.valueOf(indexArr[m]);
								CellRangeAddress range1 = new CellRangeAddress(fr, tr, cIndex, cIndex);
								cellRangeList.add(range1);
							}
						}
					} else {
						if (flag) {
							for (int m = 0; m < indexArr.length; m++) {
								int cIndex = Integer.valueOf(indexArr[m]);
								CellRangeAddress range2 = new CellRangeAddress(fr, tr, cIndex, cIndex);
								cellRangeList.add(range2);
							}
							flag = false;
						}
						fr = j + 1;
						value = StringUtil.getJSONObjectKeyVal(item, mergeVerticalName);
					}
					if (mergeHorizontalVal.equals(StringUtil.getJSONObjectKeyVal(item, mergeHorizontalName))) {
						int begion = Integer.parseInt(mergeHorizontalIndex);
						int end = begion + Integer.parseInt(mergeHorizontalCell);
						CellRangeAddress range2 = new CellRangeAddress(j + 1, j + 1, begion, end);
						cellRangeList.add(range2);
					}
				}
			}
			for (CellRangeAddress cellRange : cellRangeList) {
				sheet.addMergedRegion(cellRange);
			}
			workBook.write(out);
			inputStream.close();
			out.close();
		}
	}
	
	private String getFullFilePath(String fileName) throws Exception {
		String param = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1015\",securityCode:\"0000000000\",params:{paramType:\"UPLOAD_PATH\",paramValue:\"excel_model\"},rtnDataFormatType:\"user-defined\"}";
		String rstMsg = ServiceEngine.invokeHttp(param);
		JSONArray array = JSONArray.fromObject(rstMsg);
		if (ObjectCensor.checkListIsNull(array)) {
			JSONObject obj = array.getJSONObject(0);
			String path = StringUtil.getJSONObjectKeyVal(obj, "param1");
			String folderName = StringUtil.getJSONObjectKeyVal(obj, "param2");
			return path + folderName + URLEncoder.encode(fileName, "utf-8") + ".xls";
		} else {
			return null;
		}
	}
	
	public void exportCenterTeaFeedback(String fileName, String param, OutputStream out) throws Exception {
		String result = qryCenterTeaFeedback(param);
		JSONObject obj = JSONObject.fromObject(result);
		List list = JacksonJsonMapper.getInstance().readValue(obj.getString("rows"), List.class);
		String filePath = this.getFullFilePath(fileName);
		HttpClient client = new HttpClient();
		GetMethod httpGet = new GetMethod(filePath);
		client.executeMethod(httpGet);
		InputStream inputStream = httpGet.getResponseBodyAsStream();
		Map<String, List<Map>> beanParams = new HashMap<String, List<Map>>();
		beanParams.put("reportList", list);
		XLSTransformer former = new XLSTransformer();
		Workbook workBook = former.transformXLS(inputStream, beanParams);
		workBook.write(out);
		inputStream.close();
		out.close();
	}
	
	public void exportTeacherAttend(String fileName,String param,OutputStream out) throws Exception {
		JSONObject pjson =JSONObject.fromObject(param);
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS8201\",securityCode:\"0000000000\",params:{schoolId:'"+StringUtil.getJSONObjectKeyVal(pjson, "schoolId")+"',teacherId:'"+StringUtil.getJSONObjectKeyVal(pjson, "teacherId")+"',month:'"+StringUtil.getJSONObjectKeyVal(pjson, "month")+"'},rtnDataFormatType:\"user-defined\"}";
		JSONArray array = JSONArray.fromObject(ServiceEngine.invokeHttp(params));
		if (ObjectCensor.checkListIsNull(array)) {
			List list = JacksonJsonMapper.getInstance().readValue(array.toString(), List.class);
			String filePath = this.getFullFilePath(fileName);
			HttpClient client = new HttpClient();
			GetMethod httpGet = new GetMethod(filePath);
			client.executeMethod(httpGet);
			InputStream inputStream = httpGet.getResponseBodyAsStream();
			Map<String, List<Map>> beanParams = new HashMap<String, List<Map>>();
			beanParams.put("reportList", list);
			XLSTransformer former = new XLSTransformer();
			List<CellRangeAddress> cellRangeList = new ArrayList<CellRangeAddress>();
			HSSFWorkbook workBook = (HSSFWorkbook) former.transformXLS(inputStream, beanParams);
			HSSFSheet sheet = workBook.getSheetAt(0);
			if (ObjectCensor.checkListIsNull(array)) {
				boolean flag1 = false, flag2 = false;
				int fr1 = 2, tr1 = 2, fr2 = 2, tr2 = 2;
				String value1 = StringUtil.getJSONObjectKeyVal(array.getJSONObject(0), "schoolId");
				String value2 = StringUtil.getJSONObjectKeyVal(array.getJSONObject(0), "teacherId");
				for (int j = 1; j < array.size(); j++) {
					JSONObject item = array.getJSONObject(j);
					if (value1.equals(StringUtil.getJSONObjectKeyVal(item, "schoolId"))) {
						flag1 = true;
						tr1 = j + 2;
						if (j == (array.size() - 1) && flag1) {
							CellRangeAddress range1 = new CellRangeAddress(fr1, tr1, 0, 0);
							cellRangeList.add(range1);

						}
					} else {
						if (flag1) {
							CellRangeAddress range2 = new CellRangeAddress(fr1, tr1, 0, 0);
							cellRangeList.add(range2);
							flag1 = false;
						}
						fr1 = j + 2;
						value1 = StringUtil.getJSONObjectKeyVal(item, "schoolId");
					}
					if (value2.equals(StringUtil.getJSONObjectKeyVal(item, "teacherId"))) {
						flag2 = true;
						tr2 = j + 2;
						if (j == (array.size() - 1) && flag1) {
							CellRangeAddress range1 = new CellRangeAddress(fr2, tr2, 1, 1);
							cellRangeList.add(range1);
							range1 = new CellRangeAddress(fr2, tr2, 2, 2);
							cellRangeList.add(range1);
						}
					} else {
						if (flag2) {
							CellRangeAddress range1 = new CellRangeAddress(fr2, tr2, 1, 1);
							cellRangeList.add(range1);
							range1 = new CellRangeAddress(fr2, tr2, 2, 2);
							cellRangeList.add(range1);
							flag2 = false;
						}
						fr2 = j + 2;
						value2 = StringUtil.getJSONObjectKeyVal(item, "teacherId");
					}
				}
			}
			for (CellRangeAddress cellRange : cellRangeList) {
				sheet.addMergedRegion(cellRange);
			}
			workBook.write(out);
			inputStream.close();
			out.close();
		}
	}
	
	public void exportTeacherNum(String fileName,String param,OutputStream out) throws Exception {
		JSONObject pjson =JSONObject.fromObject(param);
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS8202\",securityCode:\"0000000000\",params:{schoolId:'"+StringUtil.getJSONObjectKeyVal(pjson, "schoolId")+"',teacherId:'"+StringUtil.getJSONObjectKeyVal(pjson, "teacherId")+"',month:'"+StringUtil.getJSONObjectKeyVal(pjson, "month")+"'},rtnDataFormatType:\"user-defined\"}";
		JSONArray array = JSONArray.fromObject(ServiceEngine.invokeHttp(params));
		if (ObjectCensor.checkListIsNull(array)) {
			List list = JacksonJsonMapper.getInstance().readValue(array.toString(), List.class);
			String filePath = this.getFullFilePath(fileName);
			HttpClient client = new HttpClient();
			GetMethod httpGet = new GetMethod(filePath);
			client.executeMethod(httpGet);
			InputStream inputStream = httpGet.getResponseBodyAsStream();
			Map<String, List<Map>> beanParams = new HashMap<String, List<Map>>();
			beanParams.put("reportList", list);
			XLSTransformer former = new XLSTransformer();
			List<CellRangeAddress> cellRangeList = new ArrayList<CellRangeAddress>();
			HSSFWorkbook workBook = (HSSFWorkbook) former.transformXLS(inputStream, beanParams);
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
	
	public void exportClassInstDetail(String fileName,String mergeName,String mergeIndex,String param,OutputStream out) throws Exception {
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS00710\",securityCode:\"0000000000\",params:{param:"+param+"},rtnDataFormatType:\"user-defined\"}";
		JSONArray array = JSONArray.fromObject(ServiceEngine.invokeHttp(params));
		if (ObjectCensor.checkListIsNull(array)) {
			List list = JacksonJsonMapper.getInstance().readValue(array.toString(), List.class);
			String filePath = this.getFullFilePath(fileName);
			HttpClient client = new HttpClient();
			GetMethod httpGet = new GetMethod(filePath);
			client.executeMethod(httpGet);
			InputStream inputStream = httpGet.getResponseBodyAsStream();
			Map<String, List<Map>> beanParams = new HashMap<String, List<Map>>();
			beanParams.put("reportList", list);
			XLSTransformer former = new XLSTransformer();
			List<CellRangeAddress> cellRangeList = new ArrayList<CellRangeAddress>();
			HSSFWorkbook workBook = (HSSFWorkbook) former.transformXLS(inputStream, beanParams);
			HSSFSheet sheet = workBook.getSheetAt(0);
			if (ObjectCensor.checkListIsNull(array)) {
				boolean flag = false;
				int fr = 1, tr = 1;
				String value = StringUtil.getJSONObjectKeyVal(array.getJSONObject(0), mergeName);
				String[] indexArr = mergeIndex.split(",");
				for (int j = 1; j < array.size(); j++) {
					JSONObject item = array.getJSONObject(j);
					if (value.equals(StringUtil.getJSONObjectKeyVal(item, mergeName))) {
						flag = true;
						tr = j + 1;
						if (j == (array.size() - 1) && flag) {
							for (int m = 0; m < indexArr.length; m++) {
								int cIndex = Integer.valueOf(indexArr[m]);
								CellRangeAddress range1 = new CellRangeAddress(fr, tr, cIndex, cIndex);
								cellRangeList.add(range1);
							}
						}
					} else {
						if (flag) {
							for (int m = 0; m < indexArr.length; m++) {
								int cIndex = Integer.valueOf(indexArr[m]);
								CellRangeAddress range2 = new CellRangeAddress(fr, tr, cIndex, cIndex);
								cellRangeList.add(range2);
							}
							flag = false;
						}
						fr = j + 1;
						value = StringUtil.getJSONObjectKeyVal(item, mergeName);
					}
				}
			}
			for (CellRangeAddress cellRange : cellRangeList) {
				sheet.addMergedRegion(cellRange);
			}
			for (int i = 1; i < sheet.getPhysicalNumberOfRows(); i++) {
				HSSFRow row = sheet.getRow(i);
				if (row != null) {
					int cells = row.getPhysicalNumberOfCells();
					for (int j = 0; j < cells; j++) {
						HSSFCell cell = row.getCell(j);
						if (cell != null && (HSSFCell.CELL_TYPE_STRING == cell.getCellType())) {
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
	
	public void exportSchoolMSGradRate(String fileName, String year, String param, String funcNodeId, OutputStream out) throws Exception {
		String result = qryPubDataService.qryDataListByPage(null, null, param, funcNodeId);
		JSONObject obj = JSONObject.fromObject(result);
		if (ObjectCensor.isStrRegular(StringUtil.getJSONObjectKeyVal(obj, "rows"))) {
			List list = JacksonJsonMapper.getInstance().readValue(obj.getString("rows"), List.class);
			String filePath = this.getFullFilePath(fileName);
			HttpClient client = new HttpClient();
			GetMethod httpGet = new GetMethod(filePath);
			client.executeMethod(httpGet);
			InputStream inputStream = httpGet.getResponseBodyAsStream();
			Map<String, List<Map>> beanParams = new HashMap<String, List<Map>>();
			beanParams.put("reportList", list);
			XLSTransformer former = new XLSTransformer();
			List<CellRangeAddress> cellRangeList = new ArrayList<CellRangeAddress>();
			HSSFWorkbook workBook = (HSSFWorkbook) former.transformXLS(inputStream, beanParams);
			HSSFSheet sheet = workBook.getSheetAt(0);
			sheet.getRow(0).getCell(0).setCellValue(year + "月度/季度升学率");
			JSONArray array = obj.getJSONArray("rows");
			if (ObjectCensor.checkListIsNull(array)) {
				boolean flag = false;
				int fr = 2, tr = 2;
				String value = StringUtil.getJSONObjectKeyVal(array.getJSONObject(0), "quarter");
				for (int j = 1; j < array.size(); j++) {
					JSONObject item = array.getJSONObject(j);
					if (value.equals(StringUtil.getJSONObjectKeyVal(item, "quarter"))) {
						flag = true;
						tr = j + 2;
						if (j == (array.size() - 1) && flag) {
							CellRangeAddress range1 = new CellRangeAddress(fr, tr, 4, 4);
							cellRangeList.add(range1);
						}
					} else {
						if (flag) {
							CellRangeAddress range2 = new CellRangeAddress(fr, tr, 4, 4);
							cellRangeList.add(range2);
							flag = false;
						}
						fr = j + 2;
						value = StringUtil.getJSONObjectKeyVal(item, "quarter");
					}
				}
			}
			for (CellRangeAddress cellRange : cellRangeList) {
				sheet.addMergedRegion(cellRange);
			}
			workBook.write(out);
			inputStream.close();
			out.close();
		}
	}
	
	public void exportCenterGradeRate(String fileName, String param, String funcNodeId, OutputStream out) throws Exception {
		String result = qryPubDataService.qryDataListByPage(null, null, param, funcNodeId);
		JSONObject obj = JSONObject.fromObject(result);
		if (ObjectCensor.isStrRegular(StringUtil.getJSONObjectKeyVal(obj, "rows"))) {
			List list = JacksonJsonMapper.getInstance().readValue(obj.getString("rows"), List.class);
			String filePath = this.getFullFilePath(fileName);
			HttpClient client = new HttpClient();
			GetMethod httpGet = new GetMethod(filePath);
			client.executeMethod(httpGet);
			InputStream inputStream = httpGet.getResponseBodyAsStream();
			Map<String, List<Map>> beanParams = new HashMap<String, List<Map>>();
			beanParams.put("reportList", list);
			XLSTransformer former = new XLSTransformer();
			List<CellRangeAddress> cellRangeList = new ArrayList<CellRangeAddress>();
			HSSFWorkbook workBook = (HSSFWorkbook) former.transformXLS(inputStream, beanParams);
			HSSFSheet sheet = workBook.getSheetAt(0);
			JSONArray array = obj.getJSONArray("rows");
			if (ObjectCensor.checkListIsNull(array)) {
				boolean flag = false;
				int fr = 2, tr = 2;
				String value = StringUtil.getJSONObjectKeyVal(array.getJSONObject(0), "schoolId");
				for (int j = 1; j < array.size(); j++) {
					JSONObject item = array.getJSONObject(j);
					if (value.equals(StringUtil.getJSONObjectKeyVal(item, "schoolId"))) {
						flag = true;
						tr = j + 2;
						if (j == (array.size() - 1) && flag) {
							CellRangeAddress range1 = new CellRangeAddress(fr, tr, 0, 0);
							cellRangeList.add(range1);
						}
					} else {
						if (flag) {
							CellRangeAddress range2 = new CellRangeAddress(fr, tr, 0, 0);
							cellRangeList.add(range2);
							flag = false;
						}
						fr = j + 2;
						value = StringUtil.getJSONObjectKeyVal(item, "schoolId");
					}
				}
			}
			for (CellRangeAddress cellRange : cellRangeList) {
				sheet.addMergedRegion(cellRange);
			}
			workBook.write(out);
			inputStream.close();
			out.close();
		}
	}
	
	public void exportCenterMSRate(String fileName, String year, String param, String funcNodeId, OutputStream out) throws Exception {
		String result = qryPubDataService.qryDataListByPage(null, null, param, funcNodeId);
		JSONObject obj = JSONObject.fromObject(result);
		if (ObjectCensor.isStrRegular(StringUtil.getJSONObjectKeyVal(obj, "rows"))) {
			List list = JacksonJsonMapper.getInstance().readValue(obj.getString("rows"), List.class);
			String filePath = this.getFullFilePath(fileName);
			HttpClient client = new HttpClient();
			GetMethod httpGet = new GetMethod(filePath);
			client.executeMethod(httpGet);
			InputStream inputStream = httpGet.getResponseBodyAsStream();
			Map<String, List<Map>> beanParams = new HashMap<String, List<Map>>();
			beanParams.put("reportList", list);
			XLSTransformer former = new XLSTransformer();
			List<CellRangeAddress> cellRangeList = new ArrayList<CellRangeAddress>();
			HSSFWorkbook workBook = (HSSFWorkbook) former.transformXLS(inputStream, beanParams);
			HSSFSheet sheet = workBook.getSheetAt(0);
			sheet.getRow(0).getCell(0).setCellValue(year + "月度/季度升学率");
			JSONArray array = obj.getJSONArray("rows");
			if (ObjectCensor.checkListIsNull(array)) {
				boolean flag1 = false, flag2 = false;
				int fr1 = 2, tr1 = 2, fr2 = 2, tr2 = 2;
				String value1 = StringUtil.getJSONObjectKeyVal(array.getJSONObject(0), "schoolId");
				String value2 = StringUtil.getJSONObjectKeyVal(array.getJSONObject(0), "quarter");
				for (int j = 1; j < array.size(); j++) {
					JSONObject item = array.getJSONObject(j);
					if (value1.equals(StringUtil.getJSONObjectKeyVal(item, "schoolId"))) {
						flag1 = true;
						tr1 = j + 2;
						if (j == (array.size() - 1) && flag1) {
							CellRangeAddress range1 = new CellRangeAddress(fr1, tr1, 0, 0);
							cellRangeList.add(range1);
						}
					} else {
						if (flag1) {
							CellRangeAddress range2 = new CellRangeAddress(fr1, tr1, 0, 0);
							cellRangeList.add(range2);
							flag1 = false;
						}
						fr1 = j + 2;
						value1 = StringUtil.getJSONObjectKeyVal(item, "schoolId");
					}
					if (value2.equals(StringUtil.getJSONObjectKeyVal(item, "quarter"))) {
						flag2 = true;
						tr2 = j + 2;
						if (j == (array.size() - 1) && flag1) {
							CellRangeAddress range1 = new CellRangeAddress(fr2, tr2, 5, 5);
							cellRangeList.add(range1);
						}
					} else {
						if (flag2) {
							CellRangeAddress range2 = new CellRangeAddress(fr2, tr2, 5, 5);
							cellRangeList.add(range2);
							flag2 = false;
						}
						fr2 = j + 2;
						value2 = StringUtil.getJSONObjectKeyVal(item, "quarter");
					}
				}
			}
			for (CellRangeAddress cellRange : cellRangeList) {
				sheet.addMergedRegion(cellRange);
			}
			workBook.write(out);
			inputStream.close();
			out.close();
		}
	}
	
	public void exportRegionGradRate(String fileName, String param, String funcNodeId, OutputStream out) throws Exception {
		String result = qryPubDataService.qryDataListByPage(null, null, param, funcNodeId);
		JSONObject obj = JSONObject.fromObject(result);
		if (ObjectCensor.isStrRegular(StringUtil.getJSONObjectKeyVal(obj, "rows"))) {
			List list = JacksonJsonMapper.getInstance().readValue(obj.getString("rows"), List.class);
			String filePath = this.getFullFilePath(fileName);
			HttpClient client = new HttpClient();
			GetMethod httpGet = new GetMethod(filePath);
			client.executeMethod(httpGet);
			InputStream inputStream = httpGet.getResponseBodyAsStream();
			Map<String, List<Map>> beanParams = new HashMap<String, List<Map>>();
			beanParams.put("reportList", list);
			XLSTransformer former = new XLSTransformer();
			List<CellRangeAddress> cellRangeList = new ArrayList<CellRangeAddress>();
			HSSFWorkbook workBook = (HSSFWorkbook) former.transformXLS(inputStream, beanParams);
			HSSFSheet sheet = workBook.getSheetAt(0);
			JSONArray array = obj.getJSONArray("rows");
			if (ObjectCensor.checkListIsNull(array)) {
				boolean flag1 = false, flag2 = false;
				int fr1 = 1, tr1 = 1, fr2 = 1, tr2 = 1;
				String value1 = StringUtil.getJSONObjectKeyVal(array.getJSONObject(0), "regionId");
				String value2 = StringUtil.getJSONObjectKeyVal(array.getJSONObject(0), "quarter");
				for (int j = 1; j < array.size(); j++) {
					JSONObject item = array.getJSONObject(j);
					if (value1.equals(StringUtil.getJSONObjectKeyVal(item, "regionId"))) {
						flag1 = true;
						tr1 = j + 1;
						if (j == (array.size() - 1) && flag1) {
							CellRangeAddress range1 = new CellRangeAddress(fr1, tr1, 0, 0);
							cellRangeList.add(range1);
						}
					} else {
						if (flag1) {
							CellRangeAddress range2 = new CellRangeAddress(fr1, tr1, 0, 0);
							cellRangeList.add(range2);
							flag1 = false;
						}
						fr1 = j + 1;
						value1 = StringUtil.getJSONObjectKeyVal(item, "regionId");
					}
					if (value2.equals(StringUtil.getJSONObjectKeyVal(item, "quarter"))) {
						flag2 = true;
						tr2 = j + 1;
						if (j == (array.size() - 1) && flag1) {
							CellRangeAddress range1 = new CellRangeAddress(fr2, tr2, 5, 5);
							cellRangeList.add(range1);

						}
					} else {
						if (flag2) {
							CellRangeAddress range2 = new CellRangeAddress(fr2, tr2, 5, 5);
							cellRangeList.add(range2);
							flag2 = false;
						}
						fr2 = j + 1;
						value2 = StringUtil.getJSONObjectKeyVal(item, "quarter");
					}
				}
			}
			for (CellRangeAddress cellRange : cellRangeList) {
				sheet.addMergedRegion(cellRange);
			}
			workBook.write(out);
			inputStream.close();
			out.close();
		}
	}
	
	public void exportExpClassDetai(String fileName, String param, String funcNodeId, OutputStream out) throws Exception {
		String result = qryPubDataService.qryDataListByPage(null, null, param, funcNodeId);
		JSONObject obj = JSONObject.fromObject(result);
		if (ObjectCensor.isStrRegular(StringUtil.getJSONObjectKeyVal(obj, "rows"))) {
			List list = JacksonJsonMapper.getInstance().readValue(obj.getString("rows"), List.class);
			String filePath = this.getFullFilePath(fileName);
			HttpClient client = new HttpClient();
			GetMethod httpGet = new GetMethod(filePath);
			client.executeMethod(httpGet);
			InputStream inputStream = httpGet.getResponseBodyAsStream();
			Map<String, List<Map>> beanParams = new HashMap<String, List<Map>>();
			beanParams.put("reportList", list);
			XLSTransformer former = new XLSTransformer();
			List<CellRangeAddress> cellRangeList = new ArrayList<CellRangeAddress>();
			HSSFWorkbook workBook = (HSSFWorkbook) former.transformXLS(inputStream, beanParams);
			HSSFSheet sheet = workBook.getSheetAt(0);
			JSONArray array = obj.getJSONArray("rows");
			if (ObjectCensor.checkListIsNull(array)) {
				boolean flag1 = false, flag2 = false;
				int fr1 = 2, tr1 = 2, fr2 = 2, tr2 = 2;
				String value1 = StringUtil.getJSONObjectKeyVal(array.getJSONObject(0), "schoolId");
				String value2 = StringUtil.getJSONObjectKeyVal(array.getJSONObject(0), "stageId");
				for (int j = 1; j < array.size(); j++) {
					JSONObject item = array.getJSONObject(j);
					if (value1.equals(StringUtil.getJSONObjectKeyVal(item, "schoolId"))) {
						flag1 = true;
						tr1 = j + 2;
						if (j == (array.size() - 1) && flag1) {
							CellRangeAddress range1 = new CellRangeAddress(fr1, tr1, 0, 0);
							cellRangeList.add(range1);
						}
					} else {
						if (flag1) {
							CellRangeAddress range2 = new CellRangeAddress(fr1, tr1, 0, 0);
							cellRangeList.add(range2);
							flag1 = false;
						}
						fr1 = j + 2;
						value1 = StringUtil.getJSONObjectKeyVal(item, "schoolId");
					}
					if (value2.equals(StringUtil.getJSONObjectKeyVal(item, "stageId"))) {
						flag2 = true;
						tr2 = j + 2;
						if (j == (array.size() - 1) && flag1) {
							CellRangeAddress range1 = new CellRangeAddress(fr2, tr2, 1, 1);
							cellRangeList.add(range1);
							range1 = new CellRangeAddress(fr2, tr2, 2, 2);
							cellRangeList.add(range1);
							range1 = new CellRangeAddress(fr2, tr2, 5, 5);
							cellRangeList.add(range1);
							range1 = new CellRangeAddress(fr2, tr2, 6, 6);
							cellRangeList.add(range1);
						}
					} else {
						if (flag2) {
							CellRangeAddress range2 = new CellRangeAddress(fr2, tr2, 1, 1);
							cellRangeList.add(range2);
							range2 = new CellRangeAddress(fr2, tr2, 2, 2);
							cellRangeList.add(range2);
							range2 = new CellRangeAddress(fr2, tr2, 5, 5);
							cellRangeList.add(range2);
							range2 = new CellRangeAddress(fr2, tr2, 6, 6);
							cellRangeList.add(range2);
							flag2 = false;
						}
						fr2 = j + 2;
						value2 = StringUtil.getJSONObjectKeyVal(item, "stageId");
					}
				}
			}
			for (CellRangeAddress cellRange : cellRangeList) {
				sheet.addMergedRegion(cellRange);
			}
			workBook.write(out);
			inputStream.close();
			out.close();
		}
	}
	
	public void exportTeacherHigherRate(String fileName, String param, String funcNodeId, OutputStream out) throws Exception {
		String result = qryPubDataService.qryDataListByPage(null, null, param, funcNodeId);
		JSONObject obj = JSONObject.fromObject(result);
		if (ObjectCensor.isStrRegular(StringUtil.getJSONObjectKeyVal(obj, "rows"))) {
			List list = JacksonJsonMapper.getInstance().readValue(obj.getString("rows"), List.class);
			String filePath = this.getFullFilePath(fileName);
			HttpClient client = new HttpClient();
			GetMethod httpGet = new GetMethod(filePath);
			client.executeMethod(httpGet);
			InputStream inputStream = httpGet.getResponseBodyAsStream();
			Map<String, List<Map>> beanParams = new HashMap<String, List<Map>>();
			beanParams.put("reportList", list);
			XLSTransformer former = new XLSTransformer();
			List<CellRangeAddress> cellRangeList = new ArrayList<CellRangeAddress>();
			HSSFWorkbook workBook = (HSSFWorkbook) former.transformXLS(inputStream, beanParams);
			HSSFSheet sheet = workBook.getSheetAt(0);
			JSONArray array = obj.getJSONArray("rows");
			if (ObjectCensor.checkListIsNull(array)) {
				boolean flag1 = false;
				int fr1 = 2, tr1 = 2;
				String value1 = StringUtil.getJSONObjectKeyVal(array.getJSONObject(0), "teacherId");
				for (int j = 1; j < array.size(); j++) {
					JSONObject item = array.getJSONObject(j);
					if (value1.equals(StringUtil.getJSONObjectKeyVal(item, "teacherId"))) {
						flag1 = true;
						tr1 = j + 2;
						if (j == (array.size() - 1) && flag1) {
							CellRangeAddress range1 = new CellRangeAddress(fr1, tr1, 0, 0);
							cellRangeList.add(range1);
						}
					} else {
						if (flag1) {
							CellRangeAddress range2 = new CellRangeAddress(fr1, tr1, 0, 0);
							cellRangeList.add(range2);
							flag1 = false;
						}
						fr1 = j + 2;
						value1 = StringUtil.getJSONObjectKeyVal(item, "teacherId");
					}
				}
			}
			for (CellRangeAddress cellRange : cellRangeList) {
				sheet.addMergedRegion(cellRange);
			}
			workBook.write(out);
			inputStream.close();
			out.close();
		}
	}
	
	public void exportUnfinishFeedback(String fileName, String param, OutputStream out) throws Exception {
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1019\",securityCode:\"0000000000\",params:{param:" + param + "},rtnDataFormatType:\"user-defined\"}";
		JSONObject json = JSONObject.fromObject(ServiceEngine.invokeHttp(params));
		if (ObjectCensor.isStrRegular(StringUtil.getJSONObjectKeyVal(json, "rows"))) {
			JSONArray array = json.getJSONArray("rows");
			if (ObjectCensor.checkListIsNull(array)) {
				List<CellRangeAddress> cellRangeList = new ArrayList<CellRangeAddress>();
				int fr1 = 1, tr1 = 1, fr2 = 1, tr2 = 1;
				boolean flag1 = false, flag2 = false;
				String schoolIndex = StringUtil.getJSONObjectKeyVal(array.getJSONObject(0), "schoolId"), classIndex = StringUtil.getJSONObjectKeyVal(array.getJSONObject(0), "classInstId");
				for (int j = 1; j < array.size(); j++) {
					JSONObject item = array.getJSONObject(j);
					if (schoolIndex.equals(StringUtil.getJSONObjectKeyVal(item, "schoolId"))) {
						flag1 = true;
						tr1 = j + 1;
						if (j == (array.size() - 1) && flag1) {
							CellRangeAddress range1 = new CellRangeAddress(fr1, tr1, 0, 0);
							cellRangeList.add(range1);
						}
					} else {
						if (flag1) {
							CellRangeAddress range1 = new CellRangeAddress(fr1, tr1, 0, 0);
							cellRangeList.add(range1);
							flag1 = false;
						}
						fr1 = j + 1;
						schoolIndex = StringUtil.getJSONObjectKeyVal(item, "schoolId");
					}
					if (classIndex.equals(StringUtil.getJSONObjectKeyVal(item, "classInstId"))) {
						flag2 = true;
						tr2 = j + 1;
						if (j == (array.size() - 1) && flag2) {
							CellRangeAddress range2 = new CellRangeAddress(fr2, tr2, 1, 1);
							CellRangeAddress range3 = new CellRangeAddress(fr2, tr2, 2, 2);
							cellRangeList.add(range2);
							cellRangeList.add(range3);
						}
					} else {
						if (flag2) {
							CellRangeAddress range2 = new CellRangeAddress(fr2, tr2, 1, 1);
							CellRangeAddress range3 = new CellRangeAddress(fr2, tr2, 2, 2);
							cellRangeList.add(range2);
							cellRangeList.add(range3);
							flag2 = false;
						}
						fr2 = j + 1;
						classIndex = StringUtil.getJSONObjectKeyVal(item, "classInstId");
					}
				}
				List list = JacksonJsonMapper.getInstance().readValue(array.toString(), List.class);
				String filePath = this.getFullFilePath(fileName);
				HttpClient client = new HttpClient();
				GetMethod httpGet = new GetMethod(filePath);
				client.executeMethod(httpGet);
				InputStream inputStream = httpGet.getResponseBodyAsStream();
				Map<String, List<Map>> beanParams = new HashMap<String, List<Map>>();
				beanParams.put("reportList", list);
				XLSTransformer former = new XLSTransformer();
				HSSFWorkbook workBook = (HSSFWorkbook) former.transformXLS(inputStream, beanParams);
				HSSFSheet sheet = workBook.getSheetAt(0);
				for (CellRangeAddress cellRange : cellRangeList) {
					sheet.addMergedRegion(cellRange);
				}
				workBook.write(out);
				inputStream.close();
				out.close();
			}

		}
	}
	
	public String qryCenterTeaFeedback(String param) throws Exception {
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1019\",securityCode:\"0000000000\",params:{param:" + param + "},rtnDataFormatType:\"user-defined\"}";
		JSONObject json = JSONObject.fromObject(ServiceEngine.invokeHttp(params));
		if (ObjectCensor.isStrRegular(StringUtil.getJSONObjectKeyVal(json, "rows"))) {
			JSONArray array = json.getJSONArray("rows");
			JSONArray newArray = new JSONArray();
			if (ObjectCensor.checkListIsNull(array)) {
				double[] total = new double[10];
				Arrays.fill(total, 0);
				BigDecimal[] per = new BigDecimal[9];
				Arrays.fill(per, new BigDecimal("0.00"));
				int[] count = new int[9];
				Arrays.fill(count, 0);
				String[] arr1 = new String[] { "classNum", "studentNum", "teachingNum", "oneNum", "planMeetingNum", "meetingNum", "planOpenNum", "openNum", "planGradNum", "gradNum" };
				String[] arr2 = new String[] { "teachingPer", "meetingPer", "openPer", "gradPer", "finishPer", "meetingCsi", "openCsi", "gradCsi", "csiPer" };
				for (int i = 0; i < array.size(); i++) {
					JSONObject item = array.getJSONObject(i);
					for (int j = 0; j < arr1.length; j++) {
						if (ObjectCensor.isStrRegular(StringUtil.getJSONObjectKeyVal(item, arr1[j]))) {
							total[j] += Double.valueOf(StringUtil.getJSONObjectKeyVal(item, arr1[j]));
						}
					}
					for (int k = 0; k < arr2.length; k++) {
						if (ObjectCensor.isStrRegular(StringUtil.getJSONObjectKeyVal(item, arr2[k]))) {
							per[k] = per[k].add(new BigDecimal(StringUtil.getJSONObjectKeyVal(item, arr2[k])));
							count[k] = count[k] + 1;
							item.put(arr2[k], StringUtil.getJSONObjectKeyVal(item, arr2[k]) + "%");
						}
					}
					newArray.add(item);
				}
				JSONObject tobj = new JSONObject();
				tobj.element("schoolName", "总计");
				for (int m = 0; m < arr1.length; m++) {
					tobj.element(arr1[m], total[m]);
				}
				for (int n = 0; n < arr2.length; n++) {
					if (count[n] > 0) {
						tobj.element(arr2[n], per[n].divide(new BigDecimal(count[n]), 2) + "%");
					} else {
						tobj.element(arr2[n], "");
					}
				}
				newArray.add(tobj);
				json.put("rows", newArray);
			}
		}
		return json.toString();
	}
	
	public String qryUnfinishFeedback(String param) throws Exception {
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS1019\",securityCode:\"0000000000\",params:{param:" + param + "},rtnDataFormatType:\"user-defined\"}";
		JSONObject json = JSONObject.fromObject(ServiceEngine.invokeHttp(params));
		if (ObjectCensor.isStrRegular(StringUtil.getJSONObjectKeyVal(json, "rows"))) {
			JSONArray array = json.getJSONArray("rows");
			JSONArray newArray = new JSONArray();
			if (ObjectCensor.checkListIsNull(array)) {
				for (int i = 0; i < array.size(); i++) {
					JSONObject obj = array.getJSONObject(i);
					if ("".equals(StringUtil.getJSONObjectKeyVal(obj, "isOpenFinish")) && "".equals(StringUtil.getJSONObjectKeyVal(obj, "isTeachingFinish"))
							&& "".equals(StringUtil.getJSONObjectKeyVal(obj, "isMeetingFinish")) && "".equals(StringUtil.getJSONObjectKeyVal(obj, "isGradFinish"))) {
						obj.element("type", "");
						obj.element("reason", "未开教质事件");
						newArray.add(obj);
					} else {
						if ("N".equals(StringUtil.getJSONObjectKeyVal(obj, "isTeachingFinish"))) {
							obj.element("type", "电教");
							obj.element("reason", "电教未完成");
							newArray.add(obj);
						}
						if ("N".equals(StringUtil.getJSONObjectKeyVal(obj, "isMeetingFinish"))) {
							obj.element("type", "家长会");
							obj.element("reason", "出勤未达80%");
							newArray.add(obj);
						}
						if ("N".equals(StringUtil.getJSONObjectKeyVal(obj, "isOpenFinish"))) {
							obj.element("type", "公开课");
							obj.element("reason", "出勤未达80%");
							newArray.add(obj);
						}
						if ("N".equals(StringUtil.getJSONObjectKeyVal(obj, "isGradFinish"))) {
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
	
	public HSSFWorkbook exportTeacherCourse(String param) throws Exception {
		JSONObject objs = JSONObject.fromObject(param);
		String schoolName = StringUtil.getJSONObjectKeyVal(objs, "schoolName");
		String month = StringUtil.getJSONObjectKeyVal(objs, "month");
		String weekName = StringUtil.getJSONObjectKeyVal(objs, "weekName");
		objs.remove("schoolName");
		objs.remove("weekName");
		String params = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS80017\",securityCode:\"0000000000\",params:{param:" + objs.toString() + "},rtnDataFormatType:\"user-defined\"}";
		String result = ServiceEngine.invokeHttp(params);
		JSONArray array = JSONArray.fromObject(result);
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFSheet sheet = wb.createSheet(schoolName + "-" + month + "-" + weekName);
		if (ObjectCensor.checkListIsNull(array)) {
			List<CellRangeAddress> cellRangeList = new ArrayList<CellRangeAddress>();
			HSSFCellStyle styleTitle = wb.createCellStyle();
			styleTitle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			styleTitle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
			HSSFFont fontTitle = wb.createFont();
			fontTitle.setFontName("黑体");
			fontTitle.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
			styleTitle.setFont(fontTitle);
			HSSFCellStyle styleContent = wb.createCellStyle();
			styleContent.setAlignment(HSSFCellStyle.ALIGN_CENTER);
			styleContent.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
			HSSFFont fontContent = wb.createFont();
			fontContent.setFontName("微软雅黑");
			styleContent.setFont(fontContent);
			HSSFRow row1 = sheet.createRow(0);
			HSSFRow row2 = sheet.createRow(1);
			HSSFCell tea = row1.createCell(0);
			tea.setCellValue("老师");
			tea.setCellStyle(styleTitle);
			HSSFCell time = row2.createCell(0);
			time.setCellValue("");
			time.setCellStyle(styleTitle);
			for (int j = 0; j < 5 * array.size(); j++) {
				HSSFCell cell1 = row1.createCell(j + 1);
				HSSFCell cell2 = row2.createCell(j + 1);
				sheet.setColumnWidth(j + 1, 6000);
				if (j % 5 == 0) {
					JSONObject obj1 = array.getJSONObject(j / 5).getJSONArray("rows").getJSONObject(0);
					cell1.setCellValue(StringUtil.getJSONObjectKeyVal(obj1, "schooltime") + "周(" + StringUtil.getJSONObjectKeyVal(obj1, "weekTime") + ")");
					cell1.setCellStyle(styleTitle);
					cell2.setCellValue("8:30");
					cell2.setCellStyle(styleTitle);
				} else if (j % 5 == 1) {
					cell2.setCellValue("10:30");
					cell2.setCellStyle(styleTitle);
				} else if (j % 5 == 2) {
					cell2.setCellValue("14:00");
					cell2.setCellStyle(styleTitle);
				} else if (j % 5 == 3) {
					cell2.setCellValue("16:00");
					cell2.setCellStyle(styleTitle);
				} else if (j % 5 == 4) {
					cell2.setCellValue("18:30");
					cell2.setCellStyle(styleTitle);
				}
			}
			for (int k = 0; k < array.size(); k++) {
				cellRangeList.add(new CellRangeAddress(0, 0, k * 5 + 1, (k + 1) * 5));
			}
			JSONArray teacher = array.getJSONObject(0).getJSONArray("rows");
			for (int i = 0; i < teacher.size(); i++) {
				HSSFRow row = sheet.createRow(i + 2);
				HSSFCell cells = row.createCell(0);
				cells.setCellValue(StringUtil.getJSONObjectKeyVal(teacher.getJSONObject(i), "teacherName"));
				cells.setCellStyle(styleContent);
				for (int e = 1; e <= array.size() * 5; e++) {
					row.createCell(e);
				}
			}
			for (int m = 0; m < array.size(); m++) {
				JSONArray array1 = array.getJSONObject(m).getJSONArray("rows");
				for (int n = 2; n < array1.size() + 2; n++) {
					JSONObject content = array1.getJSONObject(n - 2);
					JSONArray indexArr = getTimeIndex(content);
					for (int l = 0; l < indexArr.size(); l++) {
						JSONObject indexObj = indexArr.getJSONObject(l);
						int index = Integer.valueOf(indexObj.getString("index"));
						String value = indexObj.getString("value");
						HSSFCell cell = sheet.getRow(n).getCell(m * 5 + index);
						cell.setCellValue(value);
						if (ObjectCensor.isStrRegular(StringUtil.getJSONObjectKeyVal(indexObj, "merge"))) {
							int merge = Integer.valueOf(indexObj.getString("merge"));
							if (merge > 1) {
								merge -= 1;
								cellRangeList.add(new CellRangeAddress(n, n, m * 5 + index, m * 5 + index + merge));
							}
						}
					}
				}
			}
			for (CellRangeAddress cellRange : cellRangeList) {
				sheet.addMergedRegion(cellRange);
			}
		}
		return wb;
	}
	
	private JSONArray getTimeIndex(JSONObject json) throws Exception {
		JSONArray array = new JSONArray();
		JSONArray keyArr = new JSONArray();
		Iterator it = json.keys();
		while (it.hasNext()) {
			String key = it.next().toString();
			String value = json.getString(key);
			JSONObject obj = new JSONObject();
			obj.put(key, value);
			keyArr.add(obj);
		}
		for (int i = 0; i < keyArr.size(); i++) {
			JSONObject keyObj1 = keyArr.getJSONObject(i);
			Iterator it1 = keyObj1.keys();
			String objKey1 = it1.next().toString();
			for (int j = 1; j < 6; j++) {
				if (("H00" + j).equals(objKey1)) {
					JSONObject indexObj = new JSONObject();
					indexObj.put("index", j);
					indexObj.put("value", keyObj1.getString("H00" + j));
					for (int k = 0; k < keyArr.size(); k++) {
						JSONObject keyObj2 = keyArr.getJSONObject(k);
						Iterator it2 = keyObj2.keys();
						String objKey = it2.next().toString();
						if (objKey.indexOf("merge00" + j) != -1) {
							indexObj.put("merge", StringUtil.getJSONObjectKeyVal(keyObj2, objKey));
						}
					}
					array.add(indexObj);
				}
			}
		}
		return array;
	}
	
	public HSSFWorkbook exportClassroomCourse(String param) throws Exception {
		JSONObject objs = JSONObject.fromObject(param);
		String schoolName = StringUtil.getJSONObjectKeyVal(objs, "schoolName");
		String schoolId = StringUtil.getJSONObjectKeyVal(objs, "schoolId");
		String param1 = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS8009\",securityCode:\"0000000000\",params:{schoolId:" + schoolId + "},rtnDataFormatType:\"user-defined\"}";
		String result1 = ServiceEngine.invokeHttp(param1);
		JSONArray array1 = JSONArray.fromObject(result1);
		String param2 = "{channel:\"Q\",channelType:\"PC\",serviceType:\"BUS80010\",securityCode:\"0000000000\",params:{schoolId:" + schoolId + "},rtnDataFormatType:\"user-defined\"}";
		String result2 = ServiceEngine.invokeHttp(param2);
		JSONArray array2 = JSONArray.fromObject(result2);
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFCellStyle styleTitle = wb.createCellStyle();
		styleTitle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		styleTitle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		HSSFFont fontTitle = wb.createFont();
		fontTitle.setFontName("黑体");
		fontTitle.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		styleTitle.setFont(fontTitle);
		HSSFCellStyle styleContent = wb.createCellStyle();
		styleContent.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		styleContent.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		HSSFFont fontContent = wb.createFont();
		fontContent.setFontName("微软雅黑");
		styleContent.setFont(fontContent);
		HSSFSheet sheet1 = wb.createSheet(schoolName + "-班级情况和教室资源统计表");
		HSSFSheet sheet2 = wb.createSheet(schoolName + "-教师资源统计表");
		if (ObjectCensor.checkListIsNull(array1)) {
			sheet1.setColumnWidth(0, 6000);
			List<CellRangeAddress> cellRangeList1 = new ArrayList<CellRangeAddress>();
			HSSFRow row1 = sheet1.createRow(0);
			HSSFRow row2 = sheet1.createRow(1);
			HSSFCell tea = row1.createCell(0);
			tea.setCellValue("教室");
			tea.setCellStyle(styleTitle);
			HSSFCell time = row2.createCell(0);
			time.setCellValue("");
			time.setCellStyle(styleTitle);
			for (int j = 0; j < 5 * array1.size(); j++) {
				sheet1.setColumnWidth(j + 1, 6000);
				HSSFCell cell1 = row1.createCell(j + 1);
				HSSFCell cell2 = row2.createCell(j + 1);
				sheet1.setColumnWidth(j + 1, 6000);
				if (j % 5 == 0) {
					JSONObject obj1 = array1.getJSONObject(j / 5).getJSONArray("rows").getJSONObject(0);
					cell1.setCellValue("周" + StringUtil.getJSONObjectKeyVal(obj1, "weekTime"));
					cell1.setCellStyle(styleTitle);
					cell2.setCellValue("上午1");
					cell2.setCellStyle(styleTitle);
				} else if (j % 5 == 1) {
					cell2.setCellValue("上午2");
					cell2.setCellStyle(styleTitle);
				} else if (j % 5 == 2) {
					cell2.setCellValue("下午1");
					cell2.setCellStyle(styleTitle);
				} else if (j % 5 == 3) {
					cell2.setCellValue("下午2");
					cell2.setCellStyle(styleTitle);
				} else if (j % 5 == 4) {
					cell2.setCellValue("晚上");
					cell2.setCellStyle(styleTitle);
				}
			}
			for (int k = 0; k < array1.size(); k++) {
				cellRangeList1.add(new CellRangeAddress(0, 0, k * 5 + 1, (k + 1) * 5));
			}
			JSONArray room = array1.getJSONObject(0).getJSONArray("rows");
			for (int i = 0; i < room.size(); i++) {
				HSSFRow row = sheet1.createRow(i + 2);
				HSSFCell cells = row.createCell(0);
				cells.setCellValue(StringUtil.getJSONObjectKeyVal(room.getJSONObject(i), "roomName"));
				cells.setCellStyle(styleContent);
				for (int e = 1; e <= array1.size() * 5; e++) {
					row.createCell(e);
				}
			}
			for (int m = 0; m < array1.size(); m++) {
				JSONArray arrays = array1.getJSONObject(m).getJSONArray("rows");
				for (int n = 2; n < arrays.size() + 2; n++) {
					JSONObject content = arrays.getJSONObject(n - 2);
					JSONArray indexArr = getTimeIndex(content);
					for (int l = 0; l < indexArr.size(); l++) {
						JSONObject indexObj = indexArr.getJSONObject(l);
						int index = Integer.valueOf(indexObj.getString("index"));
						String value = indexObj.getString("value");
						HSSFCell cell = sheet1.getRow(n).getCell(m * 5 + index);
						cell.setCellValue(value);
						cell.setCellStyle(styleContent);
						if (ObjectCensor.isStrRegular(StringUtil.getJSONObjectKeyVal(indexObj, "merge"))) {
							int merge = Integer.valueOf(indexObj.getString("merge"));
							if (merge > 1) {
								merge -= 1;
								cellRangeList1.add(new CellRangeAddress(n, n, m * 5 + index, m * 5 + index + merge));
							}
						}
					}
				}
			}
			for (CellRangeAddress cellRange : cellRangeList1) {
				sheet1.addMergedRegion(cellRange);
			}
		}
		if (ObjectCensor.checkListIsNull(array2)) {
			sheet2.setColumnWidth(0, 6000);
			List<CellRangeAddress> cellRangeList2 = new ArrayList<CellRangeAddress>();
			HSSFRow row11 = sheet2.createRow(0);
			HSSFRow row22 = sheet2.createRow(1);
			HSSFCell teaa = row11.createCell(0);
			teaa.setCellValue("老师");
			teaa.setCellStyle(styleTitle);
			HSSFCell timee = row22.createCell(0);
			timee.setCellValue("");
			timee.setCellStyle(styleTitle);
			for (int o = 0; o < 5 * array2.size(); o++) {
				HSSFCell cell11 = row11.createCell(o + 1);
				HSSFCell cell22 = row22.createCell(o + 1);
				sheet2.setColumnWidth(o + 1, 6000);
				if (o % 5 == 0) {
					JSONObject obj11 = array2.getJSONObject(o / 5).getJSONArray("rows").getJSONObject(0);
					cell11.setCellValue("周" + StringUtil.getJSONObjectKeyVal(obj11, "weekTime"));
					cell11.setCellStyle(styleTitle);
					cell22.setCellValue("上午1");
					cell22.setCellStyle(styleTitle);
				} else if (o % 5 == 1) {
					cell22.setCellValue("上午2");
					cell22.setCellStyle(styleTitle);
				} else if (o % 5 == 2) {
					cell22.setCellValue("下午1");
					cell22.setCellStyle(styleTitle);
				} else if (o % 5 == 3) {
					cell22.setCellValue("下午2");
					cell22.setCellStyle(styleTitle);
				} else if (o % 5 == 4) {
					cell22.setCellValue("晚上");
					cell22.setCellStyle(styleTitle);
				}
			}
			for (int p = 0; p < array2.size(); p++) {
				sheet2.setColumnWidth(p + 1, 6000);
				cellRangeList2.add(new CellRangeAddress(0, 0, p * 5 + 1, (p + 1) * 5));
			}
			JSONArray teachers = array2.getJSONObject(0).getJSONArray("rows");
			for (int q = 0; q < teachers.size(); q++) {
				HSSFRow roww = sheet2.createRow(q + 2);
				HSSFCell cellss = roww.createCell(0);
				cellss.setCellValue(StringUtil.getJSONObjectKeyVal(teachers.getJSONObject(q), "teacherName"));
				cellss.setCellStyle(styleContent);
				for (int r = 1; r <= array2.size() * 5; r++) {
					roww.createCell(r);
				}
			}
			for (int s = 0; s < array2.size(); s++) {
				JSONArray arrayss = array2.getJSONObject(s).getJSONArray("rows");
				for (int x = 2; x < arrayss.size() + 2; x++) {
					JSONObject contentt = arrayss.getJSONObject(x - 2);
					JSONArray indexArrs = getTimeIndex(contentt);
					for (int t = 0; t < indexArrs.size(); t++) {
						JSONObject indexObjs = indexArrs.getJSONObject(t);
						int indexs = Integer.valueOf(indexObjs.getString("index"));
						String value = indexObjs.getString("value");
						HSSFCell cell = sheet2.getRow(x).getCell(s * 5 + indexs);
						cell.setCellValue(value);
						cell.setCellStyle(styleContent);
						if (ObjectCensor.isStrRegular(StringUtil.getJSONObjectKeyVal(indexObjs, "merge"))) {
							int merges = Integer.valueOf(indexObjs.getString("merge"));
							if (merges > 1) {
								merges -= 1;
								cellRangeList2.add(new CellRangeAddress(x, x, s * 5 + indexs, s * 5 + indexs + merges));
							}
						}
					}
				}
			}
			for (CellRangeAddress cellRange : cellRangeList2) {
				sheet2.addMergedRegion(cellRange);
			}
		}
		return wb;
	}
	
	public HSSFWorkbook exportTeacherInfo(String param) throws Exception {
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFCellStyle styleTitle = wb.createCellStyle();
		styleTitle.setFillBackgroundColor(HSSFColor.GOLD.index);
		styleTitle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		styleTitle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		HSSFFont fontTitle = wb.createFont();
		fontTitle.setColor(HSSFFont.COLOR_RED);
		fontTitle.setFontName("黑体");
		fontTitle.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		styleTitle.setFont(fontTitle);
		HSSFCellStyle styleContent = wb.createCellStyle();
		styleContent.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		styleContent.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		HSSFFont fontContent = wb.createFont();
		fontContent.setFontName("微软雅黑");
		styleContent.setFont(fontContent);
		HSSFSheet sheet = wb.createSheet("教师档案");
		JSONArray array = JSONArray.fromObject(param);
		if (array.size() > 2) {
			List<CellRangeAddress> cellRangeList = new ArrayList<CellRangeAddress>();
			JSONArray column0 = array.getJSONArray(0);
			JSONArray column1 = array.getJSONArray(1);
			HSSFRow row0 = sheet.createRow(0);
			HSSFRow row1 = sheet.createRow(1);
			int headIndex = 0;
			for (int i = 0; i < column1.size(); i++) {
				JSONObject colObj1 = column1.getJSONObject(i);
				HSSFCell cell0 = row0.createCell(i);
				HSSFCell cell1 = row1.createCell(i);
				cell0.setCellStyle(styleTitle);
				cell1.setCellStyle(styleTitle);
				cell1.setCellValue(StringUtil.getJSONObjectKeyVal(colObj1, "text"));
				sheet.setColumnWidth(i, 6000);
			}
			for (int j = 0; j < column0.size(); j++) {
				JSONObject colObj0 = column0.getJSONObject(j);
				row0.getCell(headIndex).setCellValue(StringUtil.getJSONObjectKeyVal(colObj0, "text"));
				String colspan = StringUtil.getJSONObjectKeyVal(colObj0, "colspan");
				if (ObjectCensor.isStrRegular(colspan)) {
					cellRangeList.add(new CellRangeAddress(0, 0, headIndex, headIndex + Integer.valueOf(colspan) - 1));
					headIndex += Integer.valueOf(colspan);
				} else {
					headIndex++;
				}
			}
			for (int k = 2; k < array.size(); k++) {
				HSSFRow row = sheet.createRow(k);
				JSONArray arr = array.getJSONArray(k);
				for (int l = 0; l < column1.size(); l++) {
					JSONObject cellObj = arr.getJSONObject(l);
					HSSFCell cell = row.createCell(l);
					cell.setCellStyle(styleContent);
					cell.setCellValue(StringUtil.getJSONObjectKeyVal(cellObj, "text"));
					String colspan = StringUtil.getJSONObjectKeyVal(cellObj, "colspan");
					if (ObjectCensor.isStrRegular(colspan)) {
						cellRangeList.add(new CellRangeAddress(k, k, l, l + Integer.valueOf(colspan) - 1));
					}
				}
			}
			for (CellRangeAddress cellRange : cellRangeList) {
				sheet.addMergedRegion(cellRange);
			}
		}
		return wb;
	}
	
	public HSSFWorkbook exportPageInfo(JSONObject json) throws Exception {
		HSSFWorkbook wb = new HSSFWorkbook();
		HSSFCellStyle styleTitle = wb.createCellStyle();
		styleTitle.setFillBackgroundColor(HSSFColor.GOLD.index);
		styleTitle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		styleTitle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		HSSFFont fontTitle = wb.createFont();
		fontTitle.setColor(HSSFFont.COLOR_RED);
		fontTitle.setFontName("黑体");
		fontTitle.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);
		styleTitle.setFont(fontTitle);
		HSSFCellStyle styleContent = wb.createCellStyle();
		styleContent.setWrapText(true);
		styleContent.setAlignment(HSSFCellStyle.ALIGN_CENTER);
		styleContent.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
		HSSFFont fontContent = wb.createFont();
		fontContent.setFontName("微软雅黑");
		styleContent.setFont(fontContent);
		HSSFSheet sheet = wb.createSheet(StringUtil.getJSONObjectKeyVal(json, "name"));
		JSONArray columnArr = json.getJSONArray("cloumn");
		JSONArray dataArr = json.getJSONArray("data");
		if (columnArr.size() > 0 && dataArr.size() > 0) {
			HSSFRow row0 = sheet.createRow(0);
			for (int i = 0; i < columnArr.size(); i++) {
				JSONObject columnObj = columnArr.getJSONObject(i);
				HSSFCell cell0 = row0.createCell(i);
				cell0.setCellStyle(styleTitle);
				cell0.setCellValue(StringUtil.getJSONObjectKeyVal(columnObj, (i + 1 + "")));
				sheet.setColumnWidth(i, 6000);
			}
			for (int k = 1; k < dataArr.size(); k++) {
				HSSFRow row = sheet.createRow(k);
				JSONObject dataObj = dataArr.getJSONObject(k - 1);
				for (int l = 0; l < columnArr.size(); l++) {
					HSSFCell cell = row.createCell(l);
					cell.setCellStyle(styleContent);
					String value = StringUtil.getJSONObjectKeyVal(dataObj, (l + 1 + ""));
					value = value.replaceAll("<(/)?br(/)?>", "\r\n ");
					cell.setCellValue(new HSSFRichTextString(value));
				}
			}
		}
		return wb;
	}
	
	
	public void exportServiceRate(String fileName, String array, OutputStream out) throws Exception {
		JSONArray jarray = JSONArray.fromObject(array);
		List list = JacksonJsonMapper.getInstance().readValue(array, List.class);
		String filePath = this.getFullFilePath(fileName);
		HttpClient client = new HttpClient();
		GetMethod httpGet = new GetMethod(filePath);
		client.executeMethod(httpGet);
		InputStream inputStream = httpGet.getResponseBodyAsStream();
		Map<String, List<Map>> beanParams = new HashMap<String, List<Map>>();
		beanParams.put("reportList", list);
		XLSTransformer former = new XLSTransformer();
		HSSFWorkbook workBook = (HSSFWorkbook) former.transformXLS(inputStream, beanParams);
		HSSFSheet sheet = workBook.getSheetAt(0);
		int rowNum = jarray.size();
		HSSFCellStyle styleRed = workBook.createCellStyle();
		HSSFFont fontContent = workBook.createFont();
		fontContent.setColor(HSSFFont.COLOR_RED);
		styleRed.setFont(fontContent);
		for (int i = 1; i <= rowNum; i++) {
			HSSFCell cell = sheet.getRow(i).getCell(19);
			double value = Double.valueOf(cell.getStringCellValue());
			if (value < 0) {
				cell.setCellStyle(styleRed);
				cell.setCellValue("（" + (-value) + "）");
			}
		}
		workBook.write(out);
		inputStream.close();
		out.close();
	}
	
	
	public void exportDataInModel(String fileName, String mergeName, String mergeIndex, String param, OutputStream out) throws Exception {
		JSONArray array = JSONArray.fromObject(param);
		if (ObjectCensor.checkListIsNull(array)) {
			List list = JacksonJsonMapper.getInstance().readValue(param, List.class);
			String filePath = this.getFullFilePath(fileName);
			HttpClient client = new HttpClient();
			GetMethod httpGet = new GetMethod(filePath);
			client.executeMethod(httpGet);
			InputStream inputStream = httpGet.getResponseBodyAsStream();
			Map<String, List<Map>> beanParams = new HashMap<String, List<Map>>();
			beanParams.put("reportList", list);
			XLSTransformer former = new XLSTransformer();
			List<CellRangeAddress> cellRangeList = new ArrayList<CellRangeAddress>();
			HSSFWorkbook workBook = (HSSFWorkbook) former.transformXLS(inputStream, beanParams);
			HSSFSheet sheet = workBook.getSheetAt(0);
			if (array.size() > 0) {
				int mindex = Integer.valueOf(mergeIndex);
				boolean flag = false;
				int fr = 2, tr = 2;
				String value = StringUtil.getJSONObjectKeyVal(array.getJSONObject(0), mergeName);
				for (int j = 1; j < array.size(); j++) {
					JSONObject item = array.getJSONObject(j);
					if (value.equals(StringUtil.getJSONObjectKeyVal(item, mergeName))) {
						flag = true;
						tr = j + 2;
						if (j == (array.size() - 1) && flag) {
							CellRangeAddress range1 = new CellRangeAddress(fr, tr, mindex, mindex);
							cellRangeList.add(range1);
						}
					} else {
						if (flag) {
							CellRangeAddress range2 = new CellRangeAddress(fr, tr, mindex, mindex);
							cellRangeList.add(range2);
							flag = false;
						}
						fr = j + 2;
						value = StringUtil.getJSONObjectKeyVal(item, mergeName);
					}
				}
			}
			for (CellRangeAddress cellRange : cellRangeList) {
				sheet.addMergedRegion(cellRange);
			}
			workBook.write(out);
			inputStream.close();
			out.close();
		}
	}
}