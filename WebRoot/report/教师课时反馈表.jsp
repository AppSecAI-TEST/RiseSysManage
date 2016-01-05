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
  		<div style="padding:5px 10px;">
  			<form id="qryFm">
	  			<table>
	  				<tr>
	  					<td>校区：</td>
	  					<td>
	  					<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
									data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto',
					      			onLoadSuccess:function(data){if(data.length > 0) $('#schoolId').combobox('setValue',data[0].schoolId);}"
					      			url="<%=path %>/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&resourceId=&fieldId=schoolId">
				        		</select>
	  					</td>
	  					<td>老师：</td>
	  					<td>
	  						<input class="easyui-combobox"  id="teacherId" style="width:150px;">
	  					</td>
	  					<td>月份：</td>
	  					<td>
	  						<select class="easyui-combobox" name="time" id="time" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  					<td>	
	  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:150px" id="qryBtn" onclick="qryData()">查询</a>
	  					</td>
	  					<td>
	  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-save" style="width:150px" id="qryBtn" onclick="exportData()">导出</a>
	  					</td>
	  				</tr>
	  			</table>
  			</form>
			<div style="padding:5px 0;">
				<table class="easyui-datagrid" title="查询结果" style="width:100%;height:550px" id="list_data" fitColumns="true">
					<thead>
						<tr>
							<th field="schoolName" align="center" width="9%" rowspan="2">校区</th>
							<th field="teacherName" align="center" width="9%" rowspan="2">中文名</th>
							<th field="byname" align="center" width="9%" rowspan="2">英文名</th>
							<th field="projectName" align="center" width="9%" rowspan="2">项目</th>
							<th field="date" align="center" width="62%" colspan="31">日期</th>
							<th field="total" align="center" width="2%" rowspan="2">总计</th>
						</tr>
						<tr>
							<th field="1" align="center" width="2%">1</th>
							<th field="2" align="center" width="2%">2</th>
							<th field="3" align="center" width="2%">3</th>
							<th field="4" align="center" width="2%">4</th>
							<th field="5" align="center" width="2%">5</th>
							<th field="6" align="center" width="2%">6</th>
							<th field="7" align="center" width="2%">7</th>
							<th field="8" align="center" width="2%">8</th>
							<th field="9" align="center" width="2%">9</th>
							<th field="10" align="center" width="2%">10</th>
							<th field="11" align="center" width="2%">11</th>
							<th field="12" align="center" width="2%">12</th>
							<th field="13" align="center" width="2%">13</th>
							<th field="14" align="center" width="2%">14</th>
							<th field="15" align="center" width="2%">15</th>
							<th field="16" align="center" width="2%">16</th>
							<th field="17" align="center" width="2%">17</th>
							<th field="18" align="center" width="2%">18</th>
							<th field="19" align="center" width="2%">19</th>
							<th field="20" align="center" width="2%">20</th>
							<th field="21" align="center" width="2%">21</th>
							<th field="22" align="center" width="2%">22</th>
							<th field="23" align="center" width="2%">23</th>
							<th field="24" align="center" width="2%">24</th>
							<th field="25" align="center" width="2%">25</th>
							<th field="26" align="center" width="2%">26</th>
							<th field="27" align="center" width="2%">27</th>
							<th field="28" align="center" width="2%">28</th>
							<th field="29" align="center" width="2%">29</th>
							<th field="30" align="center" width="2%">30</th>
							<th field="31" align="center" width="2%">31</th>
						</tr>
					</thead>
				</table>
			</div>
  		</div>
  	</body>
</html>
<script type="text/javascript">
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
  
function qryData()
{
	time=$("#time").datebox('getValue');
	if(time=='')
	{
		//$.messager.alert("提示","请选择排课月份");
		//return;
	}
	
	 
	var teacherId=$("#teacherId").combobox('getValue');
	var schoolId=$("#schoolId").combobox('getValue');
	var month='2015-12';
	$.ajax(
	{
		type : "POST",
		url: "/sys/report/getTeacherAttendHours.do?schoolId="+schoolId+"&teacherId="+teacherId+"&month="+month,
		async: true,
		dataType:"json",
		beforeSend: function()
    	{
    		//$.messager.progress({text:'排课中，请稍候...'});
    	},
    	success: function(data) 
    	{
    		$.messager.progress('close');
    		$('#list_data').datagrid("loadData",data);
         },
        error:function()
        {
        	$.messager.progress('close');
        }
	});
	
} 

</script>