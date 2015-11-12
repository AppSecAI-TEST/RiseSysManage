$(document).ready(function(){
	initDate();
	$("#state").combobox({
		url : "../pubData/qryCodeNameList.do?tableName=STUDENT_COURSE_T&codeType=SINGLE_COURSE_TYPE",
		onChange:function(){
			var urls ="";
			var stateValue=$("#state").combobox("getValue");
			if(stateValue=="001")
			{
				urls ="../pubData/getClassType.do?";
				$("#classType").combobox({
				url:urls,
				valueField : "classType",
				textField : "classType",
				panelHeight : "auto"
				});
			}
			
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
    			$('#list_data').datagrid('clearSelections');
    		}
    	});
    });
	 
    $("#resetBtn").click(function() {
    	$('#qryFm').form('clear');//清空窗体数据  
    	initDate();
    });
    
    $("#changeFee").click(function() {
    	changeFee();
    });
    $("#viewFee").click(function(){
    	viewFeeInfo();
    });
    $("#qryChange").click(function(){
    	window.location.href ="qryChangeFee.jsp";
    });
    
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
