package com.rise.pub.util;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.StringWriter;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Hashtable;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import net.sf.json.JSONObject;

import org.apache.commons.beanutils.BeanUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Category;

/**
 * <p>Title: �ַ�����������</p>
 *
 */

public class StringUtil {
    private static Category cat;
    public StringUtil() {
    }

    /**
     * firstCharLowerCase
     *
     * @param s String
     * @return String
     */
    public static String firstCharLowerCase(String s){
        if(s==null || "".equals(s)) return ("");
        return s.substring(0,1).toLowerCase()+s.substring(1);
    }

    /**
     * firstCharUpperCase
     *
     * @param s String
     * @return String
     */
    public static String firstCharUpperCase(String s){
       if(s==null || "".equals(s)) return ("");
       return s.substring(0,1).toUpperCase()+s.substring(1);
   }

    public static String[] splitStringByTokenCount(String value, String token, int arrSize){
        Map map=new HashMap();

        if(arrSize==0) return null;

        int cnt = StringUtils.countMatches(value, token);
        if(!token.equals(value.substring(value.length()-token.length())))
            cnt ++;

        int len = cnt%arrSize==0?(cnt/arrSize):(cnt/arrSize)+1;
        String[] rets = new String[len];

        if(len==1) rets[0] = value;
        else{
            int count = 0;
            int ssIdx = 0;
            int iBeginIdx = 0;
            int idx = 0;
            while((idx = value.indexOf(token, idx)) != -1){
                count++;
                if(count%arrSize==0) {
                    rets[ssIdx] = value.substring(iBeginIdx,idx);
                    ssIdx++;
                    iBeginIdx = idx + token.length();
                }
                idx += token.length();
            }
            if(ssIdx+1==len){
                 rets[ssIdx]= value.substring(iBeginIdx);
            }

        }
        return rets;
    }

    public static String trimTokenAndNextFirstCharUpperCase(String value, String token)
    {
        if(value==null||"".equals(value)) return value;

        String[] ss = StringUtils.split(value, token);

        ss[0] = ss[0].toLowerCase();
        for(int i=1; i<ss.length; i++)
            ss[i] = firstCharUpperCase(ss[i].toLowerCase());


        return org.apache.commons.lang.StringUtils.join(ss);
    }

