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
form{width:280px;height:120px;margin:30px auto 0;}
form div label{float:left;display:block;width:65px;font-size:16px;padding-top:6px;}
form div{margin:8px auto;}
form div.input input{height:21px;padding:2px 3px;}
form div.input img{cursor:pointer}
#username,#password{width:200px;}
#code{width:68px}
</style>
</head>
<body>
<c:if test="${!empty error}">
	<script language="javascript">
		$.messager.alert('提示', '${error}', 'error');
	</script>
</c:if>
<div class="easyui-dialog" title="用户登录" style="width:380px;height:240px" data-options="closable:false,iconCls:'icons-lock-lock',buttons:[{text:'登录',iconCls:'icons-user-user_go',handler:login}]">
	<form id='form' method="post">
		<div class="input">
			<label for="username">用户名:</label>  
	        <input type="text" name="username" id="username" value="" />  
		</div>
		<div class="input">
			<label for="password">密　码:</label>  
	        <input type="password" name="password" id="password" value="" />  
		</div>
		<div class="input">
			<label for="code">验证码:</label>  
	        <input type="text" name="code" id="code" size="4" />
	        <span style="margin-left:10px"><img id="code_img" align="top" width="100" height="28" onclick="changeCode()" src="/sys/auth.do?method=getSecurityImage" title="点击切换验证码"></span> 
		</div>
	</form> 
</div>
<script type="text/javascript">
$(function(){
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