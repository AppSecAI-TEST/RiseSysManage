<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="utf-8">
<!-- 
<title>瑞思教务管理系统 - 用户登录</title>
 -->
<%@ include file="/common/head.jsp" %>
<style type="text/css">
body
{
	margin:0;
	padding:0;
	background:#F1ECF4;
	font-family:"Microsoft YaHei"；
}
form{width:340px;height:420px;margin:50px auto;}
label{float:left;display:block;font-size:16px;color:#aba1a4;height:29px;margin:6px 0px 2px 25px;}
.inputDiv{margin:0 auto 30px;background:#F8F5F8;height:37px;border:1px solid #e4e4e2;border-radius:4px;}
#username,#password,#code{font-size:14px;cursor:pointer;height:31px;color:#4b4b5b;background:transparent;margin:2px;padding:0;border:none;-webkit-appearance:none;appearance:none;outline:none;-webkit-tap-highlight-color:transparent;border-radius:0;}
#username,#password{width:250px;}
#code{width:108px;}
.loginttitle
{
	width:100%;
	background:#44C5F6;
	height:75px;
}

#titleimg
{
	margin-top:20px;
}

#loginDiv
{
	width:800px;
	margin:20px auto;
	background:#fff;
	border-radius:8px;
	height:540px;
}

.loginLeft
{
	float:left;
	width:400px;
	text-align:right;
}
.loginRight
{
	float:left;
	width:400px;
}

.righttitle
{
	background:#FABF12;
	height:40px;
	text-align:left;
	 border-top-right-radius:8px;
}
#loginBtn
{
	background:#2194cb;
	padding:10px;
	text-align:center;
	color:#fff;
	font-size:16px;
	cursor:pointer;	
}
</style>
</head>
<body>
<c:if test="${!empty error}">
	<script language="javascript">
		$.messager.alert('提示', '${error}', 'error');
	</script>
</c:if>
<div class="loginttitle"><img id="titleimg" src="<%=path%>/pub/images/logintitle1.png"></div>
<div style="text-align:center;">
	<div id="loginDiv">
		<div class="loginLeft">
			<img src="<%=path%>/pub/images/girl.png" style="margin:32px 28px 0px 0px;">
		</div>
		<div class="loginRight">
			<div class="righttitle"><img src="<%=path%>/pub/images/rightimg.png" style="margin:10px 0px 10px 40px;"></div>
			<form id='form' method="post">
				<div class="inputDiv">
					<label for="username">账户</label>  
			        <input type="text" name="username" id="username" value="" style="background-color:transparent;" />  
				</div>
				<div class="inputDiv">
					<label for="password">密码</label>  
			        <input type="password" name="password" id="password" value="" />  
				</div>
				<div class="inputDiv" style="width:200px;margin:0 0 30px 0;position:relative;">
					<label for="code" style="margin-left:9px;">验证码</label>  
			        <input type="text" name="code" id="code" size="4" />
			        <span style="position:absolute;right:-138px;"><img id="code_img" align="top" width="100" height="35" onclick="changeCode()" src="/sys/auth.do?method=getSecurityImage" title="点击切换验证码"></span> 			        
				</div>
				<div id="loginBtn" onclick="login()">登录</div>
			</form> 
		</div>
	</div>
</div>
<script type="text/javascript">
$(function(){
	$("#titleimg").css("margin-left",$('#loginDiv').offset().left+5);
	$('input:text:first').focus();
	$('form').keyup(function(event){
		if(event.keyCode ==13){
			login();
		}
	});
})
var changeCode = function(){
	var that = document.getElementById('code_img');
	that.src = that.src + '&' + Math.random();
}
var login = function(){
	if(!$('#username').val()){
		$.messager.alert('提示信息', '请填写用户名', 'error');
		return false;
	}
	if(!$('#password').val()){
		$.messager.alert('提示信息', '请填写密码', 'error');
		return false;
	}
	if(!$('#code').val()){
		$.messager.alert('提示信息', '请填写验证码', 'error');
		return false;
	}
	$.messager.progress({text:'登录中，请稍候...'});
	$.post('/sys/auth.do?method=authStaff', $("form").serialize(), function(data){
		$.messager.progress('close');
		if(data != "success"){
			$.messager.alert('提示', data, 'error');
			changeCode();
		}else{
			$.messager.progress({text:'加载中，请稍候...'});
			window.location.href = "/sys/admin.jsp";
		}
	});
}
</script>
</body>
</html>