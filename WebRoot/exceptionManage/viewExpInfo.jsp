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
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="异动维护信息浏览">
 			 <table width="100%" cellpadding="5px" class="maintable">
				<tr>
					<td align="center"><span>维护人</span></td>
					<td align="center"><span>跟进时间</span></td>
					<td align="center"><span>异动类型</span></td>
					<td align="center"><span>跟进记录</span></td>
				</tr>
				<c:forEach items="${obj.expInfo}" var="expInfo">
					<tr>
						<td align="center"><span>${expInfo.handlerName}</span></td>
						<td align="center"><span>${expInfo.createDate}</span></td>
						<td align="center"><span>${expInfo.exceptionTypeVal}</span></td>
						<td align="center"><span>${expInfo.remark}</span></td>
					</tr>
				</c:forEach>
			</table>
 		</div>
 		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="text-align:center">
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:100px;" onclick="javascript:window.history.back()"><span>返回</span></a>
	      	</div>
	   </div>
  	</body>
</html>
