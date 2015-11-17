var resumeType =null;
var studentId =null;
var studentCourseId =null;
$(document).ready(function(){
	$("#submitBtn").on("click",function(){
		restore();
	});
	$("#backBtn").on("click",function(){
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
	    				$("#excId").val(data.excInfo.excId);
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

function restore()
{ 
	if(resumeType==null)
	{
		$.messager.alert('提示', "请选择复课方式");
		return false;
	}	
	var paramValue ='{"studentCourseId":"'+studentCourseId+'","studentId":"'+studentId+'","excId":"'+$("#excId").val()+'","resumeType":"'+resumeType+'","handlerId":"'+$("#handlerId").val()+'"}';
	$.messager.confirm('提示','您确定要复课？',function(r) {
	    if(r) 
	    {
	    	$.post('/sys/exception/restoreClass.do', {param:paramValue}, function(result) 
	    	{
	    		if(resumeType=="001")
	    		{
	    			if(result=="true") 
		    		{
			    		$.messager.alert('提示', "原班复课成功");
			    		setTimeout(function(){window.location.href="expList.jsp"},1000);
			    	}
			    	else  if(result=="finished")
			    	{
			    		$.messager.alert('提示', "原班课程已结课，无法原班复课！");
			    	}
	    			else
	    			{
	    				$.messager.alert('提示', "原班复课失败");
	    			}	
	    		}
	    		else if(resumeType=="002")
	    		{
	    			if(result=="true") 
		    		{
			    		//跳转
			    	}
			    	else if(result=="exist")
			    	{
			    		$.messager.alert('提示', "已经存在转班复课的申请单");
			    	}
	    			else
	    			{
	    				$.messager.alert('提示', "转班复课失败");
	    			}	
	    		}
	    		else if(resumeType=="003")
	    		{
	    			if(result=="true") 
		    		{
			    		//跳转
			    	}
			    	else if(result=="exist")
			    	{
			    		$.messager.alert('提示', "已经存在转校复课的申请单");
			    	}
	    			else
	    			{
	    				$.messager.alert('提示', "转校复课失败");
	    			}	
	    		}	
	    	});
	    }
    });
}

function changeType(obj)
{
	resumeType =$(obj).attr("resumeType");
}