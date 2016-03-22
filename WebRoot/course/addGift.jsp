	<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String studentId=request.getParameter("studentId");
%>
<html>
	<head>
	<%@ include file="../common/head.jsp" %>
	<%@ include file="../common/formvalidator.jsp" %>
	</head>
	<body>
			<div class="easyui-panel" style="width: 1200px; height: auto;"
					title="赠品信息">
				<table width="100%" cellpadding="5px" class="maintable" id="giftTab">
	      	      <tr id="giftModelTR">
	      	        <td width="8%" align="right"><span>赠品类型：</span></td>
	      	        <td width="8%">
	      	        <select id="parentType" style="width: 100px; height: 28px;"
	      			data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'">
      	            </select>
      	            </td>
	      	        <td width="7%" align="right"><span>赠品名称：</span></td>
	      	        <td width="39%">
	      	      	<table  border="0">
	   	                <tr>
			      	         <td id='td0' ><select  class="easyui-combobox" id="giftType" style="width: 120px; height: 28px;"></select></td>
			      	         <td id="td1" style="display:none"><select  class="easyui-combobox" id="giftId" style="width: 120px; height: 28px;"></select></td>
			      	         <td id="td2" style="display:none"><input   id="giftCode" type="text" class="easyui-textbox validatebox"  style="width:150px; height: 28px;"/></td>
		                     <td id="td3" style="display:none"><input   id="giftEffDate" type="text" class="easyui-datebox"  style="width: 100px; height: 28px;"/></td>
	      	             </tr>
      	            </table>
      	            </td>
	      	        <td width="7%" align="right"><span>是否领用：</span></td>
	      	        <td width="6%" align="left">
	      	          <input type="radio" name="isGetY"  value="Y">
	      	          <label for="radio"><span>已领用</span></label>
	      	          <input type="radio" name="isGetY" checked value="N">
	      	          <label for="radio"> <span>未领用</span></label>
      	           </td>
	      	        <td width="6%" align="right"><span>发放人：</span></td>
	      	        <td  width="8%"><input id="granter" type="text" disabled="disabled" class="easyui-textbox validatebox"  style="width: 100px; height: 28px;"/></td>
	      	       
	      	        <td width="6%"><a href="javascript:void(0)" id="addGiftBtn" class="easyui-linkbutton" iconCls="icon-add" style="width: 80px; height: 28px;">添加</a></td>
      	        </tr>
      	      <tr style="display:none;" name="addGift" id="addGift" >
      	        <td align="right"><span>赠品类型：</span></td>
      	        <td align="left" parentType="">&nbsp;</td>
      	        <td align="right"><span>赠品名称：</span></td>
      	        <td align="left" giftType="" giftId="">&nbsp;</td>
      	        <td align="right"><span>是否领用：</span></td>
      	        <td align="left" isGet="">&nbsp;</td>
      	        <td align="right"><span>发放人：</span></td>
      	        <td align="left" granter="">&nbsp;</td>
      	        
      	        <td><a href='javascript:void(0)' class='linkmore' onclick='delRow(this)' ><span>删除</span></a></td>
     	       </tr>
      	      </table>
      		</div>
		<div style="margin-top: 10px;text-align:center;">
	      	<a href="javascript:void(0)" id="submit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
	      	&nbsp;<a href="javascript:void(0)" id="back" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;">返回</a>
	     </div>
	</body>
