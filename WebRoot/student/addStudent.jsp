<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<link rel="stylesheet" type="text/css" href="<%=path %>/pub/css/style.css">
		<script type="text/javascript" src="<%=path %>/js/student.js"></script>
  	</head>
  
  	<body>
  		<div id="base">
  			<div id="u0">
        		<div id="u1">
          			<p><span></span></p>
        		</div>
      		</div>
      		
	      	<div class="easyui-panel" style="width:1101px;height:auto;" title="学员基础信息">
	      		<form id="studentFm">
	      			<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId}"/>
	      			<input type="hidden" id="schoolId" name="schoolId" value="${sessionScope.StaffT.schoolId}"/>
	      			<table width="100%" cellpadding="5px" class="maintable" id="addStudentTd">
	      				<tr>
	      					<td align="right">
	      						<span style="color: red;">*</span>
	      						<span>学员姓名：</span>
	      					</td>
	      					<td>
	      						<input name="name" id="name" type="text" class="easyui-textbox validatebox" required="true" style="width: 200px; height: 28px;"/>
	      					</td>
	      					<td align="right">
	      						<span style="color: red;">*</span>
	      						<span>出生日期：</span>
	      					</td>
	      					<td colspan="2">
	      						<input name="birthday" id="birthday" type="text" class="easyui-datebox" required="true" style="width: 200px; height: 28px;"/>
	      					</td>
	      				</tr>
	      				<tr>
	      					<td align="right">
	      						<span style="color: red;">*</span>
	      						<span>性别：</span>
	      					</td>
	      					<td>
	      						<input type="radio" value="1" name="sex"/><span>男</span>
	      						&nbsp;<input type="radio" value="0" name="sex"/><span>女</span>
	      					</td>
	      					<td align="right">
	      						<span>证件号码：</span>
	      					</td>
	      					<td colspan="2">
	      						<select name="identityType" id="identityType" class="easyui-combobox" style="width: 96px; height: 28px;"
	      						 data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
	      						 onLoadSuccess:function(data){$('#identityType').combobox('setValue',data[0].codeFlag);}" 
	      						 url="<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_T&codeType=IDENTITY_TYPE">
        						</select>
        						<input name="identityId" id="identityId" type="text" class="easyui-textbox" style="width: 200px; height: 28px;"/>
	      						<a href="javascript:void(0)" id="validate" class="easyui-linkbutton" style="width: 80px; height: 28px;" funcNodeId="1001">验重</a>
	      					</td>
	      				</tr>
	      				<tr>
	      					<td align="right">
	      						<span>英文名：</span>
	      					</td>
	      					<td>
	      						<input name="byName" id="byName" type="text" class="easyui-textbox" style="width: 200px; height: 28px;"/>
	      					</td>
	      					<td align="right">
	      						<span>家庭地址：</span>
	      					</td>
	      					<td colspan="2">
	      						<input name="address" id="address" type="text" class="easyui-textbox" style="width: 396px; height: 28px;"/>
	      					</td>
	      				</tr>
	      				<tr>
	      					<td align="right">
	      						<span>就读学校：</span>
	      					</td>
	      					<td colspan="4">
	      						<select id="schoolType" class="easyui-combobox" style="width: 150px; height: 28px;"
	      						data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
	      						 onLoadSuccess:function(data){$('#schoolType').combobox('setValue',data[0].codeFlag);}"
	      						url="<%=path %>/pubData/qryCodeNameList.do?tableName=REAL_SCHOOL_T&codeType=SCHOOL_TYPE" required="true" >
        						</select>
        						&nbsp;
        						<span>学校名称：</span>
        						<input id="realSchoolId" type="text" class="easyui-combobox" style="width: 200px; height: 28px;"/>
        						<!-- 
        						<a href="javascript:void(0)" id="qrySchool" class="easyui-linkbutton" iconCls="icon-search" style="width: 100px; height: 28px;">查找学校</a>
        						-->
        						&nbsp;<a href="javascript:void(0)" id="addRealSchool" class="easyui-linkbutton" iconCls="icon-add" style="width: 120px; height: 28px;">添加学校记录</a>
	      					</td>
	      				</tr>
	      				<tr>
	      					<td align="right">
	      						<span style="color: red;">*</span>
	      						<span>招生顾问A：</span>
	      					</td>
	      					<td>
	      						<select id="advisterASchoolId" class="easyui-combobox" style="width: 96px; height: 28px;"
	      						data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto',
	      						 onLoadSuccess:function(data){$('#advisterASchoolId').combobox('setValue',data[0].schoolId);}"
	      						url="<%=path %>/pubData/qrySchoolList.do?schoolId=">
        						</select>
        						<select name="advisterIdA" id="advisterIdA" class="easyui-combobox" style="width: 150px; height: 28px;">
        						</select>
	      					</td>
	      					<td align="right">
	      						<span style="color: red;">*</span>
	      						<span>招生顾问B：</span>
	      					</td>
	      					<td colspan="2">
	      						<select id="advisterBSchoolId" class="easyui-combobox" style="width: 96px; height: 28px;"
	      						data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto',
	      						 onLoadSuccess:function(data){$('#advisterBSchoolId').combobox('setValue',data[0].schoolId);}"
	      						url="<%=path %>/pubData/qrySchoolList.do?schoolId=">
	        					</select>
	        					<select name="advisterIdB" id="advisterIdB" class="easyui-combobox" style="width: 150px; height: 28px;">
	        					</select>
	      					</td>
	      				</tr>
	      				<tr>
	      					<td align="right">
	      						<span style="color: red;">*</span>
	      						<span>责任顾问：</span>
	      					</td>
	      					<td>
	      						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	      						<select name="dutyAdvister" id="dutyAdvister" class="easyui-combobox" style="width: 150px; height: 28px;"
	      						data-options="formatter:formatStaff, valueField: 'staffId', textField: 'staffName', panelHeight: 'auto',
	      						 onLoadSuccess:function(data){$('#dutyAdvister').combobox('setValue',data[0].staffId);}"
	      						url="<%=path %>/pubData/qryStaffList.do?post=002&schoolId=${sessionScope.StaffT.schoolId}">
        						</select>
	      					</td>
	      					<td align="right">
	      						<p><span>客户关怀：</span></p>
	      					</td>
	      					<td colspan="2">
	      						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	      						<select name="carer" id="carer" class="easyui-combobox" style="width: 150px; height: 28px;"
								data-options="formatter:formatStaff, valueField: 'staffId', textField: 'staffName', panelHeight: 'auto',
	      						 onLoadSuccess:function(data){$('#carer').combobox('setValue',data[0].staffId);}"
	      						url="<%=path %>/pubData/qryStaffList.do?post=003&schoolId=${sessionScope.StaffT.schoolId}">
        						</select>
	      					</td>
	      				</tr>
	      				<tr>
	      					<td align="right">
	      						<span>学员备注：</span>
	      					</td>
	      					<td colspan="4">
	      						<input id="remark" name="remark" type="text" class="easyui-textbox" style="width: 969px; height: 28px;"/>
	      					</td>
	      				</tr>
	      			</table>
	      		</form>
	      	</div>
      		<div style="height: 10px;"></div>
      		<div class="easyui-panel" style="width:1101px;height:auto;" title="联系人信息">
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
							<td width="100px">
								<select id="relationType" class="easyui-combobox" style="width: 100px; height: 28px;"
								data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
	      						 onLoadSuccess:function(data){$('#relationType').combobox('setValue',data[0].codeFlag);}"
	      						url="<%=path %>/pubData/qryCodeNameList.do?tableName=CONTACT_T&codeType=RELATION_TYPE">
	        					</select>
							</td>
							<td width="120px">
								<input id="contactName" type="text" class="easyui-textbox validatebox" required="true" style="width: 120px; height: 28px;"/>
							</td>
							<td width="120px">
								<input id="job" type="text" class="easyui-textbox validatebox" required="true" style="width: 120px; height: 28px;"/>
							</td>
							<td width="80px" align="center">
								<input name="used" type="checkbox"/>
							</td>
							<td width="310px">
								<select id="contactIdentityType" class="easyui-combobox" style="width: 100px; height: 28px;"
								data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
	      						 onLoadSuccess:function(data){$('#contactIdentityType').combobox('setValue',data[0].codeFlag);}" 
	      						 url="<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_T&codeType=IDENTITY_TYPE">
	        					</select>
	        					<input id="contactIdentityId" type="text" class="easyui-textbox numberbox" required="true" style="width: 200px; height: 28px;" validType="length[0,18]" />
							</td>
							<td width="150px">
								<input id="phone" type="text" class="easyui-textbox numberbox" required="true" style="width: 150px; height: 28px;" validType="length[0,11]" invalidMessage="不能超过11个字符！"/>
							</td>
							<td width="80px">
								<a href="javascript:void(0)" id="addContact" class="easyui-linkbutton" iconCls="icon-add" style="width: 80px; height: 28px;">添加</a>
							</td>
						</tr>
					</table>
	      		</form>
      		</div>
      		
	      	<div style="margin-top: 50px;">
	      		<div style="float: left;margin-left: 900px;">
	      			<a href="javascript:void(0)" id="studentSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
	      			&nbsp;<a href="javascript:void(0)" id="studentBack" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onclick="javascript:window.history.back()">返回</a>
	      		</div>
	      	</div>
  		</div>
  	</body>
</html>
