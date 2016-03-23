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
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="实物&教材赠品浏览">
	 		<table width="100%" cellpadding="5px" class="maintable">
	 			<tr>
  					<td align="right" width="20%"><span>来源类型：</span></td>
  					<td align="left" width="30%">${channelName}</td>
  					<td align="right" width="20%"><span>赠品来源：</span></td>
  					<td align="left" width="30%">${obj.giftChannelDesc}</td>
  				</tr>
  				<tr>
  					<td align="right"><span>赠品名称：</span></td>
  					<td align="left">${obj.giftName}</td>
  					<td align="right"><span>赠送时间：</span></td>
  					<td align="left">${obj.createDate}</td>
  				</tr>
  				<tr>
  					<td align="right"><span>是否领取：</span></td>
  					<td align="left">${isGetVal}</td>
  					<td align="right"><span>领取时间：</span></td>
  					<td align="left">${obj.getDate}</td>
  				</tr>
  				<tr>
  					<td align="right"><span>是否退回：</span></td>
  					<td align="left">${isRtnVal}</td>
  					<td align="right"><span>退回时间：</span></td>
  					<td align="left">${obj.rtnDate}</td>
  				</tr>
  				<tr>
  					<td align="right"><span>赠品发放人：</span></td>
  					<td align="left">${obj.granter}</td>
  					<td align="right"><span>退回接收人：</span></td>
  					<td align="left">${obj.accepter}</td>
  				</tr>
  				<tr>
  					<td align="right"><span>赠送备注：</span></td>
  					<td align="left" colspan="3"><textarea rows="5" cols="100" id="giveRemark" name="giveRemark" readonly="readonly" class="easyui-validatebox textbox">${obj.giveRemark}</textarea></td>
  				</tr>
  				<tr>
  					<td align="right"><span>领取备注：</span></td>
  					<td align="left" colspan="3"><textarea rows="5" cols="100" id="getRemark" name="getRemark" readonly="readonly" class="easyui-validatebox textbox">${obj.getRemark}</textarea></td>
  				</tr>
  				<tr>
  					<td align="right"><span>退回备注：</span></td>
  					<td align="left" colspan="3"><textarea rows="5" cols="100" id="rtnRemark" name="rtnRemark" readonly="readonly" class="easyui-validatebox textbox">${obj.rtnRemark}</textarea></td>
  				</tr>
	 		</table>
 		</div>
 		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="text-align:right">
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:100px;" onclick="javascript:window.history.back()"><span>返回</span></a>
	      	</div>
	   </div>
  	</body>
</html>
