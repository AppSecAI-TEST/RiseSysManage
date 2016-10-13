var schoolData = [1001,1002,1003,1004,1005,1006,1007,1008,1009,1010,1011,1012,1013,1014,1015,1016,1017,1018,1019,1020];
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
    		url : "/sys/pubData/qryDataListByPage.do",
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
	MergeCellWidthSchool("list_data", "schoolName,planYear");
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
                    }
                    else {
                        CurValue = dg.datagrid("getRows")[row][fldName];
                        CurSchool =  dg.datagrid("getRows")[row]["schoolId"]
                    }
                    if (PerValue == CurValue&&PreSchool==CurSchool) {
                        span += 1;
                    }
                    else {
                        var index = row - span;
                        dg.datagrid('mergeCells', {
                            index: index,
                            field: fldName,
                            rowspan: span,
                            colspan: null
                        });
                        dg.datagrid('mergeCells', {
                            index: index,
                            field: "ck",
                            rowspan: span,
                            colspan: null
                        });
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
					$("#planId_" + (i + 1)).val(obj.planId);
					$("#value_" + (i + 1)).numberbox("setValue", obj.secondValue);
				});
			}
		});
	} else {
		$.messager.alert('提示', "请先选择您要修改的年度升学目标计划！");
	}
}

function update() {
	if(checkParam()) {
		var array = new Array();
		var schoolId = $("#updateSchoolId").val();
		var planYear = $("#updatePlanYear").val();
		var handlerId = $("#handlerId").val();
		$("[name='value']").each(function(i, obj) {
			var param = {
				planId: $("#planId_" + (i + 1)).val(),
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
		$.ajax({
			type : "POST",
			url : "/sys/planManage/update.do",
			data :"param=" + JSON.stringify(array),
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
	return true;
}