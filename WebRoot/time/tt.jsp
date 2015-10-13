<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
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
	min-width:400px;
	margin-top:5px;
	width:20%;
}
.tree-node-hover{
text-decoration:none;color:#555555; background: #fae8bd; 
}
datagrid-row-selected
</style>
	</head>
	<body>
    	<table>
    	<tr>
	    	<td>
	    	<table  id="t1"></table>
	    	<div id="tb" style="height:auto">
			<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save',plain:true" onclick="accept()">保存</a>
			 
	</div>
	    	</td>
	    	
    	</tr>
    	</table>
    		<select name="classInstId" id="classInstId" class="easyui-combobox" style="width: 150px; height: 28px;"
					url="/sys/pubData/qryData.do?param={'queryCode':'Qry_School_Time','schoolId':'1001'}",
					data-options=" valueField: 'classInstId', textField: 'className', panelHeight: 'auto'" >
 					</select>
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
	$.ajax(
	{
		type : "POST",
		url: "/sys/time/getTimeByWeek.do?",
		data: "param={'month':'10','week':'1'}",
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
    				json1=data[i];
    				initTable("t1",json1);
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

function initTable(tabId,data)
{
	var rows=data.rows;
	var time=rows[0].schooltime;
	var weekTime=rows[0].weekTime;
	$('#'+tabId).datagrid({
    title: time+"(周"+weekTime+")",
    width: 400,
    height: 'auto',
    method:'get',
    fitColumns: true,
    singleSelect:true,
    onClickCell:onClickCell, 
    rowStyler: function(index,row)
    {
		 return 'background-color:#FFFFFF;color:#00000;';
    },
    columns:[[
      {field:'teacherName',title:'老师',width:50,align:'center'},
      {field:'H001',title:'8:30',width:50,align:'center',editor:'text'},
      {field:'H002',title:'10:30',width:50,align:'center',editor:'text'},
      {field:'H003',title:'14:00',width:50,align:'center',editor:'text'},
      {field:'H004',title:'16:00',width:50,align:'center',editor:'text'},
      {field:'H005',title:'18:30',width:100,align:'center',formatter: function(Confirmation, rowIndex)
    	  {
	    	   
	    		  return "<a class='editcls'  >排课</a>"
	    	   
    	  }
      } 
    ]],
    onLoadSuccess:function()
    {
	$(this).datagrid('freezeRow',0);	
     $('.editcls').linkbutton({text:'排课',plain:true,iconCls:'icon-add'});  
    
    }
  });
  $('#'+tabId).datagrid("loadData",data);	
}

function test()
{
	alert("1");	
}

$(document).ready(function()
{
	getWeekTime();
});


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

function endEditing(tab)
{
	if (editIndex == undefined){return true}
	if ($(tab).datagrid('validateRow', editIndex))
	{
		$(tab).datagrid('endEdit', editIndex);
		
		var rowVal = $(tab).datagrid('getData').rows[editIndex];
		
		var val=rowVal[editField]+"";
		
		var vals = val.split("/");
		
		var className=vals[0];
		
		var roomName=vals[1];
		
		var teacherType=vals[2];
		
		var hourRange=vals[3];
		
		editIndex = undefined;
		return true;
	} else
	{
		return false;
	}
}

function onClickCell(index, field)
{
	if (endEditing(this))
	{
		var s=  $(this).datagrid('getData');
	 	var rows =s.rows;
		$(this).datagrid('selectRow', index).datagrid('editCell', {index:index,field:field});
		editIndex = index;
		editField=field;
	}
}
	</script>