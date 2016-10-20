$(document).ready(function() {
	ajaxLoading("正在处理，请稍待。。。");
	initQryButton("qryBtn", "reset", "qryFm", "list_data");
	var staffId = $("#staffId").val();
	$("#schoolId").combobox({
    	valueField : "schoolId",
    	textField : "schoolName",
    	panelHeight : "auto",
    	loader: function(param,success,error) {
    		$.ajax({  
    			url : "/sys/pub/pageCategory.do?staffId=" + staffId + "&resourceId=712&fieldId=schoolId&headFlag=N",
				dataType: 'json',  
				success: function(data) {
			    	if(data.length == schoolData.length) {
			    		data.unshift({schoolName:"全部校区", schoolId:""});  
			    	}
					success(data);  
				}
			});  
    	},
    	formatter : function(data) {
    		return "<span>" + data.schoolName + "</span>";
    	},
    	onLoadSuccess : function(data) {
    		ajaxLoadEnd();
    		if(data.length > 0) {
    			$("#schoolId").combobox("setValue", data[0].schoolId);
    		}	
    	},
    	onChange : function(n, o) {
    		$("#dutyAdviser").combobox({
    			url : "/sys/pubData/qryStaffList.do?post=16,17&schoolId=" + n,
    			valueField : "staffId",
    	    	textField : "userName",
    	    	panelHeight : "auto",
    	    	formatter : function(data) {
    	    		return "<span>" + data.userName + "</span>";
    	    	}
    		});
    		$("#adviserId").combobox({
    			url : "/sys/pubData/qryStaffList.do?post=16,17&schoolId=" + n,
    			valueField : "staffId",
    	    	textField : "userName",
    	    	panelHeight : "auto",
    	    	formatter : function(data) {
    	    		return "<span>" + data.userName + "</span>";
    	    	}
    		});
    		$("#adviserTeacherId").combobox({
    			url : "/sys/pubData/qryTeacherList.do?schoolId=" + n + "&stageId=",
    			valueField : "teacherId",
    	    	textField : "byname",
    	    	panelHeight : "auto",
    	    	formatter : function(data) {
    	    		return "<span>" + data.byname + "</span>";
    	    	}
    		});
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
	$("#deleteCourse").click(function() {
		delCourse();
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
