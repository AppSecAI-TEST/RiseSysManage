$(document).ready(function() {
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
    			//一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题。
    			$('#list_data').datagrid('clearSelections');
    		}
    	});
    });
	
	//重置
	$("#reset").click(function() {
		$("#qryFm").form('clear');//清空窗体数据 
		if($("#schoolId").length > 0) {
			var data = $("#schoolId").combobox("getData");
			if(data.length > 0) {
				$("#schoolId").combobox("setValue", data[0].schoolId);
			}
		}
		var type = $("#type").val();
		if("inClass30Rate" == type || "inClassOneRate" == type || "inClassAvgDays" == type) {
			initDate();
		}
	});
	
	if($("#schoolId").length > 0) {
		var type = $("#type").val();
		if("inClassDetail" == type || "inClass30Rate" == type || "higherInClassDetail" == type || "classDetail" == type
				|| "inClassOneRate" == type || "inClassAvgDays" == type || "notInClassAvgDays" == type) {
			var staffId = $("#staffId").val();
			$("#schoolId").combobox({
				url : "/sys/pub/pageCategory.do?staffId=" + staffId + "&resourceId=711&fieldId=schoolId",
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
		    		$("#qryBtn").click();
		    	},
				onChange : function(n, o) {
					if($("#carer").length > 0) {
						$("#carer").combobox({
							url : "/sys/pubData/qryStaffList.do?post=31,32,33&schoolId=" + n,
							valueField : "staffId",
							textField : "userName",
							panelHeight : "auto",
							formatter : function(data) {
								return "<span>" + data.userName + "</span>";
							}
						});
					}
				}
			});
			if("inClass30Rate" == type || "inClassOneRate" == type || "inClassAvgDays" == type) {
				initDate();
			}
		}
	}
});

function initDate() {
	var curr_time = new Date();
	$('#endTimePay').datebox('setValue', myformatter(curr_time));
	$('#endTimeAttend').datebox('setValue', myformatter(curr_time));
	$('#endTimeFinish').datebox('setValue', myformatter(curr_time));
	$('#endTimeOpenClass').datebox('setValue', myformatter(curr_time));
	curr_time.setMonth(curr_time.getMonth() - 1);
	$('#startTimePay').datebox('setValue', myformatter(curr_time));
	$('#startTimeAttend').datebox('setValue', myformatter(curr_time));
	$('#startTimeFinish').datebox('setValue', myformatter(curr_time));
	$('#startTimeOpenClass').datebox('setValue', myformatter(curr_time));
}