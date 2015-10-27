<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
  	</head>
  
  	<body>
		<form id="qryFm" style="margin:0 auto;">
			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:0 auto;height:50px;" cellspacing="2">
				<tr>
					<td align="right" width="8%">
						<span>职务名称：</span>
					</td>
					<td width="42%">
						<input name="postName" id="postName" type="text" class="easyui-textbox" style="width: 400px; height: 25px;"/>
					</td>
					<td align="right" width="50%">
						<a href="javascript:void(0)" id="queryBtn" class="easyui-linkbutton" iconCls="icon-search" style="width: 100px;" onclick="queryFunc()">查询</a>
						<a href="javascript:void(0)" id="resetBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width: 100px;" onclick="resetFunc()">重置</a>
					</td>
				</tr>
			</table>
		</form>
		<div style="padding:5px 0;min-width:1100px; width:100%;">
			<table class="easyui-datagrid" title="职务列表" style="height:460px;" id="postList" url="/sys/post/queryPostList.do" 
				toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
				<thead>
					<tr>
						<th data-options="field:'postId',checkbox:true"></th>
						<th width="20%" field="postName">职位名称</th>
						<th width="19%" field="postTypeName">职位类型</th>
						<th width="20%" field="deptName">归属部门</th>
						<th width="20%" field="schoolIdsName">管辖范围</th>
						<th width="20%" field="createDate">创建时间</th>
					</tr>
				</thead>
			</table>
		</div>
		<div id="toolbar" style="padding: 2px; height: auto">
   			<a href="javascript:void(0)" id="addPost" class="easyui-linkbutton" iconCls="icon-add" style="width:100px;" onclick="newPost()">添加职务</a>
			<a href="javascript:void(0)" id="updatePost" class="easyui-linkbutton" iconCls="icon-edit" style="width:100px;" onclick="editPost()">修改职务</a>
			<a href="javascript:void(0)" id="removePost" class="easyui-linkbutton" iconCls="icon-remove" style="width:100px;" onclick="removePost()">删除职务</a>
		</div>
		<script type="text/javascript">
			function newPost(){
				window.location.href = "/sys/post/getPostInfo.do?funcNodeId=${param.funcNodeId}";
			}
			function editPost(){
				var row = $('#postList').datagrid('getSelected');
				if (row){
					window.location.href = "/sys/post/getPostInfo.do?funcNodeId=${param.funcNodeId}&postId="+row.postId;
				}
				else
				{
					$.messager.alert('提示',"请先选择要修改的职务");
				}
			}
			function removePost(){
				var row = $('#postList').datagrid('getSelected');
				if (row){
					$.messager.confirm('提示','您确定要删除当前职务吗?',function(r){
						if (r){
							$.post('/sys/post/deletePost.do',{postId:row.postId},function(result){
								if(result == "success")
								{
									$("#postList").datagrid("reload");
								}
								else
								{
									$.messager.alert('提示', result);
								}
							});
						}
					});
				}
				else
				{
					$.messager.alert('提示',"请先选择要删除的职务");
				}
			}
			function queryFunc()
			{
				var postName = $.trim($("#postName").textbox("getValue"));
				if(postName == "")
				{
					$.messager.alert('提示',"请先输入要查询的职务");
				}
				else
				{
					$("#postList").datagrid({url:"/sys/post/queryPostList.do?postName="+postName});
				}
			}
			function resetFunc()
			{
				$("#postName").textbox("setValue","");
			}
		</script>
 	</body>
</html>