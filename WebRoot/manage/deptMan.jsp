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
		<script type="text/javascript">
			var operFlag = null;
			function newDeptMan(){
				$('#dlg').dialog('open').dialog('setTitle','新增组织机构');
				$('#fm').form('clear');
				$("#handlerId").val("${sessionScope.StaffT.staffId}");
				$("input[name='deptType']")[0].checked = "checked";
				$("#regionId").combobox("disable");
				url = '/sys/orgDept/addOrgDept.do';
				operFlag = "new";
			}
			function editDeptMan(){
				var row = $('#manList').datagrid('getSelected');
				if (row){
					$('#dlg').dialog('open').dialog('setTitle','修改组织机构');
					$('#fm').form('clear');
					$('#fm').form('load',row);
					$("input[name='deptType']").each(function(i,node){
						if(node.value == row.deptType)
						{
							changeDept(node);
						}
					});
					
					$("#handlerId").val("${sessionScope.StaffT.staffId}");
					url = '/sys/orgDept/updateOrgDept.do';
					operFlag = "update";
				}
				else
				{
					$.messager.alert('提示',"请先选择要修改的机构","warning");
				}
			}
			function saveDeptMan(){
				$('#fm').form('submit',{
					url: url,
					onSubmit: function(){
						var validateFlag = $(this).form('validate');
						if(!validateFlag)
						{
							$.messager.alert('提示',"输入组织信息不全,请核实后重新尝试");
						}
						return validateFlag;
					},
					success: function(result){
						if (result == "success"){
							$('#dlg').dialog('close');		
							$("#manList").treegrid("reload");
						} else {
							if(operFlag == "new")
							{
								$.messager.alert('提示',"新增组织出错:"+result,"error");								
							}
							else
							{
								$.messager.alert('提示',"修改组织出错:"+result,"error");
							}
						}
					}
				});
			}
			function removeDeptMan(){
				var row = $('#manList').datagrid('getSelected');
				if (row)
				{
					$.messager.confirm('提示','您确定要删除当前机构吗?',function(r){
						if (r){
							$.post('/sys/orgDept/deleteOrgDept.do',{deptId:row.deptId},function(result){
								if(result == "success")
								{
									$("#manList").treegrid("reload");
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
					$.messager.alert('提示',"请先选择要删除的机构","warning");
				}
			}
			function changeDept(obj)
			{
				if(obj.value == "S")
				{
					$("#regionId").combobox("enable");
					$("#parentDeptId").combotree("setValue","");
					$("#parentDeptId").combotree("disable");
				}
				else if(obj.value == "A")
				{
					$("#regionId").combobox("enable");
					$("#parentDeptId").combotree("setValue","");
					$("#parentDeptId").combotree("disable");
				}
				else if(obj.value == "T")
				{
					$("#regionId").combobox("setValue","");
					$("#regionId").combobox("disable");
					$("#parentDeptId").combotree("enable");
				}
			}
		</script>
	</head>
	<body>
		<table id="manList" title="组织机构列表" class="easyui-treegrid" style="height:99%" data-options="url: '/sys/orgDept/getOrgList.do',method: 'get',rownumbers: true,idField: 'deptId',treeField: 'deptName',loadFilter: myLoadFilter,toolbar:'#toolbar',onBeforeExpand:function(row){var url = '/sys/orgDept/getOrgList.do?id='+row.deptId;$('#manList').treegrid('options').url = url;return true;}">
			<thead>
				<tr>
					<th field="deptName" width="40%">机构名称</th>
					<th field="address" width="20%">机构地址</th>
					<th field="telephone" width="20%">联系电话</th>
					<th field="createDate" width="20%">创建时间</th>
				</tr>
			</thead>
		</table>
		<div id="toolbar">
   			<a href="javascript:void(0)" id="addStudent" class="easyui-linkbutton" iconCls="icon-add" onclick="newDeptMan()" style="width: 120px;">新增组织机构</a>
   			<a href="javascript:void(0)" id="updateStudent" class="easyui-linkbutton" iconCls="icon-edit" onclick="editDeptMan()" style="width: 120px;">修改组织机构</a>
   			<a href="javascript:void(0)" id="viewStudent" class="easyui-linkbutton" iconCls="icon-remove" onclick="removeDeptMan()" style="width: 120px;">删除组织机构</a>
		</div>
		<div id="dlg" class="easyui-dialog" style="height:450px;padding:0px 0px" modal="true" closed="true" buttons="#dlg-buttons">
			<form id="fm" method="post" novalidate>
				<input id="deptId" name="deptId" type="hidden" value="" />
				<input id="handlerId" name="handlerId" type="hidden" value="" />
				<div class="fitem">
					<label style="text-align:right">机构名称:</label>
					<input name="deptName" id="deptName" type="text" style="width:495px" class="easyui-textbox easyui-validatebox" required="true" />
				</div>
				<div class="fitem">
					<label style="text-align:right">机构地址:</label>
					<input name="address" id="address" type="text" style="width:495px" class="easyui-textbox easyui-validatebox" required="true" />
				</div>
				<div class="fitem">
					<label style="text-align:right">机构类型:</label>
					<input type="radio" name="deptType" value="T" onclick="changeDept(this)" style="vertical-align:top;" checked="checked" /><span style="vertical-align:middle;">普通机构</span>
					<input type="radio" name="deptType" value="A" onclick="changeDept(this)" style="vertical-align:top;" /><span style="vertical-align:middle;">总部机构</span>
					<input type="radio" name="deptType" value="S" onclick="changeDept(this)" style="vertical-align:top;" /><span style="vertical-align:middle;">校区机构</span>
				</div>
				<div class="fitem">
					<label style="text-align:right">所在区域:</label>
					<select id="regionId" name="regionId" class="easyui-combobox" style="width:495px;height:25px;" data-options="formatter:function(row){return '<span>'+row.regionName+'</span>';}, valueField: 'regionId', textField: 'regionName', panelHeight: 'auto', onLoadSuccess:function(data){if(data.length > 0)$('#regionId').combobox('setValue',data[0].regionId);}" url="<%=path %>/pubData/qryRegionList.do">
      				</select>
				</div>
				<div class="fitem">
					<label style="text-align:right">机构上级:</label>
					<select class="easyui-combotree" url="/sys/orgDept/getAreaOrgDept.do" animate="true" id="parentDeptId" name="parentDeptId" style="width:495px;height:25px;" ></select>
				</div>
				<div class="fitem">
					<label style="text-align:right">联系电话:</label>
					<input name="telephone" id="telephone" type="text" style="width:495px" class="easyui-textbox easyui-validatebox" />
				</div>
				<div class="fitem">
					<label style="text-align:right">联系人:</label>
					<input name="contact" id="contact" type="text" style="width:495px" class="easyui-textbox easyui-validatebox" />
				</div>
				<div class="fitem" style="position:relative;height:155px;">
					<label style="text-align:right;position:absolute;">机构描述:</label>
					<textarea rows="10" name="deptDesc" id="deptDesc" class="easyui-validatebox" style="position:absolute;left:86px;border-radius:5px;width:495px"></textarea>
				</div>
			</form>
		</div>
		<div id="dlg-buttons">
			<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveDeptMan()">保存</a>
			<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
		</div>
	</body>
</html>