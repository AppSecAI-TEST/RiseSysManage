$(document).ready(function() {
	initQryButton("qryBtn", "reset", "qryFm", "list_data");
	
	var staffId = $("#staffId").val();
	var funcNodeId = $("#funcNodeId").val();
	$("#schoolId").combobox({
		url : "/sys/pubData/qrySchoolList.do?schoolId=",//返回json数据的url
    	valueField : "schoolId",
    	textField : "schoolName",
    	panelHeight : "auto",
    	formatter : function(data) {
    		return "<span>" + data.schoolName + "</span>";
    	},
    	onLoadSuccess : function() {
    		$("#schoolId").combobox("setValue", "");
    		$("#schoolId").combobox("setText", "全部校区");
    	},
    	onChange : function(n, o) {
    		if(n != "" && n != null && n != undefined) {
    			$("#studentId").combobox({
					url : "/sys/pub/paramComboxList.do?staffId="+staffId+"&schoolId="+n+"&funcNodeId="+funcNodeId+"&fieldId=studentId",
					valueField : "studentId",
					textField : "name",
					panelHeight : "auto",
					formatter : function(data) {
			    		return "<span>" + data.name + "</span>";
			    	}
				});
    		} else {
				$("#schoolId").combobox("setText", "全部校区");
			}
    	}
	});
	
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
	
	$("#womType").combobox({
		url : "/sys/pubData/qryCodeNameList.do?tableName=STUDENT_WOM_T&codeType=WOM_TYPE",//返回json数据的url
    	valueField : "codeFlag",
    	textField : "codeName",
    	panelHeight : "auto",
    	formatter : function(data) {
    		return "<span>" + data.codeName + "</span>";
    	},
		onChange : function(n, o) {
			$("#womTypeDetail").combobox({
				url : "/sys/pubData/qryCodeNameList.do?tableName=STUDENT_WOM_T&codeType=WOM_CHANNEL_" + n,//返回json数据的url
		    	valueField : "codeFlag",
		    	textField : "codeName",
		    	panelHeight : "auto",
		    	formatter : function(data) {
		    		return "<span>" + data.codeName + "</span>";
		    	}
			});	
		}
	});	
	
	$("#addCourse").click(function() {
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
	var funcNodeId = $("#funcNodeId").val();
	window.location.href = "addCourseList.jsp?funcNodeId="+funcNodeId;
}

function getOldCourse(id) 
{
	var courses;
	var stu = {};
	stu.studentId = id;
	stu.queryCode = 'Qry_Student_Courses';
	var str = JSON.stringify(stu);
	$.ajax( {
		url : "/sys/course/getStuCourses.do?",
		data : "param=" + str,
		dataType : "json",
		async : false,
		success : function(data)
		{
		 courses= data.data;//学员已有课程
		}
	});
	return courses;
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
