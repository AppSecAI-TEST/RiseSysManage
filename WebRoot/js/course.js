initCousreGift();
	//初始化已有赠品信息
	function initCousreGift()
	{
			//增加赠品
	 	var sqlParam={};
		sqlParam.studentCourseId='<%=object.get("studentCourseId")%>';
		sqlParam.queryCode='Qry_Course_Gift';
		var str = JSON.stringify(sqlParam);
		$.ajax({
			url: "/sys/course/getStuCourses.do?",
			data: "param="+str,
			dataType: "json",
			async: false,
			beforeSend: function()
	    	{
	    		 
	    	},
	    	success: function (data)
	    	{
	    		$.messager.progress('close'); 
	    		 var giftTs = data.data;//学员已有课程 
	    		
	    		$.each(giftTs,function(i,gift)
	    		{
    			 	var giftTR=$("#addGift").clone();
					giftTR.css("display",'table-row');
					giftTR.attr("val","old");
					giftTR.find("td").each(function(n,node)
					{
						if(n==1)
						{
							$(node).html("<span>"+gift.giftType+"</span>");	
						}else
						if(n==3)
						{							
							$(node).html("<span>"+gift.giftId+"  "+gift.couponType+"   "+gift.giftCode+"</span>");
							
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
						}
					});
				
					$("#addGift").after(giftTR);
					var height = $(document).height();
					$('<%=name%>',parent.document).css("height",height+20);
				});
			} 
		});
	}
	
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
       	 	$("#totalAmount").textbox('setValue',n);
       		 var stageType=$("#stageId").combobox('getText');
       		 var urls="/sys/pubData/qryData.do?param={queryCode:\"Qry_Stage_Class\",stageId:\""+stageType+"\"}";
       	 	$("#classType").combobox({
        		url : urls,//返回json数据的url
        		valueField : "classType",
        		textField : "classType",
        		panelHeight : "auto",
        		onLoadSuccess : function ()
        		{ //数据加载完毕事件
                    var data = $('#classType').combobox('getData');
                    if (data.length > 0)
                    {
                        $("#classType").combobox('select', data[0].classType);
                    }
                }
        	});
       }  
	});