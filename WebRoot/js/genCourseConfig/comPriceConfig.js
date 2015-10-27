var qryComFlag = true;
$(document).ready(function(){
	//初始化查询
    var obj = "{'queryCode':'qryPriceSystem','type':'COMMON_PRICE'}";
    $('#tt').tabs({
	    border:false,
	    onSelect:function(title,index){
	       if(index == 2 && qryComFlag){
			    $('#common_data').datagrid({  
					border:true,  
				    fitColumns:true,  
				    singleSelect: true,  
				    rownumbers : true,
				    pagination :true,
				  	url: "/sys/genCourseConfig/qryDataListByPage.do",
				  	queryParams:{
						param : obj
					},
				    columns:[[  
				        {field:'priceName',title:'价格体系名称',width:'15%',align:'center'},  
				        {field:'applySchools',title:'适用校区',width:'25%',align:'center'},
				        {field:'isUseVal',title:'状态',width:'7%',align:'center'},  
				        {field:'handerName',title:'创建人',width:'8%',align:'center'},
				        {field:'createDate',title:'创建时间',width:'13%',align:'center'},  
				        {field:'opt',title:'操作',width:'32%',align:'center',
				            formatter: function(Confirmation, row)
				            {  
				        		if(row.isUse == "Y"){
					                var btn = '<a class="view" onclick="" style="width:80px; height:25px;"  href="javascript:void(0)">浏览</a>&nbsp;<a class="close" onclick="closeComPrice(\''+row.setPriceId+'\',\'N\',\'COMMON_PRICE\')" style="width:80px; height:25px;" href="javascript:void(0)">关闭</a>';  
					                return btn;  
				        		}else if(row.isUse == "N"){
				        			var btn = '<a class="view" onclick="" style="width:80px; height:25px;"  href="javascript:void(0)">浏览</a>&nbsp;<a class="update" onclick="" style="width:80px; height:25px;"  href="javascript:void(0)">修改</a>&nbsp;<a class="delete" onclick="deleteComPrice(\''+row.setPriceId+'\')" style="width:80px; height:25px;"  href="javascript:void(0)">删除</a>&nbsp;<a class="open" onclick="openComPrice(\''+row.setPriceId+'\',\'Y\',\'COMMON_PRICE\')" style="width:80px; height:25px;" href="javascript:void(0)">开启</a>';  
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
				        $("#upApplySchools").html(data.unapplySchools+"，上述校区没有开启的价格体系！");
				        $('#common_data').datagrid('clearSelections');
				    },
				    toolbar:"#commonToolbar"
				});  
			    qryComFlag = false;
	       }
	    }
	});
    
});

function closeComPrice(setPriceId,operType,priceType)
{
	$.messager.confirm('提示','您确定要关闭当前课程价格体系?',function(r){
		if(r)
		{
			$.ajax({
				type : "POST",
				url: "/sys/genCourseConfig/updatePirceOpenState.do",
				data: "setPriceId="+setPriceId+"&operType="+operType+"&priceType=COMMON_PRICE",
				async: false,
				beforeSend: function()
		    	{
		    		$.messager.progress({title : '关闭课程价格体系', msg : '关闭课程价格体系中，请稍等……'});
		    	},
		    	success: function(state) {
		    		$.messager.progress('close'); 
		    		if(state == "1"){
		    			$.messager.alert('提示', "关闭课程价格体系成功！");
		    			window.location.reload();
		    		}else if(state == "2"){
		    			$.messager.alert('提示', "关闭课程价格体系失败！");
		    		}
		        } 
			});
		}
	});
}

function openComPrice(setPriceId,operType,priceType)
{
	$.messager.confirm('提示','您确定要开启当前课程价格体系?',function(r){
		if(r)
		{
			$.ajax({
				type : "POST",
				url: "/sys/genCourseConfig/updatePirceOpenState.do",
				data: "setPriceId="+setPriceId+"&operType="+operType+"&priceType=COMMON_PRICE",
				async: false,
				beforeSend: function()
		    	{
		    		$.messager.progress({title : '开启课程价格体系', msg : '开启课程价格体系中，请稍等……'});
		    	},
		    	success: function(state) {
		    		$.messager.progress('close'); 
		    		if(state == "1"){
		    			$.messager.alert('提示', "开启课程价格体系成功！");
		    			window.location.reload();
		    		}else if(state == "2"){
		    			$.messager.alert('提示', "开启课程价格体系失败！");
		    		}else{
		    			$.messager.alert('提示', state+"已经有一个价格体系处于开启状态！");
		    			window.location.reload();
	    			}
		        } 
			});
		}
	});
}

function deleteComPrice(setPriceId)
{
	$.messager.confirm('提示','您确定要删除当前课程价格体系?',function(r){
		if(r)
		{
			$.ajax({
				type : "POST",
				url: "/sys/genCourseConfig/deletePriceSystem.do",
				data: "setPriceId="+setPriceId+"&type=COMMON_PRICE",
				async: false,
				beforeSend: function()
		    	{
		    		$.messager.progress({title : '删除课程价格体系', msg : '删除课程价格体系中，请稍等……'});
		    	},
		    	success: function(flag) {
		    		$.messager.progress('close'); 
		    		if(flag == "true"){
		    			$.messager.alert('提示', "删除课程价格体系成功！");
		    			window.location.reload();
		    		}else if(flag == "false"){
		    			$.messager.alert('提示', "删除课程价格体系失败！");
		    		}
		        } 
			});
		}
	});
}

function addComPrice()
{
	window.location.href = "/sys/genCourseConfig/jumpToAddPrice.do?type=COMMON";
}

function sumFee(index)
{
	var feeA = $("#feeA"+index+"").numberbox('getValue');
	var feeB = $("#feeB"+index+"").numberbox('getValue');
	var feeC = $("#feeC"+index+"").numberbox('getValue');
	var feeD = $("#feeD"+index+"").numberbox('getValue');
	var feeE = $("#feeE"+index+"").numberbox('getValue');
	var totalFee = 0;
	if(feeA != ""){
		totalFee += parseInt(feeA);
	}
	if(feeB != ""){
		totalFee += parseInt(feeB);
	}
	if(feeC != ""){
		totalFee += parseInt(feeC);
	}
	if(feeD != ""){
		totalFee += parseInt(feeD);
	}
	if(feeE != ""){
		totalFee += parseInt(feeE);
	}
	$("#totalFee"+index+"").html(totalFee);
}

function addSchools()
{
	$('#dlg').dialog({
		title:"添加适用校区",
	});
	$('#dlg').attr("src","/sys/genCourseConfig/addSchool.jsp");
	$('#dlg').dialog("open");
}

function viewSchoolComPrice()
{
	$('#comDlg').dialog({
		title:"校区开启价格体系",
	});
	$('#comDlg').attr("src","/sys/genCourseConfig/schoolComPriceList.jsp");
	$('#comDlg').dialog("open");
}

function addComPriceSubmit()
{
	var priceName = $("#priceName").textbox('getValue');
	var isOpen = $("input[name='isOpen']:checked").val();
	var schoolIds = $("#schoolIds").val();
	var handlerId = $("#handlerId").val();
	var priceT = {};
	priceT.priceName = priceName;
	priceT.schoolIds = schoolIds;
	priceT.isUse = isOpen;
	priceT.handlerId = handlerId;
	var classArray = new Array();
	$("input[name='feeA']").each(function(index,node){
		 var amount = $("#totalFee"+index+"").html();
		 if(amount != "" && amount != 0){
			 var classT = {};
			 var stageId = $("#stageId"+index+"").html();
			 var classType = $("#classType"+index+"").html();
			 var feeA = $("#feeA"+index+"").numberbox('getValue');
			 var feeB = $("#feeB"+index+"").numberbox('getValue');
			 var feeC = $("#feeC"+index+"").numberbox('getValue');
			 var feeD = $("#feeD"+index+"").numberbox('getValue');
			 var feeE = $("#feeE"+index+"").numberbox('getValue');
			 classT.stageId = stageId;
			 classT.classType = classType;
			 classT.feeA = feeA;
			 classT.feeB = feeB;
			 classT.feeC = feeC;
			 classT.feeD = feeD;
			 classT.feeE = feeE;
			 classT.amount = amount;
			 classT.handlerId = handlerId;
			 classArray.push(classT);
		 }
	});
	if(classArray.length == 0){
		
	}else{
		$.ajax({
			type : "POST",
			url: "/sys/genCourseConfig/addPriceSystem.do",
			data: "priceJson="+JSON.stringify(priceT)+"&classJson="+JSON.stringify(classArray)+"&type=COMMON_PRICE",
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title : '添加新价格', msg : '添加新价格中，请稍等……'});
	    	},
	    	success: function(state) {
	    		$.messager.progress('close'); 
	    		if(state == "1"){
	    			$.messager.alert('提示', "添加新价格成功！");
	    			window.location.href = "/sys/genCourseConfig/genCourseCongifMain.jsp";
	    		}else if(state == "2"){
	    			$.messager.alert('提示', "添加新价格失败！");
	    		}else{
	    			$.messager.alert('提示', state+"已经有一个价格体系处于开启状态！");
	    			window.location.href = "/sys/genCourseConfig/genCourseCongifMain.jsp";
	    		}
	        } 
		});
	}
}

function removeSchool(rows)  
{  
    $(rows).parent("span").remove();  
    $("#schoolIds").val("");
}