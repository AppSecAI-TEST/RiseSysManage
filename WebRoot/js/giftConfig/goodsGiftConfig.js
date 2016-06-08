var goodsUrl = "";
var goodsAction = "";
$(document).ready(function(){
	//初始化查询
    var obj = "{'queryCode':'qryGoodsGiftConfig','type':'GOODS'}";
    $('#goodsGift_data').datagrid({  
		border:true,  
	    fitColumns:true,  
	    singleSelect: true,  
	    pagination :true,
	    pageList : [20, 30, 40],          // 可以设置每页记录条数的列表
		pageSize : 20, 
	  	url: "/sys/pubData/qryDataListByPage.do",
	  	queryParams:{
			param : obj
		},
	    columns:[[  
	        {field:'giftCode',title:'编号',width:'5%',align:'center'},  
	        {field:'giftName',title:'品名',width:'10%',align:'center'},  
	        {field:'useType',title:'使用方式',width:'15%',align:'center'},
	        {field:'getRemark',title:'领用时效',width:'15%',align:'center'},  
	        {field:'effRemark',title:'有效期',width:'15%',align:'center'},  
	        {field:'isEffVal',title:'是否有效',width:'8%',align:'center'},  
	        {field:'createDate',title:'创建时间',width:'12%',align:'center'},
	        {field:'handerName',title:'创建人',width:'5%',align:'center'},  
	        {field:'opt',title:'操作',width:'13%',align:'center',
	            formatter: function(Confirmation, row)
	            {  
	        		if(row.flag == "false"){
		                var btn = '<a class="update" onclick="updateGoods(\''+row.giftId+'\',\''+row.giftCode+'\',\''+row.giftName+'\',\''+row.amount+'\',\''+row.useType+'\',\''+row.getRemark+'\',\''+row.effRemark+'\',\''+row.isEff+'\')" style="width:60px; height:25px;"  href="javascript:void(0)"><span>修改</span></a>&nbsp;<a class="delete" onclick="removeGoods(\''+row.giftId+'\')" style="width:60px; height:25px;" href="javascript:void(0)"><span>删除</span></a>';  
		                return btn;  
	        		}else if(row.flag == "true"){
	        			var btn = '<a class="update" disabled="disabled" style="width:60px; height:25px;"  href="javascript:void(0)"><span>修改</span></a>&nbsp;<a class="delete" disabled="disabled" style="width:60px; height:25px;" href="javascript:void(0)"><span>删除</span></a>';  
		                return btn;  
	        		}
	            }  
	        }  
	    ]],  
	    onLoadSuccess:function(data){  
	        $('.update').linkbutton({text:'修改',iconCls:'icon-edit'}); 
	        $('.delete').linkbutton({text:'删除',iconCls:'icon-remove'});  
	        $('#goodsGift_data').datagrid('clearSelections');
	    },
	    toolbar:"#goodsToolbar"
	});  
     var tabs = $(".tabs").height();
    var bars=$(".toolbar").height(); 
	var height = $(document).height();
	var header = $(".panel-header").height();
	
	$('#goodsGift_data').datagrid('resize', {// 适配高度
		height: height - header - tabs*2
	});
});

//打开实物增加页面
function addGoods()
{
	$('#goodsDlg').dialog('open').dialog('setTitle','添加实物赠品');
	$('#goodsFm').form('clear');
	goodsUrl = "/sys/giftConfig/addGiftConfig.do";
	goodsAction = "添加";
	$("#giftCodeTr").css("display","none");
}

//保存信息
function saveGoodsSubmit()
{
	if($("#goodsFm").form('validate')){
		var obj = JSON.stringify($("#goodsFm").serializeObject());
		var handlerId = $("#handlerId").val();
		obj = obj.substring(0, obj.length - 1);
		obj += ",\"handlerId\":\""+handlerId+"\"}";
		$.ajax({
			type : "POST",
			url: goodsUrl,
			data: "json="+obj+"&type=GOODS",
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title : goodsAction+'实物赠品', msg : goodsAction+'实物赠品中，请稍等……'});
	    	},
	    	success: function(flag) {
	    		$.messager.progress('close'); 
	    		if(flag == "true"){
	    			$.messager.alert('提示', goodsAction+"实物赠品成功！");
	    			$('#goodsDlg').dialog('close');
	    			window.location.reload();
	    		}else if(flag == "false"){
	    			$.messager.alert('提示', goodsAction+"实物赠品失败！");
	    		}
	        } 
		});
	}
}

//打开保存实物修改页面
function updateGoods(giftId,giftCode,giftName,amount,useType,getRemark,effRemark,isEff){
	$('#goodsDlg').dialog('open').dialog('setTitle','修改实物赠品');
	$('#goodsFm').form('clear');
	$('#goodsFm').form('load',{
		giftId : giftId,
		giftCode : giftCode,
		giftName : giftName,
		amount : amount,
		useType : useType,
		getRemark : getRemark,
		effRemark : effRemark,
		isEff : isEff
	});
	$("input[name='isEff']").each(function(i,node){
		if(node.value == isEff)
		{
			$(this).prop("checked","checked");
		}
	});
    goodsUrl = "/sys/giftConfig/updateGiftConfig.do";
	goodsAction = "修改";
	$("#giftCodeTr").css("display","table-row");
}

//删除实物
function removeGoods(giftId)
{
	$.messager.confirm('提示','您确定要删除当前实物赠品?',function(r){	
		if(r)
		{
			$.ajax({
			type : "POST",
			url: "/sys/giftConfig/deleteGiftConfig.do",
			data: "giftId="+giftId+"&type=GOODS",
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title : '删除实物赠品', msg : '删除实物赠品中，请稍等……'});
	    	},
	    	success: function(flag) {
	    		$.messager.progress('close'); 
	    		if(flag == "true"){
	    			$.messager.alert('提示', "删除实物赠品成功！");
	    			window.location.reload();
	    		}else if(flag == "false"){
	    			$.messager.alert('提示', "删除实物赠品失败！");
	    		}
	        } 
		 });
	   }
	});
}