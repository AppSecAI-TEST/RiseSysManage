$(document).ready(function() {
	var clearFlag = true;
	ajaxLoading("正在处理，请稍待。。。");
	$("#schoolId").combobox({
		loader:function(param,success,error){  
		    $.ajax({  
				url: "/sys/pub/pageCategory.do?staffId="+$("#staffId").val()+"&resourceId="+$("#resourceId").val()+"&fieldId=schoolId",  
				dataType: 'json',  
				success: function(data) {
					if(data.length == schoolData.length) {
						data.unshift({schoolName:'全部校区', schoolId:""});  
					}
					success(data);  
				}
			});  
   		},
		onLoadSuccess:function(data) {
			ajaxLoadEnd();
			if(data.length > 0) {
				$("#schoolId").combobox("setValue", data[0].schoolId);
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
					formatter : function(data) {
						return "<span>" + data.byname + "</span>";
					}
				});
			}
    	}
	});
	if($("#stageId").length > 0) {
		$("#stageId").combobox({
			url : "/sys/pubData/qryStage.do",//返回json数据的url
			valueField : "stageId",
			textField : "stageId",
			panelHeight : "auto",
			formatter : function(data) {
				return "<span>" + data.stageId + "</span>";
			}
		});
	}
	initYearAndMonth("year", "month");
	if($('#year').length > 0) {
		initYear();
	}
	
	$("#qryBtn").click(function() {
		var year = $("#year").datebox("getValue");
		if(year == null || year == "" || year == undefined) {
			$.messager.alert('提示', "请选择您要查询的年度！");
		} else {
			var object = $("#qryFm").serializeObject();
			var minAttendRate = object.minAttendRate;
			if(minAttendRate == null || minAttendRate == "" || minAttendRate == undefined) {
				object.minAttendRate = "0";
			}
			var maxAttendRate = object.maxAttendRate;
			if(maxAttendRate == null || maxAttendRate == "" || maxAttendRate == undefined) {
				object.maxAttendRate = "100";
			}
			var type = $("#type").val();
			if("stageId" == type) {
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
				onLoadSuccess:function(){
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
	
	//重置
	$("#reset").click(function() {
		$("#qryFm").form('clear');//清空窗体数据 
		if($("#schoolId").length > 0) {
			if(!clearFlag) {
	    		$("#schoolId").combobox('select',$("#schoolId").combobox("getData")[0].schoolId);
	    	} else {
	    		$("#schoolId").combobox('setValue',"");
	    	}	
		}
		if($('#year').length > 0) {
			initYear();
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

function initYear() {
	var curr_time = new Date();
	$('#year').combobox('setValue', yearFormatter(curr_time));
}