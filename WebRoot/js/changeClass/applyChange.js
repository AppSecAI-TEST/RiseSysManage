$(document).ready(function() {
	$("#applyChangeSubmit").click(function() {
		if($("#applyChangeClassFm").form('validate')) {
			var obj = JSON.stringify($("#applyChangeClassFm").serializeObject());
			$.ajax({
				url: "/sys/change/applyChangeClass.do",
				data: "param=" + obj,
				dataType: "json",
				async: false,
				beforeSend: function()
				{
					$.messager.progress({title : '申请转班', msg : '正在申请转班，请稍等……'});
				},
				success: function (data) {
					$.messager.progress('close'); 
					var flag = data.flag
					if(flag) {
						$.messager.alert('提示', "申请转班成功！", "info", function() {back();});
					} else {
						$.messager.alert('提示', data.msg);
					}
				} 
			});
		}
	});
});

function back() {
	window.location.href = "/sys/changeClass/changeClass.jsp";
}