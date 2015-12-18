<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
%>

<!doctype html>
<html>
  	<head>
		<%@ include file="../common/head.jsp" %>
		<%@ include file="../common/formvalidator.jsp" %>
		<script type="text/javascript" src="<%=path %>/js/expManage/expList.js"></script>
  	</head>
  	<body>
 		<form id="qryFm">
  			<table align="center" style="min-width:1100px;width:99%;border:1px solid #95B8E7;margin-top:10px;font-family:'微软雅黑'" cellspacing="15">
  				<tr>
  					<td align="right">所属校区：</td>
  					<td>
  						<select class="easyui-combobox" name="schoolId" id="schoolId" style="width:150px;"
  							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto'"
  							url="<%=path%>/pubData/qrySchoolList.do?schoolId=">
  						</select>
  					</td>
  					<td align="right">学员姓名：</td>
  					<td>
  						<input class="easyui-textbox"  name="name" id="name" style="width:150px;" />
  					</td>
  					<td align="right">异常时常(天)：</td>
  					<td>
  						<input class="easyui-textbox" name="startDay" id="startDay"  style="width:150px;" />
  					</td>
  					<td align="center">至：</td>
  					<td>
  						<input class="easyui-textbox" name="endDay" id="endDay"  style="width:150px;" />
  					</td>
  				</tr>
  				<tr>
  					<td align="right">联系电话：</td>
  					<td>
  						<input class="easyui-textbox" name="phone" id="phone" style="width:150px;" />
  					</td>
  					<td align="right">异常状态：</td>
  					<td>
  						<select name="courseType" editable='false' class="easyui-combobox" id="excState" name="excState" style="width: 150px;"
						 data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'"
	      				 url="<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_EXC_T&codeType=EXC_STATE">
						</select>
  					</td>
  					<td align="right">异常发生时间：</td>
  					<td>
  						<input class="easyui-datebox" name="startTime" id="startTime" style="width:150px;" />
  					</td>
  					<td align="center">至：</td>
  					<td>
  						<input class="easyui-datebox" name="endTime" id="endTime" style="width:150px;" />
  					</td>
  				</tr>
  				<tr>
  					<td colspan="5" >&nbsp;</td>
  					<td>	
  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:150px" id="qryBtn" funcNodeId="3001">查询</a>
  					</td>
  					<td>&nbsp;</td>
  					<td>
  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-reload" style="width:150px" id="resetBtn" >重置</a>
  					</td>
  				</tr>
  			</table>
 		</form>
 		
 		<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:300" id="list_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
					<th field="name" align="center" width="5%">学员姓名</th>
					<th field="byName" align="center" width="5%">英文名</th>
					<th field="phone" align="center" width="10%">联系电话</th>
					<th field="excState" align="center" width="10%">异常状态</th>
					<th field="exceptionDate" align="center" width="8%">异常发生日期</th>
					<th field="days" align="center" width="10%">已异常天数</th>
					<th field="stageLevel" align="center" width="10%">已升学阶段</th>
					<th field="className" align="center" width="10%">原在读班级</th>
					<th field="teacherName" align="center" width="10%">带班老师</th>
					<th field="orignCourseState" align="center" width="10%">原在读课程状态</th>
					<th field="lessonNum" align="center" width="10%">原在读班级课时</th>
				</tr>
			</thead>
		</table>
		<div id="toolbar" style="padding: 2px;height:auto;">
   			<a href="javascript:void(0)" id="addExp" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">新增异常</a>
   			<a href="javascript:void(0)" id="restoreClass" class="easyui-linkbutton" iconCls="icon-edit" style="width: 100px;">复课</a>
   			<a href="javascript:void(0)" id="viewInfo" class="easyui-linkbutton" iconCls="icon-redo" style="width: 100px;">浏览</a>
 		</div>
  	</body>
</html>
