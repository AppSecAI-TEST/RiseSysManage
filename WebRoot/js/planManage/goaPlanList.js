$(document).ready(function() {
	ajaxLoading("正在处理，请稍待。。。");
	if($("#schoolId").length > 0) {
		$("#schoolId").combobox({
			valueField : "schoolId",
			textField : "schoolName",
			panelHeight : "auto",
			loader: function(param, success, error) {
			    $.ajax({
					url: "/sys/pub/pageCategory.do?staffId="+$("#handlerId").val()+"&resourceId=710&fieldId=schoolId",  
					dataType: 'json',  
					success: function(data) {
						if(data.length == schoolData.length) {
							data.unshift({schoolName:'全部校区',schoolId:""});  
						}
						success(data);  
					}
				});  
	   		},
	   		formatter : function(data) {
				return "<span>" + data.schoolName + "</span>";
			},
			onLoadSuccess : function(data) {
				ajaxLoadEnd();
				if(data.length > 0) {
					$("#schoolId").combobox("setValue", data[0].schoolId);
				}
			}
		});
	}
	
	initYearAndMonth("year", null);
	initYearAndMonth("planYear", null);
	$("#qryBtn").click(function() {
		initPageNumber("list_data");
		var object = $("#qryFm").serializeObject();
		var funcNodeId = $("#qryBtn").attr("funcNodeId");
		object.funcNodeId = funcNodeId;
    	var obj = JSON.stringify(object);
    	$('#list_data').datagrid({
    		url : "/sys/planManage/qryDataListByPage.do",
    		queryParams:{
    			param : obj
    		},
    		onLoadSuccess:function() {
    			onLoadSuccess();
    			$('#list_data').datagrid('clearSelections');
    			$('.edit').linkbutton({text:'修改计划', iconCls:'icon-edit'});
    			$('.remove').linkbutton({text:'删除计划', iconCls:'icon-remove'});
    		}
    	});
	});
	$("#resetBtn").click(function() {
		$("#qryFm").form('clear');//清空窗体数据  
		//校区赋默认值
		var schoolArr =['schoolId', 'schoolIds'];
		for(var i = 0; i < schoolArr.length; i++) {
			var schoolObj = $("#qryFm").find("#"+schoolArr[i]);
		    if(schoolObj.length > 0) {
		    	if(schoolObj.combobox("getData").length > 0) {
		    		schoolObj.combobox("select",schoolObj.combobox("getData")[0].schoolId);
		    	}	
		    }	
		}
	});
	$("#addPlan").click(function(){
		showAdd();
	});
	$("#updatePlan").click(function(){
		showUpdate();
	});
	$("#deletePlan").click(function(){
		del();
	});
});

function onLoadSuccess() {
	MergeCellWidthSchool("list_data", "schoolName,planYear,planQuarter");
}

function MergeCellWidthSchool(tableID, fldList) {
	var Arr = fldList.split(",");
	var dg = $('#' + tableID);
	var fldName;
	var RowCount = dg.datagrid("getRows").length;
	var span;
	var PerValue = "";
	var PreSchool ="";
	var CurValue = "";
	var CurSchool ="";
	var length = Arr.length - 1;
	for (i = length; i >= 0; i--) {
		fldName = Arr[i];
		PerValue = "";
		PreSchool="";
		span = 1;
		for (row = 0; row <= RowCount; row++) {
			if (row == RowCount) {
				CurValue = "";
				CurSchool="";
			} else {
				CurValue = dg.datagrid("getRows")[row][fldName];
				CurSchool =  dg.datagrid("getRows")[row]["schoolId"]
			}
			if (PerValue == CurValue && PreSchool == CurSchool) {
				span += 1;
			} else {
				var index = row - span;
                dg.datagrid('mergeCells', {
                	index: index,
                	field: fldName,
                	rowspan: span,
                	colspan: null
                });
                if("planYear" == fldName) {
                	dg.datagrid('mergeCells', {
                		index: index,
                		field: "ck",
                		rowspan: span,
                		colspan: null
                	});
                } else if("planQuarter" == fldName) {
                	dg.datagrid('mergeCells', {
                		index: index,
                		field: "valueVal",
                		rowspan: span,
                		colspan: null
                	});
                }
                span = 1;
                PerValue = CurValue;
                PreSchool = CurSchool;
			}
		}
	}
}

function showAdd() {
	$("#dlg").dialog('open').dialog('setTitle', '添加年度升学目标计划');
    $('#fm').form('clear');
    $("#type").val("ADD");
    $("#schoolIds").combobox("enable");
    $("#planYear").combobox("enable");
    $("#submitBtn").unbind();
    $("#submitBtn").click(function(){
    	add();
    });
}

