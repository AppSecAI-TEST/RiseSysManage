$(document).ready(function() {
	initYearAndMonth("year", null);
	initYearAndMonth("planYear", null);
	$("#qryBtn").click(function() {
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
		initYearAndMonth("year", null);
		initYearAndMonth("planYear", null);
	});
	$("#addPlan").click(function(){
		showAdd();
	});
});

function onLoadSuccess() {
	mergeCellsByField("list_data", "planYear");
}

function mergeCellsByField(tableId, colList) {
    var rowspan;
    var megerIndex;
    var before = "";
    var after = "";
    var target = $("#" + tableId);
    var colunms = colList.split(",");
    var rows = target.datagrid("getRows").length;
    for (var j = colunms.length - 1; j >= 0; j--) {
    	var field = colunms[j];
    	before = "";
        rowspan = 1;
        megerIndex = 0;
        for (var i = 0; i <= rows; i++) {
            if (i == rows) {
            	after = "";
            } else {
            	after = target.datagrid("getRows")[i][field];
            }
            if (before == after) {
            	rowspan += 1;
            } else {
            	target.datagrid("mergeCells", {
        			index: i - rowspan,
        			field: field,　　// 合并字段
        			rowspan: rowspan
        		});
            	rowspan = 1;
            }
            before = after;
        }
    }
}

function showAdd() {
	$("#dlg").dialog('open').dialog('setTitle', '添加计划');
    $('#fm').form('clear');
    $("#type").val("ADD");
    $("#submitBtn").unbind();
    $("#submitBtn").click(function(){
    	add();
    });
}

function add() {
	if(checkParam()) {
		var array = new Array();
		var planYear = $("#planYear").combobox("getValue");
		var handlerId = $("#handlerId").val();
		$("[name='value']").each(function(i, obj) {
			var text = $("#text_" + i).html();
			var stageId = text.substring(0, text.length - 5);
			var param = {
				schoolId: "10",
				planYear: planYear,
				firstValue: obj.value,
				stageId: stageId,
				planType: "stage_goa",
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
					showMessage('提示', "添加计划成功！", function() {
						hideMessage();
						$("#dlg").dialog('close');
						$("#qryBtn").trigger("click");
					});
				} else {
					showMessage('提示', "添加计划失败！", null);
				}
			},
			error : function() {
				hideProgressLoader();
				showMessage('提示', "调用添加计划服务失败！", null);
			}
		});
	}
}

function showUpdate(schoolId, planYear) {
	$("#planYear").combobox({disabled: true});
	$("#planYear").combobox("setValue", planYear);
	$("#updateSchoolId").val(schoolId);
	$("#updatePlanYear").val(planYear);
	$.ajax({
		type : "POST",
		url : "/sys/planManage/qryPlan.do",
		data :"schoolId=" + schoolId + "&planYear=" + planYear + "&planType=stage_goa",
		async : true,
		dataType: "json",
		beforeSend : function() {
			showProgressLoader("正在查询计划,请稍等...", 400);
		},
		success : function(data) {
			hideProgressLoader();
			$.each(data, function(i, obj) {
				var stageId = obj.stageId;
				$("#planId_" + stageId).val(obj.planId);
				$("#value_" + stageId).numberbox("setValue", obj.firstValue);
			});
			$("#dlg").dialog('open').dialog('setTitle', '修改计划');
			$('#fm').form('clear');
			$("#type").val("UPDATE");
			$("#submitBtn").unbind();
			$("#submitBtn").click(function(){
				update();
			});
		}
	});
}

function update() {
	if(checkParam()) {
		var array = new Array();
		var schoolId = $("#updateSchoolId").val();
		var planYear = $("#updatePlanYear").val();
		var handlerId = $("#handlerId").val();
		$("[name='value']").each(function(i, obj) {
			var text = $("#text_" + i).html();
			var stageId = text.substring(0, text.length - 5);
			var param = {
				planId: $("#planId_" + stageId).val(),
				schoolId: schoolId,
				planYear: planYear,
				firstValue: obj.value,
				stageId: stageId,
				planType: "stage_goa",
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
				showProgressLoader("正在修改计划,请稍等...", 400);
			},
			success : function(data) {
				hideProgressLoader()
				if (data.flag) {
					showMessage('提示', "修改计划成功！", function() {
						hideMessage();
						$("#dlg").dialog('close');
						$("#qryBtn").trigger("click");
					});
				} else {
					showMessage('提示', "修改计划失败！", null);
				}
			},
			error : function() {
				hideProgressLoader();
				showMessage('提示', "调用添加计划服务失败！", null);
			}
		});
	}
}

function del(schoolId, planYear) {
	$.messager.confirm('提示', '您确定要删除当前选中的计划吗？', function(r) {
		if(r) {
			$.ajax({
				type : "POST",
				url : "/sys/planManage/delPlan.do",
				data :"schoolId=" + schoolId + "&planYear=" + planYear + "&planType=stage_goa",
				async : true,
				dataType: "json",
				beforeSend : function() {
					showProgressLoader("正在删除计划,请稍等...", 400);
				},
				success : function(data) {
					hideProgressLoader()
					if (data.flag) {
						showMessage('提示', "删除计划成功！", function() {
							hideMessage();
							$("#qryBtn").trigger("click");
						});
					} else {
						showMessage('提示', "删除计划失败！", null);
					}
				},
				error : function() {
					hideProgressLoader();
					showMessage('提示', "调用删除计划服务失败！", null);
				}
			});
		}
	});
}

function checkParam() {
	var type = $("#type").val();
	if("ADD" == type) {
		var planYear = $("#planYear").combobox("getValue");
		if(planYear == "" || planYear == null || planYear == undefined) {
			$.messager.alert('提示', "请先选择年份");
			return false;
		}
	}
	for(var i = 0, len = $("[name='value']").length; i < len; i++) {
		var text = $("#text_" + i).html();
		var stageId = text.substring(0, text.length - 5);
		var value = $("#value_" + stageId).numberbox("getValue");
		if(value == "" || value == null || value == undefined) {
			text = text.substring(0, text.length - 1);
			$.messager.alert('提示', "请先填写" + text);
			return false;
		}
	}
	return true;
}