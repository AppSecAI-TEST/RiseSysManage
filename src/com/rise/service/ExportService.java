package com.rise.service;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.jxls.transformer.XLSTransformer;

import org.apache.commons.httpclient.HttpClient;
import org.apache.commons.httpclient.methods.GetMethod;
import org.apache.http.HttpResponse;
import org.apache.poi.ss.usermodel.Workbook;
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
	
}

