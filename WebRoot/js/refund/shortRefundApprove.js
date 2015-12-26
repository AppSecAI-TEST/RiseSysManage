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