$(document).ready(function(){
	//首页面查询
    $("#qryBtn").click(function() {
    	var schoolId = $("#schoolId").combobox("getValue");
	    if(schoolId != ""){
	    	var json = $("#qryFm").serializeObject();
			var feedback = json.feedback;
	    	if(feedback == "Y"){
	    		json.yesfeedback = "1";
	    	}
	    	if(feedback == "N"){
	    		json.nofeedback = "1";
	    	}
	    	var month = $("#time").datebox('getValue');
			var obj = JSON.stringify(json);
			obj = obj.substring(0, obj.length - 1);
			var funcNodeId = $("#qryBtn").attr("funcNodeId");
			obj += ",\"month\":\""+month+"\",\"funcNodeId\":\""+funcNodeId+"\"}";
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
	    }else{
			showMessage("提示","没有有效的校区可供查询",null);
		}
    });
	
    //首页面重置
    $("#resetBtn").click(function() 
    {
    	$("#qryFm").form('clear');//清空窗体数据  
    	//校区赋默认值
    	if($("#schoolId").combobox("getData").length>0){
    		$("#schoolId").combobox("select",$("#schoolId").combobox("getData")[0].schoolId);
    	}
    });
    
    var staffId = $("#staffId").val();
	$("#schoolId").combobox({
		url : "/sys/pub/pageCategory.do?staffId="+staffId+"&resourceId=512&fieldId=schoolId&headFlag=N",//返回json数据的url
		valueField : "schoolId",
		textField : "schoolName",
		panelHeight : "auto",
		formatter : formatSchool,
		onLoadSuccess : function(data) {
			$("#schoolId").combobox('setValue',data[0].schoolId);
		},
		onChange : function(n, o) {
			if(n != "" && n != null && n != undefined) {
//				$("#classInstId").combobox({disabled: false});
				$("#classInstId").combobox({
					url : "/sys/pubData/qryClassInstList.do?schoolId="+n+"&courseType=&stageId=&classType=&classState='003','004'&classInstId=",//返回json数据的url
					valueField : "classInstId",
					textField : "className",
					panelHeight : "auto",
					formatter : function(data) {
						return "<span>" + data.className + "</span>";
					}
				});
				$("#teacherId").combobox({
					url : "/sys/pubData/qryData.do?param={'queryCode':'qryClassTeacherInfo','schoolId':'"+n+"'}",//返回json数据的url
					valueField : "teacherId",
					textField : "byname",
					panelHeight : "auto",
					formatter : function(data) {
						return "<span>" + data.byname + "</span>";
					}
				});
			} else {
				$("#schoolId").combobox("setText", "");
				$("#classInstId").combobox('clear');
				$("#classInstId").combobox("loadData", new Array());
				$("#teacherId").combobox('clear');
				$("#teacherId").combobox("loadData", new Array());
//				$("#classInstId").combobox({disabled: true});
			}
		}
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
	var schoolId = $("#fSchoolId").val();
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