$(document).ready(function(){
	//首页面查询
    $("#qryGoodsGift").click(function() {
		var obj = JSON.stringify($("#qryGoodsFm").serializeObject());
		obj = obj.substring(0, obj.length - 1);
		var funcNodeId = $("#qryGoodsGift").attr("funcNodeId");
		obj += ",\"funcNodeId\":\""+funcNodeId+"\"}";
		$('#goodsGift_data').datagrid({
			url : "/sys/pubData/qryDataListByPage.do",
			queryParams:{
				param : obj
			},
			onLoadSuccess:function(){
				//一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题。
				$('#goodsGift_data').datagrid('clearSelections');
			}
		});
    });
    
    $("input[name=goodsGiftChannel]").click(function(){
	    var goodsGiftChannel = $("input[name='goodsGiftChannel']:checked").val();
	    if(goodsGiftChannel == "ACTIVITY"){
	    	$("#goodsTr").find("td").each(function(){
	    		$(this).css("display","table-cell");
	    	})
	    	$("#activity").css("display","block");
	    }else if(goodsGiftChannel == "OTHER"){
	    	$("#goodsTr").find("td").each(function(i){
	    		if(i > 0){
	    			$(this).css("display","none");
	    		}
	    	})
	    	$("#activity").css("display","none");
	    }
    });
    
});

//增加行
function addRow()
{
		var giftModelTR=$("#giftModelTR").clone();
		var flag=true;
		var giftTR=$("#addGift").clone();
		giftTR.css("display",'table-row');
		giftTR.attr("val","gift");
		giftTR.find("td").each(function(n,node)
		{
			var giftType=$("#giftType").combobox('getValue');
			if(n==1)//赠品类别;	
			{
				var name=$("#giftType").combobox('getText');
				if(giftType == undefined || giftType == ""){
					flag=false;
					$.messager.alert('提示', "请选择赠品类别！");
					return false;
				}
				$(node).html("<span>"+name+"</span>");	
				$(node).attr("giftType",giftType);
			}else if(n==3)//赠品名称;劵类ID
			{
				
				var giftId=$("#giftName").combobox('getValue');
				var giftName=$("#giftName").combobox('getText');
			 	if(giftName == undefined || giftName == ""){
			 		flag=false;
					$.messager.alert('提示', "请选择赠品名称！");
					return false;
				}
				
				$(node).html("<span>"+giftName+"</span>");									 
				
				$(node).attr("giftId",giftId);
				$(node).attr("giftName",giftName);
			}else if(n==5)
			{
				var isGet = $("input[name='isGet']:checked").val();
				if(isGet == undefined || isGet == ""){
					flag=false;
					$.messager.alert('提示', "请选择是否领用！");
					return false;
				}
				if('Y'==isGet)
				{
					$(node).html("<span>√</span>");	
					$(node).attr("isGet","Y");
				}else if('N'==isGet)
				{
					$(node).html("<span>×</span>");	
					$(node).attr("isGet","N");
				}
			}else if(n==7)
			{
				var granter=$("#granter").textbox("getValue");
				if(granter == undefined || granter == ""){
					flag=false;
					$.messager.alert('提示', "请填写发放人！");
					return false;
				}
				$(node).html("<span>"+granter+"</span>");	
				$(node).attr("granter",granter);
			} 
		});
		if(flag)
		{
			$("#addGift").after(giftTR);
	    }
		clearData("giftModelTR")
}

//删除相对应的行  
function delRow(rows)  
{  
    $(rows).parent("td").parent("tr").remove();  
}

//定位学员
function locateStu(type)
{
	window.location.href = "/sys/giftManage/qryStuList.jsp?type="+type;
}

//根据不同类型跳转不同页面（实物教材赠品还是赠券赠品）
function addGift(type)
{
	if(validateSelect("list_data")) {
		var row = $('#list_data').datagrid('getSelected');
		var studentId = row.studentId;
		var studentName = row.name;
		if(type == "goods"){
			window.location.href = "/sys/giftManage/addGoodsGift.jsp?studentId="+studentId+"&studentName="+studentName;
		}
		if(type == "coupon"){
			
		}
	}
}

//选择活动
function chooseActivity()
{
	var studentId = $("#studentId").val();
	$('#dlg').dialog({
		title:"选择活动",
	});
	$('#dlg').attr("src","/sys/giftManage/chooseActivity.jsp?studentId="+studentId);
	$('#dlg').dialog("open");
}

