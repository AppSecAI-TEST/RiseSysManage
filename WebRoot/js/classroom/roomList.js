$(document).ready(function(){
	$("#addClassroom").click(function(){
		addClassroom();
	});
	$("#updateClassroom").click(function(){
		updateClassroom();
	});
	$("#deleteClassroom").click(function(){
		deleteClassroom();
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
    });
});

function addClassroom()
{
	window.location.href="operateClassroom.jsp?operate=A&roomId=";
}

function updateClassroom()
{
	if(validateSelect("list_data"))
	{
		var row = $('#list_data').datagrid('getSelected');
		window.location.href="operateClassroom.jsp?operate=U&roomId="+row.roomId;
	}	
}

function deleteClassroom()
{
	if(validateSelect("list_data"))
	{
		var row = $('#list_data').datagrid('getSelected');
		$.messager.confirm('提示','您确定要删除该教室资源？',function(r) {
    			if(r) 
    			{
    				$.post('/sys/classroom/deleteClassroom.do', {roomId:row.roomId}, function(result) 
    				{
	    				if(result=="true") 
	    				{
	    					$.messager.alert('提示', "删除该教室资源成功",null,function(){
	    						$("#qryBtn").trigger("click");
	    					});
	    				}
	    				else 
	    				{
	    					$.messager.alert('提示', "删除该教室资源失败");
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
			$.messager.alert('提示', "只能选择一条记录操作！");
		} else {
			flag = true;
		}
	} else {
		$.messager.alert('提示', "请先选择一条记录！");
	}
	return flag;
}