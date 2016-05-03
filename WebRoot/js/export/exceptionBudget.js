var editIndex = undefined;
$(document).ready(function() {
	initReportButton("reset","qryFm","schoolId")
	var tableName = $("#tableName").val();
	$("#year").combobox({
		url : "/sys/pubData/qryReportYearList.do?tableName=" + tableName,// 返回json数据的url
		valueField : "year",
    	textField : "year",
    	panelHeight : "auto",
    	formatter : function(data) {
    		return "<span>" + data.year + "</span>";
    	},
    	onLoadSuccess:function(data) {
    		if(data.length > 0) {
    			var date = new Date;
    			var current_year = date.getFullYear();
				$('#year').combobox('setValue', current_year);
			} else {
				$("#month").combobox('clear');
				$("#month").combobox("loadData", new Array());
			}
    	},
    	onChange : function(n, o) {
    		$("#month").combobox({
    			url : "/sys/pubData/qryReportMonthList.do?tableName=" + tableName + "&year=" + n,// 返回json数据的url
    	    	valueField : "month",
    	    	textField : "monthText",
    	    	panelHeight : "auto",
    	    	formatter : function(data) {
    	    		return "<span>" + data.monthText + "</span>";
    	    	},
    	    	onLoadSuccess:function(data) {
    	    		if(data.length > 0) {
    					$('#month').combobox('setValue', data[0].month);
    				}
    	    	}
    		});
    	}
	});
	
	$("#qryBtn").click(function() {
		initPageNumber("list_data");
		var object = $("#qryFm").serializeObject();
		var obj = JSON.stringify(object);
		obj = obj.substring(0, obj.length - 1);
		var funcNodeId = $("#qryBtn").attr("funcNodeId");
		obj += ",\"funcNodeId\":\""+funcNodeId+"\"}";
		$('#list_data').datagrid({
			url : "/sys/pubData/qryDataListByPage.do",
			queryParams:{
				param : obj
			},
			onLoadSuccess:function() {
				$(".number").numberbox();
				mergeCellsByField("list_data", "schoolName");
			}
		});
    });
	
	$("#reset").click(function() {
		data = $("#year").combobox("getData");
		if(data.length > 0) {
			var date = new Date;
			var current_year = date.getFullYear();
			$('#year').combobox('setValue', current_year);
		}
	});
	
	$("#create").click(function() {
		var flag = true;
		var date = new Date;
		var next_month = date.getMonth() + 2;
		var current_year = date.getFullYear(); 
		var data = $("#month").combobox("getData");
		if(data.length > 0) {
			var year = $("#year").combobox("getValue");
			next_month = (next_month < 10 ? "0" + next_month : next_month);
			for(var i = 0, len = data.length; i < len; i++) {
				var month = data[i].month;
				if(year == current_year && next_month == month) {
					flag = false;
					break;
				}
			}
		}
		if(flag) {
			var schoolId = $("#schoolId").combobox("getValue");
			var schoolName = $("#schoolId").combobox("getText");
			$.ajax({
				url : "/sys/budget/createNextMonthBudget.do",// 返回json数据的url
				type : "post",
				data : "schoolId=" + schoolId + "&schoolName=" + schoolName,
				dataType : "json",
				async : true,
				beforeSend: function() {
					$.messager.progress({title : '异动预算', msg : '正在创建下月异动预算，请稍等……'});
				},
				success: function (data) {
					$.messager.progress('close'); 
					if(data.flag) {
						$.messager.alert('提示', "创建下月异动预算成功！", "info", function() {$("#qryBtn").click();});
					} else {
						$.messager.alert('提示', data.msg);
					}
				}
			});
		} else {
			$.messager.alert('提示', current_year + "年" + next_month + "月的异动预算记录已创建，不需要再次创建！");
		}
	});
	
	$("#submit").click(function() {
		var rows = $('#list_data').datagrid('getRows');
		if(rows != null && rows != undefined && rows.length > 0) {
			var year = $("#year").combobox("getValue");
			var month = rows[1].month;
			var date = new Date;
			var current_year = date.getFullYear(); 
			var next_month = date.getMonth() + 2;
			next_month = (next_month < 10 ? "0" + next_month : next_month);
			if(year == current_year && month == next_month) {
				var object = $("#qryFm").serializeObject();
				var param = JSON.stringify(object);
				var budgetArray = "[";
				var studyingNum = rows[0].studyingNum; 
				var exceptionNum = rows[0].exceptionNum; 
				var studentInSchoolNum = rows[0].studentInSchoolNum;
				for(var i = 1, len = rows.length; i < len; i++) {
					//本周新招
					var newPlanNum = $("#newPlan" + i).textbox("getValue");
					//转入进班
					var changeInClassNum = $("#changeIn" + i).textbox("getValue");
					//转出进班
					var changeOutClassNum = $("#changeOut" + i).textbox("getValue");
					//本周结课  已升
					var finishHigherNum = $("#finishHigher" + i).textbox("getValue");
					//本周结课  在读
					var finishStudyingNum = $("#finishStudying" + i).textbox("getValue");
					//在读退费
					var studyingRefundNum = $("#studyingRefund" + i).textbox("getValue");
					//异动退费
					var exceptionRefundNum = $("#exceptionRefund" + i).textbox("getValue");
					//异动进班人数
					var exceptionInClassNum = $("#exceptionIn" + i).textbox("getValue");
					//在读人数 = 上周在读人数 + 本周异动进班人数 - 本周结课在读 + 本周转入进班 - 本周在读退费
					studyingNum = parseInt(studyingNum) + parseInt(exceptionInClassNum) - parseInt(finishStudyingNum) + parseInt(changeInClassNum) - parseInt(studyingRefundNum);
					//异动人数 = 上周异动人数 - 本周异动进班人数 + 本周结课已升学 + 本周新招 - 本周异动退费 - 本周转出进班  
					exceptionNum = parseInt(exceptionNum) - parseInt(exceptionInClassNum) + parseInt(finishHigherNum) + parseInt(newPlanNum) - parseInt(exceptionRefundNum) - parseInt(changeOutClassNum);
					//在校人数 = 本周在读人数 + 本周异动总人数	
					studentInSchoolNum = parseInt(studyingNum) + parseInt(exceptionNum);
					var budgetObj = new Object();
					budgetObj.exceptionBudgetId = rows[i].exceptionBudgetId;
					budgetObj.newPlanNum = newPlanNum;
					budgetObj.finishHigherNum = finishHigherNum;
					budgetObj.changeInClassNum = changeInClassNum;
					budgetObj.changeOutClassNum = changeOutClassNum;
					budgetObj.finishStudyingNum = finishStudyingNum;
					budgetObj.studyingRefundNum = studyingRefundNum;
					budgetObj.exceptionRefundNum = exceptionRefundNum;
					budgetObj.exceptionInClassNum = exceptionInClassNum;
					budgetObj.studyingNum = studyingNum;
					budgetObj.exceptionNum = exceptionNum;
					budgetObj.studentInSchoolNum = studentInSchoolNum;
					budgetArray += JSON.stringify(budgetObj) + ",";
				}
				if(budgetArray.length > 1) {
					budgetArray = budgetArray.substring(0, budgetArray.length - 1);
				}
				budgetArray += "]";
				param = param.substring(0, param.length - 1) + ",\"budgetArray\":" + budgetArray + "}";
				$.ajax({
					url : "/sys/budget/batchUpdateNextMonthBudget.do",// 返回json数据的url
					type : "post",
					data : "param=" + param,
					dataType : "json",
					async : true,
					beforeSend: function() {
						$.messager.progress({title : '异动预算', msg : '正在提交异动预算，请稍等……'});
					},
					success: function (data) {
						$.messager.progress('close'); 
						if(data.flag) {
							$.messager.alert('提示', "提交异动预算成功！", "info", function() {$("#qryBtn").click();});
						} else {
							$.messager.alert('提示', data.msg);
						}
					}
				});
			} else {
				$.messager.alert('提示', "您查询的异动数据不是下月的异动数据，不能提交！");
			}
		} else {
			$.messager.alert('提示', "您还没有查询异动数据，请先查询异动数据！");
		}
	});
	
	$("#export").click(function(){
		var total = $("#list_data").datagrid("getData").total;
		if(total > 0) {
			var fileName = parent.$("li.tabs-selected").find("span.tabs-title").html();
			try {
				window.location.href = "/sys/export/exportCenterGradeRate.do?fileName="+fileName+"&param="+JSON.stringify($("#list_data").datagrid("options").queryParams.param);
			} catch(e) {
				$.messager.alert('提示', "模版不存在！",function() {window.history.back();});
			}
		} else {
			$.messager.alert('提示', "没有数据可以导出！");
		}	
	});
});

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

//function endEditing() {
//	var flag = true;
//	if (editIndex != undefined) {
//		if ($('#list_data').datagrid('validateRow', editIndex)) {
//			$('#list_data').datagrid('endEdit', editIndex);
//			editIndex = undefined;
//		} else {
//			flag = false;
//		}
//	}
//	mergeCellsByField("list_data", "schoolName");
//	return flag;
//}
//
//function onClickCell(index, field) {
//	if (editIndex != index) {
//		if (endEditing()) {
//			$('#list_data').datagrid('selectRow', index).datagrid('beginEdit', index);
//			editIndex = index;
//		} else {
//			$('#list_data').datagrid('selectRow', editIndex);
//		}
//	}
//}