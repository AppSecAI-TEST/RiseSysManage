$(document).ready(function(){
	//初始化查询
    var obj = "{'queryCode':'qryPriceSystem','type':'FAVOR_PRICE'}";
    $('#link_data').datagrid({  
		border:true,  
	    fitColumns:true,  
	    singleSelect: true,  
	    rownumbers : true,
	    pagination :true,
	  	url: "/sys/pubData/qryDataListByPage.do",
	  	queryParams:{
			param : obj
		},
	    columns:[[  
	        {field:'priceName',title:'连报优惠体系名称',width:'15%',align:'center'},  
	        {field:'applySchools',title:'适用校区',width:'25%',align:'center'},
	        {field:'isUseVal',title:'状态',width:'7%',align:'center'},  
	        {field:'handerName',title:'创建人',width:'8%',align:'center'},
	        {field:'createDate',title:'创建时间',width:'13%',align:'center'},  
	        {field:'opt',title:'操作',width:'32%',align:'center',
	            formatter: function(Confirmation, row)
	            {  
	        		if(row.isUse == "Y"){
		                var btn = '<a class="view" onclick="" style="width:80px; height:25px;"  href="javascript:void(0)">浏览</a>&nbsp;<a class="close" onclick="closeLinkPrice(\''+row.setPriceId+'\',\'N\',\'FAVOR_PRICE\')" style="width:80px; height:25px;" href="javascript:void(0)">关闭</a>';  
		                return btn;  
	        		}else if(row.isUse == "N"){
	        			var btn = '<a class="view" onclick="" style="width:80px; height:25px;"  href="javascript:void(0)">浏览</a>&nbsp;<a class="update" onclick="" style="width:80px; height:25px;"  href="javascript:void(0)">修改</a>&nbsp;<a class="delete" onclick="deleteLinkPrice(\''+row.setPriceId+'\')" style="width:80px; height:25px;"  href="javascript:void(0)">删除</a>&nbsp;<a class="open" onclick="openLinkPrice(\''+row.setPriceId+'\',\'Y\',\'FAVOR_PRICE\')" style="width:80px; height:25px;" href="javascript:void(0)">开启</a>';  
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
	        $('#link_data').datagrid('clearSelections');
	    },
	    toolbar:"#linkToolbar"
	});  

});

function closeLinkPrice(setPriceId,operType,priceType)
{
	$.messager.confirm('提示','您确定要关闭当前连报优惠体系?',function(r){
		if(r)
		{
			$.ajax({
				type : "POST",
				url: "/sys/genCourseConfig/updatePirceOpenState.do",
				data: "setPriceId="+setPriceId+"&operType="+operType+"&priceType=FAVOR_PRICE",
				async: false,
				beforeSend: function()
		    	{
		    		$.messager.progress({title : '关闭连报优惠体系', msg : '关闭连报优惠体系中，请稍等……'});
		    	},
		    	success: function(state) {
		    		$.messager.progress('close'); 
		    		if(state == "1"){
		    			$.messager.alert('提示', "关闭连报优惠体系成功！");
		    			window.location.reload();
		    		}else if(state == "2"){
		    			$.messager.alert('提示', "关闭连报优惠体系失败！");
		    		}
		        } 
			});
		}
	});
}

function openLinkPrice(setPriceId,operType,priceType)
{
	$.messager.confirm('提示','您确定要开启当前连报优惠体系?',function(r){
		if(r)
		{
			$.ajax({
				type : "POST",
				url: "/sys/genCourseConfig/updatePirceOpenState.do",
				data: "setPriceId="+setPriceId+"&operType="+operType+"&priceType=FAVOR_PRICE",
				async: false,
				beforeSend: function()
		    	{
		    		$.messager.progress({title : '开启连报优惠体系', msg : '开启连报优惠体系中，请稍等……'});
		    	},
		    	success: function(state) {
		    		$.messager.progress('close'); 
		    		if(state == "1"){
		    			$.messager.alert('提示', "开启连报优惠体系成功！");
		    			window.location.reload();
		    		}else if(state == "2"){
		    			$.messager.alert('提示', "开启连报优惠体系失败！");
		    		}else{
		    			$.messager.alert('提示', state+"已经有一个连报优惠处于开启状态！");
		    			window.location.reload();
	    			}
		        } 
			});
		}
	});
}

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

function addSchools()
{
	$('#dlg').dialog({
		title:"添加适用校区",
	});
	$('#dlg').attr("src","/sys/genCourseConfig/addSchool.jsp");
	$('#dlg').dialog("open");
}

function viewSchoolLinkPrice()
{
	$('#linkDlg').dialog({
		title:"校区开启优惠体系",
	});
	$('#linkDlg').attr("src","/sys/genCourseConfig/schoolLinkPriceList.jsp");
	$('#linkDlg').dialog("open");
}

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

function addLinkPriceSubmit()
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
	    		}else{
	    			$.messager.alert('提示', state+"已经有一个优惠体系处于开启状态！");
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