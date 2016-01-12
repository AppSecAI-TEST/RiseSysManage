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
    
	 $("input[name=goodsGiftChannel]").click(function(){
		    var goodsGiftChannel = $("input[name='goodsGiftChannel']:checked").val();
		    if(goodsGiftChannel == "ACTIVITY"){
		    	$(".activity").each(function(){
		    		$(this).css("display","table-cell");
		    	})
		    	$(".course").each(function(){
		    		$(this).css("display","none");
		    	})
		    	$("#activity").css("display","block");
		    	$("#course").css("display","none");
		    }else if(goodsGiftChannel == "OTHER"){
		    	$(".activity").each(function(){
		    		$(this).css("display","none");
		    	})
		    	$(".course").each(function(){
		    		$(this).css("display","none");
		    	})
		    	$("#activity").css("display","none");
		    	$("#course").css("display","none");
		    }else if(goodsGiftChannel == "COURSE"){
		    	$(".activity").each(function(){
		    		$(this).css("display","none");
		    	})
		    	$(".course").each(function(){
		    		$(this).css("display","table-cell");
		    	})
		    	$("#activity").css("display","none");
		    	$("#course").css("display","block");
		    }
	   });
    
     $('#giftType').combobox({
		 url:"/sys/pubData/qryData.do?param={'queryCode':'Qry_Gift_Type','parentType':'COUPON'}",
		 formatter:formatTypeName, 
		 valueField: 'giftType', 
		 textField: 'typeName', 
		 panelHeight: 'auto',
	 	 onChange:function(n,o)
		 {
       		$("#amount").combobox(
       		{
        		url : "/sys/pubData/qryData.do?param={queryCode:\"Qry_Gift\",giftType:\""+n+"\"}",//返回json数据的url
        		valueField : "giftId",
        		textField :  "amount",
        		panelHeight : "auto",
        		onLoadSuccess : function ()
        		{ //数据加载完毕事件
                    var data = $('#amount').combobox('getData');
                    if (data.length > 0)
                    {
                      //  $("#giftId").combobox('select', data[0].param2);
                    }
                }
        	});
		}
	});
    
    var staffId = $("#staffId").val();
	$("#couponSchoolId").combobox({
		url : "/sys/pub/pageCategory.do?staffId="+staffId+"&resourceId=503&fieldId=schoolId&headFlag=N",//返回json数据的url
		valueField : "schoolId",
		textField : "schoolName",
		panelHeight : "auto",
		formatter : formatSchool,
		onLoadSuccess : function(data) {
			$("#couponSchoolId").combobox('setValue',data[0].schoolId);
		},
		onChange : function(n, o) {
			if(n != "" && n != null && n != undefined) {
				$("#couponClassInstId").combobox({disabled: false});
				$("#couponClassInstId").combobox({
					url : "/sys/pubData/qryClassInstList.do?schoolId="+n+"&courseType=&stageId=&classType=&classState='001','002','003','004','005'&classInstId=",//返回json数据的url
					valueField : "classInstId",
					textField : "className",
					panelHeight : "auto",
					formatter : function(data) {
						return "<span>" + data.className + "</span>";
					}
				});
//				$("#couponStudentId").combobox({
//					url : "/sys/pub/paramComboxList.do?staffId="+staffId+"&schoolId="+n+"&funcNodeId=20&fieldId=studentId",
//					valueField : "studentId",
//					textField : "name",
//					panelHeight : "auto",
//					formatter : function(data) {
//						return "<span>" + data.name + "</span>";
//					}
//				});
			} else {
				$("#couponSchoolId").combobox("setText", "");
				$("#couponClassInstId").combobox('clear');
				$("#couponClassInstId").combobox("loadData", new Array());
				$("#couponClassInstId").combobox({disabled: true});
			}
		}
	});
    
	$("#couponGiftChannel").combobox({
		url : "/sys/pubData/qryCodeNameList.do?tableName=STUDENT_GIFT_T&codeType=GIFT_CHANNEL",//返回json数据的url
		valueField : "codeFlag",
		textField : "codeName",
		panelHeight : "auto",
		formatter : formatItem,
		onChange : function(n, o) {
			if(n != "" && n != null && n != undefined) {
				if(n=="COURSE"){
					$("#couponStageId").combobox({disabled: false});
					$("#couponStageId").combobox({
						url : "/sys/pubData/qryStage.do",//返回json数据的url
						valueField : "stageId",
						textField : "stageId",
						panelHeight : "auto",
						formatter : formatStageId
					});
				}else{
					$("#couponStageId").combobox({disabled: true});
					$("#couponStageId").combobox("setValue", "");
				}
			} else {
				$("#couponGiftChannel").combobox("setText", "");
				$("#couponStageId").combobox('clear');
				$("#couponStageId").combobox("loadData", new Array());
				$("#couponStageId").combobox({disabled: true});
			}
		}
	});
	
	 $('#couponGiftType').combobox({
		 url:"/sys/pubData/qryData.do?param={'queryCode':'Qry_Gift_Type','parentType':'COUPON'}",
		 formatter:formatTypeName, 
		 valueField: 'giftType', 
		 textField: 'typeName', 
		 panelHeight: 'auto',
	 	 onChange:function(n,o)
		 {
       		$("#couponGiftId").combobox(
       		{
        		url : "/sys/pubData/qryData.do?param={queryCode:\"Qry_Gift\",giftType:\""+n+"\"}",//返回json数据的url
        		valueField : "giftId",
        		textField :  "giftName",
        		panelHeight : "auto",
        		onLoadSuccess : function ()
        		{ //数据加载完毕事件
                    var data = $('#couponGiftId').combobox('getData');
                    if (data.length > 0)
                    {
                      //  $("#giftId").combobox('select', data[0].param2);
                    }
                }
        	});
		}
	 });
     
	$(".couponGet").change(function() {
	   var val = $(this).val();
	   if(val == "Y"){
		   $("#giftCode").textbox({disabled:false});
		   $("#effDate").datebox({disabled:false});
		   $("#granter").textbox({disabled:false});
	   }else if(val == "N"){
	       $("#giftCode").textbox('setValue',"");
	       $("#effDate").datebox('setValue',"");
		   $("#granter").textbox('setValue',"");
		   $("#giftCode").textbox({disabled:true});
		   $("#effDate").datebox({disabled:true});
		   $("#granter").textbox({disabled:true});
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
		var effDate = $("#effDate").datebox('getValue');
		var giftCode = $("#giftCode").textbox('getValue');
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
			
			var datas = $('#giftType').combobox('getData');
			for(var m=0;m<datas.length;m++)
			{
				if(giftType==datas[m].giftType)
				{
					 $(node).attr("effNum",datas[m].effNum);
					 $(node).attr("unit",datas[m].unit);
				}
			}
			
		}else if(n==3)//赠品名称;劵类ID
		{
			
			var giftId=$("#amount").combobox('getValue');
			var amount=$("#amount").combobox('getText');
		 	if(amount == undefined || amount == ""){
		 		flag=false;
				$.messager.alert('提示', "请选择赠券面值！");
				return false;
			}
			$(node).html("<span>"+amount+"</span>");	
			$(node).attr("giftId",giftId);
			
			var datas = $('#amount').combobox('getData');
			for(var m=0;m<datas.length;m++)
			{
				if(giftId==datas[m].giftId)
				{
					 $(node).attr("giftName",datas[m].giftName);
				}
			}
		}else if(n==5)
		{
			var usableAmount = $("#usableAmount").numberbox('getValue');
			if(usableAmount == undefined || usableAmount == ""){
				flag=false;
				$.messager.alert('提示', "请填写可用金额！");
				return false;
			}
			var amount=$("#amount").combobox('getText');
			if(parseInt(usableAmount)>parseInt(amount)){
				flag=false;
				$.messager.alert('提示', "可用金额不能大于赠券面值！");
				return false;
			}
			$(node).html("<span>"+usableAmount+"</span>");	
			$(node).attr("usableAmount",usableAmount);
		}else if(n==7)
		{
			$(node).html("<span>"+giftCode+"</span>");	
			$(node).attr("giftCode",giftCode);
		}else if(n==9)
		{
			$(node).html("<span>"+effDate+"</span>");	
			$(node).attr("effDate",effDate);
		}else if(n==11)
		{
			var isGet = $("input[name='isGet']:checked").val();
			if(isGet == undefined || isGet == ""){
				flag=false;
				$.messager.alert('提示', "请选择是否领用！");
				return false;
			}
			if('Y'==isGet)
			{
				if(giftCode == undefined || giftCode == ""){
					flag=false;
					$.messager.alert('提示', "请输入赠券编号！");
					return false;
				}
				if(effDate == undefined || effDate == ""){
					flag=false;
					$.messager.alert('提示', "请填写有效期！");
					return false;
				}
				$(node).html("<span>√</span>");	
				$(node).attr("isGet","Y");
			}else if('N'==isGet)
			{
				$(node).html("<span>×</span>");	
				$(node).attr("isGet","N");
			}
		}else if(n==13)
		{
			var granter=$("#granter").textbox("getValue");
			var isGet = $("input[name='isGet']:checked").val();
			if('Y'==isGet){
				if(granter == undefined || granter == ""){
					flag=false;
					$.messager.alert('提示', "请填写发放人！");
					return false;
				}
				$(node).html("<span>"+granter+"</span>");	
				$(node).attr("granter",granter);
			}
		} 
	});
	if(flag)
	{
		$("#addGift").after(giftTR);
		clearData("giftModelTR");
		$("#giftCode").textbox({disabled:false});
	    $("#effDate").datebox({disabled:false});
		$("#granter").textbox({disabled:false});
    }
}

