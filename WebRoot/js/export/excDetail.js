$(document).ready(function() {
	var curr_time = new Date();
	$('#year').datebox('setValue', yearFormatter(curr_time));
	var year = $('#year').datebox('getValue');
	var tableName = $("#tableName").val();
	$("#month").combobox({
		url : "/sys/pubData/qryReportMonthList.do?tableName=" + tableName + "&year=" + year,//返回json数据的url
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
    	},
    	onChange : function(n, o) {
    		$("#week").combobox({
    			url : "/sys/pubData/qryReportWeekList.do?tableName=" + tableName + "&year=" + year + "&month=" + n,//返回json数据的url
    			valueField : "weekName",
    	    	textField : "weekNameText",
    	    	panelHeight : "auto",
    	    	formatter : function(data) {
    	    		return "<span>" + data.weekNameText + "</span>";
    	    	},
    	    	onLoadSuccess:function(data) {
    	    		if(data.length > 0) {
    					$('#week').combobox('setValue', data[0].weekName);
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
    		onLoadSuccess:function(){
    			onLoadSuccess();
    		}
    	});
    });
	
	$("#reset").click(function() {
		$('#qryFm').form('clear');//清空窗体数据  
		$('#year').datebox('setValue', yearFormatter(curr_time));
		var data = $("#month").combobox("getData");
		if(data.length > 0) {
			$('#month').combobox('setValue', data[0].month);
		}
		data = $("#week").combobox("getData");
		if(data.length > 0) {
			$('#week').combobox('setValue', data[0].weekName);
		}
	});
});

function onLoadSuccess() {
	mergeCellsByField("list_data", "schoolName");
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