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
      		
	      	<div class="easyui-panel" style="width:100%;height:auto;" title="学员基础信息">
	      		<form id="studentFm">
	      			<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId}"/>
	      			<input type="hidden" id="schoolId" name="schoolId" value="${sessionScope.StaffT.schoolId}"/>
	      			<table width="100%" cellpadding="5px" class="maintable" id="addStudentTd">
	      				<tr>
	      					<td width="13%" align="right">
	      						<span style="color: red;">*</span>
	      						<span>学员姓名：</span>
	      					</td>
	      					<td width="25%">
	      						<input name="name" id="name" type="text" class="easyui-textbox validatebox" required="true" style="width: 200px; height: 28px;"/>
	      					</td>
	      					<td width="13%" align="right">
	      						<span style="color: red;">*</span>
	      						<span>出生日期：</span>
	      					</td>
	      					<td width="15%">
	      						2010-10-10
	      					</td>
	      					<td align="right"><span>证件号码：</span></td>
	      					<td>1234567890</td>
      					</tr>
	      				<tr>
	      					<td align="right">
	      						<span style="color: red;">*</span>
	      						<span>性别：</span>
	      					</td>
	      					<td><span>男</span></td>
	      					<td align="right"><span>缴费时间：</span></td>
	      					<td><input name="byName" id="byName" type="text" class="easyui-textbox" style="width: 200px; height: 28px;"/></td>
	      					<td align="right"><span>课程类型：</span></td>
	      					<td><select name="advisterBSchoolId" class="easyui-combobox" id="advisterBSchoolId" style="width: 96px; height: 28px;"
	      						data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto',
	      						 onLoadSuccess:function(data){$('#advisterBSchoolId').combobox('setValue',data[0].schoolId);}"
	      						url="<%=path %>/pubData/qrySchoolList.do?schoolId=">
	      					  </select></td>
      					</tr>
	      				<tr>
	      					<td align="right">&nbsp;</td>
	      					<td>&nbsp;</td>
	      					<td align="right">&nbsp;</td>
	      					<td>&nbsp;</td>
	      					<td>&nbsp;</td>
	      					<td>&nbsp;</td>
	      				</tr>
	      			</table>
	      			<p>&nbsp;</p>
                </form>
      	     
	      	</div>
	      		<div style="height: 10px;"></div>
	      <div class="easyui-panel" style="width:1101px;height:auto;" title="常规课课程">
      	      <table width="100%" cellpadding="5px" class="maintable" id="addStudentTd2">
	      	      <tr>
	      	        <td align="right"><span style="color: red;">*</span> <span>阶段：</span></td>
	      	        <td>&nbsp;</td>
	      	        <td align="right">*班级类型：</td>
	      	        <td> 2010-10-10 </td>
	      	        <td align="right"><span>证件号码：</span></td>
	      	        <td>1234567890</td>
      	        </tr>
	      	      <tr>
	      	        <td align="right"><DIV id="u170_state0" data-label="状态1">
	      	          <DIV id="u170_state0_content">
	      	            <DIV id="u171" jQuery17103354182867960753="173">
	      	              <DIV id="u172" jQuery17103354182867960753="174">
	      	                <p>业绩顾问A：</p>
      	                  </DIV>
      	                </DIV>
      	              </DIV>
	      	          </DIV></td>
	      	        <td><select name="schoolType" class="easyui-combobox" id="schoolType2" style="width: 150px; height: 28px;"
	      						data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
	      						 onLoadSuccess:function(data){$('#schoolType').combobox('setValue',data[0].codeFlag);}"
	      						url="<%=path %>/pubData/qryCodeNameList.do?tableName=REAL_SCHOOL_T&codeType=SCHOOL_TYPE" required="true" >
	      	          </select></td>
	      	        <td align="right"><span>业绩顾问：</span></td>
	      	        <td><select name="advisterBSchoolId2" class="easyui-combobox" id="advisterBSchoolId2" style="width: 96px; height: 28px;"
	      						data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto',
	      						 onLoadSuccess:function(data){$('#advisterBSchoolId').combobox('setValue',data[0].schoolId);}"
	      						url="<%=path %>/pubData/qrySchoolList.do?schoolId=">
	      	          </select></td>
	      	        <td>&nbsp;</td>
	      	        <td>&nbsp;</td>
      	        </tr>
	      	      <tr>
	      	        <td align="right">备注</td>
	      	        <td colspan="5">&nbsp;</td>
      	        </tr>
	      	      <tr>
	      	        <td align="right">上传缴费单</td>
	      	        <td>&nbsp;</td>
	      	        <td align="right">&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td>&nbsp;</td>
      	        </tr>
	      	      <tr>
	      	        <td align="right">&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td align="right">&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td>&nbsp;</td>
      	        </tr>
	      	      <tr>
	      	        <td align="right">&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td align="right">&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td>&nbsp;</td>
      	        </tr>
      	      </table>
