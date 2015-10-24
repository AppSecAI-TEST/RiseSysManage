$(document).ready(function(){
	//初始化查询
    var obj = "{'queryCode':'qryPriceSystem','type':'FAVOR_PRICE'}";
    $('#discount_data').datagrid({  
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
	        {field:'priceName',title:'复读折扣名称',width:'15%',align:'center'},  
	        {field:'applySchools',title:'适用校区',width:'25%',align:'center'},
	        {field:'countRate',title:'折扣率',width:'8%',align:'center'},
	        {field:'isUseVal',title:'状态',width:'7%',align:'center'},  
	        {field:'handerName',title:'创建人',width:'8%',align:'center'},
	        {field:'createDate',title:'创建时间',width:'12%',align:'center'},  
	        {field:'opt',title:'操作',width:'25%',align:'center',
	            formatter: function(Confirmation, row)
	            {  
	        		if(row.isUse == "Y"){
		                var btn = '<a class="view" onclick="" style="width:80px; height:25px;"  href="javascript:void(0)">浏览</a>&nbsp;<a class="close" onclick="" style="width:80px; height:25px;" href="javascript:void(0)">关闭</a>';  
		                return btn;  
	        		}else if(row.isUse == "N"){
	        			var btn = '<a class="view" onclick="" style="width:80px; height:25px;"  href="javascript:void(0)">浏览</a>&nbsp;<a class="update" onclick="" style="width:80px; height:25px;"  href="javascript:void(0)">修改</a>&nbsp;<a class="delete" onclick="" style="width:80px; height:25px;"  href="javascript:void(0)">删除</a>&nbsp;<a class="open" onclick="" style="width:80px; height:25px;" href="javascript:void(0)">开启</a>';  
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
	        $('#discount_data').datagrid('clearSelections');
	    },
	    toolbar:"#discountToolbar"
	});  

});