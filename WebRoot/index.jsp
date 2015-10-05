<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>
<!doctype html>
<html>
	<head>
		<title>例子1</title>
		<%@ include file="common/head.jsp" %>
		<%@ include file="common/formvalidator.jsp" %>
		<style type="text/css">
			#fm{
				margin:0;
				padding:10p.x 30px;
			}
			.ftitle{
				font-size:14px;
				font-weight:bold;
				color:#666;
				padding:5px 0;
				margin-bottom:10px;
			}
			.fitem{
				margin-bottom:5px;
			}
			.fitem label{
				display:inline-block;
				width:80px;
			}
		</style>
		<script type="text/javascript">
			var url;
			function newExample(){
				$('#dlg').dialog('open').dialog('setTitle','新增参数');
				$('#fm').form('clear');
				url = '<%=path %>/example/addExample.do';
			}
			function editExample(){
				var row = $('#dg').datagrid('getSelected');
				if (row){
					$('#dlg').dialog('open').dialog('setTitle','修改参数');
					$('#fm').form('clear');
					$('#fm').form('load',row);
					url = '<%=path %>/example/updateExample.do';
				}
			}
			function saveExample(){
				$('#fm').form('submit',{
					url: url,
					onSubmit: function(){
						return $(this).form('validate');
					},
					success: function(result){
						if (result == "success"){
							$('#dlg').dialog('close');		
							window.location.reload();	
						} else {
							$.messager.alert('提示',result);
						}
					}
				});
			}
			function removeExample(){
				var row = $('#dg').datagrid('getSelected');
				if (row){
					$.messager.confirm('提示','您确定要移除当前选中的参数吗?',function(r){
						if (r){
							$.post('<%=path %>/example/delExample.do',{exampleId:row.exampleId},function(result){
								if(result == "success")
								{
									window.location.reload();
								}
								else
								{
									$.messager.alert('提示', result);
								}
							});
						}
					});
				}
			}
			function myformatter(date) {
				var y = date.getFullYear();
				var m = date.getMonth() + 1;
				var d = date.getDate();
				return y + '-' + (m < 10 ? ('0' + m) : m) + '-' + (d < 10 ? ('0' + d) : d);
			}
			function myparser(s) {
				if (!s)
					return new Date();
				var ss = (s.split('-'));
				var y = parseInt(ss[0], 10);
				var m = parseInt(ss[1], 10);
				var d = parseInt(ss[2], 10);
				if (!isNaN(y) && !isNaN(m) && !isNaN(d)) {
					return new Date(y, m - 1, d);
				}else{
					return new Date();
				}
			}
		</script>
	</head>
	<body>
		<table id="dg" title="例子" class="easyui-datagrid" width="100%" style="height:490px" url="<%=path %>/example/queryExample.do" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
			<thead>
				<tr>
					<th field="exampleName" width="25%">参数名称</th>
					<th field="exampleValue" width="25%">参数值</th>
					<th field="createDate" width="25%">创建时间</th>
					<th field="stateDate" width="24%">状态时间</th>
				</tr>
			</thead>
		</table>
		<div id="toolbar">
			<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newExample()">新增参数</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editExample()">修改参数</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="removeExample()">删除参数</a>
		</div>
		<div id="dlg" class="easyui-dialog" style="width:350px;height:150px;padding:10px 10px" modal="true" closed="true" buttons="#dlg-buttons">
			<form id="fm" method="post" novalidate>
				<input name="exampleId" type="hidden" />
				<div class="fitem">
					<label style="text-align:right">参数名称:</label>
					<input name="exampleName" id="exampleName" type="text" style="width:147px" class="easyui-validatebox" required="true" />
				</div>
				<div class="fitem">
					<label style="text-align:right">参数值:</label>
					<input name="exampleValue" type="text" style="width:147px" class="easyui-validatebox" required="true" />
				</div>
			</form>
		</div>
		<div id="dlg-buttons">
			<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveExample()">保存</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
		</div>
	</body>
</html>