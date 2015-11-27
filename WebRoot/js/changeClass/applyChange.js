$(document).ready(function() {
    //上传
    $("#uploadBtn").click(function() {
    	var fileName = $("#fileName").filebox("getValue");
    	if(fileName != "" && fileName != null && fileName != undefined) {
    		var schoolId = $("#schoolId").val();
    		var handlerId = $("#handlerId").val();
    		$("#applyChangeClassFm").form("submit", {
    			url: "/sys/fileUpload?type=change_class&schoolId="+schoolId+"&handlerId="+handlerId,
    			onSubmit: function () {
    				
    			},
    			success: function (result) {
    				var data = JSON.parse(result);
    				if(data.flag)
    				{
    					$("#imgUrl").val(data.fileId);
    					$.messager.alert('提示', "文件上传成功！", "info", function() {$("#cancelUploadBtn").linkbutton('disable');});
    				}
    				else
    				{
    					$.messager.alert('提示', data.msg);
    				}
    			}
    		});
    	} else {
    		$.messager.alert('提示', "请您先选择一个文件！");
    	}
    });
    
    //取消上传
    $("#cancelUploadBtn").click(function() {
    	var fileName = $("#fileName").filebox("setValue", "");
    });
	
	$("#applyChangeSubmit").click(function() {
		if($("#applyChangeClassFm").form('validate')) {
			var flag = true;
			var fileName = $("#fileName").filebox("getValue");
			if(fileName != "" && fileName != null && fileName != undefined) {
				var imgUrl = $("#imgUrl").val();
				if(imgUrl == "" || imgUrl == null || imgUrl == undefined) {
					flag = false;
				}
			}
			if(flag) {
				var obj = JSON.stringify($("#applyChangeClassFm").serializeObject());
				obj = encodeURI(obj);
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
			} else {
				$.messager.alert('提示', "请您先上传文件！");
			}
		}
	});
});

function back() {
	window.location.href = "/sys/changeClass/changeClass.jsp";
}