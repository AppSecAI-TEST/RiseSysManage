$(document).ready(function(){
	//初始化查询
    var obj = "{'queryCode':'qryPriceSystem','type':'DISCOUNT_PRICE'}";
    $('#discount_data').datagrid({  
		border:true,  
	    fitColumns:true,  
	    singleSelect: true,  
	    rownumbers : true,
	    pagination :true,
	  	url: "/sys/pubData/qryDataListByPage.do",
	  	queryParams:{
			param : obj
		},
	    columns:[[  
	        {field:'priceName',title:'复读折扣名称',width:'15%',align:'center'},  
	        {field:'applySchools',title:'适用校区',width:'20%',align:'center'},
	        {field:'countRate',title:'折扣率',width:'7%',align:'center'},
	        {field:'isUseVal',title:'状态',width:'7%',align:'center'},  
	        {field:'handerName',title:'创建人',width:'7%',align:'center'},
	        {field:'createDate',title:'创建时间',width:'12%',align:'center'},  
	        {field:'opt',title:'操作',width:'32%',align:'center',
	            formatter: function(Confirmation, row)
	            {  
	        		if(row.isUse == "Y"){
		                var btn = '<a class="view" onclick="" style="width:80px; height:25px;"  href="javascript:void(0)">浏览</a>&nbsp;<a class="close" onclick="closeDiscountPrice(\''+row.setPriceId+'\',\'N\',\'DISCOUNT_PRICE\')" style="width:80px; height:25px;" href="javascript:void(0)">关闭</a>';  
		                return btn;  
	        		}else if(row.isUse == "N"){
	        			var btn = '<a class="view" onclick="" style="width:80px; height:25px;"  href="javascript:void(0)">浏览</a>&nbsp;<a class="update" onclick="" style="width:80px; height:25px;"  href="javascript:void(0)">修改</a>&nbsp;<a class="delete" onclick="deleteDiscountPrice(\''+row.setPriceId+'\')" style="width:80px; height:25px;"  href="javascript:void(0)">删除</a>&nbsp;<a class="open" onclick="openDiscountPrice(\''+row.setPriceId+'\',\'Y\',\'DISCOUNT_PRICE\')" style="width:80px; height:25px;" href="javascript:void(0)">开启</a>';  
		                return btn;  
	        		}
	            }  
	        }  
	    ]],  
	    onLoadSuccess:function(data){  
			$('.view').linkbutton({text:'浏览',iconCls:'icon-redo'}); 
	        $('.update').linkbutton({text:'修改',iconCls:'icon-edit'}); 
	        $('.delete').linkbutton({text:'删除',iconCls:'icon-remove'});  
	        $('.close').linkbutton({text:'关闭',iconCls:'icon-cancel'});  
	        $('.open').linkbutton({text:'开启',iconCls:'icon-add'});  
	        $('#discount_data').datagrid('clearSelections');
	    },
	    toolbar:"#discountToolbar"
	});  

});

function closeDiscountPrice(setPriceId,operType,priceType)
{
	$.messager.confirm('提示','您确定要关闭当前复读折扣配置?',function(r){
		if(r)
		{
			$.ajax({
				type : "POST",
				url: "/sys/genCourseConfig/updatePirceOpenState.do",
				data: "setPriceId="+setPriceId+"&operType="+operType+"&priceType=DISCOUNT_PRICE",
				async: false,
				beforeSend: function()
		    	{
		    		$.messager.progress({title : '关闭复读折扣配置', msg : '关闭复读折扣配置中，请稍等……'});
		    	},
		    	success: function(state) {
		    		$.messager.progress('close'); 
		    		if(state == "1"){
		    			$.messager.alert('提示', "关闭复读折扣配置成功！");
		    			window.location.reload();
		    		}else if(state == "2"){
		    			$.messager.alert('提示', "关闭复读折扣配置失败！");
		    		}
		        } 
			});
		}
	});
}

