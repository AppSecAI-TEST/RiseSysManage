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
    	}
	});
	
	initYearAndMonth("year", null);
	initYear();
	
	$("#qryBtn").click(function() {
		var year = $("#year").datebox("getValue");
		if(year == null || year == "" || year == undefined) {
			$.messager.alert('提示', "请选择您要查询的年度！");
		} else {
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
		}
    });
	
	//重置
	$("#reset").click(function() {
		$("#qryFm").form('clear');//清空窗体数据 
		if($("#schoolId").length > 0) {
			if(!clearFlag)
	    	{
	    		$("#schoolId").combobox('select',$("#schoolId").combobox("getData")[0].schoolId);
	    	}
	    	else
	    	{
	    		$("#schoolId").combobox('setValue',"");
	    	}	
		}
		if($('#year').length > 0) {
			initYear();
		}
	});
	
	$("#export").click(function(){
		if($("#list_data").datagrid("getData").total > 0) {
			var fileName =parent.$("li.tabs-selected").find("span.tabs-title").html();
			try {
				window.location.href="/sys/export/exportClassInstDetail.do?fileName="+fileName+"&mergeName=quarterText&mergeIndex=0&param="+JSON.stringify($("#list_data").datagrid("options").queryParams.param);
			} catch(e) {
				$.messager.alert('提示', "模版不存在！",function(){
					window.history.back();
				});
			}
		} else {
			$.messager.alert('提示', "没有数据可以导出！");
		}	
	})
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

function initYear() {
	var curr_time = new Date();
	$('#year').combobox('setValue', yearFormatter(curr_time));
}
