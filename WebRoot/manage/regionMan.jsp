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
			td{
				font-size:14px;
				font-family:"微软雅黑";
			}
		</style>
  	</head>
  	<body>
		<form id="manFm" style="margin:0 auto;">
			<table align="center" style="min-width:1200px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:5px auto;height:40px;" cellspacing="2">
				<tr>
					<td align="right" width="10%">
						片区名称：
					</td>
					<td width="10%">
						<input class="easyui-textbox" name="regionName" id="regionName" style="width:120px;" />
					</td>
					<td align="right" width="75%">
						<a href="javascript:void(0)" id="queryBtn" class="easyui-linkbutton" iconCls="icon-search" style="width: 100px;" onclick="queryFunc()">查询</a>
						<a href="javascript:void(0)" id="resetBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width: 100px;" onclick="">重置</a>
					</td>
					<td></td>
				</tr>
			</table>
		</form>
		<div style="padding:5px 0;min-width:1100px; width:100%">
			<table class="easyui-datagrid" title="片区列表" style="height:580px" id="manList" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
				<thead>
					<tr>
						<th width="1%" align="center" data-options="field:'regionId',checkbox:true"></th>
						<th width="15%" align="center" field="regionName">片区名称</th>
						<th width="30%" align="center" field="schoolNames">包含校区</th>
						<th width="15%" align="center" field="managerName">联系人</th>
						<th width="15%" align="center" field="phone">联系电话</th>
						<th width="24%" align="center" field="remark">备注</th>
					</tr>
				</thead>
			</table>
			<div id="toolbar">
	   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" onclick="addRegion()">新增片区</a>
	 			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" onclick="updateRegion()">修改片区</a>
	 			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" onclick="deleteRegion()">删除片区</a>
 			</div>
		</div>
		<script type="text/javascript">
			function queryFunc()
			{
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
 	</body>
</html>