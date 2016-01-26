<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
	<style>
		.table-c table{border-right:1px solid  #9370DB ;border-bottom:1px solid  #9370DB }
		.table-c table td{border-left:1px solid  #9370DB ;border-top:1px solid  #9370DB }
	</style>
  	</head>
  
  	<body>
		<input type="hidden" id="handlerId" name="handlerId"   value="${sessionScope.StaffT.staffId}"/>
		<div style="margin-right:5px;">
			<table class="search_tab" >
				<tr>
				<td align="right"><span>校区：</span></td>
  					<td width="100px">
					<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
						data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto',
		      			onLoadSuccess:function(data){if(data.length > 0) $('#schoolId').combobox('setValue',data[0].schoolId);}"
		      			url="<%=path %>/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&resourceId=505&fieldId=schoolId">
	        		</select>
					</td>
					<td  align="right" width="75px">
						<span>排课月份：</span>
					</td>
					<td  align="left" width="8px">
						<input class="easyui-datebox"  type="text" style="width:100px; height: 25px;" id="time" name="startTime" editable="false" data-options="formatter:myformatter, parser:myparser"/>
					</td>
					<td>
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" style="width:100px; height: 25px;" id="submit" funcNodeId="1000">创建</a>
						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:100px" onclick="javascript:window.history.back()">返回</a>
					</td>
				</tr>
			</table>
		 
		<div style="padding:5px 0;min-width:1100px; width:100%;">
			<table class="easyui-datagrid" title="排课" style="height:500px;" toolbar="#toolbar" pagination="true" rownumbers="false" fitColumns="true" singleSelect="false" id="weekDg" url="">
				 <thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
					<th data-options="field:'schoolName',width:25,align:'center'">周</th>
					<th data-options="field:'month',width:25,align:'center'">时间段</th>
					<th data-options="field:'staffName',width:25,align:'center'">是否排课</th>
					<th data-options="field:'createDate',width:25,align:'center'">操作</th>
				</tr>
				</thead>
			</table>
			<table id="hoursPlanTab" class="easyui-datagrid" title="排课信息" style="height:auto;min-max:1100px;" pagination="false" rownumbers="true" fitColumns="true" >
			 <thead>
			 	<tr align="center">
				    <th data-options="field:'className',width:78,align:'center'" rowspan="2"><span>班级</span></td>
				    <th data-options="field:'byname',width:90,align:'center'" rowspan="2"><span>带班老师</span></td>
				    <th data-options="field:'dateRange',width:240,align:'center'" rowspan="2"><span>上课时段</span></td>
				    <th data-options="field:'startDate',width:86,align:'center'" rowspan="2"><span>开课日期</span></td>
				    <th data-options="field:'finishDate',width:86,align:'center'" rowspan="2"><span>结课日期</span></td>
				    <th data-options="field:'realHour',width:60,align:'center'" rowspan="2"><span>上月已上<br>课时</span></td>
				    <th data-options="field:'diffNum',width:60,align:'center'" rowspan="2"><span>上月剩余<br>课时数</span></td>
				    <th data-options="field:'monthDiffNum',width:60,align:'center'" rowspan="2"><span>上月课时<br>差异</span></td>
				    <th data-options="field:'week1',width:62,align:'center'" colspan="2"><span>第一周</span></td>
				    <th data-options="field:'week2',width:62,align:'center'" colspan="2"><span>第二周</span></td>
				    <th data-options="field:'week3',width:62,align:'center'" colspan="2"><span>第三周</span></td>
				    <th data-options="field:'week4',width:62,align:'center'" colspan="2"><span>第四周</span></td>
				    <th data-options="field:'week5',width:62,align:'center'" colspan="2"><span>第五周</span></td>
				    <th data-options="field:'monthPlanHours',width:48,align:'center'" rowspan="2"><span>本月计<br>划课时</span></td>
				    <th data-options="field:'monthHandNum',width:48,align:'center'" rowspan="2"><span>本月已<br>排课时</span></td>
				    <th data-options="field:'mDiffNum',width:48,align:'center'" rowspan="2"><span>课时<br>差异</span></td>
				 </tr>
				 <tr align="center">
				    <th data-options="field:'weekPlan1',width:35,align:'center'"><span>计划<br>课时</span></td>
				    <th data-options="field:'weekHand1',width:35,align:'center'"><span>已排<br>课时</span></td>
				    <th data-options="field:'weekPlan2',width:35,align:'center'"><span>计划<br>课时</span></td>
				    <th data-options="field:'weekHand2',width:35,align:'center'"><span>已排<br>课时</span></td>
				    <th data-options="field:'weekPlan3',width:35,align:'center'"><span>计划<br>课时</span></td>
				    <th data-options="field:'weekHand3',width:35,align:'center'"><span>已排<br>课时</span></td>
				    <th data-options="field:'weekPlan4',width:35,align:'center'"><span>计划<br>课时</span></td>
				    <th data-options="field:'weekHand4',width:35,align:'center'"><span>已排<br>课时</span></td>
				    <th data-options="field:'weekPlan5',width:35,align:'center'"><span>计划<br>课时</span></td>
				    <th data-options="field:'weekHand5',width:35,align:'center'"><span>已排<br>课时</span></td>
				 </tr>
			  <thead>
		</table>
	</div>
	</div>	
 	</body>
</html>
<script type="text/javascript">
$(function () {
        $('#time').datebox({
            onShowPanel: function () {//显示日趋选择对象后再触发弹出月份层的事件，初始化时没有生成月份层
        		var p = $('#time').datebox('panel'), //日期选择对象
            	span = p.find('span.calendar-text'); //显示月份层的触发控件
            	p.find(".calendar-menu-year").attr("readOnly","true");
            	span.click(function(){
            		p.find('div.calendar-menu').hide();
            	});
                span.get(0).click(); //触发click事件弹出月份层
                p.find("div.datebox-button").find("td:eq(0)").css("visibility","hidden");//隐藏今天按钮
                var months = p.find(".calendar-menu-month-inner").find(".calendar-menu-month");
                months.unbind();
                months.click(function(){
                	var year = /\d{4}/.exec(span.html())[0]//得到年份
                    , month = parseInt($(this).attr('abbr'))+1;
                	if(month<10)
                	{
                		month="0"+month;
                	}
                	var val =year + '-' + month+"-00";
                    $('#time').datebox('setValue',val).datebox('hidePanel'); //设置日期的值
             	});
            },
            onChange:function(newValue){
            	var schoolId=+$("#schoolId").combobox('getValue');
            	$.ajax(
				{
					type : "POST",
					url: "/sys/time/hoursPlan.do?schoolId="+schoolId+"&month="+newValue,
					async: true,
					dataType:"json",
					beforeSend: function()
			    	{
			    		$.messager.progress({text:'排课中，请稍候...'});
			    	},
			    	success: function(data) 
			    	{
			    		$.messager.progress('close');
			    		var dataobj ={
			    			rows:data,
			    			total:data.length
			    		}
			    		$("#hoursPlanTab").datagrid("loadData",dataobj);
			         },
			        error:function()
			        {
			        	$.messager.progress('close');
			        }
				});
            	
            }
            //formatter: function (d) { return d.getFullYear() + '-' + d.getMonth(); }//配置formatter，只返回年月
    	});
     }


);   

function myformatter(date){
            var y = date.getFullYear();
            var m = date.getMonth()+1;
            var d = date.getDate();
            return y+'-'+(m<10?('0'+m):m);
        }

  function myparser(s){
            if (!s) return new Date();
            var ss = (s.split('-'));
            var y = parseInt(ss[0],10);
            var m = parseInt(ss[1],10);
            var d = parseInt(ss[2],10);
            if (!isNaN(y) && !isNaN(m) && !isNaN(d)){
                return new Date(y,m-1,d);
            } else {
                return new Date();
            }
        }
  
var time;
$("#submit").click(function()
{
	time=$("#time").datebox('getValue');
	var schoolId=$("#schoolId").combobox('getValue');
	if(schoolId=='' && schoolId=='10')
	{
		$.messager.alert("提示","请选择校区");
		return;
	}
	if(time=='')
	{
		$.messager.alert("提示","请选择排课月份");
		return;
	}
	
	var param={};
	param.handlerId=$("#handlerId").val();
	param.schoolId=$("#schoolId").combobox('getValue');
	param.month=time;
	$.ajax(
	{
		type : "POST",
		url: "/sys/time/getWeek.do?",
		data: "param="+JSON.stringify(param),
		async: true,
		dataType:"json",
		beforeSend: function()
    	{
    		$.messager.progress({text:'排课中，请稍候...'});
    	},
    	success: function(data) 
    	{
    		$.messager.progress('close');
    		if(data.flag)
    		{
    			init(data);
    		}else
    		{
    			$.messager.alert('提示', data.msg);
    		}
         },
        error:function()
        {
        	$.messager.progress('close');
        }
	});
	
});

function init(data)
{
	
$('#weekDg').datagrid({  
	border:false,  
    fitColumns:true,  
    singleSelect: true,  
    columns:[[  
        {field:'weekName',title:'周',width:25,align:'center'},  
        {field:'dateRange',title:'时间段',width:25,align:'center'},  
        {field:'isPlan',title:'是否排课',width:25,align:'center'},  
        {field:'createDdate',title:'操作',width:25,align:'center', 
            formatter: function(Confirmation, row)
            {  
              var btn = '<a class="editcls" onclick="planWeek(\''+row.weekSeq+'\',\''+row.dateRange+'\',\''+row.month+'\',\''+row.createWeekId+'\',\''+row.schoolId+'\')"  href="javascript:void(0)">排课</a>';  
                return btn;  
            }  
        }  
    ]],  
    onLoadSuccess:function(data){  
        $('.editcls').linkbutton({text:'排课',plain:true,iconCls:'icon-edit'});  
    }  
});  
 $('#weekDg').datagrid("loadData",data);	
}
 
  
function planWeek(weekSeq,dateRange,month,createWeekId,schoolId)
{
	$.ajax(
	{
		type : "POST",
		url: "/sys/time/updateCreateWeek.do?",
		data: "createWeekId="+createWeekId,
		async: false,
		dataType:"json",
		beforeSend: function()
    	{
    		$.messager.progress({title : '系统消息', msg : '正在提交数据，请稍等……'});
    	},
    	success: function(data) 
    	{
    		$.messager.progress('close');
        },
        error:function()
        {
        	$.messager.progress('close'); 
        }
	});
	window.location.href="/sys/time/planTime.jsp?month="+month+"&weekSeq="+weekSeq+"&createWeekId="+createWeekId+"&dateRange="+dateRange+"&schoolId="+schoolId;
}
 
</script>