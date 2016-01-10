$(document).ready(function() {
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