<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String headPath = request.getContextPath();
%>
<link href="<%=headPath %>/pub/js/easyui/themes/icon.css" rel="stylesheet" type="text/css"/>
<script type="text/javascript" src="<%=headPath %>/pub/js/jquery.min.js"></script>
<script type="text/javascript" src="<%=headPath %>/pub/js/jquery.cookie.js"></script>
<script type="text/javascript" src="<%=headPath %>/pub/js/jquery.json.min.js"></script>
<script type="text/javascript" src="<%=headPath %>/pub/js/easyui/jquery.easyui.min.js"></script>
<script type="text/javascript" src="<%=headPath %>/pub/js/easyui/locale/easyui-lang-zh_CN.js"></script>
<script type="text/javascript" src="<%=headPath %>/pub/js/calendar.js"></script>
<%@ include file="theme.jsp" %>