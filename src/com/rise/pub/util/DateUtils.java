package com.rise.pub.util;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics2D;
import java.awt.font.FontRenderContext;
import java.awt.geom.Rectangle2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.imageio.ImageIO;

import net.sf.json.JSONObject;

import com.rise.pub.base.SysDate;

public class DateUtils {
	private int year;
	private int month;
	private int day;
	private int hour;
	private int minute;
	private int second;
	private int week;
	private static final int[] dayArray = { 31, 28, 31, 30, 31, 30, 31, 31, 30,
			31, 30, 31 };

	public static final SimpleDateFormat DATE_FORMAT = new SimpleDateFormat(
			"MM/dd/yyyy");

	public static final SimpleDateFormat DATE_YEAR_MONTH_FORMAT = new SimpleDateFormat(
			"yyyy-MM");

	public static final SimpleDateFormat DATE_TIME_FORMAT = new SimpleDateFormat(
			"MM/dd/yyyy HH:mm");

	public static final SimpleDateFormat DATE_TIME_EXTENDED_FORMAT = new SimpleDateFormat(
			"MM/dd/yyyy HH:mm:ss");

	public static final SimpleDateFormat ORA_DATE_FORMAT = new SimpleDateFormat(
			"yyyyMMdd");

	public static final SimpleDateFormat ORA_DATE_TIME_FORMAT = new SimpleDateFormat(
			"yyyyMMddHHmm");

	public static final SimpleDateFormat ORA_DATE_TIME_EXTENDED_FORMAT = new SimpleDateFormat(
			"yyyyMMddHHmmss");

	public static final SimpleDateFormat CHN_DATE_FORMAT = new SimpleDateFormat(
			"yyyy-MM-dd");

	public static final SimpleDateFormat CHN_DATE_TIME_FORMAT = new SimpleDateFormat(
			"yyyy-MM-dd HH:mm");

	public static final SimpleDateFormat CHN_DATE_TIME_EXTENDED_FORMAT = new SimpleDateFormat(
			"yyyy-MM-dd HH:mm:ss");

	public static final SimpleDateFormat CHN_DATE_TIME_SHORT_EXTENDED_FORMAT = new SimpleDateFormat(
			"HH:mm:ss");
	
	public static final SimpleDateFormat CHN_DATE_TIME_SHORT_EXTENDED_FORMAT_M = new SimpleDateFormat(
	"HH:mm");

	public static final String dateString = "2014-6-30";

