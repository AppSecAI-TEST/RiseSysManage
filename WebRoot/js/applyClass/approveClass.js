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
	
	//放班审批
	$("#applyApprove").click(function() {
		var row = $('#list_data').datagrid('getSelected');
		if(row) {
			var tacheState = row.tacheState;
			if(tacheState == "001") {
				var applyId = row.applyId;
				var classInstId = row.classInstId;
				window.location.href = "/sys/applyClass/applyApprove.jsp?applyId="+applyId+"&classInstId="+classInstId;
			} else {
				var approveStateText = row.approveStateText;
				$.messager.alert('提示', "您选择的申请记录的审批状态为"+approveStateText+",该审批状态不能放班审批！");
			}
		} else {
			$.messager.alert('提示', "请先选择您要审批的放班申请！");
		}
	});
	
	//取消放班审批
	$("#cancelApprove").click(function() {
		var row = $('#list_data').datagrid('getSelected');
		if(row) {
			var tacheState = row.tacheState;
			if(tacheState == "004") {
				var applyId = row.applyId;
				var classInstId = row.classInstId;
				window.location.href = "/sys/applyClass/cancelApprove.jsp?applyId="+applyId+"&classInstId="+classInstId;
			} else {
				var approveStateText = row.approveStateText;
				$.messager.alert('提示', "您选择的申请记录的审批状态为"+approveStateText+",该审批状态不能取消放班审批！");
			}
		}else {
			$.messager.alert('提示', "请先选择您要审批的取消放班申请！");
		}
	});
	
	//浏览
	$("#view").click(function() {
		var row = $('#list_data').datagrid('getSelected');
		if(row) {
			var classInstId = row.classInstId;
			alert(classInstId);
			window.location.href = "/sys/applyClass/qryCreateClass.do?classInstId="+classInstId+"&type=view";
		} else {
			$.messager.alert('提示', "请先选择您要浏览的班级！");
		}
	});
});