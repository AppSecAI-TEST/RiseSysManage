var handlerId =null;
var currentYear =null;
var timeInfo =[];
var detailInfo=[];
var nowDate =new Date();
$(document).ready(function(){
	handlerId =$("#handlerId").val();
	initYearSelect();
	$("#submitBtn").click(function(){
		addResource();
	});
	$("#backBtn").click(function(){
		window.location.href="resourceList.jsp";
	});
});

function addResource()
{
	if(currentYear==null)
	{
		$.messager.alert("提示", "请选择年份");
		return false;
	}
	$(".addTr").each(function(){
		if($(this).attr("days")!="")
		{
			var timeObj={};
			timeObj.year =currentYear;
			timeObj.month=$(this).attr("month");
			timeObj.handlerId=handlerId;
			var dayArr =$(this).attr("days").split(",");
			if(dayArr.length>0)
			{
				for(var i=0;i<dayArr.length;i++)
				{
					var detailObj ={};
					detailObj.month=$(this).attr("month");
					detailObj.day =dayArr[i];
					detailObj.handlerId=handlerId;
					detailInfo.push(detailObj);
				}	
			}
			timeInfo.push(timeObj);
		}	
	});
	if(timeInfo.length>0&&detailInfo.length>0)
	{
		var addInfo={};
		addInfo.nowYear =nowDate.getFullYear();
		addInfo.nowMonth =nowDate.getMonth()+1;
		addInfo.year =currentYear;
		addInfo.timeInfo =timeInfo;
		addInfo.detailInfo =detailInfo;
		$.ajax( {
			type : "POST",
			url : "/sys/timeResource/addTimeResource.do",
			data :"param="+JSON.stringify(addInfo),
			async : false,
			beforeSend : function() {
				showProgressLoader("正在添加休假时间,请稍等...", 400);
			},
			success : function(data) {
				hideProgressLoader()
				if (data == "true") {
					showMessage('提示', "添加休假时间成功！", function() {
						window.location.href = "resourceList.jsp";
					});
				} else {
					showMessage('提示', "添加休假时间失败！", null);
				}
	
			},
			error : function() {
				hideProgressLoader();
				showMessage('提示', "调用添加休假时间服务失败！", null);
			}
		});
	}
	else
	{
		$.messager.alert("提示", "请添加至少一条休假记录");
		return false;
	}	
	
}

function initYearSelect()
{
	var data=[];
	var year =nowDate.getFullYear();
	for(var i=0;i<10;i++)
	{
		var soption ={};
		soption.val =(year+i);
		soption.text =soption.val;
		data.push(soption);
	}
	$("#year").combobox("loadData",data);
	$("#year").combobox({
		onChange:function(){
			clearAddTr();
		}
	});
}

function clearAddTr()
{
	$(".addTr").each(function(){
		$(this).attr("days","");
		$(this).find("td:eq(2)").html("");
		$(this).find("td:eq(1)").css("visibility","visible");
	});
	currentYear=$("#year").combobox("getValue");
	if(parseInt(currentYear)==nowDate.getFullYear())
	{
		var disNum =nowDate.getMonth()+1;
		for(var i=0;i<disNum;i++)
		{
			$(".addTr:eq("+i+")").find("td:eq(1)").css("visibility","hidden")
		}	
	}	
}


function toaddDays(obj)
{
	if(currentYear==null)
	{
		$.messager.alert("提示", "请选择年份");
		return false;
	}	
	var tr =$(obj).closest("tr");
	$('#dlg').dialog({
			title:currentYear+"年"+tr.attr("month")+"月休假日期",
	});
	$('#dlg').attr("src","/sys/timeResource/addDays.jsp?year="+currentYear+"&month="+tr.attr("month")+"&days="+tr.attr("days")+"&operate=A&schoolTimeId=");
	$('#dlg').dialog("open");
}

function closeDig()
{
	$('#dlg').attr("src","");
	$('#dlg').dialog("close");
}

function getMonthValue(flag,val)
{
	$(".addTr").each(function(){
		if($(this).attr("month")==flag)
		{
			$(this).attr("days",val);
			if(val!="")
			{
				var dateArr =val.split(",");
				val="";
				for(var i=0;i<dateArr.length;i++)
				{
					val+=flag+"月"+dateArr[i]+"号"+",";
				}
				if(val!="")
				{
					val=val.substring(0,val.length-1);
				}	
			}
			$(this).find("td:eq(2)").html("<span>"+val+"</span>");
			return false;
		}	
	});
	closeDig();
}