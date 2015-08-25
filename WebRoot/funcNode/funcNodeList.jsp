<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
		<script type="text/javascript" src="<%=path %>/js/funcNode.js"></script>
  	</head>
  
  	<body>
  		<div style="padding:5px 0;">
  			<form id="qryFm">
  				<table>
  					<tr>
  						<td>权限名称：</td>
  						<td><input class="easyui-textbox" style="width:100%;height: 25px;" id="funcNodeName" name="funcNodeName"></td>
  						<td style="text-align: right;">
	  						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:150px" id="qryBtn">查询</a>
	  					</td>
  					</tr>
  				</table>
  			</form>
  			
  			<div id="toolbar" style="padding: 2px 15px; height: auto">
    			<a href="javascript:void(0)" id="addFuncNode" class="easyui-linkbutton" iconCls="icon-add" plain="true">新增权限</a>
    			<a href="javascript:void(0)" id="updateFuncNode" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改权限</a>
    			<a href="javascript:void(0)" id="deleteFuncNode" class="easyui-linkbutton" iconCls="icon-remove" plain="true">删除权限</a>
  			</div>
  			
  			<div style="padding:5px 0;">
				<table class="easyui-datagrid" title="角色列表" style="width:100%;height:350px" id="list_data" iconCls="icon-edit" url="<%=path %>/funcNode/qryFuncNodeList.do" 
				toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
					<thead>
						<tr>
							<th data-options="field:'ck',checkbox:true"></th>
							<th data-options="field:'funcNodeId',width:80,align:'center'">权限ID</th>
							<th data-options="field:'funcNodeName',width:100,align:'center'">权限名称</th>
							<th data-options="field:'funcNodeType',width:100,align:'center'">权限类型</th>
							<th data-options="field:'description',width:120,align:'center'">权限描述</th>
							<th data-options="field:'stateDate',width:120,align:'center'">状态时间</th>
						</tr>
					</thead>
				</table>
			</div>
  		</div>
  		
  		<div id="dlg" class="easyui-dialog" style="width: 580px; height: 350px; padding: 10px 20px" closed="true" data-options="modal:true" buttons="#dlgBtn">
  			<form id="fm" method="post">
  				<input name="funcNodeId" id="funcNodeId" type="hidden" />
  				<table style="width: 100%;" cellSpacing='0' cellPadding='5px'>
  					<tr>
  						<td style="text-align: right;width: 20%">角色名称：</td>
  						<td>
	  						<input class="easyui-validatebox textbox" style="width: 320px;height: 25px;" id="funcNodeName" name="funcNodeName" data-options="required:true">
  						</td>
  					</tr>
  					<tr>
  						<td style="text-align: right;width: 20%">上级权限：</td>
  						<td>
	  						<select class="easyui-combobox" style="width: 320px;height: 25px;" name="parentFuncNodeId" id="parentFuncNodeId" data-options="panelHeight:'auto'">
		  					</select>
  						</td>
  					</tr>
  					<tr>
  						<td style="text-align: right;width: 20%">权限类型：</td>
  						<td>
	  						<select class="easyui-combobox" style="width: 320px;height: 25px;" name="funcNodeType" id="funcNodeType" data-options="panelHeight:'auto'">
		  					</select>
  						</td>
  					</tr>
  					<tr>
  						<td style="text-align: right;width: 20%">权限描述：</td>
  						<td>
  							<textarea rows="9" cols="43" id="description" name="description" class="easyui-validatebox textbox"></textarea>
  						</td>
  					</tr>
  				</table>
  			</form>
  		</div>
  		<div id="dlgBtn">
    		<a href="javascript:void(0)" id="submit" class="easyui-linkbutton" iconCls="icon-ok">保存</a> 
    		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
  		</div>
  		
  	</body>
</html>
