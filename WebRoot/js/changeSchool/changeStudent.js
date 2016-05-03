$(document).ready(function() {
	$("#qryBtn").click(function() {
		initPageNumber("list_data");
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
	
	var staffId = $("#handlerId").val();
	$("#schoolId").combobox({
		url : "/sys/pub/pageCategory.do?staffId=" + staffId + "&resourceId=503&fieldId=schoolId",
		valueField : "schoolId",
    	textField : "schoolName",
    	panelHeight : "auto",
    	formatter : function(data) {
    		return "<span>" + data.schoolName + "</span>";
    	},
    	onLoadSuccess : function(data) {
    		if(data.length > 0) {
				$("#schoolId").combobox("setValue", data[0].schoolId);
			}
    	},
    	onChange : function(n, o) {
    		if(n != null && n != "" && n != undefined) {
    			$("#teacherId").combobox({disabled: false});
    			$("#teacherId").combobox({
    				url : "/sys/pubData/qryTeacherList.do?schoolId="+n+"&stageId=",
    				valueField : "teacherId",
    		    	textField : "byname",
    		    	panelHeight : "auto",
    		    	formatter : function(data) {
    		    		return "<span>" + data.byname + "</span>";
    		    	}
    			});
    		} else {
    			var data = $("#schoolId").combobox("getData");
    			if(data.length > 0) {
					$("#schoolId").combobox("setValue", data[0].schoolId);
				}
    			$("#teacherId").combobox('clear');
				$("#teacherId").combobox("loadData", new Array());
				$("#teacherId").combobox({disabled: true});
    		}
    	}
	});
	
	$("#applyChangeSubmit").click(function() {
		var row = $('#list_data').datagrid('getSelected');
		if(row) {
			var changeClassFlagText = row.changeClassFlagText;
			if("N" == changeClassFlagText) {
				var changeSchoolFlagText = row.changeSchoolFlagText;
				if("N" == changeSchoolFlagText) {
					var studentId = row.studentId;
					window.location.href = "/sys/changeSchool/applyChangeSchool.jsp?studentId="+studentId+"&changeSource=change&funcNodeId="+$("#menuFuncNodeId").val();
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