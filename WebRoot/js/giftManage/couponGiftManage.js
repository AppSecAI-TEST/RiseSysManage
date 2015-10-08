$(document).ready(function(){
	//首页面查询
    $("#qryCouponGift").click(function() {
		var obj = JSON.stringify($("#qryCouponFm").serializeObject());
		obj = obj.substring(0, obj.length - 1);
		var funcNodeId = $("#qryCouponGift").attr("funcNodeId");
		obj += ",\"funcNodeId\":\""+funcNodeId+"\"}";
		$('#couponGift_data').datagrid({
			url : "/sys/giftManage/qryDataListByPage.do",
			queryParams:{
				param : obj
			},
			onLoadSuccess:function(){
				//一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题。
				$('#couponGift_data').datagrid('clearSelections');
			}
		});
    });
    
//    $("input[name=goodsGiftChannel]").click(function(){
//	    var goodsGiftChannel = $("input[name='goodsGiftChannel']:checked").val();
//	    if(goodsGiftChannel == "ACTIVITY"){
//	    	$("#goodsTr").find("td").each(function(){
//	    		$(this).css("display","table-cell");
//	    	})
//	    	$("#activity").css("display","block");
//	    }else if(goodsGiftChannel == "OTHER"){
//	    	$("#goodsTr").find("td").each(function(i){
//	    		if(i > 0){
//	    			$(this).css("display","none");
//	    		}
//	    	})
//	    	$("#activity").css("display","none");
//	    }
//    });
    
});

//跳转领取赠券
function getCouponGift()
{
	var obj = $("#couponGift_data").datagrid('getSelections');
	if(obj.length > 0){
		var array = new Array();
		var flag = true;
		var studentId = obj[0].studentId;
		for(var i = 0, n = obj.length; i < n; i++){
			if(studentId != obj[i].studentId){
				$.messager.alert('提示', "请选择同一个学员赠券领取！");
				flag = false;
				return false;
			}
			if(obj[i].isGet == "是"){
				$.messager.alert('提示', "已经领取的赠券无法重复领取！");
				flag = false;
				return false;
			}
		}
		if(flag){
			for(var i = 0, n = obj.length; i < n; i++){
				var gift = {};
				gift.studentGiftId = obj[i].studentGiftId;
				gift.seq = i+1;
				gift.giftChannel = obj[i].giftChannel;
				gift.giftChannelDesc = obj[i].giftChannelDesc;
				gift.giftTypeVal = obj[i].giftTypeVal;
				gift.totalAmount = obj[i].totalAmount;
				gift.amount = obj[i].amount;
				gift.usableAmount = obj[i].usableAmount;
				gift.createDate = obj[i].createDate;
				gift.isGet = obj[i].isGet;
				gift.expInfo = obj[i].expInfo;
				array.push(gift);
			}
			window.location.href = "/sys/giftManage/jumpToGetAndRtn.do?json="+JSON.stringify(array)+"&type=couponGet";
		}
	}else{
		$.messager.alert('提示', "请先选择您要操作的学员！");
	}
}

//领取赠券提交
function getCouponGiftSubmit()
{
	if($("#getCouponForm").form('validate')){
		var giftArray = new Array();
		var getRemark = $("#getRemark").val();
		$("input[name='studentGiftId']").each(function(i,node){
		   var studentGiftId = $(node).val();
		   var granter=$("#granter"+i).textbox('getValue');
		   var effDate = $("#giftEffDate"+i).datebox('getValue');
		   var expInfo = $("#expInfo"+i).val();
		   var gift = {};
		   gift.studentGiftId = studentGiftId;
		   gift.granter =granter;
		   gift.effDate =effDate;
		   gift.getRemark =getRemark;
		   gift.expInfo =expInfo;
		   giftArray.push(gift);
		});
		$.ajax({
			type : "POST",
			url: "/sys/giftManage/updateGiftInfo.do",
			data: "json="+JSON.stringify(giftArray)+"&type=couponGet",
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title : '赠券领取', msg : '赠券领取中，请稍等……'});
	    	},
	    	success: function(flag) {
	    		$.messager.progress('close'); 
	    		if(flag == "true"){
	    			$.messager.alert('提示', "赠券领取成功！");
	    			window.location.href = "/sys/giftManage/qryGiftInfo.jsp";
	    		}else if(flag == "false"){
	    			$.messager.alert('提示', "赠券领取失败！");
	    		}
	        } 
		});
	}
}

//跳转赠券兑换页面
function couponExchange()
{
	if(validateSelect("couponGift_data")) {
		getCouponInfo("couponGift_data","exchange");
	}
}


//赠券兑换提交
function couponExchangeSubmit()
{
	if($("#exchangeForm").form('validate')){
		var studentGiftId = $("#studentGiftId").val();
		var giftName = $("#giftName").val();
		var giftCode = $("#giftCode").html();
		var amount = $("#amount").html();
		var usableAmount = $("#usableAmount").html();
		var useAmount = $("#useAmount").numberbox('getValue');
		var leftAmount = Number(usableAmount) - Number(useAmount);
		var content = $("#content").textbox('getValue');
		var granter = $("#granter").textbox('getValue');
		var json = '{"studentGiftId":"'+studentGiftId+'","couponName":"'+giftName+'","couponType":"001","couponCode":"'+giftCode+'","usedAmount":"'+useAmount+'","leftAmount":"'+leftAmount+'","amount":"'+amount+'","handlerName":"'+granter+'","description":"'+content+'"}';
		$.ajax({
			type : "POST",
			url: "/sys/giftManage/updateCouponGiftInfo.do",
			data: "json="+json+"&type=exchange",
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title : '赠券兑换', msg : '赠券兑换中，请稍等……'});
	    	},
	    	success: function(flag) {
	    		$.messager.progress('close'); 
	    		if(flag == "true"){
	    			$.messager.alert('提示', "赠券兑换成功！");
	    			window.location.href = "/sys/giftManage/qryGiftInfo.jsp";
	    		}else if(flag == "false"){
	    			$.messager.alert('提示', "赠券兑换失败！");
	    		}
	        } 
		});
	}
	
}

