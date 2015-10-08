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
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="赠课浏览">
	 		<table width="100%" cellpadding="5px" class="maintable">
	 			<tr>
  					<td align="right" width="20%">来源类型：</td>
  					<td align="left" width="30%">${obj.giftChannel}</td>
  					<td align="right" width="20%">赠品来源：</td>
  					<td align="left" width="30%">${obj.giftChannelDesc}</td>
  				</tr>
  				<tr>
  					<td align="right">赠课类型：</td>
  					<td align="left">${obj.giftTypeVal}</td>
  					<td align="right">赠送课时：</td>
  					<td align="left">${obj.giftNum}</td>
  				</tr>
  				<tr>
  					<td align="right">赠课状态：</td>
  					<td align="left">${obj.giftState}</td>
  					<td align="right">课程进度：</td>
  					<td align="left"></td>
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
  					<td align="right">终止时间：</td>
  					<td align="left">${obj.rtnDate}</td>
  				</tr>
  				<tr>
  					<td align="right">终止操作人：</td>
  					<td align="left">${obj.handerName}</td>
  					<td align="right"></td>
  					<td align="left"></td>
  				</tr>
  				<tr>
  					<td align="right">终止原因：</td>
  					<td align="left" colspan="3"><textarea rows="5" cols="100" id="rtnRemark" name="rtnRemark" readonly="readonly" class="easyui-validatebox textbox">${retObj.rtnRemark}</textarea></td>
  				</tr>
	 		</table>
 		</div>
 		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="float: right;">
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
	      	</div>
	   </div>
  	</body>
</html>
