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
			$.messager.progress({title : '转出班级', msg : '正在查询转出校区信息，请稍等……'});
		},
		success: function (data) {
			$.messager.progress('close'); 
			$("#nameText").html(data.name);
			$("#phoneText").html(data.phone);
			$("#byNameText").html(data.byName);
			
			$("#outSchoolNameText").html(data.outSchoolName);
			$("#outClassNameText").html(data.outClassName);
			$("#inSchoolNameText").html(data.inSchoolName);
			
			$("#approveDateText").html(data.approveDate);
			$("#approveNameText").html(data.approveName);
			$("#approveRemarkText").html(data.approveRemark);
			
			$("#outClassId").val(data.outClassId);
			$("#outSchoolId").val(data.outSchoolId);
			$("#studentCourseId").val(data.studentCourseId);
		}
	});
	
	//提交转出
	$("#changeOutSubmit").click(function() {
		var obj = JSON.stringify($("#changeOutSchoolFm").serializeObject());
		obj = encodeURI(obj);
		$.ajax({
			url : "/sys/change/changeOutSchool.do",
			data: "param="+obj,
			dataType: "json",
			async: true,
			beforeSend: function()
			{
				$.messager.progress({title : '转入班级', msg : '正在转出校区，请稍等……'});
			},
			success: function (data) {
				$.messager.progress('close'); 
				var flag = data.flag;
				if(flag) {
					$.messager.alert('提示', "转出校区成功！", "info", function() {window.history.back();});
				} else {
					$.messager.alert('提示', data.msg);
				}
			}
		});
	});
});