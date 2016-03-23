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
  	</head>
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="持证信息浏览">
	 		<table width="95%" align="center" style="margin:5px auto;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
	 			<tr>
  					<td align="center" width="25%"><span>课程阶段</span></td>
  					<td align="center" width="20%"><span>持证开始时间</span></td>
  					<td align="center" width="20%"><span>操作人</span></td>
  					<td align="center" width="25%"><span>操作时间</span></td>
  				</tr>
  				<c:forEach items="${obj.license}" var="license">
					<tr>
						<td align="center">${license.stageId}</td>
						<td align="center">${license.startDate}</td>
						<td align="center">${license.handlerName}</td>
						<td align="center">${license.createDate}</td>
					</tr>
				</c:forEach>
	 		</table>
 		</div>
 		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="text-align:right">
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:100px;" onclick="javascript:window.history.back()"><span>返回</span></a>
	      	</div>
	   </div>
  	</body>
</html>
