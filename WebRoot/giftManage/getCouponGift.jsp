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
		<script type="text/javascript" src="<%=path %>/js/giftManage/couponGiftManage.js"></script>
		<link rel="stylesheet" type="text/css" href="<%=path %>/pub/css/style.css">
  	</head>
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="券类赠品领取">
  		 	<form id="getCouponForm">
	 		<table width="100%" cellpadding="5px" class="maintable" id="getCouponTd">
	 			<tr>
	 				<td align="center">序号</td>
	 				<td align="center">来源类型</td>
	 				<td align="center">赠品来源</td>
	 				<td align="center">赠券类型</td>
	 				<td align="center">面值</td>
	 				<td align="center">可用金额</td>
	 				<td align="center">剩余金额</td>
	 				<td align="center">赠送时间</td>
	 				<td align="center">是否领取</td>
	 				<td align="center">赠品发放人</td>
	 				<td align="center">有效开始日期</td>
	 			</tr>
 				<c:forEach items="${obj}" var="couponGift" varStatus="status">
 					<input type="hidden" name="studentGiftId" value="${couponGift.studentGiftId}" />
 					<input type="hidden" id="expInfo${status.index}" value="${couponGift.expInfo}" />
 					<tr>
 						<td align="center">${couponGift.seq}</td>
 						<td align="center">${couponGift.giftChannel}</td>
 						<td align="center">${couponGift.giftChannelDesc}</td>
 						<td align="center">${couponGift.giftTypeVal}</td>
 						<td align="center">${couponGift.totalAmount}</td>
 						<td align="center">${couponGift.amount}</td>
 						<td align="center">${couponGift.usableAmount}</td>
 						<td align="center">${couponGift.createDate}</td>
 						<td align="center">${couponGift.isGet}</td>
 						<td align="center"><input name="granter" id="granter${status.index}" type="text" class="easyui-textbox validatebox" required="true" style="width: 100px;"/></td>
 						<td align="center"><input name="giftEffDate" id="giftEffDate${status.index}" class="easyui-datebox" required="true" style="width: 100px;" /></td>
 					</tr>
 				</c:forEach>
 				<tr>
     	       	<td align="right"><span>说明：</span></td>
     	       	<td colspan="10"><textarea rows="7" cols="100" id="getRemark" name="getRemark" class="easyui-validatebox textbox"></textarea></td>
     	       	</tr>
	 		</table>
	 		</form>
 		</div>
 		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="float: right;">
	      		<a href="javascript:void(0)" id="getCouponGiftSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;" onclick="getCouponGiftSubmit()">提交</a>
	      		&nbsp;
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
	      	</div>
	   </div>
  	</body>
</html>
