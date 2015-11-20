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
    	onLoadSuccess : function () { //数据加载完毕事件
            var data = $('#studentChannelType').combobox('getData');
            if (data.length > 0) {
                $("#studentChannelType").combobox('select', data[0].codeFlag);
            }
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
    	onLoadSuccess : function () { //数据加载完毕事件
            var data = $('#stageId').combobox('getData');
            if (data.length > 0) {
                $("#stageId").combobox('select', data[0].stageId);
            }
        },
		onChange : function(n, o) {
			var schooolId = $("#schoolId").val();
			var date = new Date().format("yyyy-MM-dd");
			$("#classType").combobox({
        		url : "/sys/pubData/qryData.do?param={queryCode:\"Qry_Stage_Class\",stageId:\""+n+"\",schoolId:\""+schooolId+"\",time:\""+date+"\"}",//返回json数据的url
        		valueField : "classType",
        		textField : "classType",
        		panelHeight : "auto",
        		onLoadSuccess : function () { //数据加载完毕事件
                    var data = $('#classType').combobox('getData');
                    if (data.length > 0) {
                        $("#classType").combobox('select', data[0].classType);
                    }
                }
        	});
		}
	});
	
	$("#classType").combobox({
		onChange : function(n, o) {
			var courseType = $('#courseType').val();
			var stageId = $("#stageId").combobox("getValue");
			$.ajax({
				url : "/sys/applyClass/qryClassName.do",
				data: "courseType="+courseType+"&stageId="+stageId+"&classType="+n,
				dataType: "json",
				async: false,
				success: function (data) {
					$("#classNameText").html(data.className);
					$("#className").val(data.className);
					$("#classOrder").val(data.classOrder);
				}
			});
		}
	});

	$("#higherOptionStageId").combobox({
		url : "/sys/pubData/qryCodeNameList.do?tableName=STUDENT_COURSE_T&codeType=STAGE_ID",//返回json数据的url
    	valueField : "codeFlag",
    	textField : "codeName",
    	panelHeight : "auto",
    	onLoadSuccess : function () { //数据加载完毕事件
            var data = $('#higherOptionStageId').combobox('getData');
            if (data.length > 0) {
                $("#higherOptionStageId").combobox('select', data[0].codeFlag);
            }
        },
		onChange : function(n, o) {
			var higherOptionSchoolId = $("#higherOptionSchoolId").combobox("getValue");
			$("#higherOptionClassInstId").combobox({
				url : "/sys/pubData/qryData.do?param={queryCode:\"qryHigherSchoolList\",stageId:\""+n+"\",schoolId:\""+higherOptionSchoolId+"\"}",//返回json数据的url
        		valueField : "classInstId",
        		textField : "className",
        		panelHeight : "auto",
        		onLoadSuccess : function () { //数据加载完毕事件
                    var data = $('#higherOptionClassInstId').combobox('getData');
                    if (data.length > 0) {
                        $("#higherOptionClassInstId").combobox('select', data[0].classInstId);
                    }
                }
			});
		}
	});
	
	//添加升学班级
	$("#addHigherSchoolBtn").click(function() {
		if(addHigherSchool < 5) {
			var classInstId = $('#higherOptionClassInstId').combobox('getValue');
			var higherSchoolId = $("#higherSchoolId").val();
			var flag = true;
			if(higherSchoolId.indexOf(",") != -1) {
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
		} else {
			$.messager.alert('提示', "升学班级最多不超过5个！");
		}
	});
	
	//添加上课时段
	$("#addHourRange").click(function() {
		var roomId = $("#roomId").combobox("getValue");
		var weekTime = $("#weekTime").combobox("getValue");
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
		} else {
			$.messager.alert('提示', "该上课时段已经添加，请选择另一个上课时段！");
		}
	});
	
	//选择上课时段周标识
	$("#weekTime").combobox({
		url : "/sys/pubData/qryCodeNameList.do?tableName=SCHOOLTIME_T&codeType=WEEK_TIME",//返回json数据的url
    	valueField : "codeFlag",
    	textField : "codeName",
    	panelHeight : "auto",
    	onLoadSuccess : function () { //数据加载完毕事件
            var data = $('#weekTime').combobox('getData');
            if (data.length > 0) {
                $("#weekTime").combobox('select', data[0].codeFlag);
            }
        },
		onChange : function(n, o) {
			$("#hourRange").combobox({
        		url : "/sys/pubData/qryHourRangeList.do?weekTime=" + n,//返回json数据的url
        		valueField : "hourRange",
        		textField : "hourRangeVal",
        		panelHeight : "auto",
        		onLoadSuccess : function () { //数据加载完毕事件
                    var data = $('#hourRange').combobox('getData');
                    if (data.length > 0) {
                        $("#hourRange").combobox('select', data[0].hourRange);
                    }
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
    	onLoadSuccess : function () { //数据加载完毕事件
            var data = $('#teacherSchoolId').combobox('getData');
            if (data.length > 0) {
                $("#teacherSchoolId").combobox('select', data[0].schoolId);
            }
        },
		onChange : function(n, o) {
			var classType = $("#classType").combobox("getValue");
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
								addApplyClass();
							} else {
								$.messager.alert('提示', "上课时段"+addNum+"的总课时量为"+hours+"，您选择的所有带班老师的总课时量为"+teacherHours+"，请保持课时量相等！");
							}
						} else {
							$.messager.alert('提示', "请至少为上课时段"+addNum+"添加一位带班老师！");
						}
					} else {
						$.messager.alert('提示', "请至少为每个上课时段添加一位带班老师！");
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
		schooltimeArray += "classTeacherArray:["
			$("[name='teachers']").each(function() {
				var teacherWeekTime = $(this).attr("weekTime");
				var teacherHourRange = $(this).attr("hourRange");
				if(weekTime == teacherWeekTime && hourRange == teacherHourRange) {
					var teacherId = $(this).attr("teacherId");
					var lessions = $(this).attr("lessions");
					schooltimeArray += "{teacherId:\""+teacherId+"\",teacherType:\"T\",lessions:\""+lessions+"\"},";
				}
			});
		schooltimeArray = schooltimeArray.substring(0, schooltimeArray.length - 1) + "]},";
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
		async: false,
		beforeSend: function()
		{
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
	$("#dlg").dialog('open').dialog('setTitle', '添加老师');//设定表头  
	$('#addTeacherFm').form('clear');//清空窗体数据  
	$("#licenseFlagText").html("");
	selTr = $(obj).parent().parent();
}

function deleteTeacher(obj, teacherId) {
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

//删除上课时段
function deleteSchooltime(obj) {
	$(obj).parent().parent().remove();
	addSchoolNum--;
}