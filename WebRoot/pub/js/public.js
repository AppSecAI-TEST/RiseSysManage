var codeNameInfo=null;
jQuery.cookie = function(name, value, options) {   
    if (typeof value != 'undefined') { // name and value given, set cookie
        options = options || {};   
        if (value === null) {   
            value = '';   
            options.expires = -1;   
        }	   
        var expires = '';   
        if (options.expires && (typeof options.expires == 'number' || options.expires.toUTCString)) {   
            var date;   
            if (typeof options.expires == 'number') {   
                date = new Date();   
                date.setTime(date.getTime() + (options.expires * 24 * 60 * 60 * 1000));   
            } else {   
                date = options.expires;   
            }   
            expires = '; expires=' + date.toUTCString(); // use expires
															// attribute,
															// max-age is not
															// supported by IE
        }   
        // CAUTION: Needed to parenthesize options.path and options.domain
        // in the following expressions, otherwise they evaluate to undefined
        // in the packed version for some reason...
        var path = options.path ? '; path=' + (options.path) : '';   
        var domain = options.domain ? '; domain=' + (options.domain) : '';   
        var secure = options.secure ? '; secure' : '';   
        document.cookie = [name, '=', encodeURIComponent(value), expires, path, domain, secure].join('');   
    } else { // only name given, get cookie
        var cookieValue = null;   
        if (document.cookie && document.cookie != '') {   
            var cookies = document.cookie.split(';');   
            for (var i = 0; i < cookies.length; i++) {   
                var cookie = jQuery.trim(cookies[i]);   
                // Does this cookie string begin with the name we want?
                if (cookie.substring(0, name.length + 1) == (name + '=')) {   
                    cookieValue = decodeURIComponent(cookie.substring(name.length + 1));   
                    break;   
                }   
            }   
        }   
        return cookieValue;   
    }   
};  

$(document).ready(function(){
	var sessionId = $.cookie("sessionId");
	if(sessionId != null && sessionId != "" && sessionId != undefined)
	{
		var staffId = $.cookie("staffId");
		if(staffId != null && staffId != "" && staffId != undefined)
		{
			var exp = new Date();
			exp.setTime(exp.getTime() + 30 * 60 * 1000);
			$.cookie("sessionId", sessionId, {expires: exp});
		}
		else
		{
			$.cookie("sessionId", null);
			var url = window.location.href;
			var name = url.substring(url.lastIndexOf("/") + 1);
			if("login.jsp" != name)
			{
				window.location.href = "/sys/index.jsp";
			}
		}
	}
	else
	{
		var url = window.location.href;
		var name = url.substring(url.lastIndexOf("/") + 1);
		if("login.jsp" != name)
		{
			window.location.href = "/sys/index.jsp";
		}
	}
});

function showLoader()
{
	$("<div id='loading'><img src='../pub/images/loadingx.gif'></div>").bPopup({modalClose: false,positionStyle:"fixed",position:[($(document).width()-54)/2,"auto"]});
}

function showChildrenLoader()
{
	$("<div id='loading'><img src='../../pub/images/loadingx.gif'></div>").bPopup({modalClose: false,positionStyle:"fixed",position:[($(document).width()-54)/2,"auto"]});
}

function hideLoader()
{
	$("#loading").bPopup().close();
	$("#loading").remove();
}

function showMessage(val)
{
	$("body").append("<div id='message'>"+val+"</div>");
	$("#message").bPopup({onClose:function(){$(this).remove();},autoClose:1500,modalClose: false})
}

function confirmDelete(value,functionName)
{
	$("<div id='confirm'><div class='confirmTitle'>系统消息</div><div class='confirmContent'>确认删除该条记录?</div><div class='buttonDiv'><span class='button3' onclick='"+functionName+"(\""+value+"\")'>确定</span><span class='button3' onclick='closeConfirm()'>取消</span></div></div>").bPopup({modalClose: false,position:[$(document).width()/2-175,$(document).height()/2-80]});
}

function closeConfirm()
{
	$("#confirm").bPopup().close();
	$("#confirm").remove();
}

function popIframe(width,height,src)
{
	$("#popup_iframe").width(width);
	$("#popup_iframe").height(height);
	$("#popup_iframe").bPopup({modalClose: false,position:[(($(document).width()-width)/2),50],modal:true});
	$("#popup_iframe").attr("src",src);
}

