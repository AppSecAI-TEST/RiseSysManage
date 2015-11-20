$(document).ready(function()
{
	$("#single").click(function(){
		addSingleCourse();
	});
	$("#multiple").click(function(){
		addMultipleCourse();
	});
	$("#backBt").click(function(){
		window.location.href="qryCourseInfo.jsp";
	});
	$("#qryBtn").click(function() {
    	qry();
    });
	
//增加赠品
$("#addGiftBtn").click(function ()
{
		var giftModelTR=$("#giftModelTR").clone();
		var flag=true;
		var giftTR=$("#addGift").clone();
		giftTR.css("display",'table-row');
		giftTR.attr("val","gift");
		giftTR.find("td").each(function(n,node)
		{
			var parentType=$("#parentType").combobox('getValue');
			var giftEffDate=$("#giftEffDate").textbox('getValue');
			if(n==1)//赠品类型;	
			{
				var name=$("#parentType").combobox('getText');
				if(name=='')
				{
					$.messager.alert('提示', "请选择赠品类型!");
					flag=false;
					return false;
				}
				$(node).html("<span>"+name+"</span>");	
				$(node).attr("parentType",parentType);
			}else if(n==3)//赠品名称;劵类ID
			{
				var giftId=$("#giftId").combobox('getValue');
				var giftName=$("#giftId").combobox('getText');
			 
				var giftType=$("#giftType").combobox("getText");
				var giftTypeVal=$("#giftType").combobox('getValue');
				
				var code=$("#giftCode").textbox('getValue');
				
				//判断是否是券类
				if(giftId=='')
				{
					$.messager.alert('提示', "请选择赠品名称");
					flag=false;
					return false;
				}
				
				//判断是否是券类
				if(parentType=='COUPON' && code=='')
				{
					$.messager.alert('提示', "请输入券类编码");
					flag=false;
					return false;
				}
			
				if(''!=code)
				{
						$(node).html("<span>"+giftType+"  "+giftName+"   "+ code +"   "+giftEffDate+"</span>");	
				}else
				{
					$(node).html("<span>"+giftName+"</span>");	
				}
				
				var datas = $('#giftType').combobox('getData');
				 
				for(var m=0;m<datas.length;m++)
				{
					if(giftTypeVal==datas[m].giftType)
					{
						 $(node).attr("effNum",datas[m].effNum);
						 $(node).attr("unit",datas[m].unit);
					}
				}
				
				var amount=""; 
				var data = $('#giftId').combobox('getData');
                if (data.length > 0)
                {
                    for(var i=0;i<data.length;i++)
                    {
                    	var giftIdT=data[i].giftId;
                    	if(giftIdT==giftId)
                    	{
                    		giftTypeVal=data[i].giftType;
                    		amount=data[i].amount;
                    	}
                    }
                }
				 
				$(node).attr("giftName",giftName);
				$(node).attr("amount",amount);
				$(node).attr("giftId",giftId);
				$(node).attr("giftType",giftTypeVal);
				$(node).attr("giftCode",code);
				$(node).attr("effDate",giftEffDate);
				
			}else if(n==5)
			{
				var getFlag = $("input[name='isGetY']:checked").val(); //是否领取
				$(node).attr("isGet","N");
				if('Y'==getFlag)
				{
					if(giftEffDate=='' &&　parentType=='COUPON')
					{
						flag=false;
						$.messager.alert('提示', "请填写有效期");
						return false;
					}
					$(node).html("<span>已领取</span>");	
					$(node).attr("isGet","Y");
				}else if('N'==getFlag)
				{
					$(node).html("<span>未领取</span>");	
					$(node).attr("isGet","N");
				}
				else
				{
					 $.messager.alert('提示', "请选择已领或者未领");
					  flag=false;
					  return false;
				}
			}else if(n==7)
			{
				var granter=$("#granter").textbox("getValue");
				if(''==granter)
				{
					 $.messager.alert('提示', "发放人为空");
					  flag=false;
					  return false;
				}
				$(node).html("<span>"+granter+"</span>");	
				$(node).attr("granter",granter);
			} 
			
		});
	
		if(flag)
		{
			$("#giftFm").form('clear');
			$("#addGift").after(giftTR);
			var height = $(document).height();
			var frameName=$("#frameName").val();
			$(frameName,parent.document).css("height",height);
			clearData("giftModelTR");
			$("input[name='isGetY'][value='Y']").attr("checked", "checked");
	    }
		
	
	
	});

//增加课程
$("#addCourse").click(function()
{
	var objectTr = $("#add").clone();//克隆模板
		objectTr.css("display", 'table-row');
		objectTr.attr("val", "course");
		var flag=true;
		objectTr.find("td").each(function(i, node) {
			var effDate = "";
			if (i == 0) {
				$(node).html("<span>" + (i ++) + "</span>");
				
			} else if (i == 1) {
				var name = $("#giftCourseType").combobox('getText');
				var val = $("#giftCourseType").combobox('getValue');

				var datas = $('#giftCourseType').combobox('getData');

				for ( var m = 0; m < datas.length; m++) 
				{
					if (val == datas[m].giftType) {
						$(node).attr("effNum", datas[m].effNum);
						$(node).attr("unit", datas[m].unit);
					}
				}
				if(name=='')
				{
					$.messager.alert('提示', "请选择赠课类型");
					flag=false;
					return false;
				}
				$(node).html("<span>" + name + "</span>");
				$(node).attr("giftCourseType", val);//赠课类型	
			} else if (i == 2) {
				var name = $("#giftCourseId").combobox('getText');
				var val = $("#giftCourseId").combobox('getValue');
				$(node).html("<span>" + name + "</span>");
				$(node).attr("giftId", val);//赠课细类	
				if(name=='')
				{
					$.messager.alert('提示', "请选择赠课名称");
					flag=false;
					return false;
				}
				
			} else if (i == 3) {
				var hours = $("#courseHours").html();
				$(node).html("<span>" + hours + "</span>");
				$(node).attr("hours", hours);//课时
			} else if (i == 4) {
				$(node).html("<span>" + sysDate() + "</span>");
			} else if (i == 5) {
				$(node).html("<span>未使用</span>");
			} else if (i == 6) {
				$(node).html("<span>" + afterDate(1) + "</span>");
			} else if (i == 7) {
				$(node).html("<span>" + afterYear(1) + "</span>");
			}
		});
		if(flag==true)
		{
			$("#add").after(objectTr);
			clearData("giftCourseTr");
			$("#courseHours").html("");
		}
			
		
	});

	
})
 

