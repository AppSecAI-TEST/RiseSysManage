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
	
	var funcNodeId = $("#funcNodeId").val();
	if(funcNodeId != null && funcNodeId != "" && funcNodeId != undefined) {
		var staffId = $("#staffId").val();
		$("#schoolId").combobox({
    		url : "/sys/pubData/qrySchoolList.do?schoolId=",//返回json数据的url
    		valueField : "schoolId",
    		textField : "schoolName",
    		panelHeight : "auto",
    		formatter : function(data) {
    			return "<span>" + data.schoolName + "</span>";
    		},
    		onLoadSuccess : function(data) {
    			if(data.length > 0) {
    				$("#schoolId").combobox("setValue", data[0].schoolId);
    			}
    		},
    		onChange : function(n, o) {
    			if(n != "" && n != null && n != undefined) {
    				$("#classInstId").combobox({disabled: false});
    				$("#classInstId").combobox({
    					url : "/sys/pubData/qryClassInstList.do?schoolId="+n+"&courseType=&stageId=&classType=&classState='001','002','003','004','005'&classInstId=",//返回json数据的url
    					valueField : "classInstId",
    					textField : "className",
    					panelHeight : "auto",
    					formatter : function(data) {
    						return "<span>" + data.className + "</span>";
    					}
    				});
    				$("#teacherId").combobox({
    					url : "/sys/pubData/qryTeacherList.do?schoolId="+n+"&classType=",//返回json数据的url
    					valueField : "teacherId", 
    					textField : "byname",
    					panelHeight : "auto",
    					formatter : function(data) {
    						return "<span>" + data.byname + "</span>";
    					}
    				});
    			} else {
    				var data = $("#schoolId").combobox("getData");
    				if(data.length > 0) {
    					$("#schoolId").combobox("setText", data[0].schoolId);
    				}
    				$("#classInstId").combobox('clear');
    				$("#classInstId").combobox("loadData", new Array());
    				$("#classInstId").combobox({disabled: true});
    			}
    		}
		});
	}
	
	$("#stageId").combobox({
		url : "/sys/pubData/qryStage.do",//返回json数据的url
    	valueField : "stageId",
    	textField : "stageId",
    	panelHeight : "auto",
    	formatter : function(data) {
    		return "<span>" + data.stageId + "</span>";
    	},
		onChange : function(n, o) {
			var schoolId = $("#schoolId").combobox("getValue");
			if(n != "" && n != null && n != undefined) {
				$("#classInstId").combobox({disabled: false});
				//转出班级
				$("#classInstId").combobox({
					url : "/sys/pubData/qryClassInstList.do?schoolId="+schoolId+"&courseType=&stageId="+n+"&classType=&classState='001','002','003','004','005'&classInstId=",//返回json数据的url
					valueField : "classInstId",
					textField : "className",
					panelHeight : "auto",
					formatter : function(data) {
						return "<span>" + data.className + "</span>";
					}
				});
			}
		}
	});
	
	initQryButton("qryBtn", "reset", "qryFm", "list_data");
	initQryButton("qryApproveBtn", "resetApprove", "qryApproveFm", "approve_list_data");
	
	//放班申请
	$("#applyClass").click(function() {
    	window.location.href = "/sys/applyClass/addApplyClass.jsp";
    });
	
	//取消放班申请
	$("#cancelApplyClass").click(function() {
		var row = $('#list_data').datagrid('getSelected');
		if(row) {
			var classState = row.classState;
			if(classState == "001" || classState == "002") {
				var tacheState = row.tacheState;
				if(tacheState == "002" || tacheState == "006") {
					var classStudentNum = row.classStudentNum;
					if(classStudentNum == 0) {
						var classInstId = row.classInstId;
						var applyId = row.applyId;
						window.location.href = "/sys/applyClass/cancelApplyClass.jsp?classInstId="+classInstId+"&applyId="+applyId;
					} else {
						var className = row.className;
						$.messager.alert('提示', "您选择的"+className+"中还有"+classStudentNum+"个学员，不能再申请取消放班！");
					}
				} else {
					$.messager.alert('提示', "您选择的班级已经申请取消放班，不能再申请取消放班！");
				}
			} else {
				var classStateText = row.classStateText;
				$.messager.alert('提示', "您选择的班级为"+classStateText+"，不能再申请取消放班！");
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
			if(classState == "001" || classState == "002") {
				var classInstId = row.classInstId;
				var funcNodeId = $("#funcNodeId").val();
				window.location.href = "/sys/applyClass/qryCreateClass.do?classInstId="+classInstId+"&type=update&applyType=001&classState="+classState+"&funcNodeId="+funcNodeId;
			} else {
				var classStateText = row.classStateText;
				$.messager.alert('提示', "您选择的班级为"+classStateText+"，不能维护该班级！");
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