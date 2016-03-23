$(document).ready(function() {
	$("#qryBtn").click(function() {
		var s = "";
		$('input[name="courseState"]:checked').each(function() {
		    s += $(this).val() + ",";
		});
		s = s.substring(0, s.length - 1);
		var funcNodeId = $("#qryBtn").attr("funcNodeId");
		var object = $("#qryFm").serializeObject();
		object.courseState = s;
		object.funcNodeId = funcNodeId;
    	var obj = JSON.stringify(object);
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
    });
	
	$("#reset").click(function() {
		$("#qryFm").form('clear');//清空窗体数据  
		var data = $("#schoolId").combobox("getData");
		if(data.length > 0) {
			$("#schoolId").combobox("setValue", data[0].schoolId);
		}
	});
	
	var staffId = $("#staffId").val();
	$("#schoolId").combobox({
		url : "/sys/pub/pageCategory.do?staffId=" + staffId + "&resourceId=252&fieldId=schoolId",
    	valueField : "schoolId",
    	textField : "schoolName",
    	panelHeight : "auto",
    	formatter : function(data) {
    		return "<span>" + data.schoolName + "</span>";
    	},
    	onLoadSuccess : function() {
    		var data = $("#schoolId").combobox("getData");
    		if(data.length > 0) {
    			$("#schoolId").combobox("setValue", data[0].schoolId);
    		}
    		$("#qryBtn").click();
    	},
    	onChange : function(n, o) {
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
    			url : "/sys/pubData/qryStaffList.do?post=4,5&schoolId=" + n,
    			valueField : "staffId",
    	    	textField : "userName",
    	    	panelHeight : "auto",
    	    	formatter : function(data) {
    	    		return "<span>" + data.userName + "</span>";
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
    			$("#stageId").combobox({
    				url : "/sys/pubData/qryStage.do",//返回json数据的url
    		    	valueField : "stageId",
    		    	textField : "stageId",
    		    	panelHeight : "auto",
    		    	formatter : function(data) {
    		    		return "<span>" + data.stageId + "</span>";
    		    	}
    			});
    		} else {
    			$("#stageId").combobox({
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
	
	$("#refundSubmit").click(function() {
		var obj = $('#list_data').datagrid('getSelections');
		if(obj != null && obj != undefined && obj.length > 0) {
			var studentId = "";
			var courseType = "";
			var studentCourseId = "";
			var studentFlag = false;
			var courseTypeFlag = false;
			for(var i = 0, n = obj.length; i < n; i++) {
				if(i == 0) {
					studentId = obj[i].studentId;
					courseType = obj[i].courseType;
				} else {
					if(studentId != obj[i].studentId) {
						studentFlag = true;
						break;
					}
					if(courseType != obj[i].courseType) {
						courseTypeFlag = true;
						break;
					}
				}
				studentCourseId += obj[i].studentCourseId + ",";
			}
			if(!studentFlag) {
				if(!courseTypeFlag) {
					studentCourseId = studentCourseId.substring(0, studentCourseId.length - 1);
					window.location.href = "/sys/refund/qryApplyRefund.do?studentCourseId="+studentCourseId+"&studentId="+studentId+"&courseType="+courseType;
				} else {
					$.messager.alert('提示', "只能多选同一个人的同类型的课程进行退费！");
				}
			} else {
				$.messager.alert('提示', "只能多选同一个人的课程进行退费！");
			}
		} else {
			$.messager.alert('提示', "请选择您要退费的课程！");
		}
	});
});