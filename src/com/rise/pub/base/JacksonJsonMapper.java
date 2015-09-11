package com.rise.pub.base;

import com.fasterxml.jackson.databind.ObjectMapper;

public class JacksonJsonMapper 
{
    private static volatile ObjectMapper objectMapper = null;

    private JacksonJsonMapper(){}

    public static ObjectMapper getInstance()
    {
	if (objectMapper == null)
	{
	    synchronized (ObjectMapper.class) 
	    {
		if (objectMapper==null)
		{
		    objectMapper = new ObjectMapper();
		}
	    }
	}
	return objectMapper;
    }
}
