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
	<body class="easyui-layout userRoleMan">
		<table class="easyui-datagrid" title="查询结果" style="height:99%;" id="roleList" url="/sys/sysRole/roleList.do" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
			<thead>
				<tr>
					<th field="sysRoleName" width="20%">角色名称</th>
					<th field="roleMemo" width="20%">角色描述</th>
					<th field="createDate" width="20%">创建时间</th>
					<th field="stateDate" width="20%">修改时间</th>
					<th field="stateName" width="20%">状态</th>
				</tr>
			</thead>
		</table>
		<div id="toolbar">
   			<a href="javascript:void(0)" id="addRole" onclick="newRole()" class="easyui-linkbutton" iconCls="icon-add" style="width: 120px;">新增角色</a>
   			<a href="javascript:void(0)" id="updateRole" onclick="editRole()" class="easyui-linkbutton" iconCls="icon-edit" style="width: 120px;">修改角色</a>
   			<a href="javascript:void(0)" id="deleteRole" onclick="removeRole()" class="easyui-linkbutton" iconCls="icon-remove" style="width: 120px;">删除角色</a>
   			<a href="javascript:void(0)" id="allocateRole" onclick="allocateUserRole()" class="easyui-linkbutton" iconCls="icon-reload" style="width: 120px;">分配用户角色</a>
		</div>
		<div id="userRoleDlg" class="easyui-dialog easyui-layout" style="width:1000px;height:400px;padding:0px 0px" modal="true" closed="true" buttons="#userRoleDlg-buttons">
			<div class="easyui-panel" title="组织机构"  data-options="iconCls:'icons-other-house',region:'west'" style="width:30%;height:100%;margin:0 auto;padding:0 0">
				<ul id="deptTree" class="easyui-tree" data-options="url:'/sys/orgDept/getSubOrgDeptList.do',lines:true,animate:true,onClick:getTreeNode"></ul>
			</div>
			<div data-options="region:'center'" style="width:70%;height:100%;margin:0 auto;padding:0 0">
				<div style="float:left;height:100%;width:40%;margin:0 auto;padding:0 0">
					<table id="dgCanUsers" title="可分配用户" class="easyui-datagrid" style="height:350px" url="" pagination="false" rownumbers="false" fitColumns="false" singleSelect="false">
						<thead>
							<tr>
								<th field="staffId" checkbox="true"></th>
								<th field="staffName" width="95%">用户</th>
							</tr>
						</thead>
					</table>
				</div>
				<div style="float:left;height:100%;width:20%;margin:0 auto;padding:0 0">
					<ul style="list-style-type:none;padding-left:0px">
						<li style="text-align:center;margin-top:100px;"><a href="#" class="easyui-linkbutton" iconCls="icon-leftFlag" onclick="leftUsers()" style="width:85px;margin:0 auto;text-align:center;">&nbsp;</a></li>
						<li style="text-align:center;margin-top:40px;"><a href="#" class="easyui-linkbutton" iconCls="icon-rightFlag" onclick="rightUsers()" style="width:85px;margin:0 auto;text-align:center;">&nbsp;</a></li>
					</ul>
				</div>
				<div style="float:left;height:100%;width:40%;margin:0 auto;padding:0 0">
					<table id="dgHasUsers" title="已分配用户" class="easyui-datagrid" style="height:350px" url="" pagination="false" rownumbers="false" fitColumns="false" singleSelect="false">
						<thead>
							<tr>
								<th field="staffId" checkbox="true"></th>
								<th field="staffName" width="95%">用户</th>
							</tr>
						</thead>
					</table>
				</div>
			</div>
		</div>
		<div id="userRoleDlg-buttons">
			<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveRole()">保存</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
		</div>
		<div id="dlg" class="easyui-dialog" style="width:480px;height:230px;padding:0px 0px" modal="true" closed="true" buttons="#dlg-buttons">
			<form id="fm" method="post" novalidate>
				<input id="sysRoleId" name="sysRoleId" type="hidden" value="" />
				<input id="staffId" name="staffId" type="hidden" value="" />
				<div class="fitem">
					<label style="text-align:right">角色名称:</label>
					<input name="sysRoleName" id="sysRoleName" type="text" style="width:265px" class="easyui-textbox easyui-validatebox" required="true" />
				</div>
				<div class="fitem">
					<label style="text-align:right;vertical-align:top;">角色描述:</label>
					<input name="roleMemo" id="roleMemo" type="text" style="width:265px;height:100px" class="easyui-textbox easyui-validatebox" data-options="multiline:true" required="true" />
				</div>
			</form>
		</div>
		<div id="dlg-buttons">
			<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveRole()">保存</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
		</div>
		<script type="text/javascript">
			function newRole(){
				$('#dlg').dialog('open').dialog('setTitle','新增角色');
				$('#fm').form('clear');
				$("#staffId").val("${sessionScope.StaffT.staffId}");
				url = '/sys/sysRole/addRole.do';
			}
			function editRole(){
				var row = $('#roleList').datagrid('getSelected');
				if (row){
					$('#dlg').dialog('open').dialog('setTitle','修改角色');
					$('#fm').form('clear');
					$('#fm').form('load',row);
					$("#staffId").val("${sessionScope.StaffT.staffId}");
					url = '/sys/sysRole/updateRole.do';
				}
				else
				{
					$.messager.alert('提示',"请先选择要修改的角色");
				}
			}
			function saveRole(){
				$('#fm').form('submit',{
					url: url,
					onSubmit: function(){
						var validateFlag = $(this).form('validate');
						if(!validateFlag)
						{
							$.messager.alert('提示',"输入角色信息有误,请核实后重新尝试");
						}
						return validateFlag;
					},
					success: function(result){
						if (result == "success"){
							$('#dlg').dialog('close');		
							$("#roleList").datagrid("reload");
						} else {
							$.messager.alert('提示',result);
						}
					}
				});
			}
			function removeRole(){
				var row = $('#roleList').datagrid('getSelected');
				if (row)
				{
					$.messager.confirm('提示','您确定要删除当前角色吗?',function(r){
						if (r){
							$.post('/sys/sysRole/deleteRole.do',{sysRoleId:row.sysRoleId},function(result){
								if(result == "success")
								{
									$("#roleList").datagrid("reload");
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
					$.messager.alert('提示',"请先选择要删除的角色");
				}
			}
			
			function getTreeNode(){
				var node = $('#deptTree').tree('getSelected');
				if (node){
					$("#dgCanUsers").datagrid({url:"/sys/staff/qryStaffListByDeptId.do?deptId="+node.id});
				}
			}
			
			function allocateUserRole()
			{
				var row = $('#roleList').datagrid('getSelected');
				if (row){
					$('#userRoleDlg').dialog('open').dialog('setTitle','分配用户角色');
					$("#dgCanUsers").datagrid("reload");
					//$("#dgHasUsers").datagrid({url:""});
				}
				else
				{
					$.messager.alert('提示',"请先选择要分配的角色");
				}
			}
			
			function saveManFuncs()
			{
				var obj = $('#dgHasFuncs').datagrid('getData');
				var man = $('#dg').datagrid('getSelected');
				var arr = [];
				for(var i = 0,n = obj.total;i < n;i++)
				{
					arr.push(obj.rows[i].menuId);
				}
				$.post('/man/updateMan.do',{manId:man.manId,manFuncs:arr.join(",")},function(result){
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
			
			function leftUsers()
			{
				var obj = $('#dgHasUsers').datagrid('getSelections');
				if(obj){
					for(var i = 0,n = obj.length;i < n;i++)
					{
	                	$("#dgHasUsers").datagrid('deleteRow', $('#dgHasFuncs').datagrid("getRowIndex",obj[i]));
						$("#dgCanUsers").datagrid('insertRow', {
		                    index: 0,
		                    row: obj[i]
		                });
	                }
				}
			}
			
			function rightUsers()
			{
				var obj = $('#dgCanUsers').datagrid('getSelections');
				if(obj){
                	for(var i = 0,n = obj.length;i < n;i++)
					{
						$("#dgCanUsers").datagrid('deleteRow',$('#dgCanFuncs').datagrid("getRowIndex",obj[i]));
						$("#dgHasUsers").datagrid('insertRow', {
		                    index: 0,
		                    row: obj[i]
		                });
					}
				}
			}
		</script>
	</body>
</html>