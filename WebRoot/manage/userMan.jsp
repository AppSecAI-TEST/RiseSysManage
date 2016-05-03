<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<style type="text/css">
			.datagrid{
				margin-top:0px;
			}
			.queryArea td{
				font-size:14px;
				font-family:"微软雅黑";
			}
		</style>
		<script type="text/javascript">
			ajaxLoading("正在处理，请稍待。。。");
			$(document).ready(function(){
				$("#userList").datagrid({
					pageList : [20, 30, 40],
					pageSize : 20
				});
				$("#deptTree").tree({
					url:'/sys/orgDept/getSubOrgDeptList.do',
					lines:true,
					animate:true,
					onClick:getTreeNode,
					onLoadSuccess:function(data){
						ajaxLoadEnd();
					}
				});
				$("#deptId").combotree({
					url:"/sys/orgDept/getRootOrgDept.do",
					animate:true
				});
				$("#post").combobox({
					url:"<%=path %>/post/qryPostInfoList.do",
					formatter:function(row){
						return '<span>'+row.postName+'</span>';
					},
					editable:false,
					valueField: 'postId',
					textField: 'postName',
					listHeight:150
				});
				$("#staffState").combobox({
					url:"<%=path %>/pub/pageComboxList.do?funcNodeId=${param.funcNodeId}&fieldId=staffState",
					formatter:function(row){
						return '<span>'+row.codeName+'</span>';
					},
					editable:false, 
					valueField: 'codeFlag', 
					textField: 'codeName', 
					panelHeight: 'auto'
				});
			});
			function getTreeNode(){
				var node = $('#deptTree').tree('getSelected');
				if (node){
					$("#userList").datagrid({
						url:"<%=path %>/staff/qryStaffListByDeptId.do?deptId="+node.id,
						onLoadSuccess:function(data){
							for(var i = 0,n = data.total;i < n;i++)
							{
								if(data.rows[i])
								{
									$("#operButton"+i).linkbutton({text:(data.rows[i].state=="00A"?'离职':'复职'),iconCls:"icon-reload"});
								}
							}
						}
					});
				}
			}
			function queryFunc() {
				initPageNumber("userList");
				var deptId = $("#deptId").combotree("getValue");
				var userName = $("#userName").textbox("getValue");
				var post = $("#post").combobox("getValue");
				var staffState = $("#staffState").combotree("getValue");
				$("#userList").datagrid({
					url:"<%=path %>/staff/qryStaffListByCondition.do?deptId="+deptId+"&userName="+userName+"&post="+post+"&staffState="+staffState,
					onLoadSuccess:function(data){
						for(var i = 0,n = data.total;i < n;i++)
						{
							if(data.rows[i])
							{
								$("#operButton"+i).linkbutton({text:(data.rows[i].state=="00A"?'离职':'复职'),iconCls:"icon-reload"});
							}
						}
					}
				});
			}
			function resetFunc(){
				$("#deptId").combotree("setValue","");
				$("#userName").textbox("setValue","");
				$("#post").combobox("setValue","");
				$("#staffState").combobox("setValue","");
			}
			function newStaff(){
				window.location.href = "<%=path %>/staff/getStaffDetail.do?pageFlag=NEW&funcNodeId=${param.funcNodeId}";
			}
			function editStaff(){
				var row = $('#userList').datagrid('getSelected');
				if (row){
					window.location.href = "<%=path %>/staff/getStaffDetail.do?pageFlag=MOD&funcNodeId=${param.funcNodeId}&staffId="+row.staffId;
				}
				else
				{
					$.messager.alert('提示',"请先选择要修改的用户");
				}
			}
			function removeStaff(){
				var row = $('#userList').datagrid('getSelected');
				if (row)
				{
					$.messager.confirm('提示','您确定要删除当前用户吗?',function(r){
						if (r){
							$.post('<%=path %>/staff/deleteStaff.do',{staffId:row.staffId},function(result){
								if(result == "success")
								{
									$("#userList").datagrid("reload");
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
					$.messager.alert('提示',"请先选择要删除的用户");
				}
			}
			function dimissionFunc(flag,val){
				$.post('<%=path %>/staff/dimissionStaff.do',{operType:flag,staffId:val},function(result){
					if(result == "success")
					{
						$("#userList").datagrid("reload");
					}
					else
					{
						$.messager.alert('提示', result);
					}
				});
			}
		</script>
	</head>
	<body class="easyui-layout manage">
		<div id="leftarea" data-options="iconCls:'icons-other-house',region:'west',title:'组织机构',split:true,width:200">
			<div style="width:96%;height:100%;padding-left:5px;">
				<ul id="deptTree"></ul>
			</div>
		</div>
		<div id="mainarea" class="easyui-layout" data-options="region:'center'" style="padding:0px;background:#E0ECFF;min-width:300px">
			<table region="north" class="queryArea" split="true" align="center" style="height:30px;width:100%;min-width:1000px;">
				<tr>
					<td align="right">部门:</td>
					<td><select id="deptId" name="deptId" style="width:120px;height:25px;" ></select></td>
					<td align="right">英文名:</td>
					<td><input name="userName" id="userName" type="text" style="width:120px;height:25px;" class="easyui-textbox" /></td>
					<td align="right">职务:</td>
					<td><select id="post" name="post" style="width:120px;height:25px;" ></select></td>
					<td align="right">状态:</td>
					<td><select id="staffState" name="staffState" style="width:120px;height:25px;" ></select></td>
					<td style="padding-right:20px">
						<a href="javascript:void(0)" id="queryBtn" class="easyui-linkbutton" iconCls="icon-search" style="width: 80px;" onclick="queryFunc()">查询</a>
						<a href="javascript:void(0)" id="resetBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width: 80px;" onclick="resetFunc()">重置</a>
					</td>
				</tr>
			</table>
			<table region="center" id="userList" class="easyui-datagrid" title="用户列表" style="height:96%;" toolbar="#toolbar" pagination="true" rownumbers="false" fitColumns="true" singleSelect="true">
				<thead>
					<tr>
						<th field="staffName" width="11%">中文名</th>
						<th field="userName" width="11%">英文名</th>
						<th field="gender" width="6%">性别</th>
						<th field="deptName" width="10%">部门</th>
						<th field="postName" width="11%">职务</th>
						<th field="roleNames" width="11%">角色</th>
						<th field="phone" width="11%">联系电话</th>
						<th field="stateName" width="6%">状态</th>
						<th field="createDate" width="16%">创建时间</th>
						<th field="operArea" width="7%">操作</th>
					</tr>
				</thead>
			</table>
			<div id="toolbar">
	   			<a href="javascript:void(0)" id="addStaff" class="easyui-linkbutton" iconCls="icon-add" onclick="newStaff()" style="width: 100px;">新增用户</a>
	   			<a href="javascript:void(0)" id="updateStaff" class="easyui-linkbutton" iconCls="icon-edit" onclick="editStaff()" style="width: 100px;">修改用户</a>
	   			<a href="javascript:void(0)" id="deleteStaff" class="easyui-linkbutton" iconCls="icon-remove" onclick="removeStaff()" style="width: 100px;">删除用户</a>
			</div>
		</div>
	</body>
</html>