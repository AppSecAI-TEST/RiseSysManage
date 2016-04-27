var selTr = null;
var delSchooltimeId = "";
var delClassTeacherId = "";
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
					var flag = validateRoom(weekTime, hourRange, n, schooltimeId);
					if(!flag) {
						$("#roomId" + schooltimeId).combobox("setValue", o);
						$.messager.alert('提示', "您选择的上课时段和教室已被其他班级占用，请选择其他上课时段或教室！");
						return false;
					}
				}
			}
		});
	});
	
	//批量加载上课的周
	$("[name='classInstId']").each(function() {
		var classInstId = $(this).val();
		//选择上课时段周标识
		$("#weekTime" + classInstId).combobox({
			url : "/sys/pubData/qryCodeNameList.do?tableName=SCHOOLTIME_T&codeType=WEEK_TIME",//返回json数据的url
	    	valueField : "codeFlag",
	    	textField : "codeName",
	    	panelHeight : "auto",
	    	editable : false,
	    	formatter : function(data) {
	    		return "<span>" + data.codeName + "</span>";
	    	},
			onChange : function(n, o) {
				if(n != null && n != "" && n != undefined) {
					$("#hourRange" + classInstId).combobox({
						url : "/sys/pubData/qryHourRangeList.do?weekTime=" + n,//返回json数据的url
						valueField : "hourRange",
						textField : "timeName",
						panelHeight : "auto",
						editable : false,
						formatter : function(data) {
							return "<span>" + data.timeName + "</span>";
						}
					});
				}
			}
		});
		
		//添加上课时段
		$("#addHourRange" + classInstId).click(function() {
			if(!checkHourRange(classInstId)) {
				return;
			} else {
				var weekTime = $("#weekTime" + classInstId).combobox("getValue");
				var roomId = $("#roomId" + classInstId).combobox("getValue");
				var hourRange = $("#hourRange" + classInstId).combobox("getValue");
				var weekTimeText = $("#weekTime" + classInstId).combobox("getText");
				var hourRangeText = $("#hourRange" + classInstId).combobox("getText");
				var roomIdText = $("#roomId" + classInstId).combobox("getText");
				var hourRangeData = $('#hourRange' + classInstId).combobox('getData');
				var lessionHours = "";
				$.each(hourRangeData, function(i, obj) {
					if(hourRange == obj.hourRange) {
						lessionHours = obj.lessionHours;
					}
				});
				var flag = true;
				if($("[name='schooltimes']").length > 0) {
					$("[name='schooltimes']").each(function() {
						var selWeekTime = $(this).attr("weekTime");
						var selHourRange = $(this).attr("hourRange");
						var selClassInstId = $(this).attr("classInstId");
						if(selWeekTime == weekTime && selHourRange == hourRange && selClassInstId == classInstId) {
							flag = false;
						}
					});
				}
				if(flag) {
					flag = validateRoom(weekTime, hourRange, roomId, "");
					if(flag) {
						var hourRanges = "";
						if($("[name='schooltimes']").length > 0) {
							$("[name='schooltimes']").each(function() {
								var selWeekTime = $(this).attr("weekTime");
								var selClassInstId = $(this).attr("classInstId");
								if(selWeekTime == weekTime && selClassInstId == classInstId) {
									hourRanges += "'" + $(this).attr("hourRange") + "',";
								}
							});
						}
						if(hourRanges != null && hourRanges != "" && hourRanges != undefined) {
							hourRanges = hourRanges.substring(0, hourRanges.length - 1);
							flag = validateHourRange(hourRangeText, hourRanges);
						}
						if(flag) {
							var addSchoolNum = $("#addSchoolNum" + classInstId).val();
							addSchoolNum++;
							$("#addSchoolNum" + classInstId).val(addSchoolNum);
							var addSchootimeTd = $("#addSchootimeTd" + classInstId).clone();
							addSchootimeTd.css("display", 'table-row');
							addSchootimeTd.attr("val", "add");
							addSchootimeTd.find("td").each(function(i, node) {
								if(i == 0) {
									$(node).html("<span>" + addSchoolNum + "</span>");
									$(node).attr("lessionHours", lessionHours);
									$(node).attr("weekTime", weekTime);
									$(node).attr("hourRange", hourRange);
									$(node).attr("classInstId", classInstId);
									$(node).attr("index", addSchoolNum);
									$(node).attr("addFlag", "Y");
									$(node).attr("schooltimeName", weekTimeText + "  " + hourRangeText);
								} else if(i == 1) {
									$(node).html("<span>" + weekTimeText + "  " + hourRangeText + "</span>");
								} else if(i == 2) {
									$(node).html("<span>" + roomIdText + "</span>");
								} else if(i == 3) {
									$(node).html("<span>" + lessionHours + "</span><input type='hidden' name='schooltimes' roomId='"+roomId+"' weekTime='"+weekTime+"' " + 
											"hourRange='"+hourRange+"' lessionHours='"+lessionHours+"' addNum='"+addSchoolNum+"' classInstId='"+classInstId+"' index='"+addSchoolNum+"' addFlag='Y' schooltimeName='"+weekTimeText + "  " + hourRangeText+"'/>");
								}
							});
							$("#schooltimeTb" + classInstId).append(addSchootimeTd);
							$("#roomId" + classInstId).combobox("setValue", "");
							$("#weekTime" + classInstId).combobox("setValue", "");
							$("#hourRange" + classInstId).combobox('clear');
							$("#hourRange" + classInstId).combobox("loadData", new Array());
						} else {
							$.messager.alert('提示', "您选择的上课时段有重叠时间，请选择其他上课时段！");
						}
					} else {
						$.messager.alert('提示', "您选择的上课时段和教室已被其他班级占用，请选择其他上课时段或教室！");
					}
				} else {
					$.messager.alert('提示', "该上课时段已经添加，请选择另一个上课时段！");
				}
			}
		});
		
		//查看排期课
		$("#view" + classInstId).click(function() {
			var schoolId = $("#schoolId" + classInstId).val();
			parent.openUrl(10000 , '/sys/time/planRoom.jsp?schoolId=' + schoolId , '排期表');
		});
	});
	
	//带班老师的学校
	$("#teacherSchoolId").combobox({
		url : "/sys/pubData/qrySchoolListWithTS.do",//返回json数据的url
    	valueField : "schoolId",
    	textField : "schoolName",
    	panelHeight : "auto",
    	editable : false,
    	formatter : function(data) {
    		return "<span>" + data.schoolName + "</span>";
    	},
		onChange : function(n, o) {
			var classInstId = $("#selClassInstId").val();
			var stageId = $("#stageId" + classInstId).val();
			$("#teacherId").combobox({
				url : "/sys/pubData/qryOnJobTeacherList.do?schoolId=" + n + "&stageId=" + stageId,
				valueField : "teacherId",
        		textField : "byname",
        		panelHeight : "auto",
        		editable : false,
        		formatter : function(data) {
        			return "<span>" + data.byname + "</span>";
        		},
                onChange : function(n, o) {
        			var weekTime = null;
        			var hourRange = null;
        			selTr.find("td").each(function(i, node) {
        				if(i == 0) {
        					weekTime = $(node).attr("weekTime");
        					hourRange = $(node).attr("hourRange");
        				}
        			});
        			var flag = validateTeacher(n, weekTime, hourRange, "");
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
			$("#licenseFlagText").html("");
			$("#lessions").numberbox("setValue", "");
		}
	});
	
	//点击提交老师
	$("#addTeacherSubmit").click(function() {
		if($("#addTeacherFm").form('validate')) {
			var lessionHours = null;
			var addLessions = null;
			var weekTime = null;
			var hourRange = null;
			var classInstId = $("#selClassInstId").val();
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
			var flag = true;
			var teacherId = $("#teacherId").combobox("getValue");
			if($("input[name='teachers']").length > 0) {
				$("input[name='teachers']").each(function() {
					var selTeacherId = $(this).attr("teacherId");
					var teacherWeekTime = $(this).attr("weekTime");
					var teacherHourRange = $(this).attr("hourRange");
					var selClassInstId = $(this).attr("classInstId");
					if(teacherId == selTeacherId && weekTime == teacherWeekTime 
							&& hourRange == teacherHourRange && classInstId == selClassInstId) {
						flag = false;
					}
				});
			}
			if(flag) {
				var teacherNum = 1;
				var s = "," + teacherId + ",";
				if($("input[name='teachers'][classInstId="+classInstId+"]").length > 0) {
					$("input[name='teachers'][classInstId="+classInstId+"]").each(function() {
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
						var schooltimeId = $("#selSchooltimeId").val();
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
									content += "<input type='hidden' name='teachers' schoolId='"+teacherSchoolId+"' teacherId='"+teacherId+"' weekTime='"+weekTime+"' hourRange='"+hourRange+"' lessions='"+lessions+"' classInstId='"+classInstId+"' addFlag='Y' schooltimeId='"+schooltimeId+"'/>&nbsp;</span>";
									$(node).html(content);
								} else {
									var teacherText = teacherSchoolName + " " + teacherName + " " + lessions + " " + licenseFlagText;
									var html = teacherText + "&nbsp;<a href='javascript:void(0)' class='linkmore' onclick='deleteTeacher(this, "+teacherId+")'><span>删除</span></a>";
									html += "<input type='hidden' name='teachers' schoolId='"+teacherSchoolId+"' teacherId='"+teacherId+"' weekTime='"+weekTime+"' hourRange='"+hourRange+"' lessions='"+lessions+"' classInstId='"+classInstId+"' addFlag='Y' schooltimeId='"+schooltimeId+"'/>&nbsp;";
									$("#teacher" + teacherId + weekTime + hourRange).html(html);
								}
								$(node).attr("lessions", parseInt(lessions) + parseInt(addLessions));
							}
						});
						$('#dlg').dialog('close');
					} else {
						$.messager.alert('提示', "该上课时段可用的课时为"+subLessions+"个课时，请填写的课时为"+subLessions+"！");
					}
				} else
				{
					$.messager.alert('提示', "一个班级最多只允许有2个带班老师！");
				}
			} else {
				$.messager.alert('提示', "该上课时段已经添加该带班老师，请选择另一个老师！");
			}
		}
	});
	
	//调整上课时段
	$("#adjustSchooltimeSubmit").click(function() {
		if($("input[name='schooltimes']").length > 0) {
			var flag = true;
			var checkClassInstId = "";
			//判断每个班级是否都有上课时段
			$("input[name='classInstId']").each(function() {
				if(flag) {
					var classInstId = $(this).val();
					if($("input[name='schooltimes'][classInstId="+classInstId+"]").length == 0) {
						flag = false;
						checkClassInstId = classInstId;
					}
				}
			});
			if(flag) {
				//判断每个班级的每个上课时段是否都有老师
				var checkSchooltimeName = "";
				$("input[name='classInstId']").each(function() {
					var classInstId = $(this).val();
					$("input[name='schooltimes'][classInstId="+classInstId+"]").each(function() {
						if(flag) {
							var weekTime = $(this).attr("weekTime");
							var hourRange = $(this).attr("hourRange");
							if($("input[name='teachers'][classInstId="+classInstId+"][weekTime="+weekTime+"][hourRange="+hourRange+"]").length == 0) {
								flag = false;
								checkClassInstId = classInstId;
								checkSchooltimeName = $(this).attr("schooltimeName");
							}
						}
					});
				});
				if(flag) {
					var changeRoomFlag = false;
					$("input[name='schooltimes']").each(function() {
						var schooltimeId = $(this).attr("schooltimeId");
						if(schooltimeId != null && schooltimeId != "" && schooltimeId != undefined) {
							var oldRoomId = $(this).attr("roomId");
							var roomId = $("#roomId" + schooltimeId).combobox("getValue");
							if(oldRoomId != roomId) {
								changeRoomFlag = true;
							}
						}
					});
					var changeTeacherFlag = false;
					if($("input[name='teachers'][addFlag='Y']").length > 0) {
						$("input[name='teachers'][addFlag='Y']").each(function() {
							var schooltimeId = $(this).attr("schooltimeId");
							if(schooltimeId != null && schooltimeId != "" && schooltimeId != undefined) {
								changeTeacherFlag = true;
							}
						});
					}
					if((delClassTeacherId == "" || delClassTeacherId == null || delClassTeacherId == undefined)
							&& (delSchooltimeId == "" || delSchooltimeId == null || delSchooltimeId == undefined)
							&& ($("input[name='schooltimes'][addFlag='Y']").length == 0) && !changeTeacherFlag && !changeRoomFlag
							&& ($("input[name='teachers'][addFlag='Y']").length == 0)) {
						$.messager.alert('提示', "请先调整合并班级的上课时段或者调整合并班级的教室或带班老师！");
					} else {
						if(changeRoomFlag && changeTeacherFlag) {
							$.messager.confirm('提示', "您更换的教室和带班老师只对未排课的月份生效，确定要更换教室和带班老师吗？", function(r) {adjust();});
						} else {
							if(changeRoomFlag) {
								$.messager.confirm('提示', "您更换的教室只对未排课的月份生效，确定要更换教室吗？", function(r) {adjust();});
							} else if(changeTeacherFlag) {
								$.messager.confirm('提示', "您更换的带班老师只对未排课的月份生效，确定要更换带班老师吗？", function(r) {adjust();});
							} else {
								adjust();
							}
						}
					}
				} else {
					var className = $("#className" + checkClassInstId).val();
					$.messager.alert('提示', "请为"+className+"的"+checkSchooltimeName+"上课时段添加一位带班老师！");
				}
			} else {
				var className = $("#className" + checkClassInstId).val();
				$.messager.alert('提示', "请为"+className+"至少添加一个上课时段！");
			}
		} else {
			$.messager.alert('提示', "请为每个班级至少各添加一个上课时段！");
		}
	});
});

