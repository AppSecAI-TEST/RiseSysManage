$(document).ready(function() {
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
                $("#refundWay").combobox('select', data[0].codeFlag);
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
	
	//上传
    $("#uploadBtn").click(function() {
    	var fileName = $("#fileName").filebox("getText");
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
    	$("#fileName").filebox({prompt: ""});
    });
    
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
	
	var refundImgUrl = $("#refundImgUrl").val();
	if(refundImgUrl != null && refundImgUrl != "" && refundImgUrl != undefined) {
		$("#imgUrl").css("display", "inline-block");
		$("#url").attr("href", refundImgUrl);
		$('#url').lightBox();
	} 
    
    //提交申请
    $("#refundApplySubmit").click(function() {
    	if(!checkParam()) {
    		return;
    	} else {
    		if($("#refundApplyFm").form('validate')) {
    			var flag = true;
    			if($("#fileName").length > 0) {
    				var fileName = $("#fileName").filebox("getText");
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
					refundFeeObj.studentId = obj.studentId;
					refundFeeObj.refundWay = obj.refundWay;
					refundFeeObj.refundRule = "";
					refundFeeObj.courseType = obj.courseType;
					refundFeeObj.isAcademic = "";
					refundFeeObj.amount = obj.totalAmount;
					refundFeeObj.realAmount = $("#confirmRefundFee").textbox("getValue");
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
					var refundFeeDetailObj = new Object();
					var studentCourseId = $("#studentCourseId").val();
					refundFeeDetailObj.studentCourseId = studentCourseId;
					refundFeeDetailObj.refundType = "";
					refundFeeDetailObj.refundChannel = "";
					refundFeeDetailObj.courseState = $("#courseState").val();
					refundFeeDetailObj.classInstId = $("#classInstId").val();
					refundFeeDetailObj.className = $("#className").val();
					refundFeeDetailObj.classType = obj.classType;
					refundFeeDetailObj.stageId = obj.stageId;
					refundFeeDetailObj.refundHours = obj.refundHours;
					refundFeeDetailObj.refundStageFee = $("#refundStageFee").val();
					var isRtnGift = "Y";
					var minusGiftFee = 0;
					if(minusGiftFee > 0) {
						isRtnGift = "N";
					}
					refundFeeDetailObj.minusGiftFee = minusGiftFee;
					refundFeeDetailObj.minusCourseFee = $("#minusCourseFee").textbox("getValue");
					var isRtnTextbook = "Y";
					var minusTextbookFee = parseFloat($("#minusTextbookFee").textbox("getValue"));
					if(minusTextbookFee > 0) {
						isRtnTextbook = "N";
					}
					refundFeeDetailObj.minusTextbookFee = minusTextbookFee;
					refundFeeDetailObj.minusOtherFee = $("#minusOtherFee").textbox("getValue");
					refundFeeDetailObj.handlingChange = $("#handlingChange").textbox("getValue");
					refundFeeDetailObj.confirmRefundFee = $("#confirmRefundFee").textbox("getValue");
					refundFeeDetailObj.financialConfirmFee = $("#confirmRefundFee").textbox("getValue");
					refundFeeDetailObj.isRtnTextbook = isRtnTextbook;
					refundFeeDetailObj.isRtnGift = isRtnGift;
					refundFeeDetailObj.handlerId = obj.handlerId;
					refundFeeDetailArray += JSON.stringify(refundFeeDetailObj) + "]";
					var param = "{\"refundFeeObj\":"+JSON.stringify(refundFeeObj)+",\"refundFeeDetailArray\":"+refundFeeDetailArray+"}";
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

function calculateRefundAmount() {
	var refundStageFee = parseFloat($("#refundStageFee").val());
	var minusTextbookFee = parseFloat($("#minusTextbookFee").textbox("getValue"));
	var total = parseFloat(minusTextbookFee);
	if(total >= refundStageFee) {
		$("#minusTextbookFee").textbox("setValue", 0);
	} else {
		var minusCourseFee = parseFloat($("#minusCourseFee").textbox("getValue"));
		total = parseFloat(minusTextbookFee + minusCourseFee);
		if(total >= refundStageFee) {
			$("#minusCourseFee").textbox("setValue", 0);
		} else {
			var handlingChange = parseFloat($("#handlingChange").textbox("getValue"));
			total = parseFloat(minusTextbookFee + minusCourseFee + handlingChange);
			if(total >= refundStageFee) {
				$("#handlingChange").textbox("setValue", 0);
			} else {
				var minusOtherFee = parseFloat($("#minusOtherFee").textbox("getValue"));
				total = parseFloat(minusTextbookFee + minusCourseFee + handlingChange + minusOtherFee);
				if(total >= refundStageFee) {
					$("#minusOtherFee").textbox("setValue", 0);
				} else {
					var totalAmount = refundStageFee - total;
					$("#totalAmount").val(totalAmount);
					$("#totalAmountText").html(totalAmount);
					$("#confirmRefundFee").textbox("setValue", totalAmount);
				}
			}
		}
	}
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
			$.messager.alert('提示', "请输入申请退费的其他原因！");
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