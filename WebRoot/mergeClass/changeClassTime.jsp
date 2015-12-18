<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/mergeClass/changeTime.js"></script>
  	</head>
  	<body>
  		<div class="easyui-panel" title="班级：11111" style="width:1300px;">
  			<table class="maintable" width="100%">
  				<tr>
  					<td width="100px;" align="center">上课时段：</td>
  					<td width="340px;"align="center" colspan="3">
  						<select style="width:80px;" data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName'">
  						</select>
  						<select style="width:140px;">
  						</select>
  					</td>
  					<td width="80px" align="center">教室：</td>
  					<td width="130px" align="center">
  						<select style="width:120px;">
  						</select>
  					</td>
  					<td width="160px" align="center">
  						<a iconCls="icon-ok" style="width:150px">添加上课时段</a>	
  					</td>
  					<td colspan="2">
  				</tr>
  				<tr>
  					<td align="center">序号</td>
  					<td width="160px" align="center">上课时段</td>
  					<td width="80px" align="center">教室</td>
  					<td width="40px" align="center">课时</td>
  					<td align="center" colspan="4"></td>
  					<td align="center" width="160px">操作</td>
  				</tr>
  				<tr>
  					<td align="center"></td>
  					<td width="160px" align="center"></td>
  					<td width="80px" align="center"></td>
  					<td width="40px" align="center"></td>
  					<td align="center" colspan="4"></td>
  					<td align="center" width="160px">
  						<a iconCls="icon-ok" style="width:70px">添加老师</a>
  						&nbsp;
  						<a iconCls="icon-ok" style="width:70px">删除</a>
  					</td>
  				</tr>
  			</table>
  		</div>
  	</body>
</html>
