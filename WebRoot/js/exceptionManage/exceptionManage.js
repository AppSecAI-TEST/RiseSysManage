$(document).ready(function(){
	//首页面查询
    $("#qryBtn").click(function() {
		var obj = JSON.stringify($("#qryFm").serializeObject());
		obj = obj.substring(0, obj.length - 1);
		var funcNodeId = $("#qryBtn").attr("funcNodeId");
		obj += ",\"funcNodeId\":\""+funcNodeId+"\"}";
		$('#list_data').datagrid({
			url : "/sys/expManage/qryDataListByPage.do",
			queryParams:{
				param : obj
			},
			onLoadSuccess:function(){
				//一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题。
				$('#list_data').datagrid('clearSelections');
			}
		});
    });
});

function updateExp()
{
	if(validateSelect("list_data")) {
		var row = $('#list_data').datagrid('getSelected');
		var studentId = row.studentId;
		var studentCourseId = row.studentCourseId;
		var expType = "001";
		window.location.href = "/sys/expManage/viewExpStuInfo.do?studentId="+studentId+"&studentCourseId="+studentCourseId+"&expType="+expType;
	}
}

function viewExpInfo()
{
	if(validateSelect("list_data")) {
		var row = $('#list_data').datagrid('getSelected');
		var studentId = row.studentId;
		var studentCourseId = row.studentCourseId;
		var expType = "001";
		window.location.href = "/sys/expManage/qryExpStuDetailInfo.do?studentId="+studentId+"&studentCourseId="+studentCourseId+"&expType="+expType;
	}
}

//打开添加校区页面
function viewFollowHis(studentId,expType,studentCourseId)
{
	$('#dlg').dialog({
		title:"查看跟进历史",
	});
	$('#dlg').attr("src","/sys/exceptionManage/followHistory.jsp?studentId="+studentId+"&expType="+expType+"&studentCourseId="+studentCourseId);
	$('#dlg').dialog("open");
}

function validateSelect(object)
{
	var flag = false;
	var obj = $("#"+object+"").datagrid('getSelections');
	if(obj.length > 0) {
		if(obj.length > 1) {
			$.messager.alert('提示', "只能选择一个异动学员进行操作！");
		} else {
			flag = true;
		}
	} else {
		$.messager.alert('提示', "请先选择您要操作的异动学员！");
	}
	return flag;
}