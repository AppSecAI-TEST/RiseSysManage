var td = 1;
var selTr = null;
var classTeacherId = "";
$(document).ready(function() {	
	$("#selectClass").click(function() {
		var classType = $("#classType").html();
		var schoolId = $("#schoolId").val();
		var className = $("#className").html();
		var classInstId = $("#classInstId").val();
		window.location.href = "/sys/applyClass/studentCourseList.jsp?classType="+classType+"&schoolId="+schoolId+"&className="+className+"&classInstId="+classInstId;
	});
	
	$("#removeStudent").click(function() {
		var obj = $('#list_data').datagrid('getSelections');
		if(obj.length > 0) {
			$.messager.confirm('提示','您确定要移除当前选中的学员吗?',function(r){
				if(r){
					var classStudentId = "";
					var studentCourseId = "";
					for(var i = 0, n = obj.length; i < n; i++) {
						classStudentId += obj[i].classStudentId + ",";
						studentCourseId += obj[i].studentCourseId + ",";
					}
					classStudentId = classStudentId.substring(0, classStudentId.length - 1);
					studentCourseId = studentCourseId.substring(0, studentCourseId.length - 1);
					var handlerId = $("#handlerId").val();
					var param = "{\"classStudentId\":\""+classStudentId+"\",\"studentCourseId\":\""+studentCourseId+"\",\"handlerId\":\""+handlerId+"\"}";
					$.ajax({
						url: "/sys/applyClass/batchRemoveStudent.do",
						data: "param=" + param,
						dataType: "json",
						async: false,
						beforeSend: function()
						{
							$.messager.progress({title : '学员移除', msg : '正在学员移除，请稍等……'});
						},
						success: function (data) {
							$.messager.progress('close'); 
							var flag = data.flag
							if(flag) {
								$.messager.alert('提示', "学员移除成功！", "info", function() {window.location.reload();});
							} else {
								$.messager.alert('提示', data.msg);
							}
						}
					});
				}
			});
		} else {
			$.messager.alert('提示', "请先选择您要移除的学员！");
		}
	});
	
	$("#changeClass").click(function() {
		if(validateSelect()) {
			var row = $('#list_data').datagrid('getSelected');
			var studentId = row.studentId;
			var classInstId = row.classInstId;
			var stageId = $("#stageId").html();
			var classType = $("#classType").html();
			var studentCourseId = row.studentCourseId;
			window.location.href = "/sys/applyClass/changeClass.jsp?studentId="+studentId+"&classInstId="+classInstId+"&stageId="+stageId+"&classType="+classType+"&studentCourseId="+studentCourseId;
		}
	});
	
	//将学员添加到班级中
	$("#addStudentCourseSubmit").click(function() {
		var obj = $('#list_data').datagrid('getSelections');
		if(obj.length > 0) {
			var param = "[";
			var className = $("#className").val();
			var classInstId = $("#classInstId").val();
			var handlerId = $("#handlerId").val();
			for(var i = 0, n = obj.length; i < n; i++) {
				var studentCourseId = obj[i].studentCourseId;
				var studentId = obj[i].studentId;
				var feeType = obj[i].feeType;
				var studentChannelType = "";
				if("002" == feeType) {
					studentChannelType += obj[i].oldClassName;
				}
				studentChannelType += obj[i].feeTypeText;
				param += "{classInstId:\""+classInstId+"\",className:\""+className+"\",studentId:\""+studentId+"\",studentCourseId:\""+studentCourseId+"\",studentChannelType:\""+studentChannelType+"\",handlerId:\""+handlerId+"\"},";
			}
			param = param.substring(0, param.length - 1) + "]";
			$.ajax({
				url: "/sys/applyClass/addClassStudent.do",
				data: "param=" + param,
				dataType: "json",
				async: false,
				beforeSend: function()
				{
					$.messager.progress({title : '添加学员', msg : '正在添加学员，请稍等……'});
				},
				success: function (data) {
					$.messager.progress('close'); 
					var flag = data.flag
					if(flag) {
						$.messager.alert('提示', "添加学员成功！", "info", function() {window.location.reload();});
					} else {
						$.messager.alert('提示', data.msg);
					}
				}
			});
		} else {
			$.messager.alert('提示', "请先选择您要添加的学员！");
		}
	});
	
	//带班老师的学校
	$("#teacherSchoolId").combobox({
		onChange : function(n, o) {
			var classType = $("#classType").html();
			$("#teacherId").combobox({
				url : "/sys/pubData/qryTeacherList.do?schoolId=" + n + "&classType=" + classType,
				valueField : "teacherId",
        		textField : "byname",
        		panelHeight : "auto"
			});
			$("#licenseFlagText").html("");
			$("#lessions").numberbox("setValue", "");
		}
	});

	$("#teacherId").combobox({
		onChange : function(n, o) {
			var weekTime = null;
			var hourRange = null;
			selTr.find("td").each(function(i, node) {
				if(i == 0) {
					weekTime = $(node).attr("weekTime");
					hourRange = $(node).attr("hourRange");
				}
			});
			var flag = validateTeacher(n, weekTime, hourRange);
			if(flag) {
				var data = $('#teacherId').combobox('getData');
				$.each(data, function(i, obj){
					if(n == obj.teacherId) {
						var licenseFlag = obj.licenseFlag;
						var licenseFlagText = "未持证";
						if("Y" == licenseFlag) {
							licenseFlagText = "持证";
						}
						$("#licenseFlagText").html(licenseFlagText);
					}
				});
			} else {
				var teacherName = $("#teacherId").combobox("getText");
				$.messager.alert('提示', "您选择的老师"+teacherName+"在同一上课时段已带班其他班级，请选择其他老师！", "info", function() {$("#teacherId").combobox("setValue", ""); $("#licenseFlagText").html("");});
			}
		}
	});
	
	//点击提交老师
	$("#addTeacherSubmit").click(function() {
		if($("#addTeacherFm").form('validate')) {
			var lessionHours = null;
			var addLessions = null;
			var weekTime = null;
			var hourRange = null;
			selTr.find("td").each(function(i, node) {
				if(i == 0) {
					lessionHours = $(node).attr("lessionHours");
					weekTime = $(node).attr("weekTime");
					hourRange = $(node).attr("hourRange");
				} else if(i == 4) {
					addLessions = $(node).attr("lessions");
					if(addLessions == null || addLessions == "" || addLessions == undefined) {
						addLessions = 0;
					}
				}
			});
			var teacherId = $("#teacherId").combobox("getValue");
			var flag = true;
			if($("[name='teachers']").length > 0) {
				$("[name='teachers']").each(function() {
					var selTeacherId = $(this).attr("teacherId");
					var teacherWeekTime = $(this).attr("weekTime");
					var teacherHourRange = $(this).attr("hourRange");
					if(teacherId == selTeacherId && weekTime == teacherWeekTime && hourRange == teacherHourRange) {
						flag = false;
					}
				});
			}
			if(flag) {
				var subLessions = parseInt(lessionHours) - parseInt(addLessions);
				var lessions = $("#lessions").numberbox("getValue");
				if(parseInt(lessions) > subLessions) {
					flag = false;
				}
				if(flag) {
					var teacherSchoolName = $("#teacherSchoolId").combobox("getText");
					var teacherName = $("#teacherId").combobox("getText");
					var licenseFlagText = $("#licenseFlagText").html();
					selTr.find("td").each(function(i, node) {
						if(i == 4) {
							var content = $(node).html();
							var teacherHtml = document.getElementById("teacher" + teacherId + weekTime + hourRange);
							if(teacherHtml == null || teacherHtml == "" || teacherHtml == undefined || teacherHtml == "null") {
								content += "<span id=teacher"+ teacherId + weekTime + hourRange +">";
								var teacherText = teacherSchoolName + " " + teacherName + " " + lessions + " " + licenseFlagText;
								content += teacherText + "&nbsp;<a href='javascript:void(0)' class='linkmore' onclick='deleteTeacher(this, "+teacherId+")'><span>删除</span></a>";
								content += "<input type='hidden' name='teachers' teacherId='"+teacherId+"' weekTime='"+weekTime+"' hourRange='"+hourRange+"' lessions='"+lessions+"' addFlag='Y'/>&nbsp;</span>";
								$(node).html(content);
							} else {
								var teacherText = teacherSchoolName + " " + teacherName + " " + lessions + " " + licenseFlagText;
								var html = teacherText + "&nbsp;<a href='javascript:void(0)' class='linkmore' onclick='deleteTeacher(this, "+teacherId+")'><span>删除</span></a>";
								html += "<input type='hidden' name='teachers' teacherId='"+teacherId+"' weekTime='"+weekTime+"' hourRange='"+hourRange+"' lessions='"+lessions+"' addFlag='Y'/>&nbsp;";
								$("#teacher" + teacherId + weekTime + hourRange).html(html);
							}
							$(node).attr("lessions", parseInt(lessions) + parseInt(addLessions));
						}
					});
					$('#dlg').dialog('close');
				} else {
					$.messager.alert('提示', "该上课时段可用的课时为"+subLessions+"个课时，请填写的课时小于或者等于"+subLessions+"！");
				}
			} else {
				$.messager.alert('提示', "该上课时段已经添加该带班老师，请选择另一个老师！");
			}
		}
	});
	
	if($("[name='roomId']").length > 0) {
		$("[name='roomId']").each(function(i, obj) {
			var id = "#roomId" + (i + 1);
			$(id).combobox({
				onChange : function(n, o) {
					var changeWeekTime = $(id).attr("weekTime");
					var changeHourRange = $(id).attr("hourRange");
					$("[name='schooltimes']").each(function() {
						if ($(this).attr("weekTime") == changeWeekTime && $(this).attr("hourRange") == changeHourRange) {
							$(this).attr("roomId", n);
						}
					});
				}
			});
		});
	}
	
	//班级维护
	$("#updateApplyClassSubmit").click(function() {
		if($("#updateApplyClassFm").form('validate')) {
			var flag = true;
			if($("[name='teachers']").length > 0) {
				var addNum = "";
				$("[name='schooltimes']").each(function() {
					var teacherNum = 0;
					var weekTime = $(this).attr("weekTime");
					var hourRange = $(this).attr("hourRange");
					$("[name='teachers']").each(function() {
						var teacherWeekTime = $(this).attr("weekTime");
						var teacherHourRange = $(this).attr("hourRange");
						if(weekTime == teacherWeekTime && hourRange == teacherHourRange) {
							teacherNum++;
						}
					});
					if(teacherNum == 0) {
						flag = false;
						addNum = $(this).attr("addNum");
					}
				});
				if(flag) {
					var addNum = "";
					var hours = 0;
					var teacherHours = 0;
					$("[name='schooltimes']").each(function() {
						var weekTime = $(this).attr("weekTime");
						var hourRange = $(this).attr("hourRange");
						var lessionHours = parseInt($(this).attr("lessionHours"));
						var totalLessions = 0;
						$("[name='teachers']").each(function() {
							var teacherWeekTime = $(this).attr("weekTime");
							var teacherHourRange = $(this).attr("hourRange");
							if(weekTime == teacherWeekTime && hourRange == teacherHourRange) {
								totalLessions += parseInt($(this).attr("lessions"));
							}
						});
						if(totalLessions < lessionHours) {
							flag = false;
							addNum = $(this).attr("addNum");
							hours = lessionHours;
							teacherHours = totalLessions;
						}
					});
					if(flag) {
						updateApplyClass();
					} else {
						$.messager.alert('提示', "上课时段"+addNum+"的总课时量为"+hours+"，您选择的所有带班老师的总课时量为"+teacherHours+"，请保持课时量相等！");
					}
				} else {
					$.messager.alert('提示', "请至少为上课时段"+addNum+"添加一位带班老师！");
				}
			} else {
				$.messager.alert('提示', "请至少为每个上课时段添加一位带班老师！");
			}
		}
	});
});

