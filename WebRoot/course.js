$(document).ready(function()
{  
    $('#parentType').combobox({
	 onChange:function(n,o)
		{
		     $("#td0").css('display','none');
		 	 $("#td1").css('display','none');
             $("#td2").css('display','none');
             $("#td3").css('display','none');
       		if(n=='COUPON')//ȯ��
       		{
			    var urls="/sys/pubData/qryData.do?param={queryCode:\"Qry_Gift_Type\",parentType:\""+n+"\"}";
	       		$("#giftType").combobox(
	       		{
	        		url : urls,//����json���ݵ�url
	        		valueField : "giftType",
	        		textField :  "typeName",
	        		panelHeight : "auto",
	        		onLoadSuccess : function ()
	        		{ //���ݼ�������¼�
	                    var data = $('#giftType').combobox('getData');
	                    if (data.length > 0)
	                    {
	                      //  $("#giftId").combobox('select', data[0].param2);
	                    }
	                    $("#td0").css('display','block');
	                    $("#td1").css('display','block');
	                    $("#td2").css('display','block');
	                    $("#td3").css('display','block');
	                }
	        	});
       		}else if(n=='GOODS')//ʵ����
       		{
       			$("#td1").css('display','block');
			    var urls="/sys/pubData/qryData.do?param={queryCode:\"Qry_Gift\",giftType:\""+n+"\"}";
	       		$("#giftId").combobox(
	       		{
	        		url : urls,//����json���ݵ�url
	        		valueField : "giftId",
	        		textField :  "giftName",
	        		panelHeight : "auto",
	        		onLoadSuccess : function ()
	        		{ //���ݼ�������¼�
	                    var data = $('#giftId').combobox('getData');
	                    if (data.length > 0)
	                    {
	                      //  $("#giftId").combobox('select', data[0].param2);
	                    }
	                }
	        	});
       		}
		}
	});
	
	$('#giftType').combobox({
		onChange:function(n,o)
		{
       		 var urls="/sys/pubData/qryData.do?param={queryCode:\"Qry_Gift\",giftType:\""+n+"\"}";
       		 $("#giftId").combobox(
       			 {
        		url : urls,//����json���ݵ�url
        		valueField : "giftId",
        		textField : "giftName",
        		panelHeight : "auto",
        		onLoadSuccess : function ()
        		{ //���ݼ�������¼�
                    var data = $('#giftId').combobox('getData');
                    if (data.length > 0)
                    {
                      //  $("#giftId").combobox('select', data[0].param2);
                    }
                }
        	});
		}
	});
	
	$('#giftCourseType').combobox({
		onChange:function(n,o)
		{
       		 var urls="/sys/pubData/qryData.do?param={queryCode:\"Qry_Gift\",giftType:\""+n+"\"}";
       		 $("#giftCourseId").combobox(
       		 {
        		url : urls,//����json���ݵ�url
        		valueField : "giftId",
        		textField : "giftName",
        		panelHeight : "auto",
        		onLoadSuccess : function ()
        		{ //���ݼ�������¼�
                    var data = $('#couponType').combobox('getData');
                    if (data.length > 0)
                    {
                      //  $("#giftId").combobox('select', data[0].param2);
                    }
                }
        	});
		}
	});
	
	$('#giftCourseId').combobox({
		onChange:function(n,o)
		{
   		       var data = $('#giftCourseId').combobox('getData');
                if (data.length > 0)
                {
                    for(var i=0;i<data.length;i++)
                    {
                    	var giftNum=data[0].giftNum;	
                    	var giftId=data[0].giftId;
                    	if(n==giftId)
                    	{
                    		$("#courseHours").html(giftNum);
                    	}
                    }
                }
		}
	});
	
	//ѡ��׶μۼ��ذ༶
	$('#stageId').combobox(
	{    
       onChange : function(n, o)
       {
			var stageType = $("#stageId").combobox('getText');
			var payDate=$("#payDate").datebox('getValue');
			if(payDate=='')
			{
				$("#stageId").combobox('setText',"");
				$("#classType").combobox('setText',"");
				$("#totalAmount").textbox('setValue', '');
				$.messager.alert('��ʾ', "��ѡ��ɷ�ʱ��");	
				return;
			}
			
		    var data = $("#stageId").combobox('getData');
			var amount;
			for(var i=0;i<data.length;i++)
			{
				 if(n==data[i].stageId)
				 {
					 $("#stageOrder").val(data[i].seqOrder);
				 }
			}
		  
       		var stageType=$("#stageId").combobox('getText');
       		var schoolId=$("#schoolId").val();
       		var url = "/sys/pubData/qryData.do?param={queryCode:\"Qry_Stage_Class\",time:\""+ payDate + "\",stageId:\""+ stageType + "\",schoolId:\""+ schoolId+ "\"}";
       	 	$("#classType").combobox(
       	 	{
        		url : url,//����json���ݵ�url
        		valueField : "classType",
        		textField : "classType",
        		panelHeight : "auto",
        		onLoadSuccess : function ()
        		{ //���ݼ�������¼�
                    var data = $('#classType').combobox('getData');
                    var flag=false; 
                    if (data.length > 0)
                    {
	            	    var oldClassType=$('#oldClassType').val();
		               	for(var i=0;i<data.length;i++)
		               	{
		               		if(oldClassType==data[i].classType)
		                   	{
		                   		flag=true;
		                   		amount=data[i].amount;
		               			$("#classType").combobox('select', oldClassType);
		               			$("#coursePriceId").val(data[i].coursePriceId); 
		                    }
		                }
		               	if(!flag)
		               	{
		               		amount=data[0].amount;
		               		$("#classType").combobox('select', data[0].classType);
		               		$("#coursePriceId").val(data[0].setPriceId); 
		               	}
		               	 $("#totalAmount").textbox('setValue',amount);
		    			 parent.window.countAmount();
                    }
                }
       	 	
        	});
       }  
	});
	
	$('#favorAmount').textbox(
	{  
 		 onChange: function(value)
 		 {  
   			minus=$("#minusAmount").textbox('getValue');
			favorAmount=$("#favorAmount").textbox('getValue');
			totalAmount=$("#totalAmount").textbox('getValue');
			amount=totalAmount-minus-favorAmount;
			$("#amount").textbox('setValue',amount);
			parent.window.countAmount();
   		 }  
	});

 }); 


