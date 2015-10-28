$(document).ready(function() {
	$("#applyChangeSubmit").click(function() {
		if($("#applyChangeSchoolFm").form('validate')) {
			var obj = JSON.stringify($("#applyChangeSchoolFm").serializeObject());
			alert(obj)
			$.ajax({
				url: "/sys/change/applyChangeClass.do",
				data: "param=" + obj,
				dataType: "json",
				async: false,
				beforeSend: function()
				{
					$.messager.progress({title : '申请转校', msg : '正在申请转校，请稍等……'});
				},
				success: function (data) {
					$.messager.progress('close'); 
					var flag = data.flag
					if(flag) {
						$.messager.alert('提示', "申请转校成功！", "info", function() {back();});
					} else {
						$.messager.alert('提示', data.msg);
					}
				} 
			});
		}
	});
});

function back() {
	window.location.href = "/sys/changeSchool/changeSchool.jsp";
}