var couponUrl = "";
var couponAction = "";
$(document).ready(function(){
    var obj = "{'queryCode':'qryCouGiftConfig','type':'COUPON'}";
    $('#couponGift_data').datagrid({  
    	//初始化查询
		border:true,  
	    fitColumns:true,  
	    singleSelect: true,  
	    pagination :true,
	  	url: "/sys/pubData/qryDataListByPage.do",
	  	queryParams:{
			param : obj
		},
	    columns:[[  
	        {field:'giftCode',title:'编号',width:'5%',align:'center'},  
	        {field:'typeName',title:'赠券类型',width:'7%',align:'center'},  
	        {field:'useType',title:'使用方式',width:'9%',align:'center'},
	        {field:'getRemark',title:'领用时效',width:'9%',align:'center'},  
	        {field:'effRemark',title:'有效期说明',width:'10%',align:'center'},  
	        {field:'isMinusVal',title:'是否抵扣学费',width:'8%',align:'center'},  
	         {field:'courseNames',title:'抵扣课程类型',width:'8%',align:'center'},  
	        {field:'effNum',title:'有效期（月）',width:'7%',align:'center'},
	        {field:'giftName',title:'赠券名称',width:'9%',align:'center'},  
	        {field:'amount',title:'价值金额',width:'7%',align:'center'},  
	        {field:'isEffVal',title:'是否有效',width:'6%',align:'center'},  
	        {field:'createDate',title:'创建时间',width:'8%',align:'center'},  
	        {field:'opt',title:'操作',width:'13%',align:'center',
	            formatter: function(Confirmation, row)
	            {  
	        		if(row.typeFlag == "true" || row.giftName == ""){
	        			var btn = '<a class="update" disabled="disabled" style="width:60px; height:25px;"  href="javascript:void(0)"><span>修改</span></a>&nbsp;<a class="delete" disabled="disabled" style="width:60px; height:25px;" href="javascript:void(0)"><span>删除</span></a>';  
		                return btn;  
	        		}else if(row.typeFlag == "false"){
		                var btn = '<a class="update" onclick="updateCouponName(\''+row.giftId+'\',\''+row.giftType+'\',\''+row.giftName+'\',\''+row.amount+'\',\''+row.isEff+'\',\''+row.getRemark+'\',\''+row.courseTypes+'\')" style="width:60px; height:25px;"  href="javascript:void(0)"><span>修改</span></a>&nbsp;<a class="delete" onclick="removeCouponName(\''+row.giftId+'\')" style="width:60px; height:25px;" href="javascript:void(0)"><span>删除</span></a>';  
		                return btn;  
	        		}
	            }  
	        }  
	    ]],  
	    onLoadSuccess:function(data){  
	        $('.update').linkbutton({text:'修改',iconCls:'icon-edit'}); 
	        $('.delete').linkbutton({text:'删除',iconCls:'icon-remove'});  
	        $('#couponGift_data').datagrid('clearSelections');
	    },
	    toolbar:"#couponToolbar"
	});  
    
});

//打开赠券类型页面
function addCouponType()
{
	$('#couponTypeDlg').dialog('open').dialog('setTitle','添加赠券类型');
	$('#couponTypeFm').form('clear');
	couponUrl = "/sys/giftConfig/addGiftTypeConfig.do";
}

//保存赠券类型信息
function saveCouponType()
{
	if($("#couponTypeFm").form('validate')){
		var obj = JSON.stringify($("#couponTypeFm").serializeObject());
		var handlerId = $("#handlerId").val();
		obj = obj.substring(0, obj.length - 1);
		obj += ",\"handlerId\":\""+handlerId+"\"}";
		$.ajax({
			type : "POST",
			url: couponUrl,
			data: "json="+obj+"&type=COUPON",
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title : '添加赠券类型', msg : '添加赠券类型中，请稍等……'});
	    	},
	    	success: function(flag) {
	    		$.messager.progress('close'); 
	    		if(flag == "true"){
	    			$.messager.alert('提示', "添加赠券类型成功！");
	    			$('#couponTypeDlg').dialog('close');
	    			window.location.reload();
	    		}else if(flag == "false"){
	    			$.messager.alert('提示', "添加赠券类型失败！");
	    		}
	        } 
		});
	}
}