function add() {
	if(checkParam()) {
		var array = new Array();
		var schoolId = $("#schoolIds").combobox("getValue");
		var planYear = $("#planYear").combobox("getValue");
		var handlerId = $("#handlerId").val();
		$("[name='value']").each(function(i, obj) {
			var param = {
				schoolId: schoolId,
				planYear: planYear,
				firstValue: i + 1,
				secondValue: obj.value,
				planType: "goa",
				state: "00A",
				handlerId: handlerId
			}
			array.push(param);
		});
		var planMonth = 0;
		$("[name='value']").each(function(i, obj) {
			var firstValue = i + 1;
			$("[name='month_" + firstValue + "']").each(function(j, object) {
				planMonth++;
				var param = {
					schoolId: schoolId,
					planYear: planYear,
					planMonth: planMonth,
					firstValue: firstValue,
					secondValue: object.value,
					planType: "goa",
					state: "00A",
					handlerId: handlerId
				}
				array.push(param);
			});
		});
		$.ajax({
			type : "POST",
			url : "/sys/planManage/add.do",
			data :"param=" + JSON.stringify(array),
			async : true,
			dataType: "json",
			beforeSend : function() {
				showProgressLoader("正在添加计划,请稍等...", 400);
			},
			success : function(data) {
				hideProgressLoader();
				if (data.flag) {
					showMessage('提示', "添加年度升学目标计划成功！", function() {
						hideMessage();
						$("#dlg").dialog('close');
						$("#qryBtn").trigger("click");
					});
				} else {
					showMessage('提示', "添加年度升学目标计划失败！", null);
				}
			},
			error : function() {
				hideProgressLoader();
				showMessage('提示', "调用添加年度升学目标计划服务失败！", null);
			}
		});
	}
}

function showUpdate() {
	var row = $('#list_data').datagrid('getSelected');
	if(row) {
		var schoolId = row.schoolId;
		var planYear = row.planYear;
		$("#dlg").dialog('open').dialog('setTitle', '修改年度升学目标计划');
		$('#fm').form('clear');
		$("#type").val("UPDATE");
		$("#submitBtn").unbind();
		$("#submitBtn").click(function(){
			update();
		});
		$("#schoolIds").combobox("disable");
		$("#planYear").combobox("disable");
		$("#schoolIds").combobox("setValue", schoolId);
		$("#planYear").combobox("setValue", planYear);
		$("#updateSchoolId").val(schoolId);
		$("#updatePlanYear").val(planYear);
		$.ajax({
			type : "POST",
			url : "/sys/planManage/qryPlan.do",
			data :"schoolId=" + schoolId + "&planYear=" + planYear + "&planType=goa",
			async : true,
			dataType: "json",
			beforeSend : function() {
				showProgressLoader("正在查询年度升学目标计划,请稍等...", 400);
			},
			success : function(data) {
				hideProgressLoader();
				$.each(data, function(i, obj) {
					var planId = obj.planId;
					var planMonth = obj.planMonth;
					var secondValue = obj.secondValue;
					if(planMonth == "0") {
						var firstValue = obj.firstValue;
						$("#planId_quarter_" + firstValue).val(planId);
						$("#value_" + firstValue).numberbox("setValue", secondValue);
					} else {
						$("#planId_month_" + planMonth).val(planId);
						$("#planMonth_" + planMonth).numberbox("setValue", secondValue);
					}
				});
			}
		});
	} else {
		$.messager.alert('提示', "请先选择您要修改的年度升学目标计划！");
	}
}

