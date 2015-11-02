$(document).ready(function(){
	//初始化查询
    var obj = "{'queryCode':'qryPriceSystem','type':'FAVOR_PRICE'}";
    $('#link_data').datagrid({  
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
	        {field:'priceName',title:'连报优惠体系名称',width:'15%',align:'center'},  
	        {field:'applySchools',title:'适用校区',width:'25%',align:'center'},
	        {field:'isUseVal',title:'状态',width:'10%',align:'center'},  
	        {field:'handerName',title:'创建人',width:'10%',align:'center'},
	        {field:'createDate',title:'创建时间',width:'15%',align:'center'},  
	        {field:'opt',title:'操作',width:'25%',align:'center',
	            formatter: function(Confirmation, row)
	            {  
	        		if(row.isUse == "Y"){
		                var btn = '<a class="view" onclick="viewLinkPrice(\''+row.setPriceId+'\',\''+row.priceName+'\',\''+row.applySchools+'\',\''+row.effDate+'\',\''+row.expDate+'\',\''+row.isUseVal+'\',\''+row.handerName+'\',\''+row.createDate+'\')" style="width:80px; height:25px;"  href="javascript:void(0)">浏览</a>';  
		                return btn;  
	        		}else if(row.isUse == "N"){
	        			var btn = '<a class="view" onclick="viewLinkPrice(\''+row.setPriceId+'\',\''+row.priceName+'\',\''+row.applySchools+'\',\''+row.effDate+'\',\''+row.expDate+'\',\''+row.isUseVal+'\',\''+row.handerName+'\',\''+row.createDate+'\')" style="width:80px; height:25px;"  href="javascript:void(0)">浏览</a>&nbsp;<a class="update" onclick="updateLinkPrice(\''+row.setPriceId+'\',\''+row.priceName+'\',\''+row.schoolIds+'\',\''+row.applySchools+'\',\''+row.effDate+'\',\''+row.expDate+'\',\''+row.isUseVal+'\',\''+row.handerName+'\',\''+row.createDate+'\')" style="width:80px; height:25px;"  href="javascript:void(0)">修改</a>&nbsp;<a class="delete" onclick="deleteLinkPrice(\''+row.setPriceId+'\')" style="width:80px; height:25px;"  href="javascript:void(0)">删除</a>';  
		                return btn;  
	        		}else if(row.isUse == "X"){
	        			var btn = '<a class="view" onclick="viewLinkPrice(\''+row.setPriceId+'\',\''+row.priceName+'\',\''+row.applySchools+'\',\''+row.effDate+'\',\''+row.expDate+'\',\''+row.isUseVal+'\',\''+row.handerName+'\',\''+row.createDate+'\')" style="width:80px; height:25px;"  href="javascript:void(0)">浏览</a>';  
		                return btn;  
	        		}
	            }  
	        }  
	    ]],  
	    onLoadSuccess:function(data){  
			$('.view').linkbutton({text:'浏览',iconCls:'icon-redo'}); 
	        $('.update').linkbutton({text:'修改',iconCls:'icon-edit'}); 
	        $('.delete').linkbutton({text:'删除',iconCls:'icon-remove'});  
	        $('#link_data').datagrid('clearSelections');
	    },
	    toolbar:"#linkToolbar"
	});  

});

//function closeLinkPrice(setPriceId,operType,priceType)
//{
//	$.messager.confirm('提示','您确定要关闭当前连报优惠体系?',function(r){
//		if(r)
//		{
//			$.ajax({
//				type : "POST",
//				url: "/sys/genCourseConfig/updatePirceOpenState.do",
//				data: "setPriceId="+setPriceId+"&operType="+operType+"&priceType=FAVOR_PRICE",
//				async: false,
//				beforeSend: function()
//		    	{
//		    		$.messager.progress({title : '关闭连报优惠体系', msg : '关闭连报优惠体系中，请稍等……'});
//		    	},
//		    	success: function(state) {
//		    		$.messager.progress('close'); 
//		    		if(state == "1"){
//		    			$.messager.alert('提示', "关闭连报优惠体系成功！");
//		    			window.location.reload();
//		    		}else if(state == "2"){
//		    			$.messager.alert('提示', "关闭连报优惠体系失败！");
//		    		}
//		        } 
//			});
//		}
//	});
//}
//
//function openLinkPrice(setPriceId,operType,priceType)
//{
//	$.messager.confirm('提示','您确定要开启当前连报优惠体系?',function(r){
//		if(r)
//		{
//			$.ajax({
//				type : "POST",
//				url: "/sys/genCourseConfig/updatePirceOpenState.do",
//				data: "setPriceId="+setPriceId+"&operType="+operType+"&priceType=FAVOR_PRICE",
//				async: false,
//				beforeSend: function()
//		    	{
//		    		$.messager.progress({title : '开启连报优惠体系', msg : '开启连报优惠体系中，请稍等……'});
//		    	},
//		    	success: function(state) {
//		    		$.messager.progress('close'); 
//		    		if(state == "1"){
//		    			$.messager.alert('提示', "开启连报优惠体系成功！");
//		    			window.location.reload();
//		    		}else if(state == "2"){
//		    			$.messager.alert('提示', "开启连报优惠体系失败！");
//		    		}else{
//		    			$.messager.alert('提示', state+"已经有一个连报优惠处于开启状态！");
//		    			window.location.reload();
//	    			}
//		        } 
//			});
//		}
//	});
//}

