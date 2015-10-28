var year =null;
var month =null;
var days =null;
var operate =null;
var schoolTimeId =null;
var monthArray=['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
$(document).ready(function(){
	year =$("#year").val();
	month =$("#month").val();
	days =$("#days").val();
	operate =$("#operate").val();
	schoolTimeId =$("#schoolTimeId").val();
	$("#submitBtn").click(function(){
		if(operate=="A")
		{
			addDays();
		}
		else if(operate=="U")
		{
			updateDays();
		}	
	});
	$("#backBtn").click(function(){
		parent.closeDig();
	});
	initPage();
});

function initPage()
{
	$("#showDiv").calendar({
		width:"700px",
		height:"300px",
		year:parseInt(year),
		month:parseInt(month),
		months:[monthArray[parseInt(month-1)]],
	});
	$("#showDiv").unbind();
	$(".calendar-day").bind("click",function(){
		if($(this).hasClass("calendar-selected"))
		{
			$(this).removeClass("calendar-selected");
		}
		else
		{
			$(this).addClass("calendar-selected");
		}	
	});
	if(days!="")
	{
		var dayArr=days.split(",");
		$(".calendar-day").each(function(){
			for(var i =dayArr.length-1;i>=0;i--)
			{
				if($(this).text()==dayArr[i])
				{
					$(this).addClass("calendar-selected");
				}	
			}	
		});
		
			
	}	
}


function addDays()
{
	var dayValue="";
	$(".calendar-selected").each(function(){
		if($(this).attr("abbr").split(",")[1]==month)
		{
			dayValue+=$(this).text()+",";
		}	
	})
	if(dayValue!="")
	{
		dayValue=dayValue.substring(0,dayValue.length-1);
	}
	parent.getMonthValue(month,dayValue);
}

function updateDays()
{
	var dayValue="";
	$(".calendar-selected").each(function(){
		if($(this).attr("abbr").split(",")[1]==month)
		{
			dayValue+=$(this).text()+",";
		}	
	})
	if(dayValue!="")
	{
		dayValue=dayValue.substring(0,dayValue.length-1);
	}
	if(dayValue==days)
	{
		parent.showMessage("提示","您没有做任何修改",null);
		return false;
	}	
	parent.updateDays(year,month,dayValue,schoolTimeId);
}