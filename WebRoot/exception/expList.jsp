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
  		<div style="margin-right:5px">
 		<form id="qryFm">
  			<table class="search_tab">
  				<tr>
  					<td width="100px" align="right"><span>所属校区：</span></td>
  					<td width="110px">
  						<select class="easyui-combobox" name="schoolId" id="schoolId" style="width:100px;height:25px;" editable ="false"
  							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto',
  							onLoadSuccess:function(data){if(data.length > 0) $('#schoolId').combobox('setValue',data[0].schoolId);}"
  							url="<%=path%>/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&resourceId=701&fieldId=schoolId&headFlag=N">
  						</select>
  					</td>
  					<td width="100px" align="right"><span>学员姓名：</span></td>
  					<td width="110px">
  						<input class="easyui-textbox"  name="name" id="name" style="width:100px;height:25px;" />
  					</td>
  					<td width="110px" align="right"><span>异常时常(天)：</span></td>
  					<td width="240px">
  						<input class="easyui-numberbox" name="startDay" id="startDay"  style="width:100px;height:25px;" />
  						&nbsp;-&nbsp;
  						<input class="easyui-numberbox" name="endDay" id="endDay"  style="width:100px;height:25px;"/>
  					</td>
  				</tr>
  				<tr>
  					<td align="right"><span>联系电话：</span></td>
  					<td>
  						<input class="easyui-textbox" name="phone" id="phone" style="width:100px;height:25px;" />
  					</td>
  					<td align="right"><span>异常状态：</span></td>
  					<td>
  						<select name="excState" editable='false' class="easyui-combobox" id="excState" name="excState" style="width: 100px;height:25px;" editable="false"
						 data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'"
	      				 url="<%=path %>/pubData/qryCodeNameList.do?tableName=STUDENT_EXC_T&codeType=EXC_STATE">
						</select>
  					</td>
  					<td align="right"><span>异常发生时间：</span></td>
  					<td>
  						<input class="easyui-datebox" name="startTime" id="startTime" style="width:100px;height:25px;" editable="false" />
  						至
  						<input class="easyui-datebox" name="endTime" id="endTime" style="width:100px;height:25px;" editable="false"/>
  					</td>
  					<td>
  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:100px;height:25px;" id="qryBtn" funcNodeId="3001">查询</a>
  						&nbsp;&nbsp;
  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-reload" style="width:100px;height:25px;" id="resetBtn" >重置</a>
  					</td>
  				</tr>
  			</table>
 		</form>
 		
 		<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:400" id="list_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true">
			<thead>
				<tr>
					<th data-options="field:'ck',checkbox:true"></th>
					<th field="name" align="center" width="5%"><span>学员姓名</span></th>
					<th field="byName" align="center" width="5%"><span>英文名</span></th>
					<th field="phone" align="center" width="10%"><span>联系电话</span></th>
					<th field="excState" align="center" width="10%"><span>异常状态</span></th>
					<th field="exceptionDate" align="center" width="8%"><span>异常发生日期</span></th>
					<th field="days" align="center" width="10%"><span>已异常天数</span></th>
					<th field="stageLevel" align="center" width="10%"><span>已升学阶段</span></th>
					<th field="className" align="center" width="10%"><span>原在读班级</span></th>
					<th field="teacherName" align="center" width="10%"><span>带班老师</span></th>
					<th field="orignCourseState" align="center" width="10%"><span>原在读课程状态</span></th>
					<th field="lessonNum" align="center" width="10%"><span>原在读班级课时</span></th>
				</tr>
			</thead>
		</table>
		<div id="toolbar" style="padding: 2px;height:auto;">
   			<a href="javascript:void(0)" id="addExp" class="easyui-linkbutton" iconCls="icon-add" style="width: 100px;">新增异常</a>
   			<a href="javascript:void(0)" id="restoreClass" class="easyui-linkbutton" iconCls="icon-edit" style="width: 100px;">复课</a>
   			<a href="javascript:void(0)" id="viewInfo" class="easyui-linkbutton" iconCls="icon-redo" style="width: 100px;">浏览</a>
 		</div>
 		</div>
  	</body>
</html>