</div>
      		<div style="height: 10px;"></div>
      			      <div class="easyui-panel" style="width:100%;height:auto;" title="赠品信息">
      	      <table width="100%" cellpadding="5px" class="maintable" id="addStudentTd2">
	      	      <tr>
	      	        <td width="8%" align="right"><span style="color: red;">赠品类型</span><span>：</span></td>
	      	        <td width="14%"><select name="schoolType2" class="easyui-combobox" id="schoolType" style="width: 150px; height: 28px;"
	      						data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
	      						 onLoadSuccess:function(data){$('#schoolType').combobox('setValue',data[0].codeFlag);}"
	      						url="<%=path %>/pubData/qryCodeNameList.do?tableName=REAL_SCHOOL_T&codeType=SCHOOL_TYPE" required="true" >
      	            </select></td>
	      	        <td width="7%" align="right">赠品名称：</td>
	      	        <td width="29%"> <select name="advisterBSchoolId3" class="easyui-combobox" id="advisterBSchoolId3" style="width: 96px; height: 28px;"
	      						data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto',
	      						 onLoadSuccess:function(data){$('#advisterBSchoolId').combobox('setValue',data[0].schoolId);}"
	      						url="<%=path %>/pubData/qrySchoolList.do?schoolId=">
	      	          </select>
	      	          <select name="advisterBSchoolId4" class="easyui-combobox" id="advisterBSchoolId4" style="width: 96px; height: 28px;"
	      						data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto',
	      						 onLoadSuccess:function(data){$('#advisterBSchoolId').combobox('setValue',data[0].schoolId);}"
	      						url="<%=path %>/pubData/qrySchoolList.do?schoolId=">
      	              </select>
	      	          <input name="name2" id="name2" type="text" class="easyui-textbox validatebox" required="true" style="width: 200px; height: 28px;"/></td>
	      	        <td width="6%" align="right">是否领用</td>
	      	        <td width="12%" align="right">
	      	          <input type="radio" name="radio" id="radio" value="radio">
	      	          <label for="radio">已领用</label>
	      	          <input type="radio" name="radio" id="radio" value="radio">
	      	          <label for="radio"> 未领用</label>
      	           </td>
	      	        <td width="6%">发放人</td>
	      	        <td width="13%"><input name="name4" id="name4" type="text" class="easyui-textbox validatebox" required="true" style="width: 100px; height: 28px;"/></td>
	      	        <td width="5%">添加</td>
      	        </tr>
	      	      <tr>
	      	        <td align="right">&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td align="right">&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td>&nbsp;</td>
      	        </tr>
	      	      <tr>
	      	        <td align="right">&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td align="right">&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td>&nbsp;</td>
      	        </tr>
	      	      <tr>
	      	        <td align="right">&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td align="right">&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td>&nbsp;</td>
      	        </tr>
	      	      <tr>
	      	        <td align="right">&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td align="right">&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td>&nbsp;</td>
	      	        <td>&nbsp;</td>
      	        </tr>
      	      </table>
</div>
      		
	      	<div style="margin-top: 50px;">
	      		<div style="float: left;margin-left: 900px;">
	      			<a href="javascript:void(0)" id="studentSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 28px;">提交</a>
	      			&nbsp;<a href="javascript:void(0)" id="studentBack" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 28px;" onClick="javascript:window.history.back()">返回</a>
	      		</div>
	      	</div>
  		</div>
  	</body>
</html>