function closePopIframe()
{
	$("#popup_iframe").bPopup().close();
	$("#popup_iframe").attr("src","");
}

function initCodeNameInfo()
{
	$.ajax
	({
		type : "POST",
		url : "/sys/abilityInstanceManage.htm?method=getCodeNameInfo",
		async:false,
		dataType:"json",
		success: function(data) 
		{
			codeNameInfo =data;
		}
	});	
}

function getSelectOptions(codeType)
{
	if(codeNameInfo==null)
	{
		initCodeNameInfo();
	}
	var str ="";
	$.each(codeNameInfo,function(i,obj){
		if(obj.codeType==codeType)
		{
			str+="<option value='"+obj.codeFlag+"'>"+obj.codeName+"</option>";
		}
	});
	return str;
}

function getSelectOptionsWithValue(codeType,value)
{
	if(codeNameInfo==null)
	{
		initCodeNameInfo();
	}
	var str ="";
	$.each(codeNameInfo,function(i,obj){
		if(obj.codeType==codeType)
		{
			if(value==obj.codeFlag)
			{
				str+="<option value='"+obj.codeFlag+"' selected='true'>"+obj.codeName+"</option>";
			}
			else
			{
				str+="<option value='"+obj.codeFlag+"'>"+obj.codeName+"</option>";
			}	
		}
	});
	return str;
	
	
}


function getTypeRelName(codeType,codeFlag)
{
	if(codeNameInfo==null)
	{
		initCodeNameInfo();
	}
	var str =codeFlag;
	$.each(codeNameInfo,function(i,obj){
		if(obj.codeType==codeType&&obj.codeFlag==codeFlag)
		{
			str=obj.codeName;
			return false;
		}
	});
	return str;
}


function getNameRelType(codeType,codeName)
{
	if(codeNameInfo==null)
	{
		initCodeNameInfo();
	}
	var str =codeName;
	$.each(codeNameInfo,function(i,obj){
		if(obj.codeType==codeType&&obj.codeName==codeName)
		{
			str=obj.codeType;
			return false;
		}
	});
	return str;
}

function reloadTypeCode(val)
{
	$.ajax({
		type : "POST",
		url : "/sys/business.htm?method=qryParentTypeCode",
		data : "typeLevel=2",
		dataType : "json",
		async : false,
		success : function(msg) 
		{
			if(msg != null && msg != undefined)
			{
				$("#" + val).empty();
				$("#" + val).append("<option value=''>全部</option>"); 
				$.each(msg, function(i, obj){
					$("#" + val).append("<option value='"+obj.typeCode+"'>"+obj.typeName+"</option>"); 
				});
			}
		}
	});
}

function getDownLoadLink(name, url)
{
	if(name == undefined || name == "" || name == "null" || name == "-1")
	{
		return "";
	}
	else
	{
		return "<a href='"+url+"'>"+name+"</a>";
	}	
}

function EncodeUtf8(s1)  
{  
    // escape�������ڶԳ�Ӣ����ĸ����ַ���б��롣�硰Visit W3School!��->"Visit%20W3School%21"
    var s = escape(s1);  
    var sa = s.split("%");// sa[1]=u6211
    var retV ="";  
    if(sa[0] != "")  
    {  
        retV = sa[0];  
    }  
    for(var i = 1; i < sa.length; i ++)  
    {  
        if(sa[i].substring(0,1) == "u")  
        {  
            retV += Hex2Utf8(Str2Hex(sa[i].substring(1,5)));  
            if(sa[i].length>=6)  
            {  
                retV += sa[i].substring(5);  
            }  
        }  
        else retV += "%" + sa[i];  
    }  
    return retV;  
}  

function Str2Hex(s)  
{  
    var c = "";  
    var n;  
    var ss = "0123456789ABCDEF";  
    var digS = "";  
    for(var i = 0; i < s.length; i ++)  
    {  
        c = s.charAt(i);  
        n = ss.indexOf(c);  
        digS += Dec2Dig(eval(n));  
          
    }  
    // return value;
    return digS;  
}  

function Dec2Dig(n1)  
{  
    var s = "";  
    var n2 = 0;  
    for(var i = 0; i < 4; i++)  
    {  
        n2 = Math.pow(2,3 - i);  
        if(n1 >= n2)  
        {  
            s += '1';  
            n1 = n1 - n2;  
        }  
        else  
        s += '0';  
          
    }  
    return s;  
}  

