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
		<script type="text/javascript" src="<%=path %>/js/expManage/selectClass.js"></script>
  	</head>
  	<body>
  		<div>
  		<div style="margin-right:5px">
	 		<form id="qryFm">
	  			<table class="search_tab">
	  				<tr>
	  					<td style="min-width: 70px;" align="right"><span>所属校区：</span></td>
	  					<td style="min-width: 100px;">
	  						<select class="easyui-combobox" name="schoolId" id="schoolId" style="width:100px;height:25px;"
	  							data-options="formatter:formatSchool, valueField: 'schoolId', textField: 'schoolName', panelHeight: 'auto',
	  							onLoadSuccess:function(data){if(data.length > 0) $('#schoolId').combobox('setValue',data[0].schoolId);}"
	  							url="<%=path%>/pub/pageCategory.do?staffId=${sessionScope.StaffT.staffId}&resourceId=701&fieldId=schoolId&headFlag=N">
	  						</select>
	  					</td>
	  					<td style="min-width: 70px;" align="right"><span>学员姓名：</span></td>
	  					<td style="min-width: 100px;">
	  						<input class="easyui-textbox"  name="name" id="name" style="width:100px;height:25px;" />
	  					</td>
	  					<td style="min-width: 70px;" align="right"><span>联系电话：</span></td>
	  					<td style="min-width: 100px;">
	  						<input class="easyui-textbox" name="phone" id="phone" style="width:100px;height:25px;" />
	  					</td>
	  					<td style="min-width: 150px;"></td>
	  				</tr>
	  				<tr>
	  					<td style="min-width: 70px;" align="right"><span>课程状态：</span></td>
	  					<td style="min-width: 100px;">
	  						<select class="easyui-combobox" name="courseState" id="courseState" style="width:100px;height:25px;"
		  						data-options="formatter:formatItem, valueField: 'codeFlag', textField: 'codeName', panelHeight: 'auto'"
		      					url="<%=path %>/pubData/qryCodeNameList.do?tableName=EXC_COURSE&codeType=COURSE_STATE">
	  						</select>
	  					</td>
	  					<td align="right" style="min-width: 70px;"><span>带班老师：</span></td>
	  					<td align="left">
	  						<input class="easyui-textbox"  name="teacher" id="teacher" style="width:100px;height:25px;" />
	  					</td>
	  					<td colspan="2">
	  						&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;			
	  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-search" style="width:100px" id="qryBtn" funcNodeId="3002">查询</a>
	  						&nbsp;&nbsp;	
	  						<a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-reload" style="width:100px" id="resetBtn">重置</a>
	  					</td>
	  					<td style="min-width: 150px;"></td>
	  				</tr>
	  			</table>
	 		</form>
	 		<table class="easyui-datagrid" align="center" title="查询结果" data-options="height:400" id="list_data" toolbar="#toolbar" pagination="true" rownumbers="true" fitColumns="true" singleSelect="true">
				<thead>
					<tr>
						<th field="ck" align="center" checkbox="true" width="1%"></th>
						<th field="name" align="center" width="10%"><span>学员姓名</span></th>
						<th field="byName" align="center" width="10%"><span>英文名</span></th>
						<th field="phone" align="center" width="15%"><span>联系电话</span></th>
						<th field="stageLevel" align="center" width="10%"><span>已升学阶段</span></th>
						<th field="className" align="center" width="10%"><span>在读班级</span></th>
						<th field="courseStateVal" align="center" width="10%"><span>课程状态</span></th>
						<th field="teacherName" align="center" width="11%"><span>带班老师</span></th>
						<th field="carerName" align="center" width="10%"><span>客户关怀</span></th>
						<th field="classProgress" align="center" width="11%"><span>在读班级课时</span></th>
					</tr>
				</thead>
			</table>
			<div id="toolbar" style="padding:2px;height:auto;">
	   			<a href="javascript:void(0)" id="submitBtn" class="easyui-linkbutton" iconCls="icon-ok" style="width:100px">提交</a>
	   			<a href="javascript:void(0)" id="backBtn" class="easyui-linkbutton" iconCls="icon-back" style="width:100px">返回</a>
	 		</div>
 		</div>
  	</body>
</html>
