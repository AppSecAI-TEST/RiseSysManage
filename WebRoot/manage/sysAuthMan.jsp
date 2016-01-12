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
				<table id="dgRoleList" title="系统角色" class="easyui-datagrid" data-options="onClickRow:roleListRowClick" style="width:100%;height:100%;margin:0 auto;padding:0 0;" striped="true" pagination="false" rownumbers="true" fitColumns="false" singleSelect="true">
					<thead>
						<tr>
							<th field="sysRoleId" checkbox="true"></th>
							<th field="sysRoleName" width="88%">角色</th>
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
		<div id="dlgPriv" class="easyui-dialog easyui-layout" style="width:800px;height:350px;padding:0px 0px" modal="true" closed="true" buttons="#dlgPriv-buttons">
			<div data-options="region:'west'" style="width:33%;height:100%;margin:0 auto;padding:0 0;">
				<table id="dgPrivRoleList" title="系统角色" class="easyui-datagrid" data-options="onClickRow:roleListRowPrivClick" style="width:100%;height:100%;margin:0 auto;padding:0 0;" striped="true" pagination="false" rownumbers="true" fitColumns="false" singleSelect="true">
					<thead>
						<tr>
							<th field="sysRoleId" checkbox="true"></th>
							<th field="sysRoleName" width="88%">角色</th>
						</tr>
					</thead>
				</table>
			</div>
			<div data-options="region:'center'" style="width:33%;height:100%;margin:0 auto;padding:0 0;">
				<table id="dgOperFuncList" title="操作功能" class="easyui-datagrid" data-options="onClickRow:funcListRowPrivClick" style="width:100%;height:100%;margin:0 auto;padding:0 0;" striped="true" pagination="false" rownumbers="true" fitColumns="false" singleSelect="true">
					<thead>
						<tr>
							<th field="funcNodeId" checkbox="true"></th>
							<th field="funcNodeName" width="88%">功能</th>
						</tr>
					</thead>
				</table>
			</div>
			<div data-options="region:'east'" style="width:33%;height:100%;margin:0 auto;padding:0 0;">
				<table id="dgPrivFuncList" title="权限功能" class="easyui-datagrid" style="width:100%;height:100%;margin:0 auto;padding:0 0;" striped="true" pagination="false" rownumbers="true" fitColumns="false" singleSelect="true">
					<thead>
						<tr>
							<th field="funcNodeId" checkbox="true"></th>
							<th field="funcNodeName" width="88%">功能</th>
						</tr>
					</thead>
				</table>
			</div>
		</div>
		<div id="dlgPriv-buttons">
			<a href="#" class="easyui-linkbutton" iconCls="icon-edit" onclick="adjustDataFunc()">调整权限</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlgPriv').dialog('close')">取消</a>
		</div>
		<div id="comboboxSettingDlg" class="easyui-dialog" style="width:350px;height:170px;padding:0px 0px;padding-top:25px" modal="true" closed="true" buttons="#comboboxSettingDlg-buttons">
			<form id="comboboxSettingFm" class="fm" method="post" novalidate>
				<div class="fitem">
					<label style="text-align:right">权限类型:</label>
					<select id="comboboxName" name="comboboxName" class="easyui-combobox" style="width:150px;height:25px;" data-options="formatter:function(row){return '<span>'+row.codeName+'</span>';},editable:false, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'" url="<%=path %>/pub/pageComboxList.do?funcNodeId=${param.funcNodeId}&fieldId=comboboxName">
      				</select>
				</div>
			</form>
		</div>
		<div id="comboboxSettingDlg-buttons">
			<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="comboboxSettingFunc()">保存</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#comboboxSettingDlg').dialog('close')">取消</a>
		</div>
		<div id="datagridSettingDlg" class="easyui-dialog" style="width:300px;height:420px;padding:0px 0px" modal="true" closed="true" buttons="#datagridSettingDlg-buttons">
			<p style="text-align:left;width:95%;height:5%;margin:8px auto;padding:0 0;font-size:12px;font-family:'微软雅黑';font-weight:bold;">资源标识：<span id="ctrlResId" style="font-weight:normal;"></span></p>
			<table class="easyui-datagrid" title="数据列表" style="width:99%;height:90%;margin:0 auto;padding:0 0;" id="datagridSettingData" striped="true" pagination="false" rownumbers="true" fitColumns="false" singleSelect="false">
				<thead>
					<tr>
						<th field="dataValue" checkbox="true"></th>
						<th field="dataName" width="88%">数据名称</th>
					</tr>
				</thead>
			</table>
		</div>
		<div id="datagridSettingDlg-buttons">
			<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="datagridSettingFunc()">保存</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#datagridSettingDlg').dialog('close')">取消</a>
		</div>
		<div id="tabsFilterDlg" class="easyui-dialog" style="width:300px;height:420px;padding:0px 0px" modal="true" closed="true" buttons="#tabsFilterDlg-buttons">
			<p style="text-align:left;width:95%;height:8%;margin:8px auto;padding:0 0;font-size:12px;font-family:'微软雅黑';">标签：&nbsp;&nbsp;<input name="filterDataValue" id="filterDataValue" type="text" style="width:150px" class="easyui-textbox" />&nbsp;&nbsp;<a href="javascript:void(0)" id="filterDataBtn" class="easyui-linkbutton" iconCls="icon-add" style="width:70px;" onclick="addFilterDataFunc()">添加</a></p>
			<table class="easyui-datagrid" title="可使用标签列表" style="width:99%;height:85%;margin:0 auto;padding:0 0;" id="tabsFilterData" toolbar="#tabsFilterData-toolbar" striped="true" pagination="false" rownumbers="true" fitColumns="false" singleSelect="false">
				<thead>
					<tr>
						<th field="dataValue" checkbox="true"></th>
						<th field="dataName" width="88%">标签名称</th>
					</tr>
				</thead>
			</table>
			<div id="tabsFilterData-toolbar">
	   			<a href="javascript:void(0)" id="deleteTabs" onclick="removeFilterData()" class="easyui-linkbutton" iconCls="icon-remove" style="width:70px;">删除</a>
			</div>
		</div>
		<div id="tabsFilterDlg-buttons">
			<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="tabsFilterFunc()">保存</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#tabsFilterDlg').dialog('close')">取消</a>
		</div>
		<script type="text/javascript">
			$(document).ready(function(){
				$.post("/sys/sysRole/qryTotalRoleList.do",function(data){
					$("#dgRoleList").datagrid("loadData",data);
					$("#dgPrivRoleList").datagrid("loadData",data);
				},"json");
			});
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
				$("#dlgPriv").css("height","350px");
				$("#dgOperFuncList").datagrid("loadData",new Array());
				$("#dgPrivFuncList").datagrid("loadData",new Array());
				$('#dlgPriv').dialog('open').dialog('setTitle','设置权限功能');
			}
			function roleListRowPrivClick()
			{
				var row = $('#dgPrivRoleList').datagrid('getSelected');
				if (row){
					$("#dgOperFuncList").datagrid({url:"/sys/funcNode/getOperFuncNodeList.do?sysRoleId="+row.sysRoleId});
					$("#dgPrivFuncList").datagrid("loadData",new Array());
				}
			}
			function funcListRowPrivClick()
			{
				var roleRow = $('#dgPrivRoleList').datagrid('getSelected');
				var funcRow = $("#dgOperFuncList").datagrid('getSelected');
				if (funcRow){
					$("#dgPrivFuncList").datagrid({url:"/sys/funcNode/getPrivFuncNodeList.do?sysRoleId="+roleRow.sysRoleId+"&funcNodeId="+funcRow.funcNodeId});
				}
			}
			function comboboxSettingFunc()
			{
				var roleRow = $('#dgPrivRoleList').datagrid('getSelected');
				var privRow = $('#dgPrivFuncList').datagrid('getSelected');
				$.post("/sys/funcNode/settingConditionInfo.do",{roleId:roleRow.sysRoleId,funcNodeId:privRow.parentFuncNodeId,resourceId:privRow.html,valArr:$('#comboboxName').combobox('getValue'),type:"2"},function(data){
					if(data == "success"){
						$.messager.alert('提示',"权限调整成功","info",function(){
							$("#dgPrivFuncList").datagrid("reload");
							$('#comboboxSettingDlg').dialog('close');
						});
					}
					else
					{
						$.messager.alert('提示',"调整权限失败:"+data);
					}					
				});
			}
			function datagridSettingFunc()
			{
				var roleRow = $('#dgPrivRoleList').datagrid('getSelected');
				var privRow = $('#dgPrivFuncList').datagrid('getSelected');
				var gridSettingData = $("#datagridSettingData").datagrid('getChecked');
				var arr = [];
				for(var i = 0,n = gridSettingData.length;i < n;i++)
				{
					arr.push(gridSettingData[i].dataValue);
				}
				ajaxLoading("调整中....");
				$.post("/sys/funcNode/settingConditionInfo.do",{roleId:roleRow.sysRoleId,funcNodeId:privRow.parentFuncNodeId,resourceId:privRow.html,valArr:arr.join(","),type:"1"},function(data){
					ajaxLoadEnd();
					if(data == "success"){
						$.messager.alert('提示',"权限调整成功","info",function(){
							$("#dgPrivFuncList").datagrid("reload");
							$('#datagridSettingDlg').dialog('close');
						});
					}
					else
					{
						$.messager.alert('提示',"调整权限失败:"+data);
					}					
				});
			}
			function adjustDataFunc()
			{
				var roleRow = $('#dgPrivRoleList').datagrid('getSelected');
				var row = $('#dgPrivFuncList').datagrid('getSelected');
				if (row){
					if(row.resourceT.widgetType == "combobox")
					{
						$("#ctrlResId").html(row.resourceT.resourceId);
						if(row.resourceT.dataType == "P")
						{
							$('#datagridSettingDlg').dialog('open').dialog('setTitle','调整功能');
							$("#datagridSettingData").css("height","400px");
							$("#datagridSettingData").datagrid({
								url:"/sys/funcNode/getParamCtrlData.do?resourceId="+row.html+"&funcNodeId="+row.parentFuncNodeId+"&sysRoleId="+roleRow.sysRoleId,
								onLoadSuccess:function(data){
									if(data){
							            $.each(data.rows, function(index, item){
							                if(item.checked){
							                    $('#datagridSettingData').datagrid('checkRow', index);
							                }
							            });
							        }
								}
							});
						}
						else
						{
							$('#datagridSettingDlg').dialog('open').dialog('setTitle','调整功能');
							$("#datagridSettingData").css("height","400px");
							$("#datagridSettingData").datagrid({
								url:"/sys/funcNode/getCtrlData.do?resourceId="+row.html+"&funcNodeId="+row.parentFuncNodeId+"&sysRoleId="+roleRow.sysRoleId,
								onLoadSuccess:function(data){
									if(data){
							            $.each(data.rows, function(index, item){
							                if(item.checked){
							                    $('#datagridSettingData').datagrid('checkRow', index);
							                }
							            });
							        }
								}
							});
						}
					}
					else if(row.resourceT.widgetType == "tabs")
					{
						$('#tabsFilterDlg').dialog('open').dialog('setTitle','调整功能');
						$("#tabsFilterData").css("height","400px");
						$("#tabsFilterData").datagrid({
							url:"/sys/funcNode/getCtrlData.do?resourceId="+row.html+"&funcNodeId="+row.parentFuncNodeId+"&sysRoleId="+roleRow.sysRoleId,
							onLoadSuccess:function(data){
								if(data){
						            $.each(data.rows, function(index, item){
						                if(item.checked){
						                    $('#tabsFilterData').datagrid('checkRow', index);
						                }
						            });
						        }
							}
						});
					}
					else
					{
						$('#comboboxSettingDlg').dialog('open').dialog('setTitle','调整功能');
						if(row.condList.length > 0)
						{
							$('#comboboxName').combobox('setValue',row.condList[0].val);
						}
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
				ajaxLoading("调整中....");
				$.post("/sys/sysRole/settingRoleFunc.do",{sysRoleId:role.sysRoleId,funcNodeIds:arr.join(",")},function(data){
					ajaxLoadEnd();
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
			function tabsFilterFunc()
			{
				var roleRow = $('#dgPrivRoleList').datagrid('getSelected');
				var privRow = $('#dgPrivFuncList').datagrid('getSelected');
				var tabsFilterData = $("#tabsFilterData").datagrid('getData');
				var arr = [];
				for(var i = 0,n = tabsFilterData.rows.length;i < n;i++)
				{
					arr.push(tabsFilterData.rows[i].dataValue);
				}
				ajaxLoading("调整中....");
				$.post("/sys/funcNode/settingConditionInfo.do",{roleId:roleRow.sysRoleId,funcNodeId:privRow.parentFuncNodeId,resourceId:privRow.html,valArr:arr.join(","),type:"1"},function(data){
					ajaxLoadEnd();
					if(data == "success"){
						$.messager.alert('提示',"权限调整成功","info",function(){
							$("#dgPrivFuncList").datagrid("reload");
							$('#tabsFilterDlg').dialog('close');
						});
					}
					else
					{
						$.messager.alert('提示',"调整权限失败:"+data);
					}					
				});
			}
			function addFilterDataFunc()
			{
				var filterDataValue = $("#filterDataValue").textbox("getValue");
				if(filterDataValue != "")
				{
					var tabsFilterData = $("#tabsFilterData").datagrid("getData");
					if(isExistFilterData(tabsFilterData,filterDataValue))
					{
						var obj = {
							dataValue:filterDataValue,
							dataName:filterDataValue
						};
						$("#tabsFilterData").datagrid('insertRow', {
		                    index: 0,
		                    row: obj
		                });
					}
					else
					{
						$.messager.alert('提示',"您输入的标签已经存在","info",function(){
							$("#filterDataValue").textbox("setValue","");
							$("#filterDataValue").textbox("textbox").focus();
						});
					}
				}
				else
				{
					$.messager.alert('提示',"请输入要添加标签名称","info",function(){
						$("#filterDataValue").textbox("textbox").focus();
					});
				}
			}
			function isExistFilterData(dataArr , value)
			{
				for(var i = 0,n = dataArr.rows.length;i < n;i++)
				{
					if(dataArr.rows[i].dataValue == value)
					{
						return false;
					}
				}
				return true;
			}
			function removeFilterData()
			{
				var tabsFilterData = $("#tabsFilterData").datagrid('getChecked');
				for(var i = 0,n = tabsFilterData.length;i < n;i++)
				{
					$("#tabsFilterData").datagrid('deleteRow', $('#tabsFilterData').datagrid("getRowIndex",tabsFilterData[i]));					
				}
			}
		</script>
	</body>
</html>