function adjust() {
	var updateRoomArray = "[";
	$("input[name='schooltimes']").each(function() {
		var schooltimeId = $(this).attr("schooltimeId");
		if(schooltimeId != null && schooltimeId != "" && schooltimeId != undefined) {
			var oldRoomId = $(this).attr("roomId");
			var roomId = $("#roomId" + schooltimeId).combobox("getValue");
			if(oldRoomId != roomId) {
				var classInstId = $(this).attr("classInstId");
				updateRoomArray += "{schooltimeId:\""+schooltimeId+"\",\"classInstId\":\""+classInstId+"\",roomId:\""+roomId+"\"},";
			}
		}
	});
	if(updateRoomArray != "[" && updateRoomArray.endWith(",")) {
		updateRoomArray = updateRoomArray.substring(0, updateRoomArray.length - 1);
	}
	updateRoomArray += "]";
	var schooltimeArray = "[";
	var handlerId = $("#handlerId").val();
	$("input[name='classInstId']").each(function() {
		var classInstId = $(this).val();
		var schoolId = $("#schoolId" + classInstId).val();
		if($("input[name='schooltimes'][addFlag='Y'][classInstId="+classInstId+"]").length > 0) {
			$("input[name='schooltimes'][addFlag='Y'][classInstId="+classInstId+"]").each(function() {
				var weekTime = $(this).attr("weekTime");
				var hourRange = $(this).attr("hourRange");
				var schooltimeObj = new Object();
				schooltimeObj.schoolId = schoolId;
				schooltimeObj.classInstId = classInstId;
				schooltimeObj.roomId = $(this).attr("roomId");
				schooltimeObj.weekTime = weekTime;
				schooltimeObj.hourRange = hourRange;
				schooltimeObj.lessionHours = $(this).attr("lessionHours");
				schooltimeObj.handlerId = handlerId;
				var classTeacherArray = "[";
				if($("input[name='teachers'][addFlag='Y'][classInstId="+classInstId+"][weekTime="+weekTime+"][hourRange="+hourRange+"]").length > 0) {
					$("input[name='teachers'][addFlag='Y'][classInstId="+classInstId+"][weekTime="+weekTime+"][hourRange="+hourRange+"]").each(function() {
						var teacherObj = new Object();
						var teacherSchoolId = $(this).attr("schoolId");
						teacherObj.schoolId = teacherSchoolId;
						teacherObj.classInstId = classInstId;
						teacherObj.teacherId = $(this).attr("teacherId");
						teacherObj.teacherType = "T";
						teacherObj.handlerId = handlerId;
						teacherObj.hours = $(this).attr("lessions");
						classTeacherArray += JSON.stringify(teacherObj) + ","; 
					});
					if(classTeacherArray != "[" && classTeacherArray.endWith(",")) {
						classTeacherArray = classTeacherArray.substring(0, classTeacherArray.length - 1);
					}
				}
				classTeacherArray += "]";
				var object = JSON.stringify(schooltimeObj);
				object = object.substring(0, object.length - 1);
				object += ",\"classTeacherArray\":" + classTeacherArray + "},";
				schooltimeArray += object;
			});
		}
	});
	if(schooltimeArray != "[" && schooltimeArray.endWith(",")) {
		schooltimeArray = schooltimeArray.substring(0, schooltimeArray.length - 1);
	}
	schooltimeArray += "]";
	var classTeacherArray = "[";
	$("input[name='classInstId']").each(function() {
		var classInstId = $(this).val();
		var schoolId = $("#schoolId" + classInstId).val();
		if($("input[name='teachers'][addFlag='Y'][classInstId="+classInstId+"]").length > 0) {
			$("input[name='teachers'][addFlag='Y'][classInstId="+classInstId+"]").each(function() {
				var schooltimeId = $(this).attr("schooltimeId");
				if(schooltimeId != null && schooltimeId != "" && schooltimeId != undefined) {
					var teacherObj = new Object();
					teacherObj.schoolId = schoolId;
					teacherObj.classInstId = classInstId;
					teacherObj.teacherId = $(this).attr("teacherId");
					teacherObj.teacherType = "T";
					teacherObj.handlerId = handlerId;
					teacherObj.hours = $(this).attr("lessions");
					teacherObj.schooltimeId = $(this).attr("schooltimeId");
					classTeacherArray += JSON.stringify(teacherObj) + ","; 
				}
			});
		}
	});
	if(classTeacherArray != "[" && classTeacherArray.endWith(",")) {
		classTeacherArray = classTeacherArray.substring(0, classTeacherArray.length - 1);
	}
	classTeacherArray += "]";
	if(delSchooltimeId != "" && delSchooltimeId != null && delSchooltimeId != undefined) {
		delSchooltimeId = delSchooltimeId.substring(0, delSchooltimeId.length - 1);
	}
	if(delClassTeacherId != "" && delClassTeacherId != null && delClassTeacherId != undefined) {
		delClassTeacherId = delClassTeacherId.substring(0, delClassTeacherId.length - 1);
	}
	var param = "{\"updateRoomArray\":"+updateRoomArray+",\"schooltimeArray\":"+schooltimeArray+",\"updateClassTeacherArray\":"+classTeacherArray+",\"delClassTeacherId\":\""+delClassTeacherId+"\",\"delSchooltimeId\":\""+delSchooltimeId+"\",\"handlerId\":\""+handlerId+"\"}";
	param = encodeURI(param);
	$.ajax({
		url: "/sys/mergeClass/adjust.do",
		data: "param=" + param,
		dataType: "json",
		async: true,
		beforeSend: function() {
			$.messager.progress({title : '调整上课时段', msg : '调整上课时段，请稍等……'});
		},
		success: function (data) {
			$.messager.progress('close'); 
			var flag = data.flag
			if(flag) {
				$.messager.alert('提示', "调整上课时段成功！", "info", function() {window.history.back();});
			} else {
				$.messager.alert('提示', data.msg);
			}
		} 
	});
}

