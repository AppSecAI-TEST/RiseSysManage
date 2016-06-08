$(document).ready(function(){
	//初始化查询
    var obj = "{'queryCode':'qryClassNumConfig'}";
    $('#class_data').datagrid({  
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
	        {field:'stageId',title:'课程阶段',width:'14%',align:'center'},  
	        {field:'seqOrder',title:'年级',width:'12%',align:'center'},  
	        {field:'classType',title:'班级类型',width:'14%',align:'center'},  
	        {field:'maxNum',title:'最高开班人数',width:'14%',align:'center'},
	        {field:'minNum',title:'最低开班人数',width:'14%',align:'center'},  
	        {field:'expNum',title:'异常开班人数',width:'14%',align:'center'},  
	        {field:'opt',title:'操作',width:'18%',align:'center',
	            formatter: function(Confirmation, row)
	            {  
	                var btn = '<a class="update" onclick="updateClassNum(\''+row.classId+'\',\''+row.stageId+'\',\''+row.classType+'\',\''+row.maxNum+'\',\''+row.minNum+'\',\''+row.expNum+'\')" style="width:100px; height:25px;"  href="javascript:void(0)"><span>修改</span></a>';  
	                return btn;  
	            }  
	        }  
	    ]],  
	    onLoadSuccess:function(data){  
	        $('.update').linkbutton({text:'修改',iconCls:'icon-edit'}); 
	        $('#class_data').datagrid('clearSelections');
	    }
	});  
     var tabs = $(".tabs").height();
	var height = $(document).height();
	var header = $(".panel-header").height();
	
	$('#class_data').datagrid('resize', {// 适配高度
		height: height - header - tabs
	});
});

//打开修改开班人数页面
function updateClassNum(classId,stageId,classType,maxNum,minNum,expNum)
{
	$('#classDlg').dialog('open').dialog('setTitle','修改开班人数');
	$('#classFm').form('clear');
	$("#stageTd").html(stageId);
	$("#classTypeTd").html(classType);
	$("#maxTd").html(maxNum);
	$("#minTd").html(minNum);
	$("#expTd").html(expNum);
	$('#classFm').form('load',{
		classId : classId,
		maxNum : maxNum,
		minNum : minNum,
		expNum : expNum
	});
}

//修改开班人数
function updateClassNumSubmit()
{
	if($("#classFm").form('validate')){
		var obj = $("#classFm").serializeObject();
		obj.handlerId = $("#handlerId").val();
		var json = JSON.stringify(obj);
		var maxNum = obj.maxNum;
		var minNum = obj.minNum;
		var expNum = obj.expNum;
		if(parseInt(minNum)>parseInt(maxNum)){//规则校验
			$.messager.alert('提示', "最低开班人数不能大于最高开班人数！");
			return;
		}
		if(expNum != "" && parseInt(expNum)>parseInt(minNum)){
			$.messager.alert('提示', "异常开班人数不能大于最低开班人数！");
			return;
		}
		$.ajax({
			type : "POST",
			url: "/sys/genCourseConfig/updateClassNum.do",
			data: "json="+json,
			async: true,
			beforeSend: function()
	    	{
	    		$.messager.progress({title : '修改开班人数', msg : '修改开班人数中，请稍等……'});
	    	},
	    	success: function(flag) {
	    		$.messager.progress('close'); 
	    		if(flag == "true"){
	    			$.messager.alert('提示', "修改开班人数成功！","info",function(){
		    			$('#classDlg').dialog('close');
		    			window.location.reload();
					});
	    		}else if(flag == "false"){
	    			$.messager.alert('提示', "修改开班人数失败！");
	    		}
	        } 
		});
	}
}