package com.rise.pub.util;

import java.awt.Color;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.geom.AffineTransform;
import java.awt.image.BufferedImage;
import java.util.Random;

/**
 * 功能描述�?用来生成验证码图片，测试�?��，常量，方法都设置成了static<br/>
 */
public class SecurityCodeCreater 
{
	// 图片的宽�?
	private final static int IMAGEWIDTH = 20;
	// 图片的高�?
	private final static int IMAGEHEIGHT = 22;

	// 字符串长�?
	private final static int CODE_LENGTH = 4;

	// 随机字符范围
	private final static char[] CHAR_RANGE = { 'A', 'B', 'C', 'D', 'E', 'F',
			'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S',
			'T', 'U', 'V', 'W', 'X', 'Y', 'Z', 'a', 'b', 'c', 'd', 'e', 'f',
			'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's',
			't', 'u', 'v', 'w', 'x', 'y', 'z', '0', '1', '2', '3', '4', '5',
			'6', '7', '8', '9' };

	private static Random random = new Random();

	/**
	 * 生成随机字符�?
	 * 
	 * @return 随机字符�?
	 */
	public static String getRandString() 
	{
		StringBuilder sb = new StringBuilder();
		for (int i = 0; i < CODE_LENGTH; i++) 
		{
			sb.append(CHAR_RANGE[random.nextInt(CHAR_RANGE.length)]);
		}
		return sb.toString();
	}

	/**
	 * 生成随机颜色
	 * 
	 * @param ll
	 *            产生颜色值下�?lower limit)
	 * @param ul
	 *            产生颜色值上�?upper limit)
	 * @return 生成的随机颜色对�?
	 */
	private static Color getRandColor(int ll, int ul) 
	{
		if (ll > 255)
			ll = 255;
		if (ll < 1)
			ll = 1;
		if (ul > 255)
			ul = 255;
		if (ul < 1)
			ul = 1;
		if (ul == ll)
			ul = ll + 1;
		int r = random.nextInt(ul - ll) + ll;
		int g = random.nextInt(ul - ll) + ll;
		int b = random.nextInt(ul - ll) + ll;
		Color color = new Color(r, g, b);
		return color;
	}

	/**
	 * 生成指定字符串的图像数据
	 * 
	 * @param verifyCode
	 *            即将被打印的随机字符�?
	 * @return 生成的图像数�?
	 * */
	public static BufferedImage getImage(String verifyCode) 
	{
		// 生成画布
		BufferedImage image = new BufferedImage(IMAGEWIDTH * CODE_LENGTH, IMAGEHEIGHT, BufferedImage.TYPE_INT_RGB);

		// 获取图形上下�?（生成画笔）
		Graphics graphics = image.getGraphics();

		// 设置背景色（�?
		graphics.setColor(getRandColor(1, 50));

		// 填充矩形区域 ，作为背�?
		graphics.fillRect(0, 0, IMAGEWIDTH * 4, IMAGEHEIGHT);

		// 设置边框颜色
		graphics.setColor(new Color(0, 0, 0));

		// 画出边框
		for (int i = 0; i < 2; i++)
			graphics.drawRect(i, i, IMAGEWIDTH * CODE_LENGTH - i * 2 + 1, IMAGEHEIGHT - i * 2 + 1);

		// 设置随机干扰线条颜色
		graphics.setColor(getRandColor(50, 100));

		// 产生50条干扰线�?
		for (int i = 0; i < 50; i++) 
		{
			int x1 = random.nextInt(IMAGEWIDTH * CODE_LENGTH - 4) + 2;
			int y1 = random.nextInt(IMAGEHEIGHT - 4) + 2;
			int x2 = random.nextInt(IMAGEWIDTH * CODE_LENGTH - 2 - x1) + x1;
			int y2 = y1;
			graphics.drawLine(x1, y1, x2, y2);
		}

		// 设置字体 变形
		AffineTransform fontAT = new AffineTransform();
		for (int i = 0; i < verifyCode.length(); i++) 
		{
			// 产生弧度
			int rotate = random.nextInt(15);
			// fontAT.rotate(random.nextBoolean() ?
			// Math.toRadians(rotate):-Math.toRadians(rotate / 2));
			Font fx = new Font(new String[] { "Times New Roman", "Verdana", "arial" }[random.nextInt(2)], Font.PLAIN, 20).deriveFont(fontAT);
			graphics.setFont(fx);
			String temp = verifyCode.substring(i, i + 1);
			graphics.setColor(getRandColor(100, 255));
			graphics.drawString(temp, 13 * i + 6, 16);
		}
		// 图像生效
		graphics.dispose();

		return image;
	}
}
