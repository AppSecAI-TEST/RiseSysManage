var editIndex = undefined;
$(document).ready(function() {
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
				$('#year').combobox('setValue', data[0].year);
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
    					$("#qryBtn").click();
    				}
    	    	}
    		});
    	}
	});
	
	$("#qryBtn").click(function() {
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
//    		onBeforeEdit:function(index, row) {
//    			row.editing = true;
//    			$(this).datagrid('refreshRow', index);
//    		},
//    		onAfterEdit:function(index, row) {
//    			row.editing = false;
//    			$(this).datagrid('refreshRow', index);
//    		},
//    		onCancelEdit:function(index, row) {
//    			row.editing = false;
//    			$(this).datagrid('refreshRow', index);
//    		},
    		onLoadSuccess:function() {
    			// 一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题。
    			mergeCellsByField("list_data", "schoolName");
    		}
    	});
    });
	
	$("#reset").click(function() {
		var data = $("#schoolId").combobox("getData");
		if(data.length > 0) {
			$('#schoolId').combobox('setValue', data[0].schoolId);
		}
		data = $("#year").combobox("getData");
		if(data.length > 0) {
			$('#year').combobox('setValue', data[0].year);
		}
	});
	
	$("#create").click(function() {
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
					$.messager.alert('提示', "创建下月异动预算成功！");
				} else {
					$.messager.alert('提示', data.msg);
				}
			}
		});
	});
	
	$("#submit").click(function() {
		var object = $("#qryFm").serializeObject();
		var param = JSON.stringify(object);
		var rows = $('#list_data').datagrid('getRows');
		var budgetArray = "[";
		var studyingNum = rows[0].studyingNum; 
		var exceptionNum = rows[0].exceptionNum; 
		var studentInSchoolNum = rows[0].studentInSchoolNum;
		for(var i = 0, len = rows.length; i < len; i++) {
			var budgetObj = new Object();
			budgetObj.exceptionBudgetId = rows[i].exceptionBudgetId;
			var newPlanNum = rows[i].newPlanNum;
			budgetObj.newPlanNum = newPlanNum;
			var finishHigherNum = rows[i].finishHigherNum;
			budgetObj.finishHigherNum = finishHigherNum;
			var changeInClassNum = rows[i].changeInClassNum;
			budgetObj.changeInClassNum = changeInClassNum;
			var changeOutClassNum = rows[i].changeOutClassNum;
			budgetObj.changeOutClassNum = changeOutClassNum;
			var finishStudyingNum = rows[i].finishStudyingNum;
			budgetObj.finishStudyingNum = finishStudyingNum;
			var studyingRefundNum = rows[i].studyingRefundNum;
			budgetObj.studyingRefundNum = studyingRefundNum;
			var exceptionRefundNum = rows[i].exceptionRefundNum;
			budgetObj.exceptionRefundNum = exceptionRefundNum;
			var exceptionInClassNum = rows[i].exceptionInClassNum;
			budgetObj.exceptionInClassNum = exceptionInClassNum;
			budgetObj.studyingNum = studyingNum;
			budgetObj.exceptionNum = exceptionNum;
			budgetObj.studentInSchoolNum = studentInSchoolNum;
			//异动人数 = 上周异动人数 - 异动进班人数 + 本周结课已升学 + 本周新招 - 异动退费 - 转出进班  
			exceptionNum = parseInt(exceptionNum) - parseInt(exceptionInClassNum) + parseInt(finishHigherNum) + parseInt(newPlanNum) - parseInt(exceptionRefundNum) - parseInt(changeOutClassNum);
			alert(exceptionNum);
			//在读人数 = 上周在读人数 + 本周异动进班人数 - 本周结课在读 + 转入进班 - 在读退费
			studyingNum = parseInt(studyingNum) + parseInt(exceptionInClassNum) - parseInt(finishStudyingNum) + parseInt(changeInClassNum) - parseInt(studyingRefundNum);
			//在校人数 = 在读人数 + 异动总人数	
			studentInSchoolNum = parseInt(studyingNum) + parseInt(exceptionNum);
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
	});
		$("#export").click(function(){
			alert(1111111111)
			if($("#list_data").datagrid("getData").total>0)
			{
				var fileName =parent.$("li.tabs-selected").find("span.tabs-title").html();
				try
				{
					window.location.href="/sys/export/exportCenterGradeRate.do?fileName="+fileName+"&param="+JSON.stringify($("#list_data").datagrid("options").queryParams.param);
				}
				catch(e)
				{
					$.messager.alert('提示', "模版不存在！",function(){
						window.history.back();
					});
				}
			}
			else
			{
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

function endEditing() {
	var flag = true;
	if (editIndex != undefined) {
		if ($('#list_data').datagrid('validateRow', editIndex)) {
			$('#list_data').datagrid('endEdit', editIndex);
			editIndex = undefined;
		} else {
			flag = false;
		}
	}
	mergeCellsByField("list_data", "schoolName");
	return flag;
}

function onClickCell(index, field) {
	if (editIndex != index) {
		if (endEditing()) {
			$('#list_data').datagrid('selectRow', index).datagrid('beginEdit', index);
			editIndex = index;
		} else {
			$('#list_data').datagrid('selectRow', editIndex);
		}
	}
}