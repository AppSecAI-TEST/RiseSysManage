<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/applyClass/addApplyClass.js"></script>
  	</head>
  
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="放班申请">
  			<form id="applyClassFm">
  				<input type="hidden" id="courseType" name="courseType" value="001"/>
  				<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId}"/>
  				<input type="hidden" id="schoolId" name="schoolId" value="${sessionScope.StaffT.schoolId}"/>
  				<input type="hidden" id="classOrder" name="classOrder"/>
  				<input type="hidden" id="higherSchoolId" name="higherSchoolId"/>
  				<input type="hidden" id="higherSchoolName" name="higherSchoolName"/>
  				<table width="100%" cellpadding="5px" class="maintable" id="applyClassTd">
  					<tr>
  						<td align="right" width="12%"><span>课程阶段：</span></td>
  						<td width="10%">
  							<select name="stageId" id="stageId" class="easyui-combobox" required="true" style="width: 100px; height: 28px;">
        					</select>
  						</td>
  						<td align="right" width="12%"><span>班级类型：</span></td>
  						<td width="10%">
  							<select name="classType" id="classType" class="easyui-combobox" required="true" style="width: 100px; height: 28px;">
        					</select>
  						</td>
  						<td align="right" width="8%"><span>班级名称：</span></td>
  						<td colspan="3" width="48%">
  							<span id="classNameText"></span>
  							<input type="hidden" id="className" name="className"/>
  						</td>
  					</tr>
  					<tr>
  						<td align="right" width="12%"><span>开课时间：</span></td>
  						<td width="10%">
	  						<input name="startDate" id="startDate" type="text" class="easyui-datebox" required="true" style="width: 100px; height: 28px;" editable="false"/>
  						</td>
  						<td align="right" width="12%"><span>学员来源类型：</span></td>
  						<td width="10%">
  							<select name="studentChannelType" id="studentChannelType" class="easyui-combobox" required="true" style="width: 100px; height: 28px;">
        					</select>
  						</td>
  						<td align="right" width="8%"><span id="higherText" style="display: none;">升学班级：</span></td>
  						<td colspan="3" width="48%">
  							<div id="higherDiv" style="display: none;">
	  							<select id="higherOptionSchoolId" class="easyui-combobox" style="width: 100px; height: 28px;" editable="false">
		     					</select>
		     					<select id="higherOptionStageId" class="easyui-combobox" style="width: 100px; height: 28px;" editable="false" >
	        					</select>
	        					<select id="higherOptionClassInstId" class="easyui-combobox" style="width: 100px; height: 28px;" editable="false" >
	        					</select>
	        					<a href="javascript:void(0)" id="addHigherSchoolBtn" class="easyui-linkbutton" iconCls="icon-add" style="width: 80px; height: 28px;">添加</a>
  							</div>
  						</td>
  					</tr>
  					<tr style="display:none;" id="higherSchoolNameTr">
  						<td align="right" width="12%"><span id="higherText">升学班级名称：</span></td>
  						<td colspan="7" width="88%"></td>
  					</tr>
  					<tr style="display:none;" id="addHigherSchoolTr">
  						<td align="right" width="12%"><span>班级：</span></td>
  						<td width="10%"><span id="higherSchoolNameText"></span></td>
  						<td align="right" width="12%"><span>课程进度：</span></td>
  						<td width="10%"><span id="higherSchoolClassProgressText"></span></td>
  						<td align="right" width="8%"><span>在读人数：</span></td>
  						<td width="6%"><span id="higherSchoolClassNumText"></span></td>
  						<td align="right" width="10%"><span>已升学人数：</span></td>
  						<td width="32%"><span id="higherSchoolHigherNumText"></span><input type="hidden" name="higherSchools"/></td>
  					</tr>
  					<tr>
  						<td align="right" width="12%"><span>上课时段：</span></td>
  						<td colspan="3" width="32%">
  							<select id="weekTime" class="easyui-combobox" style="width: 100px; height: 28px;" editable="false" >
	        				</select>
	        				<select name="hourRange" id="hourRange" class="easyui-combobox" style="width: 150px; height: 28px;" editable="false" >
	        				</select>
  						</td>
  						<td align="right" width="8%"><span>教室：</span></td>
  						<td width="6%">
  							<select id="roomId" class="easyui-combobox" style="width: 80px; height: 28px;" editable="false" 
		      					data-options="formatter:formatRoom, valueField: 'roomId', textField: 'roomName', panelHeight: 'auto'" 
		      					url="<%=path %>/pubData/qryRoomList.do?schoolId=${sessionScope.StaffT.schoolId}">
	        				</select>
  						</td>
  						<td colspan="2" align="center" width="42%">
							<a href="javascript:void(0)" id="addHourRange" class="easyui-linkbutton" iconCls="icon-add" style="width: 120px; height: 28px;">添加上课时间</a>					
  							&nbsp;
  							<a href="javascript:void(0)" id="view" class="easyui-linkbutton" iconCls="icon-redo" style="width: 120px; height: 28px;">查看排期表</a>
  						</td>
  					</tr>
  					<tr style="display:none;" id="addSchootimeTr">
  						<td colspan="8">
  							<table width="100%" cellpadding="5px" id="schooltimeTb" class="maintable">
  								<tr>
  									<td align="center" width='4%'><span>序号</span></td>
  									<td align="center" width='14%'><span>上课时段</span></td>
  									<td align="center" width='4%'><span>教室</span></td>
  									<td align="center" width='4%'><span>课时</span></td>
  									<td align="center" width='54%'><span>带班老师</span></td>
  									<td align="center" width='20%'><span>操作</span></td>
  								</tr>
  								<tr id="addSchootimeTd" style="display:none;">
  									<td align="center" width='4%'></td>
  									<td align="center" width='14%'></td>
  									<td align="center" width='4%'></td>
  									<td align="center" width='4%'></td>
  									<td width='54%'></td>
  									<td align="center" width='20%'>
  										<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px; height: 28px;" onclick="addTeacher(this)">添加老师</a>
  										<a href='javascript:void(0)' class='easyui-linkbutton' iconCls='icon-remove' style='width: 100px; height: 28px;' onclick="deleteSchooltime(this)">删除</a></td></tr>
  									</td>
  								</tr>
  							</table>
  						</td>
  					</tr>
  					<tr>
	      				<td align="right" width="12%"><span>备注：</span></td>
	      				<td colspan="7" width="88%">
	      					<textarea rows="6" cols="122" id="remark" name="remark" class="easyui-validatebox textbox"></textarea>
	      				</td>
	      			</tr>
  				</table>
  			</form>
  		</div>
  		<div style="margin-top: 20px;min-width:1100px; width:99%;">
	      	<div style="float: left;margin-left: 800px;">
	      		<a href="javascript:void(0)" id="applyClassSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
	      		&nbsp;<a href="javascript:void(0)" id="activityBack" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
	      	</div>
	    </div>
	    <div id="dlg" class="easyui-dialog" style="width:500px;height: 300px;" closed="true" data-options="modal:true" buttons="#dlgBtn">
  			<form id="addTeacherFm" method="post">
  				<table width="96%" cellspacing="10px" style="margin-left: 2%; margin-top: 5%" class="maintable1">
  					<tr>
  						<td align="right" width="40%"><span>归属组织：</span></td>
  						<td width="60%">
  							<select id="teacherSchoolId" name="teacherSchoolId" class="easyui-combobox" style="width: 200px; height: 25px;" required="true">
		        			</select>
  						</td>
  					</tr>
  					<tr>
  						<td align="right" width="40%"><span>带班老师：</span></td>
  						<td width="60%">
  							<select id="teacherId" name="teacherId" class="easyui-combobox" style="width: 200px; height: 25px;" required="true" >
  							</select>
  						</td>
  					</tr>
  					<tr>
  						<td align="right" width="40%"><span>是否持证：</span></td>
  						<td width="60%">
  							<span id="licenseFlagText"></span>
  						</td>
  					</tr>
  					<tr>
  						<td align="right" width="40%"><span>课时：</span></td>
  						<td width="60%">
  							<input name="lessions" id="lessions" type="text" class="easyui-numberbox" required="true" style="width: 200px; height: 28px;"/>
  						</td>
  					</tr>
  				</table>
  			</form>
  		</div>
  		<div id="dlgBtn">
    		<a href="javascript:void(0)" id="addTeacherSubmit" class="easyui-linkbutton" iconCls="icon-ok">提交</a> 
    		<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">取消</a>
  		</div>
  	</body>
</html>
<script type="text/javascript" >
	$("#view").click(function() {
		var schoolId = $("#schoolId").val();
		parent.openUrl(10000 , '/sys/time/planRoom.jsp?schoolId='+schoolId , '排期表');
	});
</script>
