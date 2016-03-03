$(document).ready(function() {
//	$("#tt").tabs({
//		onSelect: function (title) {
//			var src = "";
//			if(title == "退费课程查询") {
//				$("#qryBtn").click();
//			} else if(title == "退费课程管理") {
//				$("#qryApproveBtn").click();
//			} 
//		}
//	});
	
	$("#qryBtn").click(function() {
		var s = "";
		$('input[name="refundState"]:checked').each(function() {
		    s += $(this).val() + ",";
		});
		s = s.substring(0, s.length - 1);
		var funcNodeId = $("#qryBtn").attr("funcNodeId");
		var object = $("#qryRefundCourseFm").serializeObject();
		object.refundState = s;
		object.funcNodeId = funcNodeId;
    	var obj = JSON.stringify(object);
    	$('#apply_list_data').datagrid({
    		url : "/sys/pubData/qryDataListByPage.do",
    		queryParams:{
    			param : obj
    		},
    		onLoadSuccess:function(){
    			//一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题。
    			$('#apply_list_data').datagrid('clearSelections');
    		}
    	});
    });
	
	//重置
	$("#reset").click(function() {
		$("#qryRefundCourseFm").form('clear');//清空窗体数据  
		var data = $("#schoolId").combobox("getData");
		if(data.length > 0) {
			$("#schoolId").combobox("setValue", data[0].schoolId);
		}
	});
	
	$("#qryApproveBtn").click(function() {
		var s = "";
		$('input[name="approveRefundState"]:checked').each(function() {
		    s += $(this).val() + ",";
		});
		s = s.substring(0, s.length - 1);
		var object = $("#qryRefundApproveFm").serializeObject();
		var funcNodeId = $("#qryApproveBtn").attr("funcNodeId");
		object.approveRefundState = s;
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
		$("#qryRefundApproveFm").form('clear');//清空窗体数据  
		var data = $("#approveSchoolId").combobox("getData");
		if(data.length > 0) {
			$("#approveSchoolId").combobox("setValue", data[0].schoolId);
		}
	});
	
	var staffId = $("#staffId").val();
	$("#schoolId").combobox({
		url : "/sys/pub/pageCategory.do?staffId=" + staffId + "&resourceId=252&fieldId=schoolId",
    	valueField : "schoolId",
    	textField : "schoolName",
    	panelHeight : "auto",
    	formatter : function(data) {
    		return "<span>" + data.schoolName + "</span>";
    	},
    	onLoadSuccess : function() {
    		var data = $("#schoolId").combobox("getData");
    		if(data.length > 0) {
    			$("#schoolId").combobox("setValue", data[0].schoolId);
    		}
    		$("#qryBtn").click();
    	},
    	onChange : function(n, o) {
    		$("#adviserId").combobox({
    			url : "/sys/pubData/qryStaffList.do?post=16,17&schoolId=" + n,
    			valueField : "staffId",
    	    	textField : "userName",
    	    	panelHeight : "auto",
    	    	formatter : function(data) {
    	    		return "<span>" + data.userName + "</span>";
    	    	}
    		});
    		$("#teacherId").combobox({
    			url : "/sys/pubData/qryTeacherList.do?schoolId=" + n + "&classType=",
    			valueField : "teacherId",
    	    	textField : "byname",
    	    	panelHeight : "auto",
    	    	formatter : function(data) {
    	    		return "<span>" + data.byname + "</span>";
    	    	}
    		});
    	}
	});
	
	$("#courseType").combobox({
		url : "/sys/pubData/qryCodeNameList.do?tableName=STUDENT_COURSE_T&codeType=COURSE_TYPE",//返回json数据的url
    	valueField : "codeFlag",
    	textField : "codeName",
    	panelHeight : "auto",
    	formatter : function(data) {
    		return "<span>" + data.codeName + "</span>";
    	},
    	onChange : function(n, o) {
    		if("001" == n) {
    			$("#stageId").combobox({
    				url : "/sys/pubData/qryStage.do",//返回json数据的url
    		    	valueField : "stageId",
    		    	textField : "stageId",
    		    	panelHeight : "auto",
    		    	formatter : function(data) {
    		    		return "<span>" + data.stageId + "</span>";
    		    	}
    			});
    		} else {
    			$("#stageId").combobox({
    				url : "/sys/pubData/qryShortClass.do",//返回json数据的url
    		    	valueField : "shortClassId",
    		    	textField : "className",
    		    	panelHeight : "auto",
    		    	formatter : function(data) {
    		    		return "<span>" + data.className + "</span>";
    		    	}
    			});
    		}
    	}
	});
	
	$("#approveCourseType").combobox({
		url : "/sys/pubData/qryCodeNameList.do?tableName=STUDENT_COURSE_T&codeType=COURSE_TYPE",//返回json数据的url
    	valueField : "codeFlag",
    	textField : "codeName",
    	panelHeight : "auto",
    	formatter : function(data) {
    		return "<span>" + data.codeName + "</span>";
    	},
    	onChange : function(n, o) {
    		if("001" == n) {
    			$("#approveStageId").combobox({
    				url : "/sys/pubData/qryStage.do",//返回json数据的url
    		    	valueField : "stageId",
    		    	textField : "stageId",
    		    	panelHeight : "auto",
    		    	formatter : function(data) {
    		    		return "<span>" + data.stageId + "</span>";
    		    	}
    			});
    		} else {
    			$("#approveStageId").combobox({
    				url : "/sys/pubData/qryShortClass.do",//返回json数据的url
    		    	valueField : "shortClassId",
    		    	textField : "className",
    		    	panelHeight : "auto",
    		    	formatter : function(data) {
    		    		return "<span>" + data.className + "</span>";
    		    	}
    			});
    		}
    	}
	});
	
	$("#womType").combobox({
		url : "/sys/pubData/qryCodeNameList.do?tableName=STUDENT_WOM_T&codeType=WOM_TYPE",//返回json数据的url
    	valueField : "codeFlag",
    	textField : "codeName",
    	panelHeight : "auto",
    	formatter : function(data) {
    		return "<span>" + data.codeName + "</span>";
    	},
		onChange : function(n, o) {
			$("#womChannel").combobox({
				url : "/sys/pubData/qryCodeNameList.do?tableName=STUDENT_WOM_T&codeType=WOM_CHANNEL_" + n,//返回json数据的url
		    	valueField : "codeFlag",
		    	textField : "codeName",
		    	panelHeight : "auto",
		    	formatter : function(data) {
		    		return "<span>" + data.codeName + "</span>";
		    	}
			});	
		}
	});	
	
	//浏览
	$("#view").click(function() {
		var row = $('#apply_list_data').datagrid('getSelected');
		if(row) {
			var courseType = row.courseType;
			var refundFeeId = row.refundFeeId;
			window.location.href = "/sys/refund/qryApproveRefund.do?refundFeeId="+refundFeeId+"&courseType="+courseType+"&type=view";
		} else {
			$.messager.alert('提示', "请先选择您要浏览的退费申请！");
		}
	});
	
	//申请退费
	$("#refundApply").click(function() {
		window.location.href = "/sys/refund/refundStudentCourseList.jsp";
	});
	
	//退费审批
	$("#refundApprove").click(function() {
		var row = $('#approve_list_data').datagrid('getSelected');
		if (row) {
			var courseType = row.courseType;
			var refundFeeId = row.refundFeeId;
			var processInstId = row.processInstanceId;
			if (!isApprove(processInstId)) {
				return false;
			}
			window.location.href = "/sys/refund/qryApproveRefund.do?refundFeeId=" + refundFeeId + "&courseType=" + courseType + "&type=approve";
		} else {
			$.messager.alert('提示', "请先选择您要审批的退费申请！");
		}
	});
	
	//退费浏览
	$("#refundView").click(function() {
		var row = $('#approve_list_data').datagrid('getSelected');
		if(row) {
			var courseType = row.courseType;
			var refundFeeId = row.refundFeeId;
			window.location.href = "/sys/refund/qryApproveRefund.do?refundFeeId="+refundFeeId+"&courseType="+courseType+"&type=view";
		} else {
			$.messager.alert('提示', "请先选择您要浏览的退费申请！");
		}
	});
	
	//取消
	$("#refundCancel").click(function() {
		var row = $('#approve_list_data').datagrid('getSelected');
		if(row) {
			var processInstId = row.processInstanceId;
			if(!isCancel(processInstId)) {
				return;
			} else {
				var courseType = row.courseType;
				var refundFeeId = row.refundFeeId;
				window.location.href = "/sys/refund/qryApproveRefund.do?refundFeeId="+refundFeeId+"&courseType="+courseType+"&type=cancel";
			}
		} else {
			$.messager.alert('提示', "请先选择您要取消的退费申请！");
		}
	});
	
	//重新申请
	$("#refundApplyAgain").click(function() {
		var row = $('#approve_list_data').datagrid('getSelected');
		if(row) {
			var tacheState = row.tacheState;
			if("006" == tacheState || "004" == tacheState) {
				var handlerId = row.handlerId;
				var staffId = $("#staffId").val();
				if(staffId == handlerId) {
					var courseType = row.courseType;
					var refundFeeId = row.refundFeeId;
					window.location.href = "/sys/refund/qryApproveRefund.do?refundFeeId="+refundFeeId+"&courseType="+courseType+"&type=againApply";
				} else {
					$.messager.alert('提示', "该退费申请单不是由您申请，您不能重新申请！");
				}
			} else {
				var refundState = row.refundState;
				$.messager.alert('提示', "该退费申请单" + refundState + "，不能重新申请！");
			}
		} else {
			$.messager.alert('提示', "请先选择您要重新申请的退费申请！");
		}
	});
});

/**
 * 判断登陆员工是否能审批
 * @param {Object} processInstId
 * @return {TypeName} 
 */
function isApprove(processInstId)
{
	var flag = false;
	var approveId = $("#staffId").val();
	$.ajax({
		url : "/sys/fee/isApprove.do?processInstId=" + processInstId + "&approveId=" + approveId,
		data : "param=" + "",
		dataType : "json",
		async : false,
		success : function(data) {
			var id = data.processInstanceId;
			if (id == '') {
				$.messager.alert('提示', "不能审批！");
				flag = false;
			} else {
				flag = true;
			}
		}
	});
	return flag;
}

function isCancel(processInstId) {
	var flag = false;
	var approveId = $("#staffId").val();
	$.ajax({
		url : "/sys/refund/isCancel.do",
		data : "processInstId=" + processInstId + "&approveId=" + approveId ,
		dataType : "json",
		async : false,
		success : function(data) {
			flag = data.flag;
			if(!flag) {
				$.messager.alert('提示', data.msg);
			}
		}
	});
	return flag;
}
