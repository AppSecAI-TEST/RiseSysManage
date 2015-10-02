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
		<table id="funcNodeData" title="功能模块列表" class="easyui-treegrid" style="width:99%;height:99%" data-options="url:'/sys/funcNode/getFuncNodeInfoList.do',method: 'post',rownumbers: true,idField: 'funcNodeId',treeField: 'funcNodeName',loadFilter: myLoadFilter,toolbar:'#toolbar',onBeforeExpand:function(row){var url = '/sys/funcNode/getFuncNodeInfoList.do?id='+row.funcNodeId;$('#funcNodeData').treegrid('options').url = url;return true;}">
			<thead>
				<tr>
					<th field="funcNodeName" width="20%">功能名称</th>
					<th field="funcNodeTypeName" width="20%">功能类型</th>
					<th field="html" width="20%">功能链接</th>
					<th field="description" width="20%">功能状态</th>
					<th field="stateDate" width="20%">创建时间</th>
				</tr>
			</thead>
		</table>
		<div id="toolbar">
   			<a href="javascript:void(0)" id="addFuncNode" onclick="newFuncNode()" class="easyui-linkbutton" iconCls="icon-add" style="width: 120px;">新增功能</a>
   			<a href="javascript:void(0)" id="updateFuncNode" onclick="editFuncNode()" class="easyui-linkbutton" iconCls="icon-edit" style="width: 120px;">修改功能</a>
   			<a href="javascript:void(0)" id="deleteFuncNode" onclick="removeFuncNode()" class="easyui-linkbutton" iconCls="icon-remove" style="width: 120px;">删除功能</a>
		</div>
		<div id="dlg" class="easyui-dialog" style="width:480px;height:350px;padding:0px 0px;" modal="true" closed="true" buttons="#dlg-buttons">
			<form id="fm" method="post" novalidate>
				<input id="funcNodeId" name="funcNodeId" type="hidden" value="" />
				<div class="fitem">
					<label style="text-align:right">功能名称:</label>
					<input name="funcNodeName" id="funcNodeName" type="text" style="width:265px" class="easyui-textbox easyui-validatebox" required="true" />
				</div>
				<div class="fitem">
					<label style="text-align:right">功能类型:</label>
					<select id="funcNodeType" name="funcNodeType" class="easyui-combobox" style="width:265px;height:25px;" data-options="formatter:function(row){return '<span>'+row.codeName+'</span>';},editable:false, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto' ,onLoadSuccess:function(data){if(data.length > 0)$('#funcNodeType').combobox('setValue',data[0].codeFlag);}" url="<%=path %>/pub/pageComboxList.do?funcNodeId=${param.funcNodeId}&fieldId=funcNodeType">
      				</select>
				</div>
				<div class="fitem">
					<label style="text-align:right">上级功能:</label>
					<select id="parentFuncNodeId" name="parentFuncNodeId" class="easyui-combotree" style="width:265px;height:25px;">
      				</select>
				</div>
				<div class="fitem">
					<label style="text-align:right">功能链接:</label>
					<input name="html" id="html" type="text" style="width:265px" class="easyui-textbox" />
				</div>
				<div class="fitem">
					<label style="text-align:right;vertical-align:top;">功能描述:</label>
					<input name="description" id="description" type="text" style="width:265px;height:100px" class="easyui-textbox" data-options="multiline:true" />
				</div>
				<div id="fieldArea" style="display:none;border-top:1px dotted #cccccc;padding-top:5px">
					<input type="hidden" id="resourceId" name="resourceId" />
					<input type="hidden" id="handlerId" name="handlerId" />
					<div class="fitem">
						<label style="text-align:right">控件属性:</label>
						<input name="fieldId" id="fieldId" type="text" style="width:265px" class="easyui-textbox easyui-validatebox" />
					</div>
					<div class="fitem">
						<label style="text-align:right">控件名称:</label>
						<input name="fieldName" id="fieldName" type="text" style="width:265px" class="easyui-textbox easyui-validatebox" />
					</div>
					<div class="fitem">
						<label style="text-align:right">控件类型:</label>
						<select id="widgetType" name="widgetType" class="easyui-combobox" style="width:265px;height:25px;" data-options="formatter:function(row){return '<span>'+row.codeName+'</span>';},editable:false, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto' ,onLoadSuccess:function(data){if(data.length > 0)$('#widgetType').combobox('setValue',data[0].codeFlag);}" url="<%=path %>/pub/pageComboxList.do?funcNodeId=${param.funcNodeId}&fieldId=widgetType">
	      				</select>
	      				<input type="hidden" id="widgetName" name="widgetName" />
					</div>
					<div class="fitem">
						<label style="text-align:right">所依赖表:</label>
						<input name="dataSourceTable" id="dataSourceTable" type="text" style="width:265px" class="easyui-textbox" />
					</div>
					<div class="fitem">
						<label style="text-align:right">依赖字段:</label>
						<input name="dataSourceField" id="dataSourceField" type="text" style="width:265px" class="easyui-textbox" />
					</div>
					<div class="fitem">
						<label style="text-align:right">字段名称:</label>
						<input name="dataSourceName" id="dataSourceName" type="text" style="width:265px" class="easyui-textbox" />
					</div>
					<div class="fitem">
						<label style="text-align:right;vertical-align:top;">依赖语句:</label>
						<input name="dataSourceSql" id="dataSourceSql" type="text" style="width:265px;height:100px" class="easyui-textbox" data-options="multiline:true" />
					</div>
				</div>
			</form>
		</div>
		<div id="dlg-buttons">
			<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveFuncNode()">保存</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
		</div>
		<script type="text/javascript">
			var gParentMenuData = null;
			var gParentOperData = null;
			var gParentPrivData = null;
			var gEditRow = null;
			$.post("/sys/funcNode/getParentMenuList.do",{},function(data){
				gParentMenuData = data;
			},"json");
			$.post("/sys/funcNode/getParentOperList.do",{},function(data){
				gParentOperData = data;
			},"json");
			$.post("/sys/funcNode/getParentPrivList.do",{},function(data){
				gParentPrivData = data;
			},"json");
			$(document).ready(function(){
				$("#funcNodeType").combobox({
					onChange:function(){
						var dataValue = $("#funcNodeType").combobox("getValue");
						if(gEditRow == null)
						{
							if(dataValue == "M")
							{
								$("#parentFuncNodeId").combotree("loadData",gParentMenuData);
								$("#html").textbox("setValue","");
								$("#html").textbox("readonly",true);
								$("#fieldArea").css("display","none");
								$("#fieldId").validatebox({required:false});
								$("#fieldName").validatebox({required:false});
								$("#dataSourceField").validatebox({required:false});
								$("#dataSourceName").validatebox({required:false});
							}
							else if(dataValue == "H")
							{
								$("#parentFuncNodeId").combotree("loadData",gParentOperData);
								$("#html").textbox("readonly",false);
								$("#fieldArea").css("display","none");
								$("#fieldId").validatebox({required:false});
								$("#fieldName").validatebox({required:false});
								$("#dataSourceField").validatebox({required:false});
								$("#dataSourceName").validatebox({required:false});
							}
							else if(dataValue == "B")
							{
								$("#parentFuncNodeId").combotree("loadData",gParentPrivData);
								$("#html").textbox("setValue","");
								$("#html").textbox("readonly",true);
								$("#fieldArea").css("display","block");
								$("#fieldId").validatebox({required:true});
								$("#fieldName").validatebox({required:true});
								$("#dataSourceField").validatebox({required:true});
								$("#dataSourceName").validatebox({required:true});
							}
						}
						else
						{
							$("#funcNodeType").combobox("setValue",gEditRow.funcNodeType);
						}
					}
				});
				$("#widgetType").combobox({
					onChange:function(){
						var dataText = $("#widgetType").combobox("getText");
						$("#widgetName").val(dataText);
					}
				});
			});
			function newFuncNode(){
				gEditRow = null;
				$("#parentFuncNodeId").combotree({disabled:false});
				$("#fieldArea").css("display","none");
				$("#fieldId").textbox("readonly",false);
				$('#dlg').dialog('open').dialog('setTitle','新增功能');
				$('#fm').form('clear');
				$("#handlerId").val("${sessionScope.StaffT.staffId}");
				url = '/sys/funcNode/addFuncNodeInfo.do';
			}
			function editFuncNode(){
				$("#parentFuncNodeId").combotree({disabled:false});
				var row = $('#funcNodeData').treegrid('getSelected');
				if (row && row.funcNodeId != 0)
				{
					$('#dlg').dialog('open').dialog('setTitle','修改功能');
					$('#fm').form('clear');
					if(row.funcNodeType == 'M')
					{
						$("#parentFuncNodeId").combotree("loadData",gParentMenuData);
						$("#html").textbox("setValue","");
						$("#html").textbox("readonly",true);
						$("#fieldArea").css("display","none");
					}
					else if(row.funcNodeType == 'H')
					{
						$("#parentFuncNodeId").combotree("loadData",gParentOperData);
						$("#html").textbox("readonly",false);
						$("#fieldArea").css("display","none");
						$("#fieldId").textbox("readonly",false);
					}
					else
					{
						$("#parentFuncNodeId").combotree("loadData",gParentPrivData);
						$("#html").textbox("readonly",true);
						$("#fieldArea").css("display","block");
						$("#fieldId").textbox("readonly",true);
					}
					$('#fm').form('load',row);
					if(row.parentFuncNodeId != 0)
					{
						$("#parentFuncNodeId").combotree("setValue",row.parentFuncNodeId);
					}
					else
					{
						$("#parentFuncNodeId").combotree({disabled:true});
					}
					url = '/sys/funcNode/updateFuncNodeInfo.do';
					gEditRow = row;
				}
				else if(row && row.funcNodeId == 0)
				{
					$.messager.alert('提示',"不能修改该功能");
				}
				else
				{
					$.messager.alert('提示',"请先选择要修改的功能");
				}
			}
			function saveFuncNode(){
				$('#fm').form('submit',{
					url: url,
					onSubmit: function(){
						var validateFlag = $(this).form('validate');
						if(!validateFlag)
						{
							$.messager.alert('提示',"输入功能信息不全,请核实后重新尝试");
						}
						return validateFlag;
					},
					success: function(result){
						if (result == "success"){
							$('#dlg').dialog('close');		
							$("#funcNodeData").treegrid("reload");
						} else {
							$.messager.alert('提示',result);
						}
					}
				});
			}
			function removeFuncNode(){
				var row = $('#funcNodeData').treegrid('getSelected');
				if (row)
				{
					$.messager.confirm('提示','您确定要删除当前功能吗?',function(r){
						if (r){
							$.post('/sys/funcNode/deleteFuncNodeInfo.do',{funcNodeId:row.funcNodeId},function(result){
								if(result == "success")
								{
									$("#funcNodeData").treegrid("reload");
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
					$.messager.alert('提示',"请先选择要删除的功能");
				}
			}
		</script>
	</body>
</html>