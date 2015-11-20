$(document).ready(function() {
	var applyId = $("#applyId").val();
	var param = "{\"applyId\":\""+applyId+"\",\"queryCode\":\"qryChangeDetailById\"}";
	$.ajax({
		url: "/sys/applyClass/qryDataByQueryCode.do",
		data: "param=" + param,
		dataType: "json",
		async: false,
		beforeSend: function()
		{
			$.messager.progress({title : '转班', msg : '正在查询转班信息，请稍等……'});
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
		}
	});
	
	//审批转班
	$("#approveChangeSubmit").click(function() {
		var approveType = $('input:radio[name="approveType"]:checked').val();
		if(approveType == "" || approveType == null || approveType == undefined || approveType == "null") {
			$.messager.alert('提示', "请选择是否审批通过！");
		} else {
			if($("#approveChangeClassFm").form('validate')) {
				var obj = JSON.stringify($("#approveChangeClassFm").serializeObject());
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