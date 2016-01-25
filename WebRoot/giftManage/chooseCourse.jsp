<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String studentId=request.getParameter("studentId");
%>
<html>
	<head>
	<%@ include file="../common/head.jsp" %>
	<%@ include file="../common/formvalidator.jsp" %>
	<style>
		.datagrid
		{
			min-width:800px;
		}
	</style>
	</head>
	<body>
		<table class="easyui-datagrid"  align="center" title="课程信息列表" style="width:920px;margin-top:10px;height:330px;" id="courseList" url="<%=path %>/pubData/qryDataListByPage.do?param={'queryCode':'qryGiftCourseList','studentId':'<%=studentId%>'}" 
			 pagination="false" rownumbers="false" fitColumns="true" singleSelect="true" data-options="onLoadSuccess:function(data){$('#courseList').datagrid('clearSelections');}">
			<thead>
				<tr>
					<th field="ck" align="center" checkbox="true" width="1%"></th>
					<th field="stageId" align="center" width="13%"><span>课程阶段</span></th>
					<th field="payDate" align="center" width="13%"><span>缴费时间</span></th>
					<th field="feeType" align="center" width="13%"><span>业绩类型</span></th>
					<th field="adviser" align="center" width="15%"><span>业绩顾问</span></th>
					<th field="dutyAdvister" align="center" width="15%"><span>责任顾问</span></th>
					<th field="className" align="center" width="15%"><span>当前班级</span></th>
					<th field="courseState" align="center" width="14%"><span>课程状态</span></th>
					<input type='hidden'  field="studentCourseId" />
				</tr>
			</thead>
		</table>
		<div style="margin-top: 10px;text-align:center;">
	      	<a href="javascript:void(0)" id="courseSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 100px;"><span>提交</span></a>
	      	&nbsp;<a href="javascript:void(0)" id="back" class="easyui-linkbutton" iconCls="icon-back" style="width: 100px;" onclick="javascript:parent.window.$('#courseDlg').dialog('close')"><span>返回</span></a>
	     </div>
	</body>
</html>
<script type="text/javascript">
	$("#courseSubmit").click(function ()
	{
		var row = $('#courseList').datagrid('getSelected');
		var obj = $("#courseList").datagrid('getSelections');
		if(obj.length <= 0) {
			$.messager.alert('提示', "请先选择一个课程！");
		}
		var stageId = row.stageId;
		var payDate = row.payDate;
		var courseState = row.courseState;
		var className = row.className;
		var studentCourseId = row.studentCourseId;
		
		parent.window.$("#stageId").html(stageId);
		parent.window.$("#payDate").html(payDate);
		parent.window.$("#courseState").html(courseState);
		parent.window.$("#className").html(className);
		parent.window.$("#studentCourseId").val(studentCourseId);
		parent.window.$('#courseDlg').dialog('close');
	});
	
</script>
