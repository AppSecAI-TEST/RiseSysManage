<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/pub/js/json.js"></script>
		<script type="text/javascript" src="<%=path %>/pub/js/json2.js"></script>
		<script type="text/javascript" src="<%=path %>/js/teaFeebackManage/teaFeebackManage.js"></script>
  	</head>
  	<body>
 		<form id="qryFm">
  			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;margin-top:10px;font-family:'微软雅黑'" cellspacing="5">
  				<tr>
  					<td align="right" width="7%">校区：</td>
  					<td align="left" width="9%">
  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width: 120px">
			        	</select>
  					</td>
  					<td align="right" width="9%">课程阶段：</td>
  					<td align="left" width="9%">
  						<select name="stageId"  id="stageId"  style="width:120px" class="easyui-combobox" editable='false'
     						data-options="formatter:formatStageId, valueField: 'stageId', textField: 'stageId', panelHeight: 'auto'"
     						url="<%=path %>/pubData/qryStage.do">
	      				</select>
  					</td>
  					<td align="right" width="9%">班级：</td>
  					<td align="left" width="9%">
						<select id="classInstId" name="classInstId" class="easyui-combobox" style="width: 120px" disabled="disabled">
			        	</select>
					</td>
  					</td>
  					<td align="right" width="9%">开课时间：</td>
  					<td align="left" width="9%">
  						<input class="easyui-datebox" name="startTime" id="startTime" style="width:120px;" />
  					</td>
  					<td align="center" width="3%">至：</td>
  					<td align="left" width="15%">
  						<input class="easyui-datebox" name="endTime" id="endTime" style="width:120px;" />
  					</td>
  					<td></td>
  				</tr>
  				<tr>
  					<td align="right">带班老师：</td>
  					<td align="left">
  						<select id="teacherId" name="teacherId" class="easyui-combobox" style="width: 120px"
							data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname', panelHeight: 'auto'" 
		      				url="<%=path %>/pubData/qryData.do?param={'queryCode':'qryClassTeacherInfo'}">
				        </select>
  					</td>
  					<td align="right">是否反馈：</td>
  					<td align="left">
  						<input name="feedback" type="checkbox" value="Y" style="margin:0 auto;vertical-align:middle;" /><span>是</span>
  						&nbsp;&nbsp;&nbsp;<input name="feedback" type="checkbox" value="N" style="margin:0 auto;vertical-align:middle;" /><span>否</span>
  					</td>
  					<td align="right" width="10%"><span>教质月份：</span></td>
					<td align="left" width="10%">
						<input class="easyui-datebox" type="text" style="width:120px" id="time" editable="false" data-options="formatter:myformatter, parser:myparser"/>
					</td>
  					<td align="right">班级状态：</td>
  					<td align="left">
  						<select id="classState" name="classState" class="easyui-combobox" style="width:120px;"
	  						data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'"
	      					url="<%=path %>/pubData/qryCodeNameList.do?tableName=CLASS_INST_T&codeType=CLASS_STATE&codeFlag=003,004">
        				</select>
  					</td>
  					<td colspan="3" align="center">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:90px; height: 25px;" id="qryBtn" funcNodeId="4500">查询</a>
						&nbsp;&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:90px; height: 25px;" id="reset" >重置</a>
					</td>
  				</tr>
  			</table>
 		</form>
 		
		<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:570" id="list_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
			<thead>
				<tr>
					<th field="ck" align="center" checkbox="true" width="1%"></th>
					<th field="schoolName" align="center" width="10%">校区</th>
					<th field="className" align="center" width="10%">班级名称</th>
					<th field="openDate" align="center" width="10%">开课时间</th>
					<th field="teacherName" align="center" width="10%">带班老师</th>
					<th field="reflect" align="center" width="9%">是否反馈</th>
					<th field="createDate" align="center" width="10%">反馈时间</th>
					<th field="teachingDate" align="center" width="10%">电教时间</th>
					<th field="meetingDate" align="center" width="10%">家长会时间</th>
					<th field="openClassDate" align="center" width="10%">公开课时间</th>
					<th field="gradDate" align="center" width="10%">毕业典礼时间</th>
				</tr>
			</thead>
		</table>
		<div id="toolbar">
   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" onclick="addTeaFeedBack()">反馈维护</a>
 			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-redo" onclick="viewTeaFeedBack()">浏览</a>
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
