<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
 	<head>
		<%@ include file="/common/head.jsp" %>
		<%@ include file="/common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/export/teachingFeedback.js"></script>
  	</head>
  	<body>
  		<div style="margin-right:5px">
 		<input type="hidden" id="staffId" name="staffId" value="${sessionScope.StaffT.staffId}"/>
 		<input type="hidden" id="resourceId" value="514">
 		<form id="qryFm">
			<table class="search_tab">
				<tr>
					<td width="8%" align="right"><span>校区：</span></td>
					<td width="10%" align="left">
						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width:100px;height: 25px;" editable="false">
			        	</select>
					</td>
					<td width="10%" align="right"><span>学员姓名：</span></td>
					<td width="10%" align="left">
						<input class="easyui-textbox" name="studentName" id="studentName" style="width:100px;height:25px;" />
					</td>
					<td width="10%" align="right">
						<span>带班老师：</span>
					</td>
					<td width="10%" align="left">
						<select id="teacherId" name="teacherId" class="easyui-combobox" style="width:100px;height: 25px;">
				        </select>
					</td>
					<td width="10%" align="right"><span>教质月份：</span></td>
					<td align="left" width="15%">
						<input class="easyui-datebox" type="text" style="width:100px;height: 25px;" id="time" editable="false" data-options="formatter:myformatter, parser:myparser"/>
					</td>
					<td></td>
				</tr>
				<tr>
					<td width="8%" align="right"><span>班级：</span></td>
					<td width="10%" align="left">
						<input id="className" name="className" class="easyui-textbox" style="width:100px;height:25px;" />
					</td>
					<td width="10%" align="right"><span>联系电话：</span></td>
					<td width="10%" align="left">
						 <input name="phone" class="easyui-numberbox" style="width:100px;height: 25px;"/>
					</td>
					<td width="10%" align="right"><span>电教次数：</span></td>
					<td  align="left" width="10%">
						<select id="teachingNum" name="teachingNum" class="easyui-combobox" style="width:100px;height: 25px;"
							data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'"
	      					url="<%=path %>/pubData/qryCodeNameList.do?tableName=TEACHING_FEEDBACK_DETAIL_T&codeType=TEACHING_NUM">
				        </select>
					</td>
					<td colspan="3"></td>
				</tr>
				<tr>
					<td width="8%" align="right"><span>家长会：</span></td>
					<td width="10%" align="left">
						<input name="meetingIsAttend" class="meetingIsAttend" type="checkbox" value="Y" style="margin:0 auto;vertical-align:middle;" /><span>已到</span>
						&nbsp;&nbsp;&nbsp;<input class="meetingIsAttend" name="meetingIsAttend" type="checkbox" value="N" style="margin:0 auto;vertical-align:middle;" /><span>未到</span>
					</td>
					<td width="10%" align="right"><span>公开课：</span></td>
					<td width="10%" align="left">
						<input name="openIsAttend" class="openIsAttend" type="checkbox" value="Y" style="margin:0 auto;vertical-align:middle;" /><span>已到</span>
						&nbsp;&nbsp;&nbsp;<input name="openIsAttend" class="openIsAttend" type="checkbox" value="N" style="margin:0 auto;vertical-align:middle;" /><span>未到</span>
					</td>
					<td width="10%" align="right"><span>毕业典礼：</span></td>
					<td align="left" width="10%">
						<input name="gradIsAttend" class="gradIsAttend" type="checkbox" value="Y" style="margin:0 auto;vertical-align:middle;" /><span>已到</span>
						&nbsp;&nbsp;&nbsp;<input name="gradIsAttend" class="gradIsAttend" type="checkbox" value="N" style="margin:0 auto;vertical-align:middle;" /><span>未到</span>
					</td>
					<td colspan="2" align="center">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px;" id="qryBtn" funcNodeId="4610"><span>查询</span></a>
						&nbsp;&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px;" id="resetBtn" ><span>重置</span></a>
					</td>
					<td></td>
				</tr>
			</table>
		</form>
		<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:500" id="list_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="false">
			<thead>
				<tr>
					<th field="schoolName" align="center" width="12%"><span>校区</span></th>
					<th field="teachingEvent" align="center" width="12%" ><span>教质事件</span></th>
					<th field="dataType" align="center" width="12%" ><span>数据类型</span></th>
					<th field="studentName" align="center" width="12%" ><span>学员姓名</span></th>
					<th field="byname" align="center" width="12%" ><span>英文名</span></th>
					<th field="className" align="center" width="12%" ><span>班级</span></th>
					<th field="phone" align="center" width="14%" ><span>联系电话</span></th>
					<th field="teacherName" align="center" width="14%" ><span>带班老师</span></th>
				</tr>
			</thead>
		</table>
		<div id="toolbar">
   			<a href="javascript:void(0)" id="export" class="easyui-linkbutton" style="width:100px;" iconCls="icon-add" ><span>导出全部</span></a>
 		</div>
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
			$('#time').datebox('setValue',new Date().format("yyyy-MM"));
			$(".meetingIsAttend").click(function() {
				$(".meetingIsAttend").removeAttr("checked");
				$(this).prop("checked", "checked");
			});
			$(".openIsAttend").click(function() {
				$(".openIsAttend").removeAttr("checked");
				$(this).prop("checked", "checked");
			});
			$(".gradIsAttend").click(function() {
				$(".gradIsAttend").removeAttr("checked");
				$(this).prop("checked", "checked");
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
