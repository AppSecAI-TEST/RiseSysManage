$(document).ready(function() {
	var studentCourseId = $("#studentCourseId").val();
	var param = "{\"studentCourseId\":\""+studentCourseId+"\",\"queryCode\":\"qrySelectShortClassListById\"}";
	$.ajax({
		url: "/sys/applyClass/qryDataByQueryCode.do",
		data: "param=" + param,
		dataType: "json",
		async: true,
		beforeSend: function() {
			$.messager.progress({title : '选班', msg : '正在查询学员信息，请稍等……'});
		},
		success: function (data) {
			$.messager.progress('close'); 
			$("#nameText").html(data.name);
			$("#birthdayText").html(data.birthday);
			$("#feeTypeText").html(data.feeType);
			$("#sexText").html(data.sexText);
			$("#identityIdText").html(data.identityId);
			$("#phoneText").html(data.phone);
			$("#byNameText").html(data.byName);
			$("#payDateText").html(data.payDate);
			$("#dutyAdvisterNameText").html(data.dutyAdvisterName);
			$("#classTypeText").html(data.classType);
			$("#currentClassNameText").html(data.className);
			$("#selectClassDateText").html(data.selectClassDate);
			$("#selectClassNumText").html(data.selectClassNum);
			$("#courseStateText").html(data.courseStateText);
			var adviserName = data.adviserName;
			if(adviserName != null && adviserName != "" && adviserName != undefined) {
				$("#adviserTeacher").html("业绩顾问");
				$("#adviserTeacherNameText").html(adviserName);
			} else {
				$("#adviserTeacherNameText").html(data.adviserTeacherName);
			}
			var stageId = data.stageId;
			var schoolId = data.schoolId;
			var classType = data.classType;
			var courseType = data.courseType;
			var oldClassInstId = data.shortClassInstId;
			$("#stageId").val(stageId);
			$("#schoolId").val(schoolId);
			$("#classType").val(classType);
			$("#feeType").val(data.feeType);
			$("#courseType").val(courseType);
			$("#studentId").val(data.studentId);
			$("#oldClassName").val(data.className);
			$("#oldCourseState").val(data.courseState);
			$("#oldClassInstId").val(oldClassInstId);
			$("#notBeginClassInstId").combobox({
	    		url : "/sys/pubData/qryClassInstList.do?schoolId="+schoolId+"&courseType="+courseType+"&stageId="+stageId+"&classType="+classType+"&classState='001','002'&classInstId=" + oldClassInstId,//返回json数据的url
	    		valueField : "classInstId",
	    		textField : "className",
	    		panelHeight : "auto",
	    		formatter : function(data) {
	        		return "<span>" + data.className + "</span>";
	        	}
			});
		}
	});
	
	//提交选班
	$("#submit").click(function() {
		var classInstId = $('#notBeginClassInstId').combobox('getValue');
		if(classInstId != null && classInstId != "" && classInstId != undefined) {
			var array = new Array();
			var obj = new Object();
			obj.shortClassInstId = classInstId;
			obj.studentId = $("#studentId").val();
			obj.studentCourseId = $("#studentCourseId").val();
			obj.schoolId = $("#schoolId").val();
			obj.handlerId = $("#handlerId").val();
			array.push(obj);
			var param = JSON.stringify(array);
			param = encodeURI(param);
			$.ajax({
				url: "/sys/applyClass/addShortClassStudent.do",
				data: "param=" + param,
				dataType: "json",
				async: true,
				beforeSend: function() {
					$.messager.progress({title : '选班', msg : '正在选班，请稍等……'});
				},
				success: function (data) {
					$.messager.progress('close'); 
					var flag = data.flag;
					if(flag) {
						$.messager.alert('提示', "选班成功！", "info", function() {window.history.back();});
					} else {
						$.messager.alert('提示', data.msg);
					}
				}
			});
		} else {
			$.messager.alert('提示', "请选择一个未开课班级！");
		}
	});
});