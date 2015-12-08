$(document).ready(function() {
	var applyId = $("#applyId").val();
	var param = "{\"applyId\":\""+applyId+"\",\"queryCode\":\"qryChangeSchoolDetail\"}";
	$.ajax({
		url: "/sys/applyClass/qryDataByQueryCode.do",
		data: "param=" + param,
		dataType: "json",
		async: false,
		beforeSend: function()
		{
			$.messager.progress({title : '浏览', msg : '正在查询浏览转班信息，请稍等……'});
		},
		success: function (data) {
			$.messager.progress('close'); 
			$("#applyDateText").html(data.applyDate);
			$("#applyNameText").html(data.applyName);
			$("#inSchoolNameText").html(data.inSchoolName);
			$("#applyRemark").html(data.applyRemark);
			$("#approveDateText").html(data.approveDate);
			$("#approveNameText").html(data.approveName);
			$("#approveTypeText").html(data.approveTypeText);
			$("#approveRemark").html(data.approveRemark);
			var outDate = data.outDate;
			var isOutText = "否";
			if(outDate != null && outDate != "" && outDate != "null" && outDate != undefined) {
				isOutText = "是";
			}
			$("#isOutText").html(isOutText);
			var inDate = data.inDate;
			var isInText = "否";
			if(inDate != null && inDate != "" && inDate != "null" && inDate != undefined) {
				isInText = "是";
			}
			$("#isInText").html(isInText);
			$("#outDateText").html(outDate);
			$("#inDateText").html(inDate);
			
			var imgUrl = data.imgUrl;
			if(imgUrl != null && imgUrl != "" && imgUrl != undefined) {
				$("#imgUrl").css("display", "inline-block");
				$("#url").attr("href", imgUrl);
				$('#url').lightBox();
			} else {
				$("#viewChangeSchoolList").css("margin-left", "300px");
			}
		}
	});
	
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
	
	//查看转校历史信息
	$("#viewChangeSchoolList").click(function() {
		var studentId = $("#studentId").val();
		var studentCourseId = $("#studentCourseId").val();
		window.location.href = "/sys/changeSchool/changeSchoolHistList.jsp?studentId="+studentId+"&studentCourseId="+studentCourseId;
	});
	
	$("#cancelChangeSubmit").click(function() {
		if($("#calcenChangeSchoolFm").form('validate')) {
			var obj = JSON.stringify($("#calcenChangeSchoolFm").serializeObject());
			obj = encodeURI(obj);
			$.ajax({
				url: "/sys/change/cancelChangeSchool.do",
				data: "param=" + obj,
				dataType: "json",
				async: false,
				beforeSend: function()
				{
					$.messager.progress({title : '取消转班', msg : '取消转班，请稍等……'});
				},
				success: function (data) {
					$.messager.progress('close'); 
					var flag = data.flag
					if(flag) {
						$.messager.alert('提示', "取消转班成功！", "info", function() {window.history.back();});
					} else {
						$.messager.alert('提示', data.msg);
					}
				} 
			});
		}
	});
});