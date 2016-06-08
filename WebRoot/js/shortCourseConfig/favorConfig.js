$(document).ready(function(){
	//初始化查询
    var obj = "{'queryCode':'qryPriceSystem','type':'SHORT_FAVOR'}";
    $('#favor_data').datagrid({  
		border:true,  
	    fitColumns:true,  
	    singleSelect: true,  
	    rownumbers : true,
	    pagination :true,
	    pageList : [20, 30, 40],          // 可以设置每页记录条数的列表
		pageSize : 20,
	  	url: "/sys/shortCourseConfig/qryDataListByPage.do",
	  	queryParams:{
			param : obj
		},
	    columns:[[  
	        {field:'priceName',title:'优惠体系名称',width:'12%',align:'center'},  
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
		                var btn = '<a class="view" onclick="viewFavorPrice(\''+row.setPriceId+'\',\''+row.priceName+'\',\''+row.applySchools+'\',\''+row.effDate+'\',\''+row.isUseVal+'\',\''+row.handerName+'\',\''+row.createDate+'\')" style="width:80px; height:25px;"  href="javascript:void(0)"><span>浏览</span></a>';  
		                return btn;  
	        		}else if(row.isUse == "N"){
	        			var btn = '<a class="view" onclick="viewFavorPrice(\''+row.setPriceId+'\',\''+row.priceName+'\',\''+row.applySchools+'\',\''+row.effDate+'\',\''+row.isUseVal+'\',\''+row.handerName+'\',\''+row.createDate+'\')" style="width:80px; height:25px;"  href="javascript:void(0)"><span>浏览</span></a>&nbsp;<a class="update" onclick="updateFavorPrice(\''+row.setPriceId+'\',\''+row.shortClassId+'\',\''+row.priceName+'\',\''+row.schoolIds+'\',\''+row.applySchools+'\',\''+row.effDate+'\',\''+row.isUseVal+'\',\''+row.handerName+'\',\''+row.createDate+'\')" style="width:80px; height:25px;"  href="javascript:void(0)"><span>修改</span></a>&nbsp;<a class="delete" onclick="deleteFavorPrice(\''+row.setPriceId+'\')" style="width:80px; height:25px;"  href="javascript:void(0)"><span>删除</span></a>';  
		                return btn;  
	        		}else if(row.isUse == "X"){
	        			var btn = '<a class="view" onclick="viewFavorPrice(\''+row.setPriceId+'\',\''+row.priceName+'\',\''+row.applySchools+'\',\''+row.effDate+'\',\''+row.isUseVal+'\',\''+row.handerName+'\',\''+row.createDate+'\')" style="width:80px; height:25px;"  href="javascript:void(0)"><span>浏览</span></a>';  
		                return btn;  
	        		}
	            }  
	        }  
	    ]],  
	    onLoadSuccess:function(data){  
			$('.view').linkbutton({text:'浏览',iconCls:'icon-redo'}); 
	        $('.update').linkbutton({text:'修改',iconCls:'icon-edit'}); 
	        $('.delete').linkbutton({text:'删除',iconCls:'icon-remove'});  
	        $('#favor_data').datagrid('clearSelections');
	    },
	    toolbar:"#favorToolbar"
	});  
	   var tabs = $(".tabs").height();
	var height = $(document).height();
	var header = $(".panel-header").height();
	
	$('#favor_data').datagrid('resize', {// 适配高度
		height: height - tabs-header*5
	});
});

//定位短期课
function locatShortFavor()
{
	window.location.href = "/sys/shortCourseConfig/qryShortCourse.jsp?type=FAVOR";
}

//打开新增校区页面
function addSchools()
{
	$('#dlg').dialog({
		title:"添加适用校区",
	});
	$('#dlg').attr("src","/sys/genCourseConfig/addSchool.jsp");
	$('#dlg').dialog("open");
}

//删除相对应的行  
function delRow(rows)  
{  
    $(rows).parent("td").parent("tr").remove();  
}

//增加行
function addRow()
{
	var favorModelTR=$("#favorModelTR").clone();
	var flag=true;
	var favorTR=$("#addShortFavor").clone();
	favorTR.css("display",'table-row');
	favorTR.attr("val","favor");
	favorTR.find("td").each(function(n,node)
	{
		if(n==0)//优惠名称	
		{
			var favorName=$("#favorName").textbox('getText');
			if(favorName == undefined || favorName == ""){
				flag=false;
				$.messager.alert('提示', "请输入优惠名称！");
				return false;
			}
			$(node).html(""+favorName+"");	
		}else if(n==1)//现金优惠额度
		{
			var favorPrice=$("#favorPrice").numberbox('getText');
			if(favorPrice == undefined || favorPrice == ""){
				flag=false;
				$.messager.alert('提示', "请输入现金优惠额度！");
				return false;
			}
			$(node).html(""+favorPrice+"");
		}
	});
	if(flag)
	{
		$("#addShortFavor").after(favorTR);
		clearData("favorModelTR");
    }
}

