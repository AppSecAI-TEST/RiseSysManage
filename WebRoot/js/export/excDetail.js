$(document).ready(function() {
	var clearFlag =true;
	var schoolData = [1001,1002,1003,1004,1005,1006,1007,1008,1009,1010,1011,1012,1013];	
	$("#schoolId").combobox({
		loader:function(param,success,error){  
		    $.ajax({  
				url: "/sys/pub/pageCategory.do?staffId="+$("#staffId").val()+"&resourceId="+$("#resourceId").val()+"&fieldId=schoolId",  
				dataType: 'json',  
				success: function(data){
		    	if(data.length==schoolData.length)
		    	{
		    		data.unshift({schoolName:'所有校区',schoolId:""});  
		    	}	
				success(data);  
				}
			});  
   		},
		onLoadSuccess:function(){
			var arr =$("#schoolId").combobox("getData");
			if(arr.length<schoolData.length)
			{
				$("#schoolId").combobox("select",arr[0].schoolId);
				clearFlag =false;
			}	
		}
	});
	var curr_time = new Date();
	$('#year').datebox('setValue', yearFormatter(curr_time));
//	var year = $('#year').datebox('getValue');
//	var tableName = $("#tableName").val();
//	$("#month").combobox({
//		url : "/sys/pubData/qryReportMonthList.do?tableName=" + tableName + "&year=" + year,//返回json数据的url
//    	valueField : "month",
//    	textField : "monthText",
//    	panelHeight : "auto",
//    	formatter : function(data) {
//    		return "<span>" + data.monthText + "</span>";
//    	},
//    	onLoadSuccess:function(data) {
//    		if(data.length > 0) {
//				$('#month').combobox('setValue', data[0].month);
//			}
//    	},
//    	onChange : function(n, o) {
//    		$("#week").combobox({
//    			url : "/sys/pubData/qryReportWeekList.do?tableName=" + tableName + "&year=" + year + "&month=" + n,//返回json数据的url
//    			valueField : "weekName",
//    	    	textField : "weekNameText",
//    	    	panelHeight : "auto",
//    	    	formatter : function(data) {
//    	    		return "<span>" + data.weekNameText + "</span>";
//    	    	},
//    	    	onLoadSuccess:function(data) {
//    	    		if(data.length > 0) {
//    					$('#week').combobox('setValue', data[0].weekName);
//    					$("#qryBtn").click();
//    				}
//    	    	}
//    		});
//    	}
//	});
	
	$("#qryBtn").click(function() {
		if(!validateIsQry()) {
			return;
		} else {
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
				onLoadSuccess:function(){
					onLoadSuccess();
				}
			});
		}
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
		if(!clearFlag)
    	{
    		$("#schoolId").combobox('select',$("#schoolId").combobox("getData")[0].schoolId);
    	}
    	else
    	{
    		$("#schoolId").combobox('setValue',"");
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

function viewNotInClassDetail(index, type) {
	var rows = $('#list_data').datagrid('getRows');
	var schoolId = rows[index].schoolId;
	var object = $("#qryFm").serializeObject();
	object.schoolId = schoolId;
	object.queryCode = "qryNewNotInClassDetail";
	if("higher" == type) {
		object.queryCode = "qryHigherNotInClassDetail";
	}
	var obj = JSON.stringify(object);
	$('#'+type+'_list_data').datagrid({
		url : "/sys/pubData/qryDataListByPage.do",
		queryParams:{
			param : obj
		}
	});
	$('#'+type+'_dlg').form('clear');//清空窗体数据 
	if("higher" == type) {
		$('#'+type+'_dlg').dialog('open').dialog('setTitle', '升学未进班阶段明细');//设定表头  
	} else {
		$('#'+type+'_dlg').dialog('open').dialog('setTitle', '新招未进班阶段明细');//设定表头  
	}
}