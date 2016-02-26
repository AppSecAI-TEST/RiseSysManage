$(document).ready(function(){
	$("#courseType").combobox({
		url : "/sys/pubData/qryCodeNameList.do?tableName=STUDENT_COURSE_T&codeType=COURSE_TYPE",//返回json数据的url
    	valueField : "codeFlag",
    	textField : "codeName",
    	panelHeight : "auto",
    	formatter : function(data) {
    		return "<span>" + data.codeName + "</span>";
    	},
    	onChange : function(n, o) {
    		if("001" == n) {
    			$("#courseTypeDetail").combobox({
    				url : "/sys/pubData/qryStage.do",//返回json数据的url
    		    	valueField : "stageId",
    		    	textField : "stageId",
    		    	panelHeight : "auto",
    		    	formatter : function(data) {
    		    		return "<span>" + data.stageId + "</span>";
    		    	}
    			});
    		} else {
    			$("#courseTypeDetail").combobox({
    				url : "/sys/pubData/qryShortClass.do",//返回json数据的url
    		    	valueField : "shortClassId",
    		    	textField : "className",
    		    	panelHeight : "auto",
    		    	formatter : function(data) {
    		    		return "<span>" + data.className + "</span>";
    		    	}
    			});
    		}
    	}
	});
	$("#courseTypes").combobox({
		url : "/sys/pubData/qryCodeNameList.do?tableName=STUDENT_COURSE_T&codeType=COURSE_TYPE",//返回json数据的url
    	valueField : "codeFlag",
    	textField : "codeName",
    	panelHeight : "auto",
    	formatter : function(data) {
    		return "<span>" + data.codeName + "</span>";
    	},
    	onChange : function(n, o) {
    		if("001" == n) {
    			$("#courseTypeDetails").combobox({
    				url : "/sys/pubData/qryStage.do",//返回json数据的url
    		    	valueField : "stageId",
    		    	textField : "stageId",
    		    	panelHeight : "auto",
    		    	formatter : function(data) {
    		    		return "<span>" + data.stageId + "</span>";
    		    	}
    			});
    		} else {
    			$("#courseTypeDetails").combobox({
    				url : "/sys/pubData/qryShortClass.do",//返回json数据的url
    		    	valueField : "shortClassId",
    		    	textField : "className",
    		    	panelHeight : "auto",
    		    	formatter : function(data) {
    		    		return "<span>" + data.className + "</span>";
    		    	}
    			});
    		}
    	}
	});
	$("#schoolId").combobox( {
		url : "/sys/pub/pageCategory.do?staffId="+$("#handlerId").val()+"&resourceId=700&fieldId=schoolId&headFlag=N",
		onChange : function(sId) {
			var urls = "/sys/pubData/qryTeacherList.do?schoolId=" + sId;
			var urlss ="/sys/pubData/qryStaffList.do?post=16,17&schoolId=" + sId;

			$("#adviser").combobox( {
				url : urlss
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
		onChange : function(sId) {
			var urls = "/sys/pubData/qryTeacherList.do?schoolId=" + sId;
			var urlss ="/sys/pubData/qryStaffList.do?post=16,17&schoolId=" + sId;
			$("#advisers").combobox( {
				url : urlss
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
