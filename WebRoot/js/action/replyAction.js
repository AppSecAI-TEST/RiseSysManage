var planArr=[];
var oldArr=[];
var actionId =null;
var operate =null;
var handlerId =null;
$(document).ready(function() {
	actionId =$("#actionId").val();
	operate =$("#operate").val();
	handlerId =$("#handlerId").val();
	if(operate=="A")
	{
		initAddPage();
	}
	else
	{
		initUpdatePage();
	}	
	$("#addBtn").click(function() {
		addTrInfo();
	});
	$("#submitBtn").click(function() {
		if(operate=="A")
		{
			replyAction();
		}
		else
		{
			updateReply();
		}	
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
		$.messager.alert("提示", "请填写参加课时");
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
				+ tr.attr("teacherType") + "</span>"+"<span>"+tr.attr("hours")+"</span>"
		tr.find("td:eq(1)").html(tdStr)
		tr
				.find("td:eq(2)")
				.html(
						"<a href='javascript:void(0)'class='easyui-linkbutton' iconCls='icon-remove' onclick='deleteTr(this)' plain='true'><span>删除</span></a>")
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



function initAddPage()
{
	$.ajax( {
		type : "POST",
		url : "/sys/actionInfo/getActionInfo.do",
		data :"actionId="+actionId,
		async : false,
		dataType:"json",
		beforeSend : function() {
			showProgressLoader("正在加载数据,请稍等...", 400);
		},
		success : function(data) {
			hideProgressLoader()
			if(data.actionInfo!=null)
			{
				var action =data.actionInfo;
				var tab =$("#infoTab");
				tab.find("tr:eq(0)").find("td:eq(1)").html("<span>"+action.schoolName+"</span>");
				var actionTime =action.actionTime;
				if(action.timeStart!=""&&action.timeStart!="")
				{
					actionTime+=" "+action.timeStart+" ～"+action.timeEnd;
				}	
				tab.find("tr:eq(1)").find("td:eq(1)").html("<span>"+actionTime+"</span>");
				tab.find("tr:eq(2)").find("td:eq(1)").html("<span>"+action.title+"</span>");
				$("#realHours").numberbox("setValue",action.planHours)
			}
			if(data.teacherInfo!=null&&data.teacherInfo.length>0)
			{
				$.each(data.teacherInfo,function(i,obj){
					var planTeacher={};
					planTeacher.teacherId =obj.teacherId;
					planTeacher.actionTeacherId =obj.actionTeacherId;
					planArr.push(planTeacher);
				})
				
			}	
		},
		error : function() {
			hideProgressLoader();
			showMessage('提示', "调用查询活动服务失败！", null);
		}
	});
}


function replyAction() {
	
	if ($("#realHours").numberbox("getValue") == "") {
		$.messager.alert("提示", "请填写实际课时");
		return false;
	}
	var reply={};
	var action = {};
	action.actionId=actionId;
	action.realHours =$("#realHours").numberbox("getValue");
	action.handlerId = handlerId;
	action.replyRemark =trim($("#replyRemark").val());
	var countHour =0;
	var teacheArr = [];
	$(".addTr").each(function() {
		var teacher = {};
		teacher.schoolId = $(this).attr("schoolId");
		teacher.schoolName = $(this).attr("schoolName");
		teacher.teacherId = $(this).attr("teacherId");
		teacher.teacherName = $(this).attr("teacherName");
		teacher.teacherType = $(this).attr("teacherType");
		teacher.hours = $(this).attr("hours");
		teacher.handlerId = handlerId;
		teacheArr.push(teacher);
		if($(this).attr("teacherType")=="T")
		{
			countHour +=parseInt($(this).attr("hours"));
		}	
	});	
	if(teacheArr.length<1)
	{
		$.messager.alert("提示", "请至少添加一条老师记录");
		return false;
	}
	if(countHour>parseInt(action.realHours))
	{
		$.messager.alert("提示", "主T老师课时数之和"+countHour+"大于课时数"+action.realHours+"，请修改");
		return false;
	}
	reply.actionInfo =action;
	reply.teacherInfo =teacheArr;
	reply.planInfo =planArr;
	$.ajax( {
		type : "POST",
		url : "/sys/actionInfo/replyAction.do",
		data :"param="+JSON.stringify(reply),
		async : false,
		beforeSend : function() {
			showProgressLoader("正在反馈,请稍等...", 400);
		},
		success : function(data) {
			hideProgressLoader()
			if (data == "true") {
				showMessage('提示', "反馈成功！", function() {
					window.location.href = "qryActionList.jsp";
				});
			} else {
				showMessage('提示', "反馈失败！", null);
			}

		},
		error : function() {
			hideProgressLoader();
			showMessage('提示', "调用反馈服务失败！", null);
		}
	});
}

function initUpdatePage()
{
	$.ajax( {
		type : "POST",
		url : "/sys/actionInfo/getReplyInfo.do",
		data :"actionId="+actionId,
		async : false,
		dataType:"json",
		beforeSend : function() {
			showProgressLoader("正在加载数据,请稍等...", 400);
		},
		success : function(data) {
			hideProgressLoader()
			if(data.actionInfo!=null)
			{
				var action =data.actionInfo;
				var tab =$("#infoTab");
				tab.find("tr:eq(0)").find("td:eq(1)").html("<span>"+action.schoolName+"</span>");
				var actionTime =action.actionTime;
				if(action.timeStart!=""&&action.timeStart!="")
				{
					actionTime+=" "+action.timeStart+" ～"+action.timeEnd;
				}	
				tab.find("tr:eq(1)").find("td:eq(1)").html("<span>"+actionTime+"</span>");
				tab.find("tr:eq(2)").find("td:eq(1)").html("<span>"+action.title+"</span>");
				$("#realHours").numberbox("setValue",action.realHours);
				$("#replyRemark").val(action.replyRemark);
			}
			if(data.teacherInfo!=null&&data.teacherInfo.length>0)
			{
				$.each(data.teacherInfo,function(i,obj){
					if(obj.isPlan=="Y")
					{
						planArr.push(obj);
					}
					if(obj.state=="00A")
					{
						oldArr.push(obj);
						var tr = $("#addInfo").clone();
						tr.addClass("addTr");
						tr.attr("schoolId", obj.schoolId);
						tr.attr("schoolName",obj.schoolName);
						tr.attr("teacherId", obj.teacherId);
						tr.attr("teacherName", obj.teacherName);
						tr.attr("teacherType",obj.teacherType);
						tr.attr("hours",obj.hours);
						var tdStr = "<span style='margin-right:20px'>" + tr.attr("schoolName")
								+ "</span><span style='margin-right:20px'>"
								+ tr.attr("teacherName") + "</span><span style='margin-right:20px'>"
								+ tr.attr("teacherType") + "</span>"+"<span>"+tr.attr("hours")+"</span>"
						tr.find("td:eq(1)").html(tdStr)
						tr.find("td:eq(2)").html("<a href='javascript:void(0)'class='easyui-linkbutton' iconCls='icon-remove' onclick='deleteTr(this)' plain='true'><span>删除</span></a>")
						$("#addInfo").after(tr);
						$.parser.parse(tr);
					}	
				});
				
			}	
		},
		error : function() {
			hideProgressLoader();
			showMessage('提示', "调用查询反馈服务失败！", null);
		}
	});
}

function updateReply()
{
	if ($("#realHours").numberbox("getValue") == "") {
		$.messager.alert("提示", "请填写实际课时");
		return false;
	}
	var param={};
	var action={};
	action.actionId =actionId;
	action.handlerId =handlerId;
	action.replyRemark =trim($("#replyRemark").val());
	action.realHours =$("#realHours").numberbox("getValue");
	var countHour =0;
	var newArr=[];
	$(".addTr").each(function() {
		var teacher = {};
		teacher.schoolId = $(this).attr("schoolId");
		teacher.schoolName = $(this).attr("schoolName");
		teacher.teacherId = $(this).attr("teacherId");
		teacher.teacherName = $(this).attr("teacherName");
		teacher.teacherType = $(this).attr("teacherType");
		teacher.hours = $(this).attr("hours");
		teacher.handlerId = handlerId;
		newArr.push(teacher);
		if($(this).attr("teacherType")=="T")
		{
			countHour +=parseInt($(this).attr("hours"));
		}	
	});	
	if(newArr.length<1)
	{
		$.messager.alert("提示", "请至少添加一条老师记录");
		return false;
	}
	if(countHour>parseInt(action.realHours))
	{
		$.messager.alert("提示", "主T老师课时数之和"+countHour+"大于课时数"+$("#realHours").numberbox("getValue")+"，请修改");
		return false;
	}
	param.actionInfo =action;
	param.oldTeacherInfo =oldArr;
	param.newTeacherInfo =newArr;
	param.planTeacherInfo=planArr;
	$.ajax( {
		type : "POST",
		url : "/sys/actionInfo/updateReply.do",
		data :"param="+JSON.stringify(param),
		async : false,
		beforeSend : function() {
			showProgressLoader("正在修改反馈,请稍等...", 400);
		},
		success : function(data) {
			hideProgressLoader()
			if (data == "true") {
				showMessage('提示', "修改反馈成功！", function() {
					window.location.href = "qryActionList.jsp";
				});
			} else {
				showMessage('提示', "修改反馈失败！", null);
			}

		},
		error : function() {
			hideProgressLoader();
			showMessage('提示', "调用修改反馈服务失败！", null);
		}
	});
}