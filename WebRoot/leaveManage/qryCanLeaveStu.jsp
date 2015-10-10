<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/pub/js/json.js"></script>
		<script type="text/javascript" src="<%=path %>/pub/js/json2.js"></script>
		<script type="text/javascript" src="<%=path %>/js/leaveManage/leaveManage.js"></script>
  	</head>
  	<body>
 		<form id="qryStuFm">
  			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;margin-top:10px;font-family:'微软雅黑'" cellspacing="5">
  				<tr>
  					<td align="right" width="15%">所属校区：</td>
  					<td align="left" width="5%">
  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width:130px;" editable="false"
							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto',
      						 onLoadSuccess:function(data){$('#schoolId').combobox('setValue',data[0].schoolId);}"
      						url="<%=path %>/pubData/qrySchoolList.do?schoolId=${sessionScope.StaffT.schoolId}">
        				</select>
  					</td>
  					<td align="right" width="15%">学员姓名：</td>
  					<td align="left" width="5%">
  						<select class="easyui-combobox" name="studentId" id="studentId" style="width:130px;">
  							
  						</select>
  					</td>
  					<td align="right" width="15%">联系电话：</td>
  					<td align="left" width="5%">
  						<input class="easyui-textbox"  name="phone" id="phone" style="width:130px;" />
  					</td>
  					<td width="40%"></td>
  				</tr>
  				<tr>
  					<td align="right" width="15%">课程状态：</td>
  					<td align="left" width="5%">
  						<select class="easyui-combobox" name="courseState" id="courseState" style="width:130px;"
  						data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
      					onLoadSuccess:function(data){$('#courseState').combobox('setValue',data[0].codeFlag);}"
      					url="<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_LEAVE_T&codeType=COURSE_STATE">
  						</select>
  					</td>
  					<td align="right" width="15%">班级老师：</td>
  					<td align="left" width="5%">
  						<select class="easyui-combobox" name="teacherId" id="teacherId" style="width:130px;">
  							
  						</select>
  					</td>
  					<td align="right" width="15%">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:90px; height: 25px;" id="qryStuBtn" funcNodeId="4005">查询</a>
					</td>
  					<td colspan="2" align="left">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:90px; height: 25px;" id="reset" >重置</a>
					</td>
  				</tr>
  			</table>
 		</form>
 		
		<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:550" id="stuList_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
			<thead>
				<tr>
					<th field="ck" align="center" checkbox="true" width="1%"></th>
					<th field="name" align="center" width="10%">学员姓名</th>
					<th field="byName" align="center" width="10%">英文名</th>
					<th field="phone" align="center" width="15%">联系电话</th>
					<th field="stageLevel" align="center" width="10%">已升学阶段</th>
					<th field="className" align="center" width="10%">在读班级</th>
					<th field="courseStateVal" align="center" width="10%">课程状态</th>
					<th field="teacherName" align="center" width="11%">带班老师</th>
					<th field="carerName" align="center" width="10%">客户关怀</th>
					<th field="classProgress" align="center" width="11%">在读班级课时</th>
				</tr>
			</thead>
		</table>
		<div id="toolbar">
   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="addLeaveInfo()">提交</a>
 			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" onclick="javascript:window.history.back()">返回</a>
 		</div>
  	</body>
</html>
