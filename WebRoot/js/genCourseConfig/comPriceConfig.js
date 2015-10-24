var qryComFlag = true;
$(document).ready(function(){
	//初始化查询
    var obj = "{'queryCode':'qryPriceSystem','type':'COMMON_PRICE'}";
    $('#tt').tabs({
	    border:false,
	    onSelect:function(title,index){
	       if(index == 2 && qryComFlag){
			    $('#common_data').datagrid({  
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
				        {field:'priceName',title:'价格体系名称',width:'15%',align:'center'},  
				        {field:'applySchools',title:'适用校区',width:'25%',align:'center'},
				        {field:'isUseVal',title:'状态',width:'10%',align:'center'},  
				        {field:'handerName',title:'创建人',width:'10%',align:'center'},
				        {field:'createDate',title:'创建时间',width:'15%',align:'center'},  
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
				        $("#upApplySchools").html(data.unapplySchools+"，上述校区没有开启的价格体系！");
				        $('#common_data').datagrid('clearSelections');
				    },
				    toolbar:"#commonToolbar"
				});  
			    qryComFlag = false;
	       }
	    }
	});
    
});

function addComPrice()
{
	window.location.href = "/sys/genCourseConfig/jumpToAddPrice.do?type=COMMON";
}

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

function addSchools()
{
	$('#dlg').dialog({
		title:"添加适用校区",
	});
	$('#dlg').attr("src","/sys/genCourseConfig/addSchool.jsp");
	$('#dlg').dialog("open");
}

function addComPriceSubmit()
{
	$("#priceName").textbox('getValue');
	var isOpen = $("input[name='isOpen']:checked").val();
	var schoolIds = $("#schoolIds").val();
	var handlerId = $("#handlerId").val();
	$("input[name='feeA']").each(function(index,node){
		 var classArray = new Array();
		 var amount = $("#totalFee"+index+"").html();
		 if(amount != "" && amount != 0){
			 var classT = {};
			 var stageId = $("#stageId"+index+"").html();
			 var classType = $("#classType"+index+"").html();
			 var feeA = $("#feeA"+index+"").numberbox('getValue');
			 var feeB = $("#feeB"+index+"").numberbox('getValue');
			 var feeC = $("#feeC"+index+"").numberbox('getValue');
			 var feeD = $("#feeD"+index+"").numberbox('getValue');
			 var feeE = $("#feeE"+index+"").numberbox('getValue');
			 classT.stageId = stageId;
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
}