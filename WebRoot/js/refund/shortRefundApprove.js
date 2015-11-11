$(document).ready(function() {
	$("input", $("#minusTextbookFee").next("span")).blur(function() {
		calculateRefundAmount(studentCourseId);
	});
	
	$("input", $("#minusCourseFee").next("span")).blur(function() {
		calculateRefundAmount(studentCourseId);
	});
	
	$("input", $("#handlingChange").next("span")).blur(function() {
		calculateRefundAmount(studentCourseId);
	});
	
	$("input", $("#minusOtherFee").next("span")).blur(function() {
		calculateRefundAmount(studentCourseId);
	});
});

function calculateRefundAmount(studentCourseId) {
	var refundStageFee = parseFloat($("#refundStageFee").val());
	var minusGiftFee = parseFloat($("#minusGiftFee").numberbox("getValue"));
	var total = 0;
	if(minusGiftFee >= refundStageFee) {
		$("#minusGiftFee").numberbox("setValue", 0);
	} else {
		var minusTextbookFee = parseFloat($("#minusTextbookFee").numberbox("getValue"));
		total = parseFloat(minusGiftFee + minusTextbookFee);
		if(total >= refundStageFee) {
			$("#minusTextbookFee").numberbox("setValue", 0);
		} else {
			var minusCourseFee = parseFloat($("#minusCourseFee").numberbox("getValue"));
			total = parseFloat(minusGiftFee + minusTextbookFee + minusCourseFee);
			if(total >= refundStageFee) {
				$("#minusCourseFee" + studentCourseId).numberbox("setValue", 0);
			} else {
				var handlingChange = parseFloat($("#handlingChange").numberbox("getValue"));
				total = parseFloat(minusGiftFee + minusTextbookFee + minusCourseFee + handlingChange);
				if(total >= refundStageFee) {
					$("#handlingChange").numberbox("setValue", 0);
				} else {
					var minusOtherFee = parseFloat($("#minusOtherFee").numberbox("getValue"));
					total = parseFloat(minusGiftFee + minusTextbookFee + minusCourseFee + handlingChange + minusOtherFee);
					if(total >= refundStageFee) {
						$("#minusOtherFee").numberbox("setValue", 0);
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