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
			$.messager.progress({title : '浏览', msg : '正在查询审批转班信息，请稍等……'});
		},
		success: function (data) {
			$.messager.progress('close'); 
			
			var imgUrl = data.imgUrl;
			if(imgUrl != null && imgUrl != "" && imgUrl != undefined) {
				$("#imgUrl").css("display", "inline-block");
				$("#url").attr("href", imgUrl);
				$('#url').lightBox();
			} else {
				$("#viewChangeSchool").css("margin-left", "500px");
			}
			$("#applyDateText").html(data.applyDate);
			$("#applyNameText").html(data.applyName);
			$("#changeRemarkText").html(data.applyRemark);
			
			$("#nameText").html(data.name);
			$("#phoneText").html(data.phone);
			$("#byNameText").html(data.byName);
			$("#schoolNameText").html(data.schoolName);
			$("#outClassNameText").html(data.outClassName);
			$("#teacherNameText").html(data.outClassTeacherName);
			
			$("#studentCourseId").val(data.studentCourseId);
		}
	});
	
	var channel = $("#channel").val();
	if(channel != "" && channel != null && channel != "null" && channel != undefined && channel == "index") {
		$("#backBtn").css("display", "none");
		$("#closeBtn").css("display", "inline-block");
	}
	
	var studentId = $("#studentId").val();
	$("#course_list_data").datagrid({ 
		url:"/sys/pubData/qryDataListByPage.do?param={funcNodeId:'1016',studentId:'"+studentId+"'}",
		onLoadSuccess: function() { 
			var rows = $("#course_list_data").datagrid('getRows');
			if(parseInt(rows.length) <= 0) {
				$("#courseTr").css("display", "none");
			}
		}
	});
	
	$("#international_list_data").datagrid({ 
		url:"/sys/pubData/qryDataListByPage.do?param={funcNodeId:'1038',studentId:'"+studentId+"'}",
		onLoadSuccess: function() { 
			var rows = $("#international_list_data").datagrid('getRows');
			if(parseInt(rows.length) <= 0) {
				$("#internationalTr").css("display", "none");
			}
		}
	});
	
	$("#travel_list_data").datagrid({ 
		url:"/sys/pubData/qryDataListByPage.do?param={funcNodeId:'1039',studentId:'"+studentId+"'}",
		onLoadSuccess: function() { 
			var rows = $("#travel_list_data").datagrid('getRows');
			if(parseInt(rows.length) <= 0) {
				$("#travelTr").css("display", "none");
			}
		}
	});
	
	$("#gift_list_data").datagrid({ 
		url:"/sys/pubData/qryDataListByPage.do?param={funcNodeId:'1030',studentId:'"+studentId+"'}",
		onLoadSuccess: function() { 
			var rows = $("#gift_list_data").datagrid('getRows');
			if(parseInt(rows.length) <= 0) {
				$("#giftTr").css("display", "none");
			}
		}
	});
	
	//关闭按钮
	$("#closeBtn").click(function() {
		var title = "转校管理";
		parent.closeUrl(title);
	});
	
	$("#approveChangeSubmit").click(function() {
		var approveType = $('input:radio[name="approveType"]:checked').val();
		if(approveType == "" || approveType == null || approveType == undefined || approveType == "null") {
			$.messager.alert('提示', "请选择是否审批通过！");
		} else {
			if($("#approveChangeSchoolFm").form('validate')) {
				var object = $("#approveChangeSchoolFm").serializeObject();
				var remark = object.remark;
				remark = string2Json(remark);
				object.remark = remark;
				var obj = JSON.stringify(object);
				obj = encodeURI(obj);
				$.ajax({
					url: "/sys/change/approveChangeClass.do",
					data: "param=" + obj,
					dataType: "json",
					async: true,
					beforeSend: function() {
						$.messager.progress({title : '转校审批', msg : '正在审批转校，请稍等……'});
					},
					success: function (data) {
						$.messager.progress('close'); 
						var flag = data.flag;
						if(flag) {
							$.messager.alert('提示', "转校审批成功！", "info", function() {close();});
						} else {
							$.messager.alert('提示', data.msg);
						}
					} 
				});
			}
		}
	});
});

function close() {
	var channel = $("#channel").val();
	if(channel != "" && channel != null && channel != "null" && channel != undefined && channel == "index") {
		var title = "转校管理";
		parent.closeUrl(title);
	} else {
		window.history.back();
	}
}

//查看转校历史信息
function viewChangeSchoolHist() {
	var studentId = $("#studentId").val();
	var studentCourseId = $("#studentCourseId").val();
	window.location.href = "/sys/changeSchool/changeSchoolHistList.jsp?studentId="+studentId+"&studentCourseId="+studentCourseId;
}