function updateApplyClass() {
	var schooltimeArray = "[";
	$("[name='schooltimes']").each(function() {
		var roomId = $(this).attr("roomId");
		var lessionHours = $(this).attr("lessionHours");
		var schooltimeId = $(this).attr("schooltimeId");
		var weekTime = $(this).attr("weekTime");
		var hourRange = $(this).attr("hourRange");
		schooltimeArray += "{schooltimeId:\""+schooltimeId+"\",roomId:\""+roomId+"\",lessionHours:\""+lessionHours+"\",";
		schooltimeArray += "classTeacherArray:[";
		var flag = false;
		$("[name='teachers']").each(function() {
			var teacherWeekTime = $(this).attr("weekTime");
			var teacherHourRange = $(this).attr("hourRange");
			var addFlag = $(this).attr("addFlag");
			if(weekTime == teacherWeekTime && hourRange == teacherHourRange && "Y" == addFlag) {
				flag = true;
				var teacherId = $(this).attr("teacherId");
				var lessions = $(this).attr("lessions");
				schooltimeArray += "{teacherId:\""+teacherId+"\",teacherType:\"T\",lessions:\""+lessions+"\"},";
			}
		});
		if(flag)
		{
			schooltimeArray = schooltimeArray.substring(0, schooltimeArray.length - 1);
		}
		schooltimeArray += "]},";
	});
	schooltimeArray = schooltimeArray.substring(0, schooltimeArray.length - 1) + "]";
	if(classTeacherId != "" && classTeacherId != null && classTeacherId != undefined) {
		classTeacherId = classTeacherId.substring(0, classTeacherId.length - 1);
		$("#classTeacherId").val(classTeacherId);
	}
	var obj = JSON.stringify($("#updateApplyClassFm").serializeObject());
	obj = obj.substring(0, obj.length - 1) + ",schooltimeArray:"+schooltimeArray+"}";
	$.ajax({
		url: "/sys/applyClass/updateCreateClass.do",
		data: "param=" + obj,
		dataType: "json",
		async: false,
		beforeSend: function()
		{
			$.messager.progress({title : '班级维护', msg : '正在维护班级信息，请稍等……'});
		},
		success: function (data) {
			$.messager.progress('close'); 
			var flag = data.flag;
			if(flag) {
				$.messager.alert('提示', "班级维护成功！", "info", function() {window.location.reload();});
			} else {
				$.messager.alert('提示', data.msg);
			}
		} 
	});
}

