$(document).ready(function(){
	//首页面查询
    $("#qryCourseGift").click(function() {
		var obj = JSON.stringify($("#qryCourseFm").serializeObject());
		obj = obj.substring(0, obj.length - 1);
		var funcNodeId = $("#qryCourseGift").attr("funcNodeId");
		obj += ",\"funcNodeId\":\""+funcNodeId+"\"}";
		$('#courseGift_data').datagrid({
			url : "/sys/pubData/qryDataListByPage.do",
			queryParams:{
				param : obj
			},
			onLoadSuccess:function(){
				//一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题。
				$('#courseGift_data').datagrid('clearSelections');
			}
		});
    });
    
});

//跳转赠课终止页面
function courseFinish()
{
	getCourseInfo("courseGift_data","finish");
}

//跳转赠课浏览页面
function viewCourseGiftInfo()
{
	getCourseInfo("courseGift_data","view");
}

//获取赠课的信息，根据不同类型跳转不同页面
function getCourseInfo(obj,type)
{
	var row = $("#"+obj+"").datagrid('getSelected');
	var gift = {};
	gift.studentGiftId = row.studentGiftId;
	gift.giftChannel = row.giftChannel;
	gift.giftChannelDesc = row.giftChannelDesc;
	gift.giftTypeVal = row.giftTypeVal;
	gift.giftNum = row.giftNum;
	gift.giftState = row.giftState;
	gift.effDate = row.effDate;
	gift.expDate = row.expDate;
	gift.createDate = row.createDate;
	gift.rtnDate = row.rtnDate;
//	gift.rtnRemark = row.rtnRemark;
	gift.handerName = row.handerName;
	window.location.href = "/sys/giftManage/viewCourseGiftInfo.do?json="+JSON.stringify(gift)+"&type="+type;
}

//终止赠课提交
function courseFinishSubmit()
{
	var studentGiftId = $("#studentGiftId").val();
	var rtnRemark = $("#rtnRemark").val();
	rtnRemark = string2Json(rtnRemark);
	rtnRemark = encodeURI(rtnRemark);
	var json = '{"studentGiftId":"'+studentGiftId+'","rtnRemark":"'+rtnRemark+'"}';
	$.ajax({
		type : "POST",
		url: "/sys/giftManage/updateCourseGiftInfo.do",
		data: "json="+json,
		async: false,
		beforeSend: function()
    	{
    		$.messager.progress({title : '赠课终止', msg : '赠课终止中，请稍等……'});
    	},
    	success: function(flag) {
    		$.messager.progress('close'); 
    		if(flag == "true"){
    			$.messager.alert('提示', "赠课终止成功！");
    			window.location.href = "/sys/giftManage/qryGiftInfo.jsp";
    		}else if(flag == "false"){
    			$.messager.alert('提示', "赠课终止失败！");
    		}
        } 
	});
}