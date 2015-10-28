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
	
	$("#stageId").combobox({
		url : "/sys/pubData/qryStage.do",//返回json数据的url
    	valueField : "stageId",
    	textField : "stageId",
    	panelHeight : "auto",
    	onLoadSuccess : function () { //数据加载完毕事件
            var data = $('#stageId').combobox('getData');
            if (data.length > 0) {
                $("#stageId").combobox('select', data[0].stageId);
            }
        },
		onChange : function(n, o) {
			var schoolId = $("#schoolId").val();
			$("#classInstId").combobox({
        		url : "/sys/pubData/qryClassInstList.do?schoolId="+schoolId+"&courseType=001&stageId="+n+"&classType=&classState=003&classInstId=",//返回json数据的url
        		valueField : "classInstId",
        		textField : "className",
        		panelHeight : "auto",
        		onLoadSuccess : function () { //数据加载完毕事件
                    var data = $('#classInstId').combobox('getData');
                    if (data.length > 0) {
                        $("#classInstId").combobox('select', data[0].classInstId);
                    }
                }
        	});
		}
	});
	
	$("#applyChangeSubmit").click(function() {
		var row = $('#list_data').datagrid('getSelected');
		if(row) {
			var changeFlag = row.changeFlag;
			if("Y" == changeFlag) {
				var studentCourseId = row.studentCourseId;
				var studentId = row.studentId;
				var byName = row.byName;
				var changeClassNum = row.changeClassNum;
				var className = row.className;
				var classProgress = row.classProgress;
				var courseStateText = row.courseStateText;
				var name = row.name;
				var phone = row.phone;
				var teacherName = row.teacherName;
				var schoolId = row.schoolId;
				var classInstId = row.classInstId;
				var classType = row.classType;
				var schoolName = row.schoolName;
				var stageId = row.stageId;
				window.location.href = "/sys/changeClass/applyChangeClass.jsp?studentCourseId="+studentCourseId+"&studentId="+studentId+"&byName="+byName+"&changeClassNum="+changeClassNum+"&className="+className+"&classProgress="+classProgress+"&courseStateText="+courseStateText+"&name="+name+"&phone="+phone+"&teacherName="+teacherName+"&schoolId="+schoolId+"&schoolName="+schoolName+"&classInstId="+classInstId+"&classType="+classType+"&stageId="+stageId;
			} else {
				$.messager.alert('提示', "您选择的学员课程已申请转班，不能再次申请转班！");
			}
		} else {
			$.messager.alert('提示', "请先选择您要转班的学员课程！");
		}
	});
});