$(document).ready(function(){
	//首页面查询
    $("#qryBtn").click(function() {
    	var json = $("#qryFm").serializeObject();
//    	json.byName = $("#byName").combobox('getText');
//    	var pay = json.pay;
//    	if(pay == "Y"){
//    		json.reparation = "1";
//    	}
//    	if(pay == "N"){
//    		json.noreparation = "1";
//    	}
		var obj = JSON.stringify(json);
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
    });
	
   $(".meeting").change(function() {
	   var val = $(this).val();
	   if(val == "Y"){
		   $(this).siblings(".meetingCsi").css("visibility","visible");
	   }else if(val == "N"){
		   $(this).siblings(".meetingCsi").css("visibility","hidden");
	   }
   });
   
    $(".open").change(function() {
	   var val = $(this).val();
	   if(val == "Y"){
		   $(this).siblings(".openCsi").css("visibility","visible");
	   }else if(val == "N"){
		   $(this).siblings(".openCsi").css("visibility","hidden");
	   }
   });
   
   $(".grad").change(function() {
	   var val = $(this).val();
	   if(val == "Y"){
		   $(this).siblings(".gradCsi").css("visibility","visible");
	   }else if(val == "N"){
		   $(this).siblings(".gradCsi").css("visibility","hidden");
	   }
   });
    
});

//跳转新增教质反馈页面
function addTeaFeedBack(){
	if(validateSelect("list_data")) {
		var row = $("#list_data").datagrid('getSelected');
		var classInstId = row.classInstId;
		var reflect = row.reflect;
		var qualityId = row.qualityId;
		var schoolId = row.schoolId;
		var className = row.className;
		var month = row.month;
		if(reflect == "是"){
			 $.messager.alert('提示', "该教质已经反馈！");
			   return;
		}
		window.location.href = "/sys/teaFeebackManage/qryClassStuByInstId.do?classInstId="+classInstId+"&qualityId="+qualityId+"&schoolId="+schoolId+"&className="+className+"&month="+month;
	}
}

//新增教质反馈提交
function addTeaFeedbackSubmit()
{
	var qualityId = $("#qualityId").val();
	var classInstId = $("#classInstId").val();
	var className = $("#className").val();
	var schoolId = $("#schoolId").val();
	var month = $("#month").val();
	var handlerId = $("#handlerId").val();
	var feedback = {};
	feedback.qualityId = qualityId;
	feedback.schoolId = schoolId;
	feedback.classInstId = classInstId;
	feedback.className = className;
	feedback.handlerId = handlerId;
	var feedbackDetailArray = new Array();
	var flag = true;
	$("input[name='studentId']").each(function(i,node){
	   var studentId = $("#studentId"+i+"").val();
	   var courseState = $("#courseState"+i+"").val();
	   var studentName = $("#studentName"+i+"").html();
	   var byname = $("#byname"+i+"").html();
	   var teachingNum = $("#teachingNum"+i+"").numberbox('getValue');
	   var meetingIsAttend = $("input[name='meetingIsAttend"+i+"']:checked").val();
	   var openIsAttend = $("input[name='openIsAttend"+i+"']:checked").val();
	   var gradIsAttend = $("input[name='gradIsAttend"+i+"']:checked").val();
	   var feedbackDetail = {};
	   feedbackDetail.classInstId = classInstId;
	   feedbackDetail.schoolId = schoolId;
	   feedbackDetail.month = month;
	   feedbackDetail.studentId = studentId;
	   feedbackDetail.studentName = studentName;
	   feedbackDetail.byname = byname;
	   feedbackDetail.courseType = courseState;
	   if(teachingNum == "" || teachingNum == undefined){
		   teachingNum = "0";
	   }
	   feedbackDetail.teachingNum = teachingNum;
	   feedbackDetail.meetingIsAttend = meetingIsAttend;
	   if(meetingIsAttend == "Y"){
		   var meetingCsi = $("#meetingCsi"+i+"").numberbox('getValue');
		   if(meetingCsi == "" || meetingCsi == undefined){
			   $.messager.alert('提示', "已到请填写家长会满意度！");
			   flag = false;
			   return false;
		   }
		   meetingCsi = string2Json(meetingCsi);
		   meetingCsi = encodeURI(meetingCsi);
		   feedbackDetail.meetingCsi = meetingCsi;
	   }
	   feedbackDetail.openIsAttend = openIsAttend;
	   if(openIsAttend == "Y"){
		   var openCsi = $("#openCsi"+i+"").numberbox('getValue');
		   if(openCsi == "" || openCsi == undefined){
			   $.messager.alert('提示', "已到请填写公开课满意度！");
			   flag = false;
			   return false;
		   }
		   openCsi = string2Json(openCsi);
		   openCsi = encodeURI(openCsi);
		   feedbackDetail.openCsi = openCsi;
	   }
	   feedbackDetail.gradIsAttend = gradIsAttend;
	   if(gradIsAttend == "Y"){
		   var gradCsi = $("#gradCsi"+i+"").numberbox('getValue');
		   if(gradCsi == "" || gradCsi == undefined){
			   $.messager.alert('提示', "已到请填写毕业典礼满意度！");
			   flag = false;
			   return false;
		   }
		   gradCsi = string2Json(gradCsi);
		   gradCsi = encodeURI(gradCsi);
		   feedbackDetail.gradCsi = gradCsi;
	   }
	   feedbackDetail.handlerId = handlerId;
	   feedbackDetailArray.push(feedbackDetail);
	});
	if(flag){
		alert(JSON.stringify(feedback));
		alert(JSON.stringify(feedbackDetailArray));
		$.ajax({
			type : "POST",
			url: "/sys/teaFeebackManage/addTeachingFeedback.do",
			data: "feedbackJson="+JSON.stringify(feedback)+"&feedbackDetailJson="+JSON.stringify(feedbackDetailArray),
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title : '新增反馈维护', msg : '新增反馈维护中，请稍等……'});
	    	},
	    	success: function(flag) {
	    		$.messager.progress('close'); 
	    		if(flag == "true"){
	    			$.messager.alert('提示', "新增反馈维护成功！","info",function(){
		    			window.location.href = "/sys/teaFeebackManage/teaFeebackManage.jsp";
					});
	    		}else if(flag == "false"){
	    			$.messager.alert('提示', "新增反馈维护失败！");
	    		}
	        } 
		});
	}
}

//浏览教质反馈
function viewTeaFeedBack(){
	if(validateSelect("list_data")) {
		var row = $("#list_data").datagrid('getSelected');
		var feedbackId = row.feedbackId;
		var reflect = row.reflect;
		if(reflect == "否"){
			 $.messager.alert('提示', "该教质还未反馈，不能浏览！");
			   return;
		}
		window.location.href = "/sys/teaFeebackManage/viewTeachingFeedback.do?feedbackId="+feedbackId;
	}
}

function validateSelect(object)
{
	var flag = false;
	var obj = $("#"+object+"").datagrid('getSelections');
	if(obj.length > 0) {
		if(obj.length > 1) {
			$.messager.alert('提示', "只能选择一个教质计划操作！");
		} else {
			flag = true;
		}
	} else {
		$.messager.alert('提示', "请先选择您要操作的教质计划！");
	}
	return flag;
}