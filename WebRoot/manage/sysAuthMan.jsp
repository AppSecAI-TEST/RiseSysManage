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
	<body class="easyui-layout manage">
		<div id="leftarea" data-options="iconCls:'icons-other-house',region:'west',title:'功能模块项',split:true,width:200">
			<div style="width:96%;height:100%;padding-left:5px;">
				<ul id="funcNodeTree" class="easyui-tree" data-options="url:'/sys/funcNode/getSubFuncNodeList.do',lines:true,animate:true,onClick:getTreeNode"></ul>
			</div>
		</div>
		<div id="mainarea" data-options="region:'center'" style="padding:0px;background:#E0ECFF;min-width:300px">
			<table class="easyui-datagrid" title="功能模块列表" style="height:100%;" id="funcNodeData" toolbar="#toolbar" pagination="true" rownumbers="false" fitColumns="true" singleSelect="false">
				<thead>
					<tr>
						<th field="funcNodeName" width="20%">功能名称</th>
						<th field="funcNodeTypeName" width="20%">功能类型</th>
						<th field="html" width="20%">功能链接</th>
						<th field="parentFuncNode" width="20%">上级功能</th>
						<th field="stateDate" width="20%">创建时间</th>
					</tr>
				</thead>
			</table>
			<div id="toolbar">
	   			<a href="javascript:void(0)" id="addFuncNode" onclick="settingPrivFuncNode()" class="easyui-linkbutton" iconCls="icon-add" style="width: 120px;">设置权限功能</a>
			</div>
		</div>
		<div id="comboboxSettingDlg" class="easyui-dialog" style="width:480px;height:300px;padding:0px 0px" modal="true" closed="true" buttons="#comboboxSettingDlg-buttons">
			<form id="comboboxSettingFm" method="post" novalidate>
				<div class="fitem">
					<label style="text-align:right">功能名称:</label>
					<input type="hidden" id="comboboxId" name="comboboxId" />
					<input type="hidden" id="comboboxFuncNodeId" name="comboboxFuncNodeId" value = "${param.funcNodeId}" />
					<input type="hidden" id="comboboxResourceId" name="comboboxResourceId" />
					<select id="comboboxName" name="comboboxName" class="easyui-combobox" style="width:265px;height:25px;" data-options="formatter:function(row){return '<span>'+row.codeName+'</span>';},editable:false, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'" url="<%=path %>/pub/pageComboxList.do?funcNodeId=${param.funcNodeId}&fieldId=comboboxName">
      				</select>
				</div>
			</form>
		</div>
		<div id="comboboxSettingDlg-buttons">
			<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="comboboxSettingFunc()">保存</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#comboboxSettingDlg').dialog('close')">取消</a>
		</div>
		<div id="datagridSettingDlg" class="easyui-dialog" style="width:480px;height:300px;padding:0px 0px" modal="true" closed="true" buttons="#datagridSettingDlg-buttons">
			<table class="easyui-datagrid" title="数据列表" style="height:100%;" id="datagridSettingData" toolbar="#datagridSettingData-toolbar" pagination="true" rownumbers="false" fitColumns="true" singleSelect="false">
				<thead>
					<tr>
						<th field="dataValue" checkbox="true"></th>
						<th field="dataName" width="95%">数据名称</th>
					</tr>
				</thead>
			</table>
			<div id="datagridSettingData-toolbar">
	   			<a href="javascript:void(0)" id="addDataNode" onclick="newDataFunc()" class="easyui-linkbutton" iconCls="icon-add" style="width: 120px;">新增数据</a>
	   			<a href="javascript:void(0)" id="updateDataNode" onclick="modDataFunc()" class="easyui-linkbutton" iconCls="icon-edit" style="width: 120px;">修改数据</a>
	   			<a href="javascript:void(0)" id="delDataNode" onclick="removeFuncNode()" class="easyui-linkbutton" iconCls="icon-remove" style="width: 120px;">删除数据</a>
			</div>
		</div>
		<div id="datagridSettingDlg-buttons">
			<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="datagridSettingFunc()">保存</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#datagridSettingDlg').dialog('close')">取消</a>
		</div>
		<div id="conditionSettingDlg" class="easyui-dialog" style="width:480px;height:300px;padding:0px 0px" modal="true" closed="true" buttons="#conditionSettingDlg-buttons">
			<form id="conditionSettingFm" method="post" novalidate>
				<div class="fitem">
					<input type="hidden" id="conditionId" name="conditionId" />
					<label style="text-align:right">数据:</label>
					<select id="conditionName" name="conditionName" class="easyui-combobox" style="width:265px;height:25px;" data-options="formatter:function(row){return '<span>'+row.codeName+'</span>';},editable:false, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'" url="<%=path %>/pub/pageComboxList.do?funcNodeId=${param.funcNodeId}&fieldId=conditionName">
      				</select>
				</div>
			</form>
		</div>
		<div id="conditionSettingDlg-buttons">
			<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="conditionSettingFunc()">保存</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#conditionSettingDlg').dialog('close')">取消</a>
		</div>
		<div id="dlg" class="easyui-dialog easyui-layout" style="width:480px;height:300px;padding:0px 0px" modal="true" closed="true" buttons="#dlg-buttons">
			<table id="dgRoleList" title="系统角色" class="easyui-datagrid" style="width:30%;height:100%;margin:0 auto;padding:0 0;" data-options="region:'west'" url="" striped="true" pagination="false" rownumbers="true" fitColumns="false" singleSelect="false">
				<thead>
					<tr>
						<th field="sysRoleId" checkbox="true"></th>
						<th field="sysRoleName" width="95%">角色</th>
					</tr>
				</thead>
			</table>
			<div data-options="region:'center'" style="width:70%;height:100%;margin:0 auto;padding:0 0;">
				<ul id="nodeTree" class="easyui-tree" data-options="url:'/sys/orgDept/getSubOrgDeptList.do',lines:true,animate:true"></ul>
			</div>
		</div>
		<div id="dlg-buttons">
			<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveRoleNode()">保存</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
		</div>
		<script type="text/javascript">
			function getTreeNode()
			{
				var node = $('#funcNodeTree').tree('getSelected');
				if (node){
					$("#funcNodeData").datagrid({url:"/sys/funcNode/getFuncNodeTableList.do?id="+node.id});
				}
			}
			function settingPrivFuncNode()
			{
				var row = $('#funcNodeData').datagrid('getSelected');
				if (row){
					if(row.funcNodeType == "B")
					{
						if(row.resourceT.widgetType == "combobox")
						{
							$('#comboboxSettingDlg').dialog('open').dialog('setTitle','设置权限功能');
							$.post("/sys/funcNode/getCtrlData.do",{resourceId:row.html,funcNodeId:"${param.funcNodeId}"},function(data){
								if(data.length > 0)
								{
									$('#comboboxId').val(data[0].dataId);
									$('#comboboxName').combobox('setValue',data[0].dataValue);
								}
							},"json");
						}
						else
						{
							$('#datagridSettingDlg').dialog('open').dialog('setTitle','设置权限功能');
							$("#datagridSettingData").datagrid({url:"/sys/funcNode/getCtrlData.do?resourceId="+row.html+"&funcNodeId=${param.funcNodeId}"});
						}
					}
					else
					{
						$.messager.alert('提示',"只有权限功能才能被设置");
					}
				}
				else
				{
					$.messager.alert('提示',"请先选择要设置的功能");
				}
			}
			function comboboxSettingFunc()
			{
				var row = $('#funcNodeData').datagrid('getSelected');
				$("#comboboxResourceId").val(row.html);
				$('#comboboxSettingFm').form('submit',{
					url: "",
					onSubmit: function(){
						return $(this).form('validate');
					},
					success: function(result){
						if (result == "success"){
							$('#comboboxSettingDlg').dialog('close');		
						} else {
							$.messager.alert('提示',result);
						}
					}
				});
			}
			function datagridSettingFunc()
			{
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
			function conditionSettingFunc()
			{
			
			}
			function newDataFunc()
			{
				$('#dlg').dialog('open').dialog('setTitle','新增用户');
				$('#fm').form('clear');
				$("#handlerId").val("${sessionScope.StaffT.staffId}");
				url = '/sys/staff/addStaff.do';
			}
			function modDataFunc()
			{
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
			function removeFuncNode()
			{
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
			function saveRoleNode()
			{
				
			}
		</script>
	</body>
</html>