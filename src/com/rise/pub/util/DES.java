package com.rise.pub.util;


import java.io.IOException;
import java.security.SecureRandom;

import javax.crypto.Cipher;
import javax.crypto.SecretKey;
import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.DESKeySpec;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import sun.misc.BASE64Decoder;
import sun.misc.BASE64Encoder;

import com.sun.net.httpserver.Filter;

public class DES
{
	public static Log log = LogFactory.getLog(DES.class);
	
	private byte[] desKey;

	public DES(String desKey)
	{
		this.desKey = desKey.getBytes();
	}

	public byte[] desEncrypt(byte[] plainText) throws Exception
	{
		SecureRandom sr = new SecureRandom();
		byte rawKeyData[] = desKey;
		DESKeySpec dks = new DESKeySpec(rawKeyData);
		SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
		SecretKey key = keyFactory.generateSecret(dks);
		Cipher cipher = Cipher.getInstance("DES");
		cipher.init(Cipher.ENCRYPT_MODE, key, sr);
		byte data[] = plainText;
		byte encryptedData[] = cipher.doFinal(data);
		return encryptedData;
	}

	public byte[] desDecrypt(byte[] encryptText) throws Exception
	{
		SecureRandom sr = new SecureRandom();
		byte rawKeyData[] = desKey;
		DESKeySpec dks = new DESKeySpec(rawKeyData);
		SecretKeyFactory keyFactory = SecretKeyFactory.getInstance("DES");
		SecretKey key = keyFactory.generateSecret(dks);
		Cipher cipher = Cipher.getInstance("DES");
		cipher.init(Cipher.DECRYPT_MODE, key, sr);
		byte encryptedData[] = encryptText;
		byte decryptedData[] = cipher.doFinal(encryptedData);
		return decryptedData;
	}

	public String encrypt(String input) throws Exception
	{
		return base64Encode(desEncrypt(input.getBytes()));
	}

	public String decrypt(String input) throws Exception
	{
		byte[] result = base64Decode(input);
		return new String(desDecrypt(result));
	}

	public boolean decrypt(String input,String str) throws Exception
	{
		byte[] result = base64Decode(input);
		String des= new String(desDecrypt(result));
		if(des.equals(str))
		{
			return true;
		}
		else
		{
//			log.warn(encrypt(str));
			throw new Exception("please change DES sign:"+encrypt(str));
			//throw new DESException("½âÃÜ×Ö·û´®:"+des+"  "+"Ã÷ÎÄ:"+str);
		}
	}
	
	public static String base64Encode(byte[] s)
	{
		if (s == null)
			return null;
		BASE64Encoder b = new sun.misc.BASE64Encoder();
		return b.encode(s);
	}

	public static byte[] base64Decode(String s) throws IOException
	{
		if (s == null)
			return null;
		BASE64Decoder decoder = new BASE64Decoder();
		byte[] b = decoder.decodeBuffer(s);
		return b;
	}

	public String filter(String str)
	{
		StringBuffer sb = new StringBuffer();
		for(int i = 0; i < str.length(); i++)
		{
			int asc = str.charAt(i);
			if(asc != 10 && asc != 13)
				sb.append(str.subSequence(i, i + 1));
		}
		return new String(sb);
	 }

	public static void main(String[] args) throws Exception
	{
		String key = "420115199008140024";
		String input = "1234567890000000";
		DES crypt = new DES(key);
		String str =crypt.encrypt(input);
		System.out.println("Encode:" +str);
		System.out.println("Decode:" + crypt.decrypt(str));
	}
}
