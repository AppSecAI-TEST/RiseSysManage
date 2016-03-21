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
  		<input type="hidden" id="resourceId" value="724">
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
	  					<td width="60px" align="right"><span>老师：</span></td>
	  					<td width="110px" align="left">
	  						<select class="easyui-combobox" name="teacherId" id="teacherId" style="width:100px;height: 25px;" editable="false"
	  							data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname', panelHeight: 'auto'">
	  						</select>
	  					</td>
	  					<td width="60px" align="right"><span>月份：</span></td>
	  					<td width="110px" align="left">
	  						<input class="easyui-datebox"  type="text" style="width:100px; height: 25px;" id="time" name="time" editable="false" data-options="formatter:myformatter, parser:myparser"/>
	  					</td>
	  					<td align="left">	
	  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:100px" id="qryBtn" onclick="qryData()"></span>查询</span></a>
	  						&nbsp;&nbsp;
	  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-redo" style="width:100px" id="resetBtn"></span>重置</span></a>
	  					</td>
	  				</tr>
	  			</table>
  			</form>
 				<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:550" id="list_data" toolbar="#toolbar" rownumbers="true" fitColumns="true">
					<thead>
						<tr>
							<th field="schoolName" align="center" width="9%" rowspan="2">校区</th>
							<th field="teacherName" align="center" width="9%" rowspan="2">中文名</th>
							<th field="byname" align="center" width="6%" rowspan="2">英文名</th>
							<th field="projectName" align="center" width="9%" rowspan="2">项目</th>
							<th field="date" align="center" width="62%" colspan="31">日期</th>
							<th field="total" align="center" width="4%" rowspan="2">总计</th>
						</tr>
						<tr>
							<th field="d1" align="center" width="2%">1</th>
							<th field="d2" align="center" width="2%">2</th>
							<th field="d3" align="center" width="2%">3</th>
							<th field="d4" align="center" width="2%">4</th>
							<th field="d5" align="center" width="2%">5</th>
							<th field="d6" align="center" width="2%">6</th>
							<th field="d7" align="center" width="2%">7</th>
							<th field="d8" align="center" width="2%">8</th>
							<th field="d9" align="center" width="2%">9</th>
							<th field="d10" align="center" width="2%">10</th>
							<th field="d11" align="center" width="2%">11</th>
							<th field="d12" align="center" width="2%">12</th>
							<th field="d13" align="center" width="2%">13</th>
							<th field="d14" align="center" width="2%">14</th>
							<th field="d15" align="center" width="2%">15</th>
							<th field="d16" align="center" width="2%">16</th>
							<th field="d17" align="center" width="2%">17</th>
							<th field="d18" align="center" width="2%">18</th>
							<th field="d19" align="center" width="2%">19</th>
							<th field="d20" align="center" width="2%">20</th>
							<th field="d21" align="center" width="2%">21</th>
							<th field="d22" align="center" width="2%">22</th>
							<th field="d23" align="center" width="2%">23</th>
							<th field="d24" align="center" width="2%">24</th>
							<th field="d25" align="center" width="2%">25</th>
							<th field="d26" align="center" width="2%">26</th>
							<th field="d27" align="center" width="2%">27</th>
							<th field="d28" align="center" width="2%">28</th>
							<th field="d29" align="center" width="2%">29</th>
							<th field="d30" align="center" width="2%">30</th>
							<th field="d31" align="center" width="2%">31</th>
						</tr>
					</thead>
				</table>
				<div id="toolbar" style="padding: 2px; height: auto">
	   				<a href="javascript:void(0)" id="export" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">导出全部</a>
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
   	var now =new Date();
	$('#time').datebox("setValue",now.getFullYear()+"-"+(now.getMonth()+1));
	initReportButton("resetBtn","qryFm","schoolId");
	$("#resetBtn").click(function(){
		resetData();
	})
	$("#schoolId").combobox({
	 		onChange:function(){
	 			$("#teacherId").combobox({
					url : "/sys/pubData/getTeacherBySchoolId.do?schoolId="+$("#schoolId").combobox('getValue')
				});
	 		}
	 });
	$("#export").click(function(){
		var param={
			teacherId:$("#teacherId").combobox('getValue'),
			schoolId:$("#schoolId").combobox('getValue'),
			month:$("#time").datebox('getValue')
		};
		if($("#list_data").datagrid("getData").total>0)
		{
			var fileName =parent.$("li.tabs-selected").find("span.tabs-title").html();
			try
			{
				window.location.href="/sys/export/exportTeacherAttend.do?fileName="+fileName+"&param="+JSON.stringify(param);
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
	var teacherId=$("#teacherId").combobox('getValue');
	var schoolId=$("#schoolId").combobox('getValue');
	var month=$("#time").datebox('getValue');
	$.ajax(
	{
		type : "POST",
		url: "/sys/report/getTeacherAttendHours.do?schoolId="+schoolId+"&teacherId="+teacherId+"&month="+month,
		async: true,
		dataType:"json",
		beforeSend: function()
    	{
    		showProgressLoader("正在处理,请稍待...",300)
    	},
    	success: function(data) 
    	{
    		hideProgressLoader();
    		$('#list_data').datagrid("loadData",data);
    		MergeCells("list_data","schoolName");
    		MergeCellWidthSchool("list_data","teacherName");
    		MergeCellWidthSchool("list_data","byname");
         },
        error:function()
        {
        	hideProgressLoader();
        }
	});
	
} 



  function MergeCellWidthSchool(tableID, fldList) {
            var Arr = fldList.split(",");
            var dg = $('#' + tableID);
            var fldName;
            var RowCount = dg.datagrid("getRows").length;
            var span;
            var PerValue = "";
            var PreSchool ="";
            var CurValue = "";
            var CurSchool ="";
            var length = Arr.length - 1;
            for (i = length; i >= 0; i--) {
                fldName = Arr[i];
                PerValue = "";
                PreSchool="";
                span = 1;
                for (row = 0; row <= RowCount; row++) {
                    if (row == RowCount) {
                        CurValue = "";
                        CurSchool="";
                    }
                    else {
                        CurValue = dg.datagrid("getRows")[row][fldName];
                        CurSchool =  dg.datagrid("getRows")[row]["schoolId"]
                    }
                    if (PerValue == CurValue&&PreSchool==CurSchool) {
                        span += 1;
                    }
                    else {
                        var index = row - span;
                        dg.datagrid('mergeCells', {
                            index: index,
                            field: fldName,
                            rowspan: span,
                            colspan: null
                        });
                        span = 1;
                        PerValue = CurValue;
                        PreSchool = CurSchool;
                    }
                }
            }
        }
</script>