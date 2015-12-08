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
	
	$("[name='studentCourseId']").each(function() {
		var studentCourseId = $(this).val();
		$("input", $("#minusGiftFee" + studentCourseId).next("span")).blur(function() {
			calculateRefundAmount(studentCourseId);
		});
		
		$("input", $("#minusTextbookFee" + studentCourseId).next("span")).blur(function() {
			calculateRefundAmount(studentCourseId);
		});
		
		$("input", $("#minusCourseFee" + studentCourseId).next("span")).blur(function() {
			calculateRefundAmount(studentCourseId);
		});
		
		$("input", $("#handlingChange" + studentCourseId).next("span")).blur(function() {
			calculateRefundAmount(studentCourseId);
		});
		
		$("input", $("#minusOtherFee" + studentCourseId).next("span")).blur(function() {
			calculateRefundAmount(studentCourseId);
		});
		
		$("input", $("#financialConfirmRefundFee" + studentCourseId).next("span")).blur(function() {
			calculateConfirmRefundAmount(studentCourseId);
		});
		
		$("#refundFeeImgUrl" + studentCourseId).lightBox();
	});
	
	//提交审批
	$("#refundApproveSubmit").click(function() {
		var flag = true;
		var masterType = "";
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
			} else {
				if("104" == nextState) {
					masterType = $("#masterType").combobox("getValue");
					if(masterType == null || masterType == "" || masterType == undefined) {
						$.messager.alert('提示', "请选择后续审批人类型！");
						flag = false;
					}
				}
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
			if("104" == nextState) {
				approveObj.masterType = masterType;
			} else if("108" == nextState) {
				approveObj.isTransfer = isTransfer;
				approveObj.approveResult = "Y";
			}
			var param = JSON.stringify(approveObj);
			param = encodeURI(param);
			$.ajax({
				url: "/sys/refund/approveRefund.do",
				data: "param=" + param,
				dataType: "json",
				async: false,
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
		async: false,
		success: function (data) {
			$.each(data, function(i, obj) {
				if("101" == obj.tacheState) {
					$("#headmasterResult").html(obj.approveTypeText);
					$("#headmasterDate").html(obj.createDate);
					$("#headmasterName").html(obj.handlerName);
					$("#headmasterRemark").html(obj.remark);
				} else if("102" == obj.tacheState) {
					$("#financialResult").html(obj.approveTypeText);
					$("#financialDate").html(obj.createDate);
					$("#financialName").html(obj.handlerName);
					$("#financialRemark").html(obj.remark);
				} else if("103" == obj.tacheState) {
					$("#chiefFinancialOfficerResult").html(obj.approveTypeText);
					$("#chiefFinancialOfficerDate").html(obj.createDate);
					$("#chiefFinancialOfficerName").html(obj.handlerName);
					$("#chiefFinancialOfficerRemark").html(obj.remark);
				} else if("104" == obj.tacheState || "105" == obj.tacheState) {
					$("#academicOrSalesResult").html(obj.approveTypeText);
					$("#academicOrSalesDate").html(obj.createDate);
					$("#academicOrSalesName").html(obj.handlerName);
					$("#academicOrSalesRemark").html(obj.remark);
				} else if("106" == obj.tacheState) {
					$("#regionalPresidentResult").html(obj.approveTypeText);
					$("#regionalPresidentDate").html(obj.createDate);
					$("#regionalPresidentName").html(obj.handlerName);
					$("#regionalPresidentRemark").html(obj.remark);
				} else if("107" == obj.tacheState) {
					$("#principalResult").html(obj.approveTypeText);
					$("#principalDate").html(obj.createDate);
					$("#principalName").html(obj.handlerName);
					$("#principalRemark").html(obj.remark);
				}
			});
		} 
	});
	
	//根据不同的审批人员显示不同的审批信息
	var nextState = $("#nextState").val();
	var isAcademic = $("#isAcademic").val();
	var refundRule = $("#refundRule").val();
	if("100" == nextState || "101" == nextState) {
		$("#headmasterApproveDiv").css("display", "block");
	} else if("102" == nextState) {
		$("#headmasterViewDiv").css("display", "block");
		$("#financialApproveDiv").css("display", "block");
	} else if("103" == nextState) {
		$("#headmasterViewDiv").css("display", "block");
		$("#financialViewDiv").css("display", "block");
		$("#chiefFinancialOfficerApproveDiv").css("display", "block");
	} else if("104" == nextState || "105" == nextState) {
		$("#masterType").combobox({
			url : "/sys/pubData/qryCodeNameList.do?tableName=REFUND_FEE_T&codeType=MASTER_TYPE",//返回json数据的url
	    	valueField : "codeFlag",
	    	textField : "codeName",
	    	panelHeight : "auto"
		});
		$("#headmasterViewDiv").css("display", "block");
		$("#financialViewDiv").css("display", "block");
		if("SPECIAL_ADJUST" == refundRule) {
			$("#chiefFinancialOfficerViewDiv").css("display", "block");
		}
		$("#academicOrSalesApproveDiv").css("display", "block");
	} else if("106" == nextState) {
		$("#headmasterViewDiv").css("display", "block");
		$("#financialViewDiv").css("display", "block");
		if("SPECIAL_ADJUST" == refundRule) {
			$("#chiefFinancialOfficerViewDiv").css("display", "block");
		}
		$("#academicOrSalesViewDiv").css("display", "block");
		$("#regionalPresidentApproveDiv").css("display", "block");
	} else if("107" == nextState) {
		$("#headmasterViewDiv").css("display", "block");
		$("#financialViewDiv").css("display", "block");
		if("SPECIAL_ADJUST" == refundRule) {
			$("#chiefFinancialOfficerViewDiv").css("display", "block");
		}
		$("#academicOrSalesViewDiv").css("display", "block");
		var regionalPresidentResult = $("#regionalPresidentResult").html();
		if(regionalPresidentResult != null && regionalPresidentResult != "" && regionalPresidentResult != undefined) {
			$("#regionalPresidentViewDiv").css("display", "block");
		}
		$("#principalApproveDiv").css("display", "block");
	} else if("108" == nextState) {
		$("#headmasterViewDiv").css("display", "block");
		$("#financialViewDiv").css("display", "block");
		if("SPECIAL_ADJUST" == refundRule) {
			$("#chiefFinancialOfficerViewDiv").css("display", "block");
		}
		$("#academicOrSalesViewDiv").css("display", "block");
		var regionalPresidentResult = $("#regionalPresidentResult").html();
		if(regionalPresidentResult != null && regionalPresidentResult != "" && regionalPresidentResult != undefined) {
			$("#regionalPresidentViewDiv").css("display", "block");
		}
		var principalResult = $("#principalResult").html();
		if(principalResult != null && principalResult != "" && principalResult != undefined) {
			$("#principalViewDiv").css("display", "block");
		}
		$("#headquartersFinancialApproveDiv").css("display", "block");
	}
	
	var refundImgUrl = $("#refundImg").attr("href");
	if(refundImgUrl != null && refundImgUrl != "" && refundImgUrl != undefined) {
		$('#refundImg').lightBox();
	}
});

