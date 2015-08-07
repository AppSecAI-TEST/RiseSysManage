<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
  		<%@ include file="common/head.jsp" %>
  	</head>
  
  	<body>
  		<p align="center">
  			<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="javascript:$.messager.alert('提示', '搞起!搞起!');">确定</a>
  		</p>
  	</body>
</html>
