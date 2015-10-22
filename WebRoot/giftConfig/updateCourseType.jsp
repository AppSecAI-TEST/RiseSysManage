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
		<script type="text/javascript" src="<%=path %>/js/giftConfig/courseGiftConfig.js"></script>
  	</head>
  	<body>
   		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="维护赠课类型">
 		<table width="100%" cellpadding="5px" class="maintable" id="courseTd">
 			<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
 			<input type="hidden" id="giftTypeTd" value="${obj.giftType}"/>
 			<input type="hidden" id="manageTypeTd" value="${obj.manageType}"/>
 			<tr>
 				<td align="center">编号</td>
 				<td align="center">赠课类型</td>
 				<td align="center">管理类型</td>
 				<td align="center">有效期（年）</td>
 				<td align="center">有效期说明</td>
 				<td align="center">操作</td>
 			</tr>
			<tr>
				<td id="gifitCodeTd" align="center">${obj.giftCode}</td>
				<td id="typeNameTd" align="center">${obj.typeName}</td>
				<td align="center">${obj.manageTypeVal}</td>
				<td id="effNumTd" align="center">${obj.effNum}</td>
				<td id="effRemarkTd" align="center">${obj.effRemark}</td>
				<td align="center"><a class="easyui-linkbutton" iconCls="icon-edit" onclick="updateCourseType()" style="width:100px; height:25px;"  href="javascript:void(0)">修改</a>&nbsp;<a class="easyui-linkbutton" iconCls="icon-remove" onclick="removeCourseType()" style="width:100px; height:25px;" href="javascript:void(0)">删除</a></td>
			</tr>
 		</table>
 		</div>
 		<div id="updateCourseTypeDlg" class="easyui-dialog" style="width:550px;height:230px;padding:0px 0px" modal="true" closed="true" buttons="#courseType-buttons">
			<form id="updateCourseTypeFm" method="post">
				<input name="giftType" type="hidden"/>
				<table width="98%" style="margin:5px 5px;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
					<tr>
						<td align="right">编号：</td>
						<td align="left"><input id="giftCode" name="giftCode" style="width:265px" class="easyui-textbox" disabled="disabled"/></td>
					</tr>
					<tr>
						<td align="right">赠课类型名称：</td>
						<td align="left"><input name="typeName" style="width:265px" class="easyui-textbox" required="true" /></td>
					</tr>
					<tr>
						<td align="right">管理类型：</td>
						<td align="left"><input type="radio" style="vertical-align:middle;" value="BOOK" name="manageType"/><span>预约赠课</span>&nbsp;<input type="radio" style="vertical-align:middle;" value="SHORT" name="manageType"/><span>短期赠课</span></td>
					</tr>
					<tr>
						<td align="right">有效期（年）：</td>
						<td align="left"><input name="effNum" style="width:265px" class="easyui-numberbox" required="true" /></td>
					</tr>
					<tr>
						<td align="right">有效期说明：</td>
						<td align="left"><input name="effRemark" style="width:265px" class="easyui-textbox" /></td>
					</tr>
				</table>
			</form>
		</div>
		<div id="courseType-buttons">
			<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="updateCourseTypeSubmit()">提交</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#updateCourseTypeDlg').dialog('close')">取消</a>
		</div>
 		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="float: right;">
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
	      	</div>
	   </div>
  	</body>
</html>
