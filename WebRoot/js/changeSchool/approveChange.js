$(document).ready(function() {
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