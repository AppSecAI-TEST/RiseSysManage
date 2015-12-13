$(document).ready(function(){
	$("#applyMerge").click(function(){
		window.location.href="selectClass.jsp?isHead=N";
	})
	$("#HeadMerge").click(function(){
		window.location.href="selectClass.jsp?isHead=Y";
	})
	$("#viewMerge").click(function(){
		viewInfo("list_data");
	})
	$("#viewApprove").click(function(){
		viewInfo("list_datas");
	})
	
	initQryButton("qryBtn","resetBtn","merFm","list_data");
});


function viewInfo(tableName)
{
	if(validateSelect(tableName))
	{
		var row = $("#"+tableName+"").datagrid('getSelected');
		window.location.href ="mergeViewInfo.jsp?applyId="+row.applyId;
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