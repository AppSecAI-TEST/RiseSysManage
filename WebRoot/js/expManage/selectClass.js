$(document).ready(function(){
	$("#backBtn").click(function(){
		window.history.back();
	});
	$("#submitBtn").click(function(){
		if(validateSelect("list_data"))
		{
			var row = $('#list_data').datagrid('getSelected');
			var studentId = row.studentId;
			var studentCourseId =row.studentCourseId;
			var courseState =row.courseState;
			if(studentId==null||studentCourseId==null)
			{
				$.messager.alert('提示', "此学生没有课程信息");
				return false;
			}	
			window.location.href="addExp.jsp?addInfo="+studentId+","+studentCourseId+","+courseState;
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
				//一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题。
				$('#list_data').datagrid('clearSelections');
			}
		});
    });
	$("#resetBtn").click(function() {
		$('#qryFm').form('clear');
	});	
});



function validateSelect(object)
{
	var flag = false;
	var obj = $("#"+object+"").datagrid('getSelections');
	if(obj.length > 0) {
		if(obj.length > 1) {
			$.messager.alert('提示', "只能选择一条记录进行操作！");
		} else {
			flag = true;
		}
	} else {
		$.messager.alert('提示', "请先选择一条记录进行操作！");
	}
	return flag;
}