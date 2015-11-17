<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>
<html>
	<head>
	<%@ include file="../common/head.jsp" %>
	<%@ include file="../common/formvalidator.jsp" %>
	<style>
		.datagrid
		{
			min-width:200px;
		}
	</style>
	</head>
	<body>
		<table class="easyui-datagrid" align="center" title="校区信息列表" style="width:380px;margin:5px auto;height:380px;" id="schoolList_data" url="<%=path %>/pubData/qrySchoolList.do" 
		border="true" pagination="false" rownumbers="false" fitColumns="true" singleSelect="true" data-options="onLoadSuccess:function(data){$('#schoolList_data').datagrid('clearSelections');}">
			<thead>
				<tr>
					<th field="ck" align="center" checkbox="true" width="5%"></th>
					<th field="schoolName" align="center" width="90%"><span>学校名称</span></th>
				</tr>
			</thead>
		</table>
		<div style="margin-top: 10px;text-align:right;">
	      	<a href="javascript:void(0)" id="submit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
	      	<a href="javascript:void(0)" id="back" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onclick="javascript:parent.window.$('#dlg').dialog('close')">返回</a>
	     </div>
	</body>
</html>
<script type="text/javascript">
	$("#submit").click(function ()
	{
		var row = $('#schoolList_data').datagrid('getSelected');
		var obj = $("#schoolList_data").datagrid('getSelections');
		if(obj.length <= 0) {
			$.messager.alert('提示', "请先选择一个校区！");
		}
		var content = "<span style='font-size:14px;font-family:'微软雅黑''>&nbsp;"+row.schoolName+"<a style='font-size:12px' class='linkmore' onclick='removeSchool(this)'>删除</a></span>";
		//回填信息
		parent.window.$("#schoolTd").html(content);
		parent.window.$("#schoolIds").val(row.schoolId);
		parent.window.$('#dlg').dialog('close');
		
	});
	
</script>
