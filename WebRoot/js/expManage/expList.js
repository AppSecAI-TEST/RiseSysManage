$(document).ready(function() {
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
    $("#addExp").click(function(){
    	window.location.href="selectClass.jsp";
    });
     $("#viewInfo").click(function(){
		viewDetail();
	});
     $("#restoreClass").click(function(){
    	 restoreClass();
     });
});


function initDate()
{
	var curr_time = new Date();
	$('#endTime').datebox('setValue', myformatter(curr_time));
	curr_time.setMonth(curr_time.getMonth() - 1);
	$('#startTime').datebox('setValue', myformatter(curr_time));
	$("#startDay").textbox('setValue',"0");
	$("#endDay").textbox('setValue',"30");
}

function viewDetail()
{
	if(validateSelect("list_data"))
	{
		var row = $('#list_data').datagrid('getSelected');
		var studentId = row.studentId;
		var studentCourseId =row.studentCourseId;
		if(studentId==null||studentCourseId==null)
		{
			$.messager.alert('提示', "此学生没有课程信息");
			return false;
		}	
		window.location.href="expDetail.jsp?expInfo="+studentId+","+studentCourseId+","+row.excId;
	}	
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


function restoreClass()
{
	if(validateSelect("list_data"))
	{
		var row = $('#list_data').datagrid('getSelected');
		var studentId = row.studentId;
		var studentCourseId =row.studentCourseId;
		var state =row.excState
		if(studentId==null||studentCourseId==null)
		{
			$.messager.alert('提示', "此学生没有课程信息");
			return false;
		}
		if(state!="异常中")
		{
			$.messager.alert('提示', "非异常中状态的异常信息不能复课！");
			return false;
		}
		else
		{
			window.location.href="restoreClass.jsp?expInfo="+studentId+","+studentCourseId+","+row.excId;
		}	
	}	
}