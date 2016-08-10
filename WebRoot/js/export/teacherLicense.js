$(document).ready(function() {
	ajaxLoading("正在处理，请稍待。。。");
	if($("#schoolId").length > 0) {
		$("#schoolId").combobox({
			valueField : "schoolId",
			textField : "schoolName",
			panelHeight : "auto",
			loader: function(param, success, error) {
			    $.ajax({
					url: "/sys/pub/pageCategory.do?staffId="+$("#staffId").val()+"&resourceId=515&fieldId=schoolId",  
					dataType: 'json',  
					success: function(data) {
						if(data.length > 1) {
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
	
	$("#qryBtn").click(function() {
		var schoolId = $("#schoolId").combobox("getValue");
    	if(schoolId != "") {
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
	    			mergeCellsByField("list_data", "schoolName");
	    		}
	    	});
    	} else {
			showMessage("提示","没有有效的校区可供查询",null);
		}
    });
	
	//页面重置
    $("#resetBtn").click(function() {
    	$("#qryFm").form('clear');//清空窗体数据  
    	//校区赋默认值
    	if($("#schoolId").combobox("getData").length > 0) {
    		$("#schoolId").combobox("select",$("#schoolId").combobox("getData")[0].schoolId);
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