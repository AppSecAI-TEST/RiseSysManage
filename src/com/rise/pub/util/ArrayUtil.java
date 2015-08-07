package com.rise.pub.util;

public final class ArrayUtil {
	public static boolean contains(String str[],String val)
	{
		for(int i=0;i<str.length;i++)
			if(str[i].equals(val))
				return true;
		return false;
	}
}
