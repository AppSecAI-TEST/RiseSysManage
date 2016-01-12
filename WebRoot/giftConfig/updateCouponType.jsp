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
		<script type="text/javascript" src="<%=path %>/js/giftConfig/couponGiftConfig.js"></script>
  	</head>
  	<body>
   		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="维护赠券类型">
 		<table width="100%" cellpadding="5px" class="maintable" id="courseTd">
 			<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
 			<input type="hidden" id="giftTypeTd" value="${obj.giftType}"/>
 			<input type="hidden" id="isMinus" value="${obj.isMinus}"/>
 			<tr>
 				<td align="center"><span>编号</span></td>
 				<td align="center"><span>赠券类型</span></td>
 				<td align="center"><span>使用方式</span></td>
 				<td align="center"><span>有效期（月）</span></td>
 				<td align="center"><span>有效期说明</span></td>
 				<td align="center"><span>是否抵扣学费</span></td>
 				<td align="center"><span>操作</span></td>
 			</tr>
			<tr>
				<td id="gifitCodeTd" align="center">${obj.giftCode}</td>
				<td id="typeNameTd" align="center">${obj.typeName}</td>
				<td id="useTypeTd" align="center">${obj.useType}</td>
				<td id="effNumTd" align="center">${obj.effNum}</td>
				<td id="effRemarkTd" align="center">${obj.effRemark}</td>
				<td id="isMinusValTd" align="center">${obj.isMinusVal}</td>
				<td align="center"><a class="easyui-linkbutton" iconCls="icon-edit" onclick="updateCouponType()" style="width:100px; height:25px;"  href="javascript:void(0)"><span>修改</span></a>&nbsp;<a class="easyui-linkbutton" iconCls="icon-remove" onclick="removeCouponType()" style="width:100px; height:25px;" href="javascript:void(0)"><span>删除</span></a></td>
			</tr>
 		</table>
 		</div>
 		<div id="updateCouponTypeDlg" class="easyui-dialog" style="width:550px;height:270px;padding:0px 0px" modal="true" closed="true" buttons="#couponType-buttons">
			<form id="updateCouponTypeFm" method="post">
				<input name="giftType" type="hidden"/>
				<table width="98%" style="margin:5px 5px;border: 1px solid #ccc;" cellpadding="5px" class="maintable">
					<tr>
						<td align="right"><span>编号：</span></td>
						<td align="left"><input id="giftCode" name="giftCode" style="width:265px" class="easyui-textbox" disabled="disabled"/></td>
					</tr>
					<tr>
						<td align="right"><span>赠券类型名称：</span></td>
						<td align="left"><input name="typeName" style="width:265px" class="easyui-textbox" required="true" /></td>
					</tr>
					<tr>
						<td align="right"><span>使用方式：</span></td>
						<td align="left"><input name="useType" style="width:265px" class="easyui-textbox" required="true" /></td>
					</tr>
					<tr>
						<td align="right"><span>有效期（月）：</span></td>
						<td align="left"><input name="effNum" style="width:265px" class="easyui-numberbox" required="true" /></td>
					</tr>
					<tr>
						<td align="right"><span>有效期说明：</span></td>
						<td align="left"><input name="effRemark" style="width:265px" class="easyui-textbox" /></td>
					</tr>
					<tr>
						<td align="right"><span>是否抵扣学费：</span></td>
						<td align="left"><input type="radio" style="vertical-align:middle;" value="Y" name="isMinus"/><span>是</span>&nbsp;<input type="radio" style="vertical-align:middle;" value="N" name="isMinus"/><span>否</span></td>
					</tr>
				</table>
			</form>
		</div>
		<div style="text-align:center" id="couponType-buttons">
			<a href="#" class="easyui-linkbutton" iconCls="icon-ok" style="width:100px; height:25px;" onclick="updateCouponTypeSubmit()"><span>提交</span></a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" style="width:100px; height:25px;" onclick="javascript:$('#updateCouponTypeDlg').dialog('close')"><span>取消</span></a>
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
