<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String callBackFn = request.getParameter("callBackFn");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
	<head>
		<%@ include file="../common/head.jsp"%>
		<%@ include file="../common/formvalidator.jsp"%>
		<style>
			.datagrid
			{
				min-width:800px;
				width:900px;
			}
		</style>
	</head>

	<body>
		<input type="hidden" id="callBackFn" name="callBackFn"
			value="<%=callBackFn%>" />
		<input type="hidden" id="staffId" name="staffId"
			value="${sessionScope.StaffT.staffId}" />
		<input type="hidden" id="funcNodeId" name="funcNodeId"
			value="${param.funcNodeId}" />	
		<form id="qryFm" style="margin: 0 auto;">
			<table align="center"
				style=" width: 900px; border: 1px solid #95B8E7; font-family: '微软雅黑'; margin: 0 auto;"
				cellspacing="2">
				<tr>
					<td align="right">
						<span>校区：</span>
					</td>
					<td width="114px">
						<select id="schoolId" name="schoolId" class="easyui-combobox"
							style="width: 114px; height: 25px;" editable="false"
							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'">
						</select>
					</td>
					<td align="right">
						<span>学员姓名：</span>
					</td>
					<td width="114px">
						<select id="name" name="name" class="easyui-combobox"
							style="width: 114px; height: 25px;">
						</select>
					</td>
				</tr>
				<tr>
					<td align="right">
						<span>联系电话：</span>
					</td>
					<td width="114px">
						<input name="phone" id="phone" type="text" class="easyui-textbox"
							style="width: 114px; height: 25px;" />
					</td>
					<td align="right">
						<span>证件号码：</span>
					</td>
					<td width="200px">
						<input name="identityId" id="identityId" type="text"
							class="easyui-textbox" style="width: 180px; height: 25px;" />
					</td>
					<td align="left">
						<a href="javascript:void(0)" class="easyui-linkbutton"
							data-options="iconCls:'icon-search'"
							style="width: 100px; height: 25px;" id="qryBtn" funcNodeId ="3900">查询</a>
					</td>
				</tr>
			</table>
		</form>
		<div style="padding: 5px 0;">
			<table class="easyui-datagrid" title="查询结果" style="height:240px;" id="list_data"
				 url="<%=path%>/pubData/qryDataListByPage.do?funcNodeId=3900"  pagination="true" rownumbers="false" fitColumns="true"  singleSelect="true">
				<thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th  field="schoolName" align="center" width="12%">
							校区
						</th>
						<th field="name" align="center" width="12%">
							学员姓名
						</th>
						<th field="byName" align="center" width="15%">
							英文名
						</th>
						<th field="className" align="center" width="15%">
							班级
						</th>
						<th field="identityId" align="center" width="22%">
							证件号码
						</th>
						<th field="phone" align="center" width="22%">
							联系电话
						</th
					</tr>
				</thead>
			</table>
		</div>
		<div style="text-align:center;margin:10px;">
			<a href="javascript:void(0)" id="submitBtn" class="easyui-linkbutton"
				iconCls="icon-ok">提交</a>
		</div>
	</body>
</html>
<script type="text/javascript">
$(document).ready(function() {
	$("#qryBtn").click(function() {
		qry();
	});
	$("#submitBtn").click(function() {
		if(validateSelect()) 
		{
			var callBack ="parent."+$("#callBackFn").val();
			var row = $('#list_data').datagrid('getSelected');
			eval(callBack+"('"+JSON.stringify(row) +"')");
		}
	});
	$("#schoolId").combobox({
		url:"<%=path%>/pub/pageCategory.do?staffId="+$("#staffId").val()+"&funcNodeId="+$("#funcNodeId").val()+"&fieldId=schoolId",
		onLoadSuccess:function(data){if(data.length > 0)$('#schoolId').combobox('setValue',data[0].schoolId);}
	});
});

function qry()
{
	var obj = JSON.stringify($("#qryFm").serializeObject());
    	obj = obj.substring(0, obj.length - 1);
    	var funcNodeId = $("#qryBtn").attr("funcNodeId");
    	obj += ",\"funcNodeId\":\""+funcNodeId+"\"}";
    	$('#list_data').datagrid({
    		url : "/sys/pubData/qryDataListByPage.do",
    		queryParams:{
    			param : obj
    		},
    		onLoadSuccess:function(){
    			//一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题。
    			$('#list_data').datagrid('clearSelections');
    		}
    	});
}


function validateSelect()
{
	var flag = false;
	var obj = $('#list_data').datagrid('getSelections');
	if(obj.length > 0) 
	{
		if(obj.length > 1) {
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