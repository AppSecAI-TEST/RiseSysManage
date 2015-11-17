var shortUrl = "";
var action = "";
var actionType = "";
$(document).ready(function(){
	//初始化查询
    var obj = "{'queryCode':'qryShortClass'}";
    $('#course_data').datagrid({  
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
	        {field:'className',title:'短期课名称',width:'12%',align:'center'},  
	        {field:'isTeachingVal',title:'管理类型',width:'10%',align:'center'},  
	        {field:'classType',title:'班级类型',width:'10%',align:'center'},  
	        {field:'maxNum',title:'最高开班人数',width:'11%',align:'center'},  
	        {field:'minNum',title:'最低开班人数',width:'11%',align:'center'},  
	        {field:'isOpenVal',title:'是否开放',width:'10%',align:'center'},
	        {field:'handlerName',title:'创建人',width:'10%',align:'center'},  
	        {field:'createDate',title:'创建时间',width:'10%',align:'center'},  
	        {field:'opt',title:'操作',width:'15%',align:'center',
	            formatter: function(Confirmation, row)
	            {  
        			if(row.classFlag == "false"){
		                var btn = '<a class="update" onclick="updateShortClassType(\''+row.classTypeId+'\',\''+row.className+'\',\''+row.isTeaching+'\',\''+row.classType+'\',\''+row.maxNum+'\',\''+row.minNum+'\',\''+row.isOpen+'\')" style="width:60px; height:25px;" href="javascript:void(0)">修改</a>&nbsp;<a class="delete" onclick="removeShortClassType(\''+row.classTypeId+'\')" style="width:60px; height:25px;" href="javascript:void(0)">删除</a>';  
		                return btn;  
        			}else if(row.classFlag == "true"){
        				var btn = '<a class="update" disabled="disabled" style="width:60px; height:25px;" href="javascript:void(0)">修改</a>&nbsp;<a class="delete" disabled="disabled" style="width:60px; height:25px;" href="javascript:void(0)">删除</a>';  
		                return btn;  
        			}
	            }  
	        }  
	    ]],  
	    onLoadSuccess:function(data){  
	        $('.update').linkbutton({text:'修改',iconCls:'icon-edit'}); 
	        $('.delete').linkbutton({text:'删除',iconCls:'icon-remove'});  
	        $('#course_data').datagrid('clearSelections');
	    },
	    toolbar:"#courseToolbar"
	});  
    
});

//打开新增短期课页面
function addShortCourse()
{
	$('#courseDlg').dialog('open').dialog('setTitle','添加短期课');
	$('#courseFm').form('clear');
	shortUrl = "/sys/shortCourseConfig/addShortClass.do";
	action = "添加";
	actionType = "短期课";
	$("#className").textbox('enable');//能编辑
	$("input[name='isTeaching']").each(function(i,node){
		$(this).attr("disabled",false);
	});
}

//打开新增短期课班级类型页面
function addShortClassType()
{
	if(validateSelect("course_data")) {
		var row = $("#course_data").datagrid('getSelected');
		$('#courseDlg').dialog('open').dialog('setTitle','添加短期课班级类型');
		$('#courseFm').form('clear');
		shortUrl = "/sys/shortCourseConfig/addShortClassType.do";
		action = "添加";
		actionType = "短期课班级类型";
		$('#courseFm').form('load',{
			shortClassId : row.shortClassId,
			className : row.className,
		});
		$("input[name='isTeaching']").each(function(i,node){
			if(node.value == row.isTeaching)
			{
				$(this).prop("checked","checked");
			}
		});
		$("#className").textbox('disable');//不能编辑
		$("input[name='isTeaching']").each(function(i,node){
			$(this).attr("disabled",true);
		});
	}
}

//打开修改短期课班级类型页面
function updateShortClassType(classTypeId,className,isTeaching,classType,maxNum,minNum,isOpen)
{
	$('#courseDlg').dialog('open').dialog('setTitle','修改短期课班级类型');
	$('#courseFm').form('clear');
	shortUrl = "/sys/shortCourseConfig/updateShortClassType.do";
	action = "修改";
	actionType = "短期课班级类型";
	$('#courseFm').form('load',{
		classTypeId :classTypeId,
		className : className,
		classType : classType,
		maxNum : maxNum,
		minNum : minNum,
	});
	$("input[name='isTeaching']").each(function(i,node){
		if(node.value == isTeaching)
		{
			$(this).prop("checked","checked");
		}
	});
	$("input[name='isOpen']").each(function(i,node){
		if(node.value == isOpen)
		{
			$(this).prop("checked","checked");
		}
	});
	$("#className").textbox('disable');//不能编辑
	$("input[name='isTeaching']").each(function(i,node){
		$(this).attr("disabled",true);
	});
}

