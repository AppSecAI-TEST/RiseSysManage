$(document).ready(function() {
	$("#qryBtn").click(function() {
		initPageNumber("list_data");
		var object = $("#qryFm").serializeObject()
		var schoolId = $("#schoolId").val();
		object.schoolId = schoolId;
		var funcNodeId = $("#qryBtn").attr("funcNodeId");
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
		$("#reset").form('clear');//清空窗体数据  
	});
	
	$("#stageId").combobox({
		url : "/sys/pubData/qryStage.do",//返回json数据的url
    	valueField : "stageId",
    	textField : "stageId",
    	panelHeight : "auto",
    	formatter : function(data) {
    		return "<span>" + data.stageId + "</span>";
    	},
		onChange : function(n, o) {
			var schoolId = $("#schoolId").val();
			$("#classInstId").combobox({
        		url : "/sys/pubData/qryClassInstList.do?schoolId="+schoolId+"&courseType=001&stageId="+n+"&classType=&classState=003&classInstId=",//返回json数据的url
        		valueField : "classInstId",
        		textField : "className",
        		panelHeight : "auto",
        		formatter : function(data) {
        			return "<span>" + data.className + "</span>";
        		}
        	});
		}
	});
	
	$("#applyChangeSubmit").click(function() {
		var row = $('#list_data').datagrid('getSelected');
		if(row) {
			var changeSchoolFlag = row.changeSchoolFlag;
			if("N" == changeSchoolFlag) {
				var changeClassFlag = row.changeClassFlag;
				if("N" == changeClassFlag) {
					var studentCourseId = row.studentCourseId;
					window.location.href = "/sys/changeClass/applyChangeClass.jsp?studentCourseId="+studentCourseId+"&changeSource=change&funcNodeId="+$("#menuFuncNodeId").val();
				} else {
					$.messager.alert('提示', "您选择的学员课程已申请转班，不能再次申请转班！");
				}
			} else {
				$.messager.alert('提示', "您选择的学员课程已申请转校，不能申请转班！");
			}
		} else {
			$.messager.alert('提示', "请先选择您要转班的学员课程！");
		}
	});
});