//新增实物教材赠品提交
function addGoodsGiftSubmit()
{
	var goodsGiftChannel = $("input[name='goodsGiftChannel']:checked").val();
	var handlerId = $("#handlerId").val();
	var studentId = $("#studentId").val();
	var studentName = $("#studentName").val();
	var giveRemark = $("#giveRemark").val();
	if(goodsGiftChannel == "" || goodsGiftChannel == undefined){
		$.messager.alert('提示', "请选择来源类型！");
		return;
	}
	var titleText = "";
	var activityId = "";
	if(goodsGiftChannel == "ACTIVITY"){
		titleText = $("#titleText").html();
		activityId = $("#activityId").val(); 
		if(titleText == "" || titleText == undefined || activityId == "" || activityId == undefined)
		{
			$.messager.alert('提示', "活动赠送请选择一个活动！");
			return;
		}
	}
	var gifts= new Array();
	$("#giftTab").find('tr').each(function(i,node)
	{
		var trName=$(this).attr("val");
 
		if('gift'==trName)
		{
			 var tds=$(this).children('td');
		 
			 var giftType=tds.eq(1).attr('giftType');
			 var giftId=tds.eq(3).attr('giftId');
			 var giftName=tds.eq(3).attr('giftName');
			 var isGet=tds.eq(5).attr('isGet');
			 var granter=tds.eq(7).attr('granter');
			 var gift = {};
			 
			 gift.studentId=studentId;
			 gift.giftChannel = goodsGiftChannel;
			 gift.giftType = giftType;
			 gift.giftId=giftId;
			 gift.giftName=giftName;
			 gift.isGet=isGet;
			 gift.isRtn="N";
			 gift.state="00A";
			 gift.giftState="00A";
			 gift.granter=granter;
			 if("Y"==isGet){
				 gift.getUser=studentName;
			 }
			 if(goodsGiftChannel == "ACTIVITY"){
				 gift.channelVal = activityId;
				 gift.giftChannelDesc = titleText+"赠送";
			 }
			 if(goodsGiftChannel == "OTHER"){
				 gift.giftChannelDesc ="其他赠送";
			 }
			 gift.giveRemark=giveRemark;
			 gift.handlerId=handlerId;
			 gifts.push(gift);  
		 }
	});
	if(gifts.length == 0){
		$.messager.alert('提示', "请至少添加一个赠品！");
		return;
	}else{
		$.ajax({
			type : "POST",
			url: "/sys/giftManage/addGiftInfo.do",
			data: "json="+JSON.stringify(gifts),
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title : '实物&教材赠品赠送', msg : '实物&教材赠品赠送中，请稍等……'});
	    	},
	    	success: function(flag) {
	    		$.messager.progress('close'); 
	    		if(flag == "true"){
	    			$.messager.alert('提示', "实物&教材赠品赠送成功！");
	    			window.location.href = "/sys/giftManage/qryGiftInfo.jsp";
	    		}else if(flag == "false"){
	    			$.messager.alert('提示', "实物&教材赠品赠送失败！");
	    		}
	        } 
		});
	}
}

//跳转实物教材领取页面
function getGoodsGift()
{
	var obj = $("#goodsGift_data").datagrid('getSelections');
	if(obj.length > 0){
		var array = new Array();
		var flag = true;
		var studentId = obj[0].studentId;
		for(var i = 0, n = obj.length; i < n; i++){
			if(studentId != obj[i].studentId){
				$.messager.alert('提示', "请选择同一个学员赠品领取！");
				flag = false;
				return false;
			}
			if(obj[i].isGet == "是"){
				$.messager.alert('提示', "已经领取的赠品无法重复领取！");
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
				gift.giftName = obj[i].giftName;
				gift.isGet = obj[i].isGet;
				gift.createDate = obj[i].createDate;
				array.push(gift);
			}
			window.location.href = "/sys/giftManage/jumpToGetAndRtn.do?json="+JSON.stringify(array)+"&type=goodsGet";
		}
	}else{
		$.messager.alert('提示', "请先选择您要操作的学员！");
	}
}

