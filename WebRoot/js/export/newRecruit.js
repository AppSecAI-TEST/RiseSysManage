$(document).ready(function() {
	var clearFlag =true;
	var schoolData =getSchools();
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

	$("#qryBtn").click(function() {
		if(!validateQryDate()) {
			return;
		} else {
			var object = $("#qryFm").serializeObject();
			if($("[name='isAttend']").length > 0) {
				var s = "";
				$('input[name="isAttend"]:checked').each(function() {
					s += $(this).val() + ",";
				});
				s = s.substring(0, s.length - 1);
				object.isAttend = s;
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
		}
    });
	
	//重置
	$("#reset").click(function() {
		$("#qryFm").form('clear');//清空窗体数据 
		if(!clearFlag)
    	{
    		$("#schoolId").combobox('select',$("#schoolId").combobox("getData")[0].schoolId);
    	}
    	else
    	{
    		$("#schoolId").combobox('setValue',"");
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
			$("#schoolId").combobox({
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

function validateQryDate() {
	if($("#startTimePay").length > 0) {
		var startTimePay = $("#startTimePay").datebox("getValue");
		var endTimePay = $("#endTimePay").datebox("getValue");
		if(endTimePay != "" && endTimePay != null && endTimePay != undefined
				&& startTimePay != "" && startTimePay != null && startTimePay != undefined) {
			endTimePay = endTimePay.replace(/-/g,"/");
			var endTime = new Date(endTimePay);
			startTimePay = startTimePay.replace(/-/g,"/");
			var startTime = new Date(startTimePay);
			if(startTime.getTime() > endTime.getTime()) {
				showMessage("提示", "缴费日期的起始日期不能大于终止日期！", null);
				return false;
			}
		}
	}
	if($("#startTimeAttend").length > 0) {
		var type = $("#type").val();
		var endTimeAttend = $("#endTimeAttend").datebox("getValue");
		var startTimeAttend = $("#startTimeAttend").datebox("getValue");
		if("inClass30Rate" == type || "inClassAvgDays" == type || "inClassOneRate" == type) {
			if(endTimeAttend == "" || endTimeAttend == null || endTimeAttend == undefined
					|| startTimeAttend == "" || startTimeAttend == null || startTimeAttend == undefined) {
				showMessage("提示", "进班日期的起止时间不能为空！", null);
				return false;
			}
		}
		if(endTimeAttend != "" && endTimeAttend != null && endTimeAttend != undefined
				&& startTimeAttend != "" && startTimeAttend != null && startTimeAttend != undefined) {
			endTimeAttend = endTimeAttend.replace(/-/g,"/");
			var endTime = new Date(endTimeAttend);
			startTimeAttend = startTimeAttend.replace(/-/g,"/");
			var startTime = new Date(startTimeAttend);
			if(startTime.getTime() > endTime.getTime()) {
				showMessage("提示", "进班日期的起始日期不能大于终止日期！", null);
				return false;
			}
		}
	}
	if($("#startTimeOpenClass").length > 0) {
		var startTimeOpenClass = $("#startTimeOpenClass").datebox("getValue");
		var endTimeOpenClass = $("#endTimeOpenClass").datebox("getValue");
		if(endTimeOpenClass != "" && endTimeOpenClass != null && endTimeOpenClass != undefined
				&& startTimeOpenClass != "" && startTimeOpenClass != null && startTimeOpenClass != undefined) {
			endTimeOpenClass = endTimeOpenClass.replace(/-/g,"/");
			var endTime = new Date(endTimeOpenClass);
			startTimeOpenClass = startTimeOpenClass.replace(/-/g,"/");
			var startTime = new Date(startTimeOpenClass);
			if(startTime.getTime() > endTime.getTime()) {
				showMessage("提示", "开课日期的起始日期不能大于终止日期！", null);
				return false;
			}
		}
	}
	if($("#startTimeFinish").length > 0) {
		var startTimeFinish = $("#startTimeFinish").datebox("getValue");
		var endTimeFinish = $("#endTimeFinish").datebox("getValue");
		if(endTimeFinish != "" && endTimeFinish != null && endTimeFinish != undefined
				&& startTimeFinish != "" && startTimeFinish != null && startTimeFinish != undefined) {
			endTimeFinish = endTimeFinish.replace(/-/g,"/");
			var endTime = new Date(endTimeFinish);
			startTimeFinish = startTimeFinish.replace(/-/g,"/");
			var startTime = new Date(startTimeFinish);
			if(startTime.getTime() > endTime.getTime()) {
				showMessage("提示", "结课日期的起始日期不能大于终止日期！", null);
				return false;
			}
		}
	}
	return true;
}