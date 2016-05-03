<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript">
			function queryFunc()
			{
				initPageNumber("manList");
				var obj = $("#manFm").serializeObject();
				obj["queryCode"] = "qryRegionInfo";
				obj["funcNodeId"] = "4630";
				obj = JSON.stringify(obj);
				$("#manList").datagrid({
					url:"/sys/pubData/qryDataListByPage.do",
					queryParams:{
						param : obj
					}
				});
			}
			function addRegion()
			{
				window.location.href = "/sys/regionManage/jumpToRegion.do?type=ADD";
			}
			function updateRegion()
			{
				if(validateSelect("manList")) {
					var row = $("#manList").datagrid('getSelected');
					var region = {};
					region.regionId = row.regionId;	
					region.regionName = row.regionName;	
					region.schoolIds = row.schoolIds;	
					region.managerName = row.managerName;	
					region.phone = row.phone;	
					region.remark = row.remark;	
					window.location.href = "/sys/regionManage/jumpToRegion.do?json="+JSON.stringify(region)+"&type=UPDATE";
				}
			}
			function deleteRegion()
			{
				if(validateSelect("manList")) {
					var row = $("#manList").datagrid('getSelected');
					$.messager.confirm('提示','您确定要删除该片区吗?',function(r){	
						if(r)
						{
							$.ajax({
								type : "POST",
								url: "/sys/regionManage/deleteRegion.do",
								data: "regionId="+row.regionId,
								async: false,
								beforeSend: function()
						    	{
						    		$.messager.progress({title : '删除片区', msg : '删除片区中，请稍等……'});
						    	},
						    	success: function(flag) {
						    		$.messager.progress('close'); 
						    		if(flag == "true"){
						    			$.messager.alert('提示', "删除片区成功！","info",function(){
						    				window.location.reload();
										});
						    		}else if(flag == "false"){
						    			$.messager.alert('提示', "删除片区失败！");
						    		}
						        } 
						     });
					  	  }
					  });
				}
			}
			function validateSelect(object)
			{
				var flag = false;
				var obj = $("#"+object+"").datagrid('getSelections');
				if(obj.length > 0) {
					if(obj.length > 1) {
						$.messager.alert('提示', "只能选择一个片区操作！");
					} else {
						flag = true;
					}
				} else {
					$.messager.alert('提示', "请先选择您要操作的片区！");
				}
				return flag;
			}
		</script>
  	</head>
  	<body>
		<form id="manFm">
			<table class="search_tab">
				<tr>
					<td align="right" width="10%">
						<span>片区名称：</span>
					</td>
					<td width="10%">
						<input class="easyui-textbox" name="regionName" id="regionName" style="width:400px;height:25px;" />
					</td>
					<td align="right" width="75%">
						<a href="javascript:void(0)" id="queryBtn" class="easyui-linkbutton" iconCls="icon-search" style="width: 100px;" onclick="queryFunc()"><span>查询</span></a>
						<a href="javascript:void(0)" id="resetBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width: 100px;" onclick=""><span>重置</span></a>
					</td>
					<td></td>
				</tr>
			</table>
		</form>
		<table class="easyui-datagrid" align="center" title="片区列表" id="manList" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
			<thead>
				<tr>
					<th width="1%" align="center" data-options="field:'regionId',checkbox:true"></th>
					<th width="15%" align="center" field="regionName"><span>片区名称</span></th>
					<th width="30%" align="center" field="schoolNames"><span>包含校区</span></th>
					<th width="15%" align="center" field="managerName"><span>联系人</span></th>
					<th width="15%" align="center" field="phone"><span>联系电话</span></th>
					<th width="24%" align="center" field="remark"><span>备注</span></th>
				</tr>
			</thead>
		</table>
		<div id="toolbar" style="padding: 2px;height:auto;">
  			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" style="width:100px;" onclick="addRegion()"><span>新增片区</span></a>
			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" style="width:100px;" onclick="updateRegion()"><span>修改片区</span></a>
			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" style="width:100px;" onclick="deleteRegion()"><span>删除片区</span></a>
		</div>
 	</body>
</html>