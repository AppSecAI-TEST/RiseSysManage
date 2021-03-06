var selTr = null;
var classTeacherId = "";
$(document).ready(function() {
	$("[name='schooltimes']").each(function() {
		var roomId = $(this).attr("roomId");
		var weekTime = $(this).attr("weekTime");
		var hourRange = $(this).attr("hourRange");
		var schooltimeId = $(this).attr("schooltimeId");
		$("#roomId" + schooltimeId).combobox({
			onChange : function(n, o) {
				if(o != null && o != "" && o != undefined && roomId != n) {
					var subHourRange = hourRange.substring(0, 3);
					var flag = validateRoom(weekTime, hourRange, n, schooltimeId, "N");
					if(!flag) {
						$("#roomId" + schooltimeId).combobox("setValue", o);
						$.messager.alert('提示', "您选择的上课时段和教室已被其他班级占用，请选择其他上课时段或教室！");
						return false;
					}
				}
			}
		});
	});
	
	//带班老师的学校
	$("#teacherSchoolId").combobox({
		url : "/sys/pubData/qrySchoolListWithTS.do",//返回json数据的url
    	valueField : "schoolId",
    	textField : "schoolName",
    	panelHeight : "auto",
    	formatter : function(data) {
    		return "<span>" + data.schoolName + "</span>";
    	},
    	onLoadSuccess : function () { //数据加载完毕事件
            var data = $('#teacherSchoolId').combobox('getData');
            if (data.length > 0) {
                $("#teacherSchoolId").combobox('select', data[0].schoolId);
            }
        },
		onChange : function(n, o) {
			var stageId = $("#stageId").html();
			$("#teacherId").combobox({
				url : "/sys/pubData/qryOnJobTeacherList.do?schoolId=" + n + "&stageId=" + stageId,
				valueField : "teacherId",
        		textField : "byname",
        		panelHeight : "auto",
        		formatter : function(data) {
            		return "<span>" + data.byname + "</span>";
            	}
			});
			$("#licenseFlagText").html("");
			$("#lessions").numberbox("setValue", "");
		}
	});

	$("#teacherId").combobox({
		onChange : function(n, o) {
			if(n != null && n != "" && n != undefined) {
				var weekTime = null;
				var hourRange = null;
				selTr.find("td").each(function(i, node) {
					if(i == 0) {
						weekTime = $(node).attr("weekTime");
						hourRange = $(node).attr("hourRange");
					}
				});
				var classInstId = $("#classInstId").val();
				var flag = validateTeacher(n, weekTime, hourRange, classInstId);
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
		}
	});
	
	var channel = $("#channel").val();
	if(channel != "" && channel != null && channel != "null" && channel != undefined && channel == "index") {
		$("#backBtn").css("display", "none");
		$("#closeBtn").css("display", "inline-block");
	}
	
	//关闭按钮
	$("#closeBtn").click(function() {
		var title = "开班管理";
		parent.closeUrl(title);
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
				var teacherNum = 1;
				var s = "," + teacherId + ",";
				if($("[name='teachers']").length > 0) {
					$("[name='teachers']").each(function() {
						var selTeacherId = $(this).attr("teacherId");
						if(teacherId != selTeacherId && s.indexOf("," + selTeacherId + ",") < 0) {
							teacherNum++;
							s += selTeacherId + ",";
						}
					});
				}
				if(teacherNum > 2) {
					flag = false;
				}
				if(flag) {
					var lessions = $("#lessions").numberbox("getValue");
					var subLessions = parseInt(lessionHours) - parseInt(addLessions);
					if(parseInt(lessions) != subLessions) {
						flag = false;
					}
					if(flag) {
						var teacherSchoolId = $("#teacherSchoolId").combobox("getValue");
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
									content += "<input type='hidden' name='teachers' schoolId='"+teacherSchoolId+"' teacherId='"+teacherId+"' weekTime='"+weekTime+"' hourRange='"+hourRange+"' lessions='"+lessions+"' addFlag='Y'/>&nbsp;</span>";
									$(node).html(content);
								} else {
									var teacherText = teacherSchoolName + " " + teacherName + " " + lessions + " " + licenseFlagText;
									var html = teacherText + "&nbsp;<a href='javascript:void(0)' class='linkmore' onclick='deleteTeacher(this, "+teacherId+")'><span>删除</span></a>";
									html += "<input type='hidden' name='teachers' schoolId='"+teacherSchoolId+"' teacherId='"+teacherId+"' weekTime='"+weekTime+"' hourRange='"+hourRange+"' lessions='"+lessions+"' addFlag='Y'/>&nbsp;";
									$("#teacher" + teacherId + weekTime + hourRange).html(html);
								}
								$(node).attr("lessions", parseInt(lessions) + parseInt(addLessions));
							}
						});
						$('#dlg').dialog('close');
					} else {
						$.messager.alert('提示', "该上课时段可用的课时为"+subLessions+"个课时，请填写的课时为"+subLessions+"！");
					}
				} else {
					$.messager.alert('提示', "一个班级最多只允许有2个带班老师！");
				}
			} else {
				$.messager.alert('提示', "该上课时段已经添加该带班老师，请选择另一个老师！");
			}
		}
	});
	
	//提交开班申请
	$("#openClassSubmit").click(function() {
		var rows = $('#list_data').datagrid("getRows"); 
		$("#openClassNum").val(rows.length);
		if($("#openClassFm").form('validate')) {
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
						openClass();
					} else {
						$.messager.alert('提示', "上课时段"+addNum+"的总课时量为"+hours+"，您选择的所有带班老师的总课时量为"+teacherHours+"，请保持课时量相等！");
					}
				} else {
					$.messager.alert('提示', "请为上课时段"+addNum+"添加一位带班老师！");
				}
			} else {
				$.messager.alert('提示', "请为每个上课时段各添加一位带班老师！");
			}
		}
	});
	
	//修改开班时间
	$("#updateStartDateSubmit").click(function() {
		if($("#openFm").form('validate')) {
			var startDate = $("#startDate").datebox("getValue");
			var oldStartDate = $("#oldStartDate").val();
			if(startDate != oldStartDate) {
				updateOrCancel();
			} else {
				$.messager.alert('提示', "请您修改开课时间！");
			}
		}
	});
	
	//取消开班
	$("#cancelOpenSubmit").click(function() {
		if($("#openFm").form('validate')) {
			updateOrCancel();
		}
	});
	
	//开班审批
	$("#approveSubmit").click(function() {
		var approveType = $('input:radio[name="approveType"]:checked').val();
		if(approveType == "" || approveType == null || approveType == undefined || approveType == "null") {
			$.messager.alert('提示', "请选择是否审批通过！");
		} else {
			if($("#approveOpenFm").form('validate')) {
				var object = $("#approveOpenFm").serializeObject();
				var remark = object.remark;
				remark = string2Json(remark);
				object.remark = remark;
				var obj = JSON.stringify(object);
				obj = encodeURI(obj);
				$.ajax({
					url: "/sys/openClass/approveOpenClass.do",
					data: "param=" + obj,
					dataType: "json",
					async: true,
					beforeSend: function() {
						$.messager.progress({title : '开班审批', msg : '正在审批开班，请稍等……'});
					},
					success: function (data) {
						$.messager.progress('close'); 
						var flag = data.flag;
						if(flag) {
							$.messager.alert('提示', "开班审批成功！", "info", function() {close();});
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
		var title = "开班管理";
		parent.closeUrl(title);
	} else {
		window.history.back();
	}
}

//修改开课时间或者是取消放班
function updateOrCancel() {
	var object = $("#openFm").serializeObject();
	var remark = object.remark;
	remark = string2Json(remark);
	object.remark = remark;
	var obj = JSON.stringify(object);
	obj = encodeURI(obj);
	var optionType = $("#optionType").val();
	$.ajax({
		url: "/sys/openClass/updateOrCancel.do",
		data: "param=" + obj,
		dataType: "json",
		async: true,
		beforeSend: function() {
			if(optionType == "CANCEL_OPEN") {
				$.messager.progress({title : '取消开班', msg : '正在取消开班，请稍等……'});
			} else {
				$.messager.progress({title : '修改开课时间', msg : '正在修改开课时间，请稍等……'});
			}
		},
		success: function (data) {
			$.messager.progress('close'); 
			var flag = data.flag;
			if(flag) {
				if(optionType == "CANCEL_OPEN") {
					$.messager.alert('提示', "取消开班成功！", "info", function() {window.history.back();});
				} else {
					$.messager.alert('提示', "修改开课时间成功,请重新排课", "info", function() {window.history.back();});
				}
			} else {
				$.messager.alert('提示', data.msg);
			}
		} 
	});
}

function openClass() {
	var schooltimeArray = "[";
	var classTeacherArray = "[";
	$("[name='schooltimes']").each(function() {
		var schooltimeId = $(this).attr("schooltimeId");
		var oldRoomId = $(this).attr("roomId");
		var roomId = $("#roomId" + schooltimeId).combobox("getValue");
		if(oldRoomId != roomId) {
			schooltimeArray += "{schooltimeId:\""+schooltimeId+"\",roomId:\""+roomId+"\"},";
		}
		var weekTime = $(this).attr("weekTime");
		var hourRange = $(this).attr("hourRange");
		var flag = false;
		$("[name='teachers']").each(function() {
			var teacherWeekTime = $(this).attr("weekTime");
			var teacherHourRange = $(this).attr("hourRange");
			var addFlag = $(this).attr("addFlag");
			if(weekTime == teacherWeekTime && hourRange == teacherHourRange && "Y" == addFlag) {
				flag = true;
				var lessions = $(this).attr("lessions");
				var teacherId = $(this).attr("teacherId");
				var teacherSchoolId = $(this).attr("schoolId");
				classTeacherArray += "{schooltimeId:\""+schooltimeId+"\",teacherId:\""+teacherId+"\",teacherType:\"T\",lessions:\""+lessions+"\",schoolId:\""+teacherSchoolId+"\"},";
			}
		});
	});
	if(classTeacherArray != "[" && classTeacherArray.endWith(",")) {
		classTeacherArray = classTeacherArray.substring(0, classTeacherArray.length - 1);
	}
	classTeacherArray += "]";
	if(schooltimeArray != "[" && schooltimeArray.endWith(",")) {
		schooltimeArray = schooltimeArray.substring(0, schooltimeArray.length - 1);
	}
	schooltimeArray += "]";
	if(classTeacherId != "" && classTeacherId != null && classTeacherId != undefined) {
		classTeacherId = classTeacherId.substring(0, classTeacherId.length - 1);
		$("#classTeacherId").val(classTeacherId);
	}
	var object = $("#openClassFm").serializeObject();
	var remark = object.remark;
	remark = string2Json(remark);
	object.remark = remark;
	var obj = JSON.stringify(object);
	obj = obj.substring(0, obj.length - 1) + ",classTeacherArray:"+classTeacherArray+",schooltimeArray:"+schooltimeArray+"}";
	obj = encodeURI(obj);
	$.ajax({
		url: "/sys/openClass/applyOpenClass.do",
		data: "param=" + obj,
		dataType: "json",
		async: true,
		beforeSend: function() {
			$.messager.progress({title : '申请开班', msg : '正在申请开班，请稍等……'});
		},
		success: function (data) {
			$.messager.progress('close'); 
			var flag = data.flag;
			if(flag) {
				var msg = "申请开班成功！";
				var openClassType = $("#openClassType").val();
				if("E" == openClassType) {
					msg = "申请开班成功，异常开班扣款500元！";
				}
				$.messager.alert('提示', msg, "info", function() {window.history.back();});
			} else {
				$.messager.alert('提示', data.msg);
			}
		},
		error: function (data) {
			alert(data)
			alert(data.status);
		}
	});
}

//添加代班老师
function addTeacher(obj) {
	var content = "";
	var tr = $(obj).parent().parent();
	tr.find("td").each(function(i, node) {
		if(i == 4) {
			content = $(node).html();
		}
	});
	if(content == "" || content == null || content == undefined) {
		$("#dlg").dialog('open').dialog('setTitle', '添加老师');//设定表头  
		$('#addTeacherFm').form('clear');//清空窗体数据  
		$("#licenseFlagText").html("");
		selTr = $(obj).parent().parent();
	} else {
		$.messager.alert('提示', "一个上课时段只允许一位老师带班！");
	}
}

function deleteTeacher(obj, teacherId)
{
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
				classTeacherId += $(this).attr("classTeacherId") + ",";
			}
		});
	}
	delTr.find("td").each(function(i, node) {
		if(i == 4) {
			$(node).html("");
			$(node).attr("lessions", 0);
		}
	});
	$("#teacher" + teacherId + weekTime + hourRange).html("");
}
