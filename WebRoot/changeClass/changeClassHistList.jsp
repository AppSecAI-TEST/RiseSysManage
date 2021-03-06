<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String studentId = request.getParameter("studentId");
	String studentCourseId = request.getParameter("studentCourseId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
  	</head>  
  	<body>
  		<div style="padding:5px 0;min-width:1100px; width:100%;">
  			<table class="easyui-datagrid" title="转班历史信息" style="height:auto;" id="list_data" pagination="false" rownumbers="true" fitColumns="true" singleSelect="true"
  				url="<%=path %>/pubData/qryDataListByPage.do?param={'studentId':'<%=studentId %>','studentCourseId':'<%=studentCourseId %>','queryCode':'qryChangeClassHistList'}" >
				<thead>
					<tr>
						<th data-options="field:'schoolName',width:80,align:'center'">发生校区</th>
						<th data-options="field:'payDate',width:100,align:'center'">缴费日期</th>
						<th data-options="field:'outClassName',width:100,align:'center'">转出班级</th>
						<th data-options="field:'outClassTeacherName',width:120,align:'center'">转出班老师</th>
						<th data-options="field:'outClassProgress',width:120,align:'center'">原班课时</th>
						<th data-options="field:'courseStateText',width:100,align:'center'">原课程状态</th>
						<th data-options="field:'changeClassStateText',width:100,align:'center'">转班状态</th>
						<th data-options="field:'inClassName',width:100,align:'center'">转入班级</th>
						<th data-options="field:'outDate',width:120,align:'center'">转出时间</th>
						<th data-options="field:'inDate',width:120,align:'center'">转入时间</th>
						<th data-options="field:'finishDate',width:120,align:'center'">完成时间</th>
					</tr>
				</thead>
			</table>
  		</div>
  		<div style="margin-top: 20px;min-width:1100px; width:99%;text-align: right">
	      	&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
	   </div>
  	</body>
</html>
