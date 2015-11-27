$(document).ready(function() {
	$("#refundWay").combobox({
		url : "/sys/pubData/qryCodeNameList.do?tableName=REFUND_FEE_T&codeType=REFUND_WAY",//返回json数据的url
    	valueField : "codeFlag",
    	textField : "codeName",
    	panelHeight : "auto",
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
});