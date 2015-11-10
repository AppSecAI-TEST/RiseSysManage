<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="教师档案信息">
  			<table width="100%" cellpadding="5px" class="maintable" id="teacherTd">
  				<tr>
  					<td align="right">校区：</td>
  					<td align="left">${obj.schoolName}</td>
  					<td align="right">教师姓名：</td>
  					<td align="left">${obj.teacherName}</td>
  					<td align="right">英文名：</td>
  					<td align="left">${obj.byname}</td>
  				</tr>
  				<tr>
  					<td align="right">联系电话：</td>
  					<td align="left">${obj.phone}</td>
  					<td align="right">入职日期：</td>
  					<td align="left">${obj.joinDate}</td>
  					<td align="right">入职时长（月）：</td>
  					<td align="left">${obj.joinTime}</td>
  				</tr>
  				<tr>
  					<td align="right">教师状态：</td>
  					<td align="left">${obj.stateVal}</td>
  					<td align="right">职务：</td>
  					<td align="left">${obj.postVal}</td>
  					<td align="right">国籍：</td>
  					<td align="left">${obj.nationality}</td>
  				</tr>
  			  	<tr>
  					<td align="right">持证情况：</td>
  					<c:if test="${obj.licenses == ''}">
  						<td align="left">无</td>
  					</c:if>
  					<c:if test="${obj.licenses != ''}">
	  					<td align="left">${obj.licenses}</td>
  					</c:if>
  					<td align="right">持证数量：</td>
  					<td align="left">${licenseNum}</td>
  					<td align="right">在读带班班级：</td>
  					<c:if test="${obj.classNames == ''}">
  						<td align="left">无</td>
  					</c:if>
  					<c:if test="${obj.classNames != ''}">
	  					<td align="left">${obj.classNames}</td>
  					</c:if>
  				</tr>
  				<tr>
  					<td align="right">在读带班阶段：</td>
  					<c:if test="${obj.stageIds == ''}">
  						<td align="left">无</td>
  					</c:if>
  					<c:if test="${obj.stageIds != ''}">
	  					<td align="left">${obj.stageIds}</td>
  					</c:if>
  					<td align="right">待培训阶段：</td>
  					<td align="left"></td>
  					<td align="right">在读带班持证率：</td>
  					<td align="left">${rate}</td>
  				</tr>
  			</table>
  			<c:if test="${fn:length(retObj.changeInfo) > 0}">
  				<table width="100%" cellpadding="5px" style="margin-top: 5px;margin-bottom: 5px;border-top: 1px solid #ccc;" class="maintable">
	  				<tr>
	  					<td width="15%" align="center">操作类型</td>
	  					<td width="10%" align="center">操作人</td>
	  					<td width="15%" align="center" >操作时间</td>
	  					<td width="60%" align="center">备注说明</td>
	  				</tr>
	  				<c:forEach items="${retObj.changeInfo}" var="changeInfo">
		  				<tr>
							<td align="center">${changeInfo.operName}</td>
							<td align="center">${changeInfo.handlerName}</td>
							<td align="center">${changeInfo.createDate}</td>
							<td align="center">${changeInfo.description}</td>
						</tr>
	  				</c:forEach>
  				</table>
  			</c:if>
  		</div>
 		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="float: right;">
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
	      	</div>
	   </div>
  	</body>
</html>
