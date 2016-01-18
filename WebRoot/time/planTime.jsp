<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<% 
	String month=request.getParameter("month");
	String weekSeq=request.getParameter("weekSeq");
	String createWeekId=request.getParameter("createWeekId");
	String dateRange=request.getParameter("dateRange");
	String schoolId=request.getParameter("schoolId");

%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
		<title>RunJS</title>
			<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script class="resources library" src="/sys/pub/js/autoMergeCells.js" type="text/javascript"></script>
	
	<style type="text/css">
.tree-node-hover {
	text-decoration: none;
	color: #555555;
	background: #fae8bd;
}
.datagrid{
	margin:0 auto;
	min-width:50px;
	margin-top:5px;
	width:20%;
}
datagrid-row-selected
#wrap{  
    width:700px;  
    margin:0 auto;  
}  
#header{  
    margin:0px;  
    height:80px;  
    border:solid 1px #00C9FF;  
}  
#container{  
    position:relative;  
    margin:0px;  
    height:400px;  
}  
#left_side{  
    position:absolute;  
    top:0px;  
    left:0px;  
    width:100px;  
    height:100%;  
}  
#content{  
    margin:0px 10px 0px 100px;  
      
    height:100%;  
}  
#right_side{  
    position:absolute;  
    top:0px;  
    right:0px;  
    border:solid 1px #00C9FF;  
    width:170px;  
    height:100%;  
}  
#footer{  
    margin:20px;  
    height:80px;  
    border:solid 1px #00C9FF;  
}  

</style>
	</head>
	<body>
		<input type="hidden" id="schoolId" name="schoolId" value="<%=schoolId%>"/>
  		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:100px" onclick="javascript:window.history.back()">返回</a>	
	<div id="wrap">  
        <!--  <div id="header">header</div> --> 
        <div id="container">  
            <div id="left_side"> 
	    	<table  id="t0"></table>
	    	 </div>  
            <div id="content"><div style="width:700; height:1000; overflow:scroll;">
    	<table width="700"  cellpadding="0" border="0" style="border-collapse:collapse;overflow:scroll;" >
    	<tr>
	    	<td>
	    	<table  id="t1"></table>
	    	</td>
	    	<td>
	    	<table  id="t2"></table>
	    	</td>
	    	<td>
	    	<table  id="t3"></table>
	    	</td>
	    	<td>
	    	<table  id="t4"></table>
	    	</td>
	    	<td>
	    	<table  id="t5"></table>
	    	</td>
	    	<td>
	    	<table  id="t6"></table>
	    	</td>
	    	<td>
	    	<table  id="t7"></table>
	    	</td>
    	</tr>
    	</table>
    	</div></div>  
             
        </div>  
    </div>  
	
		 <div id="dlg" class="easyui-dialog" style="width: 600px; height: 550px; padding: 10px 20px" closed="true" modal="true" buttons="#dlgBtn">
 				<iframe id="frame2" name="frame2"   src=""  marginwidth=0 marginheight=0 frameborder=0 scrolling="auto" height="445px" width="100%"></iframe>
  	    </div>
	</body>
</html>


<script type="text/javascript">
var json1;
var json2;
var json3;
var json4;
var json5;
var json6;
var josn7;
function closeDlg()
{
	$('#dlg').dialog('close');
}
	
function linkCourse()
{
	$('#dlg').dialog('open').dialog('setTitle', '排课');
	$('#fm').form('clear');

}

function getWeekTime()
{
	var schoolId=$("#schoolId").val();
	$.ajax(
	{
		type : "POST",
		url: "/sys/time/getTimeByWeek.do?",
		data: "param={'month':'<%=month%>','week':'<%=weekSeq%>','dateRange':'<%=dateRange%>','schoolId':'"+schoolId+"'}",
		async: true,
		dataType:"json",
		beforeSend: function()
    	{
    		$.messager.progress({title : '提示', msg : '正在获取排课信息，请稍等……'});
    	},
    	success: function(data) {
    		$.messager.progress('close');
    		for(var i=0;i<data.length;i++)
    		{
    			if(i==0)
    			{
    				//alert(JSON.stringify(data));
    				json1=data[i];
    				initTable("t1",json1);
    				initTeacher("t0",json1);
    			}else if(i==1)
    			{
    				json2=data[i];
    				initTable("t2",json2);
    			}else if(i==2)
    			{
    				json3=data[i];
    				initTable("t3",json3);
    			}else if(i==3)
    			{
    				json4=data[i];
    				initTable("t4",json4);
    			}else if(i==4)
    			{
    				json5=data[i];
    				initTable("t5",json5);
    			}else if(i==5)
    			{
    				json6=data[i];
    				initTable("t6",json6);
    			}else if(i==6)
    			{
    				json7=data[i];
    				initTable("t7",json7);
    			} 
    			
    		}
    		 
        },
        error:function(){
        	$.messager.progress('close'); 
        }
    	
	});
	
}