function Dig2Dec(s)  
{  
    var retV = 0;  
    if(s.length == 4)  
    {  
        for(var i = 0; i < 4; i ++)  
        {  
            retV += eval(s.charAt(i)) * Math.pow(2, 3 - i);  
        }  
        return retV;  
    }  
    return -1;  
}  

function Hex2Utf8(s)  
{  
    var retS = "";  
    var tempS = "";  
    var ss = "";  
    if(s.length == 16)  
    {  
        tempS = "1110" + s.substring(0, 4);  
        tempS += "10" +  s.substring(4, 10);  
        tempS += "10" + s.substring(10,16);   
        var sss = "0123456789ABCDEF";   
        for(var i = 0; i < 3; i ++)   
        {
            retS += "%";   
            ss = tempS.substring(i * 8, (eval(i)+1)*8);   
            retS += sss.charAt(Dig2Dec(ss.substring(0,4)));   
            retS += sss.charAt(Dig2Dec(ss.substring(4,8)));   
        }   
        return retS;   
    }   
    return "";   
}



//身份证校验,成功返回true
function validateIdCard(obj)
{	
 var aCity={11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",21:"辽宁",22:"吉林",23:"黑龙江",31:"上海",32:"江苏",33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",42:"湖北",43:"湖南",44:"广东",45:"广西",46:"海南",50:"重庆",51:"四川",52:"贵州",53:"云南",54:"西藏",61:"陕西",62:"甘肃",63:"青海",64:"宁夏",65:"新疆",71:"台湾",81:"香港",82:"澳门",91:"国外"};
  var iSum = 0;
 //var info = "";
 var strIDno = obj;
 var idCardLength = strIDno.length;
 if(!/^\d{17}(\d|x)$/i.test(strIDno)&&!/^\d{15}$/i.test(strIDno))
        return false; //非法身份证号

 if(aCity[parseInt(strIDno.substr(0,2))]==null)
 return false;// 非法地区

  // 15位身份证转换为18位
 if (idCardLength==15)
 {
    sBirthday = "19" + strIDno.substr(6,2) + "-" + Number(strIDno.substr(8,2)) + "-" + Number(strIDno.substr(10,2));
  var d = new Date(sBirthday.replace(/-/g,"/"))
  var dd = d.getFullYear().toString() + "-" + (d.getMonth()+1) + "-" + d.getDate();
  if(sBirthday != dd)
                return false; //非法生日
              strIDno=strIDno.substring(0,6)+"19"+strIDno.substring(6,15);
              strIDno=strIDno+GetVerifyBit(strIDno);
 }

       // 判断是否大于2078年，小于1900年
       var year =strIDno.substring(6,10);
       if (year<1900 || year>2078 )
           return false;//非法生日

    //18位身份证处理

   //在后面的运算中x相当于数字10,所以转换成a
    strIDno = strIDno.replace(/x$/i,"a");

  sBirthday=strIDno.substr(6,4)+"-"+Number(strIDno.substr(10,2))+"-"+Number(strIDno.substr(12,2));
  var d = new Date(sBirthday.replace(/-/g,"/"))
  if(sBirthday!=(d.getFullYear()+"-"+ (d.getMonth()+1) + "-" + d.getDate()))
                return false; //非法生日
    // 身份证编码规范验证
  for(var i = 17;i>=0;i --)
   iSum += (Math.pow(2,i) % 11) * parseInt(strIDno.charAt(17 - i),11);
  if(iSum%11!=1)
                return false;// 非法身份证号

   // 判断是否屏蔽身份证
    var words = new Array();
    words = new Array("11111119111111111","12121219121212121");

    for(var k=0;k<words.length;k++){
        if (strIDno.indexOf(words[k])!=-1){
            return false;
        }
    }

 return true;
}

//返回第十八位身份证号
function GetVerifyBit(str)
{
	var sum = 0;
	var j=0;
	var v = new Array();
	var r = -1;
	var vs = "10X98765432";
	v.push(2, 4, 8, 5, 10, 9, 7, 3, 6, 1, 2, 4, 8, 5, 10, 9, 7);
	for (var i = 16; i >= 0; i--)
	{
		sum += parseInt(str.substring(i, i + 1))* v[j];
		j++;
	}
	r = sum%11;
	return vs.charAt(r);
}