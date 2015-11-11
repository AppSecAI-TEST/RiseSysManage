$(document).ready(function() {
	$("#qryBtn").click(function() {
		var s = "";
		$('input[name="refundState"]:checked').each(function() {
		    s += $(this).val() + ",";
		});
		s = s.substring(0, s.length - 1);
		var object = $("#qryRefundCourseFm").serializeObject();
		object.refundState = s;
    	var obj = JSON.stringify(object);
    	obj = obj.substring(0, obj.length - 1);
    	var funcNodeId = $("#qryBtn").attr("funcNodeId");
    	obj += ",\"funcNodeId\":\""+funcNodeId+"\"}";
    	$('#apply_list_data').datagrid({
    		url : "/sys/pubData/qryDataListByPage.do",
    		queryParams:{
    			param : obj
    		},
    		onLoadSuccess:function(){
    			//一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题。
    			$('#apply_list_data').datagrid('clearSelections');
    		}
    	});
    });
	
	$("#qryApproveBtn").click(function() {
		var s = "";
		$('input[name="approveRefundState"]:checked').each(function() {
		    s += $(this).val() + ",";
		});
		s = s.substring(0, s.length - 1);
		var object = $("#qryRefundApproveFm").serializeObject();
		object.approveRefundState = s;
    	var obj = JSON.stringify(object);
    	obj = obj.substring(0, obj.length - 1);
    	var funcNodeId = $("#qryApproveBtn").attr("funcNodeId");
    	obj += ",\"funcNodeId\":\""+funcNodeId+"\"}";
    	$('#approve_list_data').datagrid({
    		url : "/sys/pubData/qryDataListByPage.do",
    		queryParams:{
    			param : obj
    		},
    		onLoadSuccess:function(){
    			//一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题。
    			$('#approve_list_data').datagrid('clearSelections');
    		}
    	});
    });
	
	
	
	$("#womType").combobox({
		url : "/sys/pubData/qryCodeNameList.do?tableName=STUDENT_WOM_T&codeType=WOM_TYPE",//返回json数据的url
    	valueField : "codeFlag",
    	textField : "codeName",
    	panelHeight : "auto",
    	onLoadSuccess : function () { //数据加载完毕事件
            var data = $('#womType').combobox('getData');
            if (data.length > 0) {
                $("#womType").combobox('select', data[0].codeFlag);
            }
        },
		onChange : function(n, o) {
			$("#womChannel").combobox({
				url : "/sys/pubData/qryCodeNameList.do?tableName=STUDENT_WOM_T&codeType=WOM_CHANNEL_" + n,//返回json数据的url
		    	valueField : "codeFlag",
		    	textField : "codeName",
		    	panelHeight : "auto",
		    	onLoadSuccess : function () { //数据加载完毕事件
		            var data = $('#womChannel').combobox('getData');
		            if (data.length > 0) {
		                $("#womChannel").combobox('select', data[0].codeFlag);
		            }
		        }
			});	
		}
	});	
	
	//浏览
	$("#view").click(function() {
		
	});
	
	//申请退费
	$("#refundApply").click(function() {
		window.location.href = "/sys/refund/refundStudentCourseList.jsp";
	});
	
	//退费审批
	$("#refundApprove").click(function() {
		var row = $('#approve_list_data').datagrid('getSelected');
		if(row) {
			var courseType = row.courseType;
			var refundFeeId = row.refundFeeId;
			window.location.href = "/sys/refund/qryApproveRefund.do?refundFeeId="+refundFeeId+"&courseType="+courseType;
		} else {
			$.messager.alert('提示', "请先选择您要审批的退费申请！");
		}
	});
	
	//退费浏览
	$("#refundView").click(function() {
		
	});
	
	//取消
	$("#refundCancel").click(function() {
		
	});
	
	//重新申请
	$("#refundApplyAgain").click(function() {
		
	});
});