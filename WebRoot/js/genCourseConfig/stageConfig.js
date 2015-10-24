var stageUrl = "";
var stageAction = "";
var actionType = "";
$(document).ready(function(){
	//初始化查询
    var obj = "{'queryCode':'qryStageConfig'}";
    $('#stage_data').datagrid({  
		border:true,  
	    fitColumns:true,  
	    singleSelect: true,  
	    pagination :true,
	  	url: "/sys/pubData/qryDataListByPage.do",
	  	queryParams:{
			param : obj
		},
	    columns:[[  
	    	{field:'ck',checkbox:true,width:'1%',align:'center'},  
	        {field:'stageId',title:'课程阶段',width:'12%',align:'center'},  
	        {field:'seqOrder',title:'阶段顺序',width:'12%',align:'center'},
	        {field:'classType',title:'班级类型',width:'12%',align:'center'},  
	        {field:'hours',title:'基础课时',width:'10%',align:'center'},
	        {field:'gradHours',title:'毕业典礼课时',width:'12%',align:'center'},  
	        {field:'gradRemark',title:'毕业典礼消耗时长',width:'15%',align:'center'},  
	        {field:'isOpenVal',title:'是否开放',width:'11%',align:'center'},  
	        {field:'opt',title:'操作',width:'15%',align:'center',
	            formatter: function(Confirmation, row)
	            {  
	        		if(row.typeFlag == "false"){
		                var btn = '<a class="update" onclick="updateClassType(\''+row.classId+'\',\''+row.stageId+'\',\''+row.classType+'\',\''+row.hours+'\',\''+row.gradHours+'\',\''+row.gradRemark+'\',\''+row.isOpen+'\')" style="width:80px; height:25px;"  href="javascript:void(0)">修改</a>&nbsp;<a class="delete" onclick="deleteClassType(\''+row.classId+'\')" style="width:80px; height:25px;" href="javascript:void(0)">删除</a>';  
		                return btn;  
	        		}else if(row.typeFlag == "true"){
	        			var btn = '<a class="update" disabled="disabled" style="width:80px; height:25px;"  href="javascript:void(0)">修改</a>&nbsp;<a class="delete" disabled="disabled" style="width:80px; height:25px;" href="javascript:void(0)">删除</a>';  
		                return btn;  
	        		}
	            }  
	        }  
	    ]],  
	    onLoadSuccess:function(data){  
	        $('.update').linkbutton({text:'修改',iconCls:'icon-edit'}); 
	        $('.delete').linkbutton({text:'删除',iconCls:'icon-remove'});  
	        $('#stage_data').datagrid('clearSelections');
	    },
	    toolbar:"#stageToolbar"
	});  
    
});

//打开新增课程阶段页面
function addStage()
{
	$('#stageDlg').dialog('open').dialog('setTitle','添加课程阶段');
	$('#stageFm').form('clear');
	stageUrl = "/sys/genCourseConfig/addStage.do";
	stageAction = "添加";
	actionType = "阶段";
	$("#stageId").textbox('enable');//能编辑
	$("#seqOrder").numberbox({required:true});//必须填
	$("#seqOrderTr").css("display","table-row");//显示行
}

//打开新增班级类型页面
function addClassType()
{
	if(validateSelect("stage_data")) {
		var row = $("#stage_data").datagrid('getSelected');
		$('#stageDlg').dialog('open').dialog('setTitle','添加班级类型');
		$('#stageFm').form('clear');
		stageUrl = "/sys/genCourseConfig/addClassType.do";
		stageAction = "添加";
		actionType = "班级类型";
		$('#stageFm').form('load',{
			stageId : row.stageId
		});
		$("#stageId").textbox('disable');//不能编辑
		$("#seqOrder").numberbox({required:false});//不用填
		$("#seqOrderTr").css("display","none");//隐藏
	}
}

//打开修改班级类型页面
function updateClassType(classId,stageId,classType,hours,gradHours,gradRemark,isOpen)
{
	$('#stageDlg').dialog('open').dialog('setTitle','修改班级类型');
	$('#stageFm').form('clear');
	stageUrl = "/sys/genCourseConfig/updateClassType.do";
	stageAction = "修改";
	actionType = "班级类型";
	$('#stageFm').form('load',{
		classId :classId,
		stageId : stageId,
		classType : classType,
		hours : hours,
		gradHours : gradHours,
		gradRemark : gradRemark
	});
	$("input[name='isOpen']").each(function(i,node){
		if(node.value == isOpen)
		{
			$(this).prop("checked","checked");
		}
	});
	$("#stageId").textbox('disable');//不能编辑
	$("#seqOrder").numberbox({required:false});//不必填
	$("#seqOrderTr").css("display","none");//隐藏行
}