//删除优惠体系
function deleteLinkPrice(setPriceId)
{
	$.messager.confirm('提示','您确定要删除当前连报优惠体系?',function(r){
		if(r)
		{
			$.ajax({
				type : "POST",
				url: "/sys/genCourseConfig/deletePriceSystem.do",
				data: "setPriceId="+setPriceId+"&type=FAVOR_PRICE",
				async: false,
				beforeSend: function()
		    	{
		    		$.messager.progress({title : '删除连报优惠体系', msg : '删除连报优惠体系中，请稍等……'});
		    	},
		    	success: function(flag) {
		    		$.messager.progress('close'); 
		    		if(flag == "true"){
		    			$.messager.alert('提示', "删除连报优惠体系成功！");
		    			window.location.reload();
		    		}else if(flag == "false"){
		    			$.messager.alert('提示', "删除连报优惠体系失败！");
		    		}
		        } 
			});
		}
	});
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

//打开校区开启优惠体系
function viewSchoolLinkPrice()
{
	$('#linkDlg').dialog({
		title:"校区开启优惠体系",
	});
	$('#linkDlg').attr("src","/sys/genCourseConfig/schoolLinkPriceList.jsp");
	$('#linkDlg').dialog("open");
}

//打开新增优惠页面
function addLinkPrice()
{
	window.location.href = "/sys/genCourseConfig/jumpToAddPrice.do?type=LINK";
}

//删除相对应的行  
function delRow(rows)  
{  
    $(rows).parent("td").parent("tr").remove();  
}

//增加行
function addRow()
{
	var linkModelTR=$("#linkModelTR").clone();
	var flag=true;
	var linkTR=$("#addLinkPrice").clone();
	linkTR.css("display",'table-row');
	linkTR.attr("val","link");
	linkTR.find("td").each(function(n,node)
	{
		if(n==0)//连报名称	
		{
			var linkName=$("#linkName").textbox('getText');
			if(linkName == undefined || linkName == ""){
				flag=false;
				$.messager.alert('提示', "请输入连报名称！");
				return false;
			}
			$(node).html(""+linkName+"");	
		}else if(n==1)//连报年数
		{
			
			var linkNum=$("#linkNum").numberbox('getText');
			if(linkNum == undefined || linkNum == ""){
				flag=false;
				$.messager.alert('提示', "请输入连报年数！");
				return false;
			}
			$(node).html(""+linkNum+"");
		}else if(n==2)//现金优惠额度
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
		$("#addLinkPrice").after(linkTR);
    }
	clearData("linkModelTR")
}

//新增优惠提交
function addLinkPriceSubmit()
{
	var priceName = $("#priceName").textbox('getValue');
	var effDate = $("#effDate").datebox('getValue');
	var expDate = $("#expDate").datebox('getValue');
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
		$.messager.alert('提示', "请选择开始时间！");
		return;
	}
	if(expDate == "" || expDate == undefined){
		$.messager.alert('提示', "请选择结束时间！");
		return;
	}
	if(expDate <= effDate){
		$.messager.alert('提示', "开始时间不能小于结束时间！");
		return;
	}
	var priceT = {};
	priceT.priceName = priceName;
	priceT.schoolIds = schoolIds;
	priceT.isUse = "N";//默认未生效
	priceT.effDate = effDate;
	priceT.expDate = expDate;
	priceT.handlerId = handlerId;
	var linkArray = new Array();
	$("#linkTab").find('tr').each(function(i,node)
	{
		var trName=$(this).attr("val");
 
		if('link'==trName)
		{
			 var tds=$(this).children('td');
		 
			 var linkName=tds.eq(0).html();
			 var linkNum=tds.eq(1).html();
			 var favorPrice=tds.eq(2).html();
			 var link = {};
			 
			 link.linkName = linkName;
			 link.linkNum = linkNum;
			 link.favorPrice = favorPrice;
			 link.handlerId=handlerId;
			 linkArray.push(link);  
		 }
	});
	if(linkArray.length == 0){
		$.messager.alert('提示', "请至少添加一行连报信息！");
		return;
	}else{
		$.ajax({
			type : "POST",
			url: "/sys/genCourseConfig/addPriceSystem.do",
			data: "priceJson="+JSON.stringify(priceT)+"&classJson="+JSON.stringify(linkArray)+"&type=FAVOR_PRICE",
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title : '添加新优惠', msg : '添加新优惠中，请稍等……'});
	    	},
	    	success: function(state) {
	    		$.messager.progress('close'); 
	    		if(state == "1"){
	    			$.messager.alert('提示', "添加新优惠成功！");
	    			window.location.href = "/sys/genCourseConfig/genCourseCongifMain.jsp";
	    		}else if(state == "2"){
	    			$.messager.alert('提示', "添加新优惠失败！");
	    		}else if(state == "3"){
	    			$.messager.alert('提示',"该校区该时间区间内已一个连报优惠体系！");
	    			window.location.href = "/sys/genCourseConfig/genCourseCongifMain.jsp";
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
function viewLinkPrice(setPriceId,priceName,applySchools,effDate,expDate,isUseVal,handerName,createDate)
{
	var priceT = {};
	priceT.setPriceId = setPriceId;
	priceT.priceName = priceName;
	priceT.applySchools = applySchools;
	priceT.effDate = effDate;
	priceT.expDate = expDate;
	priceT.isUseVal = isUseVal;
	priceT.handerName = handerName;
	priceT.createDate = createDate;
	window.location.href = "/sys/genCourseConfig/viewPriceSystem.do?json="+JSON.stringify(priceT)+"&type=LINK";
}

//打开修改优惠体系页面
function updateLinkPrice(setPriceId,priceName,schoolIds,applySchools,effDate,expDate,isUseVal,handerName,createDate)
{
	var priceT = {};
	priceT.setPriceId = setPriceId;
	priceT.priceName = priceName;
	priceT.schoolIds = schoolIds;
	priceT.applySchools = applySchools;
	priceT.effDate = effDate;
	priceT.expDate = expDate;
	priceT.isUseVal = isUseVal;
	priceT.handerName = handerName;
	priceT.createDate = createDate;
	window.location.href = "/sys/genCourseConfig/jumpToUpdatePrice.do?json="+JSON.stringify(priceT)+"&type=LINK";
}

//修改优惠体系提交
function updateLinkPriceSubmit()
{
	var priceName = $("#priceName").textbox('getValue');
	var effDate = $("#effDate").datebox('getValue');
	var expDate = $("#expDate").datebox('getValue');
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
		$.messager.alert('提示', "请选择开始时间！");
		return;
	}
	if(expDate == "" || expDate == undefined){
		$.messager.alert('提示', "请选择结束时间！");
		return;
	}
	if(expDate <= effDate){
		$.messager.alert('提示', "开始时间不能小于结束时间！");
		return;
	}
	var priceT = {};
	priceT.setPriceId = $("#setPriceId").val();
	priceT.priceName = priceName;
	priceT.schoolIds = schoolIds;
	priceT.effDate = effDate;
	priceT.expDate = expDate;
	priceT.handlerId = handlerId;
	var linkArray = new Array();
	$("#linkTab").find('tr').each(function(i,node)
	{
		var trName=$(this).attr("val");
 
		if('link'==trName)
		{
			 var tds=$(this).children('td');
		 
			 var linkName=tds.eq(0).html();
			 var linkNum=tds.eq(1).html();
			 var favorPrice=tds.eq(2).html();
			 var link = {};
			 var linkFavorId = $(this).attr("linkFavorId");
			 if(linkFavorId != "" && linkFavorId != undefined){
				 link.linkFavorId = linkFavorId;
			 }
			 link.linkName = linkName;
			 link.linkNum = linkNum;
			 link.favorPrice = favorPrice;
			 link.handlerId=handlerId;
			 linkArray.push(link);  
		 }
	});
	if(linkArray.length == 0){
		$.messager.alert('提示', "请至少添加一行连报信息！");
		return;
	}else{
		$.ajax({
			type : "POST",
			url: "/sys/genCourseConfig/updatePriceSystem.do",
			data: "priceJson="+JSON.stringify(priceT)+"&classJson="+JSON.stringify(linkArray)+"&type=FAVOR_PRICE",
			async: false,
			beforeSend: function()
	    	{
	    		$.messager.progress({title : '修改优惠', msg : '修改优惠中，请稍等……'});
	    	},
	    	success: function(state) {
	    		$.messager.progress('close'); 
	    		if(state == "1"){
	    			$.messager.alert('提示', "修改优惠成功！");
	    			window.location.href = "/sys/genCourseConfig/genCourseCongifMain.jsp";
	    		}else if(state == "2"){
	    			$.messager.alert('提示', "修改优惠失败！");
	    		}else if(state == "3"){
	    			$.messager.alert('提示',"该校区该时间区间内已一个连报优惠体系！");
	    			window.location.href = "/sys/genCourseConfig/genCourseCongifMain.jsp";
	    		}
	        } 
		});
	}
}