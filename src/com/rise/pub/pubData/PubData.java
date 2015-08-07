package com.rise.pub.pubData;

import java.util.List;

import net.sf.json.JSONArray;

import org.springframework.beans.factory.BeanFactory;

import com.rise.pub.base.JacksonJsonMapper;
import com.rise.pub.cache.CacheManager;
import com.rise.pub.util.BeanFactoryHelper;

public class PubData 
{
	public static List qryConfigInfo(String codeType, String codeFlag) throws Exception 
	{
		BeanFactory beanFactory = BeanFactoryHelper.getBeanfactory();
		CacheManager signService = (CacheManager) beanFactory.getBean("cacheManager");
		JSONArray json = signService.qryConfigInfo(codeType, codeFlag);
		List list = JacksonJsonMapper.getInstance().readValue(json.toString(), List.class);
		return list;
	}

	public static List qryBusiCapaTypeInfo() throws Exception 
	{
		BeanFactory beanFactory = BeanFactoryHelper.getBeanfactory();
		CacheManager signService = (CacheManager) beanFactory.getBean("cacheManager");
		JSONArray json = signService.qryBusiCapaTypeInfo();
		List list = JacksonJsonMapper.getInstance().readValue(json.toString(), List.class);
		return list;
	}

	public static JSONArray qryBusiCapaTypeLevel() throws Exception 
	{
		BeanFactory beanFactory = BeanFactoryHelper.getBeanfactory();
		CacheManager signService = (CacheManager) beanFactory.getBean("cacheManager");
		return signService.qryBusiCapaTypeLevel();
	}
}
