var addSchoolNum = 0;
var addHigherSchool = 0;
var selTr = null;
$(document).ready(function() {
	//学员来源类型
	$('#studentChannelType').combobox({
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
		onChange : function(n, o) {
			$("#classType").combobox({
        		url : "/sys/pubData/qryData.do?param={queryCode:\"Qry_Stage_Class\",stageId:\""+n+"\"}",//返回json数据的url
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
					$("#higherSchoolNameTr").after(addHigherSchoolTr);
					$("#higherSchoolName").val(text);
					$("#higherSchoolId").val(classInstId);
					$("#higherSchoolNameTr").after(higherSchoolNameTr);
				} else {
					var higherOptionSchoolName = $("#higherOptionSchoolName").html();
					higherOptionSchoolName += "，" + text;
					$("#higherOptionSchoolName").html(higherOptionSchoolName);
					$("#higherSchoolName").val(higherOptionSchoolName);
					$("#higherSchoolId").val("," + classInstId);
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
					$(node).html("<span>" + lessionHours + "</span><input type='hidden' name='schooltimes' roomId='"+roomId+"' weekTime='"+weekTime+"' hourRange='"+hourRange+"' lessionHours='"+lessionHours+"'/>");
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
		}
	});
	
	//点击提交老师
	$("#addTeacherSubmit").click(function() {
		var teacherId = $("#teacherId").combobox("getValue");
		var flag = true;
		if($("[name='teachers']").length > 0) {
			$("[name='teachers']").each(function() {
				var selTeacherId = $(this).attr("teacherId");
				if(teacherId == selTeacherId) {
					flag = false;
				}
			});
		}
		if(flag) {
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
			alert(weekTime);
			alert(hourRange);
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
						content += "<span id=teacher"+teacherId+">";
						if(content != "" && content != null && content != undefined) {
							content += "&nbsp;&nbsp;";
						}
						var teacherText = teacherSchoolName + " " + teacherName + " " + lessions + " " + licenseFlagText;
						content += teacherText + "&nbsp;<a href='javascript:void(0)' class='linkmore' onclick='deleteTeacher("+teacherId+")'><span>删除</span></a>";
						content += "<input type='hidden' name='teachers' teacherId='"+teacherId+"' weekTime='"+weekTime+"' hourRange='"+hourRange+"'/></span>";
						$(node).html(content);
						$(node).attr("lessions", lessions);
					}
				});
				$('#dlg').dialog('close');
			} else {
				$.messager.alert('提示', "该上课时段可用的课时为"+subLessions+"个课时，请填写的课时小于或者等于"+subLessions+"！");
			}
		} else {
			$.messager.alert('提示', "该上课时段已经添加该带班老师，请选择另一个老师！");
		}
	});
});


//添加代班老师
function addTeacher(obj) {
	$("#dlg").dialog('open').dialog('setTitle', '添加老师');//设定表头  
	$('#addTeacherFm').form('clear');//清空窗体数据  
	$("#licenseFlagText").html("");
	selTr = $(obj).parent().parent();
}

function deleteTeacher(teacherId)
{
	$("#teacher" + teacherId).html("");
//	if($("[name='teachers']").length > 0) {
//		$("[name='teachers']").each(function() {
//			var selTeacherId = $(this).attr("teacherId");
//			if(teacherId == selTeacherId) {
//				$(this).attr("teacherId", "");
//				$(this).attr("teacherId", "");
//				$(this).attr("teacherId", "");
//			}
//		});
//	}
}

//删除上课时段
function deleteSchooltime(obj) {
	$(obj).parent().parent().remove();
	addSchoolNum--;
}