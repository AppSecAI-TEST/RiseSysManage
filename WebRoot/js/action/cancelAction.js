var actionId =null;
$(document).ready(function(){
	$("#submitBtn").click(function() {
		cancelAction();
	});
	$("#backBtn").click(function() {
		window.location.href = "qryActionList.jsp";
	});
	initPage();
	$("textarea").each(function(i,node){
		$(node).attr("maxlength",200);
	});
});


function cancelAction()
{
	var param={};
	param.actionId =actionId;
	param.handlerId =$("#handlerId").val();
	param.cancelRemark =$("#cancelRemark").textbox("getValue");
	$.ajax( {
		type : "POST",
		url : "/sys/actionInfo/cancelAction.do",
		data :"param="+JSON.stringify(param),
		async : false,
		beforeSend : function() {
			showProgressLoader("正在取消活动,请稍等...", 400);
		},
		success : function(data) {
			hideProgressLoader()
			if (data == "true") {
				showMessage('提示', "取消活动成功！", function() {
					window.location.href = "qryActionList.jsp";
				});
			} else {
				showMessage('提示', "取消活动失败！", null);
			}
		},
		error : function() {
			hideProgressLoader();
			showMessage('提示', "调用取消活动服务失败！", null);
		}
	});
}

function initPage()
{
	actionId =document.URL.split("=")[1];
	$.ajax( {
		type : "POST",
		url : "/sys/actionInfo/getActionInfo.do",
		data :"actionId="+actionId,
		async : false,
		dataType:"json",
		beforeSend : function() {
			showProgressLoader("正在加载数据,请稍等...", 400);
		},
		success : function(data) {
			hideProgressLoader()
			if(data.actionInfo!=null)
			{
				var action =data.actionInfo;
				var tab =$("#infoTab");
				tab.find("tr:eq(0)").find("td:eq(1)").html("<span>"+action.schoolName+"</span>");
				var actionTime =action.actionTime;
				if(action.timeStart!=""&&action.timeStart!="")
				{
					actionTime+=" "+action.timeStart+" ～"+action.timeEnd;
				}	
				tab.find("tr:eq(1)").find("td:eq(1)").html("<span>"+actionTime+"</span>");
				tab.find("tr:eq(2)").find("td:eq(1)").html("<span>"+action.title+"</span>");
				tab.find("tr:eq(3)").find("td:eq(1)").html("<span>"+action.planHours+"</span>");
				tab.find("tr:eq(4)").find("td:eq(1)").html("<span>"+action.staffName+"</span>");
				tab.find("tr:eq(5)").find("td:eq(1)").html("<span>"+action.createRemark+"</span>");
			}
			if(data.teacherInfo!=null&&data.teacherInfo.length>0)
			{
				$.each(data.teacherInfo,function(i,obj){
					var tr =$("#teacherTr").clone();
					tr.find("td:eq(1)").html("<span>"+obj.schoolName+" "+obj.teacherName+" "+obj.teacherType+"</span>");
					tr.css("display","table-row");
					$("#teacherTr").after(tr);
				})
				
			}	
		},
		error : function() {
			hideProgressLoader();
			showMessage('提示', "调用查询活动服务失败！", null);
		}
	});
}