//打开添加赠券名称页面
function addCouponName()
{
	$('#couponNameDlg').dialog('open').dialog('setTitle','添加赠券名称');
	$('#couponNameFm').form('clear');
	couponAction = "添加";
	couponUrl = "/sys/giftConfig/addGiftConfig.do";
	$('#giftCouponType').combobox({//联动带出相关信息
		url:"/sys/pubData/qryData.do?param={'queryCode':'Qry_Gift_Type','parentType':'COUPON'}",
		formatter:formatTypeName, 
		valueField: 'giftType', 
		textField: 'typeName', 
		panelHeight: 'auto',
	 	onChange:function(n,o)
		{
			$("#couponUseType").textbox('setValue','');
			$("#couponEffNum").numberbox('setValue','');
		    $("#couponEffRemark").textbox('setValue','');
		    $("#couponMinus").textbox('setValue','');
       		var data = $('#giftCouponType').combobox('getData');
       		if (data.length > 0)
            {
	       		for(var i = 0;i < data.length;i++){
            	  if(n == data[i].giftType){
            		 $("#couponUseType").textbox('setValue',data[i].useType);
            		 $("#couponEffNum").numberbox('setValue',data[i].effNum);
            		 $("#couponEffRemark").textbox('setValue',data[i].effRemark);
            		 if("Y" == data[i].isMinus)
            		 {
            			 $("#minusCourses").css('display','table-row');
            			 $("#couponMinus").textbox('setValue','是');
            		 }else if("N" == data[i].isMinus)
            		 {
            			  $("#minusCourses").css('display','none');
            			  $("#couponMinus").textbox('setValue','否');
            			  $("input[name='courseTypes']").each(function(i,node)
            		      {
									$(this).prop("checked","");
							});
            		 }
            		 $("#couponGiftCode").val(data[i].giftCode);
            	  }
              }
            }
		}
	});
}

//打开修改赠券名称信息
function updateCouponName(giftId,giftType,giftName,amount,isEff,getRemark,courseTypes)
{
	$('#couponNameDlg').dialog('open').dialog('setTitle','修改赠券名称');
	$('#couponNameFm').form('clear');
	couponAction = "修改";
	couponUrl = "/sys/giftConfig/updateGiftConfig.do";
	$('#couponNameFm').form('load',{
		giftId : giftId,
		giftName : giftName,
		amount : amount,
		isEff : isEff,
		getRemark:getRemark
	});
	$("input[name='isEff']").each(function(i,node){
		if(node.value == isEff)
		{
			$(this).prop("checked","checked");
		}
	});
	$("input[name='courseTypes']").each(function(i,node){
		 
		if(courseTypes.indexOf(node.value)>-1)
		{
			$(this).prop("checked","checked");
		}
	});
	$('#giftCouponType').combobox({
		url:"/sys/pubData/qryData.do?param={'queryCode':'Qry_Gift_Type','parentType':'COUPON'}",
		formatter:formatTypeName, 
		valueField: 'giftType', 
		textField: 'typeName', 
		panelHeight: 'auto',
		onLoadSuccess:function(){
			if(couponAction == "修改"){//加载成功并且是修改时带出默认值
				var data = $('#giftCouponType').combobox('getData');
				if (data.length > 0)
	            {
		       		for(var i = 0;i < data.length;i++){
		       			 if(giftType == data[i].giftType){
		       				 $('#giftCouponType').combobox('select',data[i].giftType);
		       				 $("#couponUseType").textbox('setValue',data[i].useType);
            				 $("#couponEffNum").numberbox('setValue',data[i].effNum);
            		 		 $("#couponEffRemark").textbox('setValue',data[i].effRemark);
		            		 if("Y" == data[i].isMinus){
		            			 $("#couponMinus").textbox('setValue','是');
		            			 $("#minusCourses").css('display','table-row');
		            		 }else if("N" == data[i].isMinus){
		            			 $("#couponMinus").textbox('setValue','否');
		            			 ("#minusCourses").css('display','none');
		            		 }
		       			 }
		       		}
		       	}
			}
		},
	 	onChange:function(n,o)
		{
			$("#couponUseType").textbox('setValue','');
			$("#couponEffNum").numberbox('setValue','');
		    $("#couponEffRemark").textbox('setValue','');
		    $("#couponMinus").textbox('setValue','');
       		var data = $('#giftCouponType').combobox('getData');
       		if (data.length > 0)
            {
	       		for(var i = 0;i < data.length;i++){
            	  if(n == data[i].giftType){
            		 $("#couponUseType").textbox('setValue',data[i].useType);
            		 $("#couponEffNum").numberbox('setValue',data[i].effNum);
            		 $("#couponEffRemark").textbox('setValue',data[i].effRemark);
            		 if("Y" == data[i].isMinus){
            			 $("#couponMinus").textbox('setValue','是');
            		 }else if("N" == data[i].isMinus){
            			 $("#couponMinus").textbox('setValue','否');
            		 }
            	  }
              }
            }
		}
	});
}

