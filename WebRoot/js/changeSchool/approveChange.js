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
			
			var imgUrl = data.imgUrl;
			if(imgUrl != null && imgUrl != "" && imgUrl != undefined) {
				$("#imgUrl").css("display", "inline-block");
				$("#url").attr("href", imgUrl);
				$('#url').lightBox();
			} else {
				$("#viewChangeSchool").css("margin-left", "500px");
			}
			$("#applyDateText").html(data.applyDate);
			$("#applyNameText").html(data.applyName);
			$("#changeRemarkText").html(data.applyRemark);
		}
	});
	
	
	$("#approveChangeSubmit").click(function() {
		var approveType = $('input:radio[name="approveType"]:checked').val();
		if(approveType == "" || approveType == null || approveType == undefined || approveType == "null") {
			$.messager.alert('提示', "请选择是否审批通过！");
		} else {
			if($("#approveChangeSchoolFm").form('validate')) {
				var obj = JSON.stringify($("#approveChangeSchoolFm").serializeObject());
				obj = encodeURI(obj);
				$.ajax({
					url: "/sys/change/approveChangeClass.do",
					data: "param=" + obj,
					dataType: "json",
					async: false,
					beforeSend: function()
					{
						$.messager.progress({title : '转班审批', msg : '正在审批转班，请稍等……'});
					},
					success: function (data) {
						$.messager.progress('close'); 
						var flag = data.flag;
						if(flag) {
							$.messager.alert('提示', "转班审批成功！", "info", function() {window.history.back();});
						} else {
							$.messager.alert('提示', data.msg);
						}
					} 
				});
			}
		}
	});
});

//查看转校历史信息
function viewChangeSchoolHist() {
	var studentId = $("#studentId").val();
	var studentCourseId = $("#studentCourseId").val();
	window.location.href = "/sys/changeSchool/changeSchoolHistList.jsp?studentId="+studentId+"&studentCourseId="+studentCourseId;
}