var giftDivHeight = 0;
$(document).ready(function() {
	var refundWay = $("#refundWay").val();
	if("CASH" == refundWay) {
		$("#refundWayTr").find("td").each(function(i) {
			if(i == 1) {
				$(this).attr("colspan", 7);
			} else if(i > 1 && i < 8) {
				$(this).css("display", "none");
			}
    	});
	} else if("BANK_CARD" == refundWay) {
		$("#refundWayTr").find("td").each(function(i) {
			if(i == 1) {
				$(this).attr("colspan", 1);
			} else if(i > 1 && i < 8) {
				$(this).css("display", "table-cell");
			}
    	});
	}
	
	var favorType = $("#favorType").val();
	if(favorType != "" && favorType != null && favorType != undefined) {
		favorType = favorType.substring(0, favorType.length - 1);
		var param = "{favorId:\""+favorType+"\",queryCode:\"qryFavorList\"}";
		$.ajax({
			url: "/sys/pubData/qryData.do",
			data: "param=" + param,
			dataType: "json",
			success: function (data) {
				var content = "";
				$.each(data, function(i, obj) {
					content += "&nbsp;<input type='checkbox' checked='checked' disabled='disabled'/><span>"+obj.favorName+"</span>&nbsp;";
				});
				$("#favorTypeTd").html(content);
			}
		});
	}
	
	$("#gift_list_data").datagrid({ 
		url:"/sys/pubData/qryDataListByPage.do?param={funcNodeId:'1036',studentId:'"+$("#studentId").val()+"'}",
		onLoadSuccess: function() { 
			giftDivHeight = $("#giftDiv").height();
			$("#giftDiv").css("display", "none");
			$("#gift").html("<span>展开非缴费赠送历史记录</span>");
		}
	}); 
	
	var refundFeeId = $("#refundFeeId").val();
	$.ajax({
		url: "/sys/pubData/qryData.do",
		data: "param={'refundFeeId':'"+refundFeeId+"', 'funcNodeId':'1037'}",
		dataType: "json",
		async: true,
		success: function (data) {
			$.each(data, function(i, obj) {
				if("102" == obj.tacheState) {
					$("#financialResult").html(obj.approveTypeText);
					$("#financialDate").html(obj.createDate);
					$("#financialName").html(obj.handlerName);
					$("#financialRemark").html(obj.remark);
				} else if("104" == obj.tacheState) {
					$("#chiefFinancialOfficerResult").html(obj.approveTypeText);
					$("#chiefFinancialOfficerDate").html(obj.createDate);
					$("#chiefFinancialOfficerName").html(obj.handlerName);
					$("#chiefFinancialOfficerRemark").html(obj.remark);
				} else if("005" == obj.tacheState) {
					$("#headquartersFinancialRemark").html(obj.remark);
				}
			});
		} 
	});
	
	//根据不同的审批人员显示不同的审批信息
	var optionType = $("#optionType").val();
	var nextState = $("#nextState").val();
	if("approve" == optionType) {
		if("102" == nextState) {
			$("#financialApproveDiv").css("display", "block");
		} else if("104" == nextState) {
			$("#financialViewDiv").css("display", "block");
			$("#chiefFinancialOfficerApproveDiv").css("display", "block");
		} else if("108" == nextState) {
			$("#financialViewDiv").css("display", "block");
			$("#chiefFinancialOfficerViewDiv").css("display", "block");
			$("#headquartersFinancialApproveDiv").css("display", "block");
		}
	} else if("cancel" == optionType) {
		var tacheState = $("#tacheState").val();
		if("005" == tacheState) {
			$("#financialApproveDiv").css("display", "block");
			$("#chiefFinancialOfficerViewDiv").css("display", "block");
			$("#headquartersFinancialViewDiv").css("display", "block");
		} else {
			if("102" == nextState) {
				$("#approveDiv").css("display", "none");
			} else if("104" == nextState) {
				$("#financialViewDiv").css("display", "block");
			} else if("108" == nextState) {
				$("#financialViewDiv").css("display", "block");
				$("#chiefFinancialOfficerViewDiv").css("display", "block");
			}
		}
	}
	
	$("input", $("#minusTextbookFee").next("span")).blur(function() {
		calculateRefundAmount();
	});
	
	$("input", $("#minusCourseFee").next("span")).blur(function() {
		calculateRefundAmount();
	});
	
	$("input", $("#handlingChange").next("span")).blur(function() {
		calculateRefundAmount();
	});
	
	$("input", $("#minusOtherFee").next("span")).blur(function() {
		calculateRefundAmount();
	});
	
	var refundImgUrl = $("#refundImgUrl").val();
	if(refundImgUrl != null && refundImgUrl != "" && refundImgUrl != undefined) {
		$("#imgUrl").css("display", "inline-block");
		$("#url").attr("href", refundImgUrl);
		$('#url').lightBox();
	} 
	
	//审批提交
	$("#refundApproveSubmit").click(function() {
		var flag = true;
		var isTransfer = "N";
		var nextState = $("#nextState").val();
		if("108" == nextState) {
			var transfer = $("input:checkbox[name='isTransfer']:checked").val();
			if(transfer == null || transfer == "" || transfer == undefined) {
				$.messager.alert('提示', "请选择是否已打款！");
				flag = false;
			} else {
				if(transfer) {
					isTransfer = "Y";
				}
			}
		} else {
			var approveType = $('input:radio[name="approveType"]:checked').val();
			if(approveType == "" || approveType == null || approveType == undefined || approveType == "null") {
				$.messager.alert('提示', "请选择是否审批通过！");
				flag = false;
			} 
		}
		if(flag) {
			var obj = $("#refundApproveFm").serializeObject();
			var approveObj = new Object();
			var approveRemark = "";
			approveObj.approveId = obj.approveId;
			approveObj.processInstId = obj.processInstanceId;
			approveObj.approveResult = approveType;
			$("[name='approveRemark']").each(function() {
				var remark = $(this).val();
				if(remark != "" && remark != null && remark != undefined) {
					approveRemark = remark;
				}
			});
			approveObj.remark = approveRemark;
			if("108" == nextState) {
				approveObj.isTransfer = isTransfer;
				approveObj.approveResult = "Y";
			}
			var param = JSON.stringify(approveObj);
			param = encodeURI(param);
			$.ajax({
				url: "/sys/refund/approveRefund.do",
				data: "param=" + param,
				dataType: "json",
				async: true,
				beforeSend: function()
				{
					$.messager.progress({title : '审批退费', msg : '正在审批退费，请稍等……'});
				},
				success: function (data) {
					$.messager.progress('close'); 
					var flag = data.flag;
					if(flag) {
						$.messager.alert('提示', "退费审批成功！", "info", function() {window.location.href = "/sys/refund/refund.jsp";});
					} else {
						$.messager.alert('提示', data.msg);
					}
				} 
			});
		}
	});
	
	//取消退费
	$("#refundCancelSubmit").click(function() {
		var obj = $("#refundCancelFm").serializeObject();
		var param = JSON.stringify(obj);
		param = encodeURI(param);
		$.ajax({
			url: "/sys/refund/cancelRefund.do",
			data: "param=" + param,
			dataType: "json",
			async: true,
			beforeSend: function()
			{
				$.messager.progress({title : '取消退费', msg : '正在取消退费，请稍等……'});
			},
			success: function (data) {
				$.messager.progress('close'); 
				var flag = data.flag;
				if(flag) {
					$.messager.alert('提示', "取消退费成功！", "info", function() {window.location.href = "/sys/refund/refund.jsp";});
				} else {
					$.messager.alert('提示', data.msg);
				}
			} 
		});
	});
});

