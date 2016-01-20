
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
	
function initPayDate()
{
	$('#payDate').datebox().datebox('calendar').calendar(
	{
		validator: function(date)
		{
			var now = new Date();
			var d1 = new Date(now.getFullYear(), now.getMonth(), now.getDate()-30);
			var d2 = new Date(now.getFullYear(), now.getMonth(), now.getDate());
			return d1<=date && date<=d2;
		}
	});
} 


function getOldCourse() 
{
	var courses;
	var stu = {};
	stu.studentId = $("#studentId").val();
	stu.queryCode = 'Qry_Student_Courses';
	var str = JSON.stringify(stu);
	$.ajax( {
		url : "/sys/course/getStuCourses.do?",
		data : "param=" + str,
		dataType : "json",
		async : false,
		success : function(data)
		{
		 courses= data.data;//学员已有课程
		}
	});
	return courses;
}
 


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
    		
    	},
    	success: function (data)
    	{
    		$.messager.progress('close'); 
    		 var giftTs = data.data;//学员已有课程 
    		
    		$.each(giftTs,function(i,gift)
    		{
    			if(gift==null)return;
				var giftTR;
    			if(gift.giftType=="GOODS" || gift.parentType=="COUPON" || gift.giftType=="TEXTBOOK")
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
							}else if(gift.giftType=="TEXTBOOK")
							{
								$(node).html("<span>教材赠品</span>");	
							}
						}else if(n==3)
						{	
							if(gift.giftType=="GOODS" || gift.giftType=="TEXTBOOK")
							{
								 $(node).html("<span>"+gift.giftName+"</span>");	
							} 
							else
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
							 if(gift.isGet=='Y')
							{
								 giftFlag=true;
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
							
							 if(gift.giftState!='UNSUED')
							{
								$(node).html("<span>已使用</span>");	
							}else
							{
								$(node).html("<span>未使用</span>");	
							}
						}else if(i==6)
						{
							$(node).html("<span>"+gift.effDate+"</span>");	
						}else if(i==7)
						{
							$(node).html("<span>"+gift.expDate+"</span>");	
						} else if(i==9)
						{
							 if(gift.giftState!='UNSUED')
							{
								  giftFlag=true;
								$(node).html("");	
							} 
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



//删除相对应的行  
function delGiftCourse(rows)
{
	$(rows).parent("td").parent("tr").remove();
	giftCourseNum--;
}

//删除相对应的行  
function delRow(rows)
{
	$(rows).parent("td").parent("tr").remove();
}


function initDate()
{
	var curr_time = new Date();
	$('#createEndTime').datebox('setValue', myformatter(curr_time));
	curr_time.setMonth(curr_time.getMonth() - 1);
	$('#createStartTime').datebox('setValue', myformatter(curr_time));
}

 