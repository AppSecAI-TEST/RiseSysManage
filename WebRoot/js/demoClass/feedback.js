ajaxLoadEnd();
var shortClassInstId,classState,handlerId;
$(document).ready(function() {
	$("#backBtn").click(function() {
		window.history.back();
	});
	$("#submitBtn").click(function() {
		submitInfo();
	});
	shortClassInstId = $("#shortClassInstId").val();
	classState = $("#classState").val();
	handlerId =$("#handlerId").val();
	$("#schoolId").combobox( {
		url : "/sys/pubData/qrySchoolListWithTS.do",
		onChange : function() {
			var sId = $("#schoolId").combobox("getValue");
			var urls = "/sys/pubData/qryTeacherList.do?schoolId=" + sId;
			$("#teacherId").combobox( {
				url : urls
			});
		}
	});
	$("#startTime").timespinner({
		onChange:function(row){
			if($("#endTime").timespinner("getValue") != "")
			{
				var endTime = parseInt($("#endTime").timespinner("getHours"))+(parseInt($("#endTime").timespinner("getMinutes"))>0?1:0);
				var startTime = parseInt($("#startTime").timespinner("getHours"))+(parseInt($("#startTime").timespinner("getMinutes"))>0?1:0);
				$("#infoTab").find("tr:eq(2)").find("td:eq(1)").html(
							"&nbsp;&nbsp;<span>" + (endTime-startTime)
									+ "</span>");
				$("#hours").val(endTime-startTime);
			}
		}
	});
	$("#endTime").timespinner({
		onChange:function(row){
			if($("#startTime").timespinner("getValue") != "")
			{
				var endTime = parseInt($("#endTime").timespinner("getHours"))+(parseInt($("#endTime").timespinner("getMinutes"))>0?1:0);
				var startTime = parseInt($("#startTime").timespinner("getHours"))+(parseInt($("#startTime").timespinner("getMinutes"))>0?1:0);
				$("#infoTab").find("tr:eq(2)").find("td:eq(1)").html(
							"&nbsp;&nbsp;<span>" + (endTime-startTime)
									+ "</span>");
				$("#hours").val(endTime-startTime);
			}
		}
	});
	initInfo();
});

function initInfo() {
		$.ajax( {
			type : "POST",
			url : "/sys/demoClass/qryDemoInfo.do",
			data : "shortClassInstId=" + shortClassInstId+"&classState="+classState,
			async : false,
			dataType : "json",
			beforeSend : function() {
				showProgressLoader("正在加载数据,请稍等...", 400);
			},
			success : function(data) {
				console.log(data)
				hideProgressLoader()
				if (data.baseInfo != null) {
					$("#openDate").datebox("setValue", data.baseInfo.openDate);
					$("#infoTab").find("tr:eq(1)").find("td:eq(1)").html(
							"&nbsp;&nbsp;<span>" + data.baseInfo.roomName
									+ "</span>");
					$("#infoTab").find("tr:eq(2)").find("td:eq(1)").html(
							"&nbsp;&nbsp;<span>" + data.baseInfo.lessionHours
									+ "</span>");
					$("#lessionHours").numberbox( {
						max : data.baseInfo.lessionHours
					});
					$("#schoolIds").val(data.baseInfo.schoolId);
					$("#roomIds").val(data.baseInfo.roomId);
					$("#hours").val(data.baseInfo.lessionHours);
					$("#shortSchooltimeId").val(data.baseInfo.shortSchooltimeId);
					if(classState!="001")
					{
						$("#shortClassAttendId").val(data.baseInfo.shortClassAttendId);
					}
					$("#startTime").timespinner("setValue",data.baseInfo.startTime);
					$("#endTime").timespinner("setValue",data.baseInfo.endTime);
				}
				if (data.teacherInfo != null && data.teacherInfo.length > 0) {
					$.each(data.teacherInfo,
							function(i, obj) {
								var tr = $("#modelTr").clone();
								tr.addClass("tea");
								tr.attr("schoolId", obj.schoolId);
								tr.attr("teacherId", obj.teacherId);
								tr.attr("teacherType", obj.teacherType);
								tr.attr("lessionHours", obj.lessionHours);
								tr.find("td:eq(1)").find("span").html(
										obj.schoolName);
								tr.find("td:eq(2)").find("span").html(
										obj.teacherName);
								tr.find("td:eq(3)").find("span").html(
										obj.teacherType);
								tr.find("td:eq(4)").find("span").html(
										obj.lessionHours);
								tr.css("display", "table-row");
								$("#infoTab").append(tr);
							});

				}
			},
			error : function() {
				hideProgressLoader();
				showMessage('提示', "调用查询Demo课信息服务失败！", null);
			}
		});
}

