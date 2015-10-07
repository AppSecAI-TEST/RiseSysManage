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
	
	//审批
	$("#approve").click(function() {
		var row = $('#list_data').datagrid('getSelected');
		if(row) {
			var openClassState = row.openClassState;
			if(openClassState == '001') {
				var classInstId = row.classInstId;
				window.location.href = "/sys/openClass/qryCreateClass.do?classInstId="+classInstId+"&type=approve&applyType=002";
			} else {
				if(openClassState == "002") {
					$.messager.alert('提示', "您选择的班级已经审批通过，无需再次审批！");
				} else if(openClassState == "003") {
					$.messager.alert('提示', "您选择的班级审批未通过，不能再次审批！");
				}
			}
		} else {
			$.messager.alert('提示', "请先选择您要审批的班级！");
		}
	});
	
	//浏览
	$("#view").click(function() {
		var row = $('#list_data').datagrid('getSelected');
		if(row) {
			var classInstId = row.classInstId;
			window.location.href = "/sys/openClass/qryCreateClass.do?classInstId="+classInstId+"&type=view&applyType=002";
		} else {
			$.messager.alert('提示', "请先选择您要浏览的班级！");
		}
	});
});