<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String roomId =request.getParameter("roomId");
	String operate =request.getParameter("operate");
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/classroom/operate.js"></script>
	</head>
	<body>
		<div id ="baseInfo" class="easyui-panel" title="基本信息" style="width:1100px;">
		<input id="handlerId" type="hidden" value="${sessionScope.StaffT.staffId}"/>
		<input id="operate" type="hidden" value="<%=operate%>"/>
		<input id="roomId" type="hidden" value="<%=roomId%>"/>
  			<table width="100%;" class="maintable">
  				<tr>
  					<td width="20%" align="right"><span>校区：</span></td>
  					<td align="left" colspan="2">
  						<select class="easyui-combobox" name="schoolId" id="schoolId" style="width:150px;height: 28px;"
  							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'"
  							url="<%=path%>/pubData/qrySchoolList.do?schoolId=">
  						</select>
  					</td>
  				</tr>
  				<tr>
  					<td align="right"><span>教室状态：</span></td>
  					<td align="left"  colspan="2">
  						<select type="text" class="easyui-combobox" name="roomState" id="roomState" style="width:150px;height: 28px;"
  							data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'"
  							url="<%=path%>/pubData/qryCodeNameList.do?tableName=ROOM_T&codeType=ROOM_STATE">
  						</select>
  					</td>
  				</tr>
  				<tr>
  					<td align="right" ><span>教室名称：</span></td>
  					<td align="left" colspan="2">
  						 <input type="text" class="easyui-textbox" id="roomName" style="width:200px;height: 28px;">
  					</td>
  				</tr>
  				<tr>
  					<td align="right"><span>教室编号：</span></td>
  					<td align="left"  colspan="2">
  						<input type="text" class="easyui-textbox" id="roomCode" style="width:200px;height: 28px;">
  					</td>
  				</tr>
  				<tr style="display:none">
  					<td align="right"><span>添加开放课程类型</span></td>
  					<td align="left" width="40%">
  						<select class="easyui-combobox" name="state" id="state" style="width:150px;height: 28px;"
  							data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'">
  						</select>
  						<select class="easyui-combobox" name="classType" id="classType" style="width:150px;height: 28px;"
  						</select>
  					</td>
  					<td>	
  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-add" style="width:150px" id="addBtn"><span>添加</span></a>
  					</td>
  				</tr>
  				<tr id="modelTr" style="display:none;">
  					<td align="right"><span>开放课程类型：</span></td>
  					<td align="center">
  					</td>
  					<td>
  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-remove" style="width:150px" onclick="deleteTr(this)"><span>删除</span></a>
  					</td>
  				</tr>
  			</table>
  		</div>
  		<div style="width:1100px;text-align:center;margin-top:50px;">
  			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" style="width:150px" id="submitBtn">提交</a>
  				&nbsp;&nbsp;&nbsp;&nbsp;
  			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" style="width:150px" id="backBtn" >返回</a>	
  		</div>	
	</body>
</html>		