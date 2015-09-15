<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
	<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
	 
	</head>

	<body>
			 
		<iframe id="frame1" src="/sys/course/linkcourse.jsp" marginwidth=0 marginheight=0 frameborder=0 scrolling="auto" width="100%"></iframe>
		<iframe id="frame2" src="/sys/course/linkcourse.jsp" marginwidth=0 marginheight=0 frameborder=0 scrolling="auto" width="100%"></iframe>
	

	</body>

</html>
