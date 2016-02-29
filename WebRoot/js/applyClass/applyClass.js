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
	
	$("#qryBtn").click(function() {
		var object = $("#qryFm").serializeObject();
		var funcNodeId = $("#qryBtn").attr("funcNodeId");
		object.funcNodeId = funcNodeId;
    	var obj = JSON.stringify(object);
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
		var data = $("#schoolId").combobox("getData");
		if(data.length > 0) {
			$("#schoolId").combobox("setValue", data[0].schoolId);
		}
	});
	
	$("#qryApproveBtn").click(function() {
		var object = $("#qryApproveFm").serializeObject();
		var funcNodeId = $("#qryApproveBtn").attr("funcNodeId");
		object.funcNodeId = funcNodeId;
    	var obj = JSON.stringify(object);
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
	
	//重置
	$("#resetApprove").click(function() {
		$("#qryApproveFm").form('clear');//清空窗体数据  
		var data = $("#schoolId").combobox("getData");
		if(data.length > 0) {
			$("#approveSchoolId").combobox("setValue", data[0].schoolId);
		}
	});
	
	var staffId = $("#staffId").val();
	$("#schoolId").combobox({
		url : "/sys/pub/pageCategory.do?staffId=" + staffId + "&resourceId=501&fieldId=schoolId",
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
			$("#qryBtn").click();
		},
		onChange : function(n, o) {
			if(n != "" && n != null && n != undefined) {
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
			}
		}
	});
	
	$("#approveSchoolId").combobox({
		url : "/sys/pub/pageCategory.do?staffId=" + staffId + "&resourceId=501&fieldId=schoolId",
		valueField : "schoolId",
		textField : "schoolName",
		panelHeight : "auto",
		formatter : function(data) {
			return "<span>" + data.schoolName + "</span>";
		},
		onLoadSuccess : function(data) {
			if(data.length > 0) {
				$("#approveSchoolId").combobox("setValue", data[0].schoolId);
			}
		}
	});
	
	//放班申请
	$("#applyClass").click(function() {
		var curr_time = new Date();
		var date = curr_time.getDate();
		if(date <= 15) {
			window.location.href = "/sys/applyClass/addApplyClass.jsp";
		} else {
			$.messager.alert('提示', "每月15号前可以申请放班，超过15号不允许申请放班！");
		}
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
				var tacheState = row.tacheState;
				//审批通过  放班取消申请  取消放班审批未通过
				if(tacheState == "002" || tacheState == "004" || tacheState == "006") {
					var classInstId = row.classInstId;
					var funcNodeId = $("#funcNodeId").val();
					window.location.href = "/sys/applyClass/qryCreateClass.do?classInstId="+classInstId+"&type=update&applyType=001&classState="+classState+"&funcNodeId="+funcNodeId;
				} else {
					var tacheStateText = row.tacheStateText;
					if(tacheStateText == null || tacheStateText == "" || tacheStateText == undefined) {
						tacheStateText = row.cancelApplyClassStateText;
					}
					$.messager.alert('提示', "您选择的班级已"+tacheStateText+"，不能维护该班级！");
				}
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