//在添加上课时间之前验证值
function checkHourRange(classInstId) {
	var weekTime = $("#weekTime" + classInstId).combobox("getValue");
	if(weekTime == null || weekTime == "" || weekTime == undefined) {
		$.messager.alert('提示', "请先选择上课时间！");
		return false;
	}
	var hourRange = $("#hourRange" + classInstId).combobox("getValue");
	if(hourRange == null || hourRange == "" || hourRange == undefined) {
		$.messager.alert('提示', "请先选择上课时间段！");
		return false;
	}
	var roomId = $("#roomId" + classInstId).combobox("getValue");
	if(roomId == null || roomId == "" || roomId == undefined) {
		$.messager.alert('提示', "请先选择上课教室！");
		return false;
	}
	return true;
}

//添加代班老师
function addTeacher(obj) {
	var content = "";
	var classInstId = "";
	var schooltimeId = "";
	var tr = $(obj).parent().parent();
	tr.find("td").each(function(i, node) {
		if(i == 0) {
			classInstId = $(node).attr("classInstId");
			schooltimeId = $(node).attr("schooltimeId");
		} else if(i == 4) {
			content = $(node).html();
		}
	});
	if(content == "" || content == null || content == undefined) {
		$("#dlg").dialog('open').dialog('setTitle', '添加老师');//设定表头  
		$('#addTeacherFm').form('clear');//清空窗体数据  
		$("#licenseFlagText").html("");
		$("#selClassInstId").val(classInstId);
		$("#selSchooltimeId").val(schooltimeId);
		selTr = $(obj).parent().parent();
	} else {
		$.messager.alert('提示', "一个上课时段只允许一位老师带班！");
	}
}

