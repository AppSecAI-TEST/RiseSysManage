$(document).ready(function()
{
	 
	//选择阶段价加载班级
$('#shortClassId').combobox({
	onChange : function(n, o)
	{
		var data = $("#shortClassId").combobox('getData');
		var shortClassId = $("#shortClassId").combobox('getValue');
		var payDate=$("#payDate").datebox('getValue');
		if(payDate=='')
		{
			$("#shortClassId").combobox('setText',"");
			$("#shortClassType").combobox('setText',"");
			$("#totalAmount").textbox('setValue', '');
			$.messager.alert('提示', "请选择缴费时间");	
			return;
		}
		var courseType = $("#oldCourseType").val();
		if(shortClassId=='' || courseType=='001')
		{
			return;
		}
		var schoolId=$("#schoolId").val();
		var urls = "/sys/pubData/qryData.do?param={queryCode:\"Qry_Short_Class_Price\",time:\""+ payDate + "\",schoolId:\""+ schoolId + "\",shortClassId:\""+ shortClassId + "\"}";
		$("#shortClassType").combobox(
		{
			url : urls,//返回json数据的url
			valueField : "classType",
			textField : "classType",
			panelHeight : "auto",
			onLoadSuccess : function() { //数据加载完毕事件
				var data = $('#shortClassType').combobox('getData');
				var oldClassType= $('#oldClassType').val();
				if(data==null || data.length==0)
				{
					$("#shortClassId").combobox('setText',"");
					$("#shortClassType").combobox('setText',"");
					$.messager.alert('提示', "没有适用的短期班格价格体系,请重新选择缴费日期");	
					return;
				} 
				loadShortFavor();
				for(var i=0;i<data.length;i++)
				{
					if(oldClassType==data[i].classType || data.length==1)
					{
						$("#shortClassType").combobox('select',data[i].classType);
						$("#totalAmount").textbox('setValue', data[i].amount);
						favorAmount = $("#favorAmount").textbox('getValue');
						$("#minusAmount").textbox('setValue',oldMinusAmount);
						totalAmount = $("#totalAmount").textbox('getValue');
						minus = $("#minusAmount").textbox('getValue');
						var amountT = totalAmount - minus - favorAmount;
				
						$("#amount").textbox('setValue', amountT);
						$("#coursePriceId").val(data[i].setPriceId); 
					}
				}
			}
		});
	 }
});


$("#shortClassType").combobox(
{
	onChange:function(n,o)
	{
		var data = $('#shortClassType').combobox('getData');
		for(var i=0;i<data.length;i++)
		{
			if(n==data[i].classType)
			{
				$("#shortClassType").combobox('select',data[i].classType);
			
				$("#totalAmount").textbox('setValue', data[i].amount);
				 
				minus = $("#minusAmount").textbox('getValue');
			
				favorAmount = $("#favorAmount").textbox('getValue');
				totalAmount = $("#totalAmount").textbox('getValue');
				amount = totalAmount - minus - favorAmount;
				$("#amount").textbox('setValue', amount);
				$("#coursePriceId").val(data[i].setPriceId); 
			}
			
		}
	}
});
	
function loadShortFavor()
{
	var payDate=$("#payDate").datebox('getValue');
	var schoolId=$("#schoolId").val();
	var shortClassId = $("#shortClassId").combobox('getValue');
	var favors=$("#favorType").val();
	var favorIds=favors.split(",");
	var url = "/sys/pubData/qryData.do?param={queryCode:\"Qry_short_favor\",time:\""+ payDate + "\",schoolId:\""+ schoolId + "\",shortClassId:\""+ shortClassId + "\"}";
	$.ajax(
	{
		type : "POST",
		url: url,
		async: false,
		dataType:"json",
		beforeSend: function()
    	{
    		 
    	},
    	success: function(data)
    	{
    		 var html="";
    		 for(var i=0;i<data.length;i++)
    		 {
    			 var favor=data[i];
    			 var name =favor.favorName;
    			 var price=favor.favorPrice;
    			 var id=favor.favorId;
    			 var flag=false;
    			 for(var n=0;n<favorIds.length;n++)
    			 {
    				 if(favorIds[n]==id)
    				 {
    					 flag=true;
    					 break;
    				 }
    			 }
    			 if(flag)
    			 {
    				  html+="<input type='checkbox' onclick=minusFavor("+id+") id="+id+" checked price='"+price+"'/><span>"+name+"("+price+"元)</span>&nbsp&nbsp"; 
    			 }else
    			 {
    				  html+="<input type='checkbox' onclick=minusFavor("+id+") id="+id+" price='"+price+"'/><span>"+name+"("+price+"元)</span>&nbsp&nbsp"; 
    			 }
    			
    		 }
    		 $("#favors").html(html);
    	}
    });
	
}

});


function minusFavor(id)
{
	var obj=$("#"+id);
	var price=obj.attr('price');
	
	var favorAmount=$("#favorAmount").textbox('getValue');
	var totalAmount=$("#totalAmount").textbox('getValue');
	var amount=$("#amount").textbox('getValue');
	var  minus = $("#minusAmount").textbox('getValue');
	if(obj.is(':checked'))
	{
		favorIds+=id+",";
		favorAmount=Number(favorAmount)+Number(price);
		amount=Number(totalAmount)-favorAmount-Number(minus);
	}else
	{
		favorAmount=Number(favorAmount)-Number(price);
		amount=Number(totalAmount)-Number(favorAmount)-Number(minus);
		var ids=favorIds.split(",");
		var idsT="";
		for(var i=0;i<ids.length;i++)
		{
			var idT=ids[i];
			if(idT!=id && idT!='')
			{
				idsT+=idT+",";			
			}
		}
		favorIds=idsT;
	}
	$("#amount").textbox('setValue', amount);
	$("#favorAmount").textbox('setValue', favorAmount);
}
  