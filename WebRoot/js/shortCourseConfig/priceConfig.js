var qryPriceFlag = true;
$(document).ready(function(){
	//初始化查询
    var obj = "{'queryCode':'qryPriceSystem','type':'SHORT_PRICE'}";
    $('#tt').tabs({
	    border:false,
	    onSelect:function(title,index){
	       if(index == 1 && qryPriceFlag){
			    $('#price_data').datagrid({  
					border:true,  
				    fitColumns:true,  
				    singleSelect: true,  
				    rownumbers : true,
				    pagination :true,
				  	url: "/sys/shortCourseConfig/qryDataListByPage.do",
				  	queryParams:{
						param : obj
					},
				    columns:[[  
				       	{field:'priceName',title:'价格体系名称',width:'12%',align:'center'}, 
				       	{field:'className',title:'短期课名称',width:'12%',align:'center'},
				        {field:'applySchools',title:'适用校区',width:'11%',align:'center'},
				        {field:'effDate',title:'生效时间',width:'10%',align:'center'},
				        {field:'isUseVal',title:'状态',width:'8%',align:'center'},  
				        {field:'handerName',title:'创建人',width:'10%',align:'center'},
				        {field:'createDate',title:'创建时间',width:'12%',align:'center'},  
				        {field:'opt',title:'操作',width:'25%',align:'center',
				            formatter: function(Confirmation, row)
				            {  
				        		if(row.isUse == "Y"){
					                var btn = '<a class="view" onclick="viewShortPrice(\''+row.setPriceId+'\',\''+row.priceName+'\',\''+row.applySchools+'\',\''+row.effDate+'\',\''+row.isUseVal+'\',\''+row.handerName+'\',\''+row.createDate+'\')" style="width:80px; height:25px;"  href="javascript:void(0)"><span>浏览</span></a>';  
					                return btn;  
				        		}else if(row.isUse == "N"){
				        			var btn = '<a class="view" onclick="viewShortPrice(\''+row.setPriceId+'\',\''+row.priceName+'\',\''+row.applySchools+'\',\''+row.effDate+'\',\''+row.isUseVal+'\',\''+row.handerName+'\',\''+row.createDate+'\')" style="width:80px; height:25px;"  href="javascript:void(0)"><span>浏览</span></a>&nbsp;<a class="update" onclick="updateShortPrice(\''+row.setPriceId+'\',\''+row.shortClassId+'\',\''+row.priceName+'\',\''+row.schoolIds+'\',\''+row.applySchools+'\',\''+row.effDate+'\',\''+row.isUseVal+'\',\''+row.handerName+'\',\''+row.createDate+'\')" style="width:80px; height:25px;"  href="javascript:void(0)"><span>修改</span></a>&nbsp;<a class="delete" onclick="deleteShortPrice(\''+row.setPriceId+'\')" style="width:80px; height:25px;"  href="javascript:void(0)"><span>删除</span></a>';  
					                return btn;  
				        		}else if(row.isUse == "X"){
				        			var btn = '<a class="view" onclick="viewShortPrice(\''+row.setPriceId+'\',\''+row.priceName+'\',\''+row.applySchools+'\',\''+row.effDate+'\',\''+row.isUseVal+'\',\''+row.handerName+'\',\''+row.createDate+'\')" style="width:80px; height:25px;"  href="javascript:void(0)"><span>浏览</span></a>';  
					                return btn;
				        		}
				            }  
				        }  
				    ]],  
				    onLoadSuccess:function(data){  
						$('.view').linkbutton({text:'浏览',iconCls:'icon-redo'}); 
				        $('.update').linkbutton({text:'修改',iconCls:'icon-edit'}); 
				        $('.delete').linkbutton({text:'删除',iconCls:'icon-remove'});  
				        $('#price_data').datagrid('clearSelections');
				    },
				    toolbar:"#priceToolbar"
				});  
			    qryPriceFlag = false;
	       }
	    }
	});
    
});

//定位短期课
function locatShortCourse()
{
	window.location.href = "/sys/shortCourseConfig/qryShortCourse.jsp?type=PRICE";
}

//费用A-E失焦事件，自动算是总价
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

//打开添加校区页面
function addSchools()
{
	$('#dlg').dialog({
		title:"添加适用校区",
	});
	$('#dlg').attr("src","/sys/genCourseConfig/addSchool.jsp");
	$('#dlg').dialog("open");
}

