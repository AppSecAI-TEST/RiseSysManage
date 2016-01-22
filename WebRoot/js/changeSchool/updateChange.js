$(document).ready(function() {
	var applyId = $("#applyId").val();
	var param = "{\"applyId\":\""+applyId+"\",\"queryCode\":\"qryChangeSchoolDetail\"}";
	$.ajax({
		url: "/sys/applyClass/qryDataByQueryCode.do",
		data: "param=" + param,
		dataType: "json",
		async: true,
		beforeSend: function()
		{
			$.messager.progress({title : '浏览', msg : '正在查询更改选班信息，请稍等……'});
		},
		success: function (data) {
			$.messager.progress('close'); 
			var isSelect = "N";
			var inClassId = data.inClassId;
			var inClassIsBegin = data.inClassIsBegin;
			if(inClassId != "" && inClassId != null && inClassId != undefined) {
				isSelect = "Y";
				if(inClassIsBegin != null && inClassIsBegin != "" && inClassIsBegin != undefined) {
					$("input[name='isBegin'][value='"+inClassIsBegin+"']").attr("checked", "checked");
					initClassInst(inClassIsBegin);
				}
			}
			$("input[name='isSelect'][value='"+isSelect+"']").attr("checked", "checked");
			initIsSelect(isSelect);
			$("inClassIsBegin").val(inClassIsBegin);
			
			$("#applyDateText").html(data.applyDate);
			$("#applyNameText").html(data.applyName);
			$("#applyRemark").html(data.applyRemark);
			$("#outDateText").html(data.outDate);
			$("#outNameText").html(data.outName);
			$("#outSchoolNameText").html(data.outSchoolName);
			$("#inDateText").html(data.inDate);
			$("#inNameText").html(data.inName);
			$("#inClassNameText").html(data.inClassName);
			
			$("#stageId").val(data.stageId);
			$("#classType").val(data.classType);
			$("#inClassId").val(inClassId);
			$("#schoolId").val(data.inSchoolId);
			$("#courseType").val(data.courseType);
			$("#outClassId").val(data.outClassId);
			$("#outSchoolId").val(data.outSchoolId);
		}
	});
	
	$("input:radio[name='isSelect']").change(function() {
		var isSelectClass = $("input:radio[name='isSelect']:checked").val();
		initIsSelect(isSelectClass);
	});
	
	$("input:radio[name='isBegin']").change(function() {
		var isBegin = $("input:radio[name='isBegin']:checked").val();
		initClassInst(isBegin);
	});
	
	//查看转校历史信息
	$("#viewChangeSchoolList").click(function() {
		var studentId = $("#studentId").val();
		var studentCourseId = $("#studentCourseId").val();
		window.location.href = "/sys/changeSchool/changeSchoolHistList.jsp?studentId="+studentId+"&studentCourseId="+studentCourseId;
	});
	
	$("#updateChangeSubmit").click(function(){
		var flag = true;
		var className = "";
		var classInstId = "";
		var isSelect = $("input:radio[name='isSelect']:checked").val();
		if("Y" == isSelect) {
			var isBegin = $("input:radio[name='isBegin']:checked").val();
	    	if("Y" == isBegin) {
	    		classInstId = $('#beginClassInstId').combobox('getValue');
	    		className = $('#beginClassInstId').combobox('getText');
	    	} else {
	    		classInstId = $('#notBeginClassInstId').combobox('getValue');
	    		className = $('#notBeginClassInstId').combobox('getText');
	    	}
	    	if(classInstId == "" || classInstId == null || classInstId == undefined) {
	    		flag = false;
	    		$.messager.alert('提示', "请选择一个班级！");
	    	} else {
	    		var inClassId = $("#inClassId").val();
	    		if(classInstId == inClassId) {
	    			flag = false;
	    			var className = $("#classNameText").html();
	    			$.messager.alert('提示', "您选择的班级"+className+"是现在该学员的转入班级，请您更换一个班级！");
	    		} else {
	    			var classStudentNum = $("#classStudentNum").html();
	    			var studentNum = parseInt(classStudentNum.split("/")[0]) + 1;
	    			var maxNum = parseInt(classStudentNum.split("/")[1]);
	    			if(studentNum > maxNum) {
	    				flag = false;
	    				var className = $("#classNameText").html();
	    				$.messager.alert('提示', "您选择的"+className+"学员已经满员，不能再向该班级转入学员！");
	    			}
	    		}
	    	}
		}
		if(flag) {
			var object = $("#updateChangeSchoolFm").serializeObject();
			object.isSelect = isSelect;
			if("Y" == isSelect) {
				object.className = className;
				object.classInstId = classInstId;
			}
			var obj = JSON.stringify(object);
			obj = encodeURI(obj);
			$.ajax({
				url: "/sys/change/updateChangeClass.do",
				data: "param=" + obj,
				dataType: "json",
				async: true,
				beforeSend: function()
				{
					$.messager.progress({title : '更改选班', msg : '正在更改选班，请稍等……'});
				},
				success: function (data) {
					$.messager.progress('close'); 
					var flag = data.flag;
					if(flag) {
						$.messager.alert('提示', "更改选班成功！", "info", function() {window.history.back();});
					} else {
						$.messager.alert('提示', data.msg);
					}
				} 
			});
		}
	});
});