//跳转赠券作废页面
function couponInvalidate()
{
	if(validateSelect("couponGift_data")) {
		getCouponInfo("couponGift_data","invalidate");
	}
}

//赠券作废提交
function couponInvalidateSubmit()
{
	var studentGiftId = $("#studentGiftId").val();
	var rtnRemark = $("#rtnRemark").val();
	rtnRemark = string2Json(rtnRemark);
	rtnRemark = encodeURI(rtnRemark);
	var json = '{"studentGiftId":"'+studentGiftId+'","rtnRemark":"'+rtnRemark+'"}';
	$.ajax({
		type : "POST",
		url: "/sys/giftManage/updateCouponGiftInfo.do",
		data: "json="+json+"&type=invalidate",
		async: false,
		beforeSend: function()
    	{
    		$.messager.progress({title : '赠券作废', msg : '赠券作废中，请稍等……'});
    	},
    	success: function(flag) {
    		$.messager.progress('close'); 
    		if(flag == "true"){
    			$.messager.alert('提示', "赠券作废成功！");
    			window.location.href = "/sys/giftManage/qryGiftInfo.jsp";
    		}else if(flag == "false"){
    			$.messager.alert('提示', "赠券作废失败！");
    		}
        } 
	});
}

//跳转赠券延期页面
function couponDelay()
{
	if(validateSelect("couponGift_data")) {
		getCouponInfo("couponGift_data","delay");
	}
}


//赠券延期提交
function couponDelaySubmit()
{
	var expBeforeDate = $("#expBeforeDate").html();
	var expAfterDate = $("#expAfterDate").datebox('getValue');
	if(expAfterDate == "" || expAfterDate == undefined){
		$.messager.alert('提示', "请选择有效期延长时间！");
		return;
	}
	if(expAfterDate <= expBeforeDate){
		$.messager.alert('提示', "有效期延长时间不能小于当前有效期时间！");
		return;
	}
	var studentGiftId = $("#studentGiftId").val();
	var handlerId = $("#handlerId").val();
	var delayRemark = $("#delayRemark").val();
	var amount = $("#amount").html();
	var usableAmount = $("#usableAmount").html();
	var json = '{"studentGiftId":"'+studentGiftId+'","expBeforeDate":"'+expBeforeDate+'","expAfterDate":"'+expAfterDate+'","description":"'+delayRemark+'","handlerId":"'+handlerId+'","amount":"'+amount+'","usableAmount":"'+usableAmount+'"}';
	$.ajax({
		type : "POST",
		url: "/sys/giftManage/updateCouponGiftInfo.do",
		data: "json="+json+"&type=delay",
		async: false,
		beforeSend: function()
    	{
    		$.messager.progress({title : '赠券延期', msg : '赠券延期中，请稍等……'});
    	},
    	success: function(flag) {
    		$.messager.progress('close'); 
    		if(flag == "true"){
    			$.messager.alert('提示', "赠券延期成功！");
    			window.location.href = "/sys/giftManage/qryGiftInfo.jsp";
    		}else if(flag == "false"){
    			$.messager.alert('提示', "赠券延期失败！");
    		}
        } 
	});
}

//跳转赠券浏览页面
function viewCouponGiftInfo()
{
	if(validateSelect("couponGift_data")) {
		getCouponInfo("couponGift_data","view");
	}
}

//获取赠券的信息，根据不同类型跳转不同页面
function getCouponInfo(obj,type)
{
	var row = $("#"+obj+"").datagrid('getSelected');
	var studentId = row.studentId;
	var studentName = row.name;
	var gift = {};
	gift.studentGiftId = row.studentGiftId;
	gift.giftChannelDesc = row.giftChannelDesc;
	gift.giftTypeVal = row.giftTypeVal;
	gift.giftName = row.giftName;
	gift.totalAmount = row.totalAmount;
	gift.amount = row.amount;
	gift.usableAmount = row.usableAmount;
	gift.giftCode = row.giftCode;
	gift.giftState = row.giftState;
	gift.isGet = row.isGet;
	gift.effDate = row.effDate;
	gift.expDate = row.expDate;
	gift.createDate = row.createDate;
	gift.getDate = row.getDate;
	gift.granter = row.granter;
	gift.handerName = row.handerName;
	window.location.href = "/sys/giftManage/viewCouponGiftInfo.do?json="+JSON.stringify(gift)+"&type="+type;
}

function validateSelect(object)
{
	var flag = false;
	var obj = $("#"+object+"").datagrid('getSelections');
	if(obj.length > 0) {
		if(obj.length > 1) {
			$.messager.alert('提示', "只能选择一个学员进行操作！");
		} else {
			flag = true;
		}
	} else {
		$.messager.alert('提示', "请先选择您要操作的学员！");
	}
	return flag;
}