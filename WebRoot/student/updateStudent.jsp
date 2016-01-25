<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String carer = request.getParameter("carer");
	String schoolId = request.getParameter("schoolId");
	String studentId = request.getParameter("studentId");
	String funcNodeId = request.getParameter("funcNodeId");
	String dutyAdvister = request.getParameter("dutyAdvister");
	String advisterIdA = request.getParameter("advisterIdA");
	String advisterIdB = request.getParameter("advisterIdB");
	String identityType = request.getParameter("identityType");
	String advisterASchoolId = request.getParameter("advisterASchoolId");
	String advisterBSchoolId = request.getParameter("advisterBSchoolId");
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<%@ include file="../common/pub.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/student/updateStudent.js"></script>
  	</head>
  
  	<body>
  		<div class="easyui-panel" style="min-width:1100px; width:98%;height:auto;" title="学员基础信息">
	      	<input type="hidden" id="updateAdvisterBSchoolId" value="<%=advisterBSchoolId %>"/>
	      	<input type="hidden" id="updateAdvisterASchoolId" value="<%=advisterASchoolId %>"/>
	      	<input type="hidden" id="updateAdvisterIdA" value="<%=advisterIdA %>"/>
	      	<input type="hidden" id="updateAdvisterIdB" value="<%=advisterIdB %>"/>
	      	<input type="hidden" id="updateIdentityType" value="<%=identityType %>"/>
	      	<input type="hidden" id="updateDutyAdvister" value="<%=dutyAdvister %>"/>
	      	<input type="hidden" id="updateCarer" value="<%=carer %>"/>
      		<form id="studentFm">
	      		<input type="hidden" id="schoolId" value="<%=schoolId %>"/>
	      		<input type="hidden" id="funcNodeId" name="funcNodeId" value="<%=funcNodeId %>"/>
      			<input type="hidden" id="handlerId" name="handlerId" value="${sessionScope.StaffT.staffId }"/>
      			<input type="hidden" id="studentId" name="studentId" value="<%=studentId %>"/>
      			<table width="100%" cellpadding="5px" class="maintable" id="studentTd">
	      			<tr>
	      				<td align="right" width="114px"><span style="color: red;">*</span><span>学员姓名：</span></td>
	      				<td>
	      					<div id="nameDiv">
		      					<input name="name" id="name" type="text" class="easyui-textbox validatebox" required="true" style="width: 100px; height: 25px;"/>
	      					</div>
	      					<span id="nameText" style="display: none;"></span>
	      				</td>
	      				<td align="right" width="114px"><span style="color: red;">*</span><span>出生日期：</span></td>
	      				<td colspan="4">
	      					<div id="birthdayDiv">
		      					<input name="birthday" id="birthday" type="text" class="easyui-datebox" required="true" style="width: 100px; height: 25px;" editable="false"/>
	      					</div>
	      					<span id="birthdayText" style="display: none;"></span>
	      				</td>
	      			</tr>
	      			<tr>
	      				<td align="right" width="114px"><span style="color: red;">*</span><span>性别：</span></td>
	      				<td>
	      					<div id="sexDiv">
		      					<input type="radio" value="1" name="sex"/><span>男</span>
		      					&nbsp;<input type="radio" value="0" name="sex"/><span>女</span>
	      					</div>
	      					<span id="sexText" style="display: none;"></span>
	      				</td>
	      				<td align="right" width="114px"><span>证件号码：</span></td>
	      				<td colspan="4">
		      				<select name="identityType" id="identityType" class="easyui-combobox" style="width: 100px; height: 25px;">
	        				</select>
	        				<input name="identityId" id="identityId" type="text" class="easyui-textbox" style="width: 200px; height: 25px;"/>
		      				<a href="javascript:void(0)" id="validate" class="easyui-linkbutton" style="width: 80px; height: 25px;" funcNodeId="1001">验重</a>
	      				</td>
	      			</tr>
	      			<tr>
	      				<td align="right" width="114px"><span style="color: red;">*</span><span>英文名：</span></td>
	      				<td>
	      					<input name="byName" id="byName" type="text" class="easyui-textbox" style="width: 100px; height: 25px;"/>
	      				</td>
	      				<td align="right" width="114px"><span>家庭地址：</span></td>
	      				<td colspan="4">
	      					<input name="address" id="address" type="text" class="easyui-textbox" style="width: 396px; height: 25px;"/>
	      				</td>
	      			</tr>
	      			<tr>
	      				<td align="right" width="114px"><span>就读学校：</span></td>
	      				<td colspan="6">
	      					<select id="schoolType" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false">
        					</select>
        					&nbsp;
        					<span style="width: 114px">学校名称：</span>
        					<input id="realSchoolId" type="text" class="easyui-combobox" style="width: 300px; height: 25px;"/>
        					&nbsp;<a href="javascript:void(0)" id="addRealSchool" class="easyui-linkbutton" iconCls="icon-add" style="width: 120px; height: 25px;">添加学校记录</a>
	      				</td>
	      			</tr>
	      			<tr>
	      				<td align="right" width="114px"><span style="color: red;">*</span><span>建档日期：</span></td>
	      				<td>
	      					<div id="entranceDateDiv">
		      					<input name="entranceDate" id="entranceDate" type="text" class="easyui-datebox" required="true" style="width: 100px; height: 25px;" editable="false"/>
	      					</div>
	      					<span id="entranceDateText" style="display: none;"></span>
	      				</td>
	      				<td align="right" width="114px"><span>录入时间：</span></td>
	      				<td colspan="4">
	      					<span id="createDateText"></span>
	      				</td>
	      			</tr>
	      			<tr>
	      				<td align="right" width="114px"><span style="color: red;">*</span><span>招生顾问A：</span></td>
	      				<td>
	      					<div id="advisterADiv">
		      					<select id="advisterASchoolId" class="easyui-combobox" style="width: 100px; height: 25px;" required="true" editable="false">
	        					</select>
	        					<select name="advisterIdA" id="advisterIdA" class="easyui-combobox" style="width: 100px; height: 25px;" required="true" editable="false">
	        					</select>
	      					</div>
        					<span id="advisterAText" style="display: none;"></span>
	      				</td>
	      				<td align="right" width="114px"><span>招生顾问B：</span></td>
	      				<td colspan="4">
	      					<div id="advisterBDiv">
		      					<select id="advisterBSchoolId" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false">
		        				</select>
		        				<select name="advisterIdB" id="advisterIdB" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false">
		        				</select>
	      					</div>
	        				<span id="advisterBText" style="display: none;"></span>
	      				</td>
	      			</tr>
	      			<tr>
	      				<td align="right" width="114px"><span style="color: red;">*</span><span>责任顾问：</span></td>
	      				<td>
		      				<select name="dutyAdvister" id="dutyAdvister" class="easyui-combobox" style="width: 100px; height: 25px;" required="true" editable="false">
	        				</select>
	      				</td>
	      				<td align="right" width="114px"><span>客户关怀：</span></td>
	      				<td colspan="4">
	      					<select name="carer" id="carer" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false">
        					</select>
	      				</td>
	      			</tr>
	      			<tr>
	      				<td align="right" width="114px"><span>学员备注：</span></td>
	      				<td colspan="6">
	      					<input id="remark" name="remark" type="text" class="easyui-textbox" style="width: 969px; height: 25px;"/>
	      				</td>
	      			</tr>
	      		</table>
      		</form>
      	</div>
      		
      	<div style="height: 10px;"></div>
      	<div class="easyui-panel" style="min-width:1100px; width:98%;height:auto;" title="联系人信息">
      		<form id="contactFm">
			      <table width="100%" cellpadding="5px" class="maintable" id="contactTd">
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
						<td align="center" width="100px">
							<select id="relationType" class="easyui-combobox" style="width: 100px; height: 25px;"
								data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'"
	      						url="<%=path %>/pubData/qryCodeNameList.do?tableName=CONTACT_T&codeType=RELATION_TYPE" editable="false">
	        				</select>
						</td>
						<td align="center" width="120px">
							<input id="contactName" type="text" class="easyui-textbox validatebox" required="true" style="width: 120px; height: 25px;"/>
						</td>
						<td align="center" width="120px">
							<input id="job" type="text" class="easyui-textbox validatebox" style="width: 120px; height: 25px;"/>
						</td>
						<td width="80px" align="center">
							<input name="used" type="checkbox"/>
						</td>
						<td align="center" width="310px">
							<select id="contactIdentityType" class="easyui-combobox" style="width: 100px; height: 25px;" editable="false">
	        				</select>
	        				<input id="contactIdentityId" type="text" class="easyui-textbox numberbox" style="width: 200px; height: 25px;" validType="length[0,18]" />
						</td>
						<td align="center" width="150px">
							<input id="phone" type="text" class="easyui-textbox numberbox" style="width: 150px; height: 25px;" validType="length[0,11]" invalidMessage="不能超过11个字符！"/>
						</td>
						<td align="center" width="80px">
							<a href="javascript:void(0)" id="addContact" class="easyui-linkbutton" iconCls="icon-add" style="width: 80px; height: 25px;">添加</a>
						</td>
					</tr>
				</table>
	      	</form>
      	</div>
      		
      	<div style="height: 10px;"></div>
      	<div class="easyui-panel" style="min-width:1100px; width:98%;height:auto;" title="活动信息">
      		<form id="activityFm">
      			<table width="100%" cellpadding="5px" class="maintable" id="activityTd">
					<tr>
						<td align="center"><span>活动标题</span></td>
						<td align="center"><span>活动时间</span></td>
						<td align="center"><span>获奖情况</span></td>
						<td align="center"><span>活动详细</span></td>
						<td align="center"><span>操作</span></td>
					</tr>
					<tr>
						<td align="center" width="150px">
							<input id="title" type="text" class="easyui-textbox" style="width: 150px; height: 25px;" required="true"/>
						</td>
						<td align="center" width="100px">
							<input id="activityDate" type="text" class="easyui-datebox" required="true" style="width: 100px; height: 25px;" editable="false"/>
						</td>
						<td align="center" width="150px">
							<input id="award" type="text" class="easyui-textbox" style="width: 150px; height: 25px;" required="true"/>
						</td>
						<td align="center" width="563px">
							<input id="activityRemark" type="text" class="easyui-textbox" style="width: 563px; height: 25px;"/>
						</td>
						<td align="center" width="80px">
							<a href="javascript:void(0)" id="addActivity" class="easyui-linkbutton" iconCls="icon-add" style="width: 80px; height: 25px;">添加</a>
						</td>
					</tr>
				</table>
      		</form>
      	</div>
      		
      	<div style="margin-top: 20px;min-width:1100px; width:100%;">
	      	<a href="javascript:void(0)" id="updateSubmit" class="easyui-linkbutton" iconCls="icon-ok" style="width: 80px; height: 25px;">提交</a>
	      	&nbsp;&nbsp;<a href="javascript:void(0)" id="studentBack" class="easyui-linkbutton" iconCls="icon-back" style="width: 80px; height: 25px;" onclick="javascript:window.history.back()">返回</a>
		</div>
  	</body>
</html>