function calculateRefundAmount() {
	var refundStageFee = parseFloat($("#refundStageFee").val());
	var minusGiftFee = parseFloat($("#minusGiftFee").textbox("getValue"));
	var total = 0;
	if(minusGiftFee >= refundStageFee) {
		$("#minusGiftFee").textbox("setValue", 0);
	} else {
		var minusTextbookFee = parseFloat($("#minusTextbookFee").textbox("getValue"));
		total = parseFloat(minusGiftFee + minusTextbookFee);
		if(total >= refundStageFee) {
			$("#minusTextbookFee").textbox("setValue", 0);
		} else {
			var minusCourseFee = parseFloat($("#minusCourseFee").textbox("getValue"));
			total = parseFloat(minusGiftFee + minusTextbookFee + minusCourseFee);
			if(total >= refundStageFee) {
				$("#minusCourseFee").textbox("setValue", 0);
			} else {
				var handlingChange = parseFloat($("#handlingChange").textbox("getValue"));
				total = parseFloat(minusGiftFee + minusTextbookFee + minusCourseFee + handlingChange);
				if(total >= refundStageFee) {
					$("#handlingChange").textbox("setValue", 0);
				} else {
					var minusOtherFee = parseFloat($("#minusOtherFee").textbox("getValue"));
					total = parseFloat(minusGiftFee + minusTextbookFee + minusCourseFee + handlingChange + minusOtherFee);
					if(total >= refundStageFee) {
						$("#minusOtherFee").textbox("setValue", 0);
					} else {
						var confirmRefundFee = refundStageFee - total;
						$("#totalAmount").val(confirmRefundFee);
						$("#totalAmountText").html(confirmRefundFee);
					}
				}
			}
		}
	}
}

function viewGiftHist() {
	var giftDivDisplay = $("#giftDiv").css("display");
	if("none" == giftDivDisplay) {
		$("#giftDiv").height(giftDivHeight);
		$("#giftDiv").css("display", "block");
		$("#gift").html("<span>收缩非缴费赠送历史记录</span>");
	} else {
		$("#giftDiv").css("display", "none");
		$("#gift").html("<span>展开非缴费赠送历史记录</span>");
	}
}

function viewStudentCourseList() {
	$('#dlg').form('clear');//清空窗体数据 
	var studentId = $("#studentId").val();
	$("#course_list_data").datagrid({ 
		url:"/sys/pubData/qryDataListByPage.do?param={funcNodeId:'1016',studentId:'"+studentId+"'}",
		onLoadSuccess: function() { 
			var rows = $("#course_list_data").datagrid('getRows');
			if(parseInt(rows.length) <= 0) {
				$("#courseDiv").css("display", "none");
			}
		}
	});
	$("#international_list_data").datagrid({ 
		url:"/sys/pubData/qryDataListByPage.do?param={funcNodeId:'1038',studentId:'"+studentId+"'}",
		onLoadSuccess: function() { 
			var rows = $("#international_list_data").datagrid('getRows');
			if(parseInt(rows.length) <= 0) {
				$("#internationalDiv").css("display", "none");
			}
		}
	});
	$("#travel_list_data").datagrid({ 
		url:"/sys/pubData/qryDataListByPage.do?param={funcNodeId:'1039',studentId:'"+studentId+"'}",
		onLoadSuccess: function() { 
			var rows = $("#travel_list_data").datagrid('getRows');
			if(parseInt(rows.length) <= 0) {
				$("#travelDiv").css("display", "none");
			}
		}
	});
	$('#dlg').dialog('open').dialog('setTitle', '课程信息');//设定表头  
}