$(document).ready(function() {
	var curr_time = new Date();
	$('#year').datebox('setValue', yearFormatter(curr_time));
	var year = $('#year').datebox('getValue');
	var tableName = $("#tableName").val();
	$("#month").combobox({
		url : "/sys/pubData/qryReportMonthList.do?tableName=" + tableName + "&year=" + year,//返回json数据的url
    	valueField : "month",
    	textField : "monthText",
    	panelHeight : "auto",
    	formatter : function(data) {
    		return "<span>" + data.monthText + "</span>";
    	},
    	onLoadSuccess:function(data) {
    		if(data.length > 0) {
				$('#month').combobox('setValue', data[0].month);
			}
    	},
    	onChange : function(n, o) {
    		$("#week").combobox({
    			url : "/sys/pubData/qryReportWeekList.do?tableName=" + tableName + "&year=" + year + "&month=" + n,//返回json数据的url
    			valueField : "weekName",
    	    	textField : "weekNameText",
    	    	panelHeight : "auto",
    	    	formatter : function(data) {
    	    		return "<span>" + data.weekNameText + "</span>";
    	    	},
    	    	onLoadSuccess:function(data) {
    	    		if(data.length > 0) {
    					$('#week').combobox('setValue', data[0].weekName);
    					$("#qryBtn").click();
    				}
    	    	}
    		});
    	}
	});
	
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
    			$("#schoolId").combobox("setValue", "");
    			$("#schoolId").combobox("setText", "全部校区");
			}
    	},
    	onChange : function(n, o) {
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
	});
	
	$("#qryBtn").click(function() {
		var object = $("#qryFm").serializeObject();
		if($("[name='stageId']").length > 0) {
			var s = "";
			$('input[name="stageId"]:checked').each(function() {
				s += $(this).val() + ",";
			});
			s = s.substring(0, s.length - 1);
			object.stageId = s;
		} else {
			object.stageId = "";
		}
		if($("[name='licenseStageId']").length > 0) {
			var s = "";
			$('input[name="licenseStageId"]:checked').each(function() {
				s += $(this).val() + ",";
			});
			s = s.substring(0, s.length - 1);
			object.licenseStageId = s;
		} else {
			object.licenseStageId = "";
		}
    	var obj = JSON.stringify(object);
    	obj = obj.substring(0, obj.length - 1);
    	var funcNodeId = $("#qryBtn").attr("funcNodeId");
    	obj += ",\"funcNodeId\":\""+funcNodeId+"\"}";
    	$.ajax({
    		url : "/sys/teacherManage/qryTeacherArchivesList.do",//返回json数据的url
    		type : "post",
    		data : "param=" + obj,
    		dataType: "json",
    		success: function (data) {
    			onLoadSuccess(data);
    		}
    	});
    	
//    	$('#list_data').datagrid({
//    		fit : true,
//    		nowrap : true,
//    		border : false,
//    		striped : true,
//    		pagination : true,
//    		rownumbers : true,
//    		singleSelect : false,
//    		columns : columns,
//    		fitColumns : false,
//    		url : "/sys/teacherManage/qryTeacherArchivesList.do",
//    		queryParams:{
//    			param : obj
//    		},
//    		onLoadSuccess:function(data) {
//    			onLoadSuccess(data);
//    		}
//    	});
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
	});
	
	$.ajax({
		url : "/sys/pubData/qryStage.do",//返回json数据的url
		type : "post",
		dataType: "json",
		success: function (data) {
			var content = "";
			var licenseContent = "";
			$.each(data, function(i, obj){
				content += "<input type='checkbox' name='stageId' value='\""+obj.stageId+"\"'/>&nbsp;<span>"+obj.stageId+"</span>&nbsp;&nbsp;&nbsp;";
				licenseContent += "<input type='checkbox' name='licenseStageId' value='\""+obj.stageId+"\"'/>&nbsp;<span>"+obj.stageId+"</span>&nbsp;&nbsp;&nbsp;";
			});
			$("#stageTd").html(content);
			$("#licenseStageTd").html(licenseContent);
		}
	});
});

function onLoadSuccess(data) {
	var colsOne = new Array();
	var colsTwo = new Array();
	var columns = new Array();
	$.each(data.rowOne, function() {
		var colData = new Object();
		colData.field = this.field;
		colData.title = this.title;
		colData.align = this.align;
		colData.colspan = this.colspan;
		colsOne.push(colData);
	});
	columns.push(colsOne);
	$.each(data.rowTwo, function() {
		var colData = new Object();
		colData.field = this.field;
		colData.title = this.title;
		colData.width = this.width;
		colData.align = this.align;
		colsTwo.push(colData);
	});
	columns.push(colsTwo);
	$("#list_data").datagrid({
	    pagination	: true,
	    columns		: columns,
	    fitColumns : false,
		data: data.rows
	})
}