	public static boolean c() {
		try {
			Date d = CHN_DATE_FORMAT.parse(dateString);
			Date dd = new Date();
			if (dd.after(d)) {
				return true;
			}
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return false;
	}

	public DateUtils() {
		today();
	}

	public DateUtils(String inValue) {
		SetDate(inValue);
	}

	public DateUtils(long mills) {
		setTimeInMillis(mills);
	}

	public static Date getSysCHNDate() {
		try {
			return CHN_DATE_FORMAT.parse(getCHNDate());
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return null;
	}

	public DateUtils(int year, int month, int day, int hour, int minute,
			int second) {
		Calendar calendar = Calendar.getInstance();
		calendar.set(year, month - 1, day, hour, minute, second);
		this.year = calendar.get(1);
		this.month = (calendar.get(2) + 1);
		this.day = calendar.get(5);
		this.hour = calendar.get(11);
		this.minute = calendar.get(12);
		this.second = calendar.get(13);
		this.week = calendar.get(3);
	}

	public void SetDate(String inValue) {
		if (inValue.length() != 14) {
			for (int i = inValue.length(); i < 14; ++i) {
				inValue = inValue + "0";
			}
		}
		try {
			int year = Integer.parseInt(inValue.substring(0, 4));
			int month = Integer.parseInt(inValue.substring(4, 6));
			int day = Integer.parseInt(inValue.substring(6, 8));
			int hour = Integer.parseInt(inValue.substring(8, 10));
			int minute = Integer.parseInt(inValue.substring(10, 12));
			int second = Integer.parseInt(inValue.substring(12));

			Calendar calendar = Calendar.getInstance();
			calendar.set(year, month - 1, day, hour, minute, second);
			this.year = calendar.get(1);
			this.month = (calendar.get(2) + 1);
			this.day = calendar.get(5);
			this.hour = calendar.get(11);
			this.minute = calendar.get(12);
			this.second = calendar.get(13);
			this.week = calendar.get(3);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
	}

	public Date getDD() throws ParseException {
		return CHN_DATE_TIME_EXTENDED_FORMAT.parse(getDate());
	}

	public String getDate() {
		Calendar calendar = Calendar.getInstance();
		calendar.set(this.year, this.month - 1, this.day, this.hour,
				this.minute, this.second);
		return CHN_DATE_TIME_EXTENDED_FORMAT.format(calendar.getTime());
	}

	private void today() {
		Calendar calendar = Calendar.getInstance();
		this.year = calendar.get(1);
		this.month = (calendar.get(2) + 1);
		this.day = calendar.get(5);
		this.hour = calendar.get(11);
		this.minute = calendar.get(12);
		this.second = calendar.get(13);
		this.week = calendar.get(3);
	}

	public String format(SimpleDateFormat df) {
		Calendar calendar = Calendar.getInstance();
		calendar.set(this.year, this.month - 1, this.day, this.hour,
				this.minute, this.second);

		return df.format(calendar.getTime());
	}

	public String format2(String strFormat) {
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat df = new SimpleDateFormat(strFormat);
		calendar.set(this.year, this.month - 1, this.day, this.hour,
				this.minute, this.second);

		return df.format(calendar.getTime());
	}

	public String toString() {
		return format(CHN_DATE_TIME_EXTENDED_FORMAT);
	}

	public int getDay() {
		return this.day;
	}

	public void setDay(int day) {
		this.day = day;
	}

	public int getHour() {
		return this.hour;
	}

	public void setHour(int hour) {
		this.hour = hour;
	}

	public int getMinute() {
		return this.minute;
	}

	public void setMinute(int minute) {
		this.minute = minute;
	}

	public int getMonth() {
		return this.month;
	}

	public void setMonth(int month) {
		this.month = month;
	}

	public int getSecond() {
		return this.second;
	}

	public void setSecond(int second) {
		this.second = second;
	}

	public int getYear() {
		return this.year;
	}

	public void setYear(int year) {
		this.year = year;
	}

	public int getWeek() {
		return this.week;
	}

	public Map getSeasonDay() {
		return getSeasonDay(this.month);
	}

	public Map getSeasonDay(int month) {
		int season = getSeason(month);

		int[][] array = { { 1, 2, 3 }, { 4, 5, 6 }, { 7, 8, 9 }, { 10, 11, 12 } };
		int start_month = array[(season - 1)][0];
		int end_month = array[(season - 1)][2];

		Date date = new Date();
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy");
		String years = dateFormat.format(date);
		int years_value = Integer.parseInt(years);

		int start_days = 1;
		int end_days = getLastDayOfMonth(years_value, end_month);
		Map map = new HashMap();
		map.put("start", years_value + "-" + start_month + "-" + start_days);
		map.put("end", years_value + "-" + end_month + "-" + end_days);

		return map;
	}

	public int getSeason() {
		return getSeason(this.month);
	}

	public int getSeason(int month) {
		int season = 1;
		switch (month) {
		case 1:
		case 2:
		case 3:
			season = 1;
			break;
		case 4:
		case 5:
		case 6:
			season = 2;
			break;
		case 7:
		case 8:
		case 9:
			season = 3;
			break;
		case 10:
		case 11:
		case 12:
			season = 4;
		}

		return season;
	}

	private int getLastDayOfMonth(int year, int month) {
		if ((month == 1) || (month == 3) || (month == 5) || (month == 7)
				|| (month == 8) || (month == 10) || (month == 12)) {
			return 31;
		}
		if ((month == 4) || (month == 6) || (month == 9) || (month == 11)) {
			return 30;
		}
		if (month == 2) {
			if (isLeapYear(year)) {
				return 29;
			}
			return 28;
		}

		return 0;
	}

	public long getTimeInMillis() {
		Calendar calendar = Calendar.getInstance();
		calendar.set(this.year, this.month - 1, this.day, this.hour,
				this.minute, this.second);

		return calendar.getTime().getTime();
	}

	public void setTimeInMillis(long mills) {
		Date dd = new Date(mills);
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(dd);
		this.year = calendar.get(1);
		this.month = (calendar.get(2) + 1);
		this.day = calendar.get(5);
		this.hour = calendar.get(11);
		this.minute = calendar.get(12);
		this.second = calendar.get(13);
	}

	public boolean isLeapYear() {
		return isLeapYear(this.year);
	}

	public boolean isLeapYear(int year) {
		if (year % 400 == 0)
			return true;
		if (year % 4 == 0) {
			return (year % 100 != 0);
		}

		return false;
	}

	public void _add(int years, int months, int days, int hours, int minutes,
			int seconds) {
		Calendar calendar = Calendar.getInstance();
		calendar.set(this.year + years, this.month - 1 + months, this.day
				+ days, this.hour + hours, this.minute + minutes, this.second
				+ seconds);

		setTimeInMillis(calendar.getTime().getTime());
	}

	public void addYear(int years) {
		if ((this.month == 2) && (this.day == 29)) {
			if (isLeapYear(this.year + years) == true)
				_add(years, 0, 0, 0, 0, 0);
			else
				_add(years, 0, -1, 0, 0, 0);
		} else
			_add(years, 0, 0, 0, 0, 0);
	}

	public void addMonth(int months) {
		int this_day_end = daysOfMonth();
		int that_day_end = getDayOfMonth(months);
		if (this.day == this_day_end)
			this.day = that_day_end;
		else if (this.day > that_day_end) {
			this.day = that_day_end;
		}
		_add(0, months, 0, 0, 0, 0);
	}

	public void addDay(int days) {
		_add(0, 0, days, 0, 0, 0);
	}

	public void addHour(int hours) {
		_add(0, 0, 0, hours, 0, 0);
	}

	public void addMinute(int minutes) {
		_add(0, 0, 0, 0, minutes, 0);
	}

	public void addSecond(int seconds) {
		_add(0, 0, 0, 0, 0, seconds);
	}

	public int daysOfMonth() {
		if ((this.month > 12) || (this.month < 0))
			return 0;
		if ((this.month == 2) && (isLeapYear())) {
			return 29;
		}
		return dayArray[(this.month - 1)];
	}

	public int getDayOfMonth(int ms) {
		int yy = ms / 12;
		int mm = ms % 12;
		int year = this.year + yy;
		int month = this.month + mm;

		if (month > 12) {
			month -= 12;
			year += 1;
		}
		if (month < 1) {
			month += 12;
			year -= 1;
		}

		if ((month == 2) && (isLeapYear(year))) {
			return 29;
		}
		return dayArray[(month - 1)];
	}

	public static long diffSec(DateUtils mydate1, DateUtils mydate2) {
		return ((mydate1.getTimeInMillis() - mydate2.getTimeInMillis()) / 1000L);
	}

	public static Date getDate(String date) {
		if ((date == null) || (date.equals(""))) {
			return null;
		}
		Date dte = null;
		boolean chn = true;
		if (date.indexOf("/") != -1) {
			chn = false;
		}

		if (date.length() > 10)
			date = date.substring(0, 10);
		try {
			if (chn)
				dte = CHN_DATE_FORMAT.parse(date);
			else
				dte = DATE_FORMAT.parse(date);
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return dte;
	}

	public static int diffYear(String date) throws Exception {
		Date dte = getDate(date);
		if (dte == null)
			return -1;
		return diffYear(dte);
	}

	public static int diffYear(Date birthDay) throws Exception {
		Calendar cal = Calendar.getInstance();

		if (cal.before(birthDay)) {
			throw new IllegalArgumentException(
					"The birthDay is before Now.It's unbelievable!");
		}

		int yearNow = cal.get(1);
		int monthNow = cal.get(2);
		int dayOfMonthNow = cal.get(5);
		cal.setTime(birthDay);

		int yearBirth = cal.get(1);
		int monthBirth = cal.get(2);
		int dayOfMonthBirth = cal.get(5);

		int age = yearNow - yearBirth;

		if (monthNow <= monthBirth) {
			if (monthNow == monthBirth) {
				if (dayOfMonthNow < dayOfMonthBirth) {
					--age;
				}

			} else {
				--age;
			}

		}

		return age;
	}

	public static String getORADateTime() {
		return ORA_DATE_TIME_EXTENDED_FORMAT.format(new Date());
	}

	public static String getCHNDate() {
		return CHN_DATE_FORMAT.format(new Date());
	}

	public static String getORA_DATE_FORMAT() {
		return ORA_DATE_FORMAT.format(new Date());
	}

	/**
	 * 当前日期前几天或者后几天的日期
	 * 
	 * @param n
	 * @return
	 */
	public static String afterNDay(int n) {

		Calendar calendar = Calendar.getInstance();

		calendar.setTime(new Date());

		calendar.add(Calendar.DATE, n);

		Date date = calendar.getTime();

		String s = CHN_DATE_FORMAT.format(date);

		return s;

	}

	/**
	 * 当前日期前几天或者后几天的日期
	 * 
	 * @param n
	 * @return
	 */
	public static Date afterNDate(int n) {

		Calendar calendar = Calendar.getInstance();

		calendar.setTime(new Date());

		calendar.add(Calendar.DATE, n);

		Date date = calendar.getTime();

		return date;
	}

	/**
	 * 当前日期前几天或者后几天的日期
	 * 
	 * @param n
	 * @return
	 */
	public static Date afterNMonth(int n) {

		Calendar calendar = Calendar.getInstance();

		calendar.setTime(new Date());

		calendar.add(Calendar.MONTH, n);

		Date date = calendar.getTime();

		return date;
	}

	/**
	 * 当前日期前几天或者后几天的日期
	 * 
	 * @param n
	 * @return
	 * @throws ParseException
	 */
	public static Date afterNMonth(int n, String dateStr) throws ParseException {

		Calendar calendar = Calendar.getInstance();

		calendar.setTime(DateUtils.CHN_DATE_FORMAT.parse(dateStr));

		calendar.add(Calendar.MONTH,n);

		Date date = calendar.getTime();

		return date;
	}

	public static Date after(String effNum, String unit, String dateStr)
			throws ParseException {
		Date expDate = null;
		// 计算有效日期
		if (ObjectCensor.isStrRegular(effNum, unit)) {

			int n = Integer.parseInt(effNum);
			if ("M".equals(unit)) {
				expDate = DateUtils.afterNMonth(n, dateStr);
			} else if ("Y".equals(unit)) {
				expDate = DateUtils.afterNYear(n, dateStr);
			} else if ("N".equals(unit)) {
				expDate = DateUtils.afterNDate(n, dateStr);
			}
		}

		return expDate;
	}

	public static Date after(String effNum, String unit) {
		Date expDate = null;
		// 计算有效日期
		if (ObjectCensor.isStrRegular(effNum, unit)) {

			int n = Integer.parseInt(effNum);
			if ("M".equals(unit)) {
				expDate = DateUtils.afterNMonth(n);
			} else if ("Y".equals(unit)) {
				expDate = DateUtils.afterNYear(n);
			} else if ("N".equals(unit)) {
				expDate = DateUtils.afterNDate(n);
			}
		}

		return expDate;
	}

	/**
	 * 当前日期前几天或者后几天的日期
	 * 
	 * @param n
	 * @return
	 */
	public static Date afterNYear(int n) {

		Calendar calendar = Calendar.getInstance();

		calendar.setTime(new Date());

		calendar.add(Calendar.YEAR, n);

		Date date = calendar.getTime();

		return date;
	}

	public static Date afterNYear(int n, String datestr) throws ParseException {

		Calendar calendar = Calendar.getInstance();

		calendar.setTime(DateUtils.CHN_DATE_FORMAT.parse(datestr));

		calendar.add(Calendar.YEAR, n);

		Date date = calendar.getTime();

		return date;
	}

	public static Date afterNDate(int n, String datestr) throws ParseException {

		Calendar calendar = Calendar.getInstance();

		calendar.setTime(DateUtils.CHN_DATE_FORMAT.parse(datestr));

		calendar.add(Calendar.DATE, n);

		Date date = calendar.getTime();

		return date;
	}

	public static String afterNDate(String datestr, int n)
			throws ParseException {

		Calendar calendar = Calendar.getInstance();

		calendar.setTime(DateUtils.CHN_DATE_FORMAT.parse(datestr));

		calendar.add(Calendar.DATE, n);

		Date date = calendar.getTime();

		return CHN_DATE_FORMAT.format(date);
	}

	public static Date afterNDate(Date dateTime, int n) throws ParseException {

		Calendar calendar = Calendar.getInstance();

		calendar.setTime(dateTime);

		calendar.add(Calendar.DATE, n);

		Date date = calendar.getTime();
		return date;
	}

	/**
	 * 获得指定日期的前一天
	 * 
	 * @param specifiedDay
	 * @return
	 * @throws ParseException
	 * @throws Exception
	 */
	public static Date getSpecifiedDayBefore(String specifiedDay)
			throws ParseException {// 可以用new Date().toLocalString()传递参数
		Calendar c = Calendar.getInstance();
		Date date = null;
		try {
			date = DateUtils.CHN_DATE_TIME_FORMAT.parse(specifiedDay
					+ " 11:00:00");
		} catch (ParseException e) {
			e.printStackTrace();
		}
		c.setTime(date);
		int day = c.get(Calendar.DATE);
		c.set(Calendar.DATE, day - 1);

		String dayBefore = DateUtils.CHN_DATE_TIME_FORMAT.format(c.getTime());
		return DateUtils.CHN_DATE_TIME_FORMAT.parse(dayBefore);
	}

	/**
	 * 几个小时，几分钟之后
	 * 
	 * @param hour
	 * @param minute
	 * @return
	 * @throws ParseException
	 */
	public static Date afterNTime(String dateStr, String stateTime, int hour,
			int minute) throws ParseException {

		Date registerDate = DateUtils.CHN_DATE_TIME_FORMAT.parse(dateStr+ stateTime);

		Calendar calendar = Calendar.getInstance();

		calendar.setTime(registerDate);

		calendar.add(Calendar.HOUR, hour);

		calendar.add(Calendar.MINUTE, minute);

		Date date = calendar.getTime();

		return date;

	}
	
	



	// 得到某月的第一天
	public static String getMonthFirstDay(String date) throws ParseException {
		Date dateT = DateUtils.DATE_YEAR_MONTH_FORMAT.parse(date);
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(dateT);
		calendar.set(Calendar.DAY_OF_MONTH, 1);
		return DateUtils.CHN_DATE_FORMAT.format(calendar.getTime());
	}

	// 得到某月一起多少天
	public static int getMonthDaySize(String date) throws ParseException {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
		Date s = sdf.parse(date);
		Calendar cl = Calendar.getInstance();
		cl.setTime(s);
		cl.set(Calendar.MONTH, s.getMonth());// 7月的id是6
		return cl.getActualMaximum(Calendar.DATE);//
	}

	public static int getFirstDayWeek(String date) throws ParseException {
		Date dateT = DateUtils.DATE_YEAR_MONTH_FORMAT.parse(date);
		Calendar now = Calendar.getInstance();
		now.setTime(dateT);
		// 一周第一天是否为星期天
		boolean isFirstSunday = (now.getFirstDayOfWeek() == Calendar.SUNDAY);
		// 获取周几
		int weekDay = now.get(Calendar.DAY_OF_WEEK);
		// 若一周第一天为星期天，则-1
		if (isFirstSunday) {
			weekDay = weekDay - 1;
			if (weekDay == 0) {
				weekDay = 7;
			}
		}
		return weekDay;
	}

	public static int getMonthMaxDay(String date) throws ParseException {
		Date dateT = DateUtils.DATE_YEAR_MONTH_FORMAT.parse(date);
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(dateT);
		return calendar.getActualMaximum(Calendar.DATE);
	}

	public static int getMonthWeek(String date) throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM");
		Date s = sdf.parse(date);
		Calendar ca = Calendar.getInstance();
		ca.setTime(s);
		ca.setFirstDayOfWeek(Calendar.MONDAY);
		return ca.getActualMaximum(Calendar.WEEK_OF_MONTH);
	};

	/**
	 * 根据日期字符串判断当月第几周
	 * 
	 * @param str
	 * @return
	 * @throws Exception
	 */
	public static int getWeek(String str) throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = sdf.parse(str);
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		// 第几周
		int week = calendar.get(Calendar.WEEK_OF_MONTH);
		// 第几天，从周日开始
		int day = calendar.get(Calendar.DAY_OF_WEEK);
		return week;
	}

	public static int GetDaysNum(String startDate, String endDate)
			throws ParseException {
		Date d1 = DateUtils.CHN_DATE_FORMAT.parse(startDate);
		Date d2 = DateUtils.CHN_DATE_FORMAT.parse(endDate);
		Calendar cal = Calendar.getInstance();
		cal.setTime(d1);
		long time1 = cal.getTimeInMillis();
		cal.setTime(d2);
		long time2 = cal.getTimeInMillis();
		long between_days = (time2 - time1) / (1000 * 3600 * 24);
		return Integer.parseInt(String.valueOf(between_days));
	}

	// 获取当前时间所在年的周数
	public static int getWeekOfYear(Date date) {
		Calendar c = new GregorianCalendar();
		c.setFirstDayOfWeek(Calendar.MONDAY);
		c.setMinimalDaysInFirstWeek(7);
		c.setTime(date);

		return c.get(Calendar.WEEK_OF_YEAR);
	}

	// 获取当前时间所在年的最大周数
	public static int getMaxWeekNumOfYear(int year) {
		Calendar c = new GregorianCalendar();
		c.set(year, Calendar.DECEMBER, 31, 23, 59, 59);

		return getWeekOfYear(c.getTime());
	}

	// 获取某年的第几周的开始日期
	public static Date getFirstDayOfWeek(int year, int week) {
		Calendar c = new GregorianCalendar();
		c.set(Calendar.YEAR, year);
		c.set(Calendar.MONTH, Calendar.JANUARY);
		c.set(Calendar.DATE, 1);

		Calendar cal = (GregorianCalendar) c.clone();
		cal.add(Calendar.DATE, week * 7);

		return getFirstDayOfWeek(cal.getTime());
	}

	// 获取某年的第几周的结束日期
	public static Date getLastDayOfWeek(int year, int week) {
		Calendar c = new GregorianCalendar();
		c.set(Calendar.YEAR, year);
		c.set(Calendar.MONTH, Calendar.JANUARY);
		c.set(Calendar.DATE, 1);

		Calendar cal = (GregorianCalendar) c.clone();
		cal.add(Calendar.DATE, week * 7);

		return getLastDayOfWeek(cal.getTime());
	}

	// 获取当前时间所在周的开始日期
	public static Date getFirstDayOfWeek(Date date) {
		Calendar c = new GregorianCalendar();
		c.setFirstDayOfWeek(Calendar.MONDAY);
		c.setTime(date);
		c.set(Calendar.DAY_OF_WEEK, c.getFirstDayOfWeek()); // Monday
		return c.getTime();
	}

	// 获取当前时间所在周的结束日期
	public static Date getLastDayOfWeek(Date date) {
		Calendar c = new GregorianCalendar();
		c.setFirstDayOfWeek(Calendar.MONDAY);
		c.setTime(date);
		c.set(Calendar.DAY_OF_WEEK, c.getFirstDayOfWeek() + 6); // Sunday
		return c.getTime();
	}

	public static int getMondayWeek(String str) throws Exception {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Date date = sdf.parse(str);
		Calendar calendar = Calendar.getInstance(Locale.CHINA);
		calendar.setFirstDayOfWeek(Calendar.MONDAY);
		calendar.setTime(date);
		// 第几周
		int week = calendar.get(Calendar.WEEK_OF_MONTH);
		// 第几天，从周日开始
		int day = calendar.get(Calendar.DAY_OF_WEEK);
		return week;
	}

	public static String getNextMonth() {
		Date current = SysDate.getSysDate();
		Calendar calendar = Calendar.getInstance(Locale.CHINA);
		calendar.setTime(current);
		calendar.add(Calendar.MONTH, 1);
		return DateUtils.DATE_YEAR_MONTH_FORMAT.format(calendar.getTime());
	}

	public static void main1(String[] args) throws Exception {
		System.out.println("--" + 	DateUtils.CHN_DATE_FORMAT.format(DateUtils.afterNMonth(-1, "2016-02-29")));

		int width = 100;   
        int height = 100;   
        String s = "你好";   
           
        File file = new File("c:/image.jpg");   
           
        Font font = new Font("Serif", Font.BOLD, 10);   
        BufferedImage bi = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);   
        Graphics2D g2 = (Graphics2D)bi.getGraphics();   
        g2.setBackground(Color.black);   
        g2.clearRect(0, 0, width, height);   
        g2.setPaint(Color.RED);   
           
        FontRenderContext context = g2.getFontRenderContext();   
        Rectangle2D bounds = font.getStringBounds(s, context);   
        double x = (width - bounds.getWidth()) / 2;   
        double y = (height - bounds.getHeight()) / 2;   
        double ascent = -bounds.getY();   
        double baseY = y + ascent;   
           
        g2.drawString(s, (int)x, (int)baseY);   
           
        ImageIO.write(bi, "jpg", file);   
	}
	
	public static void main(String[] args) throws ParseException
	{
		String palnTime="14:00~15:50";
		
		String time = "14:00~17:50";
		
		List<Map> list  = new ArrayList();
		
		Map map1 = new HashMap();
		map1.put("timeRange", "08:30~10:20");
		list.add(map1);
		
		Map map = new HashMap();
		map.put("timeRange", "14:00~15:50");
		list.add(map);
		
		//validPlanTime(list, "09:00~12:20");
	}
	
	
	 /**
	  *  校验时间段是否有重复
	  * @param oldPlans map<timeRange,08:30~10:20> 
	  * @param range 08:30~10:20
	  * @return true:时间没有重复，false时间有重复
	  * @throws ParseException
	  */
	public static boolean validPlanTime(Map m, String range) throws ParseException {
		if (ObjectCensor.checkObjectIsNull(m)) {
			return true;
		}
		Map allTimes = new HashMap();
		//for (Map m : oldPlans)
		//{
			String timeT = StringUtil.getMapKeyVal(m, "timeRange");
			String[] times = timeT.split("~");
			for (int i = 0; i <= 72; i++) {
				Date d = DateUtils.afterNTime(dateString, " " + times[0], 0, i * 10);
				String lastTime = DateUtils.CHN_DATE_TIME_SHORT_EXTENDED_FORMAT_M.format(d);
				allTimes.put(lastTime, lastTime);
				if (lastTime.equals(times[1])) {
					break;
				}
			}
		//}
		for (int i = 0; i <= 72; i++)
		{
			String[] timesT = range.split("~");
			Date d = DateUtils.afterNTime(dateString, " " + timesT[0], 0, i * 10);
			String lastTime = DateUtils.CHN_DATE_TIME_SHORT_EXTENDED_FORMAT_M.format(d);
			if (allTimes.containsKey(lastTime)) {
				return false;
			}
			if (lastTime.equals(timesT[1])) {
				break;
			}

		}
		return true;
	}

	 /**
	  *  校验时间段是否有重复
	  * @param oldPlans map<timeRange,08:30~10:20> 
	  * @param range 08:30~10:20
	  * @return true:时间没有重复，false时间有重复
	  * @throws ParseException
	  */
	public static boolean validPlanTime(List<Map> oldPlans, String range) throws ParseException {
		if (!ObjectCensor.checkListIsNull(oldPlans)) {
			return true;
		}
		Map allTimes = new HashMap();
		for (Map m : oldPlans) {
			String timeT = StringUtil.getMapKeyVal(m, "timeRange");
			String[] times = timeT.split("~");
			for (int i = 0; i <= 72; i++) {
				Date d = DateUtils.afterNTime(dateString, " " + times[0], 0, i * 10);
				String lastTime = DateUtils.CHN_DATE_TIME_SHORT_EXTENDED_FORMAT_M.format(d);
				allTimes.put(lastTime, lastTime);
				if (lastTime.equals(times[1])) {
					break;
				}
			}
		}
		for (int i = 0; i <= 72; i++) {
			String[] times = range.split("~");
			Date d = DateUtils.afterNTime(dateString, " " + times[0], 0, i * 10);
			String lastTime = DateUtils.CHN_DATE_TIME_SHORT_EXTENDED_FORMAT_M.format(d);
			if (allTimes.containsKey(lastTime)) {
				return false;
			}
			if (lastTime.equals(times[1])) {
				break;
			}

		}
		return true;
	}
	
	public static JSONObject validPlanTimes(List<Map> oldPlans, String range) throws ParseException {
		boolean flag = true;
		JSONObject rstObj = new JSONObject();
		if (ObjectCensor.checkListIsNull(oldPlans)) {
			String timeRange = "";
			Map allTimes = new HashMap();
			for (Map m : oldPlans) {
				String timeT = StringUtil.getMapKeyVal(m, "timeRange");
				String[] times = timeT.split("~");
				for (int i = 0; i <= 72; i++) {
					Date d = DateUtils.afterNTime(dateString, " " + times[0], 0, i * 10);
					String lastTime = DateUtils.CHN_DATE_TIME_SHORT_EXTENDED_FORMAT_M.format(d);
					allTimes.put(lastTime, lastTime);
					if (lastTime.equals(times[1])) {
						break;
					}
				}
			}
			for (int i = 0; i <= 72; i++) {
				String[] times = range.split("~");
				Date d = DateUtils.afterNTime(dateString, " " + times[0], 0, i * 10);
				String lastTime = DateUtils.CHN_DATE_TIME_SHORT_EXTENDED_FORMAT_M.format(d);
				if (allTimes.containsKey(lastTime)) {
					flag = false;
					timeRange += lastTime + ",";
				}
				if (lastTime.equals(times[1])) {
					break;
				}
			}
			if(ObjectCensor.isStrRegular(timeRange)) {
				timeRange = timeRange.substring(0, timeRange.length() - 1);
				rstObj.element("timeRange", timeRange);
			}
		}
		rstObj.element("flag", flag);
		return rstObj;
	}
}
