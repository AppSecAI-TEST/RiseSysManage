<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/train/trainManage.js"></script>
  	</head>
  	<body>
  		<div style="margin-right:5px">
  		<input type="hidden" id="staffId" name="staffId" value="${sessionScope.StaffT.staffId}"/>
 		<form id="qryFm">
  			<table class="search_tab">
  				<tr>
  					<td align="right" style="min-width: 70px;">组织：</td>
  					<td align="left" style="min-width: 100px;">
  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width:100px;height:25px;" editable="false">
        				</select>
  					</td>
  					<td align="right" style="min-width: 90px;">教师英文名：</td>
  					<td align="left" style="min-width: 100px;">
  						<select name="byName" id="byName" class="easyui-combobox" style="width:100px;height:25px;">
						</select>
  					</td>
  					<td align="right" style="min-width: 70px;"><span>培训时间：</span></td>
  					<td align="left"  style="min-width: 230px;">
  						<input class="easyui-datebox" name="trainstartTime" id="trainstartTime" style="width:100px;height:25px;" />
  						至
  						<input class="easyui-datebox" name="trainendTime" id="trainendTime" style="width:100px;height:25px;" />
  					</td>
  					<td style="min-width: 350px;">&nbsp;</td>
  				</tr>
  				<tr>
  					<td align="right"><span>教师状态：</span></td>
  					<td align="left">
  						<select id="teacherState" name="teacherState" class="easyui-combobox" style="width:100px;height:25px;"
	  						data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'"
	      					url="<%=path %>/pubData/qryCodeNameList.do?tableName=TEACHER_T&codeType=T_STATE">
        				</select>
  					</td>
  					<td align="right"><span>若离职是否赔偿：</span></td>
  					<td colspan="2">
  						<input name="pay" type="checkbox" value="Y" style="margin:0 auto;vertical-align:middle;" /><span>是</span>
  						&nbsp;&nbsp;&nbsp;<input name="pay" type="checkbox" value="N" style="margin:0 auto;vertical-align:middle;" /><span>否</span>
  					<td>
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:100px;" id="qryBtn" funcNodeId="4300"><span>查询</span></a>
						&nbsp;&nbsp;&nbsp;&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:100px;" id="resetBtn" ><span>重置</span></a>
					</td>
					<td style="min-width: 350px;">&nbsp;</td>
  				</tr>
  			</table>
 		</form>
 		
		<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:570" id="list_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
			<thead>
				<tr>
					<th field="ck" align="center" checkbox="true" width="1%"></th>
					<th field="schoolName" align="center" width="10%"><span>组织</span></th>
					<th field="teacherName" align="center" width="8%"><span>教师姓名</span></th>
					<th field="byname" align="center" width="9%"><span>教师英文名</span></th>
					<th field="trainStartDate" align="center" width="8%"><span>开始时间</span></th>
					<th field="trainEndDate" align="center" width="12%"><span>结束时间</span></th>
					<th field="trainAmount" align="center" width="7%"><span>培训费用</span></th>
					<th field="reparation" align="center" width="11%"><span>若现离职赔付金额</span></th>
					<th field="stateVal" align="center" width="11%"><span>教师状态</span></th>
					<th field="remark" align="center" width="23%"><span>培训概述</span></th>
				</tr>
			</thead>
		</table>
		<div id="toolbar" style="padding: 2px;height:auto;">
			<a href="javascript:void(0)" id="toolBtn1" class="easyui-linkbutton" iconCls="icon-add" style="width:100px;" onclick="locateTeacher()"><span>新增培训</span></a>
   			<a href="javascript:void(0)" id="toolBtn2" class="easyui-linkbutton" iconCls="icon-edit" style="width:100px;" onclick="updateTeacherTrain()"><span>修改培训</span></a>
 			<a href="javascript:void(0)" id="toolBtn3" class="easyui-linkbutton" iconCls="icon-redo" style="width:100px;" onclick="viewTeacherTrain()"><span>浏览</span></a>
 		</div>
 		</div>
  	</body>
</html>
