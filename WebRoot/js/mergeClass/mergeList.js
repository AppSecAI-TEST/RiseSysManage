$(document).ready(function() {
	ajaxLoading("正在处理，请稍待。。。");
	$("#applyMerge").click(function(){
		window.location.href="selectClass.jsp?isHead=N";
	});
	$("#HeadMerge").click(function(){
		window.location.href="selectClass.jsp?isHead=Y";
	});
	$("#cancelMerge").click(function(){
		cancelMerge();
	});
	$("#viewMerge").click(function(){
		viewInfo("list_data");
	});
	$("#viewApprove").click(function(){
		viewInfo("list_datas");
	});
	$("#approve").click(function(){
		approveApply();
	});
	$("#orderClass").click(function(){
		orderClass();
	});
	//调整上课时段
	$("#adjustSchooltime").click(function() {
		adjustSchooltime();
	});
	initQryButton("qryBtn","resetBtn","merFm","list_data");
	initQryButton("qryBtns","resetBtns","appFm","list_datas");
});



function viewInfo(tableName)
{
	if(validateSelect(tableName))
	{
		var row = $("#"+tableName+"").datagrid('getSelected');
		window.location.href ="mergeViewInfo.jsp?applyId="+row.applyId;
	}	
}

function adjustSchooltime() {
	if(validateSelect("list_data")) {
		var row = $("#list_data").datagrid('getSelected');
		var applyId = row.applyId;
		if(row.stateValue=="002")
		{
			window.location.href = "/sys/mergeClass/adjustSchooltime.do?applyId=" + applyId;
		}
		else
		{
			$.messager.alert('提示', "只有审批通过的记录可以调整上课时段！");
		}	
	}
}

function validateSelect(tableName)
{
	var flag = false;
	var obj = $("#"+tableName+"").datagrid('getSelections');
	if(obj.length > 0) {
		if(obj.length > 1) {
			$.messager.alert('提示', "只能选择一条记录进行操作！");
		} else {
			flag = true;
		}
	} else {
		$.messager.alert('提示', "请先选择一条记录！");
	}
	return flag;
}


function approveApply()
{
	if(validateSelect("list_datas"))
	{
		var row = $("#list_datas").datagrid('getSelected');
		if(row.stateValue=="001"||row.stateValue=="004")
		{
			window.location.href ="approveApply.jsp?applyId="+row.applyId+"&comboState="+row.stateValue;
		}	
		else
		{
			$.messager.alert('提示', "只能审批合并已申请和取消已申请的记录！");
		}	
	}	
}

function cancelMerge()
{
	if(validateSelect("list_data"))
	{
		var row = $("#list_data").datagrid('getSelected');
		if(row.stateValue=="001"||row.stateValue=="002")
		{
			window.location.href ="cancelMergeApply.jsp?applyId="+row.applyId;
		}
		else
		{
			$.messager.alert('提示', "只有处于合并已申请或合并审批通过状态的记录才能取消合并申请！");
		}	
	}
}

function orderClass()
{
	if(validateSelect("list_data"))
	{
		var row = $("#list_data").datagrid('getSelected');
		if(row.stateValue=="002")
		{
			window.location.href ="orderClass.jsp?applyId="+row.applyId;
		}
		else
		{
			$.messager.alert('提示', "只有审批通过的记录可以进行定班处理！");
		}	
	}
}