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
		<script type="text/javascript">
		   	$(document).ready(function(){
		   		 $("#expAfterDate").datebox("setValue","${obj.expDate}")
		   	});
	   </script>
  	</head>
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="券类赠品延期">
  			<input type="hidden" id="studentGiftId" value="${obj.studentGiftId}" />
  			<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
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
  					<td align="left">${obj.giftCode}</td>
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
  					<td id="expBeforeDate" align="left">${obj.expDate}</td>
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
  					<td align="right"><span>发放操作人：</span></td>
  					<td align="left">${obj.handerName}</td>
  				</tr>
  				<tr>
  					<td align="right"><span>有效期结束时间延长至：</span></td>
  					<td align="left"><input class="easyui-datebox" id="expAfterDate" style="width:120px;height:25px;" /></td>
  					<td align="right"></td>
  					<td align="left"></td>
  				</tr>
  				<tr>
  					<td align="right"><span>延期说明：</span></td>
  					<td align="left" colspan="3"><textarea rows="7" cols="100" id="delayRemark" name="delayRemark" class="easyui-validatebox textbox"></textarea></td>
  				</tr>
  			</table>
  		</div>
 		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="text-align:right">
	      		<a href="javascript:void(0)" id="couponDelaySubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width:100px;" onclick="couponDelaySubmit()"><span>提交</span></a>
	      		&nbsp;
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:100px;" onclick="javascript:window.history.back()"><span>返回</span></a>
	      	</div>
	   </div>
  	</body>
</html>
