$(document).ready(function() {
	var clearFlag = true;
	ajaxLoading("正在处理，请稍待。。。");
	$("#schoolId").combobox({
		loader: function(param, success, error) {  
		    $.ajax({  
				url: "/sys/pub/pageCategory.do?staffId="+$("#staffId").val()+"&resourceId="+$("#resourceId").val()+"&fieldId=schoolId",  
				dataType: 'json',  
				success: function(data) {
			    	if(data.length == schoolData.length && !($("#sFlag").length > 0 && $("#sFlag").val() == "1")) {
			    		data.unshift({schoolName:'全部校区', schoolId:""});  
			    	}	
					success(data);  
				}
			});  
   		},
		onLoadSuccess: function(data) {
			ajaxLoadEnd();
			if(data.length > 0 || ($("#sFlag").length > 0 && $("#sFlag").val() == "1")) {
				$("#schoolId").combobox("select", data[0].schoolId);
				clearFlag = false;
			}	
		},
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
	    			var quarterText = $("#quarter").combobox("getText");
	    			$("#goal").html(quarterText + "距目标缺口");
	    			$("#rate").html(quarterText + "升学率");
	    			var quarter = $("#quarter").combobox("getValue");
	    			if("1" == quarter) {
	    				$("#1_month").html("1月升学率");
	    				$("#2_month").html("2月升学率");
	    				$("#3_month").html("3月升学率");
	    				
	    				$("#1_month_goal").html("1月距目标缺口");
	    				$("#2_month_goal").html("2月距目标缺口");
	    				$("#3_month_goal").html("3月距目标缺口");
	    			} else if("2" == quarter) {
	    				$("#1_month").html("4月升学率");
	    				$("#2_month").html("5月升学率");
	    				$("#3_month").html("6月升学率");
	    				
	    				$("#1_month_goal").html("4月距目标缺口");
	    				$("#2_month_goal").html("5月距目标缺口");
	    				$("#3_month_goal").html("6月距目标缺口");
	    			} else if("3" == quarter) {
	    				$("#1_month").html("7月升学率");
	    				$("#2_month").html("8月升学率");
	    				$("#3_month").html("9月升学率");
	    				
	    				$("#1_month_goal").html("7月距目标缺口");
	    				$("#2_month_goal").html("8月距目标缺口");
	    				$("#3_month_goal").html("9月距目标缺口");
	    			} else if("4" == quarter) {
	    				$("#1_month").html("10月升学率");
	    				$("#2_month").html("11月升学率");
	    				$("#3_month").html("12月升学率");
	    				
	    				$("#1_month_goal").html("10月距目标缺口");
	    				$("#2_month_goal").html("11月距目标缺口");
	    				$("#3_month_goal").html("12月距目标缺口");
	    			}
	    		} else if("allQuarter" == higherType || "allRegion" == higherType) {
	    			ajaxLoadEnd();
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
	
	initYearAndMonth("year", null);
	var curr_time = new Date();
	$('#year').combobox('setValue', yearFormatter(curr_time));
	
	$("#qryBtn").click(function() {
		if($("#sFlag").length>0&&$("#sFlag").val() == "1") {
			if($("#schoolId").combobox("getValue") == "") {
				showMessage("提示","请选择一个具体的校区",null);
				return false
			}	
		}	
		var flag = validateQryDate();
		if(flag) {
			initPageNumber("list_data");
			var object = $("#qryFm").serializeObject();
			if($("[name='isAttend']").length > 0) {
				var s = "";
				$('input[name="isAttend"]:checked').each(function() {
					s += $(this).val() + ",";
				});
				s = s.substring(0, s.length - 1);
				object.courseState = s;
			}
			var higherType = $("#higherType").val();
			if("gap" == higherType || "gapRate" == higherType) {
				object.staffId = $("#staffId").val();
				object.staffSchoolId = $("#staffSchoolId").val();
				object.staffPost = "," + $("#staffPost").val() + ",";
			}
			var obj = JSON.stringify(object);
			var funcNodeId = $("#qryBtn").attr("funcNodeId");
			$('#list_data').datagrid({
				url : "/sys/pubData/qryDataListByPage.do",
				queryParams:{
					param: obj,
					funcNodeId: funcNodeId
				},
				onLoadSuccess:function(){
					onLoadSuccess();
				},
				rowStyler: function(index, row) {
					var schoolName = row.schoolName; 
					if(schoolName != '' && schoolName != null && schoolName != undefined
							&& ("gap" == higherType || "gapRate" == higherType)) {
						if (schoolName.indexOf('片区') > -1) {
							return 'background-color:yellow;font-weight:bold;';
						} else if(schoolName.indexOf('总校') > -1) {
							return 'background-color:orange;font-weight:bold;';
						}
					}
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
					
					$("#1_month_goal").html("1月距目标缺口");
    				$("#2_month_goal").html("2月距目标缺口");
    				$("#3_month_goal").html("3月距目标缺口");
				} else if("2" == quarter) {
					$("#1_month").html("4月升学率");
					$("#2_month").html("5月升学率");
					$("#3_month").html("6月升学率");
					
					$("#1_month_goal").html("4月距目标缺口");
    				$("#2_month_goal").html("5月距目标缺口");
    				$("#3_month_goal").html("6月距目标缺口");
				} else if("3" == quarter) {
					$("#1_month").html("7月升学率");
					$("#2_month").html("8月升学率");
					$("#3_month").html("9月升学率");
					
					$("#1_month_goal").html("7月距目标缺口");
    				$("#2_month_goal").html("8月距目标缺口");
    				$("#3_month_goal").html("9月距目标缺口");
				} else if("4" == quarter) {
					$("#1_month").html("10月升学率");
					$("#2_month").html("11月升学率");
					$("#3_month").html("12月升学率");
					
					$("#1_month_goal").html("10月距目标缺口");
    				$("#2_month_goal").html("11月距目标缺口");
    				$("#3_month_goal").html("12月距目标缺口");
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
		}
    });
	 $("#reset").click(function() {
    	$("#qryFm").form('clear');//清空窗体数据  
    	if(!clearFlag||($("#sFlag").length>0&&$("#sFlag").val()=="1")) {
    		$("#schoolId").combobox('select',$("#schoolId").combobox("getData")[0].schoolId);
    	} else {
    		$("#schoolId").combobox('setValue',"");
    	}
    	var higherType = $("#higherType").val();
    	if("allRegion" == higherType) {
    		var curr_time = new Date();
    		$('#year').datebox('setValue', yearFormatter(curr_time));
    	}
    });
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
	} else if("teacherHigherRate" == higherType) {
		//校区教师升学率
		mergeCellsByField("list_data", "byname");
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
            		var higherType = $("#higherType").val();
            		if("quarter" == higherType) {
            			after = target.datagrid("getRows")[i].quarter;
            		} else {
            			var quarter = $("#quarter").combobox("getValue");
            			if(quarter == "" || quarter == null || quarter == undefined) {
            				after = target.datagrid("getRows")[i].quarter;
            			} else {
            				if("allRegion" == higherType) {
            					after = target.datagrid("getRows")[i].regionName;
            				} else {
            					after = target.datagrid("getRows")[i].schoolName;
            				}
            			}
            		}
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

function validateQryDate() {
	if($("#year").length > 0) {
		var higherType = $("#higherType").val();
		var year = $("#year").datebox("getValue");
		if("quarter" == higherType || "allRegion" == higherType 
				|| "allQuarter" == higherType || "allStage" == higherType
				|| "stage" == higherType) {
			if(year == null || year == "" || year == undefined) {
				$.messager.alert('提示', "请选择您要查询的年度！");
				return false;
			}
		}
	}
	return true;
}
