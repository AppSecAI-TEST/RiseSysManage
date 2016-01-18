$(document).ready(function() {
	$("input:radio[name='isGet']").change(function() {
		var giftType = $("#giftType").combobox("getValue");
		var isGet = $("input:radio[name='isGet']:checked").val();
		if("N" == isGet) {
			if(giftType == "COUPON") {
				$("#couponTd").attr("colspan", "2");
				$("#couponTd").attr("width", "410px");
				$("#couponTd").css("border-right", "1px solid #ccc");
				$("#getCouponTd").css("display", "none");
			}
			$("#granter").textbox({disabled : true});
		} else {
			if(giftType == "COUPON") {
				$("#couponTd").attr("colspan", "1");
				$("#couponTd").attr("width", "200px");
				$("#couponTd").css("border-right", "0px");
				$("#getCouponTd").css("display", "table-cell");
			}
			$("#granter").textbox({disabled : false});
		}
	});
	
	$("#giftType").combobox({
		url : "/sys/pubData/qryCodeNameList.do?tableName=GIFT_TYPE_T&codeType=PARENT_TYPE",//返回json数据的url
    	valueField : "codeFlag",
    	textField : "codeName",
    	panelHeight : "auto",
    	editable : false,
    	formatter : function(data) {
    		return "<span>" + data.codeName + "</span>";
    	},
		onChange : function(n, o) {
			if("COUPON" == n) {
				$("#otherTd").css("display", "none");
				$("#couponTd").attr("colspan", "2");
				$("#couponTd").css("display", "table-cell");
				$("#couponType").combobox({
					url : "/sys/pubData/qryData.do?param={queryCode:\"Qry_Gift_Type\",parentType:\""+n+"\"}",//返回json数据的url
					valueField : "giftType",
					textField :  "typeName",
					panelHeight : "auto",
					editable : false,
					formatter : function(data) {
			    		return "<span>" + data.typeName + "</span>";
			    	},
					onChange : function(newValue, oldValue) {
						$("#amount").combobox({
							url : "/sys/pubData/qryData.do?param={queryCode:\"Qry_Gift\",giftType:\""+newValue+"\"}",//返回json数据的url
					        valueField : "giftId",
					        textField :  "giftName",
					        panelHeight : "auto",
					        formatter : function(data) {
					    		return "<span>" + data.giftName + "</span>";
					    	}
						});
					}
				});
				$("#giftName").combobox('clear');
				$("#giftName").combobox("loadData", new Array());
			} else {
				$("#couponTd").css("display", "none");
				$("#otherTd").css("display", "table-cell");
				$("#giftName").combobox({
					url : "/sys/pubData/qryData.do?param={queryCode:\"Qry_Gift\",giftType:\""+n+"\"}",//返回json数据的url
					valueField : "giftId",
					textField :  "giftName",
					panelHeight : "auto",
					editable : false,
					formatter : function(data) {
			    		return "<span>" + data.giftName + "</span>";
			    	}
				});
				$("#giftCode").numberbox("datebox", "");
				$("#giftCode").numberbox("setValue", "");
				$("#couponType").combobox('clear');
				$("#couponType").combobox("loadData", new Array());
				$("#amount").combobox('clear');
				$("#amount").combobox("loadData", new Array());
			}
		}
	});
	
	//添加活动
    $("#activitySubmit").click(function() {
    	if($("#activityFm").form('validate')) {
    		var paramObj = $("#activityFm").serializeObject();
    		var gifts = new Array();
    		$("#addActivityTd").find('tr').each(function(i, node) {
    			var trName = $(this).attr("val");
    			if('gift' == trName) {
    				var tds = $(this).children('td');
					var giftType = tds.eq(1).attr('giftType');
					var effNum = tds.eq(3).attr('effNum');
					var unit = tds.eq(3).attr('unit');
					var giftId = tds.eq(3).attr('giftId');
					var giftName = tds.eq(3).attr('giftName');
					var usableAmount = tds.eq(3).attr('usableAmount');
					var giftCode = tds.eq(3).attr('giftCode');
					var effDate = tds.eq(3).attr('effDate');
					var isGet = tds.eq(5).attr('isGet');
					var granter = tds.eq(7).attr('granter');
					var gift = {};

					gift.studentId = paramObj.studentId;
					gift.giftChannel = "ACTIVITY";
					gift.giftType = giftType;
					if("COUPON" == giftType) {
						gift.effDate = effDate;
					}
					gift.effNum = effNum;
					gift.unit = unit;
					gift.giftId = giftId;
					gift.giftName = giftName;
					gift.amount = usableAmount;//刚刚新增时可用金额跟剩余金额一样
					gift.usableAmount = usableAmount;
					gift.giftCode = giftCode;
					gift.isGet = isGet;
					gift.isRtn = "N";
					gift.giftState = "UNSUED";
					gift.granter = granter;
					if ("Y" == isGet) {
						gift.getUser = paramObj.name;
					}
					gift.giftChannelDesc = paramObj.title + "赠送";
					gift.giveRemark = paramObj.remark;
					gift.handlerId = paramObj.handlerId;
					gifts.push(gift);  
    			}
    		});
    		
    		if(gifts.length == 0) {
    			$.messager.alert('提示', "请至少添加一个赠品！");
    			return;
    		} else {
    			var activityObj = {};
    			activityObj.title = paramObj.title;
    			activityObj.activityName = paramObj.title;
    			activityObj.activityDate = paramObj.activityDate;
    			activityObj.award = paramObj.award;
    			activityObj.remark = paramObj.remark;
    			activityObj.studentId = paramObj.studentId;
    			var param = "{\"activityObj\":"+JSON.stringify(activityObj)+",\"studentGiftList\":"+JSON.stringify(gifts)+"}";
    			param = encodeURI(param);
    			$.ajax({
    				url: "/sys/student/addActivity.do",
    				data: "param=" + param,
    				dataType: "json",
    				async: true,
    				beforeSend: function()
    				{
    					$.messager.progress({title : '活动信息', msg : '正在添加活动信息，请稍等……'});
    				},
    				success: function (data) {
    					$.messager.progress('close'); 
    					var flag = data.flag;
    					if(flag) {
    						$.messager.alert('提示', "成功添加活动信息！", "info", function() {window.history.back();});
    					} else {
    						$.messager.alert('提示', data.msg);
    					}
    				} 
    			});
    		}
    	} else {
    		$("#activityFm").find(".textbox-text.validatebox-text.validatebox-invalid:first").trigger("mouseover");
    	}	
    });
});

