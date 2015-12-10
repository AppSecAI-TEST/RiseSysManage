$(document).ready(function(){
	//首页面查询
    $("#qryBtn").click(function() {
    	var funcNodeId = $("#qryBtn").attr("funcNodeId");
	    var startTime= $("#startTime").datebox('getValue');
	    var endTime= $("#endTime").datebox('getValue');;
	    if(startTime=='')
	    {
	    	startTime='2014-01-01';
	    }else
	    {
	    	startTime=startTime+"-01";
	    }
	    if(endTime=='')
	    {
	    	endTime='2036-01-01';
	    }else
	    {
	    	endTime=endTime+"-01";
	    }
	    var obj={};
	    obj.funcNodeId=funcNodeId;
	    obj.startTime=startTime;
	    obj.endTime=endTime;
	    obj.schoolId=$("#schoolId").combobox('getValue');
	    var json=JSON.stringify(obj);
		$('#list_data').datagrid({
			url : "/sys/pubData/qryDataListByPage.do",
			queryParams:{
				param : json
			},
			onLoadSuccess:function(){
				//一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题。
				$('#list_data').datagrid('clearSelections');
			}
		});
    });
	
});

//跳转创建教质计划页面
function addPlan(){
	window.location.href = "/sys/teaPlanManage/addTeacherPlan.jsp";
}

//查询校区下面所有有效状态班级
function createPlan(schoolId)
{
	$.ajax({
		type : "POST",
		url: "/sys/teaPlanManage/qryClassInfoById.do",
		data: "schoolId="+schoolId,
		dataType: "json",
		async: false,
		beforeSend: function()
    	{
    		$.messager.progress({title : '创建教质计划', msg : '正在查询班级信息，请稍等……'});
    	},
    	success: function(data) {
    		$.messager.progress('close'); 
    		$("#planTab").find('tr').each(function(i,node)
			{
				if(i > 0){
					$(node).remove();
				}
			});
    		var classList = data.classInfo;
    		if(classList != null && classList != undefined){
    			var length = classList.length;
    			if(length > 0){
    				var content = "";
    				for(var i = 0; i < length; i++) {
    					content += "<tr><td id='classInstId"+i+"' class='classInfo' instId='"+classList[i].classInstId+"' align='center'>"+classList[i].className+"</td><td align='center'><input id='teachingDate"+i+"' class='view' style='width:120px;' /></td><td align='center'><input id='meetingDate"+i+"' class='view' style='width:120px;' /></td>";
    					content += "<td align='center'><input id='openClassDate"+i+"' class='view' style='width:120px;' /></td><td align='center'><input id='gradDate"+i+"' class='view' style='width:120px;' /></td></tr>";
    				}
    				$("#planTr").after(content);
					$(".view").datebox({}); 
    			}
    		}
    	
        } 
	});
}

//创建教质计划提交
function addPlanSubmit()
{
	var	time=$("#time").datebox('getValue');
	if(time=="")
	{
		$.messager.alert("提示","请选择教质月份");
		return;
	}
	var schoolId = $("#schoolId").combobox('getValue');
	if(schoolId=="")
	{
		$.messager.alert("提示","请选择校区");
		return;
	}
	var handlerId = $("#handlerId").val();
	var createQuality = {};
	createQuality.schoolId = schoolId;
	createQuality.handlerId = handlerId;
	createQuality.month = time;
	var teachingQualityArray = new Array();
	$(".classInfo").each(function(i,node){
	   var classInstId = $(node).attr("instId");
	   var className=$(node).html();
	   var teachingDate = $("#teachingDate"+i+"").datebox('getValue');
	   var meetingDate = $("#meetingDate"+i+"").datebox('getValue');
	   var openClassDate = $("#openClassDate"+i+"").datebox('getValue');
	   var gradDate = $("#gradDate"+i+"").datebox('getValue');
	   var teachingQuality = {};
	   teachingQuality.schoolId = schoolId;
	   teachingQuality.month = time;
	   teachingQuality.classInstId = classInstId;
	   teachingQuality.className = className;
	   teachingQuality.teachingDate = teachingDate;
	   teachingQuality.meetingDate = meetingDate;
	   teachingQuality.openClassDate = openClassDate;
	   teachingQuality.gradDate = gradDate;
	   teachingQuality.handlerId = handlerId;
	   teachingQualityArray.push(teachingQuality);
	});
	if(teachingQualityArray.length == 0){
		$.messager.alert('提示', "该校区没有适合班级！");
		return;
	}else{
		$.ajax({
			type : "POST",
			url: "/sys/teaPlanManage/addTeachingPlan.do",
			data: "createJson="+JSON.stringify(createQuality)+"&teachingJson="+JSON.stringify(teachingQualityArray),
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title : '创建教质计划', msg : '创建教质计划中，请稍等……'});
	    	},
	    	success: function(state) {
	    		$.messager.progress('close'); 
	    		if(state == "1"){
	    			$.messager.alert('提示', "创建教质计划成功！","info",function(){
		    			window.location.href = "/sys/teaPlanManage/teaPlanManage.jsp";
					});
	    		}else if(state == "2"){
	    			$.messager.alert('提示', "该校区该月已创建教质计划！","info",function(){
		    			window.location.href = "/sys/teaPlanManage/teaPlanManage.jsp";
					});
	    		}else if(state == "3"){
	    			$.messager.alert('提示', "创建教质计划失败！");
	    		}
	        } 
		});
	}
}

