<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<% 
String path = request.getContextPath();
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


</style>
	</head>
	<body>
		<input id="staffId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
		<table class="search_tab" >
				<tr>
				<td width="70px" align="right"><span>校区：</span></td>
  					<td width="100px">
						<select id="schoolId" name="schoolId" style="width: 100px; height: 25px;" editable="false"
							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'">
		        		</select>
					</td>
					<td align="left">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" style="width:100px; height: 25px;" id="submit" onclick=qry() >查询</a>&nbsp;&nbsp;&nbsp;
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-add'" style="width:100px; height: 25px;" id="submit" onclick=exportExcel() >导出</a>
					</td>
				</tr>
			</table>
	            <div id="content" style="margin-left:6px;">
		            
				    	<table width="700"  cellpadding="0" border="0" style="border-collapse:collapse;overflow:scroll;" >
				    	<tr><td colspan="8" id="title" style="display:none;text-align:center;font-size:20px;color:##0E2D5F;font-weight:bold;">班级情况和教室资源统计表</td></tr>
				    	<tr>
				    		<td><table id="t0"></table></td>
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
	        </div>  
    	</div>  
    	
    	<iframe id="frame0" name="frame0"  src=""  marginwidth=0 marginheight=0 frameborder=0 style="width:100%"></iframe>
  	
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
var param;
$(document).ready(function(){
	var staffId=$("#staffId").val();
	$("#schoolId").combobox({
	   url:"<%=path %>/pub/pageCategory.do?staffId="+staffId+"&resourceId=505&fieldId=schoolId",
	   onLoadSuccess:function(){
			var arr =$("#schoolId").combobox("getData");
			if(arr.length>0)
			{
				$("#schoolId").combobox("select",arr[0].schoolId);
			}	
		}                                   
	});
	
});
function closeDlg()
{
	$('#dlg').dialog('close');
}
	
function linkCourse()
{
	$('#dlg').dialog('open').dialog('setTitle', '排课');
	$('#fm').form('clear');

}

function qry()
{
	$("#content").css('display','none');
	var schoolId=$("#schoolId").combobox('getValue');
	param ="{'schoolId':'"+schoolId+"','schoolName':'"+$("#schoolId").combobox('getText')+"'}";
	getWeekTime(schoolId);
	//$("#frame0").attr('src',"/sys/time/planTeacher.jsp?schoolId="+schoolId);
}

function getWeekTime(schoolId)
{
	$.ajax(
	{
		type : "POST",
		url: "/sys/time/roomPlan.do?schoolId="+schoolId,
		async: false,
		dataType:"json",
		beforeSend: function()
    	{
    		$.messager.progress({title : '系统消息', msg : '正在提交数据，请稍等……'});
    	},
    	success: function(data) {
    		$.messager.progress('close');
    		 
    		for(var i=0;i<data.length;i++)
    		{
    			
    			if(i==0)
    			{
    				$("#content").css('display','block');
    				$("#title").css('display','table-cell');
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
	title:" ",	
    width: 100,
    height: 'auto',
    fitColumns: true,
    singleSelect:true,
    rowStyler: function(index,row)
    {
		 return 'background-color:#FFFFFF;color:#00000;';
    },
     
    columns:[[
      {field:'roomName',title:'教室',width:100,align:'center'}
      
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
    title: "周"+weekTime,
    width: 450,
    height: 'auto',
    fitColumns: true,
    singleSelect:true,
    rowStyler: function(index,row)
    {
		 return 'background-color:#FFFFFF;color:#00000;';
    },
    columns:[[
      {field:'HH001',formatter:colformatter,title:'上午1', width:120,align:'center', editor:'text',	styler: colStyle},
      {field:'HH002',formatter:colformatter,title:'上午2',width:120,align:'center', editor:'text',	styler: colStyle},
      {field:'HH003',formatter:colformatter,title:'下午1',width:120,align:'center', editor:'text',	styler: colStyle },
      {field:'HH004',formatter:colformatter,title:'下午2',width:120,align:'center', editor:'text',	styler: colStyle },
      {field:'HH005',formatter:colformatter,title:'晚上',width:120,align:'center', editor:'text',	styler: colStyle } 
    ]],
    onLoadSuccess:function()
    {
      MergeCells(tabId);
    } 
  });
  $('#'+tabId).datagrid("loadData",data);	
}

function colformatter(value, row, index)
{
	if(value!='' && value!=undefined)
	{
		var str=value+"";
	    var vals=str.split("~");
	    return vals[0];
	}else
	{
		return "";
	}
		
}

function colStyle(value,row,index)
{
	
	var str = value+"";
	console.log(str);
 	if (str.indexOf('003')>-1)
	{
		return 'background-color:#87cefa;';
	}else if (str.indexOf('002')>-1 || str.indexOf('001')>-1)
	{
		return 'background-color:#ffee00;';
	}
 	
	 
}

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
			//	console.log(key);
               if(key.indexOf("merge")>-1)
               {
               	var val=datas[i][key];
               	fieldT="HH"+key.substring(5,8);
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
	   var d=$(this).attr("state");
	  
	  if('003'==d)
	  {
		     $(this).css("background-color","#EDE1D8");
	  }else if('002'==d)
	  {
		  $(this).css("background-color","#ECB1D8");
	  }
	
	});
}


function exportExcel()
{
	var rows = $("#t0").datagrid("getData").total;
	if(rows.length<1)
	{
		$.messager.alert('提示', "没有数据可以导出！");
	}
	else
	{
		window.location.href = "/sys/export/exportClassroomCourse.do?param="+param;
	}
}
</script>