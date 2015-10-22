$(document).ready(function() {
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
    			//一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题。
    			$('#list_data').datagrid('clearSelections');
    		}
    	});
    });
	
	$("#applyChangeSubmit").click(function() {
		var row = $('#list_data').datagrid('getSelected');
		if(row) {
			var changeClassFlagText = row.changeClassFlagText;
			if("N" == changeClassFlagText) {
				var changeSchoolFlagText = row.changeSchoolFlagText;
				if("N" == changeSchoolFlagText) {
					var name = row.name;
					var phone = row.phone;
					var byName = row.byName;
					var schoolId = row.schoolId;
					var studentId = row.studentId;
					var schoolName = row.schoolName;
					var classInstId = row.classInstId;
					var studentCourseId = row.studentCourseId;
					var currentClassName = row.currentClassName;
					var adviserTeacherName = row.adviserTeacherName;
					window.location.href = "/sys/changeSchool/applyChangeSchool.jsp?studentCourseId="+studentCourseId+"&studentId="+studentId+"&schoolId="+schoolId+"&schoolName="+schoolName+"&name="+name+"&byName="+byName+"&phone="+phone+"&currentClassName="+currentClassName+"&adviserTeacherName="+adviserTeacherName+"&classInstId="+classInstId;
				} else {
					$.messager.alert('提示', "您选择的学员课程已经申请转校，不能再次申请转校！");
				}
			} else {
				$.messager.alert('提示', "您选择的学员课程有未结束的转班状态，不能申请转校！");
			}
		} else {
			$.messager.alert('提示', "请先选择您要转班的学员课程！");
		}
	});
});