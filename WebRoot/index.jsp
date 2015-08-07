<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
  		<link type="text/css" rel="stylesheet" href="<%=path%>/pub/css/pub.css"/>
  		<script type="text/javascript" src="<%=path %>/pub/js/jquery-1.11.1.min.js"></script>
  		<script type="text/javascript" src="<%=path %>/pub/js/public.js"></script>
    	<script type="text/javascript" src="<%=path %>/pub/js/bpopup.js"></script>
  		<script type="text/javascript">
  			top.window.location.href = "/sys/login.jsp";
  		</script>
  	</head>
  
  	<body>
  		
  	</body>
</html>
