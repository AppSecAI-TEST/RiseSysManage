$(document).ready(function() {
	ajaxLoading("正在处理，请稍待。。。");
	var staffSchoolId = $("#staffSchoolId").val();
	if("10" == staffSchoolId) {
		$("#regionId").combobox({
			loader:function(param,success,error){  
			    $.ajax({  
					url: "/sys/pubData/qryRegionList.do",
					dataType: 'json',
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
			data: "staffId=" + staffId,
			success: function(data) {
				if(parseInt(data) > 0) {
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
	
	$("#qryBtn").click(function() {
		initPageNumber("list_data");
		var object = $("#qryFm").serializeObject();
		if($("[name='isApplyBonus']").length > 0) {
			var s = "";
			$('input[name="isApplyBonus"]:checked').each(function() {
				s += $(this).val() + ",";
			});
			s = s.substring(0, s.length - 1);
			object.isApplyBonus = s;
		}
		var type = $("#type").val();
		if("summary" == type) {
			object.staffId = $("#staffId").val();
			object.staffPost = $("#staffPost").val();
			object.staffSchoolId = $("#staffSchoolId").val();
		}
    	var obj = JSON.stringify(object);
    	var funcNodeId = $("#qryBtn").attr("funcNodeId");
    	$('#list_data').datagrid({
    		url : "/sys/pubData/qryDataListByPage.do",
    		queryParams:{
    			param: obj,
    			funcNodeId: funcNodeId
    		},
    		onLoadSuccess:function() {
    			onLoadSuccess();
    			$('#list_data').datagrid('clearSelections');
    			var resourceId = $("#resourceId").val();
    			if(resourceId != null && resourceId != "" && resourceId != undefined && "746" == resourceId) {
    				$('.apply').linkbutton({text:'申请奖金', iconCls:'icon-add'});
    			}
    		},
    		rowStyler: function(index, row) {
    			if("summary" == type) {
    				var schoolName = row.schoolName; 
    				if(schoolName != '' && schoolName != null && schoolName != undefined) {
    					if (schoolName.indexOf('片区') > -1) {
    						return 'background-color:yellow;font-weight:bold;';
    					} else if(schoolName.indexOf('总校') > -1) {
    						return 'background-color:orange;font-weight:bold;';
    					}
    				}
    			}
			}
    	});
    });
	initReportButton("reset","qryFm","schoolId");
	if($("#schoolId").length > 0) {
		var staffId = $("#staffId").val();
		$("#schoolId").combobox({
			onLoadSuccess : function(data) {
				ajaxLoadEnd();
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
    var stageId = "";
    var schoolName = "";
    var rows = target.datagrid("getRows").length;
    for (var j = colunms.length - 1; j >= 0; j--) {
    	var field = colunms[j];
    	before = "";
        rowspan = 1;
        stageId = "";
        megerIndex = 0;
        for (var i = 0; i <= rows; i++) {
        	var columnSchoolName = "";
        	if(i == 0) {
        		schoolName = target.datagrid("getRows")[i].schoolName;
        	}
            if (i == rows) {
            	after = "";
            } else {
            	after = target.datagrid("getRows")[i][field];
            	columnSchoolName = target.datagrid("getRows")[i].schoolName;
            }
            if (before == after && schoolName == columnSchoolName) {
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
            schoolName = columnSchoolName;
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