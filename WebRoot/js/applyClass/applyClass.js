$(document).ready(function() {
	$("#tt").tabs({
		onSelect: function (title) {
			var src = "";
			if(title == "放班班级管理") {
				$("#qryBtn").click();
			} else if(title == "放班审批管理") {
				$("#qryApproveBtn").click();
			} 
		}
	});
	
	$("#stageId").combobox({
		url : "/sys/pubData/qryStage.do",//返回json数据的url
    	valueField : "stageId",
    	textField : "stageId",
    	panelHeight : "auto",
		onChange : function(n, o) {
			var schoolId = $("#schoolId").combobox("getValue");
			//转出班级
			$("#classInstId").combobox({
        		url : "/sys/pubData/qryClassInstList.do?schoolId="+schoolId+"&courseType=&stageId="+n+"&classType=&classState='001','002','003','004','005'&classInstId=",//返回json数据的url
        		valueField : "classInstId",
        		textField : "className",
        		panelHeight : "auto"
        	});
		}
	});
	
	$("#qryApproveBtn").click(function() {
    	var obj = JSON.stringify($("#qryApproveFm").serializeObject());
    	obj = obj.substring(0, obj.length - 1);
    	var funcNodeId = $("#qryApproveBtn").attr("funcNodeId");
    	obj += ",\"funcNodeId\":\""+funcNodeId+"\"}";
    	$('#approve_list_data').datagrid({
    		url : "/sys/pubData/qryDataListByPage.do",
    		queryParams:{
    			param : obj
    		},
    		onLoadSuccess:function(){
    			//一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题。
    			$('#approve_list_data').datagrid('clearSelections');
    		}
    	});
    });
	
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
					var openClassState = row.openClassState;
					if(openClassState == null || openClassState == "" || openClassState == undefined) {
						var classInstId = row.classInstId;
						var applyId = row.applyId;
						window.location.href = "/sys/applyClass/cancelApplyClass.jsp?classInstId="+classInstId+"&applyId="+applyId;
					} else {
						var openClassStateText = row.openClassStateText;
						if(openClassState == "002") {
							$.messager.alert('提示', "您选择的班级"+openClassStateText+"开班，不能再申请取消放班！");
						} else {
							$.messager.alert('提示', "您选择的班级申请开班"+openClassStateText+"，不能再申请取消放班！");
						}
					}
				} else {
					$.messager.alert('提示', "您选择的班级已经申请取消放班，不能再申请取消放班！");
				}
			} else {
				var classStateText = row.classStateText;
				$.messager.alert('提示', "您选择的班级已经"+classStateText+"，不能再申请取消放班！");
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
				window.location.href = "/sys/applyClass/qryCreateClass.do?classInstId="+classInstId+"&type=update&applyType=001";
			} else {
				$.messager.alert('提示', "您选择的班级已经取消放班审批通过，不能维护该班级！");
			}
		} else {
			$.messager.alert('提示', "请先选择您要维护的班级！");
		}
	});
	
	//浏览
	$("#view").click(function() {
		var row = $('#list_data').datagrid('getSelected');
		if(row) {
			var classInstId = row.classInstId;
			window.location.href = "/sys/applyClass/qryCreateClass.do?classInstId="+classInstId+"&type=view&applyType=001";
		} else {
			$.messager.alert('提示', "请先选择您要浏览的班级！");
		}
	});
	
	//放班审批
	$("#applyApprove").click(function() {
		var row = $('#approve_list_data').datagrid('getSelected');
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
		var row = $('#approve_list_data').datagrid('getSelected');
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
	$("#viewApprove").click(function() {
		var row = $('#approve_list_data').datagrid('getSelected');
		if(row) {
			var classInstId = row.classInstId;
			window.location.href = "/sys/applyClass/qryCreateClass.do?classInstId="+classInstId+"&type=view&applyType=001";
		} else {
			$.messager.alert('提示', "请先选择您要浏览的班级！");
		}
	});
});