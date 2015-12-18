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
		<input type="hidden" id="schoolId" name="schoolId" value="${sessionScope.StaffT.schoolId}"/>
			<table   style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:0 auto;height:30px;" cellspacing="2">
				<tr>
					<td  align="right" width="75px">
						<span>排课月份：</span>
					</td>
					<td  align="left" width="8px">
						<input class="easyui-datebox"  type="text" style="width:100px; height: 25px;" id="time" name="startTime" editable="false" data-options="formatter:myformatter, parser:myparser"/>
					</td>
					<td>
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" style="width:100px; height: 25px;" id="submit" funcNodeId="1000">创建</a>
					</td>
				</tr>
			</table>
		 
		<div style="padding:5px 0;min-width:1100px; width:100%;">
			<table class="easyui-datagrid" title="排课" style="height:435px;" toolbar="#toolbar" pagination="true" rownumbers="false" fitColumns="true" singleSelect="false" id="weekDg" url="">
				 <thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
					<th data-options="field:'schoolName',width:25,align:'center'">周</th>
					<th data-options="field:'month',width:25,align:'center'">时间段</th>
					<th data-options="field:'staffName',width:25,align:'center'">是否排课</th>
					<th data-options="field:'createDate',width:25,align:'center'">创建时间</th>
				</tr>
				</thead>
			</table>
		</div>
		<div style="min-width:1100px;overflow:auto;margin-left:7px;width:99%">
		<div class="easyui-panel" title="排课信息">
		<table class="maintable" id="hoursPlanTab" cellspacing="0" cellpadding="0">
		  <tr align="center">
		    <td align="center" width="40px;" rowspan="2"><span>序号</span></td>
		    <td align="center" width="78px;" rowspan="2"><span>班级</span></td>
		    <td align="center" width="96px;" rowspan="2"><span>带班老师</span></td>
		    <td align="center" width="240px;"rowspan="2"><span>上课时段</span></td>
		    <td align="center" width="86px;" rowspan="2"><span>开课日期</span></td>
		    <td align="center" width="86px;" rowspan="2"><span>结课日期</span></td>
		    <td align="center" rowspan="2"><span>上月已上课时</span></td>
		    <td align="center" rowspan="2"><span>上月剩余课时数</span></td>
		    <td align="center" rowspan="2"><span>上月课时差异</span></td>
		    <td align="center" colspan="2"><span>第一周</span></td>
		    <td align="center" colspan="2"><span>第二周</span></td>
		    <td align="center" colspan="2"><span>第三周</span></td>
		    <td align="center" colspan="2"><span>第四周</span></td>
		    <td align="center" colspan="2"><span>第五周</span></td>
		    <td align="center" colspan="2"><span>第六周</span></td>
		    <td align="center" colspan="2"><span>第日周</span></td>
		    <td align="center" rowspan="2"><span>本月计划课时</span></td>
		    <td align="center" rowspan="2"><span>本月已排课时</span></td>
		    <td align="center" rowspan="2"><span>课时差异</span></td>
		  </tr>
		  <tr align="center">
		    <td align="center"><span>计划课时</span></td>
		    <td align="center"><span>已排课时</span></td>
		    <td align="center"><span>计划课时</span></td>
		    <td align="center"><span>已排课时</span></td>
		    <td align="center"><span>计划课时</span></td>
		    <td align="center"><span>已排课时</span></td>
		    <td align="center"><span>计划课时</span></td>
		    <td align="center"><span>已排课时</span></td>
		    <td align="center"><span>计划课时</span></td>
		    <td align="center"><span>已排课时</span></td>
		    <td align="center"><span>计划课时</span></td>
		    <td align="center"><span>已排课时</span></td>
		    <td align="center"><span>计划课时</span></td>
		    <td align="center"><span>已排课时</span></td>
		  </tr>
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
            	$.ajax(
				{
					type : "POST",
					url: "/sys/time/hoursPlan.do?schoolId="+$("#schoolId").val()+"&month="+newValue,
					async: true,
					dataType:"json",
					beforeSend: function()
			    	{
			    		$.messager.progress({text:'排课中，请稍候...'});
			    	},
			    	success: function(data) 
			    	{
			    		$.messager.progress('close');
			    		var html="<tr>"+$("#hoursPlanTab").find("tr:eq(0)").html()+"</tr><tr>"+$("#hoursPlanTab").find("tr:eq(1)").html()+"</tr>";
			    		for(var i=0;i<data.length;i++)
			    		{
			    			var obj=data[i];
			    			 html+="<tr>";
			    			html+="<td align='center'>"+(i+1)+"</td>";
			    			html+="<td align='center'><span>"+obj.className+"</span></td>";
			    			html+="<td align='center'><span>"+obj.byname+"</span></td>";
			    			html+="<td align='center'><span>"+obj.dateRange+"</span></td>";
			    			html+="<td align='center'><span>"+obj.startDate+"</span></td>";
			    			html+="<td align='center'><span>"+obj.finishDate+"</span></td>";
			    			html+="<td align='center'><span>"+obj.realHour+"</span></td>";
			    			html+="<td align='center'><span>"+obj.diffNum+"</span></td>";
			    			html+="<td align='center'><span>"+obj.monthDiffNum+"</span></td>";
			    			html+="<td align='center'><span>"+obj.weekPlan1+"</span></td>";
			    			html+="<td align='center'><span>"+obj.weekHand1+"</span></td>";
			    			html+="<td align='center'><span>"+obj.weekPlan2+"</span></td>";
			    			html+="<td align='center'><span>"+obj.weekHand2+"</span></td>";
			    			html+="<td align='center'><span>"+obj.weekPlan3+"</span></td>";
			    			html+="<td align='center'><span>"+obj.weekHand3+"</span></td>";
			    			html+="<td align='center'><span>"+obj.weekPlan4+"</span></td>";
			    			html+="<td align='center'><span>"+obj.weekHand4+"</span></td>";
			    			html+="<td align='center'><span>"+obj.weekPlan5+"</span></td>";
			    			html+="<td align='center'><span>"+obj.weekHand5+"</span></td>";
			    			html+="<td align='center'><span>"+obj.weekPlan6+"</span></td>";
			    			html+="<td align='center'><span>"+obj.weekHand6+"</span></td>";
			    			html+="<td align='center'><span>"+obj.weekPlan7+"</span></td>";
			    			html+="<td align='center'><span>"+obj.weekHand7+"</span></td>";
			    			html+="<td align='center'><span>"+obj.monthPlanHours+"</span></td>";
			    			html+="<td align='center'><span>"+obj.monthHandHours+"</span></td>";
			    			html+="<td align='center'><span>"+obj.mDiffNum+"</span></td>";
			    			html+="</tr>";
			    		}
						
						$("#hoursPlanTab").html(html);
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
	if(time=='')
	{
		$.messager.alert("提示","请选择排课月份");
		return;
	}
	
	var param={};
	param.handlerId=$("#handlerId").val();
	param.schoolId=$("#schoolId").val();
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
        {field:'date',title:'时间段',width:25,align:'center'},  
        {field:'isPlan',title:'是否排课',width:25,align:'center'},  
        {field:'createDdate',title:'创建时间',width:25,align:'center', 
            formatter: function(Confirmation, row)
            {  
              var btn = '<a class="editcls" onclick="planWeek(\''+row.weekSeq+'\',\''+row.month+'\',\''+row.createWeekId+'\')"  href="javascript:void(0)">排课</a>';  
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
 
  
function planWeek(weekSeq,month,createWeekId)
{ 
	window.location.href="/sys/time/planTime.jsp?month="+month+"&weekSeq="+weekSeq+"&createWeekId="+createWeekId;
}
</script>