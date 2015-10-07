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
			<table class="easyui-datagrid" title="功能模块列表" style="height:100%;" id="funcNodeData" toolbar="#toolbar" pagination="true" rownumbers="false" fitColumns="true" singleSelect="true">
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
	   			<a href="javascript:void(0)" id="addRoleNode" onclick="settingRoleFuncNode()" class="easyui-linkbutton" iconCls="icon-add" style="width: 120px;">设置角色功能</a>
	   			<a href="javascript:void(0)" id="addSettingNode" onclick="settingPrivFuncNode()" class="easyui-linkbutton" iconCls="icon-reload" style="width: 120px;">设置权限功能</a>
			</div>
		</div>
		<div id="dlg" class="easyui-dialog easyui-layout" style="width:500px;height:350px;padding:0px 0px" modal="true" closed="true" buttons="#dlg-buttons">
			<div data-options="region:'west'" style="width:50%;height:100%;margin:0 auto;padding:0 0;">
				<table id="dgRoleList" title="系统角色" class="easyui-datagrid" data-options="url:'/sys/sysRole/qryTotalRoleList.do',onClickRow:roleListRowClick" style="width:100%;height:100%;margin:0 auto;padding:0 0;" striped="true" pagination="false" rownumbers="true" fitColumns="false" singleSelect="true">
					<thead>
						<tr>
							<th field="sysRoleId" checkbox="true"></th>
							<th field="sysRoleName" width="95%">角色</th>
						</tr>
					</thead>
				</table>
			</div>
			<div class="easyui-panel" data-options="region:'east',collapsible:false" title="所对应功能" style="width:50%;height:100%;margin:0 auto;padding:0 0;">
				<ul id="nodeTree" class="easyui-tree" data-options="lines:true,animate:true,checkbox:true"></ul>
			</div>
		</div>
		<div id="dlg-buttons">
			<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveRoleNode()">保存</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
		</div>
		<div id="dlgPriv" class="easyui-dialog easyui-layout" style="width:500px;height:350px;padding:0px 0px" modal="true" closed="true" buttons="#dlgPriv-buttons">
			<div data-options="region:'west'" style="width:50%;height:100%;margin:0 auto;padding:0 0;">
				<table id="dgPrivRoleList" title="系统角色" class="easyui-datagrid" data-options="url:'/sys/sysRole/qryTotalRoleList.do',onClickRow:roleListRowPrivClick" style="width:100%;height:100%;margin:0 auto;padding:0 0;" striped="true" pagination="false" rownumbers="true" fitColumns="false" singleSelect="true">
					<thead>
						<tr>
							<th field="sysRoleId" checkbox="true"></th>
							<th field="sysRoleName" width="95%">角色</th>
						</tr>
					</thead>
				</table>
			</div>
			<div data-options="region:'east'" style="width:50%;height:100%;margin:0 auto;padding:0 0;">
				<table id="dgPrivFuncList" title="权限功能" class="easyui-datagrid" style="width:100%;height:100%;margin:0 auto;padding:0 0;" striped="true" pagination="false" rownumbers="true" fitColumns="false" singleSelect="true">
					<thead>
						<tr>
							<th field="funcNodeId" checkbox="true"></th>
							<th field="funcNodeName" width="95%">功能</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
		<div id="dlgPriv-buttons">
			<a href="#" class="easyui-linkbutton" iconCls="icon-edit" onclick="adjustDataFunc()">调整权限</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlgPriv').dialog('close')">取消</a>
		</div>
		<div id="comboboxSettingDlg" class="easyui-dialog" style="width:450px;height:180px;padding:0px 0px;padding-top:25px" modal="true" closed="true" buttons="#comboboxSettingDlg-buttons">
			<form id="comboboxSettingFm" class="fm" method="post" novalidate>
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
			<table class="easyui-datagrid" title="数据列表" style="height:100%;" id="datagridSettingData" pagination="true" rownumbers="false" fitColumns="true" singleSelect="false">
				<thead>
					<tr>
						<th field="dataValue" checkbox="true"></th>
						<th field="dataName" width="95%">数据名称</th>
					</tr>
				</thead>
			</table>
		</div>
		<div id="datagridSettingDlg-buttons">
			<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="datagridSettingFunc()">保存</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#datagridSettingDlg').dialog('close')">取消</a>
		</div>
		<script type="text/javascript">
			function getTreeNode()
			{
				var node = $('#funcNodeTree').tree('getSelected');
				if (node){
					$("#funcNodeData").datagrid({url:"/sys/funcNode/getFuncNodeTableList.do?id="+node.id});
				}
			}
			function settingRoleFuncNode()
			{
				$("#dlg").css("height","350px");
				$('#dlg').dialog('open').dialog('setTitle','设置角色功能');
			}
			function roleListRowClick()
			{
				var row = $('#dgRoleList').datagrid('getSelected');
				if (row){
					ajaxLoading("加载中....")
					$.post("/sys/funcNode/getSubFuncNodeListWithRole.do",{sysRoleId:row.sysRoleId},function(data){
						ajaxLoadEnd();
						$("#nodeTree").tree("loadData",data);
					},"json");
				}
			}
			function settingPrivFuncNode()
			{
				/*
				*/
				$("#dlgPriv").css("height","350px");
				$('#dlgPriv').dialog('open').dialog('setTitle','设置权限功能');
			}
			function roleListRowPrivClick()
			{
				var row = $('#dgPrivRoleList').datagrid('getSelected');
				if (row){
					$("#dgPrivFuncList").datagrid({url:"/sys/funcNode/getPrivFuncNodeList.do?sysRoleId="+row.sysRoleId});
				}
			}
			/*
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
			
			}*/
			function adjustDataFunc()
			{
				var row = $('#dgPrivFuncList').datagrid('getSelected');
				if (row){
					if(row.resourceT.widgetType == "combobox")
					{
						$('#datagridSettingDlg').dialog('open').dialog('setTitle','调整功能');
						$("#datagridSettingData").datagrid({url:"/sys/funcNode/getCtrlData.do?resourceId="+row.html+"&funcNodeId=${param.funcNodeId}"});
					}
					else
					{
						$('#comboboxSettingDlg').dialog('open').dialog('setTitle','调整功能');
						$.post("/sys/funcNode/getCtrlData.do",{resourceId:row.html,funcNodeId:"${param.funcNodeId}"},function(data){
							if(data.length > 0)
							{
								$('#comboboxId').val(data[0].dataId);
								$('#comboboxName').combobox('setValue',data[0].dataValue);
							}
						},"json");
					}
				}
				else
				{
					$.messager.alert('提示',"请先选择要调整的功能");
				}
			}
			function saveRoleNode()
			{
				var role = $('#dgRoleList').datagrid('getSelected');
				var nodes = $('#nodeTree').tree('getChecked');
				var arr = [];
				for(var i = 0,n = nodes.length;i < n;i++)
				{
					arr.push(nodes[i].id);
				}
				$.post("/sys/sysRole/settingRoleFunc.do",{sysRoleId:role.sysRoleId,funcNodeIds:arr.join(",")},function(data){
					if(data == "success"){
						$.messager.alert('提示',"功能点调整成功","info",function(){
							$("#dgRoleList").datagrid("reload");
							$("#nodeTree").tree("reload");
							$('#dlg').dialog('close');
						});	
					}
					else
					{
						$.messager.alert('提示',"调整功能点失败:"+data);
					}
				});
			}
		</script>
	</body>
</html>