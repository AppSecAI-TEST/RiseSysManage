$(document).ready(function() {
	var isRegion = false;
	var clearFlag = true;
	ajaxLoading("正在处理，请稍待。。。");
	var staffSchoolId = $("#staffSchoolId").val();
	if(staffSchoolId != null && staffSchoolId != "" && staffSchoolId != undefined) {
		if("10" == staffSchoolId) {
			isRegion = true;
			$("#regionId").combobox({
				loader:function(param,success,error){  
					$.ajax({  
						url: "/sys/pubData/qryRegionList.do",
						dataType: 'json',
						async: false,
						success: function(data) {
							data.unshift({regionName:'全部片区', regionId:""});
							success(data);  
						}
					});  
				},
				onLoadSuccess : function(data) {
					if(data.length > 0) {
						$("#regionId").combobox("setValue", data[0].regionId);
					}
				}
			});
		} else {
			var staffId = $("#staffId").val();
			$.ajax({
				url: "/sys/pubData/checkStaffIsArea.do",
				type: "POST",
				dataType: 'json',
				async: false,
				data: "staffId=" + staffId,
				success: function(data) {
					if(parseInt(data) > 0) {
						isRegion = true;
						$("#regionId").combobox({
							url : "/sys/pubData/qryRegionListByStaffId.do?staffId=" + staffId,
							dataType: 'json',
							onLoadSuccess:function(data) {
								if(data.length > 0) {
									$("#regionId").combobox("setValue", data[0].regionId);
								}
							}
						});
					} else {
						$("#regionTd").css("display", "none");
						$("#regionTitleTd").css("display", "none");
					}
				}
			});
		}
	}
	
	$("#schoolId").combobox({
		loader:function(param,success,error){  
		    $.ajax({  
				url: "/sys/pub/pageCategory.do?staffId="+$("#staffId").val()+"&resourceId="+$("#resourceId").val()+"&fieldId=schoolId",  
				dataType: 'json',
				async: false,
				success: function(data) {
					if(isRegion || data.length == schoolData.length) {
						data.unshift({schoolName:'全部校区', schoolId:""});  
					}
					success(data);  
				}
			});  
   		},
   		onLoadSuccess : function(data) {
			ajaxLoadEnd();
			if(data.length > 0) {
				$("#schoolId").combobox("setValue", data[0].schoolId);
				clearFlag = false;
			}
		}
	});
	var curr_time = new Date();
	$('#year').datebox('setValue', yearFormatter(curr_time));
	
	$("#qryBtn").click(function() {
		if(!validateIsQry()) {
			return;
		} else {
			initPageNumber("list_data");
			var object = $("#qryFm").serializeObject();
			var tableName = $("#tableName").val();
			var funcNodeId = $("#qryBtn").attr("funcNodeId");
			if("report_teacher_service_rate" == tableName || "report_school_exception" == tableName) {
				object.staffId = $("#staffId").val();
				object.staffSchoolId = $("#staffSchoolId").val();
				object.staffPost = "," + $("#staffPost").val() + ",";
			}
			var obj = JSON.stringify(object);
			$('#list_data').datagrid({
				url : "/sys/pubData/qryDataListByPage.do",
				queryParams: {
					param: obj,
					funcNodeId: funcNodeId
				},
				onLoadSuccess: function() {
					onLoadSuccess();
				},
				rowStyler: function(index, row) {
					var schoolName = row.schoolName; 
					if(schoolName != '' && schoolName != null && schoolName != undefined) {
						if (schoolName.indexOf('片区') > -1) {
							return 'background-color:yellow;font-weight:bold;';
						} else if(schoolName.indexOf('总校') > -1) {
							return 'background-color:orange;font-weight:bold;';
						}
					}
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
		if(!clearFlag) {
    		$("#schoolId").combobox('select',$("#schoolId").combobox("getData")[0].schoolId);
    	} else {
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
	var object = $("#qryFm").serializeObject();
	var rows = $('#list_data').datagrid('getRows');
	var resultType = rows[index].resultType;
	if("school" == resultType) {
		var schoolId = rows[index].schoolId;
		object.schoolId = schoolId;
	} else if("region" == resultType) {
		var regionId = rows[index].regionId;
		object.regionId = regionId;
	} else if("city" == resultType) {
		var city = rows[index].city;
		object.city = city;
	}
	object.queryCode = "qryNewNotInClassDetail";
	if("higher" == type) {
		object.queryCode = "qryHigherNotInClassDetail";
	}
	var obj = JSON.stringify(object);
	$('#' + type + '_list_data').datagrid({
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