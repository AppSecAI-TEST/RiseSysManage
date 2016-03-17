$(document).ready(function() {
	$("#qryBtn").click(function() {
		var object = $("#qryFm").serializeObject();
		if($("[name='isApplyBonus']").length > 0) {
			var s = "";
			$('input[name="isApplyBonus"]:checked').each(function() {
				s += $(this).val() + ",";
			});
			s = s.substring(0, s.length - 1);
			object.isApplyBonus = s;
		}
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
    			$('.apply').linkbutton({text:'申请奖金', iconCls:'icon-add'});
    	        $('#list_data').datagrid('clearSelections');
    		}
    	});
    });
	initReportButton("reset","qryFm","schoolId");
	if($("#schoolId").length > 0) {
		var staffId = $("#staffId").val();
		$("#schoolId").combobox({
	    	onChange : function(n, o) {
	    		if($("#teacherId").length > 0) {
					//学校的教师
					$("#teacherId").combobox({
						url : "/sys/pubData/qryTeacherList.do?schoolId="+n+"&stageId=",//返回json数据的url
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
	} else {
		$("#qryBtn").click();
	}
});

function onLoadSuccess() {
	var type = $("#type").val();
	if("detail" == type) {
		mergeCellsByField("list_data", "schoolName,stageId");
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
            	if("stageId" == field) {
            		var stageId = $("#stageId").combobox("getValue");
            		if(stageId != null && stageId != "" && stageId != undefined) {
            			after = target.datagrid("getRows")[i].schoolName;
            		} else {
            			after = target.datagrid("getRows")[i][field];
            		}
            	} else {
            		after = target.datagrid("getRows")[i][field];
            	}
            }
            if (before == after) {
            	rowspan += 1;
            } else {
            	if(field == "stageId") {
            		target.datagrid("mergeCells", {
            			index: i - rowspan,
            			field: "stageId",　　// 合并字段
            			rowspan: rowspan
            		});
            		target.datagrid("mergeCells", {
            			index: i - rowspan,
            			field: "exceptionOpenNum",　　// 合并字段
            			rowspan: rowspan
            		});
            		target.datagrid("mergeCells", {
            			index: i - rowspan,
            			field: "exceptionAvgOpenNum",　　// 合并字段
            			rowspan: rowspan
            		});
            		target.datagrid("mergeCells", {
            			index: i - rowspan,
            			field: "exceptionOpenRate",　　// 合并字段
            			rowspan: rowspan
            		});
            	} else {
            		target.datagrid("mergeCells", {
            			index: i - rowspan,
            			field: field,　　// 合并字段
            			rowspan: rowspan
            		});
            	}
            	rowspan = 1;
            }
            before = after;
        }
    }
}

function getBonus(classInstId, type) {
	$.ajax({
		url : "/sys/applyClass/getBonus.do",// 返回json数据的url
		type : "post",
		data : "classInstId=" + classInstId + "&type=" + type,
		dataType : "json",
		async : true,
		beforeSend: function() {
			if("GET" == type) {
				$.messager.progress({title : '领取结课奖金', msg : '正在领取结课奖金，请稍等……'});
			} else {
				$.messager.progress({title : '申请结课奖金', msg : '正在申请结课奖金，请稍等……'});
			}
		},
		success: function (data) {
			$.messager.progress('close'); 
			if(data.flag) {
				if("GET" == type) {
					$.messager.alert('提示', "领取结课奖金成功！", "info", function() {$("#qryBtn").click();});
				} else {
					$.messager.alert('提示', "申请结课奖金成功！", "info", function() {$("#qryBtn").click();});
				}
			} else {
				$.messager.alert('提示', data.msg);
			}
		}
	});
}