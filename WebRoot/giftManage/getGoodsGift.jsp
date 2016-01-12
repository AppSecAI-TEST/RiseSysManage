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
		<script type="text/javascript" src="<%=path %>/js/giftManage/goodsGiftManage.js"></script>
  	</head>
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="实物&教材赠品领取">
  		 	<form id="getGoodForm">
	 		<table width="100%" cellpadding="5px" class="maintable" id="getGoodTd">
	 			<tr>
	 				<td align="center"><span>序号</span></td>
	 				<td align="center"><span>来源类型</span></td>
	 				<td align="center"><span>赠品来源</span></td>
	 				<td align="center"><span>赠品名称</span></td>
	 				<td align="center"><span>是否领取</span></td>
	 				<td align="center"><span>赠送时间</span></td>
	 				<td align="center"><span>赠品发放人</span></td>
	 			</tr>
 				<c:forEach items="${obj}" var="goodsGift" varStatus="status">
 					<input type="hidden" name="studentGiftId" value="${goodsGift.studentGiftId}" />
 					<tr>
 						<td align="center">${goodsGift.seq}</td>
 						<td align="center">${goodsGift.giftChannel}</td>
 						<td align="center">${goodsGift.giftChannelDesc}</td>
 						<td align="center">${goodsGift.giftName}</td>
 						<td align="center">${goodsGift.isGet}</td>
 						<td align="center">${goodsGift.createDate}</td>
 						<td align="center"><input name="granter" id="granter${status.index}" type="text" class="easyui-textbox validatebox" required="true" style="width: 100px;"/></td>
 					</tr>
 				</c:forEach>
 				<tr>
     	       	<td align="right"><span>说明：</span></td>
     	       	<td colspan="6"><textarea rows="7" cols="100" id="getRemark" name="getRemark" class="easyui-validatebox textbox"></textarea></td>
     	       	</tr>
	 		</table>
	 		</form>
 		</div>
 		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="text-align:center">
	      		<a href="javascript:void(0)" id="getGoodsGiftSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width:100px;" onclick="getGoodsGiftSubmit()"><span>提交</span></a>
	      		&nbsp;
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:100px;" onclick="javascript:window.history.back()"><span>返回</span></a>
	      	</div>
	   </div>
  	</body>
</html>
