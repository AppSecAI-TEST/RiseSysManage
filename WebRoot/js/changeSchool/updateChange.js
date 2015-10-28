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
			$("#applyRemark").html(data.applyRemark);
			$("#outDateText").html(data.outDate);
			$("#outNameText").html(data.outName);
			$("#outSchoolNameText").html(data.outSchoolName);
			$("#inDateText").html(data.inDate);
			$("#inNameText").html(data.inName);
			$("#inClassNameText").html(data.inClassName);
		}
	});
});