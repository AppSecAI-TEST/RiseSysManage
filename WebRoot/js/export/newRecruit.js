$(document).ready(function() {
	initDate();
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
	
	$("#qryBtn").click();
});

function initDate()
{
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