$(document).ready(function(){
	initDate();
	$("#qryBtn").click(function() {
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
    			$('#list_data').datagrid('clearSelections');
    		}
    	});
    });
	 
    $("#resetBtn").click(function() {
    	$('#qryFm').form('clear');//清空窗体数据  
    	initDate();
    });
    $("#addAction").click(function(){
		window.location.href="addAction.jsp";
	});
    $("#cancelAction").click(function(){
		turnToCancel();
	});
    $("#replyAction").click(function(){
		replyAction();
	});
     $("#updateReply").click(function(){
		updateReply();
	});
    $("#viewAction").click(function(){
		viewAction();
	});
    
});

function initDate()
{
	var curr_time = new Date();
	$('#endTime').datebox('setValue', myformatter(curr_time));
	curr_time.setMonth(curr_time.getMonth() - 1);
	$('#startTime').datebox('setValue', myformatter(curr_time));
}


function validateSelect(object)
{
	var flag = false;
	var obj = $("#"+object+"").datagrid('getSelections');
	if(obj.length > 0) {
		if(obj.length > 1) {
			$.messager.alert('提示', "只能选择一条异常记录操作！");
		} else {
			flag = true;
		}
	} else {
		$.messager.alert('提示', "请先选择一条异常记录！");
	}
	return flag;
}

function turnToCancel()
{
	if(validateSelect("list_data"))
	{
		var row = $('#list_data').datagrid('getSelected');
		if(row.state!="P")
		{
			$.messager.alert('提示', "只能取消未开展活动！");
			return false;
		}
		else
		{
			window.location.href ="cancelAction.jsp?actionId="+row.actionId;
		}	
	}	
}

function replyAction()
{
	if(validateSelect("list_data"))
	{
		var row = $('#list_data').datagrid('getSelected');
		if(row.state!="P")
		{
			$.messager.alert('提示', "只能反馈未开展活动！");
			return false;
		}
		else
		{
			window.location.href ="replyAction.jsp?actionId="+row.actionId+"&operate=A";
		}	
	}	
}


function updateReply()
{
	if(validateSelect("list_data"))
	{
		var row = $('#list_data').datagrid('getSelected');
		if(row.state!="F")
		{
			$.messager.alert('提示', "只能修改已开展反馈！");
			return false;
		}
		else
		{
			window.location.href ="replyAction.jsp?actionId="+row.actionId+"&operate=U";
		}	
	}	
}

function viewAction()
{
	if(validateSelect("list_data"))
	{
		var row = $('#list_data').datagrid('getSelected');
		window.location.href ="viewAction.jsp?actionId="+row.actionId;
	}
}