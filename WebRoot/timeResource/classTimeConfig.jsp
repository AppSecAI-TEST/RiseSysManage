<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/timeResource/config.js"></script>
		<style>
			#classInfo td
			{
				text-align:center;
			}
		</style>
  	</head>
  	
  	<body>
  		<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  		<div  class="easyui-panel" title="上课时段配置信息信息" style="width:1100px;">
  			<table width="100%;" class="maintable" id ="classInfo">
  				<tr>
  					<td width="10%"><span>星期</span></td>
  					<td width="30%"><span>上课时段</span></td>
  					<td width="10%"><span>课时量</span></td>
  					<td width="30%"><span>操作</span></td>
  					<td width="20%"><span>别名</span></td>
  				</tr>
  				<tr id="modelTr1" style="display:none">
  					<td></td>
  					<td></td>
  					<td>
  						<input type="text" class="hours" data-options="min:1,max:24,precision:0"  style="width:100px;height: 28px;">
  					</td>
  					<td>
  						<input type="radio"><span>开放</span>
  						&nbsp;&nbsp;&nbsp;&nbsp;
  						<input type="radio"><span>不开放</span>
  					</td>
  					<td></td>
  				</tr>
  				<tr id="modelTr2" style="display:none">
  					<td></td>
  					<td>
  						<input type="text" class="hours" data-options="min:1,max:24,precision:0"  style="width:100px;height: 28px;">
  					</td>
  					<td>
  						<input type="radio"><span>开放</span>
  						&nbsp;&nbsp;&nbsp;&nbsp;
  						<input type="radio"><span>不开放</span>
  					</td>
  					<td></td>
  				</tr>
  			</table>
  		</div>
  		<div style="width:1100px;text-align:right;margin:25px 0;">
  			 <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" style="width:100px" id="submitBtn">提交</a>
  				&nbsp;&nbsp;&nbsp;&nbsp;
  			 <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:100px" id="backBtn" >返回</a>	
  		</div>
  	</body>
</html>
