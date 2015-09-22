var studentId =null;
var studentCourseId =null;
var courseState =null;
$(document).ready(function(){
	$("#submitBtn").on("click",function(){
		if(trim($("#remark").val())=="")
		{
			$.messager.alert('提示', "请填写异常原因备注！");
			return false;
		}
		var paramValue ='{"studentCourseId":"'+studentCourseId+'","studentId":"'+studentId+'","excId":"","orignCourseState":"'+courseState+'","hours":"","excState":"001","remark":"'+trim($("#remark").val())+'","createDate":"","handlerId":"'+$("#handlerId").val()+'"}';
		$.messager.confirm('提示','您确定要添加该异常？',function(r) {
    			if(r) 
    			{
    				$.post('/sys/exception/addInfo.do', {param:paramValue}, function(result) 
    				{
	    				if(result=="true") 
	    				{
	    					$.messager.alert('提示', "添加异常成功");
	    				}
	    				else 
	    				{
	    					$.messager.alert('提示', "添加异常失败");
	    				}
    				});
    			}
    	});
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
	courseState =info.split(",")[2];
	var param = '{"excFlag":"N","studentId":"'+studentId+'"}';
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
	    				contentStr +="<td></td>";//开课日期
	    				contentStr +="<td></td>";//结课日期
	    				contentStr +="<td></td>";//课程进度
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