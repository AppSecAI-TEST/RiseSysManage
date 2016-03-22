$(document).ready(function() {
	var clearFlag =true;
	var schoolData = [1001,1002,1003,1004,1005,1006,1007,1008,1009,1010,1011,1012,1013];	
	if($("#schoolId").length > 0) {
		$("#schoolId").combobox({
		loader:function(param,success,error){  
		    $.ajax({  
				url: "/sys/pub/pageCategory.do?staffId="+$("#staffId").val()+"&resourceId="+$("#resourceId").val()+"&fieldId=schoolId",  
				dataType: 'json',  
				success: function(data){
		    	if(data.length==schoolData.length)
		    	{
		    		data.unshift({schoolName:'所有校区',schoolId:""});  
		    	}	
				success(data);  
				}
			});  
   		},
		onLoadSuccess:function(){
			var arr =$("#schoolId").combobox("getData");
			if(arr.length<schoolData.length)
			{
				$("#schoolId").combobox("select",arr[0].schoolId);
				clearFlag =false;
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
		if($("#startTimeFinish").length > 0) {
			initDate();
		}
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