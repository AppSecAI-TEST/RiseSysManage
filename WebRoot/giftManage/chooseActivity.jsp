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
		<table class="easyui-datagrid"  align="center" title="活动信息列表" style="width:920px;margin-top:10px;height:330px;" id="activityList" url="<%=path %>/pubData/qryDataListByPage.do?param={'queryCode':'qryActivityList','studentId':'<%=studentId%>'}" 
			 pagination="true" rownumbers="false" fitColumns="true" singleSelect="true">
			<thead>
				<tr>
					<th field="ck" align="center" checkbox="true" width="1%"></th>
					<th field="titleText" align="center" width="20%"><span>活动标题</span></th>
					<th field="activityDate" align="center" width="19%"><span>活动时间</span></th>
					<th field="awardText" align="center" width="24%"><span>获奖情况</span></th>
					<th field="remark" align="center" width="33%"><span>活动详细</span></th>
					<input type='hidden'  field="activityId" />
				</tr>
			</thead>
		</table>
		<div style="margin-top: 10px;text-align:right;">
	      	<a href="javascript:void(0)" id="submit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
	      	&nbsp;<a href="javascript:void(0)" id="back" class="easyui-linkbutton" iconCls="icon-cancel" style="width: 80px; height: 28px;" onclick="javascript:parent.window.$('#dlg').dialog('close')">返回</a>
	     </div>
	</body>
</html>
<script type="text/javascript">
	$("#submit").click(function ()
	{
		var row = $('#activityList').datagrid('getSelected');
		var obj = $("#activityList").datagrid('getSelections');
		if(obj.length <= 0) {
			$.messager.alert('提示', "请先选择一个活动！");
		}
		var titleText = row.titleText;
		var activityDate = row.activityDate;
		var awardText = row.awardText;
		var activityId = row.activityId;
		
		parent.window.$("#titleText").html(titleText);
		parent.window.$("#activityDate").html(activityDate);
		parent.window.$("#awardText").html(awardText);
		parent.window.$("#activityId").val(activityId);
		parent.window.$('#dlg').dialog('close');
	});
	
</script>
