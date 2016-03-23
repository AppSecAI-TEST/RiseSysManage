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
  	</head>
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="券类赠品浏览">
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
  					<td align="left">${obj.usableAmount}</td>
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
  					<td align="right"><span>发放操作人：</span></td>
  					<td align="left">${obj.handerName}</td>
  				</tr>
  			</table>
  			<table width="100%" cellpadding="5px" style="margin-top: 5px;border-top: 1px solid #ccc;" class="maintable">
  				<tr>
  					<td width="5%" align="center"><span>序号</span></td>
  					<td width="10%" align="center"><span>延期操作人</span></td>
  					<td width="20%" align="center"><span>操作时间</span></td>
  					<td width="20%" align="center"><span>前有效期结束时间</span></td>
  					<td width="20%" align="center"><span>调整后有效期结束时间</span></td>
  					<td width="25%" align="center"><span>延期说明</span></td>
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
  					<td width="5%" align="center"><span>序号</span></td>
  					<td width="10%" align="center"><span>兑换操作人</span></td>
  					<td width="20%" align="center"><span>兑换时间</span></td>
  					<td width="20%" align="center"><span>使用前余额</span></td>
  					<td width="20%" align="center"><span>使用后余额</span></td>
  					<td width="25%" align="center"><span>兑换内容</span></td>
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
  					<td width="5%" align="center"><span>序号</span></td>
  					<td width="10%" align="center"><span>作废操作人</span></td>
  					<td width="20%" align="center"><span>作废时间</span></td>
  					<td width="65%" align="center"><span>作废说明</span></td>
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
	      	<div style="text-align:right">
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:100px;" onclick="javascript:window.history.back()"><span>返回</span></a>
	      	</div>
	   </div>
  	</body>
</html>
