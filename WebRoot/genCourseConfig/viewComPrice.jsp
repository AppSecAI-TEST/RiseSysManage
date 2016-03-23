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
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="浏览课程价格配置">
	 		<table width="95%" align="center" style="margin:5px auto;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
	 			<tr>
  					<td align="right" width="11%"><span>价格体系名称：</span></td>
  					<td align="left" width="69%">${obj.priceName}</td>
  				</tr>
  				<tr>
  					<td align="right"><span>适用校区：</span></td>
  					<td align="left">${obj.applySchools}</td>
  				</tr>
  				<tr>
  					<td align="right"><span>生效时间：</span></td>
  					<td align="left">${obj.effDate}</td>
  				</tr>
  				<tr>
  					<td align="right"><span>状态：</span></td>
  					<td align="left">${obj.isUseVal}</td>
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
  					<td align="center" width="11%"><span>课程阶段</span></td>
  					<td align="center" width="7%"><span>年级</span></td>
  					<td align="center" width="9%"><span>班级类型</span></td>
  					<td align="center" width="9%"><span>学费</span></td>
  					<td align="center" width="9%"><span>材料费</span></td>
  					<td align="center" width="9%"><span>保育费和餐费</span></td>
  					<td align="center" width="9%"><span>总部提成</span></td>
  					<td align="center" width="9%"><span>其他费用</span></td>
  					<td align="center" width="8%"><span>总费用</span></td>
  				</tr>
  				<c:forEach items="${retObj.result}" var="result">
  					<tr>
  						<td align="center">${result.stageId}</td>
  						<td align="center">${result.seqOrder}</td>
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
	      	<div style="text-align:right">
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:100px;" onclick="javascript:window.history.back()"><span>返回</span></a>
	      	</div>
	   </div>
  	</body>
</html>
