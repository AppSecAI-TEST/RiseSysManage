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
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="券类赠品兑换">
  			<input type="hidden" id="studentGiftId" value="${obj.studentGiftId}" />
  			<input type="hidden" id="giftName" value="${obj.giftName}" />
  			<form id="exchangeForm">
  			<table width="100%" cellpadding="5px" class="maintable">
  				<tr>
  					<td align="right"><span>赠品来源：</span></td>
  					<td align="left">${obj.giftChannelDesc}</td>
  					<td align="right"><span>赠券类型：</span></td>
  					<td align="left">${obj.giftTypeVal}</td>
  				</tr>
  				<tr>
  					<td align="right"><span>面值：</span></td>
  					<td align="left">${obj.totalAmount}</td>
  					<td align="right"><span>可用金额：</span></td>
  					<td id="amount" align="left">${obj.amount}</td>
  				</tr>
  				<tr>
  					<td align="right"><span>剩余金额：</span></td>
  					<td id="usableAmount" align="left">${obj.usableAmount}</td>
  					<td align="right"><span>赠券编号：</span></td>
  					<td id="giftCode" align="left">${obj.giftCode}</td>
  				</tr>
  				<tr>
  					<td align="right"><span>赠券状态：</span></td>
  					<td align="left">${obj.giftState}</td>
  					<td align="right"><span>是否领取：</span></td>
  					<td align="left">${obj.isGet}</td>
  				</tr>
  				<tr>
  					<td align="right"><span>有效期开始时间：</span></td>
  					<td align="left">${obj.effDate}</td>
  					<td align="right"><span>有效期结束时间：</span></td>
  					<td align="left">${obj.expDate}</td>
  				</tr>
  				<tr>
  					<td align="right"><span>赠送时间：</span></td>
  					<td align="left">${obj.createDate}</td>
  					<td align="right"><span>领取时间：</span></td>
  					<td align="left">${obj.getDate}</td>
  				</tr>
  				<tr>
  					<td align="right"><span>发放人：</span></td>
  					<td align="left">${obj.granter}</td>
  					<td align="right"><span>操作人：</span></td>
  					<td align="left">${obj.handerName}</td>
  				</tr>
  				<tr>
  					<td align="right"><span>本次使用金额：</span><input class="easyui-numberbox" id="useAmount" style="width:80px;" data-options="min:1,max:${obj.usableAmount}" required="true"/></td>
  					<td align="left" colspan="3"><span>购买内容：</span><input class="easyui-textbox"  id="content" style="width:500px;" required="true"/>
  					&nbsp;<span>发放人：</span><input class="easyui-textbox" id="granter" style="width:100px;" required="true"/></td>
  				</tr>
  			</table>
  			</form>
  		</div>
 		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="text-align:right">
	      		<a href="javascript:void(0)" id="couponExchangeSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width:100px" onclick="couponExchangeSubmit()">提交</a>
	      		&nbsp;
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:100px;" onclick="javascript:window.history.back()">返回</a>
	      	</div>
	   </div>
  	</body>
</html>
