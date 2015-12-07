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
		<script type="text/javascript" src="<%=path %>/js/train/trainManage.js"></script>
  	</head>
  	<body>
 		<form id="qryFm">
  			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;margin-top:10px;font-family:'微软雅黑'" cellspacing="5">
  				<tr>
  					<td align="right" width="8%">组织：</td>
  					<td align="left" width="10%">
  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width:120px;"
							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'"
				      		url="<%=path %>/pubData/qrySchoolList.do">
        				</select>
  					</td>
  					<td align="right" width="15%">教师英文名：</td>
  					<td align="left" width="10%">
  						<select name="byName" id="byName" class="easyui-combobox" style="width:120px"
							data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname', panelHeight: 'auto'"
		      				url="<%=path %>/pubData/qryTeacherList.do">
						</select>
  					</td>
  					<td align="right" width="10%">培训时间：</td>
  					<td align="left" width="10%">
  						<input class="easyui-datebox" name="trainstartTime" id="trainstartTime" style="width:120px;" />
  					</td>
  					<td align="center" width="3%">至：</td>
  					<td align="left">
  						<input class="easyui-datebox" name="trainendTime" id="trainendTime" style="width:120px;" />
  					</td>
  					<td></td>
  				</tr>
  				<tr>
  					<td align="right">教师状态：</td>
  					<td align="left">
  						<select id="teacherState" name="teacherState" class="easyui-combobox" style="width:120px;"
	  						data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'"
	      					url="<%=path %>/pubData/qryCodeNameList.do?tableName=TEACHER_T&codeType=T_STATE">
        				</select>
  					</td>
  					<td align="right">若离职是否赔偿：</td>
  					<td align="left">
  						<input name="pay" type="checkbox" value="Y" style="margin:0 auto;vertical-align:middle;" /><span>是</span>
  						&nbsp;&nbsp;&nbsp;<input name="pay" type="checkbox" value="N" style="margin:0 auto;vertical-align:middle;" /><span>否</span>
  					<td colspan="4" align="right">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:90px; height: 25px;" id="qryBtn" funcNodeId="4300">查询</a>
						&nbsp;&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:90px; height: 25px;" id="reset" >重置</a>
					</td>
					<td></td>
  				</tr>
  			</table>
 		</form>
 		
		<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:570" id="list_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
			<thead>
				<tr>
					<th field="ck" align="center" checkbox="true" width="1%"></th>
					<th field="schoolName" align="center" width="10%">组织</th>
					<th field="teacherName" align="center" width="8%">教师姓名</th>
					<th field="byname" align="center" width="9%">教师英文名</th>
					<th field="trainStartDate" align="center" width="8%">开始时间</th>
					<th field="trainEndDate" align="center" width="12%">结束时间</th>
					<th field="trainAmount" align="center" width="7%">培训费用</th>
					<th field="reparation" align="center" width="11%">若现离职赔付金额</th>
					<th field="stateVal" align="center" width="11%">教师状态</th>
					<th field="remark" align="center" width="23%">培训概述</th>
				</tr>
			</thead>
		</table>
		<div id="toolbar">
			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" onclick="locateTeacher()">新增培训</a>
   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-edit" onclick="updateTeacherTrain()">修改培训</a>
 			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-redo" onclick="viewTeacherTrain()">浏览</a>
 		</div>
  	</body>
</html>