</html>
<script type="text/javascript">	
var gifts=[];
$('#parentType').combobox({
	 onChange:function(n,o)
		{
		     $("#td0").css('display','none');
		 	 $("#td1").css('display','none');
             $("#td2").css('display','none');
             $("#td3").css('display','none');
             $("#granter").textbox({disabled:true});
             var isGet = $("input[name='isGetY']:checked").val();
       		if(n=='COUPON')//券类
       		{
			    var urls="/sys/pubData/qryData.do?param={queryCode:\"Qry_Gift_Type\",parentType:\""+n+"\"}";
	       		$("#giftType").combobox(
	       		{
	        		url : urls,//返回json数据的url
	        		valueField : "giftType",
	        		textField :  "typeName",
	        		panelHeight : "auto",
	        		onLoadSuccess : function ()
	        		{ //数据加载完毕事件
	                    var data = $('#giftType').combobox('getData');
	                    if (data.length > 0)
	                    {
	                      //  $("#giftId").combobox('select', data[0].param2);
	                    }
	                    $("#td0").css('display','block');
	                    $("#td1").css('display','block');
	                  
	                    if(isGet=='Y')
	                    {
	                    	 $("#td2").css('display','block');
	                   		 $("#td3").css('display','block');
	                    }
	                  
	                }
	        	});
       		}else if(n=='GOODS')//实物类
       		{
       			$("#td1").css('display','block');
			    var urls="/sys/pubData/qryData.do?param={queryCode:\"Qry_Gift\",giftType:\""+n+"\"}";
	       		$("#giftId").combobox(
	       		{
	        		url : urls,//返回json数据的url
	        		valueField : "giftId",
	        		textField :  "giftName",
	        		panelHeight : "auto",
	        		onLoadSuccess : function ()
	        		{ //数据加载完毕事件
	                    var data = $('#giftId').combobox('getData');
	                    if (data.length > 0)
	                    {
	                      //  $("#giftId").combobox('select', data[0].param2);
	                    }
	                }
	        	});
       		}else if(n == 'TEXTBOOK') { //实物类
			$("#td1").css('display','block');
			var urls = "/sys/pubData/qryData.do?param={queryCode:\"Qry_Gift\",giftType:\""+n+"\"}";
			$("#giftId").combobox({
				url : urls,//返回json数据的url
				valueField : "giftId",
				textField :  "giftName",
				panelHeight : "auto",
				onLoadSuccess : function () { //数据加载完毕事件
					var data = $('#giftId').combobox('getData');
					if (data.length > 0) {
	                	//  $("#giftId").combobox('select', data[0].param2);
					}
				}
			});
		}
       		 
       		  if(isGet=='Y')
              {
             	  $("#granter").textbox({disabled:false});
              }
		},
		url:"/sys/pubData/qryCodeNameList.do?tableName=GIFT_TYPE_T&codeType=PARENT_TYPE"
	});

$('#giftType').combobox(
{
	onChange : function(n, o) 
	{
		var urls = "/sys/pubData/qryData.do?param={queryCode:\"Qry_Gift\",giftType:\""+ n + "\"}";
		$("#giftId").combobox(
		{
			url : urls,//返回json数据的url
			valueField : "giftId",
			textField : "giftName",
			panelHeight : "auto",
			onLoadSuccess : function() 
			{ //数据加载完毕事件
				var data = $('#giftId').combobox('getData');
				if (data.length > 0) 
				{
					//  $("#giftId").combobox('select', data[0].param2);
				}
			}	
		});
	}
});

$('#giftCourseType').combobox(
{
	onChange : function(n, o)
	{
		var urls = "/sys/pubData/qryData.do?param={queryCode:\"Qry_Gift\",giftType:\""+ n + "\"}";
		$("#giftCourseId").combobox(
		{
			url : urls,//返回json数据的url
			valueField : "giftId",
			textField : "giftName",
			panelHeight : "auto"
		});
	}
});

$(":radio[name='isGetY']").click(function()
{
	var isGet=$(this).val();
	var type=$('#parentType').combobox('getValue');
 	if('Y'==isGet)
 	{
 		if(type=='COUPON')
 		{
 			 $("#td2").css('display','block');
        	 $("#td3").css('display','block');
 		}
        $("#granter").textbox({disabled:false});
 	}else
 	{
 		  $("#td2").css('display','none');
          $("#td3").css('display','none');
          $("#granter").textbox({disabled:true});
 	}
});


