$(document).ready(function() {
	var applyId = $("#applyId").val();
	var param = "{\"applyId\":\""+applyId+"\",\"queryCode\":\"qryChangeDetailById\"}";
	$.ajax({
		url: "/sys/applyClass/qryDataByQueryCode.do",
		data: "param=" + param,
		dataType: "json",
		async: true,
		beforeSend: function()
		{
			$.messager.progress({title : '转班', msg : '正在查询更改转班信息，请稍等……'});
		},
		success: function (data) {
			$.messager.progress('close'); 
			var inClassId = data.inClassId;
			var isSelect = "N";
			if(inClassId != "" && inClassId != null && inClassId != undefined) {
				isSelect = "Y";
			}
			$("input[name='isSelect'][value='"+isSelect+"']").attr("checked", "checked");
			initIsSelect(isSelect);
			var outClassId = data.outClassId;
			$("#nameText").html(data.name);
			$("#birthdayText").html(data.birthday);
			$("#feeTypeText").html(data.feeTypeText);
			$("#sexText").html(data.sexText);
			$("#identityIdText").html(data.identityId);
			$("#phoneText").html(data.phone);
			$("#byNameText").html(data.byName);
			$("#dutyAdvisterNameText").html(data.dutyAdvisterName);
			$("#adviserTeacherNameText").html(data.adviserTeacherName);
			$("#payDateText").html(data.payDate);
			$("#classTypeText").html(data.classType);
			$("#planInClassNameText").html(data.planInClassName);
			$("#outClassNameText").html(data.outClassName);
			$("#outClassProgressText").html(data.outClassProgress);
			$("#outDateText").html(data.outDate);
			$("#stageId").val(data.stageId);
			$("#classType").val(data.classType);
			$("#inClassId").val(inClassId);
			$("#courseType").val(data.courseType);
			$("#outClassId").val(outClassId);
			$("#currentSelectClassName").html(data.inClassName);
			$("#currentSelectClassDate").html(data.inDate);
			$("#selectClassNum").html(data.selectClassNum);
			var inClassIsBegin = data.inClassIsBegin;
			$("#inClassIsBegin").val(inClassIsBegin);
			if(inClassIsBegin != null && inClassIsBegin != "" && inClassIsBegin != undefined) {
				$("input[name='isBegin'][value='"+inClassIsBegin+"']").attr("checked", "checked");
				initClassInst(inClassIsBegin);
			} else {
				var planInClassIsBegin = data.planInClassIsBegin;
				$("input[name='isBegin'][value='"+planInClassIsBegin+"']").attr("checked", "checked");
				initClassInst(planInClassIsBegin);
			}
			var feeType = data.feeType;
			var studentChannelType = "";
			if("001" == feeType) {
				studentChannelType = data.feeTypeText;
			} else {
				studentChannelType = data.schoolName + data.oldClassName + data.feeTypeText;
			}
			$("#studentChannelType").val(studentChannelType);
		}
	});
	
	$("input:radio[name='isBegin']").change(function() {
		var isBegin = $("input:radio[name='isBegin']:checked").val();
		initClassInst(isBegin);
	});
	
	//是否定班
	$("input:radio[name='isSelect']").change(function() {
		var isSelect = $("input:radio[name='isSelect']:checked").val();
		initIsSelect(isSelect);
	});
	
	//更改转班
	$("#updateChangeSubmit").click(function() {
		var flag = true;
		var isSelect = $("input:radio[name='isSelect']:checked").val();
		if(isSelect != null && isSelect != "" && isSelect != undefined) {
			var obj = JSON.stringify($("#updateChangeClassFm").serializeObject());
			if("Y" == isSelect) {
				var isBegin = $("input:radio[name='isBegin']:checked").val();
				if(isBegin != "" && isBegin != null && isBegin != undefined) {
					var classInstId = "";
					var className = "";
					if("Y" == isBegin) {
						classInstId = $('#beginClassInstId').combobox('getValue');
						className = $('#beginClassInstId').combobox('getText');
					} else {
						classInstId = $('#notBeginClassInstId').combobox('getValue');
						className = $('#notBeginClassInstId').combobox('getText');
					}
					if(classInstId != null && classInstId != "" && classInstId != undefined) {
						var inClassId = $("#inClassId").val();
						if(inClassId == classInstId) {
							flag = false;
							$.messager.alert('提示', "您选择的班级"+className+"是现在该学员的转入班级，请您更换一个班级！");
						} else {
							var classStudentNum = $("#classStudentNum").html();
							var studentNum = parseInt(classStudentNum.split("/")[0]) + 1;
							var maxNum = parseInt(classStudentNum.split("/")[1]);
							if(studentNum > maxNum) {
								flag = false;
								$.messager.alert('提示', "您选择的"+className+"学员已经满员，不能再向该班级转入学员！");
							} else {
								obj = obj.substring(0, obj.length - 1);
								obj += ",\"classInstId\":\""+classInstId+"\",className:\""+className+"\"}";
							}
						}
					} else {
						flag = false;
						$.messager.alert('提示', "请选择一个转入班级！");
					}
				} else {
					flag = false;
					$.messager.alert('提示', "请选择一个转入班级的开课类型！");
				}
			}
			if(flag) {
				obj = encodeURI(obj);
				$.ajax({
					url: "/sys/change/updateChangeClass.do",
					data: "param=" + obj,
					dataType: "json",
					async: true,
					beforeSend: function()
					{
						$.messager.progress({title : '更改转班', msg : '正在更改转班，请稍等……'});
					},
					success: function (data) {
						$.messager.progress('close'); 
						var flag = data.flag;
						if(flag) {
							$.messager.alert('提示', "更改转班成功！", "info", function() {window.history.back();});
						} else {
							$.messager.alert('提示', data.msg);
						}
					} 
				});
			}
		} else {
			$.messager.alert('提示', "请选择是否定班！");
		}
	});
});

