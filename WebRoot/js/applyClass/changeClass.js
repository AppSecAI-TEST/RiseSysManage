$(document).ready(function() {
	var studentCourseId = $("#studentCourseId").val();
	var param = "{\"studentCourseId\":\""+studentCourseId+"\",\"queryCode\":\"qryChangeClassStudent\"}";
	$.ajax({
		url: "/sys/applyClass/qryDataByQueryCode.do",
		data: "param=" + param,
		dataType: "json",
		async: true,
		beforeSend: function()
		{
			$.messager.progress({title : '班级维护', msg : '正在查询班级信息，请稍等……'});
		},
		success: function (data) {
			$.messager.progress('close'); 
			$("#name").html(data.name);
			$("#birthday").html(data.birthday);
			$("#feeTypeText").html(data.feeTypeText);
			$("#sexText").html(data.sexText);
			$("#identityId").html(data.identityId);
			$("#phone").html(data.phone);
			$("#payDate").html(data.payDate);
			$("#dutyAdvisterName").html(data.dutyAdvisterName);
			$("#adviserTeacherName").html(data.adviserTeacherName);
			$("#adviserName").html(data.adviserName);
			$("#selectClassName").html(data.className);
			$("#selectClassDate").html(data.selectClassDate);
			$("#selectClassNum").html(data.selectClassNum);
			$("#oldClassName").val(data.oldClassName);
			$("#schoolId").val(data.schoolId);
			
			var classIsBegin = "N";
			var classState = $("#classState").val();
			if("003" == classState) {
				classIsBegin = "Y";
			}
			var classInstId = $("#classInstId").val();
			if(classInstId != null && classInstId != "" && classInstId != undefined) {
				$("input[name='isBegin'][value='"+classIsBegin+"']").attr("checked", "checked"); 
				initClassInst(classIsBegin, classInstId);
			}
		}
	});
	
	$("input:radio[name='isBegin']").change(function() {
		var isBegin = $("input:radio[name='isBegin']:checked").val();
		initClassInst(isBegin, "");
	});

    //提交更换班级
    $("#submit").click(function() {
    	var handlerId = $("#handlerId").val();
    	var studentId = $("#studentId").val();
		var classInstId = "";
    	var className = "";
    	var isBegin = $("input:radio[name='isBegin']:checked").val();
    	if("Y" == isBegin) {
    		classInstId = $('#beginClassInstId').combobox('getValue');
    		className = $('#beginClassInstId').combobox('getText');
    	} else {
    		classInstId = $('#notBeginClassInstId').combobox('getValue');
    		className = $('#notBeginClassInstId').combobox('getText');
    	}
		var studentCourseId = $("#studentCourseId").val();
		var studentChannelType = $("#oldClassName").val() + $("#feeTypeText").html();
		var oldClassInstId = $("#classInstId").val();
		var schoolId = $("#schoolId").val();
    	var param = "[{classInstId:\""+classInstId+"\",className:\""+className+"\",studentId:\""+studentId+"\",studentCourseId:\""+studentCourseId+"\",studentChannelType:\""+studentChannelType+"\",handlerId:\""+handlerId+"\",oldClassInstId:\""+oldClassInstId+"\",schoolId:\""+schoolId+"\"}]";
    	param = encodeURI(param);
    	$.ajax({
			url: "/sys/applyClass/addClassStudent.do",
			data: "param=" + param,
			dataType: "json",
			async: true,
			beforeSend: function() {
				$.messager.progress({title : '更换班级', msg : '正在更换班级，请稍等……'});
			},
			success: function (data) {
				$.messager.progress('close'); 
				var flag = data.flag
				if(flag) {
					$.messager.alert('提示', "添加学员成功！", "info", function() {window.location.href = "/sys/applyClass/applyClass.jsp";});
				} else {
					$.messager.alert('提示', data.msg);
				}
			}
		});
    });
});

