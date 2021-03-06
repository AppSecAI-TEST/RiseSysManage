$(document).ready(function() {
	var applyId = $("#applyId").val();
	var param = "{\"applyId\":\""+applyId+"\",\"queryCode\":\"qryChangeDetailById\"}";
	$.ajax({
		url: "/sys/applyClass/qryDataByQueryCode.do",
		data: "param=" + param,
		dataType: "json",
		async: true,
		beforeSend: function() {
			$.messager.progress({title : '转班', msg : '正在查询审批转班信息，请稍等……'});
		},
		success: function (data) {
			$.messager.progress('close'); 
			$("#schoolNameText").html(data.schoolName);
			$("#nameText").html(data.name);
			$("#byNameText").html(data.byName);
			$("#phoneText").html(data.phone);
			$("#outClassNameText").html(data.outClassName);
			$("#classProgressText").html(data.outClassProgress);
			$("#courseStateText").html(data.courseStateText);
			$("#changeClassNumText").html(data.changeClassNum);
			$("#teacherNameText").html(data.teacherName);
			$("#inClassNameText").html(data.planInClassName);
			$("#applyDateText").html(data.applyDate);
			$("#applyNameText").html(data.applyName);
			$("#changeRemarkText").html(data.applyRemark);
			
			var imgUrl = data.imgUrl;
			if(imgUrl != null && imgUrl != "" && imgUrl != undefined) {
				$("#imgUrl").css("display", "inline-block");
				$("#url").attr("href", imgUrl);
				$('#url').lightBox();
			} else {
				$("#viewChangeClassList").css("margin-left", "500px");
			}
		}
	});
	
	var channel = $("#channel").val();
	if(channel != "" && channel != null && channel != "null" && channel != undefined && channel == "index") {
		$("#backBtn").css("display", "none");
		$("#closeBtn").css("display", "inline-block");
	}
	
	//关闭按钮
	$("#closeBtn").click(function() {
		var title = "转班管理";
		parent.closeUrl(title);
	});
	
	//查看转班历史
	$("#viewChangeClassList").click(function() {
		var studentId = $("#studentId").val();
		var studentCourseId = $("#studentCourseId").val();
		window.location.href = "/sys/changeClass/changeClassHistList.jsp?studentId="+studentId+"&studentCourseId="+studentCourseId;
	});
	
	//审批转班
	$("#approveChangeSubmit").click(function() {
		var approveType = $('input:radio[name="approveType"]:checked').val();
		if(approveType == "" || approveType == null || approveType == undefined || approveType == "null") {
			$.messager.alert('提示', "请选择是否审批通过！");
		} else {
			if($("#approveChangeClassFm").form('validate')) {
				var object = $("#approveChangeClassFm").serializeObject();
				var remark = object.remark;
				remark = string2Json(remark);
				object.remark = remark;
				var obj = JSON.stringify(object);
				obj = encodeURI(obj);
				$.ajax({
					url: "/sys/change/approveChangeClass.do",
					data: "param=" + obj,
					dataType: "json",
					async: true,
					beforeSend: function() {
						$.messager.progress({title : '转班审批', msg : '正在审批转班，请稍等……'});
					},
					success: function (data) {
						$.messager.progress('close'); 
						var flag = data.flag;
						if(flag) {
							$.messager.alert('提示', "转班审批成功！", "info", function() {close();});
						} else {
							$.messager.alert('提示', data.msg);
						}
					} 
				});
			}
		}
	});
});

function close() {
	var channel = $("#channel").val();
	if(channel != "" && channel != null && channel != "null" && channel != undefined && channel == "index") {
		var title = "转班管理";
		parent.closeUrl(title);
	} else {
		window.history.back();
	}
}