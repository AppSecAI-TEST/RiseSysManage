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
		</style>
	</head>
	<body class="easyui-layout manage">
		<div id="leftarea" data-options="iconCls:'icons-other-house',region:'west',title:'组织机构',split:true,width:200">
			<div style="width:96%;height:100%;padding-left:5px;">
				<ul id="deptTree" class="easyui-tree" data-options="url:'/sys/orgDept/getSubOrgDeptList.do',lines:true,animate:true,onClick:getTreeNode"></ul>
			</div>
		</div>
		<div id="mainarea" data-options="region:'center'" style="padding:0px;background:#E0ECFF;min-width:300px">
			<table id="userList" class="easyui-datagrid" title="用户列表" style="height:100%;" toolbar="#toolbar" pagination="true" rownumbers="false" fitColumns="true" singleSelect="true">
				<thead>
					<tr>
						<th field="staffName" width="15%">用户姓名</th>
						<th field="userName" width="15%">用户账户</th>
						<th field="deptName" width="15%">所属部门</th>
						<th field="phone" width="20%">联系电话</th>
						<th field="hireDate" width="20%">入职时间</th>
						<th field="stateName" width="15%">状态</th>
					</tr>
				</thead>
			</table>
			<div id="toolbar">
	   			<a href="javascript:void(0)" id="addStaff" class="easyui-linkbutton" iconCls="icon-add" onclick="newStaff()" style="width: 100px;">新增用户</a>
	   			<a href="javascript:void(0)" id="updateStaff" class="easyui-linkbutton" iconCls="icon-edit" onclick="editStaff()" style="width: 100px;">修改用户</a>
	   			<a href="javascript:void(0)" id="deleteStaff" class="easyui-linkbutton" iconCls="icon-remove" onclick="removeStaff()" style="width: 100px;">删除用户</a>
			</div>
			<div id="dlg" class="easyui-dialog" style="width:480px;height:300px;padding:0px 0px" modal="true" closed="true" buttons="#dlg-buttons">
				<form id="fm" method="post" novalidate>
					<input id="staffId" name="staffId" type="hidden" value="" />
					<input id="handlerId" name="handlerId" type="hidden" value="" />
					<div class="fitem">
						<label style="text-align:right">用户名称:</label>
						<input name="userName" id="userName" type="text" style="width:265px" class="easyui-textbox easyui-validatebox" required="true" />
					</div>
					<div class="fitem">
						<label style="text-align:right">用户密码:</label>
						<input name="password" id="password" type="password" style="width:265px" validType="length[4,20]" class="easyui-textbox easyui-validatebox" required="true" />
					</div>
					<div class="fitem">
						<label style="text-align:right">确认密码:</label>
						<input name="confirm" id="confirm" type="password" style="width:265px" validType="equalTo['#password']" invalidMessage="两次输入密码不匹配" class="easyui-textbox easyui-validatebox" required="true" />
					</div>
					<div class="fitem">
						<label style="text-align:right">真实名称:</label>
						<input name="staffName" id="staffName" type="text" style="width:265px" class="easyui-textbox easyui-validatebox" required="true" />
					</div>
					<div class="fitem">
						<label style="text-align:right">所属部门:</label>
						<select class="easyui-combotree" url="/sys/orgDept/getRootOrgDept.do" animate="true" id="deptId" name="deptId" style="width:265px" ></select>
					</div>
					<div class="fitem">
						<label style="text-align:right">入职日期:</label>
						<input name="hireDate" id="hireDate" type="text" style="width:265px" class="easyui-datebox" editable="false" data-options="formatter:myformatter, parser:myparser" required="true" />
					</div>
					<div class="fitem">
						<label style="text-align:right">联系电话:</label>
						<input name="phone" id="phone" type="text" style="width:265px" class="easyui-textbox easyui-validatebox" required="true" />
					</div>
				</form>
			</div>
			<div id="dlg-buttons">
				<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveStaff()">保存</a>
				<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
			</div>
		</div>
		<script type="text/javascript">
			function getTreeNode(){
				var node = $('#deptTree').tree('getSelected');
				if (node){
					$("#userList").datagrid({url:"/sys/staff/qryStaffListByDeptId.do?deptId="+node.id});
				}
			}
			function newStaff(){
				$('#dlg').dialog('open').dialog('setTitle','新增用户');
				$('#fm').form('clear');
				$("#handlerId").val("${sessionScope.StaffT.staffId}");
				url = '/sys/staff/addStaff.do';
			}
			function editStaff(){
				var row = $('#userList').datagrid('getSelected');
				if (row){
					$('#dlg').dialog('open').dialog('setTitle','修改用户');
					$('#fm').form('clear');
					$('#fm').form('load',row);
					$("#handlerId").val("${sessionScope.StaffT.staffId}");
					url = '/sys/staff/updateStaff.do';
				}
				else
				{
					$.messager.alert('提示',"请先选择要修改的用户");
				}
			}
			function saveStaff(){
				$('#fm').form('submit',{
					url: url,
					onSubmit: function(){
						var validateFlag = $(this).form('validate');
						if(!validateFlag)
						{
							$.messager.alert('提示',"输入用户信息不全,请核实后重新尝试");
						}
						return validateFlag;
					},
					success: function(result){
						if (result == "success"){
							$('#dlg').dialog('close');		
							$("#userList").datagrid("reload");
						} else {
							$.messager.alert('提示',result);
						}
					}
				});
			}
			function removeStaff(){
				var row = $('#userList').datagrid('getSelected');
				if (row)
				{
					$.messager.confirm('提示','您确定要删除当前用户吗?',function(r){
						if (r){
							$.post('/sys/staff/deleteStaff.do',{staffId:row.staffId},function(result){
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
		</script>
	</body>
</html>