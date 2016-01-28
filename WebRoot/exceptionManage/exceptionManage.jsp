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
		<script type="text/javascript" src="<%=path %>/js/exceptionManage/exceptionManage.js"></script>
  	</head>
  	<body>
 		<form id="qryFm">
  			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;margin-top:10px;font-family:'微软雅黑'" cellspacing="5">
  				<tr>
  					<td align="right" width="8%">校区：</td>
  					<td align="left" width="10%">
  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width:120px;"
							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'"
				      		url="<%=path %>/pubData/qrySchoolList.do">
        				</select>
  					</td>
  					<td align="right" width="10%">学员姓名：</td>
  					<td align="left" width="10%">
  						<select name="studentName" id="studentName" class="easyui-combobox" style="width:120px">
						</select>
  					</td>
  					<td align="right" width="10%">联系电话：</td>
  					<td align="left" width="15%">
  						<input class="easyui-numberbox" name="phone" id="phone" style="width:120px;" />
  					</td>
  					<td align="right" width="10%">缴费日期：</td>
  					<td align="left" width="10%">
  						<input class="easyui-datebox" name="payStartDate" id="payStartDate" style="width:120px;" />
  					</td>
  					<td align="center" width="3%">至：</td>
  					<td align="left" width="10%">
  						<input class="easyui-datebox" name="payEndDate" id="payEndDate" style="width:120px;" />
  					</td>
  				</tr>
  				<tr>
  					<td align="right">责任顾问：</td>
  					<td align="left">
  						<select id="dutyAdvister" name="dutyAdvister" class="easyui-combobox" style="width: 120px;"
							data-options="formatter:formatStaff, valueField: 'staffId', textField: 'userName', panelHeight: 'auto'"
      						url="<%=path %>/pubData/qryStaffList.do">
      					</select>
  					</td>
  					<td align="right">客户关怀：</td>
  					<td align="left">
  						<select id="carer" name="carer" class="easyui-combobox" style="width: 120px"
							data-options="formatter:formatStaff, valueField: 'staffId', textField: 'userName', panelHeight: 'auto'"
     						url="<%=path %>/pubData/qryStaffList.do">
     					</select>
  					</td>
  					<td align="right">老师：</td>
  					<td align="left">
  						<select name="teacherId" id="teacherId" class="easyui-combobox" style="width:120px"
							data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname', panelHeight: 'auto'"
		      				url="<%=path %>/pubData/qryTeacherList.do">
						</select>
  					</td>
  					<td align="right">异动开始日期：</td>
  					<td align="left">
  						<input class="easyui-datebox" name="expStartDate" id="expStartDate" style="width:120px;" />
  					</td>
  					<td align="center">至：</td>
  					<td align="left">
  						<input class="easyui-datebox" name="expEndDate" id="expEndDate" style="width:120px;" />
  					</td>
  				</tr>
  				<tr>
  					<td align="right">课程阶段：</td>
  					<td align="left">
  						<select id="stageId" name="stageId" class="easyui-combobox" style="width: 120px;"
							data-options="formatter:formatStageId, valueField: 'stageId', textField: 'stageId', panelHeight: 'auto'" 
	      					url="<%=path %>/pubData/qryStage.do">
	      				</select>
  					</td>
  					<td align="right">异动类型：</td>
  					<td align="left">
     					<select id="expType" name="expType" class="easyui-combobox" style="width:120px;" editable="false"
	  						data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto',
	  						onLoadSuccess:function(data){$('#expType').combobox('setValue',data[0].codeFlag);}"
	      					url="<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_CARE_T&codeType=EXCEPTION_TYPE">
        				</select>
  					</td>
  					<td colspan="6" align="right">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:90px; height: 25px;" id="qryBtn" funcNodeId="4200">查询</a>
						&nbsp;&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:90px; height: 25px;" id="reset" >重置</a>
					</td>
  				</tr>
  			</table>
 		</form>
 		
		<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:540" id="list_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
			<thead>
				<tr>
					<th field="ck" align="center" checkbox="true" width="1%"></th>
					<th field="schoolName" align="center" width="6%">校区</th>
					<th field="name" align="center" width="7%">学员姓名</th>
					<th field="byName" align="center" width="6%">英文名</th>
					<th field="exceptionTypeVal" align="center" width="8%">异动类型</th>
					<th field="stageId" align="center" width="7%">课程阶段</th>
					<th field="payDate" align="center" width="7%">缴费日期</th>
					<th field="dutyAdvister" align="center" width="7%">责任顾问</th>
					<th field="carer" align="center" width="7%">客户关怀</th>
					<th field="teacherName" align="center" width="7%">老师</th>
					<th field="className" align="center" width="7%">当前班级</th>
					<th field="followCount" align="center" width="7%">跟进次数</th>
					<th field="expDate" align="center" width="8%">异动开始时间</th>
					<th field="expedTime" align="center" width="8%">异动时长（天）</th>
					<th field="followEndDate" align="center" width="8%">最后跟进时间</th>
					<th field="remark" align="center" width="10%">最后跟进内容</th>
				</tr>
			</thead>
		</table>
		<div id="toolbar">
   			<a href="javascript:void(0)" id="updateBtn" class="easyui-linkbutton" iconCls="icon-edit" onclick="updateExp()">客户维护</a>
 			<a href="javascript:void(0)" id="viewBtn" class="easyui-linkbutton" iconCls="icon-redo" onclick="viewExpInfo()">浏览</a>
 		</div>
  	</body>
</html>