function initTeacher(tabId,data)
{
	var rows=data.rows;
	var time=rows[0].schooltime;
	var weekTime=rows[0].weekTime;
	$('#'+tabId).datagrid({
    title: "老师",
    align:'center',
    width: 100,
    height: 'auto',
    fitColumns: true,
    singleSelect:true,
    rowStyler: function(index,row)
    {
		 return 'background-color:#FFFFFF;color:#00000;';
    },
     
    columns:[[
      {field:'teacherName',title:'',width:100,align:'center'}
      
    ]] 
  });
  $('#'+tabId).datagrid("loadData",data);	
}

function initTable(tabId,data)
{
	var rows=data.rows;
	var time=rows[0].schooltime;
	var weekTime=rows[0].weekTime;
	$('#'+tabId).datagrid({
    title: time+"(周"+weekTime+")",
    width: 550,
    height: 'auto',
    fitColumns: true,
    singleSelect:true,
    rowStyler: function(index,row)
    {
		 return 'background-color:#FFFFFF;color:#00000;';
    },
    onClickCell:onClickCell, 
    columns:[[
      {field:'H001',title:'8:30', width:68,align:'center', editor:'text'},
      {field:'H002',title:'10:30',width:68,align:'center', editor:'text'},
      {field:'H003',title:'14:00',width:68,align:'center', editor:'text'},
      {field:'H004',title:'16:00',width:68,align:'center', editor:'text'},
      {field:'H005',title:'18:30',width:68,align:'center', editor:'text'} 
    ]],
    onLoadSuccess:function()
    {
      MergeCells(tabId);
    } 
  });
  $('#'+tabId).datagrid("loadData",data);	
}

$(document).ready(function()
{
	getWeekTime();
});


function MergeCells(tabId)
{		 
	var table;
	if(tabId!='')
	{
		table= $('#'+tabId);
	} 
    var s = $(table).datagrid('getData');
    var datas =s.rows;
 
	for(var i=0; i<datas.length; i++)
	{
		var index=i;
		var fieldT;
		var colspanNum=0;
		for(var key in datas[i])
		{  
			
               if(key.indexOf("merge")>-1)
               {
               	var val=datas[i][key];
               	fieldT="H"+key.substring(5,8);
               	$(table).datagrid('mergeCells',
				{
					index: i,
					field: fieldT,
					colspan: val
				});
               }
           }  
	}
	$("table tr td").each(function()
	{
	   var d=$(this).text();
	  if('DPre-K03'==d)
	  {
		     $(this).css("background-color","#EDE1D8");
	  }else if('DPre-K01'==d)
	  {
		  $(this).css("background-color","#ECB1D8");
	  }else if('DPre-K02'==d)
	  {
		  $(this).css("background-color","#EFE1B8");
	  }
	
	});

	/*
	$("table tr").each(function(k,v)
	{//遍历所有行
		$("td",v).eq(3).css("background-color","#ECE9D8");//把每行的同一位置变色
	});*/
 }
/*
	function randomcolor()
	{
		var str=Math.ceil(Math.random()*16777215).toString(16);   
		if(str.length<6){   
		 str="0"+str;   
		}   
		return "#"+str;
	}
 
 function onClickCell(rowIndex, field, value)
 { 
	
	// $('#tt1').datagrid('beginEdit', rowIndex);
	 var s=  $(this).datagrid('getData');
	 var rows =s.rows;
	 var schooltime=rows[0].schooltime;
	 var weekTime=rows[0].weekTime;
	 var weekSeq=rows[0].weekSeq;
	 var schoolId=rows[0].schoolId;
	 alert(JSON.stringify(rows[rowIndex]));
	 $("#frame2").attr('src',"/sys/time/editTime.jsp?schoolId="+schoolId+"&weekSeq="+weekSeq+"&weekTime="+weekTime+"&schooltime="+schooltime+"&time="+JSON.stringify(rows[rowIndex]));
	 $('#dlg').dialog('open').dialog('setTitle', '排课');
 } */ 

