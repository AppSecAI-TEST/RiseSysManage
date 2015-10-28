$(document).ready(function() {
	$("#disbandClassSubmit").click(function() {
		if($("#disbandClassFm").form('validate')) {
			var classStudentNum = parseInt($("#classStudentNum").val());
			if(classStudentNum == 0) {
				var obj = JSON.stringify($("#disbandClassFm").serializeObject());
				$.ajax({
					url: "/sys/attendClass/disbandClass.do",
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
			} else {
				$.messager.alert('提示', "您想要解散的班级还有"+classStudentNum+"名在读学员，请先将他们移除、转班或转校！");
			}
		}
	});
});