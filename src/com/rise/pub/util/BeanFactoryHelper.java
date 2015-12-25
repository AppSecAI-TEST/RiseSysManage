package com.rise.pub.util;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.BeanFactoryAware;

public class BeanFactoryHelper implements BeanFactoryAware
{
	private static BeanFactory beanFactory ; 
	
	private BeanFactoryHelper(){}
	
	public void setBeanFactory(BeanFactory beanFactory) throws BeansException
	{
		this.beanFactory = beanFactory;
	}

	public static BeanFactory getBeanfactory()
	{
		return beanFactory;
	}
	
	public static Object getBean(String serviceName)
	{
		if(beanFactory == null)
		{
			getBeanfactory();
		}
		return beanFactory.getBean(serviceName);
	}
}
