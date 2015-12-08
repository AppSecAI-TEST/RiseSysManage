$(document).ready(function() {
	var studentCourseId = $("#studentCourseId").val();
	var param = "{\"studentCourseId\":\""+studentCourseId+"\",\"queryCode\":\"qryChangeClassStudent\"}";
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
			async: false,
			beforeSend: function()
			{
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

function initClassInst(isBegin) {
	var schoolId = $("#schoolId").val();
	var courseType = $("#courseType").val();
	var stageId = $("#stageId").val();
	var classInstId = $("#classInstId").val();
	var classType = $("#classType").val();
	var schoolId = $("#schoolId").val();
	if("Y" == isBegin) {
		$("#beginClassInstId").combobox({
    		url : "/sys/pubData/qryClassInstList.do?schoolId="+schoolId+"&courseType="+courseType+"&stageId="+stageId+"&classType="+classType+"&classState='003'&classInstId=",//返回json数据的url
    		valueField : "classInstId",
    		textField : "className",
    		panelHeight : "auto",
    		onLoadSuccess : function () { //数据加载完毕事件
                var data = $('#beginClassInstId').combobox('getData');
                if (data.length > 0) {
                	if(classInstId != null && classInstId != "" && classInstId != undefined) {
                		$("#beginClassInstId").combobox('select', classInstId);
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
	        		}
	        	});
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
    		onLoadSuccess : function () { //数据加载完毕事件
                var data = $('#notBeginClassInstId').combobox('getData');
                if (data.length > 0) {
                	if(classInstId != null && classInstId != "" && classInstId != undefined) {
                		$("#notBeginClassInstId").combobox('select', classInstId);
                	} else {
                		$("#notBeginClassInstId").combobox('select', data[0].classInstId);
                	}
                }
            },
            onChange : function(n, o) {
	        	$("#changeDiv").css("display", "table-row");
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
	        		}
	        	});
            }
    	});
		$("#beginClassInstId").combobox('clear');
		$("#beginClassInstId").combobox("loadData", new Array());
	}
}