// 增加行
function addRow() {
	var giftModelTR = $("#giftModelTR").clone();
	var flag = true;
	var giftTR = $("#addGift").clone();
	giftTR.css("display", 'table-row');
	giftTR.attr("val", "gift");
	var getFlag = $("input:radio[name='isGet']:checked").val();
	giftTR.find("td").each(function(n, node) {
		var giftType = $("#giftType").combobox('getValue');
		if (n == 1) {
			// 赠品类别;
			var name = $("#giftType").combobox('getText');
			if (giftType == undefined || giftType == "") {
				flag = false;
				$.messager.alert('提示', "请选择赠品类别！");
				return false;
			}
			$(node).html("<span>" + name + "</span>");
			$(node).attr("giftType", giftType);
		} else if (n == 3){
			// 赠品名称;劵类ID 
			var unit = "";
			var giftId = "";
			var amount = "";
			var effNum = "";
			var effDate = "";
			var giftNum = "";
			var giftName = "";
			var giftCode = "";
			var usableAmount = "";
			var giftNameText = "";
			if("COUPON" == giftType) {
				var couponType = $("#couponType").combobox("getValue");
				if (couponType == undefined || couponType == "" || couponType == null) {
					flag = false;
					$.messager.alert('提示', "请选择券类赠品类型！");
					return false;
				} else {
					var data = $("#couponType").combobox("getData");
					for(var i = 0; i < data.length; i++) {
						if(couponType == data[i].giftType) {
							unit = data[i].unit;
							effNum = data[i].effNum;
						}
					}
					giftName = $("#amount").combobox("getText");
					if (giftName == undefined || giftName == "" || giftName == null) {
						flag = false;
						$.messager.alert('提示', "请选择赠品名称！");
						return false;
					} else {
						giftId = $("#amount").combobox("getValue");
						var datas = $("#amount").combobox("getData");
						for(var i = 0; i < datas.length; i++) {
							if(giftId == datas[i].giftId) {
								amount = datas[i].amount;
								giftNum = datas[i].giftNum;
								usableAmount = datas[i].amount;
							}
						}
						if(giftType == "COUPON" && "Y" == getFlag) {
							giftCode = $("#giftCode").numberbox("getValue");
							if (giftCode == undefined || giftCode == "" || giftCode == null) {
								flag = false;
								$.messager.alert('提示', "请输入"+giftName+"的编码！");
								return false;
							} else {
								effDate = $("#effDate").datebox("getValue");
								if(effDate == undefined || effDate == "" || effDate == null) {
									flag = false;
									$.messager.alert('提示', "请输入"+giftName+"的有效期开始时间！");
									return false;
								} else {
									giftNameText = giftName + "&nbsp;&nbsp;" + giftCode + "&nbsp;&nbsp;" +  effDate;
								}
							}
						} else {
							giftNameText = giftName;
						}
					}
				}
			} else {
				giftName = $("#giftName").combobox("getText");
				if (giftName == undefined || giftName == "" || giftName == null) {
					flag = false;
					$.messager.alert('提示', "请选择赠品名称！");
					return false;
				} else {
					giftId = $("#giftName").combobox("getValue");
					giftNameText = giftName;
				}
			}
			$(node).html("<span>" + giftNameText + "</span>");
			$(node).attr("unit", unit);
			$(node).attr("giftId", giftId);
			$(node).attr("amount", amount);
			$(node).attr("effNum", effNum);
			$(node).attr("effDate", effDate);
			$(node).attr("giftNum", giftNum);
			$(node).attr("giftName", giftName);
			$(node).attr("giftCode", giftCode);
			$(node).attr("usableAmount", usableAmount);
		} else if (n == 5) {
			var isGet = $("input[name='isGet']:checked").val();
			if (isGet == undefined || isGet == "") {
				flag = false;
				$.messager.alert('提示', "请选择是否领用！");
				return false;
			}
			if ('Y' == isGet) {
				$(node).html("<span>√</span>");
				$(node).attr("isGet", "Y");
			} else if ('N' == isGet) {
				$(node).html("<span>×</span>");
				$(node).attr("isGet", "N");
			}
		} else if (n == 7) {
			var granter = $("#granter").textbox("getValue");
			if ((granter == undefined || granter == "" || granter == null) && "Y" == getFlag) {
				flag = false;
				$.messager.alert('提示', "请填写发放人！");
				return false;
			}
			$(node).html("<span>" + granter + "</span>");
			$(node).attr("granter", granter);
		}
	});
	if (flag) {
		$("#addGift").after(giftTR);
		clearData("giftModelTR");
		$("#couponTd").css("display", "none");
		$("#otherTd").css("display", "table-cell");
		$("#couponTd").attr("colspan", "2");
		$("#couponTd").attr("width", "410px");
		$("#couponTd").css("border-right", "1px solid #ccc");
		$("#getCouponTd").css("display", "none");
	}
}

// 删除相对应的行
function delRow(rows) {
	$(rows).parent("td").parent("tr").remove();
}