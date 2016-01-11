<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/action/addAction.js"></script>
	</head>
	<body>
		<div id ="baseInfo" class="easyui-panel" title="基本信息" style="width:1100px;">
		<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
  			<table width="100%;" class="maintable">
  				<tr>
  					<td width="15%" align="right"><span>校区：</span></td>
  					<td align="left" colspan="2">
  						<select class="easyui-combobox" name="actionSchoolId" id="actionSchoolId" style="width:150px;height: 25px;" editable="false"
  							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'"
  							url="<%=path%>/pubData/qrySchoolList.do?schoolId=">
  						</select>
  					</td>
  				</tr>
  				<tr>
  					<td width="15%" align="right"><span>活动日期：</span></td>
  					<td align="left" colspan="2">
  						<input class="easyui-datebox" name="actionDate" id="actionDate"  style="width:100px;height: 25px;" editable="false"/>&nbsp;&nbsp;
  						<input class="easyui-timespinner" id="timeStart" name="timeStart" style="width:70px;height: 25px;"  data-options="showSeconds:false">&nbsp;&nbsp;
  						<input class="easyui-timespinner" id="timeEnd" name="timeEnd" style="width:70px;height: 25px;"  data-options="showSeconds:false">
  					</td>
  				</tr>
  				<tr>
  					<td align="right" ><span>活动名称：</span></td>
  					<td align="left" colspan="2">
  						<textarea id="title" style="border:0;width:99%;height:100%;resize:none;overflow-y:hidden"></textarea>
  					</td>
  				</tr>
  				<tr>
  					<td align="right"><span>课时：</span></td>
  					<td align="left" colspan="2">
  						<input type="text" class="easyui-numberbox" id="planHours" name="planHours" data-options="min:1,max:24,precision:0"  style="width:100px;height: 25px;">
  					</td>
  				</tr>
  				<tr id="addInfo">
  					<td align="right"><span>老师：</span></td>
  					<td align="left">
  						<select class="easyui-combobox" name="schoolId" id="schoolId" style="width:100px;height: 25px;" editable="false"
  							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'">
  						</select>
  						&nbsp;&nbsp;
  						<select class="easyui-combobox" name="teacherId" id="teacherId" style="width:100px;height: 25px;" editable="false"
  							data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname', panelHeight: 'auto'">
  						</select>
  						&nbsp;&nbsp;
  						<select class="easyui-combobox" name="teacherType" id="teacherType" style="width:100px;height: 25px;" editable="false"
  							 data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'"
	      				 url="<%=path %>/pubData/qryCodeNameList.do?tableName=ACTION_T&codeType=TEACHER_TYPE">
  						</select>
  					</td>
  					<td width="20%" align="center">
  						<a href="javascript:void(0)" id="addBtn" class="easyui-linkbutton" iconCls="icon-add" style="width:100px"><span>添加</span></a>
  					</td>
  				</tr>
  				<tr>
  					<td align="right"><span>创建备注：</span></td>
  					<td align="left" colspan="2">
  						<textarea id="createRemark" style="border:0;width:99%;height:80px;resize:none;overflow-y:hidden"></textarea>
  					</td>
  				</tr>
  			</table>
  		</div>
  		<div style="width:1100px;text-align:center;margin-top:25px;">
  			 <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" style="width:150px" id="submitBtn">提交</a>
  				&nbsp;&nbsp;&nbsp;&nbsp;
  			 <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:150px" id="backBtn" >返回</a>	
  		</div>	
	</body>
</html>		