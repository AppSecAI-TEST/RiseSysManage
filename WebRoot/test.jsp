<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>
<!doctype html>
<html>
	<head>
		<title>例子</title>
		<%@ include file="common/head.jsp" %>
		<%@ include file="common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/pub/js/easyui/src/jquery.form.js"></script>
	</head>
	<body>
		<div id ="ff">
			<form id="fff">
			<select class="easyui-combobox">
				<option>1</option>
				<option>2</option>
				<option>3</option>
			</select>
			<input type="text" class="easyui-textbox">
			<input type="text" class="easyui-datebox" id="aaa" required="true">
			<input type="radio">11111
			<input type="checkbox">11111
			</form>
			<a onclick="clearForm()">清空清空</a>
		 </div>	
	</body>
</html>	
<script>
	function clearForm(){$("#fff").form("clear")};
</script>