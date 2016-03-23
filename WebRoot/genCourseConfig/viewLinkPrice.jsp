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
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="浏览连报优惠配置">
	 		<table width="95%" align="center" style="margin:5px auto;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
	 			<tr>
  					<td align="right" width="11%"><span>连报优惠体系名称：</span></td>
  					<td align="left" width="69%">${obj.priceName}</td>
  				</tr>
  				<tr>
  					<td align="right"><span>状态：</span></td>
  					<td align="left">${obj.isUseVal}</td>
  				</tr>
  				<tr>
  					<td align="right"><span>适用校区：</span></td>
  					<td align="left">${obj.applySchools}</td>
  				</tr>
  				<tr>
  					<td align="right"><span>开始时间：</span></td>
  					<td align="left">${obj.effDate}</td>
  				</tr>
  				<tr>
  					<td align="right"><span>结束时间：</span></td>
  					<td align="left">${obj.expDate}</td>
  				</tr>
  				<tr>
  					<td align="right"><span>创建人：</span></td>
  					<td align="left">${obj.handerName}</td>
  				</tr>
  				<tr>
  					<td align="right"><span>创建时间：</span></td>
  					<td align="left">${obj.createDate}</td>
  				</tr>
	 		</table>
	 		<table width="95%" align="center" style="margin:5px auto;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
	 			<tr>
  					<td align="center" width="30%"><span>连报优惠名称</span></td>
  					<td align="center" width="20%"><span>年数</span></td>
  					<td align="center" width="30%"><span>现金优惠额度</span></td>
  				</tr>
  				<c:forEach items="${retObj.result}" var="result">
  					<tr>
  						<td align="center">${result.linkName}</td>
  						<td align="center">${result.linkNum}</td>
  						<td align="center">${result.favorPrice}</td>
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
