<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/pub/js/json.js"></script>
		<script type="text/javascript" src="<%=path %>/pub/js/json2.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=path %>/pub/css/style.css">
  	</head>
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="异动维护信息浏览">
 			 <table width="100%" cellpadding="5px" class="maintable">
				<tr>
					<td align="center">维护人</td>
					<td align="center">跟进时间</td>
					<td align="center">异动类型</td>
					<td align="center">跟进记录</td>
				</tr>
				<c:forEach items="${obj.expInfo}" var="expInfo">
					<tr>
						<td align="center">${expInfo.handlerName}</td>
						<td align="center">${expInfo.createDate}</td>
						<td align="center">${expInfo.exceptionTypeVal}</td>
						<td align="center">${expInfo.remark}</td>
					</tr>
				</c:forEach>
			</table>
 		</div>
 		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="float: right;">
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
	      	</div>
	   </div>
  	</body>
</html>
