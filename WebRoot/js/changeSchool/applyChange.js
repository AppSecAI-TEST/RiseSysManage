$(document).ready(function() {
    //上传
    $("#uploadBtn").click(function() {
    	var fileName = $("#fileName").filebox("getValue");
    	if(fileName != "" && fileName != null && fileName != undefined) {
    		var schoolId = $("#schoolId").val();
    		var handlerId = $("#handlerId").val();
    		$("#applyChangeSchoolFm").form("submit", {
    			url: "/sys/fileUpload?type=change_school&schoolId="+schoolId+"&handlerId="+handlerId,
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
		if($("#applyChangeSchoolFm").form('validate')) {
			var flag = true;
			var fileName = $("#fileName").filebox("getValue");
			if(fileName != "" && fileName != null && fileName != undefined) {
				var imgUrl = $("#imgUrl").val();
				if(imgUrl == "" || imgUrl == null || imgUrl == undefined) {
					flag = false;
				}
			}
			if(flag) {
				var obj = JSON.stringify($("#applyChangeSchoolFm").serializeObject());
				obj = encodeURI(obj);
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
			} else {
				$.messager.alert('提示', "请您先上传文件！");
			}
		}
	});
});

function back() {
	window.location.href = "/sys/changeSchool/changeSchool.jsp";
}

//查看转校历史信息
function viewChangeSchoolHist() {
	var studentId = $("#studentId").val();
	var studentCourseId = $("#studentCourseId").val();
	window.location.href = "/sys/changeSchool/changeSchoolHistList.jsp?studentId="+studentId+"&studentCourseId="+studentCourseId;
}