$(document).ready(function(){
	$("#state").combobox({
		url : "/sys/pubData/qryCodeNameList.do?tableName=STUDENT_COURSE_T&codeType=COURSE_TYPE",
		onChange:function(){
			var urls ="";
			var stateValue=$("#state").combobox("getValue");
			if(stateValue=="001")
			{
				urls ="/sys/pubData/qryCodeNameList.do?tableName=STUDENT_COURSE_T&codeType=CLASS_TYPE";
				$("#classType").combobox({
				url:urls,
				panelHeight : "auto"
				});
			}
			else
			{
				$("#classType").combobox({
				url:"/sys/pubData/qryCodeNameList.do?tableName=STUDENT_COURSE_T&codeType=11111",
				panelHeight : "auto"
				});
			}	
			
		}
	});
	$("#states").combobox({
		url : "/sys/pubData/qryCodeNameList.do?tableName=STUDENT_COURSE_T&codeType=COURSE_TYPE",
		onChange:function(){
			var urls ="";
			var stateValue=$("#states").combobox("getValue");
			if(stateValue=="001")
			{
				urls ="/sys/pubData/qryCodeNameList.do?tableName=STUDENT_COURSE_T&codeType=CLASS_TYPE";
				$("#classTypes").combobox({
				url:urls,
				panelHeight : "auto"
				});
			}
			else
			{
				$("#classTypes").combobox({
				url:"/sys/pubData/qryCodeNameList.do?tableName=STUDENT_COURSE_T&codeType=11111",
				panelHeight : "auto"
				});
			}	
		}
	});
	$("#schoolId").combobox( {
		url : "/sys/pub/pageCategory.do?staffId="+$("#handlerId").val()+"&resourceId=700&fieldId=schoolId&headFlag=N",
		onChange : function() {
			var sId = $("#schoolId").combobox("getValue");
			var urls = "/sys/pubData/qryTeacherList.do?schoolId=" + sId;
			$("#adviser").combobox( {
				url : urls
			});
			$("#adviserTeacher").combobox( {
				url : urls
			});
		},
		onLoadSuccess:function(data){
			if(data.length>0)
			{
				$("#schoolId").combobox("select",data[0].schoolId);
			}
		}
	});
	$("#schoolIds").combobox( {
		url : "/sys/pub/pageCategory.do?staffId="+$("#handlerId").val()+"&resourceId=700&fieldId=schoolId&headFlag=N",
		onChange : function() {
			var sId = $("#schoolIds").combobox("getValue");
			var urls = "/sys/pubData/qryTeacherList.do?schoolId=" + sId;
			$("#advisers").combobox( {
				url : urls
			});
			$("#adviserTeachers").combobox( {
				url : urls
			});
		},
		onLoadSuccess:function(data){
			if(data.length>0)
			{
				$("#schoolIds").combobox("select",data[0].schoolId);
			}	
		}
	});
    
    $("#changeFee").click(function() {
    	changeFee();
    });
    $("#viewFee").click(function(){
    	viewFeeInfo();
    });
    initQryButton("qryBtn","resetBtn","qryFm","list_data");
	initQryButton("qryBtn1","resetBtn1","qryFm1","list_data1");
});
	
function initDate()
{
	var curr_time = new Date();
	$('#endTime').datebox('setValue', myformatter(curr_time));
	curr_time.setMonth(curr_time.getMonth() - 1);
	$('#startTime').datebox('setValue', myformatter(curr_time));
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

function changeFee()
{
	if(validateSelect("list_data"))
	{
		var row = $('#list_data').datagrid('getSelected');
		if(row.courseState!="001"&&row.courseState!="002")
		{
			$.messager.alert('提示', "只能调整课程状态为未定班和已定班的课程费用！");
			return false;
		}
		else
		{
			window.location.href ="changeFee.jsp?studentCourseId="+row.studentCourseId;

		}	
	}
	
}


function viewFeeInfo()
{
	if(validateSelect("list_data"))
	{
		var row = $('#list_data').datagrid('getSelected');
		window.location.href ="viewFeeInfo.jsp?studentCourseId="+row.studentCourseId;
	}
}
