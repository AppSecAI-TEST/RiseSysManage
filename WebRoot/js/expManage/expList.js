$(document).ready(function() {
	initQryButton("qryBtn","resetBtn","qryFm","list_data");
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
		if(state!="001")
		{
			$.messager.alert('提示', "非异常中状态的异常信息不能复课！");
			return false;
		}
		else
		{
			if(row.excStateVal=="已超期")
			{
				$.messager.alert('提示', "已超期的异常信息不能复课！");
				return false;
			}	
			window.location.href="restoreClass.jsp?expInfo="+studentId+","+studentCourseId+","+row.excId;
		}	
	}	
}