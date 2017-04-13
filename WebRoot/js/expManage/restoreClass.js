var resumeType =null;
var studentId =null;
var studentCourseId =null;
var excId =null;
$(document).ready(function(){
	$("#submitBtn").on("click",function(){
		restore();
	});
	$("#backBtn").on("click",function(){
		 window.history.back();
	});
	initPage();
});

function initPage() {
	var info =document.URL.split("=")[1];
	studentId =info.split(",")[0];
	studentCourseId =info.split(",")[1];
	excId =info.split(",")[2];
	var param = '{"excFlag":"Y","studentId":"'+studentId+'","studentCourseId":"'+studentCourseId+'","excId":"'+excId+'"}';
	$.ajax({
		type : "POST",
		url: "/sys/exception/qryInfo.do",
		data: "param="+param,
		async: false,
		dataType:"json",
		beforeSend: function() {
	    	$.messager.progress({title : '系统消息', msg : '正在加载数据，请稍等……'});
	    },
	    success: function(data) {
	    	$.messager.progress('close'); 
			if (data.studentInfo != undefined) {
				$("#name").html(data.studentInfo.name);
				$("#birthday").html(data.studentInfo.birthday);
				$("#sexVal").html(data.studentInfo.sexVal);
				$("#identityId").html(data.studentInfo.identityId);
				$("#byName").html(data.studentInfo.byName);
				$("#phone").html(data.studentInfo.phone);
				$("#schoolName").html(data.studentInfo.schoolName);
				if (data.excInfo != undefined) {
					$("#createDate").html(data.excInfo.createDate);
					$("#excState").html(data.excInfo.state);
					$("#excDays").html(data.excInfo.excDays + "天");
					$("#excHandler").html(data.excInfo.handler);
				}
			}
			if (data.courseInfo != undefined && data.courseInfo.length > 0) {
			    var contentStr = "";
				$.each(data.courseInfo, function(i, obj) {
					contentStr += "<tr><td>" + obj.stageId + "</td>";
					contentStr += "<td>" + obj.courseStateText + "</td>";
					contentStr += "<td>" + obj.paySchoolName + "</td>";
					contentStr += "<td>" + obj.payDate + "</td>";
					contentStr += "<td>" + obj.feeTypeText + "</td>";
					contentStr += "<td>" + obj.className + "</td>";
					contentStr += "<td>" + obj.startDate + "</td>";
					contentStr += "<td>" + obj.finishDate + "</td>";
					contentStr += "<td>" + obj.classProgress + "</td>";
					contentStr += "<td>" + obj.adviserName + "</td>";
					contentStr += "<td>" + obj.dutyAdvisterName + "</td>";
					contentStr += "<td>" + obj.carerName + "</td></tr>";
				});
				$("#classInfo").append(contentStr);
	    	}
	    },
	    error:function(){
	    	$.messager.progress('close'); 
	    }
	});
}

function restore() { 
	if (resumeType == null) {
		$.messager.alert('提示', "请选择复课方式");
		return false;
	}	
	var paramValue ='{"studentCourseId":"'+studentCourseId+'","studentId":"'+studentId+'","excId":"'+excId+'","resumeType":"'+resumeType+'","handlerId":"'+$("#handlerId").val()+'"}';
	$.messager.confirm("提示", "您确定要复课？", function (data) {
      	if (data) {
        	$.ajax({
				type : "POST",
				url: "/sys/exception/restoreClass.do",
				data:"param="+paramValue,
				async: true,
				beforeSend: function() {
		    		showProgressLoader("正在复课...",400);
		    	},
		    	success: function(result) {
		    		hideProgressLoader();
		    		if(result == "true") {
		    			if(resumeType == "001") {
		    				showMessage('提示', "原班复课成功！",function(){
		    					hideMessage();
		    					window.location.href = "expList.jsp";
		    				});
		    			} else if(resumeType == "002") {
		    				window.location.href = "/sys/changeClass/applyChangeClass.jsp?studentCourseId="+studentCourseId+"&changeSource=exception";
		    			} else if(resumeType == "003") {
							window.location.href = "/sys/changeSchool/applyChangeSchool.jsp?studentId="+studentId+"&changeSource=exception";
		    			}
		    		} else if(result == "false") {
		    			if(resumeType == "001") {
		    				showMessage('提示', "原班课程已结课，无法原班复课！",null);
		    			} else if(resumeType == "002") {
		    				showMessage('提示', "有待审批的转班申请单，无法转班复课！",null);
		    			} else if(resumeType == "003") {
		    				showMessage('提示', "有待审批的转校申请单，无法转班复课！",null);
		    			}
		    		}
		        },
		        error:function(result) {
		        	hideProgressLoader();
		        }
			});
        }
    });
}

function changeType(obj) {
	resumeType = $(obj).attr("resumeType");
}