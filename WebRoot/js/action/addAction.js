$(document).ready(function() {
	$("#addBtn").click(function() {
		addTrInfo();
	});
	$("#submitBtn").click(function() {
		addAction();
	});
	$("#backBtn").click(function() {
		window.location.href = "qryActionList.jsp";
	});

	$("#schoolId").combobox( {
		url : "../pubData/qrySchoolList.do?schoolId=",
		onChange : function() {
			var sId = $("#schoolId").combobox("getValue");
			var urls = "../pubData/qryTeacherList.do?schoolId=" + sId;
			$("#teacherId").combobox( {
				url : urls
			});
		}
	});
	$("textarea").each(function(i,node){
		$(node).attr("maxlength",200);
	});
});

function addTrInfo() {
	var tr = $("#addInfo").clone();
	if ($("#schoolId").combobox("getValue") == "") {
		$.messager.alert("提示", "请选择教师校区");
		return false;
	}
	if ($("#teacherId").combobox("getValue") == "") {
		$.messager.alert("提示", "请选择一个教师");
		return false;
	}
	if ($("#teacherType").combobox("getValue") == "") {
		$.messager.alert("提示", "请选择教师类型");
		return false;
	}
	if ($("#hours").numberbox("getValue") == "") {
		$.messager.alert("提示", "请填写教师课时");
		return false;
	}
	tr.addClass("addTr");
	if (checkTeacherOnly($("#teacherId").combobox("getValue"))) {
		tr.attr("schoolId", $("#schoolId").combobox("getValue"));
		tr.attr("schoolName", $("#schoolId").combobox("getText"));
		tr.attr("teacherId", $("#teacherId").combobox("getValue"));
		tr.attr("teacherName", $("#teacherId").combobox("getText"));
		tr.attr("teacherType", $("#teacherType").combobox("getValue"));
		tr.attr("hours", $("#hours").numberbox("getValue"));
		var tdStr = "<span style='margin-right:20px'>" + tr.attr("schoolName")
				+ "</span><span style='margin-right:20px'>"
				+ tr.attr("teacherName") + "</span><span style='margin-right:20px'>"
				+ tr.attr("teacherType") + "</span><span>"+ tr.attr("hours") + "</span>";
		tr.find("td:eq(1)").html(tdStr);
		tr.find("td:eq(2)").html("<a href='javascript:void(0)'class='easyui-linkbutton' iconCls='icon-remove' onclick='deleteTr(this)'><span>删除</span></a>");
		$("#addInfo").after(tr);
		$.parser.parse(tr);
		clearData("addInfo");
	} else {
		$.messager.alert("提示", "不能重复选择教师");
		return false;
	}

}

function deleteTr(obj) {
	$(obj).closest("tr").remove();
}

function checkTeacherOnly(val) {
	var flag = true;
	$(".addTr").each(
			function() {
				if ($(this).attr("teacherId") != null
						&& $(this).attr("teacherId") == val) {
					flag = false;
					return false;
				}
			})
	return flag;
}

function addAction() {
	var addInfo={};
	var action = {};
	if ($("#actionSchoolId").combobox("getValue") == "") {
		$.messager.alert("提示", "请选择校区");
		return false;
	}
	if ($("#actionDate").datebox("getValue") == "") {
		$.messager.alert("提示", "请选择活动日期");
		return false;
	}
	if ($("#planHours").numberbox("getValue") == "") {
		$.messager.alert("提示", "请填写活动课时");
		return false;
	}
	if ($("#title").textbox("getValue") == "") {
		$.messager.alert("提示", "请填写活动名称");
		return false;
	}
	if ($("#timeStart").timespinner("getValue") != "") {
		if ($("#timeEnd").timespinner("getValue") == "") {
			$.messager.alert("提示", "请填写活动结束时段");
			return false;
		} else if ($("#timeStart").timespinner('getHours') > $("#timeEnd")
				.timespinner('getHours')) {
			$.messager.alert("提示", "开始时段不能大于结束时段");
			return false;
		} else if ($("#timeStart").timespinner('getHours') == $("#timeEnd").timespinner('getHours')) {
			 
			if ($("#timeStart").timespinner('getMinutes') >= $("#timeEnd") .timespinner('getMinutes')) {
				$.messager.alert("提示", "开始时段不能大于等于结束时段");
				return false
			}
		}
	}
	else
	{
		$.messager.alert("提示", "请填写活动开始时段");
		return false;
	}	
	action.schoolId = $("#actionSchoolId").combobox("getValue");
	action.actionDate = $("#actionDate").datebox("getValue");
	action.title = $("#title").textbox("getValue");
	action.createRemark = $("#createRemark").textbox("getValue");
	action.timeStart = $("#timeStart").timespinner("getValue");
	action.timeEnd = $("#timeEnd").timespinner("getValue");
	action.planHours = $("#planHours").numberbox("getValue");
	var handlerValue = $("#handlerId").val();
	action.handlerId = handlerValue;
	var countHour =0;
	var teacheArr = [];
	$(".addTr").each(function() {
		var teacher = {};
		teacher.schoolId = $(this).attr("schoolId");
		teacher.schoolName = $(this).attr("schoolName");
		teacher.teacherId = $(this).attr("teacherId");
		teacher.teacherName = $(this).attr("teacherName");
		teacher.teacherType = $(this).attr("teacherType");
		teacher.hours =$(this).attr("hours");
		teacher.isPlan = "Y";
		teacher.handlerId = handlerValue;
		teacheArr.push(teacher);
		if($(this).attr("teacherType")=="T")
		{
			countHour +=parseInt($(this).attr("hours"));
		}
	})
	if(teacheArr.length<1)
	{
		$.messager.alert("提示", "请至少添加一条老师记录");
		return false;
	}
	//if(countHour>parseInt(action.planHours))
	//{
		//$.messager.alert("提示", "主T老师课时数之和"+countHour+"大于活动课时数"+action.planHours+"，请修改");
		//return false;
	//}
	action.state = "P";
	addInfo.actionInfo =action;
	addInfo.teacherInfo =teacheArr;
	$.ajax( {
		type : "POST",
		url : "/sys/actionInfo/addAction.do",
		data :"param="+JSON.stringify(addInfo),
		async : false,
		beforeSend : function() {
			showProgressLoader("正在添加活动,请稍等...", 400);
		},
		success : function(data) {
			hideProgressLoader()
			if (data == "true") {
				showMessage('提示', "添加活动成功！", function() {
					window.location.href = "qryActionList.jsp";
				});
			} else {
				showMessage('提示', "添加活动失败！", null);
			}

		},
		error : function() {
			hideProgressLoader();
			showMessage('提示', "调用添加活动服务失败！", null);
		}
	});
}