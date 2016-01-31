var addSchoolNum = 0;
var addHigherSchool = 0;
var selTr = null;
$(document).ready(function() {
	//学员来源类型
	$('#studentChannelType').combobox({
		url : "/sys/pubData/qryCodeNameList.do?tableName=CLASS_INST_T&codeType=STUDENT_CHANNEL_TYPE",//返回json数据的url
    	valueField : "codeFlag",
    	textField : "codeName",
    	panelHeight : "auto",
    	editable : false,
    	formatter : function(data) {
    		return "<span>" + data.codeName + "</span>";
    	},
		onChange : function(n, o) {
			//新招
			if("001" == n) {
				$("#higherText").css("display", "none");
				$("#higherDiv").css("display", "none");
			} else {
				$("#higherText").css("display", "block");
				$("#higherDiv").css("display", "block");
			}
		}
	});
	
	$("#stageId").combobox({
		url : "/sys/pubData/qryStage.do",//返回json数据的url
    	valueField : "stageId",
    	textField : "stageId",
    	panelHeight : "auto",
    	editable : false,
    	formatter : function(data) {
    		return "<span>" + data.stageId + "</span>";
    	},
		onChange : function(n, o) {
			var schoolId = $("#schoolId").val();
			var date = new Date().format("yyyy-MM-dd");
			$("#classType").combobox({
        		url : "/sys/pubData/qryData.do?param={queryCode:\"Qry_Stage_Class\",stageId:\""+n+"\",schoolId:\""+schoolId+"\",time:\""+date+"\"}",//返回json数据的url
        		valueField : "classType",
        		textField : "classType",
        		panelHeight : "auto",
        		editable : false,
        		formatter : function(data) {
        			return "<span>" + data.classType + "</span>";
        		},
        		onChange : function(newValue, oldValue) {
        			var courseType = $('#courseType').val();
        			var stageId = $("#stageId").combobox("getValue");
        			$.ajax({
        				url : "/sys/applyClass/qryClassName.do",
        				data: "courseType="+courseType+"&stageId="+stageId+"&classType="+newValue+"&schoolId="+schoolId,
        				dataType: "json",
        				async: true,
        				success: function (data) {
        					$("#classNameText").html(data.className);
        					$("#className").val(data.className);
        					$("#classOrder").val(data.classOrder);
        				}
        			});
        		}
        	});
			
			$("#higherOptionStageId").combobox({
				url : "/sys/pubData/qryData.do?param={queryCode:\"qryHigherStageId\",stageId:\""+n+"\"}",//返回json数据的url
		    	valueField : "stageId",
		    	textField : "stageId",
		    	panelHeight : "auto",
		    	editable : false,
		    	formatter : function(data) {
		    		return "<span>" + data.stageId + "</span>";
		    	},
				onChange : function(n, o) {
					var higherOptionSchoolId = $("#higherOptionSchoolId").combobox("getValue");
					if(higherOptionSchoolId != "" && higherOptionSchoolId != null && higherOptionSchoolId != undefined) {
						$("#higherOptionClassInstId").combobox({
							url : "/sys/pubData/qryData.do?param={queryCode:\"qryHigherClassInstList\",stageId:\""+n+"\",schoolId:\""+higherOptionSchoolId+"\"}",//返回json数据的url
							valueField : "classInstId",
							textField : "className",
							panelHeight : "auto",
							editable : false,
							formatter : function(data) {
								return "<span>" + data.className + "</span>";
							}
						});
					} else {
						$.messager.alert('提示', "请选择升学班级所在的校区！");
					}
				}
			});
		}
	});
	
	$("#higherOptionSchoolId").combobox({
		url : "/sys/pubData/qrySchoolList.do?schoolId=",//返回json数据的url
    	valueField : "schoolId",
    	textField : "schoolName",
    	panelHeight : "auto",
    	editable : false,
    	formatter : function(data) {
    		return "<span>" + data.schoolName + "</span>";
    	},
		onChange : function(n, o) {
			var higherOptionStageId = $("#higherOptionStageId").combobox("getValue");
			if(higherOptionStageId != null && higherOptionStageId != "" && higherOptionStageId != undefined) {
				$("#higherOptionClassInstId").combobox({
					url : "/sys/pubData/qryData.do?param={queryCode:\"qryHigherClassInstList\",stageId:\""+higherOptionStageId+"\",schoolId:\""+n+"\"}",//返回json数据的url
					valueField : "classInstId",
					textField : "className",
					panelHeight : "auto",
					editable : false,
					formatter : function(data) {
						return "<span>" + data.className + "</span>";
					}
				});
			}
		}
	});
	
	//添加升学班级
	$("#addHigherSchoolBtn").click(function() {
		if(addHigherSchool < 5) {
			var flag = true;
			var higherOptionSchoolId = $("#higherOptionSchoolId").combobox('getValue');
			if(higherOptionSchoolId == "" || higherOptionSchoolId == null || higherOptionSchoolId == undefined) {
				flag = false;
				$.messager.alert('提示', "请选择升学班级所在的校区！");
			} else {
				var higherOptionStageId = $("#higherOptionStageId").combobox('getValue');
				if(higherOptionStageId == "" || higherOptionStageId == null || higherOptionStageId == undefined) {
					flag = false;
					$.messager.alert('提示', "请选择升学班级的课程阶段！");
				} else {
					var classInstId = $('#higherOptionClassInstId').combobox('getValue');
					if(classInstId == "" || classInstId == null || classInstId == undefined) {
						flag = false;
						$.messager.alert('提示', "请选择升学班级！");
					}
				}
			}
			if(flag) {
				var classInstId = $('#higherOptionClassInstId').combobox('getValue');
				var higherSchoolId = $("#higherSchoolId").val();
				if(higherSchoolId.indexOf(",") >= 0) {
					var src = higherSchoolId.split(",");  
					for (var i = 0; i < src.length; i++) {   
						if(src[i] == classInstId) {
							flag = false;
							break;
						}
					}   
				} else {
					if(higherSchoolId == classInstId) {
						flag = false;
					}
				}
				if(flag) {
					var higherOptionSchoolName = $("#higherOptionSchoolId").combobox("getText");
					var className = $('#higherOptionClassInstId').combobox('getText');
					var text = higherOptionSchoolName + className;
					if(addHigherSchool == 0) {
						var higherSchoolNameTr = $("#higherSchoolNameTr").clone();
						higherSchoolNameTr.css("display", 'table-row');
						higherSchoolNameTr.attr("val", "add");
						higherSchoolNameTr.find("td").each(function(i, node) {
							if(i == 1) {
								$(node).html("<span id='higherOptionSchoolName'>"+text+"</span>");	
							}
						});
						$("#higherSchoolName").val(text);
						$("#higherSchoolId").val(classInstId);
						$("#higherSchoolNameTr").after(higherSchoolNameTr);
					} else {
						var higherOptionSchoolName = $("#higherOptionSchoolName").html();
						higherOptionSchoolName += "，" + text;
						$("#higherOptionSchoolName").html(higherOptionSchoolName);
						$("#higherSchoolName").val(higherOptionSchoolName);
						var higherSchoolId = $("#higherSchoolId").val();
						$("#higherSchoolId").val(higherSchoolId + "," + classInstId);
					}
					addHigherSchool++;
				} else {
					$.messager.alert('提示', "您选中的班级已经是升学班级，请选择其他班级！");
				}
			}
		} else {
			$.messager.alert('提示', "升学班级最多不超过5个！");
		}
	});
	
	//添加上课时段
	$("#addHourRange").click(function() {
		if(!checkHourRange()) {
			return;
		} else {
			var weekTime = $("#weekTime").combobox("getValue");
			var roomId = $("#roomId").combobox("getValue");
			var hourRange = $("#hourRange").combobox("getValue");
			var weekTimeText = $("#weekTime").combobox("getText");
			var hourRangeText = $("#hourRange").combobox("getText");
			var roomIdText = $("#roomId").combobox("getText");
			var hourRangeData = $('#hourRange').combobox('getData');
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
					if(selWeekTime == weekTime && selHourRange == hourRange) {
						flag = false;
					}
				});
			}
			if(flag) {
				var subHourRange = hourRange.substring(0, 3);
				flag = validateRoom(weekTime, hourRange, roomId);
				if(flag) {
					$("[name='schooltimes']").each(function() {
						var selWeekTime = $(this).attr("weekTime");
						var selHourRange = $(this).attr("hourRange");
						var subSelHourRange = selHourRange.substring(0, 3);
						if(subHourRange == subSelHourRange && selWeekTime == weekTime) {
							flag = false;
						}
					});
					if(flag) {
						addSchoolNum++;
						var addSchootimeTd = $("#addSchootimeTd").clone();
						addSchootimeTd.css("display", 'table-row');
						addSchootimeTd.attr("val", "add");
						addSchootimeTd.find("td").each(function(i, node) {
							if(i == 0) {
								$(node).html("<span>" + addSchoolNum + "</span>");
								$(node).attr("lessionHours", lessionHours);
								$(node).attr("weekTime", weekTime);
								$(node).attr("hourRange", hourRange);
							} else if(i == 1) {
								$(node).html("<span>" + weekTimeText + "  " + hourRangeText + "</span>");
							} else if(i == 2) {
								$(node).html("<span>" + roomIdText + "</span>");
							} else if(i == 3) {
								$(node).html("<span>" + lessionHours + "</span><input type='hidden' name='schooltimes' roomId='"+roomId+"' weekTime='"+weekTime+"' hourRange='"+hourRange+"' lessionHours='"+lessionHours+"' addNum='"+addSchoolNum+"'/>");
							}
						});
						$("#schooltimeTb").append(addSchootimeTd);
						$("#addSchootimeTr").css("display", 'table-row');
						$("#roomId").combobox("setValue", "");
						$("#weekTime").combobox("setValue", "");
						$("#hourRange").combobox("setValue", "");
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
	
	//选择上课时段周标识
	$("#weekTime").combobox({
		url : "/sys/pubData/qryCodeNameList.do?tableName=SCHOOLTIME_T&codeType=WEEK_TIME",//返回json数据的url
    	valueField : "codeFlag",
    	textField : "codeName",
    	panelHeight : "auto",
    	editable : false,
    	formatter : function(data) {
    		return "<span>" + data.codeName + "</span>";
    	},
		onChange : function(n, o) {
			$("#hourRange").combobox({
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
	});
	
	//带班老师的学校
	$("#teacherSchoolId").combobox({
		url : "/sys/pubData/qrySchoolList.do",//返回json数据的url
    	valueField : "schoolId",
    	textField : "schoolName",
    	panelHeight : "auto",
    	editable : false,
    	formatter : function(data) {
    		return "<span>" + data.schoolName + "</span>";
    	},
		onChange : function(n, o) {
			var classType = $("#classType").combobox("getValue");
			$("#teacherId").combobox({
				url : "/sys/pubData/qryTeacherList.do?schoolId=" + n + "&classType=" + classType,
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
				if($("[name='teachers']").length > 0) {
					$("[name='teachers']").each(function() {
						var selTeacherId = $(this).attr("teacherId");
						if(teacherId != selTeacherId) {
							teacherNum++;
						}
					});
				}
				if(teacherNum > 2) {
					flag = false;
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
									content += "<input type='hidden' name='teachers' teacherId='"+teacherId+"' weekTime='"+weekTime+"' hourRange='"+hourRange+"' lessions='"+lessions+"'/>&nbsp;</span>";
									$(node).html(content);
								} else {
									var teacherText = teacherSchoolName + " " + teacherName + " " + lessions + " " + licenseFlagText;
									var html = teacherText + "&nbsp;<a href='javascript:void(0)' class='linkmore' onclick='deleteTeacher(this, "+teacherId+")'><span>删除</span></a>";
									html += "<input type='hidden' name='teachers' teacherId='"+teacherId+"' weekTime='"+weekTime+"' hourRange='"+hourRange+"' lessions='"+lessions+"'/>&nbsp;";
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
					$.messager.alert('提示', "一个班级最多只允许有2个带班老师！");
				}
			} else {
				$.messager.alert('提示', "该上课时段已经添加该带班老师，请选择另一个老师！");
			}
		}
	});
	
	//提交放班申请
	$("#applyClassSubmit").click(function() {
		if($("#applyClassFm").form('validate')) {
			var flag = true;
			var studentChannelType = $("#studentChannelType").combobox("getValue");
			if(studentChannelType == "002" || studentChannelType == "003") {
				var higherSchoolId = $("#higherSchoolId").val();
				if(higherSchoolId == "" || higherSchoolId == null || higherSchoolId == undefined) {
					flag = false;
				}
			}
			if(flag) {
				if($("[name='schooltimes']").length > 0) {
					var addNum = "";
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
					}
					if(flag) {
						if($("[name='teachers']").length > 0) {
							$("[name='schooltimes']").each(function() {
								var weekTime = $(this).attr("weekTime");
								var hourRange = $(this).attr("hourRange");
								var lessionHours = parseInt($(this).attr("lessionHours"));
								var hours = 0;
								var teacherHours = 0;
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
							addApplyClass();
						} else {
							$.messager.alert('提示', "上课时段"+addNum+"的总课时量为"+hours+"，您选择的所有带班老师的总课时量为"+teacherHours+"，请保持课时量相等！");
						}
					} else {
						$.messager.alert('提示', "请为上课时段"+addNum+"添加一位带班老师！");
					}
				} else {
					$.messager.alert('提示', "请至少添加一个上课时段！");
				}
			} else {
				var studentChannelTypeText = $("#studentChannelType").combobox("getText");
				$.messager.alert('提示', "您选择的学员来源类型为"+studentChannelTypeText+"，请至少添加一个升学班级！");
			}
		}
	});
});

function addApplyClass() {
	var schooltimeArray = "[";
	$("[name='schooltimes']").each(function() {
		var roomId = $(this).attr("roomId");
		var weekTime = $(this).attr("weekTime");
		var hourRange = $(this).attr("hourRange");
		var lessionHours = $(this).attr("lessionHours");
		schooltimeArray += "{roomId:\""+roomId+"\",weekTime:\""+weekTime+"\",hourRange:\""+hourRange+"\",lessionHours:\""+lessionHours+"\",";
		schooltimeArray += "classTeacherArray:[";
		if($("[name='teachers']").length > 0) {
			$("[name='teachers']").each(function() {
				var teacherWeekTime = $(this).attr("weekTime");
				var teacherHourRange = $(this).attr("hourRange");
				if(weekTime == teacherWeekTime && hourRange == teacherHourRange) {
					var teacherId = $(this).attr("teacherId");
					var lessions = $(this).attr("lessions");
					schooltimeArray += "{teacherId:\""+teacherId+"\",teacherType:\"T\",lessions:\""+lessions+"\"},";
				}
			});
			schooltimeArray = schooltimeArray.substring(0, schooltimeArray.length - 1);	
		}
		schooltimeArray += "]},";
	});
	schooltimeArray = schooltimeArray.substring(0, schooltimeArray.length - 1) + "]";
	var obj = JSON.stringify($("#applyClassFm").serializeObject());
	var param = "{\"classInstObj\":"+obj+",\"schooltimeArray\":"+schooltimeArray+"}";
	param = encodeURI(param);
	$.ajax({
		url: "/sys/applyClass/applyCreateClass.do",
		data: "param=" + param,
		dataType: "json",
		contentType: "application/x-www-form-urlencoded; charset=utf-8", 
		async: true,
		beforeSend: function() {
			$.messager.progress({title : '申请放班', msg : '正在申请放班，请稍等……'});
		},
		success: function (data) {
			$.messager.progress('close'); 
			var flag = data.flag;
			if(flag) {
				$.messager.alert('提示', "申请放班成功！", "info", function() {window.history.back();});
			} else {
				$.messager.alert('提示', data.msg);
			}
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

function deleteTeacher(obj, teacherId) {
	var delTr = $(obj).parent().parent().parent();
	delTr.find("td").each(function(i, node) {
		if(i == 4) {
			$(node).html("");
			$(node).attr("lessions", 0);
		}
	});
	$("#teacher" + teacherId + weekTime + hourRange).html("");
}

//删除上课时段
function deleteSchooltime(obj) {
	$(obj).parent().parent().remove();
	addSchoolNum--;
}

//在添加上课时间之前验证值
function checkHourRange() {
	var weekTime = $("#weekTime").combobox("getValue");
	if(weekTime == null || weekTime == "" || weekTime == undefined) {
		$.messager.alert('提示', "请先选择上课时间！");
		return false;
	}
	var hourRange = $("#hourRange").combobox("getValue");
	if(hourRange == null || hourRange == "" || hourRange == undefined) {
		$.messager.alert('提示', "请先选择上课时间段！");
		return false;
	}
	var roomId = $("#roomId").combobox("getValue");
	if(roomId == null || roomId == "" || roomId == undefined) {
		$.messager.alert('提示', "请先选择上课教室！");
		return false;
	}
	return true;
}