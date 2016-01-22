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
			$.messager.progress({title : '浏览', msg : '正在查询浏览转校信息，请稍等……'});
		},
		success: function (data) {
			$.messager.progress('close'); 
			$("#changeStateText").html(data.changeStateText);
			$("#outSchoolNameText").html(data.outSchoolName);
			$("#outClassNameText").html(data.outClass);
			$("#courseStateText").html(data.courseStateText);
			$("#inSchoolNameText").html(data.inSchoolName);
			$("#inClassNameText").html(data.inClass);
			$("#finishStageIdText").html(data.finishStageId);
			$("#higherStageIdText").html(data.higherStageId);
			$("#stageIdText").html(data.stageIdText);
			$("#feeTypeText").html(data.feeTypeText);
			
			var imgUrl = data.imgUrl;
			if(imgUrl != null && imgUrl != "" && imgUrl != undefined) {
				$("#imgUrl").css("display", "block");
				$("#url").attr("href", imgUrl);
				$('#url').lightBox();
			}
			
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
});