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
		<script type="text/javascript" src="<%=path %>/js/giftManage/courseGiftManage.js"></script>
  	</head>
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="赠课终止">
  			<input type="hidden" id="studentGiftId" value="${obj.studentGiftId}" />
  			<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
	 		<table width="100%" cellpadding="5px" class="maintable">
	 			<tr>
  					<td align="right" width="20%"><span>来源类型：</span></td>
  					<td align="left" width="30%">${obj.giftChannel}</td>
  					<td align="right" width="20%"><span>赠品来源：</span></td>
  					<td align="left" width="30%">${obj.giftChannelDesc}</td>
  				</tr>
  				<tr>
  					<td align="right"><span>赠课类型：</span></td>
  					<td align="left">${obj.giftTypeVal}</td>
  					<td align="right"><span>赠送课时：</span></td>
  					<td align="left">${obj.giftNum}</td>
  				</tr>
  				<tr>
  					<td align="right"><span>赠课状态：</span></td>
  					<td align="left">${obj.giftState}</td>
  					<td align="right"><span>课程进度：</span></td>
  					<td align="left"></td>
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
  					<td align="right"></td>
  					<td align="left"></td>
  				</tr>
  				<tr>
  					<td align="right"><span>终止原因：</span></td>
  					<td align="left" colspan="3"><textarea rows="7" cols="100" id="rtnRemark" name="rtnRemark" class="easyui-validatebox textbox"></textarea></td>
  				</tr>
	 		</table>
 		</div>
 		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      <div style="text-align:right">
      		<a href="javascript:void(0)" id="courseFinishSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width:100px;" onclick="courseFinishSubmit()"><span>提交</span></a>
      		&nbsp;
      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:100px;" onclick="javascript:window.history.back()"><span>返回</span></a>
	      </div>
	   </div>
  	</body>
</html>
