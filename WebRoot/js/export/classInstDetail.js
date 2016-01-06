$(document).ready(function() {
	$("#schoolId").combobox({
		url : "/sys/pubData/qrySchoolList.do?schoolId=",//返回json数据的url
    	valueField : "schoolId",
    	textField : "schoolName",
    	panelHeight : "auto",
    	formatter : function(data) {
    		return "<span>" + data.schoolName + "</span>";
    	},
    	onLoadSuccess:function(data) {
    		if(data.length > 0) {
				$('#schoolId').combobox('setValue', data[0].schoolId);
				$("#qryBtn").click();
			}
    	},
    	onChange : function(n, o) {
    		var stageId = $("#stageId").combobox("getValue");
    		$("#classInstId").combobox({
				url : "/sys/pubData/qryClassInstList.do?schoolId="+n+"&courseType=&stageId="+stageId+"&classType=&classState='003','004'&classInstId=",//返回json数据的url
				valueField : "classInstId",
				textField : "className",
				panelHeight : "auto",
				formatter : function(data) {
					return "<span>" + data.className + "</span>";
				}
			});
    		if($("#teacherId").length > 0) {
				//学校的教师
				$("#teacherId").combobox({
					url : "/sys/pubData/qryTeacherList.do?schoolId="+n+"&classType=",//返回json数据的url
					valueField : "teacherId",
					textField : "byname",
					panelHeight : "auto",
					formatter : function(data) {
						return "<span>" + data.byname + "</span>";
					}
				});
			}
    	}
	});
	
	$("#stageId").combobox({
		url : "/sys/pubData/qryStage.do",//返回json数据的url
    	valueField : "stageId",
    	textField : "stageId",
    	panelHeight : "auto",
    	formatter : function(data) {
    		return "<span>" + data.stageId + "</span>";
    	},
    	onChange : function(n, o) {
    		var schoolId = $("#schoolId").combobox("getValue");
    		$("#classInstId").combobox({
				url : "/sys/pubData/qryClassInstList.do?schoolId="+schoolId+"&courseType=&stageId="+n+"&classType=&classState='003','004'&classInstId=",//返回json数据的url
				valueField : "classInstId",
				textField : "className",
				panelHeight : "auto",
				formatter : function(data) {
					return "<span>" + data.className + "</span>";
				}
			});
    	}
	});
	
	var curr_time = new Date();
	$('#year').datebox('setValue', yearFormatter(curr_time));
	
	$("#qryBtn").click(function() {
		var object = $("#qryFm").serializeObject();
		if($("[name='handType']").length > 0) {
			var s = "";
			$('input[name="handType"]:checked').each(function() {
				s += $(this).val() + ",";
			});
			s = s.substring(0, s.length - 1);
			object.handType = s;
		} else {
			object.handType = "";
		}
    	var obj = JSON.stringify(object);
    	obj = obj.substring(0, obj.length - 1);
    	var funcNodeId = $("#qryBtn").attr("funcNodeId");
    	obj += ",\"funcNodeId\":\""+funcNodeId+"\"}";
    	$('#list_data').datagrid({
    		url : "/sys/applyClass/qryClassInstDetail.do",
    		queryParams:{
    			param : obj
    		},
    		onLoadSuccess:function(){
    			onLoadSuccess();
    		}
    	});
    });
});

function onLoadSuccess() {
	mergeCellsByField("list_data", "quarterText");
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
            	if("quarterText" == field) {
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