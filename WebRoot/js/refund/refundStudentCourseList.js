$(document).ready(function() {
	$("#qryBtn").click(function() {
		var s = "";
		$('input[name="courseState"]:checked').each(function() {
		    s += $(this).val() + ",";
		});
		s = s.substring(0, s.length - 1);
		var object = $("#qryFm").serializeObject();
		object.courseState = s;
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
	
	$("#refundSubmit").click(function() {
		var studentId = "";
		var courseType = "";
		var studentCourseId = "";
		var studentFlag = false;
		var courseTypeFlag = false;
		var obj = $('#list_data').datagrid('getSelections');
		for(var i = 0, n = obj.length; i < n; i++) {
			if(i == 0) {
				studentId = obj[i].studentId;
				courseType = obj[i].courseType;
			} else {
				if(studentId != obj[i].studentId) {
					studentFlag = true;
					break;
				}
				if(courseType != obj[i].courseType) {
					courseTypeFlag = true;
					break;
				}
			}
			studentCourseId += obj[i].studentCourseId + ",";
		}
		if(!studentFlag) {
			if(!courseTypeFlag) {
				studentCourseId = studentCourseId.substring(0, studentCourseId.length - 1);
				window.location.href = "/sys/refund/qryApplyRefund.do?studentCourseId="+studentCourseId+"&studentId="+studentId+"&courseType="+courseType;
			} else {
				$.messager.alert('提示', "只能多选同一个人的同类型的课程进行退费！");
			}
		} else {
			$.messager.alert('提示', "只能多选同一个人的课程进行退费！");
		}
	});
});