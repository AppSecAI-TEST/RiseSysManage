var giftDivHeight = 0;
$(document).ready(function() {
	var totalAmount = 0;
	$("[name='confirmRefundFee']").each(function() {
		totalAmount += parseFloat($(this).html());
	});
	$("#totalAmount").val(totalAmount);
	$("#totalAmountText").html(totalAmount);
	$("#refundWay").combobox({
		url : "/sys/pubData/qryCodeNameList.do?tableName=REFUND_FEE_T&codeType=REFUND_WAY",//返回json数据的url
    	valueField : "codeFlag",
    	textField : "codeName",
    	panelHeight : "auto",
    	formatter : function(data) {
    		return "<span>" + data.codeName + "</span>";
    	},
    	onLoadSuccess : function () { //数据加载完毕事件
            var data = $('#refundWay').combobox('getData');
            if (data.length > 0) {
            	var optionType = $("#optionType").val();
            	if("applyAgain" == optionType) {
            		var oldRefundWay = $("#oldRefundWay").val();
            		$("#refundWay").combobox('select', oldRefundWay);
            	} else {
            		$("#refundWay").combobox('select', data[0].codeFlag);
            	}
            }
        },
		onChange : function(n, o) {
			if("CASH" == n) {
				$("#refundWayTr").find("td").each(function(i) {
					if(i == 1) {
						$(this).attr("colspan", 7);
					} else if(i > 1 && i < 8) {
						$(this).css("display", "none");
					}
		    	});
				var optionType = $("#optionType").val();
            	if("applyAgain" == optionType) {
            		$("#bankName").textbox("setValue", "");
            		$("#account").textbox("setValue", "");
            		$("#bankCard").textbox("setValue", "");
            	}
			} else if("BANK_CARD" == n) {
				$("#refundWayTr").find("td").each(function(i) {
					if(i == 1) {
						$(this).attr("colspan", 1);
					} else if(i > 1 && i < 8) {
						$(this).css("display", "table-cell");
					}
		    	});
			}
		}
	});
	
	$("input:radio[name='refundReason']").change(function() {
		var refundReason = $("input:radio[name='refundReason']:checked").val();
		if("school" == refundReason) {
			$("#schoolReasonType").combobox({
				url : "/sys/pubData/qryCodeNameList.do?tableName=REFUND_FEE_T&codeType=SCHOOL_REASON_TYPE",//返回json数据的url
		    	valueField : "codeFlag",
		    	textField : "codeName",
		    	panelHeight : "auto",
		    	formatter : function(data) {
		    		return "<span>" + data.codeName + "</span>";
		    	},
		    	onLoadSuccess : function () { //数据加载完毕事件
		            var data = $('#schoolReasonType').combobox('getData');
		            if (data.length > 0) {
		                $("#schoolReasonType").combobox('select', data[0].codeFlag);
		            }
		        },
		        onChange : function(n, o) {
		        	if(n != "" && n != null && n != undefined) {
		        		$("#schoolReason").combobox({
		        			url : "/sys/pubData/qryParaConfigList.do?paramType=SCHOOL_REASON&paramValue=" + n,//返回json数据的url
		        			valueField : "param1",
		        			textField : "param2",
		        			panelHeight : "auto",
		        			formatter : function(data) {
		    		    		return "<span>" + data.param2 + "</span>";
		    		    	},
		        			onLoadSuccess : function () { //数据加载完毕事件
		        				var data = $('#schoolReason').combobox('getData');
		        				if (data.length > 0) {
		        					$("#schoolReason").combobox('select', data[0].param1);
		        				}
		        			}
		        		});
		        	}
		        }
			});
			$("#otherReason").textbox("setValue", "");
			$("#customerReason").combobox('clear');
			$("#customerReason").combobox("loadData", new Array());
		} else if("customer" == refundReason) {
			$("#customerReason").combobox({
				url : "/sys/pubData/qryCodeNameList.do?tableName=REFUND_FEE_T&codeType=CUSTOMER_REASON",//返回json数据的url
		    	valueField : "codeFlag",
		    	textField : "codeName",
		    	panelHeight : "auto",
		    	formatter : function(data) {
		    		return "<span>" + data.codeName + "</span>";
		    	},
		    	onLoadSuccess : function () { //数据加载完毕事件
		            var data = $('#customerReason').combobox('getData');
		            if (data.length > 0) {
		                $("#customerReason").combobox('select', data[0].codeFlag);
		            }
		        }
			});
			$("#otherReason").textbox("setValue", "");
			$("#schoolReason").combobox('clear');
			$("#schoolReason").combobox("loadData", new Array());
			$("#schoolReasonType").combobox('clear');
			$("#schoolReasonType").combobox("loadData", new Array());
		} else {
			$("#schoolReason").combobox('clear');
			$("#schoolReason").combobox("loadData", new Array());
			$("#schoolReasonType").combobox('clear');
			$("#schoolReasonType").combobox("loadData", new Array());
			$("#customerReason").combobox('clear');
			$("#customerReason").combobox("loadData", new Array());
		}
	});
	
	$("input:radio[name='visitPersonOne']").change(function() {
		var visitPersonOne = $("input:radio[name='visitPersonOne']:checked").val();
		var schoolId = $("#schoolId").val();
		if("teacher" == visitPersonOne) {
			$("#teacherId").combobox({
				url : "/sys/pubData/qryStaffList.do?post=4,5&schoolId="+schoolId,//返回json数据的url
		    	valueField : "staffId",
		    	textField : "userName",
		    	panelHeight : "auto",
		    	formatter : function(data) {
		    		return "<span>" + data.userName + "</span>";
		    	},
		    	onLoadSuccess : function () { //数据加载完毕事件
		            var data = $('#teacherId').combobox('getData');
		            if (data.length > 0) {
		                $("#teacherId").combobox('select', data[0].staffId);
		            }
		        }
			});
			$("#careAdviserId").combobox('clear');
			$("#careAdviserId").combobox("loadData", new Array());
		} else {
			$("#careAdviserId").combobox({
				url : "/sys/pubData/qryStaffList.do?post=16,17&schoolId="+schoolId,//返回json数据的url
		    	valueField : "staffId",
		    	textField : "userName",
		    	panelHeight : "auto",
		    	formatter : function(data) {
		    		return "<span>" + data.userName + "</span>";
		    	},
		    	onLoadSuccess : function () { //数据加载完毕事件
		            var data = $('#careAdviserId').combobox('getData');
		            if (data.length > 0) {
		                $("#careAdviserId").combobox('select', data[0].staffId);
		            }
		        }
			});
			$("#teacherId").combobox('clear');
			$("#teacherId").combobox("loadData", new Array());
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
	
	$("input:radio[name='visitPersonTwo']").change(function() {
		var visitPersonTwo = $("input:radio[name='visitPersonTwo']:checked").val();
		var schoolId = $("#schoolId").val();
		$("#academicOrSalesId").combobox({
			url : "/sys/pubData/qryStaffList.do?post=7,8,17&schoolId="+schoolId,//返回json数据的url
	    	valueField : "staffId",
	    	textField : "userName",
	    	panelHeight : "auto",
	    	formatter : function(data) {
	    		return "<span>" + data.userName + "</span>";
	    	},
	    	onLoadSuccess : function () { //数据加载完毕事件
	            var data = $('#academicOrSalesId').combobox('getData');
	            if (data.length > 0) {
	                $("#academicOrSalesId").combobox('select', data[0].staffId);
	            }
	        }
		});
	});

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
	
	var refundImgUrl = $("#refundImg").attr("href");
	if(refundImgUrl != null && refundImgUrl != "" && refundImgUrl != undefined) {
		$('#refundImg').lightBox();
	}
	
	var courseImgUrl = $("#courseImgUrl").attr("href");
	if(courseImgUrl != null && courseImgUrl != "" && courseImgUrl != undefined) {
		$('#courseImgUrl').lightBox();
	}
	
	//上传
    $("#uploadBtn").click(function() {
    	var fileName = $("#fileName").filebox("getValue");
    	if(fileName != "" && fileName != null && fileName != undefined) {
    		var schoolId = $("#schoolId").val();
    		var handlerId = $("#handlerId").val();
    		$("#refundApplyFm").form("submit", {
    			url: "/sys/fileUpload?type=refund&schoolId="+schoolId+"&handlerId="+handlerId,
    			onSubmit: function () {
    				
    			},
    			success: function (result) {
    				var data = JSON.parse(result);
    				if(data.flag)
    				{
    					$("#imgUrl").val(data.fileId);
    					$.messager.alert('提示', "文件上传成功！", "info", function() {$("#cancelUploadBtn").linkbutton('disable');});
    				}
    				else
    				{
    					$.messager.alert('提示', data.msg);
    				}
    			}
    		});
    	} else {
    		$.messager.alert('提示', "请您先选择一个文件！");
    	}
    });
    
    //取消上传
    $("#cancelUploadBtn").click(function() {
    	var fileName = $("#fileName").filebox("setValue", "");
    });
	
	//提交申请
	$("#refundApplySubmit").click(function() {
		if(!checkParam()) {
			return;
		} else {
			if($("#refundApplyFm").form('validate')) {
				var flag = true;
				if($("#fileName").length > 0) {
					var fileName = $("#fileName").filebox("getValue");
					if(fileName != "" && fileName != null && fileName != undefined) {
						var imgUrl = $("#imgUrl").val();
						if(imgUrl == "" || imgUrl == null || imgUrl == undefined) {
							flag = false;
						}
					}
				}
				if(flag) {
					var obj = $("#refundApplyFm").serializeObject();
					var refundFeeObj = new Object();
					refundFeeObj.schoolId = obj.schoolId;
					refundFeeObj.className = $("#className").val();
					refundFeeObj.classInstId = $("#classInstId").val();
					refundFeeObj.studentId = obj.studentId;
					refundFeeObj.refundWay = obj.refundWay;
					refundFeeObj.refundRule = obj.refundRule;
					refundFeeObj.courseType = obj.courseType;
					refundFeeObj.isAcademic = obj.isAcademic;
					refundFeeObj.amount = obj.totalAmount;
					refundFeeObj.realAmount = obj.realAmount;
					refundFeeObj.schoolReasonType = obj.schoolReasonType;
					refundFeeObj.schoolReason = obj.schoolReason;
					refundFeeObj.customerReason = obj.customerReason;
					refundFeeObj.otherReason = obj.otherReason;
					refundFeeObj.bankName = obj.bankName;
					refundFeeObj.account = obj.account;
					refundFeeObj.bankCard = obj.bankCard;
					refundFeeObj.remark = obj.remark;
					refundFeeObj.handlerId = obj.handlerId;
					refundFeeObj.approveId = obj.handlerId;
					var refundFeeDetailArray = "[";
					$("[name='studentCourseId']").each(function() {
						var studentCourseId = $(this).val();
						var refundFeeDetailObj = new Object();
						refundFeeDetailObj.studentCourseId = studentCourseId;
						refundFeeDetailObj.refundType = $("#refundType" + studentCourseId).combobox("getValue");
						refundFeeDetailObj.refundChannel = $("#refundChannel" + studentCourseId).combobox("getValue");
						refundFeeDetailObj.courseState = $("#courseState" + studentCourseId).val();
						refundFeeDetailObj.classInstId = $("#classInstId" + studentCourseId).val();
						refundFeeDetailObj.className = $("#className" + studentCourseId).val();
						refundFeeDetailObj.classType = $("#classType" + studentCourseId).val();
						refundFeeDetailObj.stageId = $("#stageId" + studentCourseId).val();
						refundFeeDetailObj.refundHours = $("#refundHours" + studentCourseId).val();
						refundFeeDetailObj.refundStageFee = $("#refundStageFee" + studentCourseId).html();
						var isRtnGift = "Y";
						var minusGiftFee = parseFloat($("#minusGiftFee" + studentCourseId).textbox("getValue"));
						if(minusGiftFee > 0) {
							isRtnGift = "N";
						}
						refundFeeDetailObj.minusGiftFee = minusGiftFee;
						refundFeeDetailObj.minusCourseFee = $("#minusCourseFee" + studentCourseId).textbox("getValue");
						var isRtnTextbook = "Y";
						var minusTextbookFee = parseFloat($("#minusTextbookFee" + studentCourseId).textbox("getValue"));
						if(minusTextbookFee > 0) {
							isRtnTextbook = "N";
						}
						refundFeeDetailObj.minusTextbookFee = minusTextbookFee;
						refundFeeDetailObj.minusOtherFee = $("#minusOtherFee" + studentCourseId).textbox("getValue");
						refundFeeDetailObj.handlingChange = $("#handlingChange" + studentCourseId).textbox("getValue");
						refundFeeDetailObj.confirmRefundFee = $("#confirmRefundFee" + studentCourseId).html();
						refundFeeDetailObj.financialConfirmFee = $("#financialConfirmRefundFee" + studentCourseId).textbox("getValue");
						refundFeeDetailObj.isRtnTextbook = isRtnTextbook;
						refundFeeDetailObj.isRtnGift = isRtnGift;
						refundFeeDetailObj.handlerId = obj.handlerId;
						refundFeeDetailArray += JSON.stringify(refundFeeDetailObj) + ",";
					});
					if(refundFeeDetailArray.length > 1) {
						refundFeeDetailArray = refundFeeDetailArray.substring(0, refundFeeDetailArray.length - 1);
					}
					refundFeeDetailArray += "]";
					var refundVisitArray = "[";
					for(var i = 0; i < 3; i++) {
						var refundVisitObj = new Object();
						refundVisitObj.visitType = "00" + (i + 1);
						if(i == 0) {
							var visitPersonOne = $("input:radio[name='visitPersonOne']:checked").val();
							refundVisitObj.userType = visitPersonOne;
							if("teacher" == visitPersonOne) {
								refundVisitObj.visitUserId = obj.teacherId;
							} else {
								refundVisitObj.visitUserId = obj.careAdviserId;
							}
							refundVisitObj.visitDate = obj.teacherOrAdviserVisitDate;
							refundVisitObj.remark = obj.teacherOrAdviserVisitRemark;
							refundVisitObj.handlerId = obj.handlerId;
						} else if(i == 1) {
							var visitPersonTwo = $("input:radio[name='visitPersonTwo']:checked").val();
							refundVisitObj.userType = visitPersonTwo;
							refundVisitObj.visitUserId = obj.academicOrSalesId;
							refundVisitObj.visitDate = obj.academicOrSalesVisitDate;
							refundVisitObj.remark = obj.academicOrSalesVisitRemark;
							refundVisitObj.handlerId = obj.handlerId;
						} else if(i == 2) {
							refundVisitObj.userType = "headmaster";
							refundVisitObj.visitUserId = obj.headmasterId;
							refundVisitObj.visitDate = obj.headmasterVisitDate;
							refundVisitObj.remark = obj.headmasterVisitRemark;
							refundVisitObj.handlerId = obj.handlerId;
						}
						refundVisitArray += JSON.stringify(refundVisitObj) + ",";
					}
					if(refundVisitArray.length > 1) {
						refundVisitArray = refundVisitArray.substring(0, refundVisitArray.length - 1);
					}
					refundVisitArray += "]";
					var param = "{\"refundFeeObj\":"+JSON.stringify(refundFeeObj)+",\"refundFeeDetailArray\":"+refundFeeDetailArray+",\"refundVisitArray\":"+refundVisitArray+"}";
					param = encodeURI(param);
					$.ajax({
						url: "/sys/refund/applyRefund.do",
						data: "param=" + param,
						dataType: "json",
						async: true,
						beforeSend: function()
						{
							$.messager.progress({title : '申请退费', msg : '正在申请退费，请稍等……'});
						},
						success: function (data) {
							$.messager.progress('close'); 
							var flag = data.flag
							if(flag) {
								$.messager.alert('提示', "申请退费成功！", "info", function() {window.location.href = "/sys/refund/refund.jsp";});
							} else {
								$.messager.alert('提示', data.msg);
							}
						} 
					});
				} else {
					$.messager.alert('提示', "请您先上传文件！");
				}
			}
		}
	});
});

function calculateRefundAmount(studentCourseId) {
	var refundStageFee = parseFloat($("#refundStageFee" + studentCourseId).html());
	var minusGiftFee = parseFloat($("#minusGiftFee" + studentCourseId).textbox("getValue"));
	var total = 0;
	if(minusGiftFee >= refundStageFee) {
		$("#minusGiftFee" + studentCourseId).textbox("setValue", 0);
	} else {
		var minusTextbookFee = parseFloat($("#minusTextbookFee" + studentCourseId).textbox("getValue"));
		total = parseFloat(minusGiftFee + minusTextbookFee);
		if(total >= refundStageFee) {
			$("#minusTextbookFee" + studentCourseId).textbox("setValue", 0);
		} else {
			var minusCourseFee = parseFloat($("#minusCourseFee" + studentCourseId).textbox("getValue"));
			total = parseFloat(minusGiftFee + minusTextbookFee + minusCourseFee);
			if(total >= refundStageFee) {
				$("#minusCourseFee" + studentCourseId).textbox("setValue", 0);
			} else {
				var handlingChange = parseFloat($("#handlingChange" + studentCourseId).textbox("getValue"));
				total = parseFloat(minusGiftFee + minusTextbookFee + minusCourseFee + handlingChange);
				if(total >= refundStageFee) {
					$("#handlingChange" + studentCourseId).textbox("setValue", 0);
				} else {
					var minusOtherFee = parseFloat($("#minusOtherFee" + studentCourseId).textbox("getValue"));
					total = parseFloat(minusGiftFee + minusTextbookFee + minusCourseFee + handlingChange + minusOtherFee);
					if(total >= refundStageFee) {
						$("#minusOtherFee" + studentCourseId).textbox("setValue", 0);
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
		var financialConfirmRefundFee = $("#financialConfirmRefundFee" + studentCourseId).textbox("getValue");
		if(financialConfirmRefundFee != null && financialConfirmRefundFee != "" && financialConfirmRefundFee != "null" && financialConfirmRefundFee != undefined) {
			realAmount += parseFloat(financialConfirmRefundFee);
		}
	});
	$("#realAmount").val(realAmount);
	$("#realAmountText").html(realAmount);
}

function checkParam() {
	var refundWay = $("#refundWay").combobox('getValue');
	if(refundWay == null || refundWay == "" || refundWay == undefined || refundWay == "null") {
		$.messager.alert('提示', "请选择退费形式！");
		return false;
	} else {
		if("BANK_CARD" == refundWay) {
			var bankName = $("#bankName").textbox("getValue");
			if(bankName == null || bankName == "" || bankName == undefined || bankName == "null") {
				$.messager.alert('提示', "请输入退费银行！");
				return false;
			} else {
				var account = $("#account").textbox("getValue");
				if(account == null || account == "" || account == undefined || account == "null") {
					$.messager.alert('提示', "请输入银行账户名！");
					return false;
				} else {
					var bankCard = $("#bankCard").textbox("getValue");
					if(account == null || account == "" || account == undefined || account == "null") {
						$.messager.alert('提示', "请输入银行账号！");
						return false;
					}
				}
			}
		}
	}
	var refundRule = $("input:radio[name='refundRule']:checked").val();
	if(refundRule == null || refundRule == "" || refundRule == undefined || refundRule == "null") {
		$.messager.alert('提示', "请选择退费规则！");
		return false;
	}
	var isAcademic = $("input:radio[name='isAcademic']:checked").val();
	if(isAcademic == null || isAcademic == "" || isAcademic == undefined || isAcademic == "null") {
		$.messager.alert('提示', "请选择是否学术退费！");
		return false;
	}
	var refundReason = $("input:radio[name='refundReason']:checked").val();
	if(refundReason == null || refundReason == "" || refundReason == undefined || refundReason == "null") {
		$.messager.alert('提示', "请选择退费原因！");
		return false;
	} else {
		if("school" == refundReason) {
			var schoolReasonType = $("#schoolReasonType").combobox('getValue');
			if(schoolReasonType == null || schoolReasonType == "" || schoolReasonType == undefined || schoolReasonType == "null") {
				$.messager.alert('提示', "请选择申请退费的校方原因类型！");
				return false;
			} else {
				var schoolReason = $("#schoolReason").combobox('getValue');
				if(schoolReason == null || schoolReason == "" || schoolReason == undefined || schoolReason == "null") {
					$.messager.alert('提示', "请选择申请退费的校方原因！");
					return false;
				}
			}
		} else if("customer" == refundReason) {
			var customerReason = $("#customerReason").combobox('getValue');
			if(customerReason == null || customerReason == "" || customerReason == undefined || customerReason == "null") {
				$.messager.alert('提示', "请选择申请退费的客户原因！");
				return false;
			}
		} else {
			var otherReason = $("#otherReason").textbox("getValue");
			if(otherReason == null || otherReason == "" || otherReason == undefined || otherReason == "null") {
				$.messager.alert('提示', "请输入申请退费的其他原因！");
				return false;
			}
		}
	}
	var visitPersonOne = $("input:radio[name='visitPersonOne']:checked").val();
	if(visitPersonOne == null || visitPersonOne == "" || visitPersonOne == undefined || visitPersonOne == "null") {
		$.messager.alert('提示', "请选择老师或CC回访的回访人员类型！");
		return false;
	} else {
		if("teacher" == visitPersonOne) {
			var teacherId = $("#teacherId").combobox('getValue');
			if(teacherId == null || teacherId == "" || teacherId == undefined || teacherId == "null") {
				$.messager.alert('提示', "请选择老师的回访人员！");
				return false;
			}
		} else {
			var careAdviserId = $("#careAdviserId").combobox('getValue');
			if(careAdviserId == null || careAdviserId == "" || careAdviserId == undefined || careAdviserId == "null") {
				$.messager.alert('提示', "请选择课程顾问的回访人员！");
				return false;
			}
		}
	}
	var visitPersonTwo = $("input:radio[name='visitPersonTwo']:checked").val();
	if(visitPersonTwo == null || visitPersonTwo == "" || visitPersonTwo == undefined || visitPersonTwo == "null") {
		$.messager.alert('提示', "请选择学术或销售主管的回访人员类型！");
		return false;
	} else {
		var visitPersonType = "学术主管";
		if("sales" == visitPersonTwo) {
			visitPersonType = "销售主管";
		}
		var academicOrSalesId = $("#academicOrSalesId").combobox('getValue');
		if(academicOrSalesId == null || academicOrSalesId == "" || academicOrSalesId == undefined || academicOrSalesId == "null") {
			$.messager.alert('提示', "请选择"+visitPersonType+"的回访人员！");
			return false;
		}
	}
	return true;
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

function viewCourseDetail(studentCourseId) {
	var courseDetailDivDisplay = $("#courseDetail" + studentCourseId).css("display");
	if("none" == courseDetailDivDisplay) {
		$("#goods_list_data" + studentCourseId).datagrid({ 
			url:"/sys/pubData/qryDataListByPage.do?param={funcNodeId:'1074',studentCourseId:'"+studentCourseId+"'}",
			onLoadSuccess: function() { 
				var rows = $("#goods_list_data" + studentCourseId).datagrid('getRows');
				if(parseInt(rows.length) <= 0) {
					$("#goodsDiv" + studentCourseId).css("display", "none");
				}
			}
		});
		$("#coupon_list_data" + studentCourseId).datagrid({ 
			url:"/sys/pubData/qryDataListByPage.do?param={funcNodeId:'1075',studentCourseId:'"+studentCourseId+"'}",
			onLoadSuccess: function() { 
				var rows = $("#coupon_list_data" + studentCourseId).datagrid('getRows');
				if(parseInt(rows.length) <= 0) {
					$("#couponDiv" + studentCourseId).css("display", "none");
				}
			}
		});
		$("#course_list_data" + studentCourseId).datagrid({ 
			url:"/sys/pubData/qryDataListByPage.do?param={funcNodeId:'1076',studentCourseId:'"+studentCourseId+"'}",
			onLoadSuccess: function() { 
				var rows = $("#course_list_data" + studentCourseId).datagrid('getRows');
				if(parseInt(rows.length) <= 0) {
					$("#courseDiv" + studentCourseId).css("display", "none");
				}
			}
		});
		$("#courseDetail" + studentCourseId).css("display", "block");
		$("#studentCourseDetail" + studentCourseId).html("<span>收缩课程</span>");
	} else {
		$("#courseDetail" + studentCourseId).css("display", "none");
		$("#studentCourseDetail" + studentCourseId).html("<span>展开课程</span>");
	}
}