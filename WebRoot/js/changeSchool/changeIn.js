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
			$.messager.progress({title : '转入班级', msg : '正在查询转入班级信息，请稍等……'});
		},
		success: function (data) {
			$.messager.progress('close'); 
			$("#nameText").html(data.name);
			$("#phoneText").html(data.phone);
			$("#byNameText").html(data.byName);
			
			$("#approveDateText").html(data.approveDate);
			$("#approveNameText").html(data.approveName);
			$("#approveRemarkText").html(data.approveRemark);
			
			$("#outDateText").html(data.outDate);
			$("#outNameText").html(data.outName);
			$("#outSchoolName").html(data.outSchoolName);
			
			$("#stageId").val(data.stageId);
			$("#classType").val(data.classType);
			$("#courseType").val(data.courseType);
			$("#outClassId").val(data.outClassId);
			$("#inSchoolId").val(data.inSchoolId);
			$("#studentCourseId").val(data.studentCourseId);
		}
	});
	
	$("input:radio[name='isBegin']").change(function() {
		var isBegin = $("input:radio[name='isBegin']:checked").val();
		initClassInst(isBegin);
	});
	
	//转入校区
	$("#changeInSubmit").click(function() {
		var isBegin = $("input:radio[name='isBegin']:checked").val();
		if(isBegin != "" && isBegin != null && isBegin != undefined) {
			var classStudentNum = $("#classStudentNum").html();
			var studentNum = parseInt(classStudentNum.split("/")[0]) + 1;
			var maxNum = parseInt(classStudentNum.split("/")[1]);
			if(studentNum <= maxNum) {
				var classInstId = "";
				var className = "";
				if("Y" == isBegin) {
					classInstId = $('#beginClassInstId').combobox('getValue');
		    		className = $('#beginClassInstId').combobox('getText');
				} else {
					classInstId = $('#notBeginClassInstId').combobox('getValue');
		    		className = $('#notBeginClassInstId').combobox('getText');
				}
				var obj = JSON.stringify($("#changeInSchoolFm").serializeObject());
				obj = obj.substring(0, obj.length - 1);
				obj += ",\"classInstId\":\""+classInstId+"\",className:\""+className+"\"}";
				obj = encodeURI(obj);
				$.ajax({
					url: "/sys/change/changeInSchool.do",
					data: "param=" + obj,
					dataType: "json",
					async: true,
					beforeSend: function()
					{
						$.messager.progress({title : '转入校区', msg : '正在转入校区，请稍等……'});
					},
					success: function (data) {
						$.messager.progress('close'); 
						var flag = data.flag;
						if(flag) {
							$.messager.alert('提示', "转入校区成功！", "info", function() {window.history.back();});
						} else {
							$.messager.alert('提示', data.msg);
						}
					} 
				});
			} else {
				var classNameText = $("#classNameText").html();
				$.messager.alert('提示', "您选择的"+classNameText+"学员已经满员，不能再向该班级转入学员！");
			}
		} else {
			$.messager.alert('提示', "请先选择您要转入的班级！");
		}
	});
});

function initClassInst(isBegin) {
	var stageId = $("#stageId").val();
	var inSchoolId = $("#inSchoolId").val();
	var classType = $("#classType").val();
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
                	$("#beginClassInstId").combobox('select', data[0].classInstId);
                } else {
                	$("#changeDiv").css("display", "none");
                }
            },
            onChange : function(n, o) {
            	$("#changeDiv").css("display", "block");
            	var param = "{\"classInstId\":\""+n+"\",\"queryCode\":\"qryClassInstListById\"}";
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
            			$("#className").html(data.className);
            			$("#applyDate").html(data.applyClassDate);
            			$("#startDate").html(data.startDate);
            			$("#teacherName").html(data.teacherName);
            			$("#classStudentNum").html(data.classStudentNum);
            			$("#classProgress").html(data.classProgress);
            			$("#schooltimeName").html(data.schooltimeName);
            			$("#inClassTr").css("display", "table-row");
            		}
            	});
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
                	$("#notBeginClassInstId").combobox('select', data[0].classInstId);
                } else {
                	$("#changeDiv").css("display", "none");
                }
            },
            onChange : function(n, o) {
            	$("#changeDiv").css("display", "block");
            	var param = "{\"classInstId\":\""+n+"\",\"queryCode\":\"qryClassInstListById\"}";
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
            			$("#classInstId").val(data.classInstId);
            			$("#className").val(data.className);
            			$("#classNameText").html(data.className);
            			$("#applyDate").html(data.applyClassDate);
            			$("#startDate").html(data.startDate);
            			$("#teacherName").html(data.teacherName);
            			$("#classStudentNum").html(data.classStudentNum);
            			$("#classProgress").html(data.classProgress);
            			$("#schooltimeName").html(data.schooltimeName);
            			$("#inClassTr").css("display", "table-row");
            		}
            	});
            }
    	});
		$("#beginClassInstId").combobox('clear');
		$("#beginClassInstId").combobox("loadData", new Array());
	}
}