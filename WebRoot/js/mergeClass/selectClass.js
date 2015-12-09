var max=5;
$(document).ready(function(){
	$("#backBtn").click(function(){
		history.back();
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
    $("#addClass").click(function() {
    	addClass();
    });
    $("#subClass").click(function(){
    	subClass();
    });
    
});


function addClass()
{
	var count =$("#classList").find("a").length;
	var obj = $("#list_data").datagrid('getSelections');
	if(obj.length > max-count) 
	{
		$.messager.alert('提示', "最多只能选择五个班级进行合并！");
		return false;
	} 
	else if(obj.length==0)
	{
		$.messager.alert('提示', "请至少选择一个班级进行添加！");
		return false;
	}
	$.each(obj,function(i,node){
		addClassSpan(node.classInstId+"",node.className)
	});
	$('#list_data').datagrid('clearSelections');
}

function addClassSpan(val1,val2)
{
	var flag =true;
	$("#classList").find("a").each(function(){
		if($(this).attr("classInstId")==val1)
		{
			flag =false;
			return false;
		}	
	});
	if(flag)
	{
		$("#classList").append("<a title='点击删除该班级' onclick='deleteThis(this)' classInstId=\""+val1+"\">"+val2+"</a>");
	}	
}


function deleteThis(obj)
{
	$(obj).remove();
}

function subClass()
{
	var classInstIds ="";
	$("#classList").find("a").each(function(){
		classInstIds+=$(this).attr("classInstId")+",";
	});
	var re = new RegExp(",","g");
	if(classInstIds=="")
	{
		$.messager.alert('提示', "请选择班级进行合并！");
		return false;
	}	
	else if(classInstIds.match(re).length<2)
	{
		$.messager.alert('提示', "请至少选择两个班级进行合并！");
		return false;
	}
	classInstIds=classInstIds.substring(0,classInstIds.length-1);
	window.location.href="mergeClassApply.jsp?classInstIds="+classInstIds+"&isHead=N";
}