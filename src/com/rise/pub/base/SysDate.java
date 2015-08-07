package com.rise.pub.base;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;
import java.sql.Timestamp;

/**
 * 
 */
public final class SysDate 
{
//    private static SysDate sysDate = new SysDate();
    /**
     * 获取系统日期时间
     * 
     * @throws ParseException
     */
    public static Timestamp getSysDate() 
    {
	Date date = Calendar.getInstance().getTime();
	return getFormatSimpleDate(new Timestamp(date.getTime()));
    }

    public static Timestamp getFormatSimpleDate(Date date) 
    {

	String format = "yyyy-MM-dd hh:mm:ss";
	SimpleDateFormat df = new SimpleDateFormat(format);
	String dateT = df.format(date);
	try 
	{
	    return new Timestamp(df.parse(dateT).getTime());
	} 
	catch (ParseException e)
	{
	    e.printStackTrace();
	}
	return null;
    }

    public static Timestamp getSysDate(String dateStr) 
    {
	String format = "yyyy-MM-dd hh:mm:ss";
	SimpleDateFormat df = new SimpleDateFormat(format);

	try 
	{
	    return new Timestamp(df.parse(dateStr).getTime());
	}
	catch (ParseException e) 
	{
	    e.printStackTrace();
	}
	return null;
    }
    
    public static String getDate()
    {
	Date date = Calendar.getInstance().getTime();
	return getFormatDate(new Timestamp(date.getTime()));
    }

    public static String getFormatDate(Date date) 
    {
	String format = "yy-MM-dd";
	SimpleDateFormat df = new SimpleDateFormat(format);
	String dateT = df.format(date);
	return dateT;
    }
}
