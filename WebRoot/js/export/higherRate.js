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
	
	if($("#quarter").length > 0) {
		$("#quarter").combobox({
			url : "/sys/pubData/qryQuarterList.do",//返回json数据的url
			valueField : "quarter",
	    	textField : "quarterText",
	    	panelHeight : "auto",
	    	formatter : function(data) {
	    		return "<span>" + data.quarterText + "</span>";
	    	},
	    	onLoadSuccess:function(data) {
	    		var higherType = $("#higherType").val();
	    		if("gap" == higherType) {
	    			$('#quarter').combobox('setValue', data[0].quarter);
	    			$("#qryBtn").click();
	    			var quarterText = $("#quarter").combobox("getText");
	    			$("#goal").html(quarterText + "距目标缺口");
	    			$("#rate").html(quarterText + "升学率");
	    			var quarter = $("#quarter").combobox("getValue");
	    			if("1" == quarter) {
	    				$("#1_month").html("1月升学率");
	    				$("#2_month").html("2月升学率");
	    				$("#3_month").html("3月升学率");
	    			} else if("2" == quarter) {
	    				$("#1_month").html("4月升学率");
	    				$("#2_month").html("5月升学率");
	    				$("#3_month").html("6月升学率");
	    			} else if("3" == quarter) {
	    				$("#1_month").html("7月升学率");
	    				$("#2_month").html("8月升学率");
	    				$("#3_month").html("9月升学率");
	    			} else if("4" == quarter) {
	    				$("#1_month").html("10月升学率");
	    				$("#2_month").html("11月升学率");
	    				$("#3_month").html("12月升学率");
	    			}
	    		}
	    	},
	    	onChange : function(n, o) {
	    		if($("#month").length > 0) {
	    			$("#month").combobox({
	    				url : "/sys/pubData/qryMonthList.do?quarter="+n,//返回json数据的url
	    				valueField : "month",
	    				textField : "monthText",
	    				panelHeight : "auto",
	    				formatter : function(data) {
	    					return "<span>" + data.monthText + "</span>";
	    				}
	    			});
	    		}
	    	}
		});
	}

	var curr_time = new Date();
	$('#year').datebox('setValue', yearFormatter(curr_time));
	
	$("#qryBtn").click(function() {
		var object = $("#qryFm").serializeObject();
		if($("[name='isAttend']").length > 0) {
			var s = "";
			$('input[name="isAttend"]:checked').each(function() {
				s += $(this).val() + ",";
			});
			s = s.substring(0, s.length - 1);
			object.courseState = s;
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
    		}
    	});
    	
    	var higherType = $("#higherType").val();
    	if("quarter" == higherType||"allQuarter"==higherType) {
    		var year = $('#year').datebox('getValue');
    		$("#yearDiv").html(year);
    	} else if("gap" == higherType) {
			var quarterText = $("#quarter").combobox("getText");
			$("#goal").html(quarterText + "距目标缺口");
			$("#rate").html(quarterText + "升学率");
			var quarter = $("#quarter").combobox("getValue");
			if("1" == quarter) {
				$("#1_month").html("1月升学率");
				$("#2_month").html("2月升学率");
				$("#3_month").html("3月升学率");
			} else if("2" == quarter) {
				$("#1_month").html("4月升学率");
				$("#2_month").html("5月升学率");
				$("#3_month").html("6月升学率");
			} else if("3" == quarter) {
				$("#1_month").html("7月升学率");
				$("#2_month").html("8月升学率");
				$("#3_month").html("9月升学率");
			} else if("4" == quarter) {
				$("#1_month").html("10月升学率");
				$("#2_month").html("11月升学率");
				$("#3_month").html("12月升学率");
			}
		}
    	if($("#classProgress").length > 0) {
    		var content = "";
    		var minAttendRate = $("#minAttendRate").textbox("getValue");
    		var maxAttendRate = $("#maxAttendRate").textbox("getValue");
    		if(minAttendRate != null && minAttendRate != "" && minAttendRate != undefined) {
    			if(maxAttendRate != null && maxAttendRate != "" && maxAttendRate != undefined) {
    				content += minAttendRate + "% <= 课时进度 <= " + maxAttendRate + "%";
    			} else {
    				content += minAttendRate + "% <= 课时进度";
    			}
    		} else {
    			if(maxAttendRate != null && maxAttendRate != "" && maxAttendRate != undefined) {
    				content += "课时进度 <= " + maxAttendRate + "%";
    			} else {
    				content += "未结课";
    			}
    		}
    		$("#classProgress").html(content);
    	}
    });
	
	var higherType = $("#higherType").val();
	if("allStage" == higherType || "allQuarter" == higherType || "allRegion" == higherType) {
		$("#qryBtn").click();
	}
});

function onLoadSuccess() {
	var higherType = $("#higherType").val();
	if("quarter" == higherType) {
		//校区月季度升学率
		mergeCellsByField("list_data", "quarterHigherRate");
	} else if("allStage" == higherType) {
		//总校年级组升学率
		mergeCellsByField("list_data", "schoolName");
	} else if("allQuarter" == higherType) {
		//总校区月季度升学率
		mergeCellsByField("list_data", "schoolName,quarterHigherRate");
	} else if("allRegion" == higherType) {
		//片区升学率
		mergeCellsByField("list_data", "regionName,quarterHigherRate");
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