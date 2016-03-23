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
		<script type="text/javascript" src="<%=path %>/js/giftManage/couponGiftManage.js"></script>
  	</head>
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="券类赠品领取">
  		 	<form id="getCouponForm">
	 		<table width="100%" cellpadding="5px" class="maintable" id="getCouponTd">
	 			<tr>
	 				<td align="center"><span>序号</span></td>
	 				<td align="center"><span>来源类型</span></td>
	 				<td align="center"><span>赠品来源</span></td>
	 				<td align="center"><span>赠券类型</span></td>
	 				<td align="center"><span>面值</span></td>
	 				<td align="center"><span>可用金额</span></td>
	 				<td align="center"><span>剩余金额</span></td>
	 				<td align="center"><span>赠送时间</span></td>
	 				<td align="center"><span>是否领取</span></td>
	 				<td align="center"><span>赠券编号</span></td>
	 				<td align="center"><span>赠品发放人</span></td>
	 				<td align="center"><span>有效开始日期</span></td>
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
 						<td align="center"><input name="giftCode" id="giftCode${status.index}" type="text" class="easyui-textbox validatebox" required="true" style="width: 100px;"/></td>
 						<td align="center"><input name="granter" id="granter${status.index}" type="text" class="easyui-textbox validatebox" required="true" style="width: 100px;"/></td>
 						<td align="center"><input name="giftEffDate" id="giftEffDate${status.index}" class="easyui-datebox" required="true" style="width: 100px;" /></td>
 					</tr>
 				</c:forEach>
 				<tr>
     	       	<td align="right"><span>说明：</span></td>
     	       	<td colspan="11"><textarea rows="7" cols="100" id="getRemark" name="getRemark" class="easyui-validatebox textbox"></textarea></td>
     	       	</tr>
	 		</table>
	 		</form>
 		</div>
 		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="text-align:right">
	      		<a href="javascript:void(0)" id="getCouponGiftSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width:100px;" onclick="getCouponGiftSubmit()"><span>提交</span></a>
	      		&nbsp;
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:100px;" onclick="javascript:window.history.back()"><span>返回</span></a>
	      	</div>
	   </div>
  	</body>
</html>