function initClassInst(isBegin) {
	var stageId = $("#stageId").val();
	var inSchoolId = $("#schoolId").val();
	var classType = $("#classType").val();
	var inClassId = $("#inClassId").val();
	var courseType = $("#courseType").val();
	var inClassIsBegin = $("#inClassIsBegin").val();
	if("Y" == isBegin) {
		$("#beginClassInstId").combobox({
    		url : "/sys/pubData/qryClassInstList.do?schoolId="+inSchoolId+"&courseType="+courseType+"&stageId="+stageId+"&classType="+classType+"&classState='003'&classInstId=",//返回json数据的url
    		valueField : "classInstId",
    		textField : "className",
    		panelHeight : "auto",
    		formatter : function(data) {
    			return "<span>" + data.className + "</span>";
    		},
    		onLoadSuccess : function () { //数据加载完毕事件
                var data = $('#beginClassInstId').combobox('getData');
                if (data.length > 0) {
                	if(isBegin == inClassIsBegin) {
                		$("#beginClassInstId").combobox('select', inClassId);
                	} else {
                		$("#beginClassInstId").combobox('select', data[0].classInstId);
                	}
                }
                var classInstId = $("#beginClassInstId").combobox("getValue");
                if(classInstId != "" && classInstId != null && classInstId != undefined) {
                	qryClassDetail(classInstId);
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
    		url : "/sys/pubData/qryClassInstList.do?schoolId="+inSchoolId+"&courseType="+courseType+"&stageId="+stageId+"&classType="+classType+"&classState='001','002'&classInstId=",//返回json数据的url
    		valueField : "classInstId",
    		textField : "className",
    		panelHeight : "auto",
    		formatter : function(data) {
    			return "<span>" + data.className + "</span>";
    		},
    		onLoadSuccess : function () { //数据加载完毕事件
                var data = $('#notBeginClassInstId').combobox('getData');
                if (data.length > 0) {
                	if(isBegin == inClassIsBegin) {
                		$("#notBeginClassInstId").combobox('select', inClassId);
                	} else {
                		$("#notBeginClassInstId").combobox('select', data[0].classInstId);
                	}
                }
                var classInstId = $("#notBeginClassInstId").combobox("getValue");
                if(classInstId != "" && classInstId != null && classInstId != undefined) {
                	qryClassDetail(classInstId);
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
		beforeSend: function() {
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

function initIsSelect(isSelect) {
	//未定班  则不需要选班
	if(isSelect == "N") {
		$("#selectClassTr").find("td").each(function(i) {
			if(i == 1) {
				$(this).attr("colspan", 5);
			} else if(i > 1) {
				$(this).css("display", "none");
			}
		});
		$("#changeDiv").css("display", "none");
	} else {
		$("#selectClassTr").find("td").each(function(i) {
			if(i == 1) {
				$(this).attr("colspan", 1);
			} else if(i > 1) {
				$(this).css("display", "table-cell");
			}
		});
	}
}