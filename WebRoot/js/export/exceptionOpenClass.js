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
	if($("#schoolId").length > 0) {
		var staffId = $("#staffId").val();
		$("#schoolId").combobox({
			url : "/sys/pub/pageCategory.do?staffId=" + staffId + "&resourceId=503&fieldId=schoolId",
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

$.extend($.fn.datagrid.methods, {
    autoMergeCells : function (jq, fields) {
        return jq.each(function () {
            var target = $(this);
            if (!fields) {
                fields = target.datagrid("getColumnFields");
            }
            var rows = target.datagrid("getRows");
            var i = 0,
            j = 0,
            temp = {};
            for (i; i < rows.length; i++) {
                var row = rows[i];
                j = 0;
                for (j; j < fields.length; j++) {
                    var field = fields[j];
                    if("className" != field && "openClassNum" != field) {
                    	var tf = temp[field];
                    	if (!tf) {
                    		tf = temp[field] = {};
                    		tf[row[field]] = [i];
                    	} else {
                    		var tfv = tf[row[field]];
                    		if (tfv) {
                    			tfv.push(i);
                    		} else {
                    			tfv = tf[row[field]] = [i];
                    		}
                    	}
                    }
                }
            }
            $.each(temp, function (field, colunm) {
                $.each(colunm, function () {
                    var group = this;
                    if (group.length > 1) {
                        var before,
                        after,
                        megerIndex = group[0];
                        for (var i = 0; i < group.length; i++) {
                            before = group[i];
                            after = group[i + 1];
                            if (after && (after - before) == 1) {
                                continue;
                            }
                            var rowspan = before - megerIndex + 1;
                            if (rowspan > 1) {
                                target.datagrid('mergeCells', {
                                    index : megerIndex,
                                    field : field,
                                    rowspan : rowspan
                                });
                            }
                            if (after && (after - before) != 1) {
                                megerIndex = after;
                            }
                        }
                    }
                });
            });
        });
    }
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