<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<%@ include file="../common/pub.jsp" %>
		 
  	</head>
  
  	<body>
		<input type="hidden" id="staffId" name="staffId" value="${sessionScope.StaffT.staffId}"/>
		<div style="margin-right:5px;">
		<form id="qryFm">
			<table class="search_tab">
				<tr>
					<td width="80px" align="right"><span>校区：</span></td>
	  				<td width="110px">
						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
						data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto',
			      		onLoadSuccess:function(data){$('#schoolId').combobox('setValue',data[0].schoolId);}"
			      		url="<%=path %>/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&resourceId=504&fieldId=schoolId">
		        		</select>
					</td>
					<td width="80px" align="right">
						<span>排课月份：</span>
					</td>
					<td width="260px" align="left">
						<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="startTime" name="startTime" editable="false" data-options="formatter:myformatter, parser:myparser"/>
						<span>至</span>
						<input class="easyui-datebox" type="text" style="width:100px; height: 25px;" id="endTime" name="endTime" editable="false" data-options="formatter:myformatter, parser:myparser"/>
					</td>
					<td align="left">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px; height: 25px;" id="qryBtn" funcNodeId="50014">查询</a>
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px; height: 25px;" id="reset">重置</a>
					</td>
				</tr>
			</table>
		</form>
		<div style="padding:5px 0;min-width:1100px; width:100%;">
			<table class="easyui-datagrid" title="排课列表" style="height:435px;" id="list_data"   
				toolbar="#toolbar" pagination="true" rownumbers="false" fitColumns="true" singleSelect="true">
				 <thead>
					<tr>
						<th data-options="field:'ck',checkbox:true"></th>
						<th data-options="field:'schoolName',width:20,align:'center'">校区</th>
						<th data-options="field:'month',width:30,align:'center'">排课月份</th>
						<th data-options="field:'staffName',width:30,align:'center'">创建人</th>
						<th data-options="field:'createDate',width:30,align:'center'">创建时间</th>
					</tr>
				</thead>
			</table>
		</div>
		<div id="toolbar" style="padding: 2px; height: auto">
   			<a href="javascript:void(0)" id="createPlan" href="" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;" funcNodeId="50014">创建排课</a>
   			<a href="javascript:void(0)" id="updatePlan" class="easyui-linkbutton" iconCls="icon-edit" style="width: 100px;" >维护排课</a>
   			<a href="javascript:void(0)" id="viewPlan" class="easyui-linkbutton" iconCls="icon-redo" style="width: 100px;">浏览排课</a>
		</div>
  	</div>
 	</body>
</html>
<script type="text/javascript">
   	 $('#startTime').datebox({
            onShowPanel: function () {//显示日趋选择对象后再触发弹出月份层的事件，初始化时没有生成月份层
        		var p = $('#startTime').datebox('panel'), //日期选择对象
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
                    $('#startTime').datebox('setValue',val).datebox('hidePanel'); //设置日期的值
             	});
            },
            
            //formatter: function (d) { return d.getFullYear() + '-' + d.getMonth(); }//配置formatter，只返回年月
    	});
   	 $('#endTime').datebox({
            onShowPanel: function () {//显示日趋选择对象后再触发弹出月份层的事件，初始化时没有生成月份层
        		var p = $('#endTime').datebox('panel'), //日期选择对象
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
                    $('#endTime').datebox('setValue',val).datebox('hidePanel'); //设置日期的值
             	});
            },
            
            //formatter: function (d) { return d.getFullYear() + '-' + d.getMonth(); }//配置formatter，只返回年月
    	});
    
    $("#qryBtn").click(function()
    {
    	var funcNodeId = $("#qryBtn").attr("funcNodeId");
	    var startTime= $("#startTime").datebox('getValue');
	    var endTime= $("#endTime").datebox('getValue');;
	    if(startTime=='')
	    {
	    	startTime='2014-01-01';
	    }else
	    {
	    	startTime=startTime+"-01";
	    }
	    if(endTime=='')
	    {
	    	endTime='2036-01-01';
	    }else
	    {
	    	endTime=endTime+"-01";
	    }
	    var obj={};
	    obj.funcNodeId=funcNodeId;
	    obj.startTime=startTime;
	    obj.endTime=endTime;
	    obj.schoolId=$("#schoolId").combobox('getValue');
	    params=JSON.stringify(obj);
    		$('#list_data').datagrid(
    		{
    		url : "/sys/pubData/qryDataListByPage.do",
    		queryParams:
    		{
    			param : params
    		},
    		onLoadSuccess:function(){
    			//一定要加上这一句，要不然datagrid会记住之前的选择状态，删除时会出问题。
    			$('#list_data').datagrid('clearSelections');
    		}
    	});
     });
 
    $("#createPlan").click(function()
    	{
    	 
    		window.location.href = "/sys/time/createPlan.jsp";
    	}
    );
    
      $("#updatePlan").click(function()
      {
    	 	var row = $('#list_data').datagrid('getSelected');
    	 	
    	 	if(row)
    	 	{
				flag = true;
			} else {
				$.messager.alert('提示', "请先选择排课月份！");
			}
    	 	
    	 	var createMonthId=row.createMonthId;
    	 	var month=row.month;
    	 	var schoolId=row.schoolId;
    		window.location.href = "/sys/time/updatePlan.jsp?flag=update&time="+month+"&createMonthId="+createMonthId+"&schoolId="+schoolId;
      }
    );
    
       $("#viewPlan").click(function()
      {
    	 	var row = $('#list_data').datagrid('getSelected');
    	 	
    	 	if(row)
    	 	{
				flag = true;
			} else {
				$.messager.alert('提示', "请先选择排课月份！");
			}
    	 	
    	 	var createMonthId=row.createMonthId;
    	 	var month=row.month;
    	 	var schoolId=row.schoolId;
    		window.location.href = "/sys/time/updatePlan.jsp?flag=view&time="+month+"&createMonthId="+createMonthId+"&schoolId="+schoolId;
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

</script>
