$(document).ready(function(){
	var staffId = $("#staffId").val();
	var funcNodeId = $("#funcNodeId").val();
	$("#schoolId").combobox({
		url : "/sys/pub/pageCategory.do?staffId="+$("#staffId").val()+"&resourceId=711&fieldId=schoolId&headFlag=N",
    	valueField : "schoolId",
    	textField : "schoolName",
    	panelHeight : "auto",
    	formatter : function(data) {
    		return "<span>" + data.schoolName + "</span>";
    	},
    	onLoadSuccess : function() {
    		if($("#schoolId").combobox("getData").length>0)
    		{
    			$("#schoolId").combobox("setValue",$("#schoolId").combobox("getData")[0].schoolId);
    		}	
    	},
    	onChange : function(n, o) {
    		if(n != "" && n != null && n != undefined) {
    		} 
    	}
	});
	
	$("#single").click(function() {
		addSingleCourse();
	});
	$("#multiple").click(function() {
		addMultipleCourse();
	});
	$("#backBt").click(function() {
		window.location.href = "qryCourseInfo.jsp";
	});
	initQryButton("qryBtn","reset","qryFm","list_data");
});


function addSingleCourse()
{
	if(validateSelect("list_data")) 
	{
		var row = $('#list_data').datagrid('getSelected');
    	var studentId = row.studentId;
    	var schoolId = row.schoolId;
    	var studentInfo =row.name+";;"+row.byName+";;"+row.birthday+";;"+row.identityId+";;"+row.sexText;
    	window.location.href="addCourse.jsp?schoolId="+schoolId+"&studentId="+studentId+"&studentInfo="+studentInfo;
	}
}

function addMultipleCourse()
{
	if(validateSelect("list_data")) 
	{
		var row = $('#list_data').datagrid('getSelected');
    	var studentId = row.studentId;
    	var schoolId = row.schoolId;
    	var studentInfo =row.name+";;"+row.byName+";;"+row.birthday+";;"+row.identityId+";;"+row.sexText;
    	window.location.href="link.jsp?schoolId="+schoolId+"&studentId="+studentId+"&studentInfo="+studentInfo;
	}
}

function validateSelect(object)
{
	var flag = false;
	var obj = $("#"+object+"").datagrid('getSelections');
	if(obj.length > 0) 
	{
		if(obj.length > 1) 
		{
			$.messager.alert('提示', "只能选择一个学员进行操作！");
		} else 
		{
			flag = true;
		}
	} else 
	{
		$.messager.alert('提示', "请先选择您要操作的学员！");
	}
	return flag;
}