function openDiscountPrice(setPriceId,operType,priceType)
{
	$.messager.confirm('提示','您确定要开启当前复读折扣配置?',function(r){
		if(r)
		{
			$.ajax({
				type : "POST",
				url: "/sys/genCourseConfig/updatePirceOpenState.do",
				data: "setPriceId="+setPriceId+"&operType="+operType+"&priceType=DISCOUNT_PRICE",
				async: false,
				beforeSend: function()
		    	{
		    		$.messager.progress({title : '开启复读折扣配置', msg : '开启复读折扣配置中，请稍等……'});
		    	},
		    	success: function(state) {
		    		$.messager.progress('close'); 
		    		if(state == "1"){
		    			$.messager.alert('提示', "开启复读折扣配置成功！");
		    			window.location.reload();
		    		}else if(state == "2"){
		    			$.messager.alert('提示', "开启复读折扣配置失败！");
		    		}else{
		    			$.messager.alert('提示', state+"已经有一个复读折扣处于开启状态！");
		    			window.location.reload();
	    			}
		        } 
			});
		}
	});
}

function deleteDiscountPrice(setPriceId)
{
	$.messager.confirm('提示','您确定要删除当前复读折扣配置?',function(r){
		if(r)
		{
			$.ajax({
				type : "POST",
				url: "/sys/genCourseConfig/deletePriceSystem.do",
				data: "setPriceId="+setPriceId+"&type=DISCOUNT_PRICE",
				async: false,
				beforeSend: function()
		    	{
		    		$.messager.progress({title : '删除复读折扣配置', msg : '删除复读折扣配置中，请稍等……'});
		    	},
		    	success: function(flag) {
		    		$.messager.progress('close'); 
		    		if(flag == "true"){
		    			$.messager.alert('提示', "删除复读折扣配置成功！");
		    			window.location.reload();
		    		}else if(flag == "false"){
		    			$.messager.alert('提示', "删除复读折扣配置失败！");
		    		}
		        } 
			});
		}
	});
}

function addSchools()
{
	$('#dlg').dialog({
		title:"添加适用校区",
	});
	$('#dlg').attr("src","/sys/genCourseConfig/addSchool.jsp");
	$('#dlg').dialog("open");
}

function viewSchoolDiscountPrice()
{
	$('#disDlg').dialog({
		title:"查看校区开启折扣",
	});
	$('#disDlg').attr("src","/sys/genCourseConfig/schoolDisPriceList.jsp");
	$('#disDlg').dialog("open");
}

function addDiscountPrice()
{
	window.location.href = "/sys/genCourseConfig/jumpToAddPrice.do?type=DISCOUNT";
}

function addDiscountPriceSubmit()
{
	var priceName = $("#priceName").textbox('getValue');
	var isOpen = $("input[name='isOpen']:checked").val();
	var countRate = $("#countRate").textbox('getValue');
	var schoolIds = $("#schoolIds").val();
	var handlerId = $("#handlerId").val();
	countRate = string2Json(countRate);
	countRate = encodeURI(countRate);
	var priceT = {};
	priceT.priceName = priceName;
	priceT.schoolIds = schoolIds;
	priceT.isUse = isOpen;
	priceT.countRate = countRate;
	priceT.handlerId = handlerId;
	$.ajax({
			type : "POST",
			url: "/sys/genCourseConfig/addPriceSystem.do",
			data: "priceJson="+JSON.stringify(priceT)+"&type=DISCOUNT_PRICE",
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title : '添加新折扣', msg : '添加新折扣中，请稍等……'});
	    	},
	    	success: function(state) {
	    		$.messager.progress('close'); 
	    		if(state == "1"){
	    			$.messager.alert('提示', "添加新折扣成功！");
	    			window.location.href = "/sys/genCourseConfig/genCourseCongifMain.jsp";
	    		}else if(state == "2"){
	    			$.messager.alert('提示', "添加新折扣失败！");
	    		}else{
	    			$.messager.alert('提示', state+"已经有一个折扣配置处于开启状态！");
	    			window.location.href = "/sys/genCourseConfig/genCourseCongifMain.jsp";
	    		}
	        } 
		});
}

function removeSchool(rows)  
{  
    $(rows).parent("span").remove();  
    $("#schoolIds").val("");
}