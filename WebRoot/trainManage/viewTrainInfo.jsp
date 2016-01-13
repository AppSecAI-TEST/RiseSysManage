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
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="浏览培训">
	 		<table id="trainTab" width="95%" align="center" style="margin:5px auto;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
	 			<tr>
  					<td align="right"><span>教师姓名：</span></td>
  					<td align="left">${name}</td>
  					<td align="right"><span>教师英文名：</span></td>
  					<td align="left">${byName}</td>
  					<td align="right"><span>教师状态：</span></td>
  					<td align="left">${stateVal}</td>
  				</tr>
  				<tr>
  					<td align="right"><span>培训开始时间：</span></td>
  					<td align="left">${obj.train.trainStartDate}</td>
  					<td align="right"><span>培训结束时间：</span></td>
  					<td align="left">${obj.train.trainEndDate}</td>
  					<td align="right"><span>培训费用：</span></td>
  					<td align="left">${obj.train.trainAmount}</td>
  				</tr>
  				<tr>
  					<td align="right"><span>协议有效期：</span></td>
  					<td align="left">${obj.train.trainDeadline}年</td>
  					<td align="right"><span>培训地点：</span></td>
  					<td align="left">${obj.train.trainPlace}</td>
  					<td align="right"><span>培训类型：</span></td>
  					<td align="left">${obj.train.trainTypeVal}</td>
  				</tr>
  				<tr>
  					<td align="right"><span>备注：</span></td>
  					<td colspan="5" align="left"><textarea rows="5" cols="100" id="remark" name="remark" readonly="readonly" class="easyui-validatebox textbox">${obj.train.remark}</textarea></td>
  				</tr>
	 		</table>
 		</div>
 		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="text-align:center">
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:100px;" onclick="javascript:window.history.back()"><span>返回</span></a>
	      	</div>
	   </div>
  	</body>
</html>
