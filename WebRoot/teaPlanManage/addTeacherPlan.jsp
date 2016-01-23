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
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="教质计划创建">
  		<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  			<table width="98%" style="border:1px solid #ccc;font-family:'微软雅黑';margin-top:5px;height:30px;" align="center" cellspacing="2">
  				<tr>
					<td align="right" width="10%"><span>教质月份：</span></td>
					<td align="left" width="10%">
						<input class="easyui-datebox" type="text" style="width:120px" id="time" name="startTime" editable="false" data-options="formatter:myformatter, parser:myparser"/>
					</td>
  					<td align="right" width="8%"><span>校区：</span></td>
	  				<td align="left" width="10%">
						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width:120px" editable="false">
		        		</select>
					</td>
					<td align="center" width="60%"></td>
  				</tr>
  			</table>
  			<table id="planTab" width="98%" cellpadding="2px" style="margin-top:5px;margin-bottom: 5px;border:1px solid #ccc;" align="center" class="maintable">
	      	   <tr id="planTr">
	      	   	 <td align="center" width="3%"><span>序号</span></td>
	      	   	 <td align="center" width="9%"><span>班级</span></td>
	      	   	 <td align="center" width="12%"><span>电教</span></td>
	      	   	 <td align="center" width="12%"><span>家长会</span></td>
	      	   	 <td align="center" width="12%"><span>公开课</span></td>
	      	   	 <td align="center" width="12%"><span>毕业典礼</span></td>
	      	   	 <td align="center" width="15%"><span>是否开教质事件</span></td>
	      	   	 <td align="center" width="25%"><span>说明</span></td>
     	       </tr>
      	    </table>
  		</div>
 		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="text-align:center">
	      		<a href="javascript:void(0)" id="addPlanSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width:100px;" onclick="addPlanSubmit()"><span>提交</span></a>
	      		&nbsp;
	      		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:100px;" onclick="javascript:window.history.back()"><span>返回</span></a>
	      	</div>
	   </div>
  	</body>
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
	                    createPlan($('#schoolId').combobox('getValue'),$('#time').datebox("getValue"));
	             	});
	            }
	            //formatter: function (d) { return d.getFullYear() + '-' + d.getMonth(); }//配置formatter，只返回年月
	    	});
	    	$('#time').datebox('setValue',new Date().format("yyyy-MM"));
	    	$('#schoolId').combobox({//联动信息带出
				url:"/sys/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&resourceId=511&fieldId=schoolId&headFlag=N",
				formatter:formatSchool, 
				valueField: 'schoolId', 
				textField: 'schoolName', 
				panelHeight: 'auto',
				onLoadSuccess:function(data){
					$('#schoolId').combobox('setValue',data[0].schoolId);
				},
			 	onChange:function(n,o)
				{
					createPlan(n,$('#time').datebox('getValue'));
				}
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
        
	</script>
</html>
