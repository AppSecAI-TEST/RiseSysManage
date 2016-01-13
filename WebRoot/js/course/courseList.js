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
	$("#qryBtn").click(function() {
    	qry();
    });
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

function initDate()
{
	var curr_time = new Date();
	$('#createEndTime').datebox('setValue', myformatter(curr_time));
	curr_time.setMonth(curr_time.getMonth() - 1);
	$('#createStartTime').datebox('setValue', myformatter(curr_time));
}

function qry()
{
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
	
}