function initClassInst(isBegin) {
	var stageId = $("#stageId").val();
	var schoolId = $("#schoolId").val();
	var classType = $("#classType").val();
	var inClassId = $("#inClassId").val();
	var courseType = $("#courseType").val();
	var outClassId = $("#outClassId").val();
	if("Y" == isBegin) {
		$("#changeDiv").css("display", "none");
		$("#beginClassInstId").combobox({
    		url : "/sys/pubData/qryClassInstList.do?schoolId="+schoolId+"&courseType="+courseType+"&stageId="+stageId+"&classType="+classType+"&classState='003'&classInstId="+outClassId,//返回json数据的url
    		valueField : "classInstId",
    		textField : "className",
    		panelHeight : "auto",
    		formatter : function(data) {
    			return "<span>" + data.className + "</span>";
    		},
    		onLoadSuccess : function () { //数据加载完毕事件
                var data = $('#beginClassInstId').combobox('getData');
                if (data.length > 0) {
                	var flag = true;
                	if(inClassId != "" && inClassId != null && inClassId != undefined) {
                		for(var i = 0, len = data.length; i < len; i++) {
                			if(data[i].classInstId == inClassId) {
                				flag = false;
                				break;
                			}
                		}
                	}
                	if(flag) {
                		$("#beginClassInstId").combobox('select', data[0].classInstId);
                	} else {
                		$("#beginClassInstId").combobox('select', inClassId);
                	}
                	var classInstId = $("#beginClassInstId").combobox("getValue");
                	if(classInstId != "" && classInstId != null && classInstId != undefined) {
                		qryClassDetail(classInstId);
                	}
                } else {
                	$("#changeDiv").css("display", "none");
                }
            },
            onChange : function(n, o) {
            	if(n != "" && n != null && n != undefined) {
            		qryClassDetail(n);
            	}
            }
    	});
		$("#notBeginClassInstId").combobox('clear');
		$("#notBeginClassInstId").combobox("loadData", new Array());
	} else {
		$("#changeDiv").css("display", "none");
		$("#notBeginClassInstId").combobox({
    		url : "/sys/pubData/qryClassInstList.do?schoolId="+schoolId+"&courseType="+courseType+"&stageId="+stageId+"&classType="+classType+"&classState='001','002'&classInstId="+outClassId,//返回json数据的url
    		valueField : "classInstId",
    		textField : "className",
    		panelHeight : "auto",
    		formatter : function(data) {
    			return "<span>" + data.className + "</span>";
    		},
    		onLoadSuccess : function () { //数据加载完毕事件
                var data = $('#notBeginClassInstId').combobox('getData');
                if (data.length > 0) {
                	var flag = true;
                	if(inClassId != "" && inClassId != null && inClassId != undefined) {
                		for(var i = 0, len = data.length; i < len; i++) {
                			if(data[i].classInstId == inClassId) {
                				flag = false;
                				break;
                			}
                		}
                	}
                	if(flag) {
                		$("#notBeginClassInstId").combobox('select', data[0].classInstId);
                	} else {
                		$("#notBeginClassInstId").combobox('select', inClassId);
                	}
                	var classInstId = $("#notBeginClassInstId").combobox("getValue");
                    if(classInstId != "" && classInstId != null && classInstId != undefined) {
                    	qryClassDetail(classInstId);
                    }
                } else {
                	$("#changeDiv").css("display", "none");
                }
            },
            onChange : function(n, o) {
            	if(n != "" && n != null && n != undefined) {
            		qryClassDetail(n);
            	}
            }
    	});
		$("#beginClassInstId").combobox('clear');
		$("#beginClassInstId").combobox("loadData", new Array());
	}
}

function initIsSelect(isSelect) {
	//未定班  则不需要选班
	if(isSelect == "N") {
		$("#selectClassTr").find("td").each(function(i) {
			if(i == 1) {
				$(this).attr("colspan", 5);
			} else if(i > 1) {
				$(this).css("display", "none");
			}
		});
		$("#changeDiv").css("display", "none");
	} else {
		$("#selectClassTr").find("td").each(function(i) {
			if(i == 1) {
				$(this).attr("colspan", 1);
			} else if(i > 1) {
				$(this).css("display", "table-cell");
			}
		});
		$("#changeDiv").css("display", "block");
	}
}

function qryClassDetail(classInstId) {
	$("#changeDiv").css("display", "block");
	var param = "{\"classInstId\":\""+classInstId+"\",\"queryCode\":\"qryClassInstListById\"}";
	$.ajax({
		url: "/sys/applyClass/qryDataByQueryCode.do",
		data: "param=" + param,
		dataType: "json",
		async: true,
		beforeSend: function()
		{
			$.messager.progress({title : '班级维护', msg : '正在查询班级信息，请稍等……'});
		},
		success: function (data) {
			$.messager.progress('close'); 
			$("#classNameText").html(data.className);
			$("#applyDate").html(data.applyClassDate);
			$("#startDate").html(data.startDate);
			$("#teacherName").html(data.teacherName);
			$("#classStudentNum").html(data.classStudentNum);
			$("#classProgress").html(data.classProgress);
			$("#schooltimeName").html(data.schooltimeName);
		}
	});
}