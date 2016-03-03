$(document).ready(function() {
	if($("#schoolId").length > 0) {
		var staffId = $("#staffId").val();
		var resourceId = $("#resourceId").val();
		$("#schoolId").combobox({
			url : "/sys/pub/pageCategory.do?staffId=" + staffId + "&resourceId=" + resourceId + "&fieldId=schoolId",
			valueField : "schoolId",
			textField : "schoolName",
			panelHeight : "auto",
			formatter : function(data) {
				return "<span>" + data.schoolName + "</span>";
			},
			onLoadSuccess : function() {
	    		var data = $("#schoolId").combobox("getData");
	    		if(data.length > 0) {
	    			$("#schoolId").combobox("setValue", data[0].schoolId);
	    		}
	    	}
		});
	}
	if($("#startTimeFinish").length > 0) {
		initDate();
	}
	$("#qryBtn").click(function() {
		var flag = true;
		if($("#startTimeFinish").length > 0) {
			flag = validateQryDate();
		}
		if(flag) {
			var obj = JSON.stringify($("#qryFm").serializeObject());
			obj = obj.substring(0, obj.length - 1);
			var funcNodeId = $("#qryBtn").attr("funcNodeId");
			obj += ",\"funcNodeId\":\""+funcNodeId+"\"}";
			$("#list_data").datagrid({
				url : "/sys/pubData/qryDataListByPage.do",
				queryParams:{
					param : obj
				}
			}); 
		}
	});
	$("#reset").click(function() {
		$("#qryFm").form('clear');//清空窗体数据  
		var data = $("#schoolId").combobox("getData");
		if(data.length > 0) {
			$("#schoolId").combobox("setValue", data[0].schoolId);
	    }
		if($("#startTimeFinish").length > 0) {
			initDate();
		}
	});
	exportLink("export","list_data");
});
function initDate() {
	var curr_time = new Date();
	$('#endTimeFinish').datebox('setValue', myformatter(curr_time));
	curr_time.setMonth(curr_time.getMonth() - 1);
	$('#startTimeFinish').datebox('setValue', myformatter(curr_time));
}
function validateQryDate() {
	var endTimeFinish = $("#endTimeFinish").datebox("getValue");
	var startTimeFinish = $("#startTimeFinish").datebox("getValue");
	if(endTimeFinish == "" || endTimeFinish == null || endTimeFinish == undefined
		|| startTimeFinish == "" || startTimeFinish == null || startTimeFinish == undefined) {
		showMessage("提示", "结课日期起止时间不能为空！", null);
		return false;
	} else {
		endTimeFinish = endTimeFinish.replace(/-/g,"/");
		var endTime = new Date(endTimeFinish);
		startTimeFinish = startTimeFinish.replace(/-/g,"/");
		var startTime = new Date(startTimeFinish);
		if(startTime.getTime() > endTime.getTime()) {
			showMessage("提示", "结课日期的起始日期不能大于终止日期！", null);
			return false;
		}
	}
	return true;
}