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
				<ul id="funcNodeTree" class="easyui-tree" data-options="url:'/sys/funcNode/getSubFuncNodeList.do',lines:true,animate:true"></ul>
			</div>
		</div>
		<div id="mainarea" data-options="region:'center'" style="padding:0px;background:#E0ECFF;min-width:300px">
			<table class="easyui-datagrid" title="功能模块列表" style="height:100%;" id="funcNodeData" toolbar="#toolbar" pagination="true" rownumbers="false" fitColumns="true" singleSelect="false">
				<thead>
					<tr>
						<th field="funcNodeName" width="15%">功能名称</th>
						<th field="funcNodeType" width="15%">功能类型</th>
						<th field="html" width="15%">功能链接</th>
						<th field="parentFuncNode" width="20%">上级功能</th>
						<th field="stateDate" width="20%">创建时间</th>
						<th field="state" width="15%">功能状态</th>
					</tr>
				</thead>
			</table>
			<div id="toolbar">
	   			<a href="javascript:void(0)" id="addFuncNode" onclick="newFuncNode()" class="easyui-linkbutton" iconCls="icon-add" style="width: 120px;">分配角色功能</a>
			</div>
		</div>
		<div id="dlg" class="easyui-dialog" style="width:480px;height:300px;padding:0px 0px" modal="true" closed="true" buttons="#dlg-buttons">
			<form id="fm" method="post" novalidate>
				<input id="funcNodeId" name="funcNodeId" type="hidden" value="" />
				<div class="fitem">
					<label style="text-align:right">功能名称:</label>
					<input name="funcNodeName" id="funcNodeName" type="text" style="width:265px" class="easyui-textbox easyui-validatebox" required="true" />
				</div>
				<div class="fitem">
					<label style="text-align:right">功能类型:</label>
					<select id="funcNodeType" name="funcNodeType" class="easyui-combobox" style="width:265px;height:25px;" data-options="formatter:function(row){return '<span>'+row.regionName+'</span>';}, valueField: 'regionId', textField: 'regionName', panelHeight: 'auto', onLoadSuccess:function(data){if(data.length > 0)$('#regionId').combobox('setValue',data[0].regionId);}" url="<%=path %>/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&funcNodeId=${param.funcNodeId}&fieldId=regionId">
      				</select>
				</div>
				<div class="fitem">
					<label style="text-align:right">功能链接:</label>
					<input name="html" id="html" type="text" style="width:265px" class="easyui-textbox easyui-validatebox" required="true" />
				</div>
				<div class="fitem">
					<label style="text-align:right;vertical-align:top;">功能描述:</label>
					<input name="description" id="description" type="text" style="width:265px;height:100px" class="easyui-textbox easyui-validatebox" data-options="multiline:true" required="true" />
				</div>
			</form>
		</div>
		<div id="dlg-buttons">
			<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveFuncNode()">保存</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
		</div>
		<script type="text/javascript">
			function getTreeNode(){
				var node = $('#funcNodeTree').tree('getSelected');
				if (node){
					$("#funcNodeData").datagrid({url:"/sys/staff/qryStaffListByDeptId.do?deptId="+node.id});
				}
			}
		</script>
	</body>
</html>