function validateSelect()
{
	var flag = false;
	var obj = $('#list_data').datagrid('getSelections');
	if(obj.length > 0) {
		if(obj.length > 1) {
			$.messager.alert('提示', "只能选择一个学员进行操作！");
		} else {
			flag = true;
		}
	} else {
		$.messager.alert('提示', "请先选择您要操作的学员！");
	}
	return flag;
}

//添加代班老师
function addTeacher(obj) {
	$("#dlg").dialog('open').dialog('setTitle', '添加老师');//设定表头  
	$('#addTeacherFm').form('clear');//清空窗体数据  
	$("#licenseFlagText").html("");
	selTr = $(obj).parent().parent();
}

function deleteTeacher(obj, teacherId)
{
	var lessions = null;
	var weekTime = null;
	var hourRange = null;
	var delTr = $(obj).parent().parent().parent();
	delTr.find("td").each(function(i, node) {
		if(i == 0) {
			weekTime = $(node).attr("weekTime");
			hourRange = $(node).attr("hourRange");
		}
	});
	if($("[name='teachers']").length > 0) {
		$("[name='teachers']").each(function() {
			var selTeacherId = $(this).attr("teacherId");
			var selWeekTime = $(this).attr("weekTime");
			var selHourRange = $(this).attr("hourRange");
			if(teacherId == selTeacherId && weekTime == selWeekTime && hourRange == selHourRange) {
				lessions = $(this).attr("lessions");
				classTeacherId += $(this).attr("classTeacherId") + ",";
			}
		});
	}
	delTr.find("td").each(function(i, node) {
		if(i == 4) {
			var lession = $(node).attr("lessions");
			$(node).attr("lessions", parseInt(lession) - parseInt(lessions));
		}
	});
	$("#teacher" + teacherId + weekTime + hourRange).html("");
}