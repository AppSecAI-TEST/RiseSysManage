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
	});
	
	//根据不同的审批人员显示不同的审批信息
	$("#headmasterApproveDiv").css("display", "block");
	
	//提交审批
	$("#refundApproveSubmit").click(function() {
		var approveType = $('input:radio[name="approveType"]:checked').val();
		if(approveType == "" || approveType == null || approveType == undefined || approveType == "null") {
			$.messager.alert('提示', "请选择是否审批通过！");
		} else {
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