function initClassInst(isBegin, classInstId) {
	var schoolId = $("#schoolId").val();
	var courseType = $("#courseType").val();
	var stageId = $("#stageId").val();
	var classType = $("#classType").val();
	var schoolId = $("#schoolId").val();
	if("Y" == isBegin) {
		$("#beginClassInstId").combobox({
    		url : "/sys/pubData/qryClassInstList.do?schoolId="+schoolId+"&courseType="+courseType+"&stageId="+stageId+"&classType="+classType+"&classState='003'&classInstId=",//返回json数据的url
    		valueField : "classInstId",
    		textField : "className",
    		panelHeight : "auto",
    		formatter : function(data) {
    			return "<span>" + data.className + "</span>";
    		},
    		onLoadSuccess : function () { //数据加载完毕事件
                var data = $('#beginClassInstId').combobox('getData');
                if (data.length > 0) {
                	var flag = true;
                	if(classInstId != null && classInstId != "" && classInstId != undefined) {
                		for(var i = 0, len = data.length; i < len; i++) {
                			if(data[i].classInstId == classInstId) {
                				flag = false;
                				break;
                			}
                		}
                	}
                	if(flag) {
                		$("#beginClassInstId").combobox('select', data[0].classInstId);
                	} else {
                		$("#beginClassInstId").combobox('select', classInstId);
                	}
                	var classInstId = $("#beginClassInstId").combobox("getValue");
                    if(classInstId != "" && classInstId != null && classInstId != undefined) {
                    	qryClassDetail(classInstId);
                    } else {
                		$("#changeDiv").css("display", "none");
                	}
                } else {
                	$("#changeDiv").css("display", "none");
                }
            },
            onChange : function(n, o) {
            	if(n != "" && n != null && n != undefined) {
	        		qryClassDetail(n);
	        	} else {
            		$("#changeDiv").css("display", "none");
            	}
            }
    	});
		$("#notBeginClassInstId").combobox('clear');
		$("#notBeginClassInstId").combobox("loadData", new Array());
	} else {
		$("#notBeginClassInstId").combobox({
    		url : "/sys/pubData/qryClassInstList.do?schoolId="+schoolId+"&courseType="+courseType+"&stageId="+stageId+"&classType="+classType+"&classState='001','002'&classInstId=",//返回json数据的url
    		valueField : "classInstId",
    		textField : "className",
    		panelHeight : "auto",
    		formatter : function(data) {
    			return "<span>" + data.className + "</span>";
    		},
    		onLoadSuccess : function () { //数据加载完毕事件
                var data = $('#notBeginClassInstId').combobox('getData');
                if (data.length > 0) {
                	var flag = true;
                	if(classInstId != null && classInstId != "" && classInstId != undefined) {
                		for(var i = 0, len = data.length; i < len; i++) {
                			if(data[i].classInstId == classInstId) {
                				flag = false;
                				break;
                			}
                		}
                	}
                	if(flag) {
                		$("#notBeginClassInstId").combobox('select', data[0].classInstId);
                	} else {
                		$("#notBeginClassInstId").combobox('select', classInstId);
                	}
                	var classInstId = $("#notBeginClassInstId").combobox("getValue");
                	if(classInstId != "" && classInstId != null && classInstId != undefined) {
                		qryClassDetail(classInstId);
                	} else {
                		$("#changeDiv").css("display", "none");
                	}
                } else {
                	$("#changeDiv").css("display", "none");
                }
            },
            onChange : function(n, o) {
	        	if(n != "" && n != null && n != undefined) {
	        		qryClassDetail(n);
	        	} else {
            		$("#changeDiv").css("display", "none");
            	}
            }
    	});
		$("#beginClassInstId").combobox('clear');
		$("#beginClassInstId").combobox("loadData", new Array());
	}
}

function qryClassDetail(classInstId) {
	var param = "{\"classInstId\":\""+classInstId+"\",\"queryCode\":\"qryClassInstListById\"}";
	$.ajax({
		url: "/sys/applyClass/qryDataByQueryCode.do",
		data: "param=" + param,
		dataType: "json",
		async: true,
		beforeSend: function()
		{
			$.messager.progress({title : '班级维护', msg : '正在查询班级信息，请稍等……'});
		},
		success: function (data) {
			$.messager.progress('close'); 
			$("#className").html(data.className);
			$("#applyDate").html(data.applyClassDate);
			$("#startDate").html(data.startDate);
			$("#teacherName").html(data.teacherName);
			$("#classStudentNum").html(data.classStudentNum);
			$("#classProgress").html(data.classProgress);
			$("#schooltimeName").html(data.schooltimeName);
			$("#changeDiv").css("display", "block");
		}
	});
}