//删除校区
function removeSchool(rows)  
{  
    $(rows).parent("span").remove();  
    $("#schoolIds").val("");
}

//新增短期课价格体系提交
function addShortPriceSubmit()
{
	var priceName = $("#priceName").textbox('getValue');
	var effDate = $("#effDate").datebox('getValue');
	var schoolIds = $("#schoolIds").val();
	var handlerId = $("#handlerId").val();
	if(priceName == "" || priceName == undefined){
		$.messager.alert('提示', "请填写价格体系名称！");
		return;
	}
	if(schoolIds == "" || schoolIds == undefined){
		$.messager.alert('提示', "请选择一个适用校区！");
		return;
	}
	if(effDate == "" || effDate == undefined){
		$.messager.alert('提示', "请选择生效时间！");
		return;
	}
	if(effDate <= (new Date().format("yyyy-MM-dd"))){
		$.messager.alert('提示', "生效时间不能小于当前时间！");
		return;
	}
	var shortClassId = $("#shortClassId").val();
	var priceT = {};
	priceT.priceName = priceName;
	priceT.schoolIds = schoolIds;
	priceT.shortClassId = shortClassId;
	priceT.isUse = "N";//初始都入未生效
	priceT.effDate = effDate;
	priceT.handlerId = handlerId;
	var classArray = new Array();
	var count = 0;
	$("input[name='feeA']").each(function(index,node){
		count++;
		 var amount = $("#totalFee"+index+"").html();
		 if(amount != "" && amount != 0){
			 var classT = {};
			 var classType = $("#classType"+index+"").html();
			 var feeA = $("#feeA"+index+"").numberbox('getValue');
			 var feeB = $("#feeB"+index+"").numberbox('getValue');
			 var feeC = $("#feeC"+index+"").numberbox('getValue');
			 var feeD = $("#feeD"+index+"").numberbox('getValue');
			 var feeE = $("#feeE"+index+"").numberbox('getValue');
			 classT.shortClassId = shortClassId;
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
	if(classArray.length != count || classArray.length == 0){
		$.messager.alert('提示', "请填写每个班级费用信息！");
		return;
	}else{
		$.ajax({
			type : "POST",
			url: "/sys/shortCourseConfig/addPriceSystem.do",
			data: "priceJson="+JSON.stringify(priceT)+"&classJson="+JSON.stringify(classArray)+"&type=SHORT_PRICE",
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title : '添加新价格', msg : '添加新价格中，请稍等……'});
	    	},
	    	success: function(state) {
	    		$.messager.progress('close'); 
	    		if(state == "1"){
	    			$.messager.alert('提示', "添加新价格成功！","info",function(){
		    			window.location.href = "/sys/shortCourseConfig/shortCourseMain.jsp";
					});
	    		}else if(state == "2"){
	    			$.messager.alert('提示', "添加新价格失败！");
	    		}else if(state == "3"){
	    			$.messager.alert('提示', "该校区该时间点已经有一个短期课价格体系！",function(){
		    			window.location.href = "/sys/shortCourseConfig/shortCourseMain.jsp";
					});
	    		}
	        } 
		});
	}
}

//浏览价格体系
function viewShortPrice(setPriceId,priceName,applySchools,effDate,isUseVal,handerName,createDate)
{
	var priceT = {};
	priceT.setPriceId = setPriceId;
	priceT.priceName = priceName;
	priceT.applySchools = applySchools;
	priceT.effDate = effDate;
	priceT.isUseVal = isUseVal;
	priceT.handerName = handerName;
	priceT.createDate = createDate;
	window.location.href = "/sys/shortCourseConfig/viewPriceSystem.do?json="+JSON.stringify(priceT)+"&type=PRICE";
}

//删除价格体系
function deleteShortPrice(setPriceId)
{
	$.messager.confirm('提示','您确定要删除当前短期课价格体系?',function(r){
		if(r)
		{
			$.ajax({
				type : "POST",
				url: "/sys/shortCourseConfig/deletePriceSystem.do",
				data: "setPriceId="+setPriceId+"&type=SHORT_PRICE",
				async: false,
				beforeSend: function()
		    	{
		    		$.messager.progress({title : '删除短期课价格体系', msg : '删除短期课价格体系中，请稍等……'});
		    	},
		    	success: function(flag) {
		    		$.messager.progress('close'); 
		    		if(flag == "true"){
		    			$.messager.alert('提示', "删除短期课价格体系成功！","info",function(){
		    			window.location.reload();
					});
		    		}else if(flag == "false"){
		    			$.messager.alert('提示', "删除短期课价格体系失败！");
		    		}
		        } 
			});
		}
	});
}

//跳转修改价格体系页面
function updateShortPrice(setPriceId,shortClassId,priceName,schoolIds,applySchools,effDate,isUseVal,handerName,createDate)
{
	var priceT = {};
	priceT.setPriceId = setPriceId;
	priceT.shortClassId= shortClassId;
	priceT.priceName = priceName;
	priceT.schoolIds = schoolIds;
	priceT.applySchools = applySchools;
	priceT.effDate = effDate;
	priceT.isUseVal = isUseVal;
	priceT.handerName = handerName;
	priceT.createDate = createDate;
	window.location.href = "/sys/shortCourseConfig/jumpToUpdatePrice.do?json="+JSON.stringify(priceT)+"&type=PRICE";
}

//修改短期班价格体系提交
function updateShortPriceSubmit()
{
	var priceName = $("#priceName").textbox('getValue');
	var effDate = $("#effDate").datebox('getValue');
	var schoolIds = $("#schoolIds").val();
	var handlerId = $("#handlerId").val();
	if(priceName == "" || priceName == undefined){
		$.messager.alert('提示', "请填写价格体系名称！");
		return;
	}
	if(schoolIds == "" || schoolIds == undefined){
		$.messager.alert('提示', "请选择一个适用校区！");
		return;
	}
	if(effDate == "" || effDate == undefined){
		$.messager.alert('提示', "请选择生效时间！");
		return;
	}
	if(effDate <= (new Date().format("yyyy-MM-dd"))){
		$.messager.alert('提示', "生效时间不能小于当前时间！");
		return;
	}
	var priceT = {};
	priceT.setPriceId = $("#setPriceId").val();
	priceT.shortClassId = $("#shortClassId").val();
	priceT.priceName = priceName;
	priceT.schoolIds = schoolIds;
	priceT.effDate = effDate;
	priceT.handlerId = handlerId;
	var classArray = new Array();
	var count = 0;
	$("input[name='feeA']").each(function(index,node){
		 count++;
		 var amount = $("#totalFee"+index+"").html();
		 if(amount != "" && amount != 0){
			 var classT = {};
			 var setClassId = $("#setClassId"+index+"").val();
			 var setPriceId = $("#setPriceId"+index+"").val();
			 var shortClassId = $("#shortClassId"+index+"").val();
			 var classType = $("#classType"+index+"").html();
			 var feeA = $("#feeA"+index+"").numberbox('getValue');
			 var feeB = $("#feeB"+index+"").numberbox('getValue');
			 var feeC = $("#feeC"+index+"").numberbox('getValue');
			 var feeD = $("#feeD"+index+"").numberbox('getValue');
			 var feeE = $("#feeE"+index+"").numberbox('getValue');
			 classT.setClassId = setClassId;
			 classT.setPriceId = setPriceId;
			 classT.shortClassId = shortClassId;
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
	if(classArray.length != count || classArray.length == 0){
		$.messager.alert('提示', "请填写每个班级费用信息！");
		return;
	}else{
		$.ajax({
			type : "POST",
			url: "/sys/shortCourseConfig/updatePriceSystem.do",
			data: "priceJson="+JSON.stringify(priceT)+"&classJson="+JSON.stringify(classArray)+"&type=SHORT_PRICE",
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title : '修改价格', msg : '修改价格中，请稍等……'});
	    	},
	    	success: function(state) {
	    		$.messager.progress('close'); 
	    		if(state == "1"){
	    			$.messager.alert('提示', "修改价格成功！","info",function(){
		    			window.location.href = "/sys/shortCourseConfig/shortCourseMain.jsp";
					});
	    		}else if(state == "2"){
	    			$.messager.alert('提示', "修改价格失败！");
	    		}else if(state == "3"){
	    			$.messager.alert('提示', "该校区该时间点已经有一个短期课价格体系！","info",function(){
		    			window.location.href = "/sys/shortCourseConfig/shortCourseMain.jsp";
					});
	    		}
	        } 
		});
	}
}