//实物教材领取提交
function getGoodsGiftSubmit()
{
	if($("#getGoodForm").form('validate')){
		var giftArray = new Array();
		var getRemark = $("#getRemark").val();
		$("input[name='studentGiftId']").each(function(i,node){
		   var studentGiftId = $(node).val();
		   var granter=$("#granter"+i).textbox('getValue');
		   var gift = {};
		   gift.studentGiftId = studentGiftId;
		   gift.granter =granter;
		   gift.getRemark =getRemark;
		   giftArray.push(gift);
		});
		$.ajax({
			type : "POST",
			url: "/sys/giftManage/updateGiftInfo.do",
			data: "json="+JSON.stringify(giftArray)+"&type=goodsGet",
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title : '实物&教材赠品领取', msg : '实物&教材赠品领取中，请稍等……'});
	    	},
	    	success: function(flag) {
	    		$.messager.progress('close'); 
	    		if(flag == "true"){
	    			$.messager.alert('提示', "实物&教材赠品领取成功！");
	    			window.location.href = "/sys/giftManage/qryGiftInfo.jsp";
	    		}else if(flag == "false"){
	    			$.messager.alert('提示', "实物&教材赠品领取失败！");
	    		}
	        } 
		});
	}
}

//跳转实物教材退回页面
function rtnGoodsGift()
{
	var obj = $("#goodsGift_data").datagrid('getSelections');
	if(obj.length > 0){
		var array = new Array();
		var flag = true;
		var studentId = obj[0].studentId;
		for(var i = 0, n = obj.length; i < n; i++){
			if(studentId != obj[i].studentId){
				$.messager.alert('提示', "请选择同一个学员赠品退回！");
				flag = false;
				return false;
			}
			if(obj[i].isRtn == "是"){
				$.messager.alert('提示', "已经退回的赠品无法重复退回！");
				flag = false;
				return false;
			}
			if(obj[i].isGet == "否"){
				$.messager.alert('提示', "没有领取的赠品无法退回！");
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
				gift.giftName = obj[i].giftName;
				gift.isGet = obj[i].isGet;
				gift.isRtn = obj[i].isRtn;
				gift.createDate = obj[i].createDate;
				gift.getDate = obj[i].getDate;
				gift.granter = obj[i].granter;
				array.push(gift);
			}
			window.location.href = "/sys/giftManage/jumpToGetAndRtn.do?json="+JSON.stringify(array)+"&type=goodsRtn";
		}
	}else{
		$.messager.alert('提示', "请先选择您要操作的学员！");
	}
}

//实物教材退回提交
function rtnGoodsGiftSubmit()
{
	if($("#rtnGoodForm").form('validate')){
		var giftArray = new Array();
		var rtnRemark = $("#rtnRemark").val();
		$("input[name='studentGiftId']").each(function(i,node){
		   var studentGiftId = $(node).val();
		   var accepter=$("#accepter"+i).textbox('getValue');
		   var gift = {};
		   gift.studentGiftId = studentGiftId;
		   gift.accepter =accepter;
		   gift.rtnRemark =rtnRemark;
		   giftArray.push(gift);
		});
		$.ajax({
			type : "POST",
			url: "/sys/giftManage/updateGiftInfo.do",
			data: "json="+JSON.stringify(giftArray)+"&type=goodsRtn",
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title : '实物&教材赠品退回', msg : '实物&教材赠品退回中，请稍等……'});
	    	},
	    	success: function(flag) {
	    		$.messager.progress('close'); 
	    		if(flag == "true"){
	    			$.messager.alert('提示', "实物&教材赠品退回成功！");
	    			window.location.href = "/sys/giftManage/qryGiftInfo.jsp";
	    		}else if(flag == "false"){
	    			$.messager.alert('提示', "实物&教材赠品退回失败！");
	    		}
	        } 
		});
	}
}

//浏览实物教材赠品
function viewGoodsGift()
{
	if(validateSelect("goodsGift_data")) {
		var row = $('#goodsGift_data').datagrid('getSelected');
		var studentGiftId = row.studentGiftId;
		var channelName = row.giftChannel;
		var isGetVal = row.isGet;
		var isRtnVal = row.isRtn;
		window.location.href = "/sys/giftManage/viewGoodsGiftInfo.do?studentGiftId="+studentGiftId+"&channelName="+channelName+"&isGetVal="+isGetVal+"&isRtnVal="+isRtnVal;
	}
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