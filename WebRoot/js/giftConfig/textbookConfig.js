var textbookUrl = "";
var textbookAction = "";
$(document).ready(function(){
	//初始化查询
    var obj = "{'queryCode':'qryGoodsGiftConfig','type':'TEXTBOOK'}";
    $('#textbook_data').datagrid({  
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
	        {field:'giftCode',title:'编号',width:'15%',align:'center'},  
	        {field:'giftName',title:'教材名称',width:'15%',align:'center'},  
	        {field:'useType',title:'使用方式',width:'20%',align:'center'},
	        {field:'getRemark',title:'领用时效',width:'20%',align:'center'},  
	        {field:'isEffVal',title:'是否有效',width:'10%',align:'center'},  
	        {field:'opt',title:'操作',width:'20%',align:'center',
	            formatter: function(Confirmation, row)
	            {  
	        		if(row.flag == "false"){
		                var btn = '<a class="update" onclick="updateTextbook(\''+row.giftId+'\',\''+row.giftCode+'\',\''+row.giftName+'\',\''+row.useType+'\',\''+row.getRemark+'\',\''+row.isEff+'\')" style="width:60px; height:25px;"  href="javascript:void(0)"><span>修改</span></a>&nbsp;<a class="delete" onclick="removeTextbook(\''+row.giftId+'\')" style="width:60px; height:25px;" href="javascript:void(0)"><span>删除</span></a>';  
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
	        $('#textbook_data').datagrid('clearSelections');
	    },
	    toolbar:"#textbookToolbar"
	});  
     var tabs = $(".tabs").height();
	var height = $(document).height();
	var header = $(".panel-header").height();
	
	$('#textbook_data').datagrid('resize', {// 适配高度
		height: height - header*3
	});
});

//打开新增教材页面
function addTextbook()
{
	$('#textbookDlg').dialog('open').dialog('setTitle','添加教材');
	$('#textbookFm').form('clear');
	textbookUrl = "/sys/giftConfig/addGiftConfig.do";
	textbookAction = "添加";
	$("#giftCodeTr").css("display","none");
}

//保存教材信息
function saveTextbookSubmit()
{
	if($("#textbookFm").form('validate')){
		var obj = JSON.stringify($("#textbookFm").serializeObject());
		var handlerId = $("#handlerId").val();
		obj = obj.substring(0, obj.length - 1);
		obj += ",\"handlerId\":\""+handlerId+"\"}";
		$.ajax({
			type : "POST",
			url: textbookUrl,
			data: "json="+obj+"&type=TEXTBOOK",
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title : textbookAction+'教材', msg : textbookAction+'教材中，请稍等……'});
	    	},
	    	success: function(flag) {
	    		$.messager.progress('close'); 
	    		if(flag == "true"){
	    			$.messager.alert('提示', textbookAction+"教材成功！");
	    			$('#textbookDlg').dialog('close');
	    			window.location.reload();
	    		}else if(flag == "false"){
	    			$.messager.alert('提示', textbookAction+"教材失败！");
	    		}
	        } 
		});
	}
}

//打开修改教材信息页面
function updateTextbook(giftId,giftCode,giftName,useType,getRemark,isEff){
	$('#textbookDlg').dialog('open').dialog('setTitle','修改教材');
	$('#textbookFm').form('clear');
	$('#textbookFm').form('load',{
		giftId : giftId,
		giftCode : giftCode,
		giftName : giftName,
		useType : useType,
		getRemark : getRemark,
		isEff : isEff
	});
	$("input[name='isEff']").each(function(i,node){
		if(node.value == isEff)
		{
			$(this).prop("checked","checked");
		}
	});
    textbookUrl = "/sys/giftConfig/updateGiftConfig.do";
	textbookAction = "修改";
	$("#giftCodeTr").css("display","table-row");
}

//删除教材
function removeTextbook(giftId)
{
	$.messager.confirm('提示','您确定要删除当前教材?',function(r){	
		if(r)
		{
			$.ajax({
			type : "POST",
			url: "/sys/giftConfig/deleteGiftConfig.do",
			data: "giftId="+giftId+"&type=TEXTBOOK",
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title : '删除教材', msg : '删除教材中，请稍等……'});
	    	},
	    	success: function(flag) {
	    		$.messager.progress('close'); 
	    		if(flag == "true"){
	    			$.messager.alert('提示', "删除教材成功！");
	    			window.location.reload();
	    		}else if(flag == "false"){
	    			$.messager.alert('提示', "删除教材失败！");
	    		}
	        } 
		 });
	   }
	});
}