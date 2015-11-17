$(document).ready(function(){
	$("#backBtn").click(function(){
		window.history.back();
	});
	initPage();
});


function initPage()
{
	var info =document.URL.split("=")[1];
	studentId =info.split(",")[0];
	studentCourseId =info.split(",")[1];
	var param = '{"excFlag":"Y","studentId":"'+studentId+'","studentCourseId":"'+studentCourseId+'"}';
	$.ajax({
			type : "POST",
			url: "/sys/exception/qryInfo.do",
			data: "param="+param,
			async: false,
			dataType:"json",
			beforeSend: function()
	    	{
	    		$.messager.progress({title : '系统消息', msg : '正在加载数据，请稍等……'});
	    	},
	    	success: function(data) {
	    		$.messager.progress('close'); 
	    		if(data.studentInfo!=undefined)
	    		{
	    			$("#name").html(data.studentInfo.name);
	    			$("#birthday").html(data.studentInfo.birthday);
	    			$("#sexVal").html(data.studentInfo.sexVal);
	    			$("#identityId").html(data.studentInfo.identityId);
	    			$("#byName").html(data.studentInfo.byName);
	    			$("#phone").html(data.studentInfo.phone);
	    			$("#schoolName").html(data.studentInfo.schoolName);
	    			if(data.excInfo!=undefined)
	    			{
	    				$("#createDate").html(data.excInfo.createDate);
	    				$("#excState").html(data.excInfo.state);
	    				$("#excDays").html(data.excInfo.excDays+"天");
	    				$("#excHandler").html(data.excInfo.handler);
	    				$("#remark").html(data.excInfo.remark);
	    			}	
	    		}
	    		if(data.courseInfo!=undefined&&data.courseInfo.length>0)
	    		{
	    			var contentStr ="";
	    			$.each(data.courseInfo,function(i,obj){
	    				contentStr +="<tr><td>"+obj.courseName+"</td>";
	    				contentStr +="<td>"+obj.courseState+"</td>";
	    				contentStr +="<td>"+obj.schoolName+"</td>";
	    				contentStr +="<td>"+obj.payDate+"</td>";
	    				contentStr +="<td>"+obj.feeType+"</td>";
	    				contentStr +="<td>"+obj.className+"</td>";
	    				contentStr +="<td>"+obj.startTime+"</td>";//开课日期
	    				contentStr +="<td>"+obj.finishTime+"</td>";//结课日期
	    				contentStr +="<td>"+obj.classProgress+"</td>";//课程进度
	    				contentStr +="<td>"+obj.adviser+"</td>";
	    				contentStr +="<td>"+obj.dutyAdvister+"</td>";
	    				contentStr +="<td>"+obj.carer+"</td></tr>";
	    			});
	    			$("#classInfo").append(contentStr);
	    		}
	        },
	        error:function(){
	        	$.messager.progress('close'); 
	        }
	    	
	});
}