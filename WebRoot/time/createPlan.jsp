<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
	
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
			<table  class="easyui-datagrid" title="排课" style="height:435px;" id="weekDg" url=""></table>
		</div>
		<table style="min-width:1100px;width:99%;border:1px solid #95B8E7;font-family:'微软雅黑';margin:0 auto;height:30px;" border="1px" cellspacing="0">
		  <tr>
		    <td rowspan="2">序号</td>
		    <td rowspan="2">班级</td>
		    <td rowspan="2">带班老师</td>
		    <td rowspan="2">上课时段</td>
		    <td rowspan="2">开课日期</td>
		    <td rowspan="2">结课日期</td>
		    <td rowspan="2">上月已上课时</td>
		    <td rowspan="2">上月剩余课时数</td>
		    <td rowspan="2">上月课时差异</td>
		    <td colspan="2">第一周</td>
		    <td colspan="2">第二周</td>
		    <td colspan="2">第三周</td>
		    <td colspan="2">第四周</td>
		    <td colspan="2">第五周</td>
		  </tr>
		  <tr>
		    <td>计划课时</td>
		    <td>已排课时</td>
		    <td>计划课时</td>
		    <td>已排课时</td>
		    <td>计划课时</td>
		    <td>已排课时</td>
		    <td>计划课时</td>
		    <td>已排课时</td>
		    <td>计划课时</td>
		    <td>已排课时</td>
		  </tr>
		  
		  <tr>
		    <td height="61">&nbsp;</td>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
		    <td>&nbsp;</td>
		  </tr>
		</table>
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
            
            //formatter: function (d) { return d.getFullYear() + '-' + d.getMonth(); }//配置formatter，只返回年月
    	});
     });   

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
		async: false,
		dataType:"json",
		beforeSend: function()
    	{
    		showProgressLoader("正在提交数据,请稍等...",500)
    	},
    	success: function(data) 
    	{
    		hideProgressLoader();
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
        	hideProgressLoader();
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
        {field:'weekName',title:'周',width:80},  
        {field:'date',title:'时间段',width:25},  
        {field:'isPlan',title:'是否排课',width:25},  
        {field:'createDdate',title:'创建时间',width:25, 
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