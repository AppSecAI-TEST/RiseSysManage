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
		$("input:radio[name='refundReason']").attr("disabled", "disabled");
		if("school" == refundReason) {
			$("#schoolReasonType").combobox({disabled: false});
			$("#schoolReason").combobox({disabled: false});
			$("#schoolReasonType").combobox({
				url : "/sys/pubData/qryCodeNameList.do?tableName=REFUND_FEE_T&codeType=SCHOOL_REASON_TYPE",//返回json数据的url
		    	valueField : "codeFlag",
		    	textField : "codeName",
		    	panelHeight : "auto",
		    	formatter : function(data) {
		    		return "<span>" + data.codeName + "</span>";
		    	},
		    	onLoadSuccess : function () { //数据加载完毕事件
		    		$("input:radio[name='refundReason']").removeAttr("disabled");
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
		    		    	}
		        		});
		        	}
		        }
			});
			$("#otherReason").textbox({disabled: true});
			$("#otherReason").textbox("setValue", "");
			$("#customerReason").combobox('clear');
			$("#customerReason").combobox("loadData", new Array());
			$("#customerReason").combobox({disabled: true});
		} else if("customer" == refundReason) {
			$("#customerReason").combobox({disabled: false});
			$("#customerReason").combobox({
				url : "/sys/pubData/qryCodeNameList.do?tableName=REFUND_FEE_T&codeType=CUSTOMER_REASON",//返回json数据的url
		    	valueField : "codeFlag",
		    	textField : "codeName",
		    	panelHeight : "auto",
		    	formatter : function(data) {
		    		return "<span>" + data.codeName + "</span>";
		    	},
		    	onLoadSuccess : function () { //数据加载完毕事件
		    		$("input:radio[name='refundReason']").removeAttr("disabled");
		        }
			});
			$("#otherReason").textbox({disabled: true});
			$("#otherReason").textbox("setValue", "");
			$("#schoolReason").combobox('clear');
			$("#schoolReason").combobox("loadData", new Array());
			$("#schoolReason").textbox({disabled: true});
			$("#schoolReasonType").combobox('clear');
			$("#schoolReasonType").combobox("loadData", new Array());
			$("#schoolReasonType").combobox({disabled: true});
		} else {
			$("#otherReason").textbox({disabled: false});
			$("#schoolReason").combobox('clear');
			$("#schoolReason").combobox("loadData", new Array());
			$("#schoolReason").textbox({disabled: true});
			$("#schoolReasonType").combobox('clear');
			$("#schoolReasonType").combobox("loadData", new Array());
			$("#schoolReasonType").textbox({disabled: true});
			$("#customerReason").combobox('clear');
			$("#customerReason").combobox("loadData", new Array());
			$("#customerReason").textbox({disabled: true});
			$("input:radio[name='refundReason']").removeAttr("disabled");
		}
	});
	
	$("input:radio[name='visitPersonOne']").change(function() {
		var visitPersonOne = $("input:radio[name='visitPersonOne']:checked").val();
		var schoolId = $("#schoolId").val();
		if("teacher" == visitPersonOne) {
			$("#teacherId").combobox({disabled: false});
			$("#teacherId").combobox({
				url : "/sys/pubData/qryStaffList.do?post=4,5,6,7,8&schoolId="+schoolId,//返回json数据的url
		    	valueField : "staffId",
		    	textField : "userName",
		    	formatter : function(data) {
		    		return "<span>" + data.userName + "</span>";
		    	}
			});
			$("#careAdviserId").combobox('clear');
			$("#careAdviserId").combobox("loadData", new Array());
			$("#careAdviserId").combobox({disabled: true});
		} else {
			$("#careAdviserId").combobox({disabled: false});
			$("#careAdviserId").combobox({
				url : "/sys/pubData/qryStaffList.do?post=16,17&schoolId="+schoolId,//返回json数据的url
		    	valueField : "staffId",
		    	textField : "userName",
		    	formatter : function(data) {
		    		return "<span>" + data.userName + "</span>";
		    	}
			});
			$("#teacherId").combobox('clear');
			$("#teacherId").combobox("loadData", new Array());
			$("#teacherId").combobox({disabled: true});
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
		if("academic" == visitPersonTwo) {
			$("#academicId").combobox({disabled: false});
			$("#academicId").combobox({
				url : "/sys/pubData/qryStaffList.do?post=7,8&schoolId=" + schoolId,//返回json数据的url
				valueField : "staffId",
				textField : "userName",
				formatter : function(data) {
					return "<span>" + data.userName + "</span>";
				}
			});
			$("#salesId").combobox('clear');
			$("#salesId").combobox("loadData", new Array());
			$("#salesId").combobox({disabled: true});
		} else {
			$("#salesId").combobox({disabled: false});
			$("#salesId").combobox({
				url : "/sys/pubData/qryStaffList.do?post=17&schoolId=" + schoolId,//返回json数据的url
				valueField : "staffId",
				textField : "userName",
				formatter : function(data) {
					return "<span>" + data.userName + "</span>";
				}
			});
			$("#academicId").combobox('clear');
			$("#academicId").combobox("loadData", new Array());
			$("#academicId").combobox({disabled: true});
		}
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
		
		$("#refundType" + studentCourseId).combobox({
			url : "/sys/pubData/qryCodeNameList.do?tableName=REFUND_FEE_DETAIL_T&codeType=REFUND_TYPE",//返回json数据的url
	    	valueField : "codeFlag",
	    	textField : "codeName",
	    	panelHeight : "auto",
	    	formatter : function(data) {
	    		return "<span>" + data.codeName + "</span>";
	    	},
	    	onChange : function(n, o) {
	    		if("RTN_NEW" == n || "RTN_READING" == n) {
	    			$("#refundChannel" + studentCourseId).combobox({
	    				url : "/sys/pubData/qryCodeNameList.do?tableName=REFUND_FEE_DETAIL_T&codeType=REFUND_CHANNEL",//返回json数据的url
	    				valueField : "codeFlag",
	    		    	textField : "codeName",
	    		    	panelHeight : "auto",
	    		    	formatter : function(data) {
	    		    		return "<span>" + data.codeName + "</span>";
	    		    	}
	    			});
	    		} else {
	    			$("#refundChannel" + studentCourseId).combobox('clear');
	    			$("#refundChannel" + studentCourseId).combobox("loadData", new Array());
	    		}
	    		if("RTN_NEW" == n) {
    				$("#belongSchoolId" + studentCourseId).combobox({
    					url: "/sys/pubData/qrySchoolList.do",
    					valueField : "schoolId",
    					textField : "schoolName",
    					formatter : function(data) {
    						return "<span>" + data.schoolName + "</span>";
    					}
    				});
    				$("#belongSchoolVal" + studentCourseId).css("display", "table-cell");
    				$("#belongSchoolText" + studentCourseId).css("display", "table-cell");
    			} else {
    				$("#belongSchoolVal" + studentCourseId).css("display", "none");
    				$("#belongSchoolText" + studentCourseId).css("display", "none");
    				$("#belongSchoolId" + studentCourseId).combobox('clear');
	    			$("#belongSchoolId" + studentCourseId).combobox("loadData", new Array());
    			}
	    	}
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
    	var fileName = $("#fileName").filebox("getText");
    	if(fileName != "" && fileName != null && fileName != undefined) {
			var index = fileName.lastIndexOf(".");
			var suffix = fileName.substring(index + 1);
			if("BMP" == suffix || "bmp" == suffix || "gif" == suffix || "GIF" == suffix
					|| "jpeg" == suffix || "JPEG" == suffix || "jpg" == suffix || "JPG" == suffix
					|| "png" == suffix || "PNG" == suffix) {
				var schoolId = $("#schoolId").val();
				var handlerId = $("#handlerId").val();
				$("#refundApplyFm").form("submit", {
					url: "/sys/fileUpload?type=refund&schoolId="+schoolId+"&handlerId="+handlerId,
					onSubmit: function () {
						$.messager.progress({title : '上传图片', msg : '正在上传退费申请单，请稍等……'});
					},
					success: function (result) {
						$.messager.progress('close');
						var data = JSON.parse(result);
						if(data.flag) {
							$("#imgUrl").val(data.fileId);
							$.messager.alert('提示', "退费申请单上传成功！", "info", function() {$("#cancelUploadBtn").linkbutton('disable');});
						} else {
							showMessage('提示', data.msg);
						}
					}
				});
			} else {
				showMessage('提示', "退费申请单请上传图片！");
			}
    	} else {
    		showMessage('提示', "请您先选择一个上传文件！");
    	}
    });
    
    //取消上传
    $("#cancelUploadBtn").click(function() {
    	$("#fileName").filebox({prompt: ""});
    });
	
	//提交申请
	$("#refundApplySubmit").click(function() {
		if($("[name='studentCourseId']").length > 0) {
			if($("#refundApplyFm").form('validate')) {
				if(!checkParam()) {
					return;
				} else {
					var flag = true;
					var imgUrl = $("#imgUrl").val();
					if(imgUrl == "" || imgUrl == null || imgUrl == undefined) {
						flag = false;
					}
					/* if($("#fileName").length > 0) {
						var fileName = $("#fileName").filebox("getText");
						if(fileName != "" && fileName != null && fileName != undefined) {
							var imgUrl = $("#imgUrl").val();
							if(imgUrl == "" || imgUrl == null || imgUrl == undefined) {
								flag = false;
							}
						}
					} */
					if(flag) {
						var obj = $("#refundApplyFm").serializeObject();
						var refundFeeObj = new Object();
						refundFeeObj.schoolId = obj.schoolId;
						refundFeeObj.className = $("#classNameText").html();
						refundFeeObj.classProgress = $("#classProgressText").html();
						refundFeeObj.teacherName = $("#teacherNameText").html();
						refundFeeObj.classInstId = $("#studyClassInstId").val();
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
						var remark = obj.remark;
						remark = string2Json(remark);
						refundFeeObj.remark = remark;
						refundFeeObj.handlerId = obj.handlerId;
						refundFeeObj.approveId = obj.handlerId;
						refundFeeObj.imgUrl = imgUrl;
						var belongSchoolId = "";
						var refundFeeDetailArray = "[";
						$("[name='studentCourseId']").each(function() {
							var studentCourseId = $(this).val();
							var refundFeeDetailObj = new Object();
							refundFeeDetailObj.studentCourseId = studentCourseId;
							var refundType = $("#refundType" + studentCourseId).combobox("getValue");
							if(refundType == "RTN_NEW") {
								belongSchoolId = $("#belongSchoolId" + studentCourseId).combobox("getValue");
							}
							refundFeeDetailObj.refundType = refundType;
							var refundChannel = "";
							var courseState = $("#courseState" + studentCourseId).val();
							if("001" == courseState || "002" == courseState) {
								refundChannel = $("#refundChannel" + studentCourseId).combobox("getValue");
							}
							refundFeeDetailObj.courseState = courseState;
							refundFeeDetailObj.refundChannel = refundChannel; 
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
							refundFeeDetailObj.financialConfirmFee = "";
							refundFeeDetailObj.isRtnTextbook = isRtnTextbook;
							refundFeeDetailObj.isRtnGift = isRtnGift;
							refundFeeDetailObj.handlerId = obj.handlerId;
							refundFeeDetailArray += JSON.stringify(refundFeeDetailObj) + ",";
						});
						refundFeeObj.belongSchoolId = belongSchoolId;
						if(refundFeeDetailArray.length > 1) {
							refundFeeDetailArray = refundFeeDetailArray.substring(0, refundFeeDetailArray.length - 1);
						}
						refundFeeDetailArray += "]";
						var refundVisitArray = "[";
						for(var i = 0; i < 2; i++) {
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
								var teacherOrAdviserVisitRemark = obj.teacherOrAdviserVisitRemark;
								teacherOrAdviserVisitRemark = string2Json(teacherOrAdviserVisitRemark);
								refundVisitObj.remark = teacherOrAdviserVisitRemark;
								refundVisitObj.handlerId = obj.handlerId;
							} else if(i == 1) {
								var visitPersonTwo = $("input:radio[name='visitPersonTwo']:checked").val();
								refundVisitObj.userType = visitPersonTwo;
								if("academic" == visitPersonTwo) {
									refundVisitObj.visitUserId = obj.academicId;
								} else {
									refundVisitObj.visitUserId = obj.salesId;
								}
								refundVisitObj.visitDate = obj.academicOrSalesVisitDate;
								var academicOrSalesVisitRemark = obj.academicOrSalesVisitRemark;
								academicOrSalesVisitRemark = string2Json(academicOrSalesVisitRemark);
								refundVisitObj.remark = academicOrSalesVisitRemark;
								refundVisitObj.handlerId = obj.handlerId;
							} /*else if(i == 2) {
								refundVisitObj.userType = "headmaster";
								refundVisitObj.visitUserId = obj.headmasterId;
								refundVisitObj.visitDate = obj.headmasterVisitDate;
								refundVisitObj.remark = obj.headmasterVisitRemark;
								refundVisitObj.handlerId = obj.handlerId;
							} */
							if(refundVisitObj.visitUserId != '' && refundVisitObj.visitUserId != null && refundVisitObj.visitUserId != undefined) {
								refundVisitArray += JSON.stringify(refundVisitObj) + ",";
							}
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
							beforeSend: function() {
								$.messager.progress({title : '申请退费', msg : '正在申请退费，请稍等……'});
							},
							success: function (data) {
								$.messager.progress('close');
								var flag = data.flag
								if(flag) {
									showMessage('提示', "申请退费成功！", function() {window.location.href = "/sys/refund/refund.jsp";});
								} else {
									showMessage('提示', data.msg);
								}
							} 
						});
					} else {
						showMessage('提示', "请您先上传退费申请单！");
					}
				}
			}
		} else {
			showMessage('提示', "请您先选择退费的课程！");
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
		showMessage('提示', "请选择退费形式！");
		return false;
	} else {
		if("BANK_CARD" == refundWay) {
			var bankName = $("#bankName").textbox("getValue");
			if(bankName == null || bankName == "" || bankName == undefined || bankName == "null") {
				showMessage('提示', "请输入退费银行！");
				return false;
			} else {
				var account = $("#account").textbox("getValue");
				if(account == null || account == "" || account == undefined || account == "null") {
					showMessage('提示', "请输入银行账户名！");
					return false;
				} else {
					var bankCard = $("#bankCard").textbox("getValue");
					if(account == null || account == "" || account == undefined || account == "null") {
						showMessage('提示', "请输入银行账号！");
						return false;
					}
				}
			}
		}
	}
	var refundRule = $("input:radio[name='refundRule']:checked").val();
	if(refundRule == null || refundRule == "" || refundRule == undefined || refundRule == "null") {
		showMessage('提示', "请选择退费规则！");
		return false;
	}
	var isAcademic = $("input:radio[name='isAcademic']:checked").val();
	if(isAcademic == null || isAcademic == "" || isAcademic == undefined || isAcademic == "null") {
		showMessage('提示', "请选择是否学术退费！");
		return false;
	}
	var refundReason = $("input:radio[name='refundReason']:checked").val();
	if(refundReason == null || refundReason == "" || refundReason == undefined || refundReason == "null") {
		showMessage('提示', "请选择退费原因！");
		return false;
	} else {
		if("school" == refundReason) {
			var schoolReasonType = $("#schoolReasonType").combobox('getValue');
			if(schoolReasonType == null || schoolReasonType == "" || schoolReasonType == undefined || schoolReasonType == "null") {
				showMessage('提示', "请选择申请退费的校方原因类型！");
				return false;
			} else {
				var schoolReason = $("#schoolReason").combobox('getValue');
				if(schoolReason == null || schoolReason == "" || schoolReason == undefined || schoolReason == "null") {
					showMessage('提示', "请选择申请退费的校方原因！");
					return false;
				}
			}
		} else if("customer" == refundReason) {
			var customerReason = $("#customerReason").combobox('getValue');
			if(customerReason == null || customerReason == "" || customerReason == undefined || customerReason == "null") {
				showMessage('提示', "请选择申请退费的客户原因！");
				return false;
			}
		} else {
			var otherReason = $("#otherReason").textbox("getValue");
			if(otherReason == null || otherReason == "" || otherReason == undefined || otherReason == "null") {
				showMessage('提示', "请输入申请退费的其他原因！");
				return false;
			}
		}
	}
	var num = 0;
	var index = 0;
	var indexs = 0;
	var flag = true;
	var flags = true;
	var array = document.getElementsByName("studentCourseId");
	if(array.length > 0) {
		for(var i = 0, len = array.length; i < len; i++) {
			var studentCourseId = array[i].value;
			var courseState = $("#courseState" + studentCourseId).val();
			var refundType = $("#refundType" + studentCourseId).combobox("getValue");
			if("001" == courseState || "002" == courseState) {
				if(refundType == "RTN_NEW" || "RTN_READING" == refundType) {
					var refundChannel = $("#refundChannel" + studentCourseId).combobox("getValue");
					if(refundChannel == null || refundChannel == "" || refundChannel == undefined) {
						flag = false;
						index = i + 1;
						break;
					}
				}
			}
			if(refundType == "RTN_NEW") {
				num++;
				if(flags) {
					var belongSchoolId = $("#belongSchoolId" + studentCourseId).combobox("getValue");
					if(belongSchoolId == null || belongSchoolId == "" || belongSchoolId == undefined) {
						flags = false;
						indexs = i + 1;
					}
				}
			}
		}
	}
	if(flag) {
		if(num <= 1) {
			if(flags) {
				var visitPersonOne = $("input:radio[name='visitPersonOne']:checked").val();
				if(visitPersonOne == null || visitPersonOne == "" || visitPersonOne == undefined || visitPersonOne == "null") {
					showMessage('提示', "请选择老师或CC回访的回访人员类型！");
					return false;
				} else {
					if("teacher" == visitPersonOne) {
						var teacherId = $("#teacherId").combobox('getValue');
						if(teacherId == null || teacherId == "" || teacherId == undefined || teacherId == "null") {
							showMessage('提示', "请选择老师的回访人员！");
							return false;
						}
					} else {
						var careAdviserId = $("#careAdviserId").combobox('getValue');
						if(careAdviserId == null || careAdviserId == "" || careAdviserId == undefined || careAdviserId == "null") {
							showMessage('提示', "请选择课程顾问的回访人员！");
							return false;
						}
					}
					/*var visitPersonTwo = $("input:radio[name='visitPersonTwo']:checked").val();
					if(visitPersonTwo == null || visitPersonTwo == "" || visitPersonTwo == undefined || visitPersonTwo == "null") {
						showMessage('提示', "请选择学术或销售主管的回访人员类型！");
						return false;
					} else {
						if("sales" == visitPersonTwo) {
							var salesId = $("#salesId").combobox('getValue');
							if(salesId == null || salesId == "" || salesId == undefined || salesId == "null") {
								showMessage('提示', "请选择销售主管的回访人员！");
								return false;
							}
						} else {
							var academicId = $("#academicId").combobox('getValue');
							if(academicId == null || academicId == "" || academicId == undefined || academicId == "null") {
								showMessage('提示', "请选择销售主管的回访人员！");
								return false;
							}
						}
					}*/
				}
			} else {
				showMessage('提示', "请选择课程" + indexs + "的归属校区！");
				return false;
			}
		} else {
			showMessage('提示', "一个学员最多只能有一个退新招的退费类型！");
			return false;
		}
	} else {
		showMessage('提示', "请选择课程" + index + "的渠道来源！");
		return false;
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
