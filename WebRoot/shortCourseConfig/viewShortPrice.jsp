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
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="浏览短期课价格配置">
	 		<table width="95%" align="center" style="margin:5px auto;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
	 			<tr>
  					<td align="right" width="11%">价格体系名称：</td>
  					<td align="left" width="69%">${obj.priceName}</td>
  				</tr>
  				<tr>
  					<td align="right">适用校区：</td>
  					<td align="left">${obj.applySchools}</td>
  				</tr>
  				<tr>
  					<td align="right">生效时间：</td>
  					<td align="left">${obj.effDate}</td>
  				</tr>
  				<tr>
  					<td align="right">状态：</td>
  					<td align="left">${obj.isUseVal}</td>
  				</tr>
  				<tr>
  					<td align="right">创建人：</td>
  					<td align="left">${obj.handerName}</td>
  				</tr>
  				<tr>
  					<td align="right">创建时间：</td>
  					<td align="left">${obj.createDate}</td>
  				</tr>
	 		</table>
	 		<table width="95%" align="center" style="margin:5px auto;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
	 			<tr>
  					<td align="center" width="13%">班级类型</td>
  					<td align="center" width="13%">学费</td>
  					<td align="center" width="13%">材料费</td>
  					<td align="center" width="13%">保育费和餐费</td>
  					<td align="center" width="13%">总部提成</td>
  					<td align="center" width="13%">其他费用</td>
  					<td align="center" width="13%">总费用</td>
  				</tr>
  				<c:forEach items="${retObj.result}" var="result">
  					<tr>
  						<td align="center">${result.classType}</td>
  						<td align="center">${result.feeA}</td>
  						<td align="center">${result.feeB}</td>
  						<td align="center">${result.feeC}</td>
  						<td align="center">${result.feeD}</td>
  						<td align="center">${result.feeE}</td>
  						<td align="center">${result.amount}</td>
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
