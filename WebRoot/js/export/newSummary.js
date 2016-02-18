$(document).ready(function() {
	var staffId = $("#staffId").val();
	$("#schoolId").combobox({
		url : "/sys/pub/pageCategory.do?staffId=" + staffId + "&resourceId=711&fieldId=schoolId",//返回json数据的url
    	valueField : "schoolId",
    	textField : "schoolName",
    	panelHeight : "auto",
    	formatter : function(data) {
    		return "<span>" + data.schoolName + "</span>";
    	},
    	onLoadSuccess:function(data) {
    		if(data.length == 1) {
				$('#schoolId').combobox('setValue', data[0].schoolId);
			}
    	}
	});
	
	initDay();
	
	$("#qryBtn").click(function() {
		getData();
    });
	
	$("#reset").click(function() {
		$('#qryFm').form('clear');//清空窗体数据  
		initDay();
		var data = $('#schoolId').combobox('getData');
		if(data.length == 1) {
			$('#schoolId').combobox('setValue', data[0].schoolId);
		}
	});
});

function getData() {
	var flag = false;
	var startTimePay = $('#startTimePay').datebox('getValue');
	startTimePay = startTimePay.replace(/-/g,"/");
	var startDate = new Date(startTimePay);
	var endTimePay = $('#endTimePay').datebox('getValue');
	endTimePay = endTimePay.replace(/-/g,"/");
	var endDate = new Date(endTimePay);
	if(startDate.getFullYear() == endDate.getFullYear() 
			&& startDate.getMonth() == endDate.getMonth()) {
		flag = true;
	}
	if(flag) {
		var object = $("#qryFm").serializeObject();
		var funcNodeId = $("#qryBtn").attr("funcNodeId");
		object.funcNodeId = funcNodeId;
		var obj = JSON.stringify(object);
		$.ajax({
			url : "/sys/courseSummary/qryNewCourseSummaryReport.do",//返回json数据的url
			type : "post",
			data : "param=" + obj,
			dataType: "json",
			async: true,
			beforeSend: function() {
				$.messager.progress({title : '新增汇总表', msg : '正在查询新增汇总表，请稍等……'});
			},
			success: function (data) {
				$.messager.progress('close'); 
				onLoadSuccess(data);
			}
		});
	} else {
		$.messager.alert('提示', "开始日期和结束日期只能选同一个月内的日期！");
	}
}

function onLoadSuccess(data) {
	if(data.total > 0) {
		var colsOne = new Array();
		var colsTwo = new Array();
		var columns = new Array();
		$.each(data.rowOne, function() {
			var colData = new Object();
			colData.field = this.field;
			colData.title = this.title;
			colData.align = this.align;
			colData.rowspan = this.rowspan;
			colData.colspan = this.colspan;
			colsOne.push(colData);
		});
		columns.push(colsOne);
		$.each(data.rowTwo, function() {
			var colData = new Object();
			colData.field = this.field;
			colData.title = this.title;
			colData.width = this.width;
			colData.align = this.align;
			colsTwo.push(colData);
		});
		columns.push(colsTwo);
		$("#list_data").datagrid({
		    pagination	: false,
		    columns		: columns,
		    fitColumns : false,
			data: data.rows
		});
		mergeCellsByField("list_data", "schoolName");
	} else {
		$("#list_data").datagrid("loadData", new Array());
	}
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
            	if("quarterHigherRate" == field) {
            		after = target.datagrid("getRows")[i].quarter;
            	} else {
            		after = target.datagrid("getRows")[i][field];
            	}
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

function initDay() {
	var curr_time = new Date();
	var year = curr_time.getFullYear();
	var month = curr_time.getMonth() + 1;
	if (month < 10) {
        month = "0" + month;
    }
	var firstDay = year + "-" + month + "-" + "01";
	$('#startTimePay').datebox('setValue', firstDay);
	$('#endTimePay').datebox('setValue', myformatter(curr_time));
}