$(document).ready(function() {
	$("input:radio[name='isNeed']").change(function() {
		var isNeed = $("input:radio[name='isNeed']:checked").val();
		if("'Y'" == isNeed) {
			$("[name='courseStateNeed']").each(function() {
				$(this).removeAttr("disabled");
			});
			$("[name='courseStateAll']").each(function() {
				$(this).attr("disabled", "disabled");
				$(this).removeAttr("checked");
			});
		} else {
			$("[name='courseStateAll']").each(function() {
				$(this).removeAttr("disabled");
			});
			$("[name='courseStateNeed']").each(function() {
				$(this).attr("disabled", "disabled");
				$(this).removeAttr("checked");
			});
		}
	});
	initQryButton("qryBtn","reset","qryFm","list_data");
	$("#qryBtn").unbind();
	$("#qryBtn").click(function() {
    	if($("#schoolId").combobox("getValue")=="")
    	{
    		showMessage("提示","没有有效的校区可供查询",null);
    	}
    	else
    	{
    		var obj = JSON.stringify($("#qryFm").serializeObject());
	    	obj = obj.substring(0, obj.length - 1);
	    	var isNeed = $("input:radio[name='isNeed']:checked").val();
	    	if(isNeed != null && isNeed != null && isNeed != undefined) {
	    		var courseState = "";
	    		if("'Y'" == isNeed) {
	    			$("[name='courseStateNeed']:checked").each(function() {
	    				courseState += $(this).val()+",";
	    			});
	    		} else {
	    			$("[name='courseStateAll']:checked").each(function() {
	    				courseState += $(this).val()+",";
	    			});
	    		}
	    		courseState = courseState.substring(0, courseState.length - 1);
	    		obj += ",\"courseState\":\""+courseState+"\"";
	    	}
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
    	
    });
		
	var staffId = $("#staffId").val();
	var funcNodeId = $("#funcNodeId").val();
	$("#schoolId").combobox({
		url : "/sys/pub/pageCategory.do?staffId="+$("#staffId").val()+"&resourceId=713&fieldId=schoolId&headFlag=N",
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
    		if(n != "" && n != null && n != undefined) {
    			$("#stageId").combobox({disabled: false});
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
    		} else {
    			$("#stageId").combobox("loadData", new Array());
				$("#stageId").combobox({disabled: true});
    		}
    	}
	});
	
	//选班
	$("#selectClassBtn").click(function() {
		var row = $('#list_data').datagrid('getSelected');
		if(row) {
			var isNeedSelect = row.isNeedSelect;
			if("Y" == isNeedSelect) {
				var studentCourseId = row.studentCourseId;
				window.location.href = "/sys/selectClass/selectClass.jsp?studentCourseId="+studentCourseId;
			} else {
				$.messager.alert('提示', "您选择的学员暂时还不需要选班！");
			}
		} else {
			$.messager.alert('提示', "请先选择您要选班的学员！");
		}
	});
	
	//浏览
	$("#view").click(function() {
		var row = $('#list_data').datagrid('getSelected');
		if(row) {
			var studentId = row.studentId;
			var studentCourseId = row.studentCourseId;
			window.location.href = "/sys/selectClass/viewSelectClass.jsp?studentCourseId="+studentCourseId+"&studentId="+studentId;
		} else {
			$.messager.alert('提示', "请先选择您要浏览的班级！");
		}
	});
});