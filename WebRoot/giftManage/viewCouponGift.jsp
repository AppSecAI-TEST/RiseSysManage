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
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="券类赠品浏览">
  			<table width="100%" cellpadding="5px" class="maintable">
  				<tr>
  					<td align="right">赠品来源：</td>
  					<td align="left">${obj.giftChannelDesc}</td>
  					<td align="right">赠券类型：</td>
  					<td align="left">${obj.giftTypeVal}</td>
  				</tr>
  				<tr>
  					<td align="right">面值：</td>
  					<td align="left">${obj.totalAmount}</td>
  					<td align="right">可用金额：</td>
  					<td id="amount" align="left">${obj.amount}</td>
  				</tr>
  				<tr>
  					<td align="right">剩余金额：</td>
  					<td align="left">${obj.usableAmount}</td>
  					<td align="right">赠券编号：</td>
  					<td align="left">${obj.giftCode}</td>
  				</tr>
  				<tr>
  					<td align="right">赠券状态：</td>
  					<td align="left">${obj.giftState}</td>
  					<td align="right">是否领取：</td>
  					<td align="left">${obj.isGet}</td>
  				</tr>
  				<tr>
  					<td align="right">有效期开始时间：</td>
  					<td align="left">${obj.effDate}</td>
  					<td align="right">有效期结束时间：</td>
  					<td align="left">${obj.expDate}</td>
  				</tr>
  				<tr>
  					<td align="right">赠送时间：</td>
  					<td align="left">${obj.createDate}</td>
  					<td align="right">领取时间：</td>
  					<td align="left">${obj.getDate}</td>
  				</tr>
  				<tr>
  					<td align="right">发放人：</td>
  					<td align="left">${obj.granter}</td>
  					<td align="right">发放操作人：</td>
  					<td align="left">${obj.handerName}</td>
  				</tr>
  			</table>
  			<table width="100%" cellpadding="5px" style="margin-top: 5px;border-top: 1px solid #ccc;" class="maintable">
  				<tr>
  					<td width="5%" align="center">序号</td>
  					<td width="10%" align="center">延期操作人</td>
  					<td width="20%" align="center">操作时间</td>
  					<td width="20%" align="center">前有效期结束时间</td>
  					<td width="20%" align="center">调整后有效期结束时间</td>
  					<td width="25%" align="center" >延期说明</td>
  				</tr>
  				<c:forEach items="${retObj.delayInfo}" var="delayInfo" varStatus="status">
					<tr>
						<td align="center">${status.count}</td>
						<td align="center">${delayInfo.handlerName}</td>
						<td align="center">${delayInfo.createDate}</td>
						<td align="center">${delayInfo.expBeforeDate}</td>
						<td align="center">${delayInfo.expAfterDate}</td>
						<td align="center">${delayInfo.description}</td>
					</tr>
				</c:forEach>
  			</table>
  			<table width="100%" cellpadding="5px" style="margin-top: 5px;border-top: 1px solid #ccc;" class="maintable">
  				<tr>
  					<td width="5%" align="center">序号</td>
  					<td width="10%" align="center" >兑换操作人</td>
  					<td width="20%" align="center">兑换时间</td>
  					<td width="20%" align="center">使用前余额</td>
  					<td width="20%" align="center">使用后余额</td>
  					<td width="25%" align="center">兑换内容</td>
  				</tr>
  				<c:forEach items="${retObj.exchangeInfo}" var="exchangeInfo" varStatus="status">
					<tr>
						<td align="center">${status.count}</td>
						<td align="center">${exchangeInfo.handlerName}</td>
						<td align="center">${exchangeInfo.createDate}</td>
						<td align="center">${exchangeInfo.beforAmount}</td>
						<td align="center">${exchangeInfo.leftAmount}</td>
						<td align="center">${exchangeInfo.description}</td>
					</tr>
				</c:forEach>
  			</table>
  			<table width="100%" cellpadding="5px" style="margin-top: 5px;margin-bottom: 5px;border-top: 1px solid #ccc;" class="maintable">
  				<tr>
  					<td width="5%" align="center">序号</td>
  					<td width="10%" align="center">作废操作人</td>
  					<td width="20%" align="center" >作废时间</td>
  					<td width="65%" align="center">作废说明</td>
  				</tr>
  				<c:if test="${fn:length(retObj.invalidInfo) > 0}">
	  				<tr>
						<td align="center">1</td>
						<td align="center">${retObj.invalidInfo.handlerName}</td>
						<td align="center">${retObj.invalidInfo.rtnDate}</td>
						<td align="center">${retObj.invalidInfo.rtnRemark}</td>
					</tr>
  				</c:if>
  			</table>
  		</div>
 		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="float: right;">
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
	      	</div>
	   </div>
  	</body>
</html>