//保存短期课信息
function saveCourseSubmit()
{
	if($("#courseFm").form('validate')){
		var json = $("#courseFm").serializeObject();
		var maxNum = json.maxNum;
		var minNum = json.minNum;
		if(parseInt(minNum)>parseInt(maxNum)){//规则校验
			$.messager.alert('提示', "最低开班人数不能大于最高开班人数！");
			return;
		}
		var obj = JSON.stringify(json);
		var handlerId = $("#handlerId").val();
		obj = obj.substring(0, obj.length - 1);
		obj += ",\"handlerId\":\""+handlerId+"\"}";
		$.ajax({
			type : "POST",
			url: shortUrl,
			data: "json="+obj,
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title : action+actionType, msg : action+actionType+'中，请稍等……'});
	    	},
	    	success: function(flag) {
	    		$.messager.progress('close'); 
	    		if(flag == "true"){
	    			$.messager.alert('提示', action+actionType+"成功！","info",function(){
		    			$('#courseDlg').dialog('close');
		    			window.location.reload();
					});
	    		}else if(flag == "false"){
	    			$.messager.alert('提示', action+actionType+"失败！");
	    		}
	        } 
		});
	}
}

//删除短期课
function removeShortClass()
{
	if(validateSelect("course_data")) {
		var row = $("#course_data").datagrid('getSelected');
		if(row.courseFlag == "false"){
			$.messager.confirm('提示','您确定要删除当前短期课?',function(r){	
				if(r)
				{
					$.ajax({
					type : "POST",
					url: "/sys/shortCourseConfig/deleteShortClass.do",
					data: "shortClassId="+row.shortClassId,
					async: false,
					beforeSend: function()
			    	{
			    		$.messager.progress({title : '删除短期课', msg : '删除短期课中，请稍等……'});
			    	},
			    	success: function(flag) {
			    		$.messager.progress('close'); 
			    		if(flag == "true"){
			    			$.messager.alert('提示', "删除短期课成功！","info",function(){
		    					window.location.reload();
							});
			    		}else if(flag == "false"){
			    			$.messager.alert('提示', "删除短期课失败！");
			    		}
			        } 
				 });
			   }
			});
		}else if(row.courseFlag == "true"){ //关联实例的短期课不能删除
			$.messager.alert('提示', "该课程阶段已被关联，不能删除！");
		}
	}
}

//删除短期课班级类型
function removeShortClassType(classTypeId)
{
	$.messager.confirm('提示','您确定要删除当前班级类型?',function(r){	
		if(r)
		{
			$.ajax({
			type : "POST",
			url: "/sys/shortCourseConfig/deleteShortClassType.do",
			data: "classTypeId="+classTypeId,
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title : '删除短期课班级类型', msg : '删除短期课班级类型中，请稍等……'});
	    	},
	    	success: function(flag) {
	    		$.messager.progress('close'); 
	    		if(flag == "true"){
	    			$.messager.alert('提示', "删除短期课班级类型成功！","info",function(){
		    			window.location.reload();
					});
	    		}else if(flag == "false"){
	    			$.messager.alert('提示', "删除短期课班级类型失败！");
	    		}
	        } 
		 });
	   }
	});
}

//跳转新增价格体系页面
function addShortSystem(type)
{
	if(validateSelect("list_data")) {
		var row = $("#list_data").datagrid('getSelected');
		var shortClassId = row.shortClassId;
		window.location.href = "/sys/shortCourseConfig/jumpToAddPrice.do?type="+type+"&shortClassId="+shortClassId;
	}
}

function validateSelect(object)
{
	var flag = false;
	var obj = $("#"+object+"").datagrid('getSelections');
	if(obj.length > 0) {
		if(obj.length > 1) {
			$.messager.alert('提示', "只能选择一个短期课进行操作！");
		} else {
			flag = true;
		}
	} else {
		$.messager.alert('提示', "请先选择您要操作的短期课！");
	}
	return flag;
}