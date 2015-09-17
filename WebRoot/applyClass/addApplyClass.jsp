<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/applyClass.js"></script>
  	</head>
  
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="放班申请">
  			<form id="applyClassFm">
  				<input type="hidden" id="courseType" name="courseType" value="001"/>
  				<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId}"/>
  				<input type="hidden" id="schoolId" name="schoolId" value="${sessionScope.StaffT.schoolId}"/>
  				<table width="100%" cellpadding="5px" class="maintable" id="applyClassTd">
  					<tr>
  						<td align="right"><span>课程阶段：</span></td>
  						<td>
  							<select name="stageId" id="stageId" class="easyui-combobox" style="width: 100px; height: 28px;"
	      					 data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
	      					 onLoadSuccess:function(data){$('#stageId').combobox('setValue',data[0].codeFlag);}" 
	      					 url="<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_COURSE_T&codeType=STAGE_ID">
        					</select>
  						</td>
  						<td align="right"><span>班级类型：</span></td>
  						<td>
  							<select name="classType" id="classType" class="easyui-combobox" style="width: 100px; height: 28px;"
	      					 data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
	      					 onLoadSuccess:function(data){$('#classType').combobox('setValue',data[0].codeFlag);}" 
	      					 url="<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_COURSE_T&codeType=CLASS_TYPE">
        					</select>
  						</td>
  						<td align="right"><span>班级名称：</span></td>
  						<td colspan="3">
  							<span id="classNameText"></span>
  							<input type="hidden" id="className" name="className"/>
  						</td>
  					</tr>
  					<tr>
  						<td align="right"><span>开课时间：</span></td>
  						<td>
	  						<input name="effectDate" id="effectDate" type="text" class="easyui-datebox" required="true" style="width: 100px; height: 28px;"/>
  						</td>
  						<td align="right"><span>学员来源类型：</span></td>
  						<td>
  							<select name="studentChannelType" id="studentChannelType" class="easyui-combobox" style="width: 100px; height: 28px;"
	      					 data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
	      					 onLoadSuccess:function(data){$('#studentChannelType').combobox('setValue',data[0].codeFlag);}" 
	      					 url="<%=path %>/pubData/qryCodeNameList.do?tableName=CLASS_INST_T&codeType=STUDENT_CHANNEL_TYPE">
        					</select>
  						</td>
  						<td align="right"><span id="higherText" style="display: none;">升学班级：</span></td>
  						<td colspan="3">
  							<div id="higherDiv" style="display: none;">
	  							<select id="higherOptionSchoolId" name="higherOptionSchoolId" class="easyui-combobox" style="width: 100px; height: 28px;" editable="false" 
								data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto', 
								onLoadSuccess:function(data){$('#higherOptionSchoolId').combobox('setValue',data[0].schoolId);}"	
								url="<%=path %>/pubData/qrySchoolList.do?schoolId=">
		     					</select>
		     					<select name="higherOptionStageId" id="higherOptionStageId" class="easyui-combobox" style="width: 100px; height: 28px;"
		      					 data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
		      					 onLoadSuccess:function(data){$('#higherOptionStageId').combobox('setValue',data[0].codeFlag);}" 
		      					 url="<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_COURSE_T&codeType=STAGE_ID">
	        					</select>
	        					<select name="higherOptionClassInstId" id="higherOptionClassInstId" class="easyui-combobox" style="width: 100px; height: 28px;">
	        						<option value="1001">Pre-K01</option>
	        						<option value="1002">K01</option>
	        						<option value="1003">PreRise</option>
	        						<option value="1004">S101</option>
	        						<option value="1005">S201</option>
	        						<option value="1006">S301</option>
	        					</select>
	        					<a href="javascript:void(0)" id="addHigherClass" class="easyui-linkbutton" iconCls="icon-add" style="width: 80px; height: 28px;">添加</a>
  							</div>
  						</td>
  					</tr>
  					<tr>
  						<td colspan="8">
  							<span id="higherOptionSchoolName"></span>
  						</td>
  					</tr>
  					<tr>
  						
  						<td align="right"><span>班级：</span></td>
  						<td><span id="higherSchoolNameText"></span></td>
  						<td align="right"><span>课程进度：</span></td>
  						<td><span id="higherSchoolClassProgressText"></span></td>
  						<td align="right"><span>在读人数：</span></td>
  						<td><span id="higherSchoolClassNumText"></span></td>
  						<td align="right"><span>已升学人数：</span></td>
  						<td><span id="higherSchoolHigherNumText"></span></td>
  					</tr>
  					<tr>
  						<td align="right"><span>上课时段：</span></td>
  						<td colspan="3">
  							<select name="weekTime" id="weekTime" class="easyui-combobox" style="width: 100px; height: 28px;"
		      				data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
		      				onLoadSuccess:function(data){$('#weekTime').combobox('setValue',data[0].codeFlag);}" 
		      				url="<%=path %>/pubData/qryCodeNameList.do?tableName=SCHOOLTIME_T&codeType=WEEK_TIME">
	        				</select>
	        				<select name="hourRange" id="hourRange" class="easyui-combobox" style="width: 150px; height: 28px;">
	        				</select>
  						</td>
  						<td align="right"><span>教室：</span></td>
  						<td>
  							<select name="roomId" id="roomId" class="easyui-combobox" style="width: 100px; height: 28px;"
		      				data-options="formatter:formatItem, valueField: 'roomId', textField: 'roomName', panelHeight: 'auto',
		      				onLoadSuccess:function(data){$('#roomId').combobox('setValue',data[0].roomId);}" 
		      				url="<%=path %>/pubData/qryRoomList.do?schoolId=${sessionScope.StaffT.schoolId}">
	        				</select>
  						</td>
  						<td colspan="2" align="center">
							<a href="javascript:void(0)" id="addHourRange" class="easyui-linkbutton" iconCls="icon-add" style="width: 120px; height: 28px;">添加上课时间</a>					
  							&nbsp;
  							<a href="javascript:void(0)" id="view" class="easyui-linkbutton" iconCls="icon-redo" style="width: 120px; height: 28px;">查看排期表</a>
  						</td>
  					</tr>
  					<tr>
  						<td align="right"><span>上课时段：</span></td>
  						<td>
  							<span id="hourRangeText"></span>
  						</td>
	  					<td align="right"><span>教室：</span></td>
	  					<td>
	  						<span id="RoomText"></span>
	  					</td>
	  					<td align="right"><span>课时：</span></td>
	  					<td>
	  						<span id="lessionHoursText"></span>
	  					</td>
	  					<td align="right"><span>带班老师：</span></td>
	  					<td>
	  						<select id="teacherSchoolId" name="teacherSchoolId" class="easyui-combobox" style="width: 100px; height: 28px;" editable="false" 
							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto', 
							onLoadSuccess:function(data){$('#teacherSchoolId').combobox('setValue',data[0].schoolId);}"	
							url="<%=path %>/pubData/qrySchoolList.do?schoolId=">
		     				</select>
		     				<select id="teacherId" name="teacherId" class="easyui-combobox" style="width: 100px; height: 28px;">
		     				</select>
		     				<a href="javascript:void(0)" id="addTeacher" class="easyui-linkbutton" iconCls="icon-add" style="width: 120px; height: 28px;">添加代班老师</a>
	  					</td>
  					</tr>
  					<tr>
	      				<td align="right"><span>备注：</span></td>
	      				<td colspan="7">
	      					<input id="remark" name="remark" type="text" class="easyui-textbox" style="width: 969px; height: 28px;"/>
	      				</td>
	      			</tr>
  				</table>
  			</form>
  		</div>
  	</body>
</html>
