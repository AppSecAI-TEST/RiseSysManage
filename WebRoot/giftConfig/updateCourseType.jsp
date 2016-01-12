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
		<script type="text/javascript" src="<%=path %>/js/giftConfig/courseGiftConfig.js"></script>
  	</head>
  	<body>
   		<div class="easyui-panel" style="min-width:1100px; width:100%;height:auto;" title="维护赠课类型">
 		<table width="100%" cellpadding="5px" class="maintable" id="courseTd">
 			<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
 			<input type="hidden" id="giftTypeTd" value="${obj.giftType}"/>
 			<input type="hidden" id="manageTypeTd" value="${obj.manageType}"/>
 			<tr>
 				<td align="center"><span>编号</span></td>
 				<td align="center"><span>赠课类型</span></td>
 				<td align="center"><span>管理类型</span></td>
 				<td align="center"><span>有效期（年）</span></td>
 				<td align="center"><span>有效期说明</span></td>
 				<td align="center"><span>操作</span></td>
 			</tr>
			<tr>
				<td id="gifitCodeTd" align="center">${obj.giftCode}</td>
				<td id="typeNameTd" align="center">${obj.typeName}</td>
				<td align="center">${obj.manageTypeVal}</td>
				<td id="effNumTd" align="center">${obj.effNum}</td>
				<td id="effRemarkTd" align="center">${obj.effRemark}</td>
				<td align="center"><a class="easyui-linkbutton" iconCls="icon-edit" onclick="updateCourseType()" style="width:100px; height:25px;"  href="javascript:void(0)"><span>修改</span></a>&nbsp;<a class="easyui-linkbutton" iconCls="icon-remove" onclick="removeCourseType()" style="width:100px; height:25px;" href="javascript:void(0)"><span>删除</span></a></td>
			</tr>
 		</table>
 		</div>
 		<div id="updateCourseTypeDlg" class="easyui-dialog" style="width:550px;height:240px;padding:0px 0px" modal="true" closed="true" buttons="#courseType-buttons">
			<form id="updateCourseTypeFm" method="post">
				<input name="giftType" type="hidden"/>
				<table width="98%" style="margin:5px 5px;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
					<tr>
						<td align="right"><span>编号：</span></td>
						<td align="left"><input id="giftCode" name="giftCode" style="width:265px" class="easyui-textbox" disabled="disabled"/></td>
					</tr>
					<tr>
						<td align="right"><span>赠课类型名称：</span></td>
						<td align="left"><input name="typeName" style="width:265px" class="easyui-textbox" required="true" /></td>
					</tr>
					<tr>
						<td align="right"><span>管理类型：</span></td>
						<td align="left"><input type="radio" style="vertical-align:middle;" value="BOOK" name="manageType"/><span>预约赠课</span>&nbsp;<input type="radio" style="vertical-align:middle;" value="SHORT" name="manageType"/><span>短期赠课</span></td>
					</tr>
					<tr>
						<td align="right"><span>有效期（年）：</span></td>
						<td align="left"><input name="effNum" style="width:265px" class="easyui-numberbox" required="true" /></td>
					</tr>
					<tr>
						<td align="right"><span>有效期说明：</span></td>
						<td align="left"><input name="effRemark" style="width:265px" class="easyui-textbox" /></td>
					</tr>
				</table>
			</form>
		</div>
		<div style="text-align:center" id="courseType-buttons">
			<a href="#" class="easyui-linkbutton" iconCls="icon-ok" style="width:100px; height:25px;" onclick="updateCourseTypeSubmit()"><span>提交</span></a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" style="width:100px; height:25px;" onclick="javascript:$('#updateCourseTypeDlg').dialog('close')"><span>取消</span></a>
		</div>
 		<table style="margin-top: 20px;min-width:1100px; width:99%;">
			<tr>
				<td align="center">
					<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:100px; height: 25px;" onclick="javascript:window.history.back()"><span>返回</span></a>
				</td>
			</tr>
		</table>
  	</body>
</html>