function deleteTeacher(obj, teacherId) {
	var weekTime = "";
	var hourRange = "";
	var classInstId = "";
	var delTr = $(obj).parent().parent().parent();
	delTr.find("td").each(function(i, node) {
		if(i == 0) {
			weekTime = $(node).attr("weekTime");
			hourRange = $(node).attr("hourRange");
			classInstId = $(node).attr("classInstId");
		}
	});
	if($("[name='teachers']").length > 0) {
		$("[name='teachers']").each(function() {
			var selTeacherId = $(this).attr("teacherId");
			var selWeekTime = $(this).attr("weekTime");
			var selHourRange = $(this).attr("hourRange");
			var selClassInstId = $(this).attr("classInstId");
			var addFlag = $(this).attr("addFlag");
			if(teacherId == selTeacherId && weekTime == selWeekTime && "N" == addFlag
					&& hourRange == selHourRange && classInstId == selClassInstId) {
				delClassTeacherId += $(this).attr("classTeacherId") + ",";
			}
		});
	}
	delTr.find("td").each(function(i, node) {
		if(i == 4) {
			$(node).html("");
			$(node).attr("lessions", 0);
		}
	});
	$("#teacher" + teacherId + weekTime + hourRange + classInstId).html("");
}

//删除上课时段
function deleteSchooltime(obj) {
	var selIndex = null;
	var classInstId = null;
	var delTr = $(obj).parent().parent();
	delTr.find("td").each(function(i, node) {
		if(i == 0) {
			selIndex = $(node).attr("index");
			var addFlag = $(node).attr("addFlag");
			if(addFlag == "N") {
				delSchooltimeId += $(node).attr("schooltimeId") + ",";
			}
			classInstId = $(node).attr("classInstId");
		}
	});
	var addSchoolNum = $("#addSchoolNum" + classInstId).val();
	if(selIndex == addSchoolNum) {
		addSchoolNum--;
	}
	$(obj).parent().parent().remove();
	$("#addSchoolNum" + classInstId).val(addSchoolNum);
}