//保存赠券名称信息
function saveCouponName()
{
	if($("#couponNameFm").form('validate')){
		var form = $("#couponNameFm").serializeObject();
		 
		var courseTypes="";
		 $('input[name="courseTypes"]:checked').each(function()
		  {    
			courseTypes=courseTypes+$(this).val()+",";
		  });
		 
		if(courseTypes!=='')
		{
			form.courseTypes=courseTypes.substring(0, courseTypes.length - 1);
		}  
		var handlerId = $("#handlerId").val();
		var effRemark = $("#couponEffRemark").val();
		var useType = $("#couponUseType").val();
		var obj = JSON.stringify(form);
		obj = obj.substring(0, obj.length - 1);
		obj += ",\"useType\":\""+useType+"\",\"effRemark\":\""+effRemark+"\",\"handlerId\":\""+handlerId+"\"}";
		$.ajax({
			type : "POST",
			url: couponUrl,
			data: "json="+obj+"&type=COUPON",
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title : couponAction+'赠券名称', msg : couponAction+'赠券名称中，请稍等……'});
	    	},
	    	success: function(flag) {
	    		$.messager.progress('close'); 
	    		if(flag == "true"){
	    			$.messager.alert('提示', couponAction+"赠券名称成功！");
	    			$('#couponNameDlg').dialog('close');
	    			window.location.reload();
	    		}else if(flag == "false"){
	    			$.messager.alert('提示', couponAction+"赠券名称失败！");
	    		}
	        } 
		});
	}
}

//删除赠券名称
function removeCouponName(giftId)
{
	$.messager.confirm('提示','您确定要删除当前赠券名称?',function(r){	
		if(r)
		{
			$.ajax({
			type : "POST",
			url: "/sys/giftConfig/deleteGiftConfig.do",
			data: "giftId="+giftId+"&type=COUPON",
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title : '删除赠券名称', msg : '删除赠券名称，请稍等……'});
	    	},
	    	success: function(flag) {
	    		$.messager.progress('close'); 
	    		if(flag == "true"){
	    			$.messager.alert('提示', "删除赠券名称成功！");
	    			window.location.reload();
	    		}else if(flag == "false"){
	    			$.messager.alert('提示', "删除赠券名称失败！");
	    		}
	        } 
		 });
	   }
	});
}

