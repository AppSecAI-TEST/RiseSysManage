var td = 1;
var selTr = null;
var classTeacherId = "";
$(document).ready(function() {	
	if($("[name='teachers']").length > 0) {
		var oldTeacherName = "";
		$("[name='teachers']").each(function() {
			var schoolName = $(this).attr("schoolName");
			var byname = $(this).attr("byname");
			var isLicense = $(this).attr("isLicense");
			oldTeacherName += schoolName + " " + byname + "（" + isLicense + "）</br>";
		});
		oldTeacherName = oldTeacherName.substring(0, oldTeacherName.length - 5);
		$("#oldTeacherName").val(oldTeacherName);
	}
	//带班老师的学校
	$("#teacherSchoolId").combobox({
		url : "/sys/pubData/qrySchoolList.do",//返回json数据的url
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
				url : "/sys/pubData/qryTeacherList.do?schoolId=" + n + "&stageId=" + stageId,
				valueField : "teacherId",
        		textField : "byname",
        		panelHeight : "auto",
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
									content += "<input type='hidden' name='teachers' teacherId='"+teacherId+"' weekTime='"+weekTime+"' hourRange='"+hourRange+"' lessions='"+lessions+"' schoolName='"+teacherSchoolName+"' byname='"+teacherName+"' isLicense='"+licenseFlagText+"' addFlag='Y'/>&nbsp;</span>";
									$(node).html(content);
								} else {
									var teacherText = teacherSchoolName + " " + teacherName + " " + lessions + " " + licenseFlagText;
									var html = teacherText + "&nbsp;<a href='javascript:void(0)' class='linkmore' onclick='deleteTeacher(this, "+teacherId+")'><span>删除</span></a>";
									html += "<input type='hidden' name='teachers' teacherId='"+teacherId+"' weekTime='"+weekTime+"' hourRange='"+hourRange+"' lessions='"+lessions+"' schoolName='"+teacherSchoolName+"' byname='"+teacherName+"' isLicense='"+licenseFlagText+"' addFlag='Y'/>&nbsp;";
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
	
	//提交老师变更
	$("#maintenanceClassSubmit").click(function() {
		if($("#maintenanceClassFm").form('validate')) {
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
						maintenanceClass();
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
	
	//移除学员
	$("#removeStudent").click(function() {
		var obj = $('#list_data').datagrid('getSelections');
		if(obj.length > 0) {
			var flag = true;
			var byName = "";
			for(var i = 0, n = obj.length; i < n; i++) {
				var attendFlag = obj[i].attendFlag;
				if("Y" == attendFlag) {
					flag = false;
					byName = obj[i].byName;
					break;
				}
			}
			if(flag) {
				$.messager.confirm('提示','您确定要移除当前选中的学员吗?',function(r) {
					if(r) {
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
				$.messager.alert('提示', "您选择的要移除的学员"+byName+"已有考勤记录，不能移除！");
			}
		} else {
			$.messager.alert('提示', "请先选择您要移除的学员课程！");
		}
	});
	
	//转班
	$("#changeClass").click(function() {
		if(validateSelect()) {
			var row = $('#list_data').datagrid('getSelected');
			if(row) {
				var courseState = row.courseState;
				if("003" == courseState || "004" == courseState || "005" == courseState) {
					var changeClassFlag = row.changeClassFlag;
					if("N" == changeClassFlag) {
						var changeSchoolFlag = row.changeSchoolFlag;
						if("N" == changeSchoolFlag) {
							var studentCourseId = row.studentCourseId;
							window.location.href = "/sys/changeClass/applyChangeClass.jsp?studentCourseId="+studentCourseId+"&changeSource=change";
						} else {
							$.messager.alert('提示', "您选择的学员课程已申请转校，不能申请转班！");
						}
					} else {
						$.messager.alert('提示', "您选择的学员课程已申请转班，不能再次申请转班！");
					}
				} else {
					var courseStateText = row.courseStateText;
					$.messager.alert('提示', "您选择的学员课程已"+courseStateText+"，不能再次申请转班！");
				}
			} else {
				$.messager.alert('提示', "请先选择您要转班的学员课程！");
			}
		}
	});
	
	//转校
	$("#changeSchool").click(function() {
		if(validateSelect()) {
			var row = $('#list_data').datagrid('getSelected');
			if(row) {
				var courseState = row.courseState;
				if("003" == courseState || "004" == courseState || "005" == courseState) {
					var changeClassFlag = row.changeClassFlag;
					if("N" == changeClassFlag) {
						var changeSchoolFlag = row.changeSchoolFlag;
						if("N" == changeSchoolFlag) {
							var studentId = row.studentId;
							window.location.href = "/sys/changeSchool/applyChangeSchool.jsp?studentId="+studentId+"&changeSource=change";
						} else {
							$.messager.alert('提示', "您选择的学员课程已申请转校，不能再次申请转校！");
						}
					} else {
						$.messager.alert('提示', "您选择的学员课程已申请转班，不能申请转校！");
					}
				} else {
					var courseStateText = row.courseStateText;
					$.messager.alert('提示', "您选择的学员课程已"+courseStateText+"，不能申请转校！");
				}
			} else {
				$.messager.alert('提示', "请先选择您要转班的学员课程！");
			}
		}
	});
	
	//休学
	$("#leave").click(function() {
		if(validateSelect()) {
			var row = $('#list_data').datagrid('getSelected');
			if(row) {
				var courseState = row.courseState;
				if("003" == courseState || "005" == courseState || "006" == courseState || "007" == courseState) {
					var studentId = row.studentId;
					var studentCourseId = row.studentCourseId;
					var classProgress = row.classProgress;
					var classInstId=row.classInstId;
					var stageLevel=row.stageId;
					var className=row.className;
					var teacherName=row.teacherName;
					var schoolId=row.schoolId;
					var funcNodeId="";
					window.location.href ="/sys/leaveManage/viewLeaveInfo.do?studentId="+studentId+"&schoolId="+schoolId+"&courseState="+courseState+"&studentCourseId="+studentCourseId+"&funcNodeId="+funcNodeId+"&type=add&currentHours="+classProgress+"&stageLevel="+stageLevel+"&classInstId="+classInstId+"&className="+className+"&teacherName="+teacherName; 
				} else {
					$.messager.alert('提示', "您选择的学员课程已休学，不能再次申请休学！");
				}
			} else {
				$.messager.alert('提示', "请先选择您要休学的学员课程！");
			}
		}
	});
	
	//异常
	$("#exception").click(function() {
		if(validateSelect()) {
			var row = $('#list_data').datagrid('getSelected');
			if(row) {
				var courseState = row.courseState;
				if("003" == courseState || "004" == courseState || "006" == courseState || "007" == courseState) {
					var studentId = row.studentId;
					var studentCourseId = row.studentCourseId;
					var studentId = row.studentId;
					var studentCourseId = row.studentCourseId;
					var classProgress = row.classProgress;
					var classInstId=row.classInstId;
					var stageLevel=row.stageId;
					var className=row.className;
					var teacherName=row.teacherName;
					var schoolId=row.schoolId;
					var funcNodeId="";
					window.location.href = "/sys/exception/addExp.jsp?addInfo="+studentId+","+studentCourseId+","+courseState+","+classProgress+","+stageLevel+","+className+","+teacherName+","+classInstId;
				} else {
					$.messager.alert('提示', "您选择的学员课程状态为异常，不能再次修改课程状态为异常！");
				}
			} else {
				$.messager.alert('提示', "请先选择您要异常的学员课程！");
			}
		}
	});
	
	//修改档案
	$("#updateStudent").click(function() {
		if(validateSelect()) {
			var row = $('#list_data').datagrid('getSelected');
			if(row) {
				var carer = row.carer;
				var studentId = row.studentId;
				var dutyAdvister = row.dutyAdvister;
				var advisterIdA = row.advisterIdA;
				var advisterIdB = row.advisterIdB;
				var identityType = row.identityType;
				var advisterASchoolId = row.advisterASchoolId;
				var advisterBSchoolId = row.advisterBSchoolId;
				var funcNodeId = $("#updateStudent").attr("funcNodeId");
				window.location.href = "/sys/student/updateStudent.jsp?studentId="+studentId+"&funcNodeId="+funcNodeId+"&dutyAdvister="+dutyAdvister+"&carer="+carer+"&advisterIdA="+advisterIdA+"&advisterIdB="+advisterIdB+"&identityType="+identityType+"&advisterASchoolId="+advisterASchoolId+"&advisterBSchoolId="+advisterBSchoolId;
			} else {
				$.messager.alert('提示', "请先选择您要修改档案的学员课程！");
			}
		}
	});
	
	//浏览
	$("#view").click(function() {
		if(validateSelect()) {
			var row = $('#list_data').datagrid('getSelected');
			if(row) {
				var studentId = row.studentId;
	    		window.location.href = "/sys/view.jsp?studentId="+studentId+"&title=基础信息";
			} else {
				$.messager.alert('提示', "请先选择您要浏览的学员课程！");
			}
		}
	});
});

//变更班级教师
function maintenanceClass() {
	var flag = false;
	var classTeacherArray = "[";
	var newTeacherName = "";
	$("[name='schooltimes']").each(function() {
		var schooltimeId = $(this).attr("schooltimeId");
		var weekTime = $(this).attr("weekTime");
		var hourRange = $(this).attr("hourRange");
		$("[name='teachers']").each(function() {
			var teacherWeekTime = $(this).attr("weekTime");
			var teacherHourRange = $(this).attr("hourRange");
			var addFlag = $(this).attr("addFlag");
			var schoolName = $(this).attr("schoolName");
			var byname = $(this).attr("byname");
			var isLicense = $(this).attr("isLicense");
			if(weekTime == teacherWeekTime && hourRange == teacherHourRange) {
				if("Y" == addFlag) {
					flag = true;
					var teacherId = $(this).attr("teacherId");
					var lessions = $(this).attr("lessions");
					classTeacherArray += "{schooltimeId:\""+schooltimeId+"\",teacherId:\""+teacherId+"\",teacherType:\"T\",lessions:\""+lessions+"\"},";
				}
				newTeacherName += schoolName + " " + byname + "（" + isLicense + "）</br>";
			}
		});
	});
	var handTypeDisabled = $(".handType").attr("disabled");
	if(handTypeDisabled == "" || handTypeDisabled == null || handTypeDisabled == undefined) {
		var handType = $("input:radio[name='handType']:checked").val();
		if("2" == handType) {
			flag = true;
		}
	}
	if(flag) {
		newTeacherName = newTeacherName.substring(0, newTeacherName.length - 5);
		$("#newTeacherName").val(newTeacherName);
		if(classTeacherArray != "[" && classTeacherArray.endWith(",")) {
			classTeacherArray = classTeacherArray.substring(0, classTeacherArray.length - 1);
		}
		classTeacherArray += "]";
		if(classTeacherId != "" && classTeacherId != null && classTeacherId != undefined) {
			classTeacherId = classTeacherId.substring(0, classTeacherId.length - 1);
			$("#classTeacherId").val(classTeacherId);
		}
		var object = $("#maintenanceClassFm").serializeObject();
		var obj = JSON.stringify(object);
		var param = "{teacherChangeHist:"+obj+",classTeacherArray:"+classTeacherArray+"}";
		param = encodeURI(param);
		$.ajax({
			url: "/sys/attendClass/changeTeacher.do",
			data: "param=" + param,
			dataType: "json",
			async: true,
			beforeSend: function()
			{
				$.messager.progress({title : '变更老师', msg : '正在变更老师，请稍等……'});
			},
			success: function (data) {
				$.messager.progress('close'); 
				var flag = data.flag;
				if(flag) {
					$.messager.alert('提示', "变更老师成功！", "info", function() {window.history.back();});
				} else {
					$.messager.alert('提示', data.msg);
				}
			} 
		});
	} else {
		$.messager.alert('提示', "请先变更老师或者更改班级性质！");
	}
}

//查看老师变更历史
function viewChangeTeacherHist() {
	$("#histDlg").dialog('open').dialog('setTitle', '老师变更历史');//设定表头  
}

function viewClassAttendInfo(){
	ajaxLoading("正在处理，请稍待。。。");
	window.location.href = "/sys/attend/getAttenceCalendarView.do?funcNodeId="+$("#funcNodeId").val()+"&classInstId="+$("#classInstId").val()+"&flag=maintenance";
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