    /** ��JAVABEAN������ת��Ϊ��BEAN��Ӧ�����ݿ����ֶ�
       * @param voName
       * @return String
       */
      public static String  getConverColName(String property) {
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < property.length(); i++) { //����property����д�д��ĸ�򽫴�д��ĸת��Ϊ_��Сд
          char cur = property.charAt(i);
          if (Character.isUpperCase(cur)) {
            sb.append("_");
            sb.append(Character.toLowerCase(cur));
          }
          else {
            sb.append(cur);
          }
        }
        return sb.toString();
      }

      //**************add by ojw*********************
      /**
       *�����ַ�������date
       *
       * @param String
       * @return Date
       */
     public static Date strToDate(String s){

        Date mydate=new Date();

        if (s.length()==10){
            mydate.setYear(Integer.parseInt(s.substring(0,4)));
            mydate.setMonth(Integer.parseInt(s.substring(5,7)));
            mydate.setDate(Integer.parseInt(s.substring(8,10)));
        }
        if (s.length()==8){
            mydate.setYear(Integer.parseInt(s.substring(0,4)));
            mydate.setMonth(Integer.parseInt(s.substring(4,6)));
            mydate.setDate(Integer.parseInt(s.substring(6,8)));
        }
        return mydate;
     }

     /**
       *����Vo���ֶ����ֵõ�dto������
       *!!!!���ǹ涨ҳ����dto������Ϊ���ݿ��еı�/�ֶ���,����ȫ��ΪСд
       * @param voName
       * @return
       */
      public static String  getDtoName_ByVo(String voName) {
        StringBuffer sb = new StringBuffer();
        for (int i = 0; i < voName.length(); i++) { //����voName����д�д��ĸ�򽫴�д��ĸת��Ϊ_��Сд
          char cur = voName.charAt(i);
          if (Character.isUpperCase(cur)) {
            sb.append("_");
            sb.append(Character.toLowerCase(cur));
          }
          else {
            sb.append(cur);
          }
        }
        return sb.toString();
      }

    /****************
     * ����VO�ֶ����õ���¼���ֶε�����
     *
     * @param voName
     * @return
     */
      public static String getRstFieldName_ByVoFldName(String voName) {
        StringBuffer sb = new StringBuffer();

        sb.append(Character.toUpperCase(voName.charAt(0)));
        for (int i = 1; i < voName.length(); i++) { //����voName����д�д��ĸ�򽫴�д��ĸת��Ϊ_��Сд
              char cur = voName.charAt(i);
              if (Character.isUpperCase(cur)&& i>0 ) {
                sb.append("_");
                sb.append(Character.toUpperCase(cur));
              }
              else {
                sb.append(cur);
              }
            }
            return sb.toString();
          }

      /*****************************
       * ����model���ֶ����õ���¼�е��ֶ�����
       * @param voName
       * @return
       */
      public static String getVoFldName_ByRstFldName(String voName) {
        StringBuffer sb = new StringBuffer();
        sb.append(Character.toLowerCase(voName.charAt(0)));
        for (int i = 1; i < voName.length(); i++) { //����voName����д�д��ĸ�򽫴�д��ĸת��Ϊ_��Сд
          char cur = voName.charAt(i);
          char interval='_';
          if (cur==interval) {
            if (i+1<voName.length()){
                sb.append(Character.toUpperCase(voName.charAt(i+1)));
                i++;
            }
          }
          else {
            sb.append(cur);
          }
        }
        return sb.toString();
      }

      /**
       * ���ж���ת����ֵ����
       * @param row
       * @param typeֵ��������
       * @return
       * @throws java.lang.Exception ������쳣һ����DAO�д�����ΪDAO����
       * �����������Row��ValueObject��ת��
       */
      public static Object map_to_vo(Map row, Class type)  {
        try{

        Object vo = type.newInstance(); //����һ��ֵ����
        Field[] fields = type.getDeclaredFields(); //�õ�ֵ�����������ֶ�

        for (int i = 0; i < fields.length; i++) {
          String name = fields[i].getName(); //�õ�JavaBean���ֶ���
          String nameInRow = getDtoName_ByVo(name);//�ڴ˽���ֵ�������Ƶ��ж������Ƶ�ת��
          Object value = row.get(nameInRow); //�õ������ݿ���ȡ�������ֶ�����Ӧ��ֵ
          if (value ==null) continue;
          String methodName = "set" + Character.toUpperCase(name.charAt(0)) +
              name.substring(1); //�õ�setXXXX������
          Class argClass = null;

          if (value instanceof Class) {
            argClass = (Class)value;
            value = null;

          }else{
            //argClass = value.getClass();
            argClass=fields[i].getType();

          }
          String datatype=fields[i].getType().getName();
          try{//����hibernateӰ���ֵ���������ֶ�,����û��setCustid()����
                if (datatype.equals("java.lang.Long")){
                    Method method = type.getMethod(methodName, new Class[] {argClass}); //�õ�set����
                    method.invoke(vo, new Long[] {new Long(value.toString())});//����setXXXX����
                }
                if (datatype.equals("java.lang.Double")){
                    Method method = type.getMethod(methodName, new Class[] {argClass}); //�õ�set����
                    method.invoke(vo, new Double[] {new Double(value.toString())});//����setXXXX����
                }
                if (datatype.equals("java.lang.Float")){
                    Method method = type.getMethod(methodName, new Class[] {argClass}); //�õ�set����
                    method.invoke(vo, new Float[] {new Float(value.toString())});//����setXXXX����
                }
                if (datatype.equals("java.util.Date")){
                    Method method = type.getMethod(methodName, new Class[] {argClass}); //�õ�set����
                    Date mydate=strToDate(value.toString());
                    method.invoke(vo, new java.util.Date[] {mydate});//����setXXXX����
                }
                if (datatype.equals("java.lang.String")){
                    Method method = type.getMethod(methodName, new Class[] {argClass}); //�õ�set����
                    method.invoke(vo, new Object[] {value});//����setXXXX����
                }

          }catch(Exception e){
            e.printStackTrace();
          }
        }
        return vo;
        }catch(Exception e){
            e.printStackTrace();
        }
        return null;
      }

      /**
       * ���ж���ת����ֵ����
       * @param row
       * @param typeֵ��������
       * @return
       * @throws java.lang.Exception ������쳣һ����DAO�д�����ΪDAO����
       * �����������Row��ValueObject��ת��
       */
      public static Object row_to_vo(Map row, Class type)  {
        try{

        Object vo = type.newInstance(); //����һ��ֵ����

        Field[] fields =type.getDeclaredFields(); //�õ�ֵ�����������ֶ�

        for (int i = 0; i < fields.length; i++) {
          String name = fields[i].getName(); //�õ�JavaBean���ֶ���
          String nameInRow = getRstFieldName_ByVoFldName(name);//�ڴ˽���ֵ�������Ƶ��ж������Ƶ�ת��
          Object value = row.get(nameInRow); //�õ������ݿ���ȡ�������ֶ�����Ӧ��ֵ
          if (value ==null) continue;
          String methodName = "set" + Character.toUpperCase(name.charAt(0)) +
              name.substring(1); //�õ�setXXXX������
          Class argClass = null;

          if (value instanceof Class) {
            argClass = (Class)value;
            value = null;

          }else{
            //argClass = value.getClass();
            argClass=fields[i].getType();

          }
          String datatype=fields[i].getType().getName();
          try{//����hibernateӰ���ֵ���������ֶ�,����û��setCustid()����
                if (datatype.equals("java.lang.Long")){
                    Method method = type.getMethod(methodName, new Class[] {argClass}); //�õ�set����
                    method.invoke(vo, new Long[] {new Long(value.toString())});//����setXXXX����
                }
                if (datatype.equals("java.lang.Double")){
                    Method method = type.getMethod(methodName, new Class[] {argClass}); //�õ�set����
                    method.invoke(vo, new Double[] {new Double(value.toString())});//����setXXXX����
                }
                if (datatype.equals("java.lang.Float")){
                    Method method = type.getMethod(methodName, new Class[] {argClass}); //�õ�set����
                    method.invoke(vo, new Float[] {new Float(value.toString())});//����setXXXX����
                }
                if (datatype.equals("java.util.Date")){
                    Method method = type.getMethod(methodName, new Class[] {argClass}); //�õ�set����
                    Date mydate=strToDate(value.toString());
                    method.invoke(vo, new java.util.Date[] {mydate});//����setXXXX����
                }
                if (datatype.equals("java.lang.String")){
                    Method method = type.getMethod(methodName, new Class[] {argClass}); //�õ�set����
                    method.invoke(vo, new Object[] {value});//����setXXXX����
                }

          }catch(Exception e){
            e.printStackTrace();
          }
        }
        return vo;
        }catch(Exception e){
            e.printStackTrace();
        }
        return null;
      }

      public static Map getShortName_Map(Map map,String tabName)  {
        Iterator ite=map.keySet().iterator();
        Map retMap=new HashMap();
        while(ite.hasNext()){
            String key=(String)ite.next();
            if (key.length()<=tabName.length()) continue;
            String pre=key.substring(0,tabName.length()).toUpperCase();
            if (pre.equals(tabName.toUpperCase())){
                String fieldName=key.substring(tabName.length()+1);
                retMap.put(fieldName,map.get(key));
            }
        }
        return retMap;
      }

      public static Object map_to_Model(Map map,Class type) {
        try{
            Object obj=type.newInstance();
            Iterator ite=map.keySet().iterator();
            Map modelMap=new HashMap();
            while(ite.hasNext()){
                String key=(String)ite.next();
                String voFldName=getVoFldName_ByRstFldName(key);
                modelMap.put(voFldName,map.get(key));
            }

            BeanUtils.copyProperties(obj,modelMap);
            return(obj);
        }catch(Exception e){
            e.printStackTrace();
            return(null);
        }
      }

      public static String getLastToken(String str, String tokenSeparator)
        {
            return str.substring(str.lastIndexOf(tokenSeparator) + 1, str.length());
        }

        public static boolean isNull(String s)
        {
            return s == null || s.length() < 1;
        }

        public static boolean isNull(String s, String val)
        {
            return isNull(s) || s.compareTo(val) == 0;
        }

        public static String stackTrace(Throwable t)
        {
            StringWriter sw = new StringWriter();
            t.printStackTrace(new PrintWriter(sw));
            String s = sw.toString();
            try
            {
                sw.close();
            }
            catch(IOException e)
            {
                cat.error("::stackTrace - cannot close the StringWriter object", e);
            }
            return s;
        }

        public static String dbString(String v)
        {
            StringBuffer sb = new StringBuffer();
            return isNull(v) ? "" : sb.append("'").append(v).append("'").toString();
        }

        public static String dumpHashTable(Hashtable table, boolean html)
        {
            Enumeration keys = table.keys();
            Enumeration values = table.elements();
            StringBuffer sb = new StringBuffer();
            String eof = "\n";
            if(html)
                eof = "<br>\n";
            for(; keys.hasMoreElements(); sb.append("  key [").append(keys.nextElement().toString()).append("] = [").append(values.nextElement().toString()).append("]").append(eof));
            return sb.toString();
        }

        public static String addURLParameter(String URL, String paramName, String paramValue)
        {
            String param = paramName + "=" + paramValue;
            return addURLParameter(URL, param);
        }

        public static String addURLParameter(String URL, String parameter)
        {
            StringBuffer sb = new StringBuffer(URL);
            if(URL.lastIndexOf(63) == -1)
                sb.append("?");
            else
                sb.append("&");
            sb.append(parameter);
            return sb.toString();
        }

        public static String remove(String str, String until)
        {
            String val = null;
            int indx = str.indexOf(until);
            if(indx != -1)
                val = str.substring(indx + until.length(), str.length());
            return val;
        }

        /**
         * @param sSource
         * @param sIntervel
         * ��һ������,(����sIntervel=",")���ַ����ֽ⿪
         * ��emp_id,emp_code,empname�ֽ��õ�
         * �����ַ���emp_id��emp_code��emp_name
         */
        public static List stringMid(String sSource,String sIntervel){
            String sDes="";
            List lst=new ArrayList();
            int nindex;
            while(sSource.length()>0) {
                if (sSource.equals(sIntervel)){
                    break;
                }

                nindex=sSource.indexOf(sIntervel);
                if (nindex<0 && (!sSource.equals(sIntervel))){
                    lst.add(sSource);
                    break;
                }
                sDes=sSource.substring(0,nindex);
                sSource=sSource.substring(nindex+sIntervel.length());

                if (sDes.length()>=sIntervel.length())
                    if (sDes.substring(0,sIntervel.length()).equals(sIntervel)){
                        continue;
                    }else{
                        lst.add(sDes);
                    }
            }
            return(lst);
        }
        /**
         * �õ�һ��MapList��List(��¼������List),��������Map(�������úü�������)
         * @param maplst : Դ��¼��
         * @param mapComp: ����
         * @return
         */
        public static List getSubMapList(List maplst,Map mapComp){
            if (maplst==null || maplst.size()==0) return null;
            if (mapComp==null) return null;

            //�õ����������е�key
            Iterator iteKey=mapComp.keySet().iterator();
            if (iteKey==null) return null;
            List lstKey=new ArrayList();
            while(iteKey.hasNext()) {
                lstKey.add(iteKey.next());
            }
            if (lstKey.size()==0 ) return null;

            //��ʼѭ���Ƚ�
            List lstResult=new ArrayList();
            for(int i=0;i<maplst.size();i++){
                Map oneRow=(Map)maplst.get(i);
                int equalFlag=1; //��ʼ��Ϊ���
                for(int j=0;j<lstKey.size();j++){
                    String key=(String)lstKey.get(j);
                    String val1=getMapKeyVal(oneRow,key);
                    String val2=getMapKeyVal(mapComp,key);
                            if (!val1.equals(val2)) {
                            equalFlag=0;
                            break;
                    }
                }
                if ( equalFlag==1){//���ȫ�����,��������
                    lstResult.add(oneRow);
                }

            }

            return lstResult;
        }
        
        /**
         * ģ�����õ�һ��MapList��List(��¼������List),��������Map(�������úü�������)
         * ֧�ֶ��ŷֿ���(',')
         * @param maplst : Դ��¼��
         * @param mapComp: ����
         * @return
         */
        public static List getBlurSubMapList(List maplst,Map mapComp){
            if (maplst==null || maplst.size()==0) return null;
            if (mapComp==null) return null;

            //�õ����������е�key
            Iterator iteKey=mapComp.keySet().iterator();
            if (iteKey==null) return null;
            List lstKey=new ArrayList();
            while(iteKey.hasNext()) 
            {
                lstKey.add(iteKey.next());
            }
            if (lstKey.size()==0 ) return null;

            //��ʼѭ���Ƚ�
            List lstResult=new ArrayList();
            for(int i=0;i<maplst.size();i++)
            {
                Map oneRow=(Map)maplst.get(i);
                int equalFlag=1; //��ʼ��Ϊ���
                for(int j=0;j<lstKey.size();j++)
                {
                    String key=(String)lstKey.get(j);
                    String val1=getMapKeyVal(oneRow,key);
                    String val2=getMapKeyVal(mapComp,key);
                    if ((","+val1+",").indexOf(","+val2+",")==-1) 
                    {
                      equalFlag=0;
                      break;
                    }
                }
                if ( equalFlag==1)//���ȫ�����,��������
                {
                    lstResult.add(oneRow);
                }
            }
            return lstResult;
        }
        
