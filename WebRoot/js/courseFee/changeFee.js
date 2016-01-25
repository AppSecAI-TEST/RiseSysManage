$(document).ready(function(){
	initPage();
	$("#submitBtn").click(function(){
		changeFee();
	})
	$("#backBtn").click(function(){
		window.location.href = "qryCourseFee.jsp";
	});
});

function initPage()
{
	$.ajax({
			type : "POST",
			url: "/sys/courseFee/getCourseFeeInfo.do",
			data: "studentCourseId="+$("#studentCourseId").val(),
			async: false,
			dataType:"json",
			beforeSend: function()
	    	{
	    		showProgressLoader("正在加载数据,请稍等",500)
	    	},
	    	success: function(data) {
	    		hideProgressLoader();
	    		if(data.baseInfo!=undefined)
	    		{
	    			var base =data.baseInfo;
	    			$("#name").find("span").html(base.name);
	    			$("#birthday").find("span").html(base.birthTime);
	    			$("#sexVal").find("span").html(base.sexVal);
	    			$("#identityId").find("span").html(base.identityId);
	    			$("#byName").find("span").html(base.byName);
	    			$("#phone").find("span").html(base.phone);
	    			$("#stageId").find("span").html(base.stageId);
	    			$("#classType").find("span").html(base.classType);
	    			$("#payTime").find("span").html(base.payTime);
	    			$("#feeType").find("span").html(base.feeType);
	    			$("#adviserName").find("span").html(base.adviserName);
	    			if(base.totalAmount=="")
	    			{
	    				base.totalAmount="0";
	    			}
	    			if(base.minusAmount=="")
	    			{
	    				base.minusAmount="0";
	    			}
	    			if(base.favorAmount=="")
	    			{
	    				base.favorAmount="0";
	    			}
	    			if(base.amount=="")
	    			{
	    				base.amount="0";
	    			}
	    			$("#totalAmount").find("span").html(base.totalAmount+"元");
	    			$("#minusAmount").find("span").html(base.minusAmount+"元");
	    			$("#favorAmount").find("span").html(base.favorAmount+"元");
	    			$("#amount").find("span").html(base.amount+"元");
	    			$("#afterAmount").html(base.lastAmount);
	    			$("#beforeAmount").val(base.lastAmount);
	    			$("#adjustAmount").numberbox({
						"onChange":function(n,o)
						{
							changeAfterAmount(n);
						},
						max:parseInt($("#amount").find("span").html())
					});
	    			
	    		}
	    		if(data.feeInfo!=undefined&&data.feeInfo.length>0)
	    		{
	    			$.each(data.feeInfo,function(i,obj){
	    				var tr =$("#modelTr").clone();
	    				tr.find("td:eq(0)").find("span").html(obj.handlerName);
	    				tr.find("td:eq(1)").find("span").html(obj.createTime);
	    				tr.find("td:eq(2)").find("span").html(obj.beforeAmount+"元");
	    				tr.find("td:eq(3)").find("span").html(obj.afterAmount+"元");
	    				tr.find("td:eq(4)").find("span").html(obj.remark);
	    				tr.css("display","table-row");	
	    				$("#changeTab").append(tr);	
	    			});
	    		}
	    		else
	    		{
	    			$("#changeInfo").panel("close");
	    		}	
	        },
	        error:function(){
	        	hideProgressLoader();
	        }
	    	
	});
	
}

function changeFee()
{
	if($("#adjustAmount").numberbox("getValue")=="")
	{
		$.messager.alert('提示', "请输入调整金额");
		return false;
	}
	var param ={};
	param.handlerId =$("#handlerId").val();
	param.beforeAmount=$("#beforeAmount").val();
	param.afterAmount =$("#afterAmount").html();
	param.studentCourseId =$("#studentCourseId").val();
	param.remark =trim($("#remark").val());
	param.state ="00A";
	param.adjustAmount =$("#adjustAmount").numberbox("getValue");
	$.ajax( {
		type : "POST",
		url : "/sys/courseFee/changeFee.do",
		data :"param="+JSON.stringify(param),
		async : false,
		beforeSend : function() {
			showProgressLoader("正在保存调整记录,请稍等...", 400);
		},
		success : function(data) {
			hideProgressLoader()
			if (data == "true") {
				showMessage('提示', "调整实收金额成功！", function() {
					window.location.reload();
				});
			} else {
				showMessage('提示', "调整实收金额失败！", null);
			}

		},
		error : function() {
			hideProgressLoader();
			showMessage('提示', "调用调整实收金额服务失败！", null);
		}
	});
}

function changeAfterAmount(n)
{
	if(n=="")
	{
		n=0;
	}
	else
	{
		n=parseInt(n);
	}	
	$("#afterAmount").html(parseInt($("#amount").find("span").html())-n);
}