function update() {
	if(checkParam()) {
		var planIds = "";
		var obj = new Object();
		var array = new Array();
		var schoolId = $("#updateSchoolId").val();
		var planYear = $("#updatePlanYear").val();
		var handlerId = $("#handlerId").val();
		$("[name='value']").each(function(i, obj) {
			var planId = $("#planId_quarter_" + (i + 1)).val();
			if(planId != null && planId != "" && planId != undefined) {
				planIds += planId + ",";
			}
			var param = {
				schoolId: schoolId,
				planYear: planYear,
				firstValue: i + 1,
				secondValue: obj.value,
				planType: "goa",
				state: "00A",
				handlerId: handlerId
			}
			array.push(param);
		});
		var planMonth = 0;
		$("[name='value']").each(function(i, obj) {
			var firstValue = i + 1;
			$("[name='month_" + firstValue + "']").each(function(j, object) {
				planMonth++;
				var planId = $("#planId_month_" + planMonth).val();
				if(planId != null && planId != "" && planId != undefined) {
					planIds += planId + ",";
				}
				var param = {
					schoolId: schoolId,
					planYear: planYear,
					planMonth: planMonth,
					firstValue: firstValue,
					secondValue: object.value,
					planType: "goa",
					state: "00A",
					handlerId: handlerId
				}
				array.push(param);
			});
		});
		if(planIds != "" && planIds != null && planIds != undefined) {
			planIds = planIds.substring(0, planIds.length - 1);
		}
		obj.planId = planIds;
		obj.array = JSON.stringify(array);
		$.ajax({
			type : "POST",
			url : "/sys/planManage/update.do",
			data :"param=" + JSON.stringify(obj),
			async : true,
			dataType: "json",
			beforeSend : function() {
				showProgressLoader("正在修改年度升学目标计划,请稍等...", 400);
			},
			success : function(data) {
				hideProgressLoader()
				if (data.flag) {
					showMessage('提示', "修改年度升学目标计划成功！", function() {
						hideMessage();
						$("#dlg").dialog('close');
						$("#qryBtn").trigger("click");
					});
				} else {
					showMessage('提示', "修改年度升学目标计划失败！", null);
				}
			},
			error : function() {
				hideProgressLoader();
				showMessage('提示', "调用修改年度升学目标计划服务失败！", null);
			}
		});
	}
}

function del() {
	var row = $('#list_data').datagrid('getSelected');
	if(row) {
		var schoolId = row.schoolId;
		var planYear = row.planYear;
		$.messager.confirm('提示', '您确定要删除当前选中的计划吗？', function(r) {
			if(r) {
				$.ajax({
					type : "POST",
					url : "/sys/planManage/delPlan.do",
					data :"schoolId=" + schoolId + "&planYear=" + planYear + "&planType=goa",
					async : true,
					dataType: "json",
					beforeSend : function() {
						showProgressLoader("正在删除年度升学目标计划,请稍等...", 400);
					},
					success : function(data) {
						hideProgressLoader()
						if (data.flag) {
							showMessage('提示', "删除年度升学目标计划成功！", function() {
								hideMessage();
								$("#qryBtn").trigger("click");
							});
						} else {
							showMessage('提示', "删除年度升学目标计划失败！", null);
						}
					},
					error : function() {
						hideProgressLoader();
						showMessage('提示', "调用删除年度升学目标计划服务失败！", null);
					}
				});
			}
		});
	} else {
		$.messager.alert('提示', "请先选择您要删除的年度升学目标计划！");
	}
}

function validateSelect() {
	var flag = false;
	var obj = $("#list_data").datagrid('getSelections');
	if(obj.length > 0) {
		if(obj.length > 1) {
			$.messager.alert('提示', "只能选择一条记录操作！");
		} else {
			flag = true;
		}
	} else {
		$.messager.alert('提示', "请先选择一条记录！");
	}
	return flag;
}

function checkParam() {
	var type = $("#type").val();
	if("ADD" == type) {
		var schoolIds = $("#schoolIds").combobox("getValue");
		if(schoolIds == "" || schoolIds == null || schoolIds == undefined) {
			$.messager.alert('提示', "请先选择校区");
			return false;
		}
		var planYear = $("#planYear").combobox("getValue");
		if(planYear == "" || planYear == null || planYear == undefined) {
			$.messager.alert('提示', "请先选择年份");
			return false;
		}
	}
	var firstValue = $("#value_1").numberbox("getValue");
	if(firstValue == "" || firstValue == null || firstValue == undefined) {
		$.messager.alert('提示', "请先填写一季度升学目标");
		return false;
	}
	var secondValue = $("#value_2").numberbox("getValue");
	if(secondValue == "" || secondValue == null || secondValue == undefined) {
		$.messager.alert('提示', "请先填写二季度升学目标");
		return false;
	}
	var thirdValue = $("#value_3").numberbox("getValue");
	if(thirdValue == "" || thirdValue == null || thirdValue == undefined) {
		$.messager.alert('提示', "请先填写三季度升学目标");
		return false;
	}
	var fourthValue = $("#value_4").numberbox("getValue");
	if(fourthValue == "" || fourthValue == null || fourthValue == undefined) {
		$.messager.alert('提示', "请先填写四季度升学目标");
		return false;
	}
	for(var i = 0; i < 12; i++) {
		var month = i + 1;
		var planMonth = $("#planMonth_" + month).numberbox("getValue");
		if(planMonth == "" || planMonth == null || planMonth == undefined) {
			$.messager.alert('提示', "请先填写" + month + "月升学目标");
			return false;
		}
	}
	return true;
}