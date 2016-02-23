$(document).ready(function(){
	$("#backBtn").click(function(){
		window.history.back();
	});
	//关闭按钮
	$("#closeBtn").click(function() {
		var title = "异常管理";
		parent.closeUrl(title);
	});
	initPage();
});


function initPage()
{
	var info = document.URL.split("=")[1];
	var studentId = info.split(",")[0];
	var studentCourseId = info.split(",")[1];
	var excId = info.split(",")[2];
	var channel = info.split(",")[3];
	if(channel != "" && channel != null && channel != "null" && channel != undefined && channel == "index") {
		$("#backBtn").css("display", "none");
		$("#closeBtn").css("display", "inline-block");
	}
	var param = '{"excFlag":"Y","studentId":"'+studentId+'","studentCourseId":"'+studentCourseId+'","excId":"'+excId+'"}';
	$.ajax({
		type : "POST",
		url: "/sys/exception/qryInfo.do",
		data: "param="+param,
		async: false,
		dataType:"json",
		beforeSend: function() {
	    	$.messager.progress({title : '系统消息', msg : '正在加载数据，请稍等……'});
	    },
	   	success: function(data) {
	    	$.messager.progress('close'); 
			if (data.studentInfo != undefined) {
				$("#name").html(data.studentInfo.name);
				$("#birthday").html(data.studentInfo.birthday);
				$("#sexVal").html(data.studentInfo.sexVal);
				$("#identityId").html(data.studentInfo.identityId);
				$("#byName").html(data.studentInfo.byName);
				$("#phone").html(data.studentInfo.phone);
				$("#schoolName").html(data.studentInfo.schoolName);
				if (data.excInfo != undefined) {
					$("#createDate").html(data.excInfo.createDate);
					$("#excState").html(data.excInfo.state);
					$("#excDays").html(data.excInfo.excDays + "天");
					$("#excHandler").html(data.excInfo.handler);
					$("#remark").html(data.excInfo.remark);
					$("#finishDate").html(data.excInfo.finishDate);
					$("#resumeDate").html(data.excInfo.resumeDate);
					$("#resumeType").html(data.excInfo.resumeType);
					if (data.excInfo.state == '异常中'
							&& data.excInfo.excDays != ""
								&& parseInt(data.excInfo.excDays) > 730) {
						$("#excState").html("已超期");
					}
				}
			}
			if (data.courseInfo != undefined && data.courseInfo.length > 0) {
				var contentStr = "";
				$.each(data.courseInfo, function(i, obj) {
					contentStr += "<tr><td>" + obj.stageId + "</td>";
					contentStr += "<td>" + obj.courseStateText + "</td>";
					contentStr += "<td>" + obj.paySchoolName + "</td>";
					contentStr += "<td>" + obj.payDate + "</td>";
					contentStr += "<td>" + obj.feeTypeText + "</td>";
					contentStr += "<td>" + obj.className + "</td>";
					contentStr += "<td>" + obj.startDate + "</td>";
					contentStr += "<td>" + obj.finishDate + "</td>";
					contentStr += "<td>" + obj.classProgress + "</td>";
					contentStr += "<td>" + obj.adviserName + "</td>";
					contentStr += "<td>" + obj.dutyAdvisterName + "</td>";
					contentStr += "<td>" + obj.carerName + "</td></tr>";
				});
				$("#classInfo").append(contentStr);
			}
		},
		error : function() {
			$.messager.progress('close');
		}
	});
}