$.extend($.fn.datagrid.methods, 
{
	editCell: function(jq,param)
	{
		return jq.each(function()
		{
			var opts = $(this).datagrid('options');
			var fields = $(this).datagrid('getColumnFields',true).concat($(this).datagrid('getColumnFields'));
			for(var i=0; i<fields.length; i++)
			{
				var col = $(this).datagrid('getColumnOption', fields[i]);
				col.editor1 = col.editor;
				if (fields[i] != param.field)
				{
					col.editor = null;
				}
			}
			$(this).datagrid('beginEdit', param.index);
			for(var i=0; i<fields.length; i++)
			{
				var col = $(this).datagrid('getColumnOption', fields[i]);
				col.editor = col.editor1;
			}
		});
	}
});

var editIndex = undefined;
var editField=undefined;
var tabId="";
var editValue="";

function endEditing(tab)
{
	if (editIndex == undefined){return true}
	if ($(tab).datagrid('validateRow', editIndex))
	{
 
		var choose=getCellValue($(tab),editIndex,editField);
		if(choose!=undefined && choose!=editValue)
		{
			var rowVal = $(tab).datagrid('getData').rows[editIndex];
		//	alert(JSON.stringify(rowVal));
			var planT={};
			var val=rowVal[editField]+"";
			var schooltimeInstId=rowVal[editField+"-schooltimeInstId"]+"";
			
			if(choose=='' && schooltimeInstId!=undefined)
			{
				var classInstId=rowVal.classInstId;
				deletePlanTime(schooltimeInstId);
				return;
			}
			
			var vals = choose.split("/");
			 
			var className=vals[0];
			var roomName=vals[1];
			var teacherType=vals[2];
			
			if(className==undefined)
			{
				$.messager.alert('提示',"请输入班级名称");
				setCellValue($(tab),editIndex,editField,editValue);//恢复初始值
			}else
			
			if(roomName==undefined)
			{
				$.messager.alert('提示',"请输入教室名称");
				setCellValue($(tab),editIndex,editField,editValue);//恢复初始值
			}else
			
			if(teacherType==undefined)
			{
				$.messager.alert('提示',"请输入教师类型");
				setCellValue($(tab),editIndex,editField,editValue);//恢复初始值
			}else if( teacherType!='T' && teacherType!='TA')
			{
				$.messager.alert('提示',"教师类型格式只能是T或TA");
				setCellValue($(tab),editIndex,editField,editValue);//恢复初始值
			}
			else
			{
				var hoursNum=vals[3];//课时数量
			
				var schoolId=$("#schoolId").val();
				planT.schoolId=schoolId;
				planT.teacherName=rowVal.teacherName;
				planT.teacherId=rowVal.teacherId;
				planT.teacherType=teacherType;
			    planT.className=className;
			    planT.roomName=roomName;
			   
			    planT.schooltimeInstId=schooltimeInstId;
			    
			    planT=getHours(planT,hoursNum);
			    if(planT.hourRange!=undefined && planT.hourRange!='')
			    {
					addPlanTime(planT,tab);
				}else
				{
					$.messager.alert('提示',"没有可适用上课时段");
					setCellValue($(tab),editIndex,editField,editValue);//恢复初始值
				}
		    }
		  }
		$(tab).datagrid('endEdit', editIndex);
		var tabId= $(tab).attr("id");
		MergeCells(tabId);//重新合并
		editIndex = undefined;
		return true;
	} else
	{
		return false;
	}
}

function deletePlanTime(schooltimeId,classInstId)
{
		var param="{schooltimeInstId="+schooltimeId+",createWeekId="+<%=createWeekId%>+"}";
		$.ajax({
			type : "POST",
			url: "/sys/time/delete.do",
			data: "param="+param,
			async: false,
			dataType:"json",
			beforeSend: function()
	    	{
	    		$.messager.progress({title : '系统消息', msg : '正在提交数据，请稍等……'});
	    	},
	    	success: function(data) {
	    		$.messager.progress('close');
	    		 
	        },
	        error:function(){
	        	$.messager.progress('close'); 
	        }
	    	
		});
		
} 
	