function addTeacher() {
	if ($("#schoolId").combobox("getValue") == "") {
		$.messager.alert("提示", "请选择组织");
		return false;
	}
	if ($("#teacherId").combobox("getValue") == "") {
		$.messager.alert("提示", "请选择姓名");
		return false;
	}
	if ($("#teacherType").combobox("getValue") == "") {
		$.messager.alert("提示", "请选择课时类型");
		return false;
	}
	if ($("#lessionHours").numberbox("getValue") == "") {
		$.messager.alert("提示", "请填写课时量");
		return false;
	}
	if (checkTheSame($("#teacherId").combobox("getValue"))) {
		var tr = $("#modelTr").clone();
		tr.addClass("tea");
		tr.attr("schoolId", $("#schoolId").combobox("getValue"));
		tr.attr("teacherId", $("#teacherId").combobox("getValue"));
		tr.attr("teacherType", $("#teacherType").combobox("getValue"));
		tr.attr("lessionHours", $("#lessionHours").numberbox("getValue"));
		tr.find("td:eq(1)").find("span").html(
				$("#schoolId").combobox("getText"));
		tr.find("td:eq(2)").find("span").html(
				$("#teacherId").combobox("getText"));
		tr.find("td:eq(3)").find("span").html(
				$("#teacherType").combobox("getText"));
		tr.find("td:eq(4)").find("span").html(
				$("#lessionHours").numberbox("getValue"));
		tr.css("display", "table-row");
		$("#infoTab").append(tr);
		$("#schoolId").combobox("setValue", "")
		$("#teacherId").combobox("setValue", "")
		$("#teacherType").combobox("setValue", "")
		$("#lessionHours").numberbox("setValue", "");
	} else {
		$.messager.alert("提示", "您选择的老师已添加");
	}
}

function checkTheSame(teacherId) {
	var flag = true;
	$(".tea").each(function() {
		if ($(this).attr("teacherId") == teacherId) {
			flag = false;
			return false;
		}
	})
	return flag;
}

function delRow(obj) {
	$(obj).parent().parent().remove();
}

function submitInfo() {
	if (classState == "001") 
	{
		if($("#openDate").datebox("getValue")=="")
		{
			$.messager.alert("提示", "请选择上课日期");
			return false;
		}
		if($("#startTime").timespinner("getValue") == "")
		{
			$.messager.alert('提示',"上课起始时间不能为空,请核实后重新尝试");
			return false;
		}
		if($("#endTime").timespinner("getValue") == "")
		{
			$.messager.alert('提示',"上课结束时间不能为空,请核实后重新尝试");
			return false;
		}
		if(parseInt($("#hours").val()) <= 0)
		{
			$.messager.alert('提示',"上课起始时间必须大于上课结束时间,请核实后重新尝试");
			return false;
		}
	}
	var param={};
	var classAttend={};
	var teacherAttend=[];
	if(classState!="001")
	{
		classAttend.shortClassAttendId=$("#shortClassAttendId").val();
	}
	classAttend.shortClassInstId =shortClassInstId;
	classAttend.schoolId =$("#schoolIds").val();
	classAttend.roomId =$("#roomIds").val();
	classAttend.shortSchooltimeId =$("#shortSchooltimeId").val();
	classAttend.attendDate =$("#openDate").datebox("getValue");
	classAttend.startTime = $("#startTime").timespinner("getValue");
	classAttend.endTime = $("#endTime").timespinner("getValue");
	classAttend.handerId =handlerId;
	classAttend.attendNum="0";
	classAttend.attendRate="0";
	classAttend.hours =$("#hours").val();
	classAttend.lateNum="0";
	classAttend.truantNum="0";
	classAttend.leaveNum="0";
	classAttend.realNum="0";
	classAttend.schooltime=$("#openDate").datebox("getValue");
	classAttend.teacherIds="0";
	

	param.classAttend =classAttend;
	$(".tea").each(function() {
		var attobj ={};
		attobj.schoolId =$(this).attr("schoolId");
		attobj.teacherId =$(this).attr("teacherId");
		attobj.teacherType =$(this).attr("teacherType");
		attobj.lessionHours =$(this).attr("lessionHours");
		attobj.state ="00A";
		attobj.handerId =handlerId;
		attobj.attendDate =$("#openDate").datebox("getValue");
		teacherAttend.push(attobj);
	});
	if(teacherAttend.length<1)
	{
		$.messager.alert("提示", "请至少添加一个教师反馈");
		return false;
	}
	else
	{
		param.teacherAttend =teacherAttend;
		$.ajax( {
			type : "POST",
			url : "/sys/demoClass/feedBack.do",
			data :"classState="+classState+"&param="+JSON.stringify(param),
			async : false,
			beforeSend : function() {
				showProgressLoader("正在录入反馈,请稍等...", 400);
			},
			success : function(data) {
				hideProgressLoader()
				if (data == "true") {
					showMessage('提示', "录入反馈成功！", function() {
						window.history.back();
					});
				} else {
					showMessage('提示', "录入反馈失败！", null);
				}
	
			},
			error : function() {
				hideProgressLoader();
				showMessage('提示', "调用录入反馈服务失败！", null);
			}
		});
	}	
}