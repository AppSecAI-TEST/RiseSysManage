package com.rise.pub.util;

import org.springframework.beans.BeansException;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.BeanFactoryAware;

public class BeanFactoryHelper implements BeanFactoryAware
{
	private static BeanFactory beanFactory; //BEAN¹¤³§
	
	public void setBeanFactory(BeanFactory f) throws BeansException
	{
		this.beanFactory = f;
	}

	public static BeanFactory getBeanfactory()
	{
		return beanFactory;
	}

}
