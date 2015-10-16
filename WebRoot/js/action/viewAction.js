$(document).ready(function(){
	$("#backBtn").click(function() {
		window.location.href = "qryActionList.jsp";
	});
	initPage();
});

function initPage()
{
	actionId =document.URL.split("=")[1];
	$.ajax( {
		type : "POST",
		url : "/sys/actionInfo/getActionDetailInfo.do",
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
				if(action.state=="F")
				{
					tab.find("tr:eq(3)").find("td:eq(1)").html("<span>"+action.realHours+"</span>");
				}
				else
				{
					tab.find("tr:eq(3)").find("td:eq(1)").html("<span>"+action.planHours+"</span>");
				}	
				tab.find("tr:eq(5)").find("td:eq(1)").html("<span>"+action.createRemark+"</span>");
				if(action.state=="C")
				{
					tab.find("tr:eq(6)").find("td:eq(0)").html("<span>取消备注：</span>");
					tab.find("tr:eq(6)").find("td:eq(1)").html("<span>"+action.cancelRemark+"</span>");
				}
				else
				{
					tab.find("tr:eq(6)").find("td:eq(1)").html("<span>"+action.replyRemark+"</span>");
				}	
				tab.find("tr:eq(7)").find("td:eq(1)").html("<span>"+action.staffName+"</span>");
				tab.find("tr:eq(7)").find("td:eq(3)").html("<span>"+action.createTime+"</span>");
				if(action.state=="F")
				{
					tab.find("tr:eq(8)").find("td:eq(1)").html("<span>"+action.backName+"</span>");
					tab.find("tr:eq(8)").find("td:eq(3)").html("<span>"+action.backTime+"</span>");
				}
				else
				{
					tab.find("tr:eq(8)").css("display","none");
				}	
			}
			if(data.teacherInfo!=null&&data.teacherInfo.length>0)
			{
				$.each(data.teacherInfo,function(i,obj){
					var tr =$("#teacherTr").clone();
					tr.find("td:eq(1)").html("<span>"+obj.schoolName+" "+obj.teacherName+" "+obj.teacherType+" "+obj.hours+"</span>");
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