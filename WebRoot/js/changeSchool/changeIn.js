$(document).ready(function() {
	$("input:radio[name='isBegin']").change(function() {
		var isBegin = $("input:radio[name='isBegin']:checked").val();
		initClassInst(isBegin);
	});
});

function initClassInst(isBegin) {
	var stageId = $("#stageId").val();
	var inSchoolId = $("#inSchoolId").val();
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
    		onLoadSuccess : function () { //数据加载完毕事件
                var data = $('#beginClassInstId').combobox('getData');
                if (data.length > 0) {
                	if(isBegin == inClassIsBegin) {
                		$("#beginClassInstId").combobox('select', inClassId);
                	} else {
                		$("#beginClassInstId").combobox('select', data[0].classInstId);
                	}
                }
            },
            onChange : function(n, o) {
            	$("#changeDiv").css("display", "block");
            	var param = "{\"classInstId\":\""+n+"\",\"queryCode\":\"qryClassInstListById\"}";
            	$.ajax({
            		url: "/sys/applyClass/qryDataByQueryCode.do",
            		data: "param=" + param,
            		dataType: "json",
            		async: false,
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
            			$("#inClassTr").css("display", "block");
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
    		onLoadSuccess : function () { //数据加载完毕事件
                var data = $('#notBeginClassInstId').combobox('getData');
                if (data.length > 0) {
                	if(isBegin == inClassIsBegin) {
                		$("#notBeginClassInstId").combobox('select', inClassId);
                	} else {
                		$("#notBeginClassInstId").combobox('select', data[0].classInstId);
                	}
                }
            },
            onChange : function(n, o) {
            	$("#changeDiv").css("display", "block");
            	var param = "{\"classInstId\":\""+n+"\",\"queryCode\":\"qryClassInstListById\"}";
            	$.ajax({
            		url: "/sys/applyClass/qryDataByQueryCode.do",
            		data: "param=" + param,
            		dataType: "json",
            		async: false,
            		beforeSend: function()
            		{
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
            		}
            	});
            }
    	});
		$("#beginClassInstId").combobox('clear');
		$("#beginClassInstId").combobox("loadData", new Array());
	}
}