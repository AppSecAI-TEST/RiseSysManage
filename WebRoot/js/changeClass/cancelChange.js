$(document).ready(function() {
	var applyId = $("#applyId").val();
	var param = "{\"applyId\":\""+applyId+"\",\"queryCode\":\"qryChangeDetailById\"}";
	$.ajax({
		url: "/sys/applyClass/qryDataByQueryCode.do",
		data: "param=" + param,
		dataType: "json",
		async: true,
		beforeSend: function()
		{
			$.messager.progress({title : '转班', msg : '正在查询取消转班信息，请稍等……'});
		},
		success: function (data) {
			$.messager.progress('close'); 
			$("#schoolNameText").html(data.schoolName);
			$("#nameText").html(data.name);
			$("#byNameText").html(data.byName);
			$("#phoneText").html(data.phone);
			$("#oldCourseStateText").html(data.oldCourseStateText);
			$("#changeClassNumText").html(data.changeClassNum);
			$("#planInClassNameText").html(data.planInClassName);
			$("#planInClassNameText").html(data.planInClassName);
			$("#teacherNameText").html(data.teacherName);
			$("#outDateText").html(data.outDate);
			$("#outHandlerNameText").html(data.outHandlerName);
			$("#outClassNameText").html(data.outClassName);
			$("#outClassProgressText").html(data.outClassProgress);
			$("#inDateText").html(data.inDate);
			$("#inHandlerNameText").html(data.inHandlerName);
			$("#inClassNameText").html(data.inClassName);
			$("#inClassProgressText").html(data.inClassProgress);
			$("#applyDateText").html(data.applyDate);
			$("#applyNameText").html(data.applyName);
			$("#applyRemarkText").html(data.applyRemark);
			$("#approveDateText").html(data.approveDate);
			$("#approveNameText").html(data.approveName);
			$("#approveTypeText").html(data.approveTypeText);
			$("#approveRemarkText").html(data.approveRemark);
			
			$("#outClassId").val(data.outClassId);
			$("#courseState").val(data.courseState);
			$("#oldCourseState").val(data.oldCourseState);
			
			var imgUrl = data.imgUrl;
			if(imgUrl != null && imgUrl != "" && imgUrl != undefined) {
				$("#imgUrl").css("display", "inline-block");
				$("#url").attr("href", imgUrl);
				$('#url').lightBox();
			}
		}
	});
	
	$("#cancelChangeSubmit").click(function() {
		if($("#cancelChangeClassFm").form('validate')) {
			var object = $("#cancelChangeClassFm").serializeObject();
			var remark = object.remark;
			remark = string2Json(remark);
			object.remark = remark;
			var obj = JSON.stringify(object);
			obj = encodeURI(obj);
			$.ajax({
				url: "/sys/change/cancelChange.do",
				data: "param=" + obj,
				dataType: "json",
				async: true,
				beforeSend: function()
				{
					$.messager.progress({title : '取消转班', msg : '取消转班，请稍等……'});
				},
				success: function (data) {
					$.messager.progress('close'); 
					var flag = data.flag
					if(flag) {
						$.messager.alert('提示', "取消转班成功！", "info", function() {window.history.back();});
					} else {
						$.messager.alert('提示', data.msg);
					}
				} 
			});
		}
	});
});