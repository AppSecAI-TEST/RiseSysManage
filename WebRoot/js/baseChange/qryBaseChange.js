$(document).ready(function(){
	initDate();
	$("#schoolId").combobox({
		onChange:function(){
			var urls ="";
			urls ="../pubData/qryClassInstList.do?schoolId="+$("#schoolId").combobox("getValue")+"&stageId="+$("#stageId").combobox("getValue");
			$("#classInstId").combobox({
				url:urls,
				valueField : "classInstId",
				textField : "className",
				panelHeight : "auto"
			});
		}
	});
	$("#stageId").combobox({
		onChange:function(){
			var urls ="";
			urls ="../pubData/qryClassInstList.do?schoolId="+$("#schoolId").combobox("getValue")+"&stageId="+$("#stageId").combobox("getValue");
			$("#classInstId").combobox({
				url:urls,
				valueField : "classInstId",
				textField : "className",
				panelHeight : "auto"
			});
		}
	});
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
			$.messager.alert('提示', "只能选择一条记录操作！");
		} else {
			flag = true;
		}
	} else {
		$.messager.alert('提示', "请先选择一条记录！");
	}
	return flag;
}