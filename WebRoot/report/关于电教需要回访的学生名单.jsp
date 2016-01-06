<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
 	<head>
		<%@ include file="/common/head.jsp" %>
		<%@ include file="/common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/export/teachingFeedback.js"></script>
  	</head>
  	<body>
 		<form id="qryFm" style="margin:0 auto;">
 			<input type="hidden" id="staffId" name="staffId" value="${sessionScope.StaffT.staffId}"/>
			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;margin-top:10px;font-family:'微软雅黑'" cellspacing="5">
				<tr>
					<td width="10%" align="right"><span>校区：</span></td>
					<td width="10%" align="left">
						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 120px">
			        	</select>
					</td>
					<td width="10%" align="right"><span>学员姓名：</span></td>
					<td width="10%" align="left">
					 <select id="studentId" name="studentId" style="width:120px" class="easyui-combobox">
    				</select>
					</td>
					<td width="10%" align="right">
						<span>带班老师：</span>
					</td>
					<td width="10%" align="left">
						<select id="teacherId" name="teacherId" class="easyui-combobox" style="width: 120px"
							data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname', panelHeight: 'auto'" 
		      				url="<%=path %>/pubData/qryData.do?param={'queryCode':'qryClassTeacherInfo'}">
				        </select>
					</td>
					<td width="10%" align="right"><span>教质月份：</span></td>
					<td align="left" width="10%">
						<input class="easyui-datebox" type="text" style="width:120px" id="time" editable="false" data-options="formatter:myformatter, parser:myparser"/>
					</td>
					<td></td>
				</tr>
				<tr>
					<td width="10%" align="right"><span>班级：</span></td>
					<td width="10%" align="left">
						<select id="classInstId" name="classInstId" class="easyui-combobox" style="width: 120px" disabled="disabled">
			        	</select>
					</td>
					<td width="10%" align="right"><span>联系电话：</span></td>
							<td width="10%" align="left">
						 <input name="phone" class="easyui-numberbox" style="width:120px"/>
					</td>
					<td width="10%" align="right"><span>电教次数：</span></td>
					<td colspan="2" align="left" width="10%">
						<input name="teachingNum" type="checkbox" value="0" style="margin:0 auto;vertical-align:middle;" /><span>0次</span>
						&nbsp;&nbsp;&nbsp;<input name="teachingNum" type="checkbox" value="1" style="margin:0 auto;vertical-align:middle;" /><span>1次</span>
						&nbsp;&nbsp;&nbsp;<input name="teachingNum" type="checkbox" value="2" style="margin:0 auto;vertical-align:middle;" /><span>2次</span>
					</td>
					<td colspan="2"></td>
						</tr>
						<tr>
					<td width="10%" align="right"><span>家长会：</span></td>
					<td width="10%" align="left">
						<input name="meetingIsAttend" type="checkbox" value="Y" style="margin:0 auto;vertical-align:middle;" /><span>已到</span>
						&nbsp;&nbsp;&nbsp;<input name="meetingIsAttend" type="checkbox" value="N" style="margin:0 auto;vertical-align:middle;" /><span>未到</span>
					</td>
					<td width="10%" align="right"><span>公开课：</span></td>
					<td width="10%" align="left">
						<input name="openIsAttend" type="checkbox" value="Y" style="margin:0 auto;vertical-align:middle;" /><span>已到</span>
						&nbsp;&nbsp;&nbsp;<input name="openIsAttend" type="checkbox" value="N" style="margin:0 auto;vertical-align:middle;" /><span>未到</span>
					</td>
					<td width="10%" align="right"><span>毕业典礼：</span></td>
					<td align="left" width="10%">
						<input name="gradIsAttend" type="checkbox" value="Y" style="margin:0 auto;vertical-align:middle;" /><span>已到</span>
						&nbsp;&nbsp;&nbsp;<input name="gradIsAttend" type="checkbox" value="N" style="margin:0 auto;vertical-align:middle;" /><span>未到</span>
					</td>
					<td colspan="2" align="right">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:90px; height: 25px;" id="qryBtn" funcNodeId="4610">查询</a>
						&nbsp;&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:90px; height: 25px;" id="reset" >重置</a
					</td>
					<td></td>
				</tr>
			</table>
		</form>
		<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:540" id="list_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="false">
			<thead>
				<tr>
					<th field="schoolName" align="center" width="12%">校区</th>
					<th field="teachingEvent" align="center" width="12%" >教质事件</th>
					<th field="dataType" align="center" width="12%" >数据类型</th>
					<th field="studentName" align="center" width="12%" >学员姓名</th>
					<th field="byname" align="center" width="12%" >英文名</th>
					<th field="className" align="center" width="12%" >班级</th>
					<th field="phone" align="center" width="14%" >联系电话</th>
					<th field="teacherName" align="center" width="14%" >带班老师</th>
				</tr>
			</thead>
		</table>
		<div id="toolbar">
   			<a href="javascript:void(0)" id="export" class="easyui-linkbutton" iconCls="icon-add" >导出</a>
 		</div>
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
  	</body>
</html>
