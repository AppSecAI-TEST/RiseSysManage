$(document).ready(function(){
	$("#addCourse").click(function(){
		addCourse();
	});
});
function qryData()
{
	var obj = JSON.stringify($("#qryFm").serializeObject());
	$('#list_data').datagrid({
		url : "qryCourseInfo.do",
		queryParams:{
			json : obj
		},
		onLoadSuccess:function(){
			//一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题。
			$('#list_data').datagrid('clearSelections');
		}
	});
	
}

function addCourse()
{
//	if(validateSelect("list_data"))
//	{
//		var row = $('#list_data').datagrid('getSelected');
//		var studentId = row.studentId;
//		if(studentId==null)
//		{
//			$.messager.alert('提示', "没有学员信息");
//			return false;
//		}	
//		
//	}
	var studentId ="2";//临时测试用
	window.location.href="addCourseList.jsp?studentId="+studentId;
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