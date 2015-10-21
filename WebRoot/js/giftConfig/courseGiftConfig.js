var courseUrl = "";
var courseAction = "";
$(document).ready(function(){
	//初始化查询
    var obj = "{'queryCode':'qryCouGiftConfig','type':'COURSE'}";
    $('#courseGift_data').datagrid({  
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
	        {field:'typeName',title:'赠课类型',width:'8%',align:'center'},  
	        {field:'manageTypeVal',title:'管理类别',width:'8%',align:'center'},
	        {field:'effRemark',title:'有效期说明',width:'15%',align:'center'},  
	        {field:'effNum',title:'有效期（年）',width:'8%',align:'center'},  
	        {field:'giftName',title:'赠课名称',width:'10%',align:'center'},  
	        {field:'amount',title:'价值金额',width:'8%',align:'center'},
	        {field:'giftNum',title:'次数',width:'8%',align:'center'},  
	        {field:'isEffVal',title:'是否有效',width:'8%',align:'center'},  
	        {field:'createDate',title:'创建时间',width:'8%',align:'center'},  
	        {field:'opt',title:'操作',width:'13%',align:'center',
	            formatter: function(Confirmation, row)
	            {  
	        		if(row.typeFlag == "true" || row.giftName == ""){
	        			var btn = '<a class="update" disabled="disabled" style="width:60px; height:25px;"  href="javascript:void(0)">修改</a>&nbsp;<a class="delete" disabled="disabled" style="width:60px; height:25px;" href="javascript:void(0)">删除</a>';  
		                return btn;  
	        		}else if(row.typeFlag == "false"){
		                var btn = '<a class="update" onclick="updateCourseName(\''+row.giftId+'\',\''+row.giftType+'\',\''+row.giftName+'\',\''+row.amount+'\',\''+row.giftNum+'\',\''+row.isEff+'\')" style="width:60px; height:25px;"  href="javascript:void(0)">修改</a>&nbsp;<a class="delete" onclick="removeCourseName(\''+row.giftId+'\')" style="width:60px; height:25px;" href="javascript:void(0)">删除</a>';  
		                return btn;  
	        		}
	            }  
	        }  
	    ]],  
	    onLoadSuccess:function(data){  
	        $('.update').linkbutton({text:'修改',iconCls:'icon-edit'}); 
	        $('.delete').linkbutton({text:'删除',iconCls:'icon-remove'});  
	        $('#courseGift_data').datagrid('clearSelections');
	    },
	    toolbar:"#courseToolbar"
	});  
    
});

//打开添加赠课类型页面
function addCourseType()
{
	$('#courseTypeDlg').dialog('open').dialog('setTitle','添加赠课类型');
	$('#courseTypeFm').form('clear');
	courseUrl = "/sys/giftConfig/addGiftTypeConfig.do";
}

//保存赠课类型信息
function saveCourseType()
{
	if($("#courseTypeFm").form('validate')){
		var obj = JSON.stringify($("#courseTypeFm").serializeObject());
		var handlerId = $("#handlerId").val();
		obj = obj.substring(0, obj.length - 1);
		obj += ",\"handlerId\":\""+handlerId+"\"}";
		$.ajax({
			type : "POST",
			url: courseUrl,
			data: "json="+obj+"&type=COURSE",
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title : '添加赠课类型', msg : '添加赠课类型中，请稍等……'});
	    	},
	    	success: function(flag) {
	    		$.messager.progress('close'); 
	    		if(flag == "true"){
	    			$.messager.alert('提示', "添加赠课类型成功！");
	    			$('#courseTypeDlg').dialog('close');
	    			window.location.reload();
	    		}else if(flag == "false"){
	    			$.messager.alert('提示', "添加赠课类型失败！");
	    		}
	        } 
		});
	}
}

