<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<link rel="stylesheet" type="text/css" href="<%=path %>/pub/js/easyui/themes/default/easyui.css">
		<link rel="stylesheet" type="text/css" href="<%=path %>/pub/js/easyui/themes/icon.css">
		<link rel="stylesheet" type="text/css" href="<%=path %>/pub/js/demo.css">
		<script type="text/javascript" src="<%=path %>/pub/js/jquery.min.js"></script>
		<script type="text/javascript" src="<%=path %>/pub/js/easyui/jquery.easyui.min.js"></script>
		<script type="text/javascript" src="<%=path %>/pub/js/json.js"></script>
		<script type="text/javascript" src="<%=path %>/pub/js/json2.js"></script>
		<script type="text/javascript" src="<%=path %>/js/applyClass.js"></script>
  	</head>
  
  	<body>
  		<div style="padding:5px 0;">
  			<form id="qryFm">
	  			<table>
	  				<tr>
	  					<td>学校：</td>
	  					<td>
	  						<select class="easyui-combobox" name="schoolId" id="schoolId" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  					<td>教室：</td>
	  					<td>
	  						<select class="easyui-combobox" name="roomId" id="roomId" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  					<td>教师：</td>
	  					<td>
	  						<select class="easyui-combobox" name="teacherId" id="teacherId" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  					<td>时间段：</td>
	  					<td>
	  						<input class="easyui-timespinner" value="00:00" id="startTimeId" name="startTimeId" style="width:150px;">
	  					</td>
	  					<td>至</td>
	  					<td>
	  						<input class="easyui-timespinner" value="23:00" id="endTimeId" name="endTimeId" style="width:150px;">
	  					</td>
	  				</tr>
	  				<tr>
	  					<td>申请状态：</td>
	  					<td>
	  						<select class="easyui-combobox" name="applyState" id="applyState" style="width:150px;">
	  							
	  						</select>
	  					</td>
	  					<td>班级名称：</td>
	  					<td>
	  						<input class="easyui-textbox" style="width: 150px;" name="className" id="className">
	  					</td>
	  					<td>计划开班时间：</td>
	  					<td>
	  						<input class="easyui-datebox" data-options="sharedCalendar:'#cc'" style="width:150px;" id="startPlanDate" name="startPlanDate">
	  					</td>
	  					<td>至</td>
	  					<td>
	  						<input class="easyui-datebox" data-options="sharedCalendar:'#cc'" style="width:150px;" id="endPlanDate" name="endPlanDate">
	  					</td>
	  					<td colspan="2" style="text-align: right;">
	  						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:150px" id="qryBtn">查询</a>
	  					</td>
	  				</tr>
	  			</table>
  			</form>
  			<div id="cc" class="easyui-calendar"></div>
  			
  			<div id="tb" style="padding: 2px 15px; height: auto">
    			<a href="javascript:void(0)" id="addApply" class="easyui-linkbutton" iconCls="icon-add" plain="true">申请放班</a>
    			<a href="javascript:void(0)" id="updateApply" class="easyui-linkbutton" iconCls="icon-edit" plain="true">修改放班</a>
    			<a href="javascript:void(0)" id="deleteApply" class="easyui-linkbutton" iconCls="icon-remove" plain="true">取消放班</a>
  			</div>
  			
			<div style="padding:5px 0;">
				<table class="easyui-datagrid" title="查询结果" style="width:100%;height:250px" id="list_data">
					<thead>
						<tr>
							<th data-options="field:'schoolId',width:80,align:'center'">学校</th>
							<th data-options="field:'roomId',width:100,align:'center'">教室</th>
							<th data-options="field:'timeId',width:120,align:'center'">时间段</th>
							<th data-options="field:'teacherId',width:100,align:'center'">教师</th>
							<th data-options="field:'applyNameId',width:100,align:'center'">申请人</th>
							<th data-options="field:'applyState',width:80,align:'center'">申请状态</th>
							<th data-options="field:'applyDate',width:150,align:'center'">申请日期</th>
							<th data-options="field:'className',width:100,align:'center'">班级名称</th>
							<th data-options="field:'planDate',width:150,align:'center'">计划开班时间</th>
						</tr>
					</thead>
				</table>
			</div>
  		</div>
  		<div id="dlg" class="easyui-dialog" style="width: 580px; height: 350px; padding: 10px 20px" closed="true" data-options="modal:true" buttons="#dlgBtn">
  			<form id="fm" method="post">
  				<table style="width: 100%;" cellSpacing='0' cellPadding='5px'>
  					<tr>
  						<td style="text-align: right;width: 40%">学校：</td>
  						<td>
	  						<select class="easyui-combobox" style="width: 155px;" name="schoolId" id="schoolId" data-options="panelHeight:'auto'">
	  						</select>
  						</td>
  					</tr>
  					<tr>
  						<td style="text-align: right;width: 40%">教室：</td>
  						<td>
	  						<select class="easyui-combobox" style="width: 155px;" name="roomId" id="roomId" data-options="panelHeight:'auto'">
  							</select>
  						</td>
  					</tr>
  					<tr>
  						<td style="text-align: right;width: 40%">时间段：</td>
  						<td>
	  						<input class="easyui-timespinner" value="00:00" id="startTimeId" name="startTimeId" style="width:70px;">--<input class="easyui-timespinner" value="23:00" id="endTimeId" name="endTimeId" style="width:70px;">
  						</td>
  					</tr>
  					<tr>
  						<td style="text-align: right;width: 40%">教师：</td>
  						<td>
	  						<select class="easyui-combobox" style="width: 155px;" name="teacherId" id="teacherId" data-options="panelHeight:'auto'">
  							</select>
  						</td>
  					</tr>
  					<tr>
  						<td style="text-align: right;width: 40%">班级名称：</td>
  						<td>
	  						<input class="easyui-textbox" style="width: 155px;" id="className" name="className">
  						</td>
  					</tr>
  					<tr>
  						<td style="text-align: right;width: 40%">计划开班时间：</td>
  						<td>
	  						<input class="easyui-datebox" data-options="sharedCalendar:'#cc'" style="width:155px;" id="planDate" name="planDate">
  						</td>
  					</tr>
  				</table>
  			</form>
  		</div>
  		<div id="dlgBtn">
    		<a href="javascript:void(0)" id="submit" class="easyui-linkbutton" iconCls="icon-ok">确认</a> 
    		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
  		</div>
  	</body>
</html>
