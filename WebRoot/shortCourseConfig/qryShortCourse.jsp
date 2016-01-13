<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String type=request.getParameter("type");
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/shortCourseConfig/shortCourseMain.js"></script>
  	</head>
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;padding:5px;display:block;" title="短期课查询">
 		<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:600" id="list_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
			<thead>
				<tr>
					<th field="ck" align="center" checkbox="true" width="1%"></th>
					<th field="className" align="center" width="25%"><span>短期课名称</span></th>
					<th field="isTeachingVal" align="center" width="24%"><span>管理类型</span></th>
					<th field="handlerName" align="center" width="25%"><span>创建人</span></th>
					<th field="createDate" align="center" width="25%"><span>创建时间</span></th>
				</tr>
			</thead>
		</table>
		<div id="toolbar">
   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" style="width:100px;" onclick="addShortSystem('<%=type %>')"><span>提交</span></a>
 			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:100px;" onclick="javascript:window.history.back()"><span>返回</span></a>
 		</div>
 		<script type="text/javascript">
	   		$(document).ready(function(){
	   			//初始化页面值
	   			var obj = "{'queryCode':'qryShortCourse'}";
			   	$('#list_data').datagrid({
					url : "/sys/pubData/qryDataListByPage.do",
					queryParams:{
						param : obj
					},
					onLoadSuccess:function(){
						//一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题。
						$('#list_data').datagrid('clearSelections');
					}
				});
	   		});
	   </script>
  	</body>
</html>
