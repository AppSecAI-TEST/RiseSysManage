$(document).ready(function(){
	$("#applyMerge").click(function(){
		window.location.href="selectClass.jsp?isHead=N";
	})
	$("#HeadMerge").click(function(){
		window.location.href="selectClass.jsp?isHead=Y";
	})
	$("#cancelMerge").click(function(){
		cancelMerge();
	})
	$("#viewMerge").click(function(){
		viewInfo("list_data");
	})
	$("#viewApprove").click(function(){
		viewInfo("list_datas");
	})
	$("#approve").click(function(){
		approveApply();
	})
	$("#orderClass").click(function(){
		orderClass();
	})
//	var strArr=["审批管理","合并班级管理"];
//	$("ul.tabs").find("li").each(function(){
//		if(!isContain(strArr,$(this).find("span.tabs-title").html()))
//		{
//			$(this).css("display","none");
//		}	
//	})
//	$("ul.tabs").find("li:visible:first").trigger("click");
	initQryButton("qryBtn","resetBtn","merFm","list_data");
	initQryButton("qryBtns","resetBtns","appFm","list_datas");
});

function isContain(arr,val)
{
	var flag =false;
	if(arr.length>0)
	{
		for(var i=0;i<arr.length;i++)
		{
			if(val==arr[i])
			{
				flag =true;
				break;
			}	
		}	
	}	
	return flag;
}

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


function approveApply()
{
	if(validateSelect("list_datas"))
	{
		var row = $("#list_datas").datagrid('getSelected');
		window.location.href ="approveApply.jsp?applyId="+row.applyId+"&comboState="+row.stateValue;
	}	
}

function cancelMerge()
{
	if(validateSelect("list_data"))
	{
		var row = $("#list_data").datagrid('getSelected');
		if(row.stateValue=="001"||row.stateValue=="003")
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
		//if(row.stateValue=="001")
		//{
			window.location.href ="orderClass.jsp?applyId="+row.applyId;
		//}
		//else
		//{
			//$.messager.alert('提示', "！");
		//}	
	}
}