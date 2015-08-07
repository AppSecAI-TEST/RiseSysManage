<%@page	import="org.springframework.security.authentication.BadCredentialsException"%> 
<%@page language="java" import="java.util.*" pageEncoding="UTf-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<base href="<%=basePath%>">
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<script type="text/javascript" src="<%=path %>/pub/js/jquery.min.js"></script>
<title>XXXXX</title>

</head>
<style type="text/css">
body {
	background-color:#fffff;
	margin: 0px;
	padding: 0px;
}
</style>
<body style="height:100%">
	<table width="100%" height="100%">
	<tr>
		<td align="center">
			<table align='center' class='table-3' border="1" height="120" cellpadding="1" cellspacing="1">
				<tr>
					<td align="center" bgcolor="#9220" width="400" > 连接超时</td>
				</tr>
				<tr>
					<td align="center" width="400">抱歉，连接超时。<span style="color:red;" id="time"></span></td>
				</tr>
				<tr>
					<td align="center" width="400">
						<form action="/logout" method="post" target="_top" id="myForm">
							<input type="submit" value="重新登录">
						</form>
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>
</body>
</html>
<script type="text/javascript">
var wait = 5; //设置秒数(单位秒)
var inter;
$(document).ready(function(){
	$("#time").html(wait);
	inter = setInterval("run()",1000);
});

function run(){
	wait--;
	if(parseInt(wait) < 0){
		clearInterval(inter);
		document.getElementById("myForm").submit();
		return;
	}
	$("#time").html(wait);
}
</script>
