$(document).ready(function() {
	ajaxLoading("正在处理，请稍待。。。");
	var staffId = $("#staffId").val();
	$("#schoolId").combobox({
    	valueField : "schoolId",
    	textField : "schoolName",
    	panelHeight : "auto",
    	loader: function(param,success,error) {
    		$.ajax({  
    			url : "/sys/pub/pageCategory.do?staffId=" + staffId + "&resourceId=711&fieldId=schoolId",//返回json数据的url
				dataType: 'json',  
				success: function(data) {
			    	if(data.length == schoolData) {
			    		data.unshift({schoolName:"全部校区", schoolId:""});  
			    	}
					success(data);  
				}
			});  
    	},
    	formatter : function(data) {
    		return "<span>" + data.schoolName + "</span>";
    	},
    	onLoadSuccess:function(data) {
    		ajaxLoadEnd();
    		if(data.length > 0) {
				$('#schoolId').combobox('setValue', data[0].schoolId);
			}
    	}
	});
	
	initDay();
	
	$("#qryBtn").click(function() {
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
			initPageNumber("list_data");
			var object = $("#qryFm").serializeObject();
			var schoolId = $('#schoolId').combobox('getValue');
			if(schoolId != null && schoolId != "" && schoolId != undefined) {
				object.schoolName = schoolId;
			} else {
				object.schoolName = "1050";
			}
			var funcNodeId = $("#qryBtn").attr("funcNodeId");
			object.funcNodeId = funcNodeId;
			var obj = JSON.stringify(object);
			$('#list_data').datagrid({
				url : "/sys/pubData/qryDataListByPage.do",
				queryParams:{
					param : obj
				},
				onLoadSuccess:function(){
					mergeCellsByField("list_data", "schoolName");
				}
			});
		} else {
			$.messager.alert('提示', "开始日期和结束日期只能选同一个月内的日期！");
		}
    });
	
	$("#reset").click(function() {
		$('#qryFm').form('clear');//清空窗体数据  
		initDay();
		var data = $('#schoolId').combobox('getData');
		if(data.length > 0) {
			$('#schoolId').combobox('setValue', data[0].schoolId);
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