/*
*�ж��ַ����Ƿ�������
*/
     public  static boolean checkStringIsNum(String cheStr)
 {  
      for(int i=0;i<cheStr.length();i++)
      {
       if( new String("9876543210").indexOf(cheStr.substring(i,i+1)) == -1 )
       return false;
      } 
      return true;
 }

    public static String getMapKeyVal(Map map,String key){
        if (map==null) return "";
        if (key==null) return "";
        Object obj=map.get(key);
        String result;
        if (obj==null){
            result="";
        }else{
            result=obj.toString();
        }
        return result;
    }
    
    public static String getJSONObjectKeyVal(JSONObject object, String key)
    {
	if(object == null)
	{
	    return "";
	}
	if(key == null)
	{
	    return "";
	}
	Object obj = object.get(key);
        String result;
        if (obj == null)
        {
            result = "";
        }
        else
        {
            result = obj.toString();
        }
        return result;
    }
    
    /**
     * <h3>��mapList����columnName���з���</h3>
     * @author rb
     * @param maplst : Դ��¼��
     * @param column: ����
     * @return
     */
    
    public static List sortMapListByColumn(String columnName,List mapList){
        List returnList = new ArrayList();
        if (mapList==null || mapList.size()==0) return returnList;
        List uniqueValList = new ArrayList();
        for(int i=0;i<mapList.size();i++){
            HashMap map = (HashMap) mapList.get(i);
            String columnVal = getMapKeyVal(map,columnName);
            if("".equals(columnVal)){
                return returnList;
            }
            HashMap tempMap = new HashMap();
            tempMap.put(columnName,columnVal);
            if(getSubMapList(uniqueValList,tempMap)==null || 
                    getSubMapList(uniqueValList,tempMap).size()==0){
                uniqueValList.add(tempMap);
            }
        }
        for(int k=0;k<uniqueValList.size();k++){
            HashMap uniqueValMap = (HashMap)uniqueValList.get(k);
            if(getSubMapList(mapList,uniqueValMap)!=null && 
                    getSubMapList(mapList,uniqueValMap).size()!=0){
                returnList.add(getSubMapList(mapList,uniqueValMap));
            }
        }
        return returnList;
    }
    
    /**
     * ��list��ĳ�����ֶ�Ϊkey��ֵ��װ���ַ����ԡ������ָ�
     * @param list
     * @param key
     * @return
     */
    public static String makeColumsToStr(List list , String key,String divide){
		if(list == null || list.size() == 0 || "".equals(key))
		{
			return "";
		}
		String str = "";
		for(int i = 0 ; i < list.size() ; i++){
			Map mapComp = (Map)list.get(i);
			String keyValue = getMapKeyVal(mapComp,key);
			if(i == 0 && list.size()==1){
				str+=keyValue;
			}else if(i<list.size()-1){
				str+=keyValue+divide;
			}else{
				str+=keyValue;
			}
		}
		return str;
	}
    
    /**
     * �ж��ַ����Ƿ�Ϊ�ֻ�����
     * @param String
     * @return boolean
     */
    public static boolean isMobileNO(String mobiles){
    	if(mobiles==null) return false;
        Pattern p = Pattern.compile("^((13[0-9])|(15[^4,\\D])|(18[0,5-9]))\\d{8}$");
        Matcher m = p.matcher(mobiles);
        return m.matches();   
    }
    
    /**
     * �ж��ַ����Ƿ�Ϊ�����ַ
     * @param String
     * @return boolean
     */
    public static boolean isEmail(String email){
    	if(email==null) return false;
    	String str="^([a-zA-Z0-9]*[-_]?[a-zA-Z0-9]+)*@([a-zA-Z0-9]*[-_]?[a-zA-Z0-9]+)+[\\.][A-Za-z]{2,3}([\\.][A-Za-z]{2})?$";
        Pattern p = Pattern.compile(str);
        Matcher m = p.matcher(email);
        return m.matches();
    } 
    
    /**
     * @author : tiankang
     * @param json
     * @return
     * ȡJSONObject�е�ʱ��
     */
    public static Timestamp getTimestampByJT(JSONObject json)
    {
    	Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	if(!ObjectCensor.checkObjectIsNull(json))
    	{	
    		date.setTime(Long.parseLong(StringUtil.getJSONObjectKeyVal(json, "time")));
    		String dateStr = sdf.format(date);
        	Timestamp sta = Timestamp.valueOf(dateStr);
        	return sta;
    	}
    	else
    	{
    		return null;
    	}
    		
    }
    
    /**
     * @author : hzy
     * @param json
     * @param formatStyle
     * @return
     * ȡJSONObject�е�ʱ������Ҫ�ĸ�ʽ �����ַ���
     */
    public static String getTimeByJT(JSONObject json,String formatStyle)
    {
    	Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat(formatStyle);
    	if(!ObjectCensor.checkObjectIsNull(json))
    	{	
    		date.setTime(Long.parseLong(StringUtil.getJSONObjectKeyVal(json, "time")));
    		String dateStr = sdf.format(date);
        	return dateStr;
    	}
    	else
    	{
    		return null;
    	}
    }
    
    /**
     * @author : tiankang
     * @param str
     * @return
     * ���ݱ��ֶ�ת��������
     */
    public static String transDataToObj(String str)
    {
    	int ind;
    	StringBuffer sb = new StringBuffer();
    	for(int i = 0,n = str.length();i < n;i++)
    	{
    		char ch = str.charAt(i);
    		if(ch == '_')
    		{
    			char sr = str.charAt(i+1);
    			sb.append((char)(sr-32));
    		}
    		else
    		{
    			sb.append(ch);
    		}
    	}
    	return sb.toString();
    }
    
    /**
     * @author : tiankang
     * @param str
     * @return
     * ����������ʽת���ݿ�������ʽ
     */
    public static String transObjToData(String str)
    {
    	StringBuffer sb = new StringBuffer();
    	for(int i = 0 , n = str.length();i < n;i++)
    	{
    		char ch = str.charAt(i);
    		if(ch >= 'A' && ch <= 'Z')
    		{
    			sb.append("_"+(char)(ch+32));
    		}
    		else
    		{
    			sb.append(ch);
    		}
    	}
    	return sb.toString();
    }
}