//跳转修改教质计划页面
function updatePlan()
{
	if(validateSelect("list_data")) {
		var row = $("#list_data").datagrid('getSelected');
		var createQualityId = row.createQualityId;
		var schoolName = row.schoolName;
		var month = row.month;
		window.location.href = "/sys/teaPlanManage/viewTeachingPlanInfo.do?createQualityId="+createQualityId+"&schoolName="+schoolName+"&month="+month+"&type=update";
	}

}

//修改教质计划提交
function updatePlanSubmit()
{
	var handlerId = $("#handlerId").val();
	var teachingQualityArray = new Array();
	$("input[name='qualityId']").each(function(i,node){
	   var qualityId = $("#qualityId"+i+"").val();
	   var teachingDate = $("#teachingDate"+i+"").datebox('getValue');
	   var meetingDate = $("#meetingDate"+i+"").datebox('getValue');
	   var openClassDate = $("#openClassDate"+i+"").datebox('getValue');
	   var gradDate = $("#gradDate"+i+"").datebox('getValue');
	   var teachingQuality = {};
	   teachingQuality.qualityId = qualityId;
	   teachingQuality.teachingDate = teachingDate;
	   teachingQuality.meetingDate = meetingDate;
	   teachingQuality.openClassDate = openClassDate;
	   teachingQuality.gradDate = gradDate;
	   teachingQuality.handlerId = handlerId;
	   teachingQualityArray.push(teachingQuality);
	});
	$.ajax({
		type : "POST",
		url: "/sys/teaPlanManage/updateTeachingPlan.do",
		data: "json="+JSON.stringify(teachingQualityArray),
		async: false,
		beforeSend: function()
    	{
    		$.messager.progress({title : '修改教质计划', msg : '修改教质计划中，请稍等……'});
    	},
    	success: function(flag) {
    		$.messager.progress('close'); 
    		if(flag == "true"){
    			$.messager.alert('提示', "修改教质计划成功！","info",function(){
	    			window.location.href = "/sys/teaPlanManage/teaPlanManage.jsp";
				});
    		}else if(flag == "false"){
    			$.messager.alert('提示', "修改教质计划失败！");
    		}
        } 
	});
}

//跳转浏览教质计划页面
function viewPlan()
{
	if(validateSelect("list_data")) {
		var row = $("#list_data").datagrid('getSelected');
		var createQualityId = row.createQualityId;
		var schoolName = row.schoolName;
		var month = row.month;
		window.location.href = "/sys/teaPlanManage/viewTeachingPlanInfo.do?createQualityId="+createQualityId+"&schoolName="+schoolName+"&month="+month+"&type=view";
	}

}

function validateSelect(object)
{
	var flag = false;
	var obj = $("#"+object+"").datagrid('getSelections');
	if(obj.length > 0) {
		if(obj.length > 1) {
			$.messager.alert('提示', "只能选择一个教质计划进行操作！");
		} else {
			flag = true;
		}
	} else {
		$.messager.alert('提示', "请先选择您要操作的教质计划！");
	}
	return flag;
}