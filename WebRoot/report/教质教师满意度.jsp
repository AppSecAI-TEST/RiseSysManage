<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="/common/head.jsp" %>
		<%@ include file="/common/formvalidator.jsp" %>
  	</head>
  	<body>
  		<div style="margin-right:5px;">
  			<input type="hidden" id="resourceId" value="721">
  			<input type="hidden" id="staffId" value="${sessionScope.StaffT.staffId}"/>
  			<form id="qryFm">
	  			<table class="search_tab">
	  				<tr>
	  					<td width="100px" align="right"><span>校区：</span></td>
	  					<td width="130px" align="left">
	  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false"
								data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'">
				        	</select>
	  					</td>
	  					<td width="100px" align="right"><span>教师：</span></td>
	  					<td width="130px" align="left">
	  						<select class="easyui-combobox" name="teacherId" id="teacherId" style="width:100px;height:25px;" editable="false"
	  							data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname', panelHeight: 'auto'">
	  						</select>
	  					</td>
	  					<td align="right" width="120px;"><span>时间：</span></td>
	  					<td align="left">
	  						<input class="easyui-datebox"  type="text" style="width:120px; height: 25px;" id="month" name="month" editable="false" data-options="formatter:myformatter, parser:myparser"/>
	  					</td>
	  				</tr>
	  				<tr>
	  					<td align="right"><span>开班典礼满意度：</span></td>
	  					<td align="left">
	  						<input class="easyui-numberbox" name="min1" id="min1"  style="width:38px;height:25px;" data-options="min:0,max:99,precision:0" />%至
	  						<input class="easyui-numberbox" name="max1" id="max1"  style="width:38px;height:25px;" data-options="min:1,max:100,precision:0" />%
	  					</td>
	  					<td align="right"><span>家长会满意度：</span></td>
	  					<td align="left">
	  						<input class="easyui-numberbox" name="min2" id="min2"  style="width:38px;height:25px;" data-options="min:0,max:99,precision:0" />%至
	  						<input class="easyui-numberbox" name="max2" id="max2"  style="width:38px;height:25px;" data-options="min:1,max:100,precision:0" />%
	  					</td>
	  					<td align="right"><span>公开课满意度：</span></td>
	  					<td align="left">
	  						<input class="easyui-numberbox" name="min3" id="min3"  style="width:38px;height:25px;" data-options="min:0,max:99,precision:0" />%至
	  						<input class="easyui-numberbox" name="max3" id="max3"  style="width:38px;height:25px;" data-options="min:1,max:100,precision:0" />%
	  					</td>
	  					<td align="right"><span>毕业典礼满意度：</span></td>
	  					<td align="left">
	  						<input class="easyui-numberbox" name="min4" id="min4"  style="width:38px;height:25px;" data-options="min:0,max:99,precision:0" />%至
	  						<input class="easyui-numberbox" name="max4" id="max4"  style="width:38px;height:25px;" data-options="min:1,max:100,precision:0" />%
	  					</td>
	  					<td align="right"><span>综合满意度：</span></td>
	  					<td align="left">
	  						<input class="easyui-numberbox" name="min5" id="min5"  style="width:38px;height:25px;" data-options="min:0,max:99,precision:0" />%至
	  						<input class="easyui-numberbox" name="max5" id="max5"  style="width:38px;height:25px;" data-options="min:1,max:100,precision:0" />%
	  					</td>
	  				</tr>	
	  				<tr>		
	  					
	  					<td align="left" colspan="8">	
	  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:100px" id="qryBtn" funcNodeId ="60345"><span>查询</a>
	  						&nbsp;&nbsp;&nbsp;&nbsp;
	  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-redo" style="width:100px" id="resetBtn"><span>重置</a>
	  					</td>
	  				</tr>
	  			</table>
  			</form>
				<table class="easyui-datagrid" style="height:450px;" id="list_data"
					title="查询结果" toolbar="#toolbar" pagination="false" rownumbers="true" fitColumns="true">
					<thead>
						<tr>
							<th field="schoolName" align="center" width="6%"  >校区</th>
							<th field="byname" align="center" width="6%"  >教师中文名称</th>
							<th field="teacherName" align="center" width="5%" >教师</th>
							<th field="strativeCsiVal" align="center" width="10%" >开班典礼满意度</th>
							<th field="meetingCsiVal" align="center" width="10%" >家长会满意度</th>
							<th field="openCsiVal" align="center" width="10%" >公开课满意度</th>
							<th field="gradCsiVal" align="center" width="10%" >毕业典礼满意度</th>  
							<th field="csiPerVal" align="center" width="6%"  >综合满意度</th>
						</tr>
					 
					</thead>
				</table>
			<div id="toolbar" style="padding: 2px; height: auto">
	   			<a href="javascript:void(0)" id="export" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">导出全部</a>
			</div>
  		</div>
  	</body>
</html>
<script>

$(document).ready(function(){
	 $('#month').datebox({
            onShowPanel: function () {//显示日趋选择对象后再触发弹出月份层的事件，初始化时没有生成月份层
        		var p = $('#month').datebox('panel'), //日期选择对象
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
                    $('#month').datebox('setValue',val).datebox('hidePanel'); //设置日期的值
             	});
            }
    	});
	 	initReportButton("resetBtn","qryFm","schoolId")
	 	$("#qryBtn").click(function() {
		var object = $("#qryFm").serializeObject();
		 
		if(object.month=='')
		{
			$.messager.alert('提示', "请选择时间");
			return;
		}
    	var obj = JSON.stringify(object);
    	obj = obj.substring(0, obj.length - 1);
    	var funcNodeId = $("#qryBtn").attr("funcNodeId");
    	obj += ",\"funcNodeId\":\""+funcNodeId+"\"}";
    	$('#list_data').datagrid({
    		url : "/sys/pubData/qryDataListByPage.do",
    		queryParams:{
    			param : obj
    		}
    	});
    });
	 	$("#schoolId").combobox({
	 		onChange:function(){
	 		 
	 			$("#teacherId").combobox({
					url : "/sys/pubData/getTeacherBySchoolId.do?schoolId="+$("#schoolId").combobox('getValue')
				});
	 		}
	 	});
	 	$("#stageId").combobox({
	 		onChange:function(){
	 			$("#classInstId").combobox({
					url:"/sys/pubData/qryClassInstList.do?schoolId="+$("#schoolId").combobox('getValue')+"&stageId="+$("#stageId").combobox('getValue')
				});
	 		}
	 	});
	 	exportLink("export","list_data");
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