//跳转维护赠券类型页面
function viewCouponTypeInfo()
{
	if(validateSelect("couponGift_data")) {
		var row = $("#couponGift_data").datagrid('getSelected');
		if(row.giftFlag == "false"){
			var gift = {};
			gift.giftType = row.giftType;
			gift.giftCode = row.giftCode;
			gift.typeName = row.typeName;
			gift.useType = row.useType;
			gift.isMinus = row.isMinus;
			gift.isMinusVal = row.isMinusVal;
			gift.effNum = row.effNum;
			gift.effRemark = row.effRemark;
			window.location.href = "/sys/giftConfig/viewGiftTypeInfo.do?json="+JSON.stringify(gift)+"&type=COUPON";
		}else if(row.giftFlag == "true"){
			$.messager.alert('提示', "该券类赠品类型已被关联，不能修改！");
		}
	}
}

//打开修改赠券类型页面
function updateCouponType()
{
	$('#updateCouponTypeDlg').dialog('open').dialog('setTitle','修改赠券类型');
	$('#updateCouponTypeFm').form('clear');
	$('#updateCouponTypeFm').form('load',{
		giftType : $("#giftTypeTd").val(),
		giftCode : $("#gifitCodeTd").html(),
		typeName : $("#typeNameTd").html(),
		useType : $("#useTypeTd").html(),
		effNum : $("#effNumTd").html(),
		effRemark : $("#effRemarkTd").html()
	});
	$("input[name='isMinus']").each(function(i,node){
		if(node.value == $("#isMinus").val())
		{
			$(this).prop("checked","checked");
		}
	});
}

//保存赠券类型信息
function updateCouponTypeSubmit()
{
	if($("#updateCouponTypeFm").form('validate')){
		var obj = JSON.stringify($("#updateCouponTypeFm").serializeObject());
		var handlerId = $("#handlerId").val();
		obj = obj.substring(0, obj.length - 1);
		obj += ",\"handlerId\":\""+handlerId+"\"}";
		$.ajax({
			type : "POST",
			url: "/sys/giftConfig/updateGiftTypeConfig.do",
			data: "json="+obj+"&type=COUPON",
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title :'修改赠券类型', msg : '修改赠券类型中，请稍等……'});
	    	},
	    	success: function(flag) {
	    		$.messager.progress('close'); 
	    		if(flag == "true"){
	    			$.messager.alert('提示', "修改赠券类型成功！");
	    			$('#updateCouponTypeDlg').dialog('close');
	    			window.location.href = "/sys/giftConfig/giftConfigMain.jsp";
	    		}else if(flag == "false"){
	    			$.messager.alert('提示', "修改赠券类型失败！");
	    		}
	        } 
		});
	}
}

//删除赠券类型
function removeCouponType()
{
	$.messager.confirm('提示','您确定要删除当前赠券类型?',function(r){	
		if(r)
		{
			$.ajax({
			type : "POST",
			url: "/sys/giftConfig/deleteGiftTypeConfig.do",
			data: "giftTypeId="+$("#giftTypeTd").val()+"&type=COURSE",
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title : '删除赠券类型', msg : '删除赠券类型，请稍等……'});
	    	},
	    	success: function(flag) {
	    		$.messager.progress('close'); 
	    		if(flag == "true"){
	    			$.messager.alert('提示', "删除赠券类型成功！");
	    			window.location.href = "/sys/giftConfig/giftConfigMain.jsp";
	    		}else if(flag == "false"){
	    			$.messager.alert('提示', "删除赠券类型失败！");
	    		}
	        } 
		 });
	   }
	});
}

function validateSelect(object)
{
	var flag = false;
	var obj = $("#"+object+"").datagrid('getSelections');
	if(obj.length > 0) {
		if(obj.length > 1) {
			$.messager.alert('提示', "只能选择一个赠券类型进行操作！");
		} else {
			flag = true;
		}
	} else {
		$.messager.alert('提示', "请先选择您要操作的赠券类型！");
	}
	return flag;
}