//删除相对应的行  
function delRow(rows)  
{  
    $(rows).parent("td").parent("tr").remove();  
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

//选择课程
function chooseCourse()
{
	var studentId = $("#studentId").val();
	$('#courseDlg').dialog({
		title:"选择课程",
	});
	$('#courseDlg').attr("src","/sys/giftManage/chooseCourse.jsp?studentId="+studentId);
	$('#courseDlg').dialog("open");
}

//新增赠券赠品提交
function addCouponGiftSubmit()
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
	var stageId = "";
	var studentCourseId = "";
	if(goodsGiftChannel == "COURSE"){
		stageId = $("#stageId").html();
		studentCourseId = $("#studentCourseId").val(); 
		if(stageId == "" || stageId == undefined || studentCourseId == "" || studentCourseId == undefined)
		{
			$.messager.alert('提示', "课程赠送请选择一个课程！");
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
			 var effNum=tds.eq(1).attr('effNum');
			 var unit=tds.eq(1).attr('unit');
			 var giftId=tds.eq(3).attr('giftId');
			 var giftName=tds.eq(3).attr('giftName');
			 var usableAmount=tds.eq(5).attr('usableAmount');
			 var giftCode=tds.eq(7).attr('giftCode');
			 var effDate=tds.eq(9).attr('effDate');
			 var isGet=tds.eq(11).attr('isGet');
			 var granter=tds.eq(13).attr('granter');
			 var gift = {};
			 
			 gift.studentId=studentId;
			 gift.giftChannel = goodsGiftChannel;
			 gift.giftType = giftType;
			 gift.effNum = effNum;
			 gift.unit = unit;
			 gift.giftId=giftId;
			 gift.giftName=giftName;
			 gift.amount=usableAmount;//刚刚新增时可用金额跟剩余金额一样
			 gift.usableAmount=usableAmount;
			 gift.giftCode=giftCode;
			 gift.effDate=effDate;
			 gift.isGet=isGet;
			 gift.isRtn="N";
			 gift.state="00A";
			 gift.giftState="UNSUED";
			 gift.granter=granter;
			 if("Y"==isGet){
				 gift.getUser=studentName;
			 }
			 if(goodsGiftChannel == "ACTIVITY"){
				 gift.channelVal = activityId;
				 gift.giftChannelDesc = titleText+"赠送";
			 }
			 if(goodsGiftChannel == "COURSE"){
				 gift.channelVal = studentCourseId;
				 gift.studentCourseId = studentCourseId;
				 gift.giftChannelDesc = "购买"+stageId+"赠送";
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
			data: "json="+JSON.stringify(gifts)+"&type=addCoupon",
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title : '赠券赠品赠送', msg : '赠券赠品赠送中，请稍等……'});
	    	},
	    	success: function(flag) {
	    		$.messager.progress('close'); 
	    		if(flag == "true"){
	    			$.messager.alert('提示', "赠券赠品赠送成功！");
	    			window.location.href = "/sys/giftManage/qryGiftInfo.jsp";
	    		}else if(flag == "false"){
	    			$.messager.alert('提示', "赠券赠品赠送失败！");
	    		}
	        } 
		});
	}
}

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
		   var giftCode = $("#giftCode"+i).textbox('getValue');
		   var expInfo = $("#expInfo"+i).val();
		   var gift = {};
		   gift.studentGiftId = studentGiftId;
		   gift.granter =granter;
		   gift.effDate =effDate;
		   gift.getRemark =getRemark;
		   gift.giftCode = giftCode;
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
		var row = $("#couponGift_data").datagrid('getSelected');
		var isGet = row.isGet;
		var giftState = row.giftState;
		if(isGet == "否"){
			$.messager.alert('提示', "请先领取赠券！");
			return;
		}
		if(giftState == "消耗完" || giftState == "已过期" || giftState == "已作废"){
			$.messager.alert('提示', "该赠券状态不能兑换！");
			return;
		}
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
		var json = '{"studentGiftId":"'+studentGiftId+'","couponName":"'+giftName+'","couponCode":"'+giftCode+'","usedAmount":"'+useAmount+'","leftAmount":"'+leftAmount+'","amount":"'+amount+'","handlerName":"'+granter+'","description":"'+content+'"}';
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
		var row = $("#couponGift_data").datagrid('getSelected');
		var giftState = row.giftState;
		if(giftState == "已作废"){
			$.messager.alert('提示', "该赠券已经作废！");
			return;
		}
		getCouponInfo("couponGift_data","invalidate");
	}
}

//赠券作废提交
function couponInvalidateSubmit()
{
	var studentGiftId = $("#studentGiftId").val();
	var handlerId = $("#handlerId").val();
	var rtnRemark = $("#rtnRemark").val();
	rtnRemark = string2Json(rtnRemark);
	rtnRemark = encodeURI(rtnRemark);
	var json = '{"studentGiftId":"'+studentGiftId+'","rtnRemark":"'+rtnRemark+'","handlerId":"'+handlerId+'"}';
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
		var row = $("#couponGift_data").datagrid('getSelected');
		var giftState = row.giftState;
		if(giftState == "消耗完" || giftState == "已作废"){
			$.messager.alert('提示', "该赠券状态不能延期！");
			return;
		}
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