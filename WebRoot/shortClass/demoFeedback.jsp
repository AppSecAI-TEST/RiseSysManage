<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String shortClassInstId =request.getParameter("shortClassInstId");
	String classState =request.getParameter("classState");
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/demoClass/feedback.js"></script>
  	</head>
  	<body>
 		<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
 		<input id="shortClassInstId" type="hidden" value="<%=shortClassInstId %>"/>
 		<input id="classState" type="hidden" value="<%=classState %>"/>
 		<input id="schoolIds" type="hidden"/>
 		<input id="roomIds" type="hidden"/>
 		<input id="hours" type="hidden"/>
 		<input id="shortSchooltimeId" type="hidden"/>
 		<input id="shortClassAttendId" type="hidden" value=""/>
 		<div  class="easyui-panel" title="反馈信息" style="width:1100px;">
 			<table id="infoTab" width="100%;" class="maintable">
 				<tr>
	 				<td width="150px" align="right"><span>上课时间：</span></td>
	 				<td align="left" colspan="5">
	 					&nbsp;&nbsp;<input class="easyui-datebox" name="openDate" id="openDate"  style="width:150px;height: 28px;"/>&nbsp;&nbsp;
	 					<select class="easyui-combobox" name="hourRange" id="hourRange" style="width:180px;height: 28px;"
  							 data-options="valueField: 'paramValue', textField: 'paramDesc', panelHeight: 'auto'"
	      					 url="<%=path %>/pubData/qryParaConfigList.do?paramType=HOUR_RANGE">
  						</select>
	 				</td>
	 			</tr>
	 			<tr>
	 				<td align="right"><span>教室：</span></td>
	 				<td align="left" colspan="5"></td>
	 			</tr>
	 			<tr>
	 				<td align="right"><span>课时：</span></td>
	 				<td align="left" colspan="5"></td>
	 			</tr>
	 			<tr>
	 				<td align="right"><span>老师：</span></td>
	 				<td align="center"><span>组织</span></td>
	 				<td align="center"><span>姓名</span></td>
	 				<td align="center"><span>课时类型</span></td>
	 				<td align="center"><span>课时量</span></td>
	 				<td align="center"><span>操作</span></td>
	 			</tr>
	 			<tr>
	 				<td align="right"></td>
	 				<td align="center">
	 					<select class="easyui-combobox" name="schoolId" id="schoolId" style="width:150px;height: 28px;"
  							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'">
  						</select>
	 				</td>
	 				<td align="center">
	 					<select class="easyui-combobox" name="teacherId" id="teacherId" style="width:150px;height: 28px;"
  							data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname', panelHeight: 'auto'">
  						</select>
	 				</td>
	 				<td align="center">
	 					<select class="easyui-combobox" name="teacherType" id="teacherType" style="width:100px;height: 28px;"
  							 data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'"
	      				 		url="<%=path %>/pubData/qryCodeNameList.do?tableName=ACTION_T&codeType=TEACHER_TYPE">
  						</select>
	 				</td>
	 				<td align="center">
	 					<input type="text" class="easyui-numberbox" id="lessionHours" name="lessionHours" data-options="min:1,precision:0"  style="width:150px;height: 28px;">
	 				</td>
	 				<td align="center">
	 					<a href="javascript:void(0)" id="addBtn" class="easyui-linkbutton" iconCls="icon-add" style="width:150px;" onclick="addTeacher()"><span>添加</span></a>
	 				</td>
	 			</tr>
	 			<tr id="modelTr" style="display:none;">
	 				<td align="right"><span>老师：</span></td>
	 				<td align="center"><span></span></td>
	 				<td align="center"><span></span></td>
	 				<td align="center"><span></span></td>
	 				<td align="center"><span></span></td>
	 				<td align="center"><a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" style="width:150px;" onclick="delRow(this)"><span>删除</span></a></td>
	 			</tr>		
 			</table>
 		</div>
 		<div style="width:1100px;text-align:center;margin-top:30px;">
  			 <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" style="width:150px" id="submitBtn">提交</a>
  				&nbsp;&nbsp;&nbsp;&nbsp;
  			 <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:150px" id="backBtn" >返回</a>	
  		</div>	
  	</body>
</html>