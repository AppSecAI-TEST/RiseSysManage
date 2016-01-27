<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/student/addStudent.js"></script>
  	</head>
  
  	<body>
		<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="学员基础信息">
			<form id="studentFm">
	      		<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId}"/>
	      		<input type="hidden" id="schoolId" name="schoolId" value="${sessionScope.StaffT.schoolId}"/>
	      		<table width="100%" cellpadding="5px" class="maintable" id="addStudentTd">
	      			<tr>
	      				<td align="right" width="114px"><span style="color: red;">*</span><span>学员姓名：</span></td>
	      				<td>
	      					<input name="name" id="name" type="text" class="easyui-textbox validatebox" validType="length[0,15]" required="true" style="width: 100px; height: 25px;"/>
	      				</td>
	      				<td align="right" width="114px"><span style="color: red;">*</span><span>出生日期：</span></td>
	      				<td colspan="2">
	      					<input name="birthday" id="birthday" type="text" class="easyui-datebox" required="true" style="width: 100px; height: 25px;" editable="false"/>
	      				</td>
	      			</tr>
	      			<tr>
	      				<td align="right" width="114px"><span style="color: red;">*</span><span>性别：</span></td>
	      				<td>
	      					<input type="radio" value="1" name="sex"/><span>男</span>
	      					&nbsp;<input type="radio" value="0" name="sex"/><span>女</span>
	      				</td>
	      				<td align="right" width="114px"><span>证件号码：</span></td>
	      				<td colspan="2">
	      					<select name="identityType" id="identityType" class="easyui-combobox"   style="width: 100px; height: 25px;">
        					</select>
        					<input name="identityId" id="identityId" type="text" class="easyui-textbox" validType="certNo['identityType']" style="width: 200px; height: 25px;"/>
	      					<a href="javascript:void(0)" id="validate" class="easyui-linkbutton" style="width: 80px; height: 25px;" funcNodeId="1001">验重</a>
	      				</td>
	      			</tr>
	      			<tr>
	      				<td align="right" width="114px"><span style="color: red;">*</span><span>英文名：</span></td>
	      				<td>
	      					<input name="byName" id="byName" type="text" class="easyui-textbox"  validType="byname" required="true" style="width: 100px; height: 25px;"/>
	      				</td>
	      				<td align="right" width="114px"><span>家庭地址：</span></td>
	      				<td colspan="2">
	      					<input name="address" id="address" type="text" class="easyui-textbox" style="width: 396px; height: 25px;"/>
	      				</td>
	      			</tr>
	      			<tr>
	      				<td align="right" width="114px"><span>就读学校：</span></td>
	      				<td colspan="4">
	      					<select id="schoolType" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false">
        					</select>
        					&nbsp;
        					<span style="width: 114px">学校名称：</span>
        					<select id="realSchoolId" class="easyui-combobox" style="width: 300px; height: 25px;">
        					</select>
        					&nbsp;<a href="javascript:void(0)" id="addRealSchool" class="easyui-linkbutton" iconCls="icon-add" style="width: 120px; height: 25px;">添加学校记录</a>
	      				</td>
	      			</tr>
	      			<tr>
	      				<td align="right" width="114px"><span style="color: red;">*</span><span>建档日期：</span></td>
	      				<td colspan="4">
	      					<input name="entranceDate" id="entranceDate" type="text" class="easyui-datebox" required="true" style="width: 100px; height: 25px;" editable="false"/>
	      				</td>
	      			</tr>
	      			<tr>
	      				<td align="right" width="114px"><span style="color: red;">*</span><span>招生顾问A：</span></td>
	      				<td>
	      					<select id="advisterASchoolId" class="easyui-combobox" style="width: 100px; height: 25px;" required="true" editable="false">
        					</select>
        					<select name="advisterIdA" id="advisterIdA" class="easyui-combobox" style="width: 100px; height: 25px;" required="true" editable="false">
        					</select>
	      				</td>
	      				<td align="right" width="114px"><span>招生顾问B：</span></td>
	      				<td colspan="2">
	      					<select id="advisterBSchoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false">
	        				</select>
	        				<select name="advisterIdB" id="advisterIdB" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false">
	        				</select>
	      				</td>
	      			</tr>
	      			<tr>
	      				<td align="right" width="114px"><span style="color: red;">*</span><span>责任顾问：</span></td>
	      				<td>
	      					<select name="dutyAdvister" id="dutyAdvister" class="easyui-combobox" style="width: 100px; height: 25px;"
	      						data-options="formatter:formatStaff, valueField: 'staffId', textField: 'userName', panelHeight: 'auto'"
	      						url="<%=path %>/pubData/qryStaffList.do?post=16,17&schoolId=${sessionScope.StaffT.schoolId}" required="true" editable="false">
        					</select>
	      				</td>
	      				<td align="right" width="114px"><span>客户关怀：</span></td>
	      				<td colspan="2">
	      					<select name="carer" id="carer" class="easyui-combobox" style="width: 100px; height: 25px;"
								data-options="formatter:formatStaff, valueField: 'staffId', textField: 'userName', panelHeight: 'auto'"
	      						url="<%=path %>/pubData/qryStaffList.do?post=31,32,33&schoolId=${sessionScope.StaffT.schoolId}" editable="false">
        					</select>
	      				</td>
	      			</tr>
	      			<tr>
	      				<td align="right" width="114px"><span>学员备注：</span></td>
	      				<td colspan="4">
	      					<textarea rows="4" cols="122" id="remark" name="remark" class="easyui-validatebox textbox"></textarea>
	      				</td>
	      			</tr>
	      		</table>
	      	</form>
	    </div>
      	<div style="height: 10px;"></div>
      	<div class="easyui-panel" style="min-width:1100px; width:99%;height:auto;" title="联系人信息">
      		<form id="contactFm">
			     <table width="100%" cellpadding="5px" class="maintable" id="addContactTd">
					<tr>
						<td align="center"><span>关系</span></td>
						<td align="center"><span>姓名</span></td>
						<td align="center"><span>职业</span></td>
						<td align="center"><span>常用联系人</span></td>
						<td align="center"><span>证件号码</span></td>
						<td align="center"><span>联系电话</span></td>
						<td align="center"><span>操作</span></td>
					</tr>
					<tr>
						<td width="100px" align="center">
							<select id="relationType" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false" required="true"
								data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'"
	      						url="<%=path %>/pubData/qryCodeNameList.do?tableName=CONTACT_T&codeType=RELATION_TYPE">
	        				</select>
						</td>
						<td width="100px" align="center">
							<input id="contactName" type="text" class="easyui-textbox validatebox" validType="stuName" required="true" style="width: 100px; height: 25px;"/>
						</td>
						<td width="100px" align="center">
							<input id="job" type="text" class="easyui-textbox validatebox"  style="width: 100px; height: 25px;"/>
						</td>
						<td width="80px" align="center">
							<input name="used" type="checkbox"/>
						</td>
						<td width="310px" align="center">
							<select id="contactIdentityType" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false">
	        				</select>
	        				<input id="contactIdentityId" type="text" class="easyui-textbox numberbox" style="width: 200px; height: 25px;" validType="length[0,18]" />
						</td>
						<td width="100px" align="center">
							<input id="phone" type="text" class="easyui-textbox" required="true" style="width: 100px; height: 25px;" validType="phone"/>
						</td>
						<td width="80px" align="center">
							<a href="javascript:void(0)" id="addContact" class="easyui-linkbutton" iconCls="icon-add" style="width: 80px; height: 25px;">添加</a>
						</td>
					</tr>
				</table>
	      	</form>
      	</div>
      		
      	<div style="text-align:center;margin-top: 25px;min-width:1100px; width:99%;">
	      	<a href="javascript:void(0)" id="studentSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 25px;">提交</a>
	      	&nbsp;&nbsp;		
	      	<a href="javascript:void(0)" id="studentBack" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 25px;" onclick="javascript:window.history.back()">返回</a>
	   </div>
  	</body>
</html>
