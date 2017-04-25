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
		$("#refundFeeImgUrl" + studentCourseId).lightBox();
	});
	
	//关闭按钮
	$("#closeBtn").click(function() {
		var title = "退费管理";
		parent.closeUrl(title);
	});
	
	//提交审批
	$("#refundApproveSubmit").click(function() {
		var flag = true;
		var belongDate = "";
		var masterType = "";
		var isTransfer = "N";
		var nextState = $("#nextState").val();
		if("108" == nextState) {
			var transfer = $("input:checkbox[name='isTransfer']:checked").val();
			if(transfer == null || transfer == "" || transfer == undefined) {
				showMessage('提示', "请选择是否已打款！");
				flag = false;
			} else {
				if(transfer) {
					isTransfer = "Y";
				}
				belongDate = $("#belongDate").datebox("getValue");
				if(belongDate == null || belongDate == "" || belongDate == undefined) {
					showMessage('提示', "请选择退费归属日期！");
					flag = false;
				} /*else {
					var curr_time = new Date();
					var curr_year = curr_time.getFullYear();
					var curr_month = curr_time.getMonth() + 1;
					var date = new Date(belongDate.replace(/-/g,"/"));
					var year = date.getFullYear();
					var month = date.getMonth() + 1;
					if(parseInt(curr_year) != parseInt(year) 
							|| parseInt(month) < (parseInt(curr_month) - 1) 
							|| parseInt(month) > (parseInt(curr_month) + 1)) {
						flag = false;
						showMessage('提示', "退费归属日期只能选择上月、当月、下月的日期！");
					}
				}*/
			}
		} else {
			if("102" == nextState) {
				var array = document.getElementsByName("studentCourseId");
				for(var i = 0, len = array.length; i < len; i++) {
					var studentCourseId = array[i].value;
					var financialConfirmRefundFee = $("#financialConfirmRefundFee" + studentCourseId).textbox("getValue");
					if(financialConfirmRefundFee == "" || financialConfirmRefundFee == null || financialConfirmRefundFee == undefined) {
						flag = false;
						var stageId = $("#stageId" + studentCourseId).html();
						showMessage('提示', "请输入" + stageId + "课程的总部财务核定金额！");
						break;
					}
				}
			}
			if(flag) {
				var approveType = $('input:radio[name="approveType"]:checked').val();
				if(approveType == "" || approveType == null || approveType == undefined || approveType == "null") {
					showMessage('提示', "请选择是否审批通过！");
					flag = false;
				}/** else {
					if("Y" == approveType) {
						if("104" == nextState || "105" == nextState) {
							
							masterType = $("#masterType").combobox("getValue");
							if(masterType == null || masterType == "" || masterType == undefined) {
								showMessage('提示', "请选择后续审批人类型！");
								flag = false;
							}
						}
					} else {
						$("#masterType").combobox('clear');
						$("#masterType").combobox("loadData", new Array());
					}
				}*/
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
			approveRemark = string2Json(approveRemark);
			approveObj.remark = approveRemark;
			var refundFeeObj = new Object();
			var refundFeeDetailArray = "[";
			if("102" == nextState) {
				var refundFeeId = $("#refundFeeId").val();
				refundFeeObj.refundFeeId = refundFeeId;
				var realAmount = $("#realAmount").val();
				refundFeeObj.realAmount = realAmount;
				$("[name='studentCourseId']").each(function() {
					var studentCourseId = $(this).val();
					var refundFeeDetailObj = new Object();
					var refundFeeDetailId = $("#refundFeeDetailId" + studentCourseId).val();
					refundFeeDetailObj.refundFeeDetailId = refundFeeDetailId;
					var financialConfirmRefundFee = $("#financialConfirmRefundFee" + studentCourseId).val();
					refundFeeDetailObj.financialConfirmRefundFee = financialConfirmRefundFee;
					refundFeeDetailArray += JSON.stringify(refundFeeDetailObj) + ",";
				});
				if(refundFeeDetailArray.length > 1) {
					refundFeeDetailArray = refundFeeDetailArray.substring(0, refundFeeDetailArray.length - 1);
				}
				refundFeeDetailArray += "]";
			} if("104" == nextState || "105" == nextState) {
				//approveObj.masterType = masterType;
			} else if("108" == nextState) {
				approveObj.approveResult = "Y";
				approveObj.isTransfer = isTransfer;
				approveObj.belongDate = belongDate;
			}
			var param = JSON.stringify(approveObj);
			if("102" == nextState) {
				param = param.substring(0, param.length - 1);
				param += ",\"refundFeeObj\":" + JSON.stringify(refundFeeObj) + ",\"refundFeeDetailArray\":" + refundFeeDetailArray + "}";
			}
			param = encodeURI(param);
			$.ajax({
				url: "/sys/refund/approveRefund.do",
				data: "param=" + param,
				dataType: "json",
				async: true,
				beforeSend: function() {
					$.messager.progress({title : '审批退费', msg : '正在审批退费，请稍等……'});
				},
				success: function (data) {
					$.messager.progress('close'); 
					var flag = data.flag;
					if(flag) {
						showMessage('提示', "退费审批成功！", function() {window.location.href = "/sys/refund/refund.jsp?funcNodeId=53";});
					} else {
						showMessage('提示', data.msg);
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
		async: true,
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
				} else if("005" == obj.tacheState) {
					$("#headquartersFinancialRemark").html(obj.remark);
				}
			});
		} 
	});
	
	//根据不同的审批人员显示不同的审批信息
	var nextState = $("#nextState").val();
	var isAcademic = $("#isAcademic").val();
	var refundRule = $("#refundRule").val();
	var optionType = $("#optionType").val();
	if("approve" == optionType) {
		if("100" == nextState || "101" == nextState) {
			$("[name='studentCourseId']").each(function() {
				var studentCourseId = $(this).val();
				$("#financialDiv" + studentCourseId).css("display", "none");
			});
			$("#headmasterApproveDiv").css("display", "block");
		} else if("102" == nextState) {
			$("[name='studentCourseId']").each(function() {
				var studentCourseId = $(this).val();
				$("#financialConfirmRefundFee" + studentCourseId).textbox({disabled: false});
				$("input", $("#financialConfirmRefundFee" + studentCourseId).next("span")).blur(function() {
					calculateConfirmRefundAmount(studentCourseId);
				});
			});
			$("#headmasterViewDiv").css("display", "block");
			$("#financialApproveDiv").css("display", "block");
		} else if("103" == nextState) {
			$("#headmasterViewDiv").css("display", "block");
			$("#financialViewDiv").css("display", "block");
			$("#chiefFinancialOfficerApproveDiv").css("display", "block");
		} else if("104" == nextState || "105" == nextState) {
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
			$("#regionalPresidentViewDiv").css("display", "block");
			$("#principalApproveDiv").css("display", "block");
		} else if("108" == nextState) {
			$("#headmasterViewDiv").css("display", "block");
			$("#financialViewDiv").css("display", "block");
			if("SPECIAL_ADJUST" == refundRule) {
				$("#chiefFinancialOfficerViewDiv").css("display", "block");
			}
			$("#academicOrSalesViewDiv").css("display", "block");
			$("#regionalPresidentViewDiv").css("display", "block");
			$("#principalViewDiv").css("display", "block");
			$("#headquartersFinancialApproveDiv").css("display", "block");
		}
	} else if("cancel" == optionType) {
		var tacheState = $("#tacheState").val();
		if("005" == tacheState) {
			$("#headmasterViewDiv").css("display", "block");
			$("#financialViewDiv").css("display", "block");
			if("SPECIAL_ADJUST" == refundRule) {
				$("#chiefFinancialOfficerViewDiv").css("display", "block");
			}
			$("#academicOrSalesViewDiv").css("display", "block");
			$("#regionalPresidentViewDiv").css("display", "block");
			$("#principalViewDiv").css("display", "block");
			$("#headquartersFinancialViewDiv").css("display", "block");
		} else {
			if("100" == nextState || "101" == nextState) {
				$("#approveDiv").css("display", "none");
			} else if("102" == nextState) {
				$("#headmasterViewDiv").css("display", "block");
			} else if("103" == nextState) {
				$("#headmasterViewDiv").css("display", "block");
				$("#financialViewDiv").css("display", "block");
			} else if("104" == nextState || "105" == nextState) {
				$("#headmasterViewDiv").css("display", "block");
				$("#financialViewDiv").css("display", "block");
				if("SPECIAL_ADJUST" == refundRule) {
					$("#chiefFinancialOfficerViewDiv").css("display", "block");
				}
			} else if("106" == nextState) {
				$("#headmasterViewDiv").css("display", "block");
				$("#financialViewDiv").css("display", "block");
				if("SPECIAL_ADJUST" == refundRule) {
					$("#chiefFinancialOfficerViewDiv").css("display", "block");
				}
				$("#academicOrSalesViewDiv").css("display", "block");
			} else if("107" == nextState) {
				$("#headmasterViewDiv").css("display", "block");
				$("#financialViewDiv").css("display", "block");
				if("SPECIAL_ADJUST" == refundRule) {
					$("#chiefFinancialOfficerViewDiv").css("display", "block");
				}
				$("#academicOrSalesViewDiv").css("display", "block");
				$("#regionalPresidentViewDiv").css("display", "block");
			} else if("108" == nextState) {
				$("#headmasterViewDiv").css("display", "block");
				$("#financialViewDiv").css("display", "block");
				if("SPECIAL_ADJUST" == refundRule) {
					$("#chiefFinancialOfficerViewDiv").css("display", "block");
				}
				$("#academicOrSalesViewDiv").css("display", "block");
				$("#regionalPresidentViewDiv").css("display", "block");
				$("#principalViewDiv").css("display", "block");
			}
		}
	}
	if("104" == nextState || "105" == nextState) {
		$("input:radio[name='approveType']").change(function() {
			var approveType = $("input:radio[name='approveType']:checked").val();
			/**if("Y" == approveType) 
			{
				
				$("#masterType").combobox({
					url : "/sys/pubData/qryCodeNameList.do?tableName=REFUND_FEE_T&codeType=MASTER_TYPE",//返回json数据的url
					valueField : "codeFlag",
					textField : "codeName",
					panelHeight : "auto",
					formatter : function(data) {
						return "<span>" + data.codeName + "</span>";
					}
				});
			} else 
			{
				$("#masterType").combobox('clear');
				$("#masterType").combobox("loadData", new Array());
			}
			*/
		});
	}
	
	var refundImgUrl = $("#refundImg").attr("href");
	if(refundImgUrl != null && refundImgUrl != "" && refundImgUrl != undefined) {
		$('#refundImg').lightBox();
	}
	
	var courseImgUrl = $("#courseImgUrl").attr("href");
	if(courseImgUrl != null && courseImgUrl != "" && courseImgUrl != undefined) {
		$('#courseImgUrl').lightBox();
	}
	
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
			beforeSend: function() {
				$.messager.progress({title : '取消退费', msg : '正在取消退费，请稍等……'});
			},
			success: function (data) {
				$.messager.progress('close'); 
				var flag = data.flag;
				if(flag) {
					showMessage('提示', "取消退费成功！", function() {window.location.href = "/sys/refund/refund.jsp";});
				} else {
					showMessage('提示', data.msg);
				}
			} 
		});
	});
});

function calculateConfirmRefundAmount(studentCourseId) {
	var realAmount = 0;
	$("[name='studentCourseId']").each(function() {
		var studentCourseId = $(this).val();
		var financialConfirmRefundFee = $("#financialConfirmRefundFee" + studentCourseId).textbox("getValue");
		if(financialConfirmRefundFee != null && financialConfirmRefundFee != "" 
			&& financialConfirmRefundFee != "null" && financialConfirmRefundFee != undefined) {
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