function calculateRefundAmount(studentCourseId) {
	var refundStageFee = parseFloat($("#refundStageFee" + studentCourseId).html());
	var minusGiftFee = parseFloat($("#minusGiftFee" + studentCourseId).numberbox("getValue"));
	var total = 0;
	if(minusGiftFee >= refundStageFee) {
		$("#minusGiftFee" + studentCourseId).numberbox("setValue", 0);
	} else {
		var minusTextbookFee = parseFloat($("#minusTextbookFee" + studentCourseId).numberbox("getValue"));
		total = parseFloat(minusGiftFee + minusTextbookFee);
		if(total >= refundStageFee) {
			$("#minusTextbookFee" + studentCourseId).numberbox("setValue", 0);
		} else {
			var minusCourseFee = parseFloat($("#minusCourseFee" + studentCourseId).numberbox("getValue"));
			total = parseFloat(minusGiftFee + minusTextbookFee + minusCourseFee);
			if(total >= refundStageFee) {
				$("#minusCourseFee" + studentCourseId).numberbox("setValue", 0);
			} else {
				var handlingChange = parseFloat($("#handlingChange" + studentCourseId).numberbox("getValue"));
				total = parseFloat(minusGiftFee + minusTextbookFee + minusCourseFee + handlingChange);
				if(total >= refundStageFee) {
					$("#handlingChange" + studentCourseId).numberbox("setValue", 0);
				} else {
					var minusOtherFee = parseFloat($("#minusOtherFee" + studentCourseId).numberbox("getValue"));
					total = parseFloat(minusGiftFee + minusTextbookFee + minusCourseFee + handlingChange + minusOtherFee);
					if(total >= refundStageFee) {
						$("#minusOtherFee" + studentCourseId).numberbox("setValue", 0);
					} else {
						var confirmRefundFee = refundStageFee - total;
						$("#confirmRefundFee" + studentCourseId).html(confirmRefundFee);
						var totalAmount = 0;
						$("[name='confirmRefundFee']").each(function() {
							totalAmount += parseFloat($(this).html());
						});
						$("#totalAmount").val(totalAmount);
						$("#totalAmountText").html(totalAmount);
					}
				}
			}
		}
	}
}

function calculateConfirmRefundAmount(studentCourseId) {
	var realAmount = 0;
	$("[name='studentCourseId']").each(function() {
		var studentCourseId = $(this).val();
		var financialConfirmRefundFee = $("#financialConfirmRefundFee" + studentCourseId).numberbox("getValue");
		if(financialConfirmRefundFee != null && financialConfirmRefundFee != "" && financialConfirmRefundFee != "null" && financialConfirmRefundFee != undefined) {
			realAmount += parseFloat(financialConfirmRefundFee);
		}
	});
	$("#realAmount").val(realAmount);
	$("#realAmountText").html(realAmount);
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