function addPlanTime(planT,tab)
{	
	var s = $(tab).datagrid('getData');
	 var datas =s.rows;
	for(var i=0;i<datas.length;i++)
	{
		var data=datas[i];
		if(data.schooltime!=undefined && data.weekTime!=undefined && data.weekSeq!=undefined)
		{
			planT.weekTime=data.weekTime;
			planT.weekSeq=data.weekSeq;
			planT.schooltime=data.schooltime;
			planT.createWeekId='<%=createWeekId%>';
			break;
		}
		 
	}
	  
	$.ajax(
	{
		type : "POST",
		url: "/sys/time/add.do",
		data: "param="+JSON.stringify(planT),
		async: false,
		dataType:"json",
		beforeSend: function()
    	{
    		$.messager.progress({title : '系统消息', msg : '正在提交数据，请稍等……'});
    	},
    	success: function(data) 
    	{
    		$.messager.progress('close');
    		if(data.flag)
    		{
    		}else
    		{
    			$.messager.alert('提示',data.msg);
    		}
    		  getWeekTime();
        },
        error:function()
        {
        	$.messager.progress('close'); 
        }
	});
}
  
function onClickCell(index, field,value)
{
	if(value==undefined)
	{
		value ="";
	}	
	var id= $(this).attr("id");
	if(tabId!='' && tabId!=id)
	{
		endEditing($("#"+tabId));
	}
	if (endEditing(this))
	{
		var s=  $(this).datagrid('getData');
	 	var rows =s.rows;
		$(this).datagrid('selectRow', index).datagrid('editCell', {index:index,field:field});
		if(value!='')
		{	
		//	setCellValue($(this),index,field,value+"/")
		}
		editIndex = index;
		editField=field;
	}
	editValue=value;
	tabId=$(this).attr("id");
}

/*时间范围*/ 
var hourRange;
$.ajax(
	{
		type : "POST",
		url: "/sys/pubData/qryParaConfigList.do?",
		data: "paramType=HOUR_RANGE",
		async: false,
		dataType:"json",
		beforeSend: function()
    	{
    		$.messager.progress({title : '系统消息', msg : '正在提交数据，请稍等……'});
    	},
    	success: function(data)
    	{
    		$.messager.progress('close');
    		hourRange=data;
    	}
    });

var hourRanges=[];

/**
 * 根据填写的课时量定位时间段范围
 * @param {Object} planT
 * @param {Object} mergeNum
 * @return {TypeName} 
 */
function getHours(planT,hoursNum)
{
	var mark=editField.substring(1,editField.length);
	
	for(var i=0;i<hourRange.length;i++)
	{
		var paramVal=hourRange[i].paramValue;
		var hours=hourRange[i].param4;
		 
		if(hoursNum==''|| hoursNum==undefined)
		{
			if(paramVal.indexOf(mark)>-1 && hours==2)//不填默认两个课时
			{
				planT.hourRange=paramVal;
				planT.lessionHours=hourRange[i].param4;
				break;
			}
		}else
		{
			if(paramVal.indexOf(mark)>-1 && hours==hoursNum)
			{
				planT.hourRange=paramVal;
				planT.lessionHours=hourRange[i].param4;
				break;
			}
		}
		
		
	}
	return planT;
}

function getCellValue(tabObj,rowIndex,field)
{
	var val ="";
	var tab =tabObj.parent().find(".datagrid-view2").find(".datagrid-body").find(".datagrid-btable");
	var tr =tab.find("tr:eq("+rowIndex+")");
	tr.find("td").each(function()
	{
		if($(this).attr("field")==field)
		{
			val =$(this).find("input[type='text']").val();
			return false;
		}	
	});
	return val;
}

function setCellValue(tabObj,rowIndex,field,value)
{
	var val ="";
	var tab =tabObj.parent().find(".datagrid-view2").find(".datagrid-body").find(".datagrid-btable");
	var tr =tab.find("tr:eq("+rowIndex+")");
	tr.find("td").each(function()
	{
		if($(this).attr("field")==field)
		{
			val =$(this).find("input[type='text']").val(value);
		}	
	});
	 
}

</script>