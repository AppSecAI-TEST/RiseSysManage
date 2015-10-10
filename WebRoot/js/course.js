$(document).ready(function()
{  
    $('#parentType').combobox({
	 onChange:function(n,o)
		{
		     $("#td0").css('display','none');
		 	 $("#td1").css('display','none');
             $("#td2").css('display','none');
             $("#td3").css('display','none');
       		if(n=='COUPON')//券类
       		{
			    var urls="/sys/pubData/qryData.do?param={queryCode:\"Qry_Gift_Type\",parentType:\""+n+"\"}";
	       		$("#giftType").combobox(
	       		{
	        		url : urls,//返回json数据的url
	        		valueField : "giftType",
	        		textField :  "typeName",
	        		panelHeight : "auto",
	        		onLoadSuccess : function ()
	        		{ //数据加载完毕事件
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
       		}else if(n=='GOODS')//实物类
       		{
       			$("#td1").css('display','block');
			    var urls="/sys/pubData/qryData.do?param={queryCode:\"Qry_Gift\",giftType:\""+n+"\"}";
	       		$("#giftId").combobox(
	       		{
	        		url : urls,//返回json数据的url
	        		valueField : "giftId",
	        		textField :  "giftName",
	        		panelHeight : "auto",
	        		onLoadSuccess : function ()
	        		{ //数据加载完毕事件
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
        		url : urls,//返回json数据的url
        		valueField : "giftId",
        		textField : "giftName",
        		panelHeight : "auto",
        		onLoadSuccess : function ()
        		{ //数据加载完毕事件
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
        		url : urls,//返回json数据的url
        		valueField : "giftId",
        		textField : "giftName",
        		panelHeight : "auto",
        		onLoadSuccess : function ()
        		{ //数据加载完毕事件
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
	
	//选择阶段价加载班级
	$('#stageId').combobox(
	{    
       onChange : function(n, o)
       {
       	 	
		    var data = $("#stageId").combobox('getData');
			var amount;
			for(var i=0;i<data.length;i++)
			{
				 if(n==data[i].stageId)
				 {
					 amount=data[i].amount;
					 $("#stageOrder").val(data[i].seqId);
				 }
			}
		
		    $("#totalAmount").textbox('setValue',amount);
		    parent.window.countAmount();
       		var stageType=$("#stageId").combobox('getText');
       		var urls="/sys/pubData/qryData.do?param={queryCode:\"Qry_Stage_Class\",stageId:\""+stageType+"\"}";
       	 	$("#classType").combobox(
       	 	{
        		url : urls,//返回json数据的url
        		valueField : "classType",
        		textField : "classType",
        		panelHeight : "auto",
        		onLoadSuccess : function ()
        		{ //数据加载完毕事件
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
		               			$("#classType").combobox('select', oldClassType);
		                    }
		                }
		               	if(!flag)
		               	{
		               		$("#classType").combobox('select', data[0].classType);
		               	}
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

//初始化已有赠品信息
function initCousreGift()
{
		//增加赠品
 	var sqlParam={};
 	var id=$("#studentCourseId").val();
	sqlParam.studentCourseId=id;
	sqlParam.queryCode='Qry_Course_Gift';
	var str = JSON.stringify(sqlParam);
	$.ajax({
		url: "/sys/course/getStuCourses.do?",
		data: "param="+str,
		dataType: "json",
		async: false,
		beforeSend: function()
    	{
    		// $.messager.progress({title : '批量修改', msg : '正在批量修改客户关怀和责任顾问，请稍等……'});
    	},
    	success: function (data)
    	{
    		$.messager.progress('close'); 
    		 var giftTs = data.data;//学员已有课程 
    		 
    		$.each(giftTs,function(i,gift)
    		{
    			if(gift==null)return;
				var giftTR;
    			if(gift.parentType=="GOODS" || gift.parentType=="COUPON")
				{
			 		giftTR=$("#addGift").clone();
			 		giftTR.css("display",'table-row');
					giftTR.attr("studentGiftId",gift.studentGiftId);
					giftTR.attr("val",'gift');
					giftTR.find("td").each(function(n,node)
					{
						if(n==1)
						{
							if(gift.giftType=="GOODS")
							{
								$(node).html("<span>实物赠品</span>");	
							}else if(gift.parentType=="COUPON")
							{
								$(node).html("<span>券类赠品</span>");	
							}
						}else if(n==3)
						{	
							if(gift.giftType=="GOODS")
							{
								 $(node).html("<span>"+gift.giftName+"</span>");	
							}else
							{
								 $(node).html("<span>"+gift.giftName+"   "+gift.giftCode+"   "+gift.effDate+"</span>");
							}
							
						}else
						if(n==5)
						{	
							if(gift.isGet=='Y')
							{
								$(node).html("<span>已领取</span>");	
							}else
							{
								$(node).html("<span>未领取</span>");	
							}
							
							 
						}else if(n==7)
						{
							$(node).html("<span>"+gift.granter+"</span>");	
						}else if(n==8)
						{
							if(gift.isRtn=='Y')
							{
								$(node).html("<span>是</span>");	
							}else
							{
								$(node).html("<span>否</span>");	
							}
						}else if(n==9)
						{
							if(gift.giftState!='UNSUED')//已使用不可删除
							{
								 $(node).html("");
								
							} 
						}
					});
				
					$("#addGift").after(giftTR);
			 	}else if(gift.parentType=="COURSE")
			 	{
			 		var objectTr=$("#add").clone();//克隆模板
					objectTr.css("display",'table-row');
					objectTr.attr("val","course");
					objectTr.attr("studentGiftId",gift.studentGiftId);
					objectTr.find("td").each(function(i,node)
					{
						var effDate="";
						if(i==0)
						{
							$(node).html("<span>"+(i+1)+"</span>");	
						}else
						if(i==1)
						{
							$(node).html("<span>"+gift.typeName+"</span>");	
						}else if(i==2)
						{
							 
							$(node).html("<span>"+gift.giftName+"</span>");	
		 	
						}else if(i==3)
						{
						 
							$(node).html("<span>"+gift.giftNum+"</span>");	
						}else if(i==4)
						{
							$(node).html("<span>"+gift.createDate+"</span>");	
						}else if(i==5)
						{
							$(node).html("<span>未使用</span>");	
						}else if(i==6)
						{
							$(node).html("<span>"+gift.effDate+"</span>");	
						}else if(i==7)
						{
							$(node).html("<span>"+gift.expDate+"</span>");	
						} 
					});
					$("#add").after(objectTr);
			 	}
				
				
				var height = $(document).height();
				var frameName=$("#frameName").val();
				$(frameName,parent.document).css("height",height);
			});
		} 
	});
	
	 
}

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
	
	
	
//点击取消抵扣券，减去总的优惠金额
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
		$.messager.alert('提示', "请选择阶段!");
		return;
	}
	$("#frame").attr('src',"/sys/course/useCoupon.jsp?studentId=2");
	$('#dlg').dialog('open').dialog('setTitle', '使用抵扣券');
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
