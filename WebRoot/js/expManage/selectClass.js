$(document).ready(function(){
	initQryButton("qryBtn","resetBtn","qryFm","list_data");
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
			var classProgress =row.classProgress;
			var stageLevel =row.stageLevel;
			var className =row.className;
			var teacherName =row.teacherName;
			if(studentId==null||studentCourseId==null)
			{
				$.messager.alert('提示', "此学生没有课程信息");
				return false;
			}	
			window.location.href="addExp.jsp?addInfo="+studentId+","+studentCourseId+","+courseState+","+classProgress+","+stageLevel+","+className+","+teacherName;
		}	
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