function closeDlg()
{
	$('#dlg').dialog('close');
	$('#useCoupon').html(useCoupon);
	$("#minusAmount").textbox('setValue',minus);
	favorAmount=$("#favorAmount").textbox('getValue');
	totalAmount=$("#totalAmount").textbox('getValue');
	amount=totalAmount-minus-favorAmount;
	$("#amount").textbox('setValue',amount);
	parent.window.countAmount();
}
	
	
	
//���ȡ���ֿ�ȯ����ȥ�ܵ��Żݽ��
function colDis(id)
{
	var idT="#useCoupon"+id+"";
	$(idT).css('display','none');
	for(var i=coupons.length-1;i>=0;i--)
	{
		 var coupon=coupons[i];
		 if(coupon.studentGiftId==id)
		 {
			var usableAmountT=$("#minusAmount").textbox('getValue');
			usableAmountT=usableAmountT-coupon.usableAmount;
			$("#minusAmount").textbox('setValue',usableAmountT);
			coupons.remove(i);
		 }
	}
	minus=$("#minusAmount").textbox('getValue');
	favorAmount=$("#favorAmount").textbox('getValue');
	totalAmount=$("#totalAmount").textbox('getValue');
	amount=totalAmount-minus-favorAmount;
	$("#amount").textbox('setValue',amount);
	parent.window.countAmount();
}

function addArchives()
{
	var totalAmount=$("#totalAmount").textbox('getValue');
	if(totalAmount=='')
	{
		$.messager.alert('��ʾ', "��ѡ��׶�!");
		return;
	}
	$("#frame").attr('src',"/sys/course/useCoupon.jsp?studentId=2");
	$('#dlg').dialog('open').dialog('setTitle', 'ʹ�õֿ�ȯ');
}
	
	
function getMinus()
{
	return $("#minusAmount").textbox('getValue');
}

function getFavorAmount()
{
	return $("#favorAmount").textbox('getValue');
}

function getTotalAmount()
{
	return $("#totalAmount").textbox('getValue');
}

function getAmount()
{
	return $("#amount").textbox('getValue');
}