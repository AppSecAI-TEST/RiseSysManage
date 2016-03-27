<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<link rel="stylesheet" type="text/css" href="<%=path %>/pub/js/easyui/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css" href="<%=path %>/pub/js/easyui/themes/icon.css">
		<link rel="stylesheet" type="text/css" href="<%=path %>/pub/js/demo.css">
		<script type="text/javascript" src="<%=path %>/pub/js/jquery.min.js"></script>
		<script type="text/javascript" src="<%=path %>/pub/js/jquery.cookie.js"></script>
		<script type="text/javascript" src="<%=path %>/pub/js/easyui/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="<%=path %>/pub/js/formvalidator/formValidator.min.js"></script>
		<script type="text/javascript" src="<%=path %>/pub/js/formvalidator/formValidatorRegex.js"></script>
		<script type="text/javascript" src="<%=path %>/pub/js/json.js"></script>
		<script type="text/javascript" src="<%=path %>/pub/js/json2.js"></script>
		<script type="text/javascript" src="<%=path %>/js/sysRole.js"></script>
  	</head>
  
  	<body>
  		<div style="padding:5px 0;">
  			<form id="qryFm">
  				<table>
  					<tr>
  						<td>角色名称：</td>
  						<td><input class="easyui-textbox" style="width:100%;height: 25px;" id="sysRoleName" name="sysRoleName"></td>
  						<td style="text-align: right;">
	  						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:150px" id="qryBtn">查询</a>
	  					</td>
  					</tr>
  				</table>
  			</form>
  			
  			<div id="toolbar" style="padding: 2px 15px; height: auto">
    			<a href="javascript:void(0)" id="addSysRole" class="easyui-linkbutton" iconCls="icon-add" plain="true">新增角色</a>
    			<a href="javascript:void(0)" id="updateSysRole" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改角色</a>
    			<a href="javascript:void(0)" id="deleteSysRole" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除角色</a>
    			<a href="javascript:void(0)" id="allocSysRole" class="easyui-linkbutton" iconCls="icon-save" plain="true">分配权限</a>
  			</div>
  			
  			<div style="padding:5px 0;">
				<table class="easyui-datagrid" title="角色列表" style="width:100%;height:350px" id="list_data" iconCls="icon-edit" url="<%=path %>/sysRole/qrySysRoleList.do" 
				toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
					<thead>
						<tr>
							<th data-options="field:'ck',checkbox:true"></th>
							<th data-options="field:'sysRoleId',width:80,align:'center'">角色ID</th>
							<th data-options="field:'sysRoleName',width:100,align:'center'">角色名称</th>
							<th data-options="field:'roleMemo',width:120,align:'center'">角色描述</th>
							<th data-options="field:'createDate',width:120,align:'center'">创建时间</th>
							<th data-options="field:'stateDate',width:120,align:'center'">状态时间</th>
						</tr>
					</thead>
				</table>
			</div>
  		</div>
  		
  		<div id="dlg" class="easyui-dialog" style="width: 580px; height: 350px; padding: 10px 20px" closed="true" data-options="modal:true" buttons="#dlgBtn">
  			<form id="fm" method="post">
  				<input name="sysRoleId" id="sysRoleId" type="hidden" />
  				<input name="staffId" id="staffId" type="hidden">
  				<table style="width: 100%;" cellSpacing='0' cellPadding='5px'>
  					<tr>
  						<td style="text-align: right;width: 20%">角色名称：</td>
  						<td>
	  						<input class="easyui-validatebox textbox" style="width: 320px;height: 25px;" id="sysRoleName" name="sysRoleName" data-options="required:true">
  						</td>
  					</tr>
  					<tr>
  						<td style="text-align: right;width: 20%">所属学校：</td>
  						<td>
	  						<select class="easyui-combobox" style="width: 320px;height: 25px;" name="schoolId" id="schoolId" data-options="panelHeight:'auto'">
		  					</select>
  						</td>
  					</tr>
  					<tr>
  						<td style="text-align: right;width: 20%">角色描述：</td>
  						<td>
  							<textarea rows="9" cols="43" id="roleMemo" name="roleMemo" class="textarea easyui-validatebox" validType="length[0,120]"></textarea>
  						</td>
  					</tr>
  				</table>
  			</form>
  		</div>
  		<div id="dlgBtn">
    		<a href="javascript:void(0)" id="submit" class="easyui-linkbutton" iconCls="icon-ok">保存</a> 
    		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
  		</div>
  		
  		<div id="allocDlg" class="easyui-dialog" style="width: 820px; height: 500px; padding: 10px 20px" closed="true" data-options="modal:true" buttons="#allocDlgBtn">
  			<form id="allocFm" method="post">
  				<table width="100%" height="96%">
  					<tr>
  						<td width="40%" align="center">
  							<div style="padding:5px 0; height: 88%">
  								<table class="easyui-datagrid" title="可分配权限" style="width:98%;height:100%" id="notAllocTd" fitColumns="true" singleSelect="false" iconCls="icon-edit">
  									<thead>
										<tr>
											<th data-options="field:'ck',checkbox:true"></th>
											<th data-options="field:'funcNodeId',width:80,align:'center'">权限ID</th>
											<th data-options="field:'funcNodeName',width:120,align:'center'">权限名称</th>
											<th data-options="field:'allocAuth',width:100,align:'center'">授用类型</th>
										</tr>
									</thead>
  								</table>
  							</div>
  						</td>
  						<td width="10%" align="center">
  							<table>
  								<tr>
  									<td>
  										<a href="javascript:void(0)" id="alloc" class="easyui-linkbutton" style="width: 30px; margin-left: 5px;">-></a>
  									</td>
								</tr>
								<tr>
  									<td>
  										<a href="javascript:void(0)" id="deleteAlloc" class="easyui-linkbutton" style="width: 30px; margin-left: 5px;"><-</a>
  									</td>
								</tr>
  							</table>
  						</td>
  						<td width="40%" align="center">
  							<div style="padding:5px 0; height: 88%">
  								<table class="easyui-datagrid" title="已分配权限" style="width:98%;height:100%" id="allocTd" fitColumns="true" singleSelect="false" iconCls="icon-edit">
  									<thead>
										<tr>
											<th data-options="field:'ck',checkbox:true"></th>
											<th data-options="field:'funcNodeId',width:80,align:'center'">权限ID</th>
											<th data-options="field:'funcNodeName',width:120,align:'center'">权限名称</th>
											<th data-options="field:'allocAuth',width:100,align:'center'">授用类型</th>
										</tr>
									</thead>
  								</table>
  							</div>
  						</td>
  					</tr>
  				</table>
  			</form>
  		</div>
  		<div id="allocDlgBtn">
    		<a href="javascript:void(0)" id="allocSubmit" class="easyui-linkbutton" iconCls="icon-ok">保存</a> 
    		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#allocDlg').dialog('close')">取消</a>
  		</div>
  	</body>
</html>
