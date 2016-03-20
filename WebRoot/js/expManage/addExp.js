var studentId = null;
var studentCourseId = null;
var courseState = "";
var teacherName = "";
var stageLevel = "";
var className = "";
var classProgress = "";
var classInstId = "";
var funcNodeId = "";
var channel = "";
$(document).ready(function(){
	initPage();
	$("#submitBtn").on("click", function() {
		if (trim($("#remark").val()) == "") {
			$.messager.alert('提示', "请填写异常原因备注！");
			return false;
		}
		var paramValue = '{"stageLevel":"' + stageLevel
			+ '","orignClassId":"' + classInstId
			+ '","orignClassName":"' + className
			+ '","studentCourseId":"' + studentCourseId
			+ '","studentId":"' + studentId
			+ '","excId":"","orignCourseState":"'
			+ courseState + '","teacherName":"'
			+ teacherName + '","hours":"' + classProgress
			+ '","excState":"001","remark":"'
			+ trim($("#remark").val()) + '","handlerId":"'
			+ $("#handlerId").val() + '"}';
		$.messager.confirm('提示', '您确定要添加该异常？', function(r) {
			if (r) {
				$.post('/sys/exception/addInfo.do', {param : paramValue}, function(result) {
					if (result == "true") {
						showMessage('提示', "添加异常成功", function() {back();});
					} else {
						$.messager.alert('提示', "添加异常失败");
					}
				});
			}
		});
	});
	$("#backBtn").on("click",function(){
		 window.history.back();
	});
});

function back() {
	if("attend" == channel) {
		window.location.href = "/sys/attendClass/qryAttendClass.do?classInstId="+classInstId+"&type=maintenance&funcNodeId="+funcNodeId;
	} else {
		window.location.href = "expList.jsp"
	}
}

function initPage()
{
	var info = document.URL.split("=")[1];
	studentId = info.split(",")[0];
	studentCourseId = info.split(",")[1];
	courseState = info.split(",")[2];
	classProgress = getFormatStr(replaceAdd(info.split(",")[3]));
	stageLevel = getFormatStr(info.split(",")[4]);
	className = getFormatStr(info.split(",")[5]);
	teacherName = getFormatStr(info.split(",")[6]);
	classInstId = getFormatStr(info.split(",")[7]);
	funcNodeId = getFormatStr(info.split(",")[8]);
	channel = getFormatStr(info.split(",")[9]);
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
	    				contentStr +="<tr><td>"+obj.stageId+"</td>";
	    				contentStr +="<td>"+obj.courseStateText+"</td>";
	    				contentStr +="<td>"+obj.paySchoolName+"</td>";
	    				contentStr +="<td>"+obj.payDate+"</td>";
	    				contentStr +="<td>"+obj.feeTypeText+"</td>";
	    				contentStr +="<td>"+obj.className+"</td>";
	    				contentStr +="<td>"+obj.startDate+"</td>";
	    				contentStr +="<td>"+obj.finishDate+"</td>";
	    				contentStr +="<td>"+obj.classProgress+"</td>";
	    				contentStr +="<td>"+obj.adviserName+"</td>";
	    				contentStr +="<td>"+obj.dutyAdvisterName+"</td>";
	    				contentStr +="<td>"+obj.carerName+"</td></tr>";
	    			});
	    			$("#classInfo").append(contentStr);
	    		}
	        },
	        error:function(){
	        	$.messager.progress('close'); 
	        }
	    	
	});
}

function replaceAdd(s)
{
	var newstr = "";
	if(s.length > 0)
	{
		for (var i=0; i<s.length; i++) 
		{
			c = s.charAt(i); 
			if(c=="+")
			{
				newstr+="%2B";
			}
			else
			{
				newstr+=c;
			}	
		}
	}
   return newstr; 
}