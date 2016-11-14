$(document).ready(function() {
	var applyId = $("#applyId").val();
	var param = "{\"applyId\":\""+applyId+"\",\"queryCode\":\"qryChangeClassDetail\"}";
	$.ajax({
		url: "/sys/applyClass/qryDataByQueryCode.do",
		data: "param=" + param,
		dataType: "json",
		async: true,
		beforeSend: function() {
			$.messager.progress({title : '浏览', msg : '正在查询浏览转班信息，请稍等……'});
		},
		success: function (data) {
			$.messager.progress('close'); 
			$("#changeStateText").html(data.changeStateText);
			$("#outClass").html(data.outClass);
			$("#inClass").html(data.inClass);
			var feeType = data.feeType;
			if("001" == feeType) {
				$("#adviserName").html(data.adviserName);
			} else {
				$("#adviserNameText").html("业绩老师：");
				$("#adviserName").html(data.adviserTeacherName);
			}
			$("#outClassTeacherName").html(data.outClassTeacherName);
			$("#oldCourseStateText").html(data.oldCourseStateText);
			var applyDate = data.applyDate;
			if(applyDate != null && applyDate != "" && applyDate != "null" && applyDate != undefined) {
				$("#applyDate").html(data.applyDate);
				$("#applyName").html(data.applyName);
				$("#applyRemark").html(data.applyRemark);
				$("#applyTr").css("display", 'table-row');
			}
			var approveDate = data.approveDate;
			if(approveDate != null && approveDate != "" && approveDate != "null" && approveDate != undefined) {
				$("#approveDate").html(data.approveDate);
				$("#approveName").html(data.approveName);
				$("#approveTypeText").html(data.approveTypeText);
				$("#approveRemark").html(data.approveRemark);
				$("#approveTr").css("display", 'table-row');
			}
			var inDate = data.inDate;
			if(inDate != null && inDate != "" && inDate != "null" && inDate != undefined) {
				$("#inDate").html(data.inDate);
				$("#inName").html(data.inName);
				$("#inTr").css("display", 'table-row');
			}
			var outDate = data.outDate;
			if(outDate != null && outDate != "" && outDate != "null" && outDate != undefined) {
				$("#outDate").html(data.outDate);
				$("#outName").html(data.outName);
				$("#outTr").css("display", 'table-row');
			}
			var cancelDate = data.cancelDate;
			if(cancelDate != null && cancelDate != "" && cancelDate != "null" && cancelDate != undefined) {
				$("#cancelDate").html(data.cancelDate);
				$("#cancelName").html(data.cancelName);
				$("#cancelTr").css("display", 'table-row');
			}
			var stopDate = data.stopDate;
			if(stopDate != null && stopDate != "" && stopDate != "null" && stopDate != undefined) {
				$("#stopDate").html(data.stopDate);
				$("#stopName").html(data.stopName);
				$("#stopTr").css("display", 'table-row');
			}
			var finishDate = data.finishDate;
			if(finishDate != null && finishDate != "" && finishDate != "null" && finishDate != undefined) {
				$("#finishDate").html(data.finishDate);
				$("#finishName").html(data.finishName);
				$("#finishTr").css("display", 'table-row');
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
});