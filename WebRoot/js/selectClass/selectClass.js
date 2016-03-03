$(document).ready(function() {
	var studentCourseId = $("#studentCourseId").val();
	var param = "{\"studentCourseId\":\""+studentCourseId+"\",\"queryCode\":\"qrySelectClassListById\"}";
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
			$("#nameText").html(data.name);
			$("#birthdayText").html(data.birthday);
			$("#feeTypeText").html(data.feeTypeText);
			$("#sexText").html(data.sexText);
			$("#identityIdText").html(data.identityId);
			$("#phoneText").html(data.phone);
			$("#byNameText").html(data.byName);
			$("#payDateText").html(data.payDate);
			$("#dutyAdvisterNameText").html(data.dutyAdvisterName);
			$("#classTypeText").html(data.classType);
			$("#currentClassNameText").html(data.currentClassName);
			$("#selectClassDateText").html(data.selectClassDate);
			$("#selectClassNumText").html(data.selectClassNum);
			$("#courseStateText").html(data.courseStateText);
			if("001" == data.feeType) {
				$("#adviserTeacher").html("业绩顾问：");
				$("#adviserTeacherNameText").html(data.adviserName);
			} else {
				$("#adviserTeacher").html("业绩老师：");
				$("#adviserTeacherNameText").html(data.adviserTeacherName);
			}
			
			var schoolId = data.schoolId;
			var inSchoolId = data.inSchoolId;
			if(inSchoolId != "" && inSchoolId != null && inSchoolId != undefined) {
				schoolId = inSchoolId;
			}
			$("#schoolId").val(schoolId);
			$("#courseType").val(data.courseType);
			$("#stageId").val(data.stageId);
			$("#classType").val(data.classType);
			$("#oldClassInstId").val(data.currentClassInstId);
			$("#studentId").val(data.studentId);
			$("#oldClassName").val(data.oldClassName);
			$("#feeType").val(data.feeType);
			$("#outSchoolName").val(data.outSchoolName);
			$("#oldCourseState").val(data.oldCourseState);
			
			var oldClassInstId = data.currentClassInstId;
			if(oldClassInstId != null && oldClassInstId != "" && oldClassInstId != undefined) {
				var classIsBegin = data.classIsBegin;
				$("input[name='isBegin'][value='"+classIsBegin+"']").attr("checked", "checked"); 
				initClassInst(classIsBegin);
			}
		}
	});
	
	$("input:radio[name='isBegin']").change(function() {
		var isBegin = $("input:radio[name='isBegin']:checked").val();
		initClassInst(isBegin);
	});
	
	//提交更换班级
    $("#submit").click(function() {
    	var isBegin = $("input:radio[name='isBegin']:checked").val();
    	if(isBegin != null && isBegin != "" && isBegin != undefined) {
    		var classInstId = "";
    		var className = "";
    		if("Y" == isBegin) {
    			classInstId = $('#beginClassInstId').combobox('getValue');
    			className = $('#beginClassInstId').combobox('getText');
    		} else {
    			classInstId = $('#notBeginClassInstId').combobox('getValue');
    			className = $('#notBeginClassInstId').combobox('getText');
    		}
    		if(classInstId != "" && classInstId != null && classInstId != undefined) {
    			var oldCourseState = $("#oldCourseState").val();
        		if("009" != oldCourseState && "Y" == isBegin) {
        			$.messager.alert('提示', "您选择的学员有在读课程，不能选择已开课班级！");
        		} else {
        			var handlerId = $("#handlerId").val();
        			var studentId = $("#studentId").val();
        			var feeType = $("#feeType").val();
        			var studentChannelType = "";
        			if("001" == feeType) {
        				var outSchoolName = $("#outSchoolName").val();
        				if(outSchoolName != "" && outSchoolName != null && outSchoolName != undefined) {
        					studentChannelType = outSchoolName + "校区转入";
        				} else {
        					studentChannelType = $("#feeTypeText").html();
        				}
        			} else {
        				studentChannelType = $("#oldClassName").val() + $("#feeTypeText").html();
        			}
        			var studentCourseId = $("#studentCourseId").val();
        			var oldClassInstId = $("#oldClassInstId").val();
        			var schoolId = $("#schoolId").val();
        			var param = "[{classInstId:\""+classInstId+"\",className:\""+className+"\",studentId:\""+studentId+"\",studentCourseId:\""+studentCourseId+"\",studentChannelType:\""+studentChannelType+"\",handlerId:\""+handlerId+"\",oldClassInstId:\""+oldClassInstId+"\",schoolId:\""+schoolId+"\"}]";
        			param = encodeURI(param);
        			$.ajax({
        				url: "/sys/applyClass/addClassStudent.do",
        				data: "param=" + param,
        				dataType: "json",
        				async: true,
        				beforeSend: function()
        				{
        					$.messager.progress({title : '选班', msg : '正在选班，请稍等……'});
        				},
        				success: function (data) {
        					$.messager.progress('close'); 
        					var flag = data.flag
        					if(flag) {
        						$.messager.alert('提示', "选班成功！", "info", function() {window.history.back();});
        					} else {
        						$.messager.alert('提示', data.msg);
        					}
        				}
        			});
        		}
    		} else {
    			$.messager.alert('提示', "请选择一个班级！");
    		}
    	} else {
    		$.messager.alert('提示', "请先选择您要选择的班级是否开课！");
    	}
    });
});

function initClassInst(isBegin) {
	var schoolId = $("#schoolId").val();
	var courseType = $("#courseType").val();
	var stageId = $("#stageId").val();
	var oldClassInstId = $("#oldClassInstId").val();
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
                	if(oldClassInstId != null && oldClassInstId != "" && oldClassInstId != undefined) {
                		for(var i = 0, len = data.length; i < len; i++) {
                			if(data[i].classInstId == oldClassInstId) {
                				flag = false;
                				break;
                			}
                		}
                	}
                	if(flag) {
                		$("#beginClassInstId").combobox('select', data[0].classInstId);
                	} else {
                		$("#beginClassInstId").combobox('select', oldClassInstId);
                	}
                }
                var classInstId = $("#notBeginClassInstId").combobox("getValue");
                if(classInstId != "" && classInstId != null && classInstId != undefined) {
                	qryClassDetail(classInstId);
                }
            },
            onChange : function(n, o) {
            	if(n != "" && n != null && n != undefined) {
            		qryClassDetail(n);
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
                	if(oldClassInstId != null && oldClassInstId != "" && oldClassInstId != undefined) {
                		for(var i = 0, len = data.length; i < len; i++) {
                			if(data[i].classInstId == oldClassInstId) {
                				flag = false;
                				break;
                			}
                		}
                	}
                	if(flag) {
                		$("#notBeginClassInstId").combobox('select', data[0].classInstId);
                	} else {
                		$("#notBeginClassInstId").combobox('select', oldClassInstId);
                	}
                }
                
                var classInstId = $("#notBeginClassInstId").combobox("getValue");
                if(classInstId != "" && classInstId != null && classInstId != undefined) {
                	qryClassDetail(classInstId);
                }
            },
            onChange : function(n, o) {
            	if(n != "" && n != null && n != undefined) {
            		qryClassDetail(n);
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
			$("#classNameText").html(data.className);
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