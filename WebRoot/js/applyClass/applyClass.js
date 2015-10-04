$(document).ready(function() {
	$("#qryBtn").click(function() {
    	var obj = JSON.stringify($("#qryFm").serializeObject());
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
	
	//放班申请
	$("#applyClass").click(function() {
    	window.location.href = "/sys/applyClass/addApplyClass.jsp";
    });
	
	//取消放班申请
	$("#cancelApplyClass").click(function() {
		var row = $('#list_data').datagrid('getSelected');
		if(row) {
			var classState = row.classState;
			if(classState == "001") {
				var tacheState = row.tacheState;
				if(tacheState == "002" || tacheState == "006") {
					var classInstId = row.classInstId;
					var applyId = row.applyId;
					window.location.href = "/sys/applyClass/cancelApplyClass.jsp?classInstId="+classInstId+"&applyId="+applyId;
				} else {
					$.messager.alert('提示', "您选择的班级已经申请取消放班，不能再申请取消放班！");
				}
			} else {
				$.messager.alert('提示', "您选择的班级已经取消放班审批通过，不能再申请取消放班！");
			}
		} else {
			$.messager.alert('提示', "请先选择您要取消放班的班级！");
		}
    });
	
	//班级维护
	$("#updateApplyClass").click(function() {
		var row = $('#list_data').datagrid('getSelected');
		if(row) {
			var classState = row.classState;
			if(classState == "001") {
				var classInstId = row.classInstId;
				window.location.href = "/sys/applyClass/qryCreateClass.do?classInstId="+classInstId;
			} else {
				$.messager.alert('提示', "您选择的班级已经取消放班审批通过，不能维护该班级！");
			}
		} else {
			$.messager.alert('提示', "请先选择您要维护的班级！");
		}
	});
});