$(document).ready(function() {
	$("#disbandClassSubmit").click(function() {
		if($("#disbandClassFm").form('validate')) {
			var obj = JSON.stringify($("#disbandClassFm").serializeObject());
			$.ajax({
				url: "/sys/attendClass/updateCreateClass.do",
				data: "param=" + obj,
				dataType: "json",
				async: false,
				beforeSend: function()
				{
					$.messager.progress({title : '班级解散', msg : '正在解散班级，请稍等……'});
				},
				success: function (data) {
					$.messager.progress('close'); 
					var flag = data.flag;
					if(flag) {
						$.messager.alert('提示', "班级解散成功！", "info", function() {window.history.back();});
					} else {
						$.messager.alert('提示', data.msg);
					}
				} 
			});
		}
	});
});