//增加赠品
$("#addGiftBtn").click(function ()
{
		var giftModelTR=$("#giftModelTR").clone();
		var flag=true;
		var giftTR=$("#addGift").clone();
		giftTR.css("display",'table-row');
		giftTR.attr("val","gift");
		giftTR.find("td").each(function(n,node)
		{
			var getFlag = $("input[name='isGetY']:checked").val(); //是否领取
			var parentType=$("#parentType").combobox('getValue');
			var giftEffDate=$("#giftEffDate").textbox('getValue');
			if('N'==getFlag)
			{
				$("#giftEffDate").textbox('setValue','');
				$("#giftCode").textbox('setValue','');
				$("#granter").textbox("setValue",'');
			}
			if(n==1)//赠品类型;	
			{
				var name=$("#parentType").combobox('getText');
				if(name=='')
				{
					showMessage('提示', "请选择赠品类型", null);
					flag=false;
					return false;
				}
				$(node).html("<span>"+name+"</span>");	
				$(node).attr("parentType",parentType);
			}else if(n==3)//赠品名称;劵类ID
			{
				var giftId=$("#giftId").combobox('getValue');
				var giftName=$("#giftId").combobox('getText');
			 
				var giftType=$("#giftType").combobox("getText");
				var giftTypeVal=$("#giftType").combobox('getValue');
				
				var code=$("#giftCode").textbox('getValue');
				
				//判断是否是券类
				if(giftId=='')
				{
					showMessage('提示', "请选择赠品名称",null);
					flag=false;
					return false;
				}
				
				//判断是否是券类
				if(parentType=='COUPON' && code=='' && 'Y'==getFlag)
				{
					showMessage('提示', "请输入券类编码",null);
					flag=false;
					return false;
				}
			
				if(''!=code)
				{
						$(node).html("<span>"+giftType+"  "+giftName+"   "+ code +"   "+giftEffDate+"</span>");	
				}else
				{
					$(node).html("<span>"+giftName+"</span>");	
				}
				
				var datas = $('#giftType').combobox('getData');
				 
				for(var m=0;m<datas.length;m++)
				{
					if(giftTypeVal==datas[m].giftType)
					{
						 $(node).attr("effNum",datas[m].effNum);
						 $(node).attr("unit",datas[m].unit);
					}
				}
				
				var amount=""; 
				var data = $('#giftId').combobox('getData');
                if (data.length > 0)
                {
                    for(var i=0;i<data.length;i++)
                    {
                    	var giftIdT=data[i].giftId;
                    	if(giftIdT==giftId)
                    	{
                    		giftTypeVal=data[i].giftType;
                    		amount=data[i].amount;
                    	}
                    }
                }
				 
				$(node).attr("giftName",giftName);
				$(node).attr("amount",amount);
				$(node).attr("giftId",giftId);
				$(node).attr("giftType",giftTypeVal);
				$(node).attr("giftCode",code);
				$(node).attr("effDate",giftEffDate);
				
			}else if(n==5)
			{
				$(node).attr("isGet","N");
				if('Y'==getFlag)
				{
					if(giftEffDate=='' &&　parentType=='COUPON')
					{
						flag=false;
						showMessage('提示', "请填写有效期",null);
						return false;
					}
					$(node).html("<span>已领取</span>");	
					$(node).attr("isGet","Y");
				}else if('N'==getFlag)
				{
					$(node).html("<span>未领取</span>");	
					$(node).attr("isGet","N");
				}
				else
				{
					 showMessage('提示', "请选择已领或者未领",null);
					  flag=false;
					  return false;
				}
			}else if(n==7)
			{
				var granter=$("#granter").textbox("getValue");
				if(''==granter && 'Y'==getFlag)
				{
					  showMessage('提示', "发放人为空",null);
					  flag=false;
					  return false;
				}
				$(node).html("<span>"+granter+"</span>");	
				$(node).attr("granter",granter);
			} 
			
		});
	
		if(flag)
		{
			$("#giftFm").form('clear');
			$("#addGift").after(giftTR);
			var height = $(document).height();
			var frameName=$("#frameName").val();
			$(frameName,parent.document).css("height",height);
			clearData("giftModelTR");
			$("#giftModelTR").find("input[type='radio']:eq(1)").trigger("click");
	    }
		
	
	
	});

function delRow(rows) {
	$(rows).parent("td").parent("tr").remove();
}

$("#submit").click(function(){
	$("#giftTab").find('tr').each(function(i,node)
		{
			var trName=$(this).attr("val");
			var studentGiftId=$(this).attr("studentGiftId");
 
			if('gift'==trName)
			{
				 var  tds=$(this).children('td');
			 
				 var giftName=tds.eq(3).attr("giftName");
				 var  amount=tds.eq(3).attr('amount');
				 var  effNum=tds.eq(3).attr('effNum');
				 var  unit=tds.eq(3).attr('unit');
				 var  giftId=tds.eq(3).attr('giftId');
				 var  giftType=tds.eq(3).attr('giftType');
				 var  giftCode=tds.eq(3).attr('giftCode');
				 var  isGet=tds.eq(5).attr('isGet');
				 var  granter=tds.eq(7).attr('granter');
				 var  showName=tds.eq(1).find("span").html()+":"+giftName;
				 var  gift = {};
				 
				 gift.studentId=$("#studentId").val();
				
				 gift.showName=showName;
				 gift.giftName=giftName;
				 gift.usableAmount=amount;
				 gift.amount=amount;
				 gift.studentGiftId=studentGiftId;
				 gift.unit = unit; 
				 gift.effNum = effNum; 
				 gift.giftType = giftType;
				 gift.giftId=giftId;
				 gift.giftCode=giftCode;
				 gift.isGet=isGet;
				 gift.granter=granter;
				 gifts.push(gift);  
			 }
		});
	parent.getWomGiftInfo(gifts);
});


$("#back").click(function(){
	parent.closeWomGift();
});
</script>
	
	