function addSingleCourse()
{
	if(validateSelect("list_data")) 
	{
		var row = $('#list_data').datagrid('getSelected');
    	var studentId = row.studentId;
    	var schoolId = row.schoolId;
    	var studentInfo =row.name+";;"+row.byName+";;"+row.birthday+";;"+row.identityId+";;"+row.sexVal;
    	window.location.href="addCourse.jsp?schoolId="+schoolId+"&studentId="+studentId+"&studentInfo="+studentInfo;
	}
}

function addMultipleCourse()
{
	if(validateSelect("list_data")) 
	{
		var row = $('#list_data').datagrid('getSelected');
    	var studentId = row.studentId;
    	var schoolId = row.schoolId;
    	var studentInfo =row.name+";;"+row.byName+";;"+row.birthday+";;"+row.identityId+";;"+row.sexVal;
    	window.location.href="link.jsp?schoolId="+schoolId+"&studentId="+studentId+"&studentInfo="+studentInfo;
	}
}

function validateSelect(object)
{
	var flag = false;
	var obj = $("#"+object+"").datagrid('getSelections');
	if(obj.length > 0) {
		if(obj.length > 1) {
			$.messager.alert('提示', "只能选择一个学员进行操作！");
		} else {
			flag = true;
		}
	} else {
		$.messager.alert('提示', "请先选择您要操作的学员！");
	}
	return flag;
}

function initDate()
{
	var curr_time = new Date();
	$('#createEndTime').datebox('setValue', myformatter(curr_time));
	curr_time.setMonth(curr_time.getMonth() - 1);
	$('#createStartTime').datebox('setValue', myformatter(curr_time));
}

function qry()
{
	var obj = JSON.stringify($("#qryFm").serializeObject());
    	obj = obj.substring(0, obj.length - 1);
    	var funcNodeId = $("#qryBtn").attr("funcNodeId");
    	obj += ",\"funcNodeId\":\""+funcNodeId+"\"}";
    	$('#list_data').datagrid({
    		url : "/sys/pubData/qryDataListByPage.do",
    		queryParams:{
    			param : obj
    		},
    		onLoadSuccess:function(){
    			//一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题。
    			$('#list_data').datagrid('clearSelections');
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
 
$(function()
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
						} else if(i==9)
						{
							$(node).html("");	
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
function delRow(rows)
{
	$(rows).parent("td").parent("tr").remove();
}

 