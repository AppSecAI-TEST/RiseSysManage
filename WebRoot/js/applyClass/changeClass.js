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
		}
	});
	
    //更换选班发生变化时执行的操作
    $('#changeClassInstId').combobox({    
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
    
    //提交更换班级
    $("#submit").click(function() {
    	var handlerId = $("#handlerId").val();
    	var studentId = $("#studentId").val();
    	var classInstId = $('#changeClassInstId').combobox('getValue');
		var className = $('#changeClassInstId').combobox('getText');
		var studentCourseId = $("#studentCourseId").val();
		var studentChannelType = $("#oldClassName").val() + $("#feeTypeText").html();
		var oldClassInstId = $("#classInstId").val();
    	var param = "[{classInstId:\""+classInstId+"\",className:\""+className+"\",studentId:\""+studentId+"\",studentCourseId:\""+studentCourseId+"\",studentChannelType:\""+studentChannelType+"\",handlerId:\""+handlerId+"\",oldClassInstId:\""+oldClassInstId+"\"}]";
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
					$.messager.alert('提示', "添加学员成功！");
					window.location.reload();
				} else {
					$.messager.alert('提示', "添加学员失败！");
				}
			}
		});
    });
});