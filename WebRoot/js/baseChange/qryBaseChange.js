$(document).ready(function() {
	ajaxLoading("正在处理，请稍待。。。");
	var staffId = $("#staffId").val();
	$("#schoolId").combobox({
		valueField : "schoolId",
    	textField : "schoolName",
    	panelHeight : "auto",
    	loader: function(param, success, error) {
    		$.ajax({  
    			url : "/sys/pub/pageCategory.do?staffId=" + staffId + "&resourceId=506&fieldId=schoolId",
				dataType: 'json',  
				success: function(data) {
			    	if(data.length > 1) {
			    		data.unshift({schoolName:"全部校区", schoolId:""});  
			    	}
					success(data);  
				}
			});  
    	},
    	formatter : function(data) {
    		return "<span>" + data.schoolName + "</span>";
    	},
    	onLoadSuccess : function() {
    		ajaxLoadEnd();
    		var data = $("#schoolId").combobox("getData");
    		if(data.length > 0) {
    			$("#schoolId").combobox("setValue", data[0].schoolId);
    		}
    	},
    	onChange : function(n, o) {
    		if(n != "" && n != null && n != undefined) {
    			$("#teacherId").combobox({
    				url : "/sys/pubData/qryTeacherList.do?schoolId="+n+"&stageId=",//返回json数据的url
    				valueField : "teacherId", 
    				textField : "byname",
    				panelHeight : "auto",
    				formatter : function(data) {
    					return "<span>" + data.byname + "</span>";
    				}
    			});
    		} else {
    			$("#teacherId").combobox('clear');
    			$("#teacherId").combobox("loadData", new Array());
    		}
    	}
	});
	
	$("#qryBtn").click(function() {
		initPageNumber("list_data");
		var object = $("#qryFm").serializeObject();
		var funcNodeId = $("#qryBtn").attr("funcNodeId");
		object.funcNodeId = funcNodeId;
    	var obj = JSON.stringify(object);
    	$('#list_data').datagrid({
    		url : "/sys/pubData/qryDataListByPage.do",
    		queryParams:{
    			param : obj
    		},
    		onLoadSuccess:function() {
    			$('#list_data').datagrid('clearSelections');
    		}
    	});
    });
	initResetButton("reset","qryFm");
	// 调整基数
	$("#changeBase").click(function() {
		var row = $('#list_data').datagrid('getSelected');
		if (row) {
//			var classState = row.classState;
//			if (classState != '003') {
//				$.messager.alert('提示', "该班级不能调整基数！");
//				return;
//			}
			var classInstId = row.classInstId;
			window.location.href = "/sys/attendClass/qryAttendClass.do?classInstId=" + classInstId + "&type=numChange&funcNodeId="+$("#funcNodeId").val();
		} else {
			$.messager.alert('提示', "请先选择您要调整的班级！");
		}
	});

	// 调整历史
	$("#viewChange").click(function() {
		var row = $('#list_data').datagrid('getSelected');
		if (row) {
			var classState = row.classState;
			var classInstId = row.classInstId;
			window.location.href = "/sys/attendClass/qryAttendClass.do?classInstId=" + classInstId + "&type=changeHist&funcNodeId="+$("#funcNodeId").val();
		} else {
			$.messager.alert('提示', "请选择班级！");
		}
	});
});