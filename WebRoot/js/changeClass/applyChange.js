$(document).ready(function() {
	var studentCourseId = $("#studentCourseId").val();
	$.ajax({
		url: "/sys/pubData/qryData.do",
		data: "param={\"queryCode\":\"qryApplyChangeClass\",\"studentCourseId\":\""+studentCourseId+"\"}",
		dataType: "json",
		async: true,
		beforeSend: function() {
			$.messager.progress({title : '转班申请', msg : '正在查询申请转班的课程信息，请稍等……'});
		},
		success: function (data) {
			$.messager.progress('close'); 
			$.each(data, function(i, obj) {
				$("#schoolNameText").html(obj.schoolName);
				$("#nameText").html(obj.name);
				$("#byNameText").html(obj.byName);
				$("#phoneText").html(obj.phone);
				$("#classNameText").html(obj.className);
				$("#classProgressText").html(obj.classProgress);
				$("#teacherNameText").html(obj.teacherName);
				$("#courseStateText").html(obj.courseStateText);
				$("#changeClassNumText").html(obj.changeClassNum);
				
				$("#stageId").val(obj.stageId);
				$("#schoolId").val(obj.schoolId);
				$("#classType").val(obj.classType);
				$("#studentId").val(obj.studentId);
				$("#outClassId").val(obj.classInstId);
				$("#courseState").val(obj.courseState);
				
				$("#planInClassId").combobox({
					url : "/sys/pubData/qryClassInstList.do?schoolId="+obj.schoolId+"&courseType=001&stageId="+obj.stageId+"&classType="+obj.classType+"&classState='001','002','003'&classInstId="+obj.classInstId,//返回json数据的url
					valueField : "classInstId",
					textField : "className",
					panelHeight : "auto",
					formatter : function(data) {
						return "<span>" + data.className + "</span>";
					}
				});
			});
		}
	});
	
    //上传
    $("#uploadBtn").click(function() {
    	var fileName = $("#fileName").filebox("getValue");
    	if(fileName != "" && fileName != null && fileName != undefined) {
    		var schoolId = $("#schoolId").val();
    		var handlerId = $("#handlerId").val();
    		$("#applyChangeClassFm").form("submit", {
    			url: "/sys/fileUpload?type=change_class&schoolId="+schoolId+"&handlerId="+handlerId,
    			onSubmit: function () {
    				
    			},
    			success: function (result) {
    				var data = JSON.parse(result);
    				if(data.flag) {
    					$("#imgUrl").val(data.fileId);
    					$.messager.alert('提示', "文件上传成功！", "info", function() {$("#cancelUploadBtn").linkbutton('disable');});
    				} else {
    					$.messager.alert('提示', data.msg);
    				}
    			}
    		});
    	} else {
    		$.messager.alert('提示', "请您先选择一个文件！");
    	}
    });
    
    //取消上传
    $("#cancelUploadBtn").click(function() {
    	$("#fileName").filebox("setValue", "");
    });
	
	$("#applyChangeSubmit").click(function() {
		if($("#applyChangeClassFm").form('validate')) {
			var flag = true;
			var fileName = $("#fileName").filebox("getValue");
			if(fileName != "" && fileName != null && fileName != undefined) {
				var imgUrl = $("#imgUrl").val();
				if(imgUrl == "" || imgUrl == null || imgUrl == undefined) {
					flag = false;
				}
			}
			if(flag) {
				var obj = JSON.stringify($("#applyChangeClassFm").serializeObject());
				obj = encodeURI(obj);
				$.ajax({
					url: "/sys/change/applyChangeClass.do",
					data: "param=" + obj,
					dataType: "json",
					async: true,
					beforeSend: function()
					{
						$.messager.progress({title : '申请转班', msg : '正在申请转班，请稍等……'});
					},
					success: function (data) {
						$.messager.progress('close'); 
						var flag = data.flag
						if(flag) {
							$.messager.alert('提示', "申请转班成功！", "info", function() {back();});
						} else {
							$.messager.alert('提示', data.msg);
						}
					} 
				});
			} else {
				$.messager.alert('提示', "请您先上传文件！");
			}
		}
	});
});

function back() {
	var changeSource = $("#changeSource").val();
	if("change" == changeSource) {
		var channel = $("#channel").val();
		if("attend" == channel) {
			var funcNodeId = $("#attendFuncNodeId").val();
			var classInstId = $("#attendClassInstId").val();
			window.location.href = "/sys/attendClass/qryAttendClass.do?classInstId="+classInstId+"&type=maintenance&funcNodeId="+funcNodeId;
		} else {
			window.location.href = "/sys/changeClass/changeClass.jsp?funcNodeId="+$("#funcNodeId").val();
		}
	} else if("leave" == changeSource) {
		window.location.href = "/sys/leaveManage/qryLeaveInfo.jsp";
	} else if("exception" == changeSource) {
		window.location.href = "/sys/exception/expList.jsp";
	}
}