//保存信息提交
function saveSubmit()
{
	if($("#stageFm").form('validate')){
		$("#stageId").textbox('enable');
		var obj = JSON.stringify($("#stageFm").serializeObject());
		if(actionType == "班级类型"){
			$("#stageId").textbox('disable');
		}
		var handlerId = $("#handlerId").val();
		obj = obj.substring(0, obj.length - 1);
		obj += ",\"handlerId\":\""+handlerId+"\"}";
		$.ajax({
			type : "POST",
			url: stageUrl,
			data: "json="+obj,
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title : stageAction+actionType, msg : stageAction+actionType+'中，请稍等……'});
	    	},
	    	success: function(state) {
	    		$.messager.progress('close'); 
	    		if(state == "3"){
	    			$.messager.alert('提示', stageAction+actionType+"成功！");
	    			$('#stageDlg').dialog('close');
	    			window.location.reload();
	    		}else if(state == "2"){
	    			$.messager.alert('提示', "阶段名称或者阶段顺序不能重复！");
	    			$('#stageDlg').dialog('close');
	    			window.location.reload();
	    		}else if(state == "1"){
	    			$.messager.alert('提示', stageAction+actionType+"失败！");
	    		}
	        } 
		});
	}
}

//删除班级类型
function deleteClassType(classId)
{
	$.messager.confirm('提示','您确定要删除当前班级类型?',function(r){	
		if(r)
		{
			$.ajax({
			type : "POST",
			url: "/sys/genCourseConfig/deleteClassType.do",
			data: "classId="+classId,
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title : '删除班级类型', msg : '删除班级类型中，请稍等……'});
	    	},
	    	success: function(flag) {
	    		$.messager.progress('close'); 
	    		if(flag == "true"){
	    			$.messager.alert('提示', "删除班级类型成功！");
	    			window.location.reload();
	    		}else if(flag == "false"){
	    			$.messager.alert('提示', "删除班级类型失败！");
	    		}
	        } 
		 });
	   }
	});
}

//删除阶段
function deleteStage()
{
	if(validateSelect("stage_data")) {
		var row = $("#stage_data").datagrid('getSelected');
		if(row.stageFlag == "false"){
			$.messager.confirm('提示','您确定要删除当前课程阶段?',function(r){	
				if(r)
				{
					$.ajax({
					type : "POST",
					url: "/sys/genCourseConfig/deleteStage.do",
					data: "id="+row.id+"&stageId="+row.stageId,
					async: false,
					beforeSend: function()
			    	{
			    		$.messager.progress({title : '删除课程阶段', msg : '删除课程阶段中，请稍等……'});
			    	},
			    	success: function(flag) {
			    		$.messager.progress('close'); 
			    		if(flag == "true"){
			    			$.messager.alert('提示', "删除课程阶段成功！");
			    			window.location.reload();
			    		}else if(flag == "false"){
			    			$.messager.alert('提示', "删除课程阶段失败！");
			    		}
			        } 
				 });
			   }
			});
		}else if(row.stageFlag == "true"){ //关联实例的阶段不能删除
			$.messager.alert('提示', "该课程阶段已被关联，不能删除！");
		}
	}
}

//打开修改阶段页面
function updateStage()
{
	if(validateSelect("stage_data")) {
		var row = $("#stage_data").datagrid('getSelected');
		if(row.stageFlag == "false"){
			$('#updateStageDlg').dialog('open').dialog('setTitle','修改课程阶段');
			$('#updateStageFm').form('clear');
			$('#updateStageFm').form('load',{
				id : row.id,
				stageId : row.stageId,
				seqOrder : row.seqOrder
			});
		}else if(row.stageFlag == "true"){ //关联实例的阶段不能修改
			$.messager.alert('提示', "该课程阶段已被关联，不能修改！");
		}
	}
}

//修改阶段提交
function updateStageSubmit()
{
	if($("#updateStageFm").form('validate')){
		var obj = JSON.stringify($("#updateStageFm").serializeObject());
		var handlerId = $("#handlerId").val();
		obj = obj.substring(0, obj.length - 1);
		obj += ",\"handlerId\":\""+handlerId+"\"}";
		$.ajax({
			type : "POST",
			url: "/sys/genCourseConfig/updateStage.do",
			data: "json="+obj,
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title : '修改阶段', msg : '修改阶段中，请稍等……'});
	    	},
	    	success: function(state) {
	    		$.messager.progress('close'); 
	    		if(state == "3"){
	    			$.messager.alert('提示', "修改阶段成功！");
	    			$('#updateStageDlg').dialog('close');
	    			window.location.reload();
	    		}else if(state == "2"){
	    			$.messager.alert('提示', "阶段名称或者阶段顺序不能重复！");
	    			$('#updateStageDlg').dialog('close');
	    			window.location.reload();
	    		}else if(state == "1"){
	    			$.messager.alert('提示', "修改阶段失败！");
	    		}
	        } 
		});
	}
}

function validateSelect(object)
{
	var flag = false;
	var obj = $("#"+object+"").datagrid('getSelections');
	if(obj.length > 0) {
		if(obj.length > 1) {
			$.messager.alert('提示', "只能选择一个课程阶段进行操作！");
		} else {
			flag = true;
		}
	} else {
		$.messager.alert('提示', "请先选择您要操作的课程阶段！");
	}
	return flag;
}