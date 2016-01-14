<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/teaPlanManage/teaPlanManage.js"></script>
  	</head>
  	<body>
  		<div style="margin-right:5px">
 		<form id="qryFm">
  			<table class="search_tab">
  				<tr>
					<td align="right" width="8%"><span>所属校区：</span></td>
	  				<td align="left" width="8%">
						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width:100px;height:25px;" editable="false"
							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto',
				      		onLoadSuccess:function(data){$('#schoolId').combobox('setValue',data[0].schoolId);}"
				      		url="<%=path %>/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&resourceId=510&fieldId=schoolId&headFlag=N">
		        		</select>
					</td>
					<td align="right" width="10%"><span>计划月份：</span></td>
					<td align="left" width="8%">
						<input class="easyui-datebox" type="text" style="width:100px;height:25px;" id="startTime" name="startTime" editable="false" data-options="formatter:myformatter, parser:myparser"/>
					</td>
					<td align="center" width="2%"><span>至</span></td>
					<td align="left" width="15%">
						<input class="easyui-datebox" type="text" style="width:100px;height:25px;" id="endTime" name="endTime" editable="false" data-options="formatter:myformatter, parser:myparser"/>
					</td>
					<td align="left" width="44%">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px;" id="qryBtn" funcNodeId="4400">查询</a>
						&nbsp;&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px;" id="reset" >重置</a>
					</td>
					<td></td>
				</tr>
  			</table>
 		</form>
 		
		<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:580" id="list_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
			<thead>
				<tr>
					<th field="ck" align="center" checkbox="true" width="1%"></th>
					<th field="schoolName" align="center" width="20%"><span>校区</span></th>
					<th field="month" align="center" width="20%"><span>教质月份</span></th>
					<th field="createDate" align="center" width="30%"><span>创建时间</span></th>
					<th field="handlerName" align="center" width="29%"><span>创建人</span></th>
				</tr>
			</thead>
		</table>
		<div id="toolbar" style="padding: 2px;height:auto;">
   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" style="width:100px;" onclick="addPlan()"><span>创建</span></a>
   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" style="width:100px;" onclick="updatePlan()"><span>修改</span></a>
 			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-redo" style="width:100px;" onclick="viewPlan()"><span>浏览</span></a>
 		</div>
 		</div>
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
  	</body>
</html>
