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
 		<form id="qryTeaFm">
  			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;margin-top:10px;font-family:'微软雅黑'" cellspacing="5">
  				<tr>
  					<td align="right" width="8%">组织：</td>
  					<td align="left" width="10%">
  						<select id="schoolId" name="schoolId" class="easyui-combobox" style="width:120px;"
							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'"
				      		url="<%=path %>/pubData/qrySchoolList.do">
        				</select>
  					</td>
  					<td align="right" width="10%">教师英文名：</td>
  					<td align="left" width="10%">
  						<select name="byName" id="byName" class="easyui-combobox" style="width:120px"
							data-options="formatter:formatTeacher, valueField: 'teacherId', textField: 'byname', panelHeight: 'auto'"
		      				url="<%=path %>/pubData/qryTeacherList.do">
						</select>
  					</td>
  					<td align="right" width="10%">入职时间：</td>
  					<td align="left" width="10%">
  						<input class="easyui-datebox" name="joinStartDate" id="joinStartDate" style="width:120px;" />
  					</td>
  					<td align="center" width="3%">至：</td>
  					<td align="left" width="10%">
  						<input class="easyui-datebox" name="joinEndDate" id="joinEndDate" style="width:120px;" />
  					</td>
  					<td></td>
  				</tr>
  				<tr>
  					<td align="right">职务：</td>
  					<td align="left">
  						<select id="post" name="post" class="easyui-combobox" style="width:120px;" editable="false"
							data-options="formatter:formatPost, valueField: 'postId', textField: 'postName', panelHeight: 'auto'"
				      		url="<%=path %>/pubData/qryPostList.do?postType=T">
        				</select>
  					</td>
  					<td align="right" width="10%">工作性质：</td>
  					<td align="left" width="15%">
  						<select id="jobProperty" name="jobProperty" class="easyui-combobox" style="width:120px;"
	  						data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'"
	      					url="<%=path %>/pubData/qryCodeNameList.do?tableName=STAFF_T&codeType=JOB_PROPERTY">
        				</select>
  					</td>
  					<td align="right">入职时长：</td>
  					<td align="left">
  						<input class="easyui-numberbox" name="joinStartTime" id="joinStartTime" style="width:120px;" />
  					</td>
  					<td align="center">至：</td>
  					<td align="left">
  						<input class="easyui-numberbox" name="joinEndTime" id="joinEndTime" style="width:120px;" />
  					</td>
  					<td align="center">
						<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-search'" style="width:90px; height: 25px;" id="qryTeaBtn" funcNodeId="4100">查询</a>
						&nbsp;&nbsp;<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-reload'" style="width:90px; height: 25px;" id="reset" >重置</a>
					</td>
  				</tr>
  			</table>
 		</form>
 		
		<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:570" id="teacher_list" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
			<thead>
				<tr>
					<th field="ck" align="center" checkbox="true" width="1%"></th>
					<th field="schoolName" align="center" width="7%">组织</th>
					<th field="teacherName" align="center" width="8%">教师姓名</th>
					<th field="byname" align="center" width="9%">教师英文名</th>
					<th field="stateVal" align="center" width="8%">教师状态</th>
					<th field="phone" align="center" width="9%">联系电话</th>
					<th field="postVal" align="center" width="8%">职务</th>
					<th field="joinDate" align="center" width="10%">入职时间</th>
					<th field="joinTime" align="center" width="10%">入职时长（月）</th>
					<th field="licenses" align="center" width="11%">持证阶段</th>
					<th field="stageIds" align="center" width="19%">在读带班阶段</th>
				</tr>
			</thead>
		</table>
		<div id="toolbar">
   			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-ok" onclick="addTrain()">提交</a>
 			<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-back" onclick="javascript:window.history.back()">返回</a>
 		</div>
  	</body>
</html>
