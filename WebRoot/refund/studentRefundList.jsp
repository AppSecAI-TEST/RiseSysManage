<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String studentId = request.getParameter("studentId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
  	</head>
  
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="学员退费信息">
		  	<table class="easyui-datagrid" title="" style="height:auto;" id="list_data" 
		  		url="<%=path %>/pubData/qryDataListByPage.do?funcNodeId=1026&param={'studentId':'<%=studentId %>'}" 
			  	rownumbers="true" fitColumns="true" singleSelect="false">
				<thead>
					<tr>
						<th data-options="field:'stageId',width:120,align:'center'">阶段或课程名称</th>
						<th data-options="field:'classType',width:80,align:'center'">退费课程</th>
						<th data-options="field:'payDate',width:80,align:'center'">缴费日期</th>
						<th data-options="field:'adviserName',width:100,align:'center'">业绩顾问</th>
						<th data-options="field:'adviserTeacherName',width:100,align:'center'">业绩老师</th>
						<th data-options="field:'courseStateText',width:100,align:'center'">原课程状态</th>
						<th data-options="field:'className',width:100,align:'center'">班级</th>
						<th data-options="field:'teacherName',width:100,align:'center'">带班老师</th>
						<th data-options="field:'classProgress',width:80,align:'center'">课时进度</th>
						<th data-options="field:'refundTypeText',width:80,align:'center'">退费类型</th>
						<th data-options="field:'refundState',width:100,align:'center'">退费状态</th>
						<th data-options="field:'applyDate',width:80,align:'center'">申请日期</th>
						<th data-options="field:'finishDate',width:80,align:'center'">成功日期</th>
					</tr>
				</thead>
			</table>
	  		<div style="height: 10px;"></div>
  		</div>
  	</body>
</html>