//打开添加赠课名称页面
function addCourseName()
{
	$('#courseNameDlg').dialog('open').dialog('setTitle','添加赠课名称');
	$('#courseNameFm').form('clear');
	courseAction = "添加";
	courseUrl = "/sys/giftConfig/addGiftConfig.do";
	$('#giftCourseType').combobox({//联动信息带出
		url:"/sys/pubData/qryData.do?param={'queryCode':'Qry_Gift_Type','parentType':'COURSE'}",
		formatter:formatTypeName, 
		valueField: 'giftType', 
		textField: 'typeName', 
		panelHeight: 'auto',
	 	onChange:function(n,o)
		{
			$("#manageType").textbox('setValue','');
			$("#courseEffNum").numberbox('setValue','');
		    $("#courseEffRemark").textbox('setValue','');
       		var data = $('#giftCourseType').combobox('getData');
       		if (data.length > 0)
            {
	       		for(var i = 0;i < data.length;i++){
            	  if(n == data[i].giftType){
            		 if("BOOK" == data[i].manageType){
            			 $("#manageType").textbox('setValue','预约赠课');
            		 }else if("SHORT" == data[i].manageType){
            			 $("#manageType").textbox('setValue','短期赠课');
            		 }
            		 $("#courseEffNum").numberbox('setValue',data[i].effNum);
            		 $("#courseEffRemark").textbox('setValue',data[i].effRemark);
            		 $("#courseGiftCode").val(data[i].giftCode);
            	  }
              }
            }
		}
	});
}

//打开修改赠课名称页面
function updateCourseName(giftId,giftType,giftName,amount,giftNum,isEff)
{
	$('#courseNameDlg').dialog('open').dialog('setTitle','修改赠课名称');
	$('#courseNameFm').form('clear');
	courseAction = "修改";
	courseUrl = "/sys/giftConfig/updateGiftConfig.do";
	$('#courseNameFm').form('load',{
		giftId : giftId,
		giftName : giftName,
		amount : amount,
		giftNum : giftNum,
		isEff : isEff
	});
	$("input[name='isEff']").each(function(i,node){
		if(node.value == isEff)
		{
			$(this).prop("checked","checked");
		}
	});
	$('#giftCourseType').combobox({
		url:"/sys/pubData/qryData.do?param={'queryCode':'Qry_Gift_Type','parentType':'COURSE'}",
		formatter:formatTypeName, 
		valueField: 'giftType', 
		textField: 'typeName', 
		panelHeight: 'auto',
		onLoadSuccess:function(){
			if(courseAction == "修改"){//成功后并且是修改才执行 默认选中值
				var data = $('#giftCourseType').combobox('getData');
				if (data.length > 0)
	            {
		       		for(var i = 0;i < data.length;i++){
		       			 if(giftType == data[i].giftType){
		       				 $('#giftCourseType').combobox('select',data[i].giftType);
		       				 if("BOOK" == data[i].manageType){
	            				 $("#manageType").textbox('setValue','预约赠课');
	            			 }else if("SHORT" == data[i].manageType){
	            			 	$("#manageType").textbox('setValue','短期赠课');
	            			 }
	            			 $("#courseEffNum").numberbox('setValue',data[i].effNum);
	            		 	 $("#courseEffRemark").textbox('setValue',data[i].effRemark);
		       			 }
		       		}
		       	}
			}
		},
	 	onChange:function(n,o)
		{
			$("#manageType").textbox('setValue','');
			$("#courseEffNum").numberbox('setValue','');
		    $("#courseEffRemark").textbox('setValue','');
       		var data = $('#giftCourseType').combobox('getData');
       		if (data.length > 0)
            {
	       		for(var i = 0;i < data.length;i++){
            	  if(n == data[i].giftType){
            		 if("BOOK" == data[i].manageType){
            			 $("#manageType").textbox('setValue','预约赠课');
            		 }else if("SHORT" == data[i].manageType){
            			 $("#manageType").textbox('setValue','短期赠课');
            		 }
            		 $("#courseEffNum").numberbox('setValue',data[i].effNum);
            		 $("#courseEffRemark").textbox('setValue',data[i].effRemark);
            	  }
              }
            }
		}
	});
}

//保存赠课名称信息
function saveCourseName()
{
	if($("#courseNameFm").form('validate')){
		var obj = JSON.stringify($("#courseNameFm").serializeObject());
		var handlerId = $("#handlerId").val();
		var effRemark = $("#courseEffRemark").val();
		obj = obj.substring(0, obj.length - 1);
		obj += ",\"effRemark\":\""+effRemark+"\",\"handlerId\":\""+handlerId+"\"}";
		$.ajax({
			type : "POST",
			url: courseUrl,
			data: "json="+obj+"&type=COURSE",
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title : courseAction+'赠课名称', msg : courseAction+'赠课名称中，请稍等……'});
	    	},
	    	success: function(flag) {
	    		$.messager.progress('close'); 
	    		if(flag == "true"){
	    			$.messager.alert('提示', courseAction+"赠课名称成功！");
	    			$('#courseNameDlg').dialog('close');
	    			window.location.reload();
	    		}else if(flag == "false"){
	    			$.messager.alert('提示', courseAction+"赠课名称失败！");
	    		}
	        } 
		});
	}
}

