$(document).ready(function(){
	//初始化查询
    var obj = "{'queryCode':'qryOpenClassPlanList'}";
    $('#open_data').datagrid({  
		border:true,  
	    fitColumns:true,  
	    singleSelect: true,  
	    pagination :true,
	  	url: "/sys/pubData/qryDataListByPage.do",
	  	queryParams:{
			param : obj
		},
	    columns:[[  
	        {field:'stageId',title:'课程阶段',width:'10%',align:'center'},  
	        {field:'seqOrder',title:'年级',width:'10%',align:'center'},  
	        {field:'classType',title:'班级类型',width:'10%',align:'center'},  
	        {field:'one',title:'第1次公开课',width:'11%',align:'center'},
	        {field:'two',title:'第2次公开课',width:'11%',align:'center'},  
	        {field:'three',title:'第3次公开课',width:'11%',align:'center'},
	        {field:'four',title:'第4次公开课',width:'11%',align:'center'},  
	        {field:'grad',title:'毕业典礼',width:'11%',align:'center'},  
	        {field:'opt',title:'操作',width:'15%',align:'center',
	            formatter: function(Confirmation, row)
	            {  
	                var btn = '<a class="update" onclick="updateClassPlan(\''+row.openId+'\',\''+row.stageId+'\',\''+row.classType+'\',\''+row.one+'\',\''+row.two+'\',\''+row.three+'\',\''+row.four+'\',\''+row.grad+'\')" style="width:100px; height:25px;"  href="javascript:void(0)">修改</a>';  
	                return btn;  
	            }  
	        }  
	    ]],  
	    onLoadSuccess:function(data){  
	        $('.update').linkbutton({text:'修改',iconCls:'icon-edit'}); 
	        $('#open_data').datagrid('clearSelections');
	    }
	});  
    
});

//打开修改教质时间轴配置页面
function updateClassPlan(openId,stageId,classType,one,two,three,four,grad)
{
	$('#openDlg').dialog('open').dialog('setTitle','修改教质时间轴配置');
	$('#openFm').form('clear');
	$("#oStageTd").html(stageId);
	$("#oClassTypeTd").html(classType);
	$("#oneTd").html(one);
	$("#twoTd").html(two);
	$("#threeTd").html(three);
	$("#fourTd").html(four);
	$("#gradTd").html(grad);
	$('#openFm').form('load',{
		openId : openId,
		one : one,
		two : two,
		three : three,
		four : four,
		grad : grad
	});
}

//修改教质时间轴配置
function updateClassPlanNumSubmit()
{
	if($("#openFm").form('validate')){
		var obj = $("#openFm").serializeObject();
		obj.handlerId = $("#handlerId").val();
		obj.stageId = $("#oStageTd").html();
		obj.classType = $("#oClassTypeTd").html();
		var json = JSON.stringify(obj);
		var one = obj.one;
		var two = obj.two;
		var three = obj.three;
		var four = obj.four;
		var grad = obj.grad;
		if(parseInt(one)>=parseInt(two)){//规则校验
			$.messager.alert('提示', "第1次公开课课时不能大于第2次公开课课时！");
			return;
		}
		if(parseInt(two)>=parseInt(three)){//规则校验
			$.messager.alert('提示', "第2次公开课课时不能大于第3次公开课课时！");
			return;
		}
		if(parseInt(three)>=parseInt(four)){//规则校验
			$.messager.alert('提示', "第3次公开课课时不能大于第4次公开课课时！");
			return;
		}
		if(parseInt(four)>=parseInt(grad)){//规则校验
			$.messager.alert('提示', "第4次公开课课时不能大于毕业典礼课时！");
			return;
		}
		$.ajax({
			type : "POST",
			url: "/sys/genCourseConfig/updateClassPlan.do",
			data: "json="+json,
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title : '修改教质时间轴配置', msg : '修改教质时间轴配置中，请稍等……'});
	    	},
	    	success: function(flag) {
	    		$.messager.progress('close'); 
	    		if(flag == "true"){
	    			$.messager.alert('提示', "修改教质时间轴配置成功！","info",function(){
		    			$('#openDlg').dialog('close');
		    			window.location.reload();
					});
	    		}else if(flag == "false"){
	    			$.messager.alert('提示', "修改教质时间轴配置失败！");
	    		}
	        } 
		});
	}
}