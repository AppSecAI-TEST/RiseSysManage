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
  		<input id="staffId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  		<input type="hidden" id="resourceId" value="723">
  		<div style="margin-right:5px;">
  			<form id="qryFm">
	  			<table class="search_tab">
	  				<tr>
	  					<td width="80px" align="right"><span>校区：</span></td>
	  					<td width="110px" align="left">
	  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
								data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'">
				        	</select>
	  					</td>
	  					<td width="80px" align="right"><span>教师英文名：</span></td>
	  					<td width="110px" align="left">
	  						<input class="easyui-textbox"  id="teacherId" name="teacherId" style="width:100px; height: 25px;">
	  					</td>
	  					<td width="50px" align="right"><span>月份：</span></td>
	  					<td width="11px" align="left">
	  						<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="time" name="time" data-options="formatter:myformatter, parser:myparser" editable="false"/>
	  					</td>
	  					<td align="left">	
	  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:100px" id="qryBtn" onclick="qryData()">查询</a>
	  							&nbsp;&nbsp;
	  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-reload" style="width:100px" id="resetBtn" onclick="resetData()">重置</a>
	  					</td>
	  				</tr>
	  			</table>
  			</form>
					<table class="easyui-datagrid" style="height:435px;" id="list_data" title="查询结果" toolbar="#toolbar" pagination="false" fitColumns="true" >
					<thead>
						<tr>
							<th field="schoolName" align="center" width="6%" rowspan="2">校区</th>
							<th field="teacherName" align="center" width="6%" rowspan="2">中文名</th>
							<th field="byname" align="center" width="6%" rowspan="2">英文名</th>
							<th field="hireDate" align="center" width="6%" rowspan="2">入职时间</th>
							<th field="month_num" align="center" width="6%" rowspan="2">入职时长</th>
							<th field="graAchieve" align="center" width="12%" colspan="2">升学业绩</th>
							<th field="wom_A" align="center" width="12%" colspan="2">升学退费情况</th>
							<th field="wom_A" align="center" width="6%" rowspan="2">口碑业绩</th>
							<th field="wom_X" align="center" width="6%" rowspan="2">口碑退费</th>
							<th field="short_tour_A" align="center" width="6%" rowspan="2">游学业绩</th>
							<th field="short_tour_X" align="center" width="6%" rowspan="2">游学退费</th>
							<th field="short_class_A" align="center" width="6%" rowspan="2">国际班业绩</th>
							<th field="short_class_X" align="center" width="6%" rowspan="2">国际班退费</th>
						</tr>
						<tr>
							<th field="personA" align="center" width="6%">个数</th>
							<th field="yearA" align="center" width="6%">年数</th>
							<th field="courseXPersonNum" align="center" width="6%">个数</th>
							<th field="courseXYearNum" align="center" width="6%">年数</th>
						</tr>
					</thead>
				</table>
				<div id="toolbar" style="padding: 2px; height: auto">
	   				<a href="javascript:void(0)" id="export" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">导出全部</a>
				</div>
			</div>
  	</body>
</html>
<script type="text/javascript">
$(document).ready(function(){
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
            }});
 	initReportButton("resetBtn","qryFm","schoolId");	
	$("#export").click(function(){
		var param={
			teacherId:$("#teacherId").textbox('getValue'),
			schoolId:$("#schoolId").combobox('getValue'),
			month:$("#time").datebox('getValue')
		};
		if($("#list_data").datagrid("getData").total>0)
		{
			var fileName =parent.$("li.tabs-selected").find("span.tabs-title").html();
			try
			{
				window.location.href="/sys/export/exportTeacherNum.do?fileName="+fileName+"&param="+JSON.stringify(param);
			}
			catch(e)
			{
				$.messager.alert('提示', "模版不存在！",function(){
					window.history.back();
				});
			}
		}
		else
		{
			$.messager.alert('提示', "没有数据可以导出！");
		}	
	})
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
  
function resetData()
{
	var now =new Date();
	$('#time').datebox("setValue",now.getFullYear()+"-"+(now.getMonth()+1));
}
  
  
function qryData()
{
	var teacherId=$("#teacherId").textbox('getValue');
	var schoolId=$("#schoolId").combobox('getValue');
	var month=$("#time").datebox('getValue');
	if(month=='')
	{
		$.messager.alert('提示', "请选择月份");
		return ;
	}
	$.ajax(
	{
		type : "POST",
		url: "/sys/report/getTeacherNum.do?schoolId="+schoolId+"&teacherId="+teacherId+"&month="+month,
		async: true,
		dataType:"json",
		beforeSend: function()
    	{
    		showProgressLoader("正在查询,请稍后...",300)
    	},
    	success: function(data) 
    	{
    		hideProgressLoader();
    		$('#list_data').datagrid("loadData",data);
         },
        error:function()
        {
        	hideProgressLoader();
        }
	});
	
} 

</script>