//删除赠课名称
function removeCourseName(giftId)
{
	$.messager.confirm('提示','您确定要删除当前赠课名称?',function(r){	
		if(r)
		{
			$.ajax({
			type : "POST",
			url: "/sys/giftConfig/deleteGiftConfig.do",
			data: "giftId="+giftId+"&type=COURSE",
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title : '删除赠课名称', msg : '删除赠课名称，请稍等……'});
	    	},
	    	success: function(flag) {
	    		$.messager.progress('close'); 
	    		if(flag == "true"){
	    			$.messager.alert('提示', "删除赠课名称成功！");
	    			window.location.reload();
	    		}else if(flag == "false"){
	    			$.messager.alert('提示', "删除赠课名称失败！");
	    		}
	        } 
		 });
	   }
	});
}

//跳转维护赠课页面
function viewCourseTypeInfo()
{
	if(validateSelect("courseGift_data")) {
		var row = $("#courseGift_data").datagrid('getSelected');
		if(row.giftFlag == "false"){
			var gift = {};
			gift.giftType = row.giftType;
			gift.giftCode = row.giftCode;
			gift.typeName = row.typeName;
			gift.manageType = row.manageType;
			gift.manageTypeVal = row.manageTypeVal;
			gift.effNum = row.effNum;
			gift.effRemark = row.effRemark;
			window.location.href = "/sys/giftConfig/viewGiftTypeInfo.do?json="+JSON.stringify(gift)+"&type=COURSE";
		}else if(row.giftFlag == "true"){
			$.messager.alert('提示', "该课程赠品类型已被关联，不能修改！");
		}
	}
}

//打开修改赠课类型
function updateCourseType()
{
	$('#updateCourseTypeDlg').dialog('open').dialog('setTitle','修改赠课类型');
	$('#updateCourseTypeFm').form('clear');
	$('#updateCourseTypeFm').form('load',{
		giftType : $("#giftTypeTd").val(),
		giftCode : $("#gifitCodeTd").html(),
		typeName : $("#typeNameTd").html(),
		effNum : $("#effNumTd").html(),
		effRemark : $("#effRemarkTd").html()
	});
	$("input[name='manageType']").each(function(i,node){
		if(node.value == $("#manageTypeTd").val())
		{
			$(this).prop("checked","checked");
		}
	});
}

//保存赠课类型
function updateCourseTypeSubmit()
{
	if($("#updateCourseTypeFm").form('validate')){
		var obj = JSON.stringify($("#updateCourseTypeFm").serializeObject());
		var handlerId = $("#handlerId").val();
		obj = obj.substring(0, obj.length - 1);
		obj += ",\"handlerId\":\""+handlerId+"\"}";
		$.ajax({
			type : "POST",
			url: "/sys/giftConfig/updateGiftTypeConfig.do",
			data: "json="+obj+"&type=COURSE",
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title :'修改赠课类型', msg : '修改赠课类型中，请稍等……'});
	    	},
	    	success: function(flag) {
	    		$.messager.progress('close'); 
	    		if(flag == "true"){
	    			$.messager.alert('提示', "修改赠课类型成功！");
	    			$('#updateCourseTypeDlg').dialog('close');
	    			window.location.href = "/sys/giftConfig/giftConfigMain.jsp";
	    		}else if(flag == "false"){
	    			$.messager.alert('提示', "修改赠课类型失败！");
	    		}
	        } 
		});
	}
}

//删除赠课类型
function removeCourseType()
{
	$.messager.confirm('提示','您确定要删除当前赠课类型?',function(r){	
		if(r)
		{
			$.ajax({
			type : "POST",
			url: "/sys/giftConfig/deleteGiftTypeConfig.do",
			data: "giftTypeId="+$("#giftTypeTd").val()+"&type=COURSE",
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title : '删除赠课类型', msg : '删除赠课类型，请稍等……'});
	    	},
	    	success: function(flag) {
	    		$.messager.progress('close'); 
	    		if(flag == "true"){
	    			$.messager.alert('提示', "删除赠课类型成功！");
	    			window.location.href = "/sys/giftConfig/giftConfigMain.jsp";
	    		}else if(flag == "false"){
	    			$.messager.alert('提示', "删除赠课类型失败！");
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
			$.messager.alert('提示', "只能选择一个赠课类型进行操作！");
		} else {
			flag = true;
		}
	} else {
		$.messager.alert('提示', "请先选择您要操作的赠课类型！");
	}
	return flag;
}