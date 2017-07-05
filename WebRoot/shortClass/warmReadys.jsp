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
		<script type="text/javascript">
			sessionStorage.clear();
		 	
		 
			$(document).ready(function(){
			$("#schoolId").combobox({
				valueField : "schoolId",
				textField : "schoolName",
				panelHeight : "auto",
				loader: function(param,success,error) {
			   		$.ajax({  
			   			url : "/sys/pub/pageCategory.do?staffId=" + ${sessionScope.StaffT.staffId} + "&resourceId=1501&fieldId=schoolId",
						dataType: 'json',  
						success: function(data) {
					    	if(data.length == schoolData.length) {
					    		data.unshift({schoolName:"全部校区", schoolId:""});  
					    	}
							success(data);  
						}
					});  
			   	},
				formatter : function(data) {
					return "<span>" + data.schoolName + "</span>";
				},
				onLoadSuccess : function(data) {
					ajaxLoadEnd();
					if(data.length > 0) {
						$("#schoolId").combobox("setValue", data[0].schoolId);
					}
				} 
			});
			});
					
			function queryFunc()
			{
				initPageNumber("manList");
				var obj = $("#manFm").serializeObject();
				 
				obj["queryCode"] = "Qry_Warm_Ready";
				obj["funcNodeId"] = "3";
				obj = JSON.stringify(obj);
				$("#manList").datagrid(
				{
					url:"/sys/pubData/qryDataListByPage.do",
					queryParams:{
						param : obj
					}
				});
			}
			function resetFunc()
			{
				var schoolData = $("#schoolManId").combobox("getData");
				if(schoolData != null && schoolData.length > 0)
				{
					$("#schoolManId").combobox("setValue",schoolData[0].schoolId);
				}
				$("#classType").combobox("setValue","");
				$("#classInfo").textbox("setValue","");
				$("#classManState").combobox("setValue","");
				$("#openStartManTime").datebox("setValue","");
				$("#openEndManTime").datebox("setValue","");
			
			}
			
			function cancel()
			{
				if(!validateSelect())
				{
					return;
				}
				
				
				 var row = $("#manList").datagrid("getSelected");
				 
				 if(row.state=='00X')
				 {
					 $.messager.alert("提示", "该学员已取消预约");
					 return;
				 }
				 
				$.messager.confirm('提示','您确定要取消当前学员预约课吗?',function(r) 
				{
    			if(r) 
    			{
					var id = row.id;
					$.ajax({
						url : "/rwx/warm/updateMyWarm.do?readyId="+id+"&sts=00X",
						dataType : "json",
						async : true,
						beforeSend: function() 
						{
    						$.messager.progress({title: "取消预约", msg: "正在取消,请稍等……"});
    					},
						success : function(data)
						{
							$.messager.progress('close');
						 	if(data.code == '200')
						 	{
						 		$.messager.alert("提示", "处理成功！", "info", function() {$("#qryBtn").click();});
						 	}else
						 	{
						 		$.messager.alert("提示", "处理失败！");
						 	}
						} 
					});
    			}
    		});
			}
			
			function handler()
			{
				if(!validateSelect())
				{
					return;
				}
				 var row = $("#manList").datagrid("getSelected");
				 
				 if(row.state=='00X')
				 {
					 $.messager.alert("提示", "该学员预约课已取消,不能预约");
					 return;
				 }
				 
					$.messager.confirm('提示','您确定要预约吗?',function(r) 
					{
	    			if(r) 
	    			{
						var id = row.id;
						$.ajax({
							url : "/rwx/warm/updateMyWarm.do?readyId="+id+"&sts=00A",
							dataType : "json",
							async : true,
							beforeSend: function() 
							{
	    						$.messager.progress({title: "预约", msg: "正在处理,请稍等……"});
	    					},
							success : function(data)
							{
								$.messager.progress('close');
							 	if(data.code == '200')
							 	{
							 		$.messager.alert("提示", "处理成功！", "info", function() {$("#qryBtn").click();});
							 	}else
							 	{
							 		$.messager.alert("提示", "处理失败！");
							 	}
							} 
						});
	    			}
	    		});
			}
			
			function validateSelect()
			{
				var flag = false;
				var obj = $('#manList').datagrid('getSelections');
				if(obj.length > 0) 
				{
					if(obj.length > 1) 
					{
						$.messager.alert('提示', "只能选择一个学员！");
					} else {
						flag = true;
					}
				} else {
					$.messager.alert('提示', "请先选择您要操作的学员！");
				}
				return flag;
			}
		</script>
  	</head>
  	<body>
  		<div id="tab" class="easyui-tabs">
  			<input type="hidden" id="staffId" name="staffId" value="${sessionScope.StaffT.staffId}"/>
		    <div title="预约管理" style="padding:5px">
				<form id="manFm">
					<table class="search_tab">
						<tr>
							<td align="right" width="80px">
								所属校区：
							</td>
							<td width="100px">
								<select id="schoolId" name="schoolId"  class="easyui-combobox" editable="false"  style="width:100px;height:25px;" ></select>
							</td>
							<td align="right" width="70px">	
								学员姓名：
							</td>
							<td width="100px">
								<input name="name" id="name" type="text" class="easyui-textbox" style="width:100px;height:25px;"/>
							</td>
							<td align="right" width="70px">
								联系电话
							</td>
							<td width="225px">
								<input name="phone" id="phone" type="text" class="easyui-textbox" style="width:100px;height:25px;"/>								
							</td>
							<td align="left">
								<a href="javascript:void(0)" id="qryBtn" class="easyui-linkbutton" iconCls="icon-search" style="width: 100px;" onclick="queryFunc()">查询</a>
								<a href="javascript:void(0)" id="resetManBtn" class="easyui-linkbutton" iconCls="icon-reload" style="width: 100px;" onclick="resetFunc()">重置</a>
							</td>
						</tr>
						
					</table>
				</form>
				<table class="easyui-datagrid" title="列表" id="manList" toolbar="#toolManbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
					<thead>
						<tr>
							<th data-options="field:'shortClassInstId',checkbox:true"></th>
							<th width="9%" field="schoolName">校区</th>
							<th width="9%" field="planHours">学员姓名</th>
							<th width="9%" field="phone">联系电话</th>
							<th width="10%" field="putClassDate">申请时间</th>
							<th width="9%" field="className">热身课班级名称</th>
							<th width="9%" field="classStateName">班级状态</th>
							<th width="9%" field="openDate">开课日期</th>
							<th width="9%" field="stateName">状态</th>
						</tr>
					</thead>
				</table>
				<div id="toolManbar" style="padding: 2px; height: auto">
					<a href="javascript:void(0)" id="classArrangementBtn" class="easyui-linkbutton" iconCls="icon-add" style="width:100px;" onclick=" handler()">预约</a>
					<a href="javascript:void(0)" id="classArrangementBtn" class="easyui-linkbutton" iconCls="icon-add" style="width:100px;" onclick=" cancel()">取消预约</a>
				</div>
			</div>
		</div>
 	</body>
</html>
