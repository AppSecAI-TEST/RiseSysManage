$(document).ready(function() {
	var applyId = $("#applyId").val();
	var param = "{\"applyId\":\""+applyId+"\",\"queryCode\":\"qryChangeSchoolDetail\"}";
	$.ajax({
		url: "/sys/applyClass/qryDataByQueryCode.do",
		data: "param=" + param,
		dataType: "json",
		async: false,
		beforeSend: function()
		{
			$.messager.progress({title : '浏览', msg : '正在查询浏览转班信息，请稍等……'});
		},
		success: function (data) {
			$.messager.progress('close'); 
			$("#applyDateText").html(data.applyDate);
			$("#applyNameText").html(data.applyName);
			$("#inSchoolNameText").html(data.inSchoolName);
			$("#applyRemark").html(data.applyRemark);
			$("#approveDateText").html(data.approveDate);
			$("#approveNameText").html(data.approveName);
			$("#approveTypeText").html(data.approveTypeText);
			$("#approveRemark").html(data.approveRemark);
			var outDate = data.outDate;
			var isOutText = "否";
			if(outDate != null && outDate != "" && outDate != "null" && outDate != undefined) {
				isOutText = "是";
			}
			$("#isOutText").html(isOutText);
			var inDate = data.inDate;
			var isInText = "否";
			if(inDate != null && inDate != "" && inDate != "null" && inDate != undefined) {
				isInText = "是";
			}
			$("#isInText").html(isInText);
			$("#outDateText").html(outDate);
			$("#inDateText").html(inDate);
		}
	});
});