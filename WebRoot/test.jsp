<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>
<!doctype html>
<html>
	<head>
		<title>例子1</title>
	</head>
	<body>
	</body>
</html>
<script>
	var param={};
	for(var i=0;i<10;i++)
	{
		param[i+""]=i;
	}
	alert(JSON.stringify(param))
</script>