//新增优惠提交
function addShortFavorSubmit()
{
	var priceName = $("#priceName").textbox('getValue');
	var effDate = $("#effDate").datebox('getValue');
	var schoolIds = $("#schoolIds").val();
	var handlerId = $("#handlerId").val();
	if(priceName == "" || priceName == undefined){
		$.messager.alert('提示', "请填写联报优惠体系名称！");
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
	priceT.isUse = "N";//默认未生效
	priceT.effDate = effDate;
	priceT.handlerId = handlerId;
	var favorArray = new Array();
	$("#favorTab").find('tr').each(function(i,node)
	{
		var trName=$(this).attr("val");
 
		if('favor'==trName)
		{
			 var tds=$(this).children('td');
		 
			 var favorName=tds.eq(0).html();
			 var favorPrice=tds.eq(1).html();
			 var favor = {};
			 
			 favor.shortClassId = shortClassId;
			 favor.favorName = favorName;
			 favor.favorPrice = favorPrice;
			 favor.handlerId=handlerId;
			 favorArray.push(favor);  
		 }
	});
	if(favorArray.length == 0){
		$.messager.alert('提示', "请至少添加一行优惠信息！");
		return;
	}else{
		$.ajax({
			type : "POST",
			url: "/sys/shortCourseConfig/addPriceSystem.do",
			data: "priceJson="+JSON.stringify(priceT)+"&classJson="+JSON.stringify(favorArray)+"&type=SHORT_FAVOR",
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title : '添加新优惠', msg : '添加新优惠中，请稍等……'});
	    	},
	    	success: function(state) {
	    		$.messager.progress('close'); 
	    		if(state == "1"){
	    			$.messager.alert('提示', "添加新优惠成功！","info",function(){
		    			window.location.href = "/sys/shortCourseConfig/shortCourseMain.jsp";
					});
	    		}else if(state == "2"){
	    			$.messager.alert('提示', "添加新优惠失败！");
	    		}else if(state == "3"){
	    			$.messager.alert('提示',"该校区该时间点内已一个优惠体系！","info",function(){
		    			window.location.href = "/sys/shortCourseConfig/shortCourseMain.jsp";
					});
	    		}
	        } 
		});
	}
}

//删除校区
function removeSchool(rows)  
{  
    $(rows).parent("span").remove();  
    $("#schoolIds").val("");
}

//浏览优惠体系信息
function viewFavorPrice(setPriceId,priceName,applySchools,effDate,isUseVal,handerName,createDate)
{
	var priceT = {};
	priceT.setPriceId = setPriceId;
	priceT.priceName = priceName;
	priceT.applySchools = applySchools;
	priceT.effDate = effDate;
	priceT.isUseVal = isUseVal;
	priceT.handerName = handerName;
	priceT.createDate = createDate;
	window.location.href = "/sys/shortCourseConfig/viewPriceSystem.do?json="+JSON.stringify(priceT)+"&type=FAVOR";
}

//删除优惠体系
function deleteFavorPrice(setPriceId)
{
	$.messager.confirm('提示','您确定要删除当前短期课优惠体系?',function(r){
		if(r)
		{
			$.ajax({
				type : "POST",
				url: "/sys/shortCourseConfig/deletePriceSystem.do",
				data: "setPriceId="+setPriceId+"&type=SHORT_FAVOR",
				async: false,
				beforeSend: function()
		    	{
		    		$.messager.progress({title : '删除短期课优惠体系', msg : '删除短期课优惠体系中，请稍等……'});
		    	},
		    	success: function(flag) {
		    		$.messager.progress('close'); 
		    		if(flag == "true"){
		    			$.messager.alert('提示', "删除短期课优惠体系成功！","info",function(){
		    				window.location.reload();
						});
		    		}else if(flag == "false"){
		    			$.messager.alert('提示', "删除短期课优惠体系失败！");
		    		}
		        } 
			});
		}
	});
}

//打开修改短期课优惠体系页面
function updateFavorPrice(setPriceId,shortClassId,priceName,schoolIds,applySchools,effDate,isUseVal,handerName,createDate)
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
	window.location.href = "/sys/shortCourseConfig/jumpToUpdatePrice.do?json="+JSON.stringify(priceT)+"&type=FAVOR";
}

//修改短期课优惠体系提交
function updateFavorPriceSubmit()
{
	var priceName = $("#priceName").textbox('getValue');
	var effDate = $("#effDate").datebox('getValue');
	var schoolIds = $("#schoolIds").val();
	var handlerId = $("#handlerId").val();
	if(priceName == "" || priceName == undefined){
		$.messager.alert('提示', "请填写联报优惠体系名称！");
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
	var favorArray = new Array();
	$("#favorTab").find('tr').each(function(i,node)
	{
		var trName=$(this).attr("val");
 
		if('favor'==trName)
		{
			 var tds=$(this).children('td');
		 
			 var favorName=tds.eq(0).html();
			 var favorPrice=tds.eq(1).html();
			 var favor = {};
			 var favorId = $(this).attr("favorId");
			 if(favorId != "" && favorId != undefined){
				 favor.favorId = favorId;
			 }
			 favor.favorName = favorName;
			 favor.favorPrice = favorPrice;
			 favor.handlerId=handlerId;
			 favorArray.push(favor);  
		 }
	});
	if(favorArray.length == 0){
		$.messager.alert('提示', "请至少添加一行优惠信息！");
		return;
	}else{
		$.ajax({
			type : "POST",
			url: "/sys/shortCourseConfig/updatePriceSystem.do",
			data: "priceJson="+JSON.stringify(priceT)+"&classJson="+JSON.stringify(favorArray)+"&type=SHORT_FAVOR",
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title : '修改优惠', msg : '修改优惠中，请稍等……'});
	    	},
	    	success: function(state) {
	    		$.messager.progress('close'); 
	    		if(state == "1"){
	    			$.messager.alert('提示', "修改优惠成功！","info",function(){
		    			window.location.href = "/sys/shortCourseConfig/shortCourseMain.jsp";
					});
	    		}else if(state == "2"){
	    			$.messager.alert('提示', "修改优惠失败！");
	    		}else if(state == "3"){
	    			$.messager.alert('提示',"该校区该时间点内已一个优惠体系！","info",function(){
		    			window.location.href = "/sys/shortCourseConfig/shortCourseMain.jsp";
					});
	    		}
	        } 
		});
	}
}