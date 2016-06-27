var td = 1;
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
				if(o != null && o != "" && o != undefined && n != roomId) {
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
	$("#selectClass").click(function() {
		var maxNum = $("#maxNum").val();
		var rows = $('#list_data').datagrid("getRows"); 
		var className = $("#className").html();
		var rowNum = 0;
		if (rows == undefined || rows == null) {
			rowNum = 0;
		} else {
			rowNum = rows.length;
		}
		if(parseInt(rowNum) < parseInt(maxNum)) {
			var sub = parseInt(maxNum) - parseInt(rowNum);
			$.messager.confirm('提示', className + "已有" + rowNum + "名学员，您还可以为该班级添加" + sub + "名学员", function(r) {
				var stageId = $("#stageId").html();
				var schoolId = $("#schoolId").val();
				var classType = $("#classType").html();
				var funcNodeId = $("#funcNodeId").val();
				var classInstId = $("#classInstId").val();
				window.location.href = "/sys/applyClass/studentCourseList.jsp?stageId="+stageId+"&classType="+classType+"&schoolId="+schoolId+"&className="+className+"&classInstId="+classInstId+"&funcNodeId="+funcNodeId;
			});
		} else {
			$.messager.alert('提示', className + "已经满员，不能再为该班级添加学员！");
		}
	});
	
	$("#removeStudent").click(function() {
		var obj = $('#list_data').datagrid('getSelections');
		if(obj.length > 0) {
			$.messager.confirm('提示','您确定要移除当前选中的学员吗?',function(r) {
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
						async: true,
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
			var classState = $("#classState").val();
			var studentCourseId = row.studentCourseId;
			window.location.href = "/sys/applyClass/changeClass.jsp?studentId="+studentId+"&classInstId="+classInstId+"&stageId="+stageId+"&classType="+classType+"&studentCourseId="+studentCourseId+"&classState="+classState;
		}
	});
	
	//浏览
	$("#view").click(function() {
		if(validateSelect()) {
			var row = $('#list_data').datagrid('getSelected');
			var studentId = row.studentId;
			window.location.href = "/sys/view.jsp?studentId="+studentId+"&title=基础信息";
		}
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
	
	//点击提交老师
	$("#addTeacherSubmit").click(function() {
		if($("#addTeacherFm").form('validate')) {
			var lessionHours = 0;
			var addLessions = 0;
			var weekTime = null;
			var hourRange = null;
			selTr.find("td").each(function(i, node) {
				if(i == 0) {
					lessionHours = parseInt($(node).attr("lessionHours"));
					weekTime = $(node).attr("weekTime");
					hourRange = $(node).attr("hourRange");
				} else if(i == 4) {
					var lessions = $(node).attr("lessions");
					if(lessions != null && lessions != "" && lessions != undefined) {
						addLessions = parseInt(lessions);
					}
				}
			});
			var flag = true;
			var teacherId = $("#teacherId").combobox("getValue");
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
	
//	if($("[name='roomId']").length > 0) {
//		$("[name='roomId']").each(function(i, obj) {
//			var id = "#roomId" + (i + 1);
//			$(id).combobox({
//				url : "/sys/pubData/qryRoomList.do?schoolId="+$("#schoolId").val(),//返回json数据的url
//		    	valueField : "roomId",
//		    	textField : "roomName",
//		    	panelHeight : "auto",
//		    	formatter : function(data) {
//		    		return "<span>" + data.roomName + "</span>";
//		    	},
//		    	onLoadSuccess : function () { //数据加载完毕事件
//		            var data = $(id).combobox('getData');
//		            if (data.length > 0) {
//		                $(id).combobox('select', data[0].roomId);
//		            }
//		        },
//				onChange : function(n, o) {
//					var changeWeekTime = $(id).attr("weekTime");
//					var changeHourRange = $(id).attr("hourRange");
//					$("[name='schooltimes']").each(function() {
//						if ($(this).attr("weekTime") == changeWeekTime && $(this).attr("hourRange") == changeHourRange) {
//							$(this).attr("roomId", n);
//						}
//					});
//				}
//			});
//		});
//	}
	
	//班级维护
	$("#updateApplyClassSubmit").click(function() {
		if($("#updateApplyClassFm").form('validate')) {
			if($("[name='schooltimes']").length > 0) {
				var flag = true;
				var addNum = "";
				var flags = true;
				if($("[name='teachers']").length > 0) {
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
				} else {
					//待开课班级必须要有老师
					var classState = $("#classState").val();
					if(classState == "002") {
						flags = false;
					}
				}
				if(flags) {
					if(flag) {
						if($("[name='teachers']").length > 0) {
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
						}
						if(flag) {
							updateApplyClass();
						} else {
							$.messager.alert('提示', "上课时段"+addNum+"的总课时量为"+hours+"，您选择的所有带班老师的总课时量为"+teacherHours+"，请保持课时量相等！");
						}
					} else {
						$.messager.alert('提示', "请至少为上课时段"+addNum+"添加一位带班老师！");
					}
				} else {
					$.messager.alert('提示', "待开课的班级每个上课时段都需要有带班老师！");
				}
			} else {
				$.messager.alert('提示', "请至少添加一个上课时段！");
			}
		}
	});
});

function updateApplyClass() {
	var schooltimeArray = "[";
	$("[name='schooltimes']").each(function() {
		var schooltimeId = $(this).attr("schooltimeId");
		var roomId = $("#roomId" + schooltimeId).combobox("getValue");
		var lessionHours = $(this).attr("lessionHours");
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
				var lessions = $(this).attr("lessions");
				var teacherId = $(this).attr("teacherId");
				var teacherSchoolId = $(this).attr("schoolId");
				schooltimeArray += "{teacherId:\""+teacherId+"\",teacherType:\"T\",lessions:\""+lessions+"\",schoolId:\""+teacherSchoolId+"\"},";
			}
		});
		if(flag) {
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
	obj = encodeURI(obj);
	$.ajax({
		url: "/sys/applyClass/updateCreateClass.do",
		data: "param=" + obj,
		dataType: "json",
		async: true,
		beforeSend: function()
		{
			$.messager.progress({title : '班级维护', msg : '正在维护班级信息，请稍等……'});
		},
		success: function (data) {
			$.messager.progress('close'); 
			var flag = data.flag;
			if(flag) {
				$.messager.alert('提